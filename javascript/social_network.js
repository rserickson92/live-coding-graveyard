// This problem wasn't very well explained IMO so am doing my best
// to reconstruct from memory. Don't know how I did, role was filled
// before any feedback was received.

// Define a network mapping out followers for a given user ID.
// e.g. {1: [2, 3], 2: [1], 3: []}
class Network {

    constructor () {
        this.network = {}
    }

    addFollower(userId, followerId) {
        if (!this.network[userId]) {
            this.network[userId] = new Set()
        }

        this.network[userId].add(followerId)
    }

    removeFollower(userId, followerId) {
        const followers = this.network[userId]
        followers?.delete(followerId)
    }

    getFollowers(userId) {
        return this.network[userId] || new Set()
    }

    // my own extension
    getFollowedUsers(followerId) {
        return Object.entries(this.network)
          .filter(([userId, followers]) => followers.has(followerId))
          .map(([userId, followers]) => userId)
    }
}

const network = new Network()
network.addFollower(1, 2)
network.addFollower(1, 3)
network.addFollower(2, 1)
console.log('network.getFollowers(1) => [2, 3]')
console.log(network.getFollowers(1))
console.log('network.getFollowers(2) => [1]')
console.log(network.getFollowers(2))

network.removeFollower(1, 2)
console.log('network.getFollowers(1) => [3]')
console.log(network.getFollowers(1))

network.removeFollower(1, 2)
console.log('network.getFollowers(1) => [3]')
console.log(network.getFollowers(1))

network.removeFollower(3, 42)
console.log('network.getFollowers(3) => []')
console.log(network.getFollowers(3))

network.addFollower(3, 1)
console.log('network.getFollowedUsers(1) => [2, 3]')
console.log(network.getFollowedUsers(1))
console.log('network.getFollowedUsers(3) => [1]')
console.log(network.getFollowedUsers(3))
console.log('network.getFollowedUsers(4) => []')
console.log(network.getFollowedUsers(4))