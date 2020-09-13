Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9772681CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 00:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgIMW5H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Sep 2020 18:57:07 -0400
Received: from mail1.trendhosting.net ([195.8.117.5]:49114 "EHLO
        mail1.trendhosting.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgIMW5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Sep 2020 18:57:05 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Sep 2020 18:57:04 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail1.trendhosting.net (Postfix) with ESMTP id 1E58115109
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Sep 2020 23:49:21 +0100 (BST)
Received: from mail1.trendhosting.net ([127.0.0.1])
        by localhost (thp003.trendhosting.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id aF0MZkA2YhGW for <linux-btrfs@vger.kernel.org>;
        Sun, 13 Sep 2020 23:49:18 +0100 (BST)
Received: from [IPv6:2001:1620:e61:0:6cd2:d1e2:f6ff:8f1c] (unknown [IPv6:2001:1620:e61:0:6cd2:d1e2:f6ff:8f1c])
        by mail1.trendhosting.net (Postfix) with ESMTPSA id DBDB6150FB
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Sep 2020 23:49:18 +0100 (BST)
To:     linux-btrfs@vger.kernel.org
From:   Daniel Pocock <daniel@pocock.pro>
Subject: 64k and 4k page size inter-op?
Autocrypt: addr=daniel@pocock.pro; keydata=
 mQINBE7934cBEADWPV0LP/J2OxvDxO47QtOPmJnQv1Af7GTWp9xXuq/KCjgxrYcECpEQusU+
 DET2X+oQjWiOs4FOQ1cz4atWPaXJG6O98ownXjrrhQ98Tvs0lZQpUQOCbVwgp359QN077L2m
 XznJgAAgD5RYpvvpcsMikX3c+L9MRPQGKKxK9MusAFM9LWVNMBmDn+oixMbGKX2mJyIcrDes
 YAo3tVEwfwV7nVDQjTtmFd9YV0fjPBHW83MrA5473kH+nXvhL5I6l05W7hLpmGsPdEuJ0aLf
 Z8mNiZTU5Y/Qj3j8iymRezocdWsyRzsdFjnJHlluEW3CINl9++v0z9+VDVU26rJ+UebB1RTE
 2qWF2vk0YBUX2jxsNQoynrWQknmf7TZloNkXxvFwRuTmjrMIQI1esCub36krRMAIbLyNleVP
 +stfSGvjR2H1/zKq0A3CqE3ShOAaxeI2PIVv/vOus1MlAy8FqQuLvht+IfaxrnP+sTafHneJ
 b7OVB0zPTPJYnHMaika9Y71CJYfinn7cNgeK3Rhklp6oBq8kT5uKMpnz96FSOkU0SBfGPEuq
 MCZbYXuMFIpUopK3prwfSet+FN/FtUbvYzBx14kGr+J8MrSSdsjmJKvxkOHZ2RzDW8ALgQXS
 zvbmBbyIH6xDI5XK6wnnrDl/xvnbJa+fYWSsEHbQbKJVegEc9wARAQABtCFEYW5pZWwgUG9j
 b2NrIDxkYW5pZWxAcG9jb2NrLnBybz6JAjoEEwEIACQCGwMFCwkIBwMFFQoJCAsFFgIDAQAC
 HgECF4AFAlLpGXwCGQEACgkQbGWA53vXVsSBBBAApC5LfH5b0V6ZfFF5PSC0RhoDOM7n1q2/
 zAQn4G/sFfy5Xxpls30nZLbvtQHh9QPvWd9Rg5lUgW4ak1Z4g2KTZ740QLsaLMrt7phSDpQx
 cEVD3HuvZxuM64f+80RfOMk6MabQtatieHB+iMY3DHSvSdVP8DXzAwM+rNq7+V/bKPGYAgqV
 4ek4/z8S2Poe+61I7uN7FwiszyRKvK2sy1skXq4pYKBifdr67nvPp1x1Mz5NXGPQWTeJ8CR0
 WM+RzwkH/eavXcpFofpPHbedYw8gwsM8wMS1ctKsxT76Z+bcMa5tLm0ux0MmQArXjwm+a/Gf
 dQppY1eWCx6TrjY/TrgXqXK7FrMgvZHVWwpFmDvFyW5EQlzEyvw9GtoE8gWIWoqrvQjUuDWW
 SQh1PXrqwIeqcxGnDtj3ouFygq9Fo9VrELFoDGKJgI6YTJMhRvzovGUmXBcOypgCxggzL5b1
 XOK/msPN3s//8l0zSjGItAl/dI/Ypn5cZtuAY7dYxBDqhEHDCmAqudVHL5ncNtNa8TK++3tf
 uPVGsiLfe0gZaZRk4AAw/E6ZzJgmBU44L5PM2nIaAjI+sLzCV7CZMS100VAf9zpa6BO6MPSV
 RqIdcZNPsqsnhMQ8ryW7KhFAuqPr388uT4ePX6hOsmXekW7rmcTb0kF7vzN9MAJjhctDnpFT
 mgi5Ag0ETv3gKgEQAOO9XQfsOtQkNb8zsPkwi0oQm1dR3F3mNGpgxdl/N62K64iTVwc1ItDm
 ZuHKUi2zYi9wKExPLFt1/1oCZRwJFeZ/RF4VqSq5apLN8Ll/w8l2iTaRVfQq8A0v/Ih9/kq4
 c11+eULhY/kFfypOwxhX20P28FHoX+72oCofJTE7xUs8Bu1fwIHoSqKjDjaP1Yk2t+pBTFx4
 xAagOnFbxka+1wdJ6WivohCmw7pkcRh19Z4/K3J31b8Q5JcB9yrQbXhKOl8eoCKt8S10BGkK
 G/Ah4AfT1iLm7Qs72abKgDNvPlQJjHKeHjt70U4VoEwTyUhdPMoN8aaH6z0xi0NG34Lc0MS0
 hlVwYvBuF5sH1aJNGFh3cGDDAUUhE56RssnCKjihoBpO7Kdu9mdtN3aHmEIVOlW+nxsEw827
 0is4Sv4EtIZPhtGJogcC19tvEx1lemb/PeifDZ2TJP4aq2TfABAM99oq4nofNwinWNblegDg
 3N2kqAREVRqFR4+gPBhfCwV8aSH7Jz8DPqRl0RFxNAs8xMkQ+9JJg15Joqg3fF2v/lT+mWlI
 1hCiQoVN/OtagjuMYAvalfOG70nD4u+g32Q08GvaoutraOH8J7WeD3ngcrVcqAAqUIq6f2hL
 u4f6onzi/EpyRk4G1zoltIAxivoWnwhOGcbfzS4U5Ox7VfhzQQPRABEBAAGJAh8EGAEIAAkF
 Ak794CoCGwwACgkQbGWA53vXVsS9FA/+OndKHuBsKpzCrvvWIfSiUamvO42srSpVMJ0g3YXx
 trtPMs+p7Hva0QbCIIzrQbgHlm3tKwpl5YkVXP0TrAzfnbk0XPxBaADJSHjAveDeVg6l8Rxm
 7vzCHIsNC0Fz/qYrBQj4YTSPLv9+reiHLZqu9M1nklHcyj1t75rP/T/zBrdkwyOT/FGya3j4
 edXwPw26ZzS/mXVvvas77K3hDSBMuI52GhU+3aiKB5p4EQ2oMZ1DOVOeuuPMVsnegkgjwrdT
 hiZNxpbdILvesu/j+jkbpPQdsue2YzEhqkaylBdYKlyMS9yCDwO+amaKsEQV71UwuTN4HS6p
 GU17UILKzi+WUxCepj4XcUt7p2FrNku54UgNUjFtBvXij9L/YKE2Yd3IarR8QD2nKkNSrODs
 CZKYXrrjzpQTwj95NV36+66XBOWz9b282IDzYCNt+NnpnaqvyqwTYIiUhzrzgx0X6uB6A6w3
 duOLiYIXgKF9d+kXFYGW/wNdpD77+nYkLmnC5EYnV122gXMdpMwIg1k+Wtu+SROTf9lv7AY4
 IhvzBBrC+cZaM6ZVBpBXO+XRQV5Q6lQoksx7dA1IMjCr8/nn9w0aoq2KnJsWNOku6mccsf8D
 lUGTxY+9K4hnjnOZsxhN6ie6pmn/GKOg/vSJHLLH+V01UQvWmpchyYXeFkaypQ55F2M=
Message-ID: <01a71119-f662-e559-534b-82a6d9fc79f4@pocock.pro>
Date:   Mon, 14 Sep 2020 00:49:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


I recently ran into trouble moving btrfs volumes between an amd64 host
(4k page size) and powerpc64el (64k page size)

As far as I can tell, the only option to ensure compatibility between
the two hosts is to

a) recompile the powerpc64el kernel for a 4k page size,

b) re-format any volumes created with 64k sectorsize so they have 4k instead

Is there any other reasonable way to proceed?

Are there any downsides to using the 4k page size on powerpc64el?

Regards,

Daniel
