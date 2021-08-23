Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63BB3F5397
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 01:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhHWXVD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 19:21:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:36511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233093AbhHWXVB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 19:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629760814;
        bh=BddUW0tlBSSi2efSwZC+tl4dKmzgRlI38PVDMJ5VQXg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IX5d16HhQCnOQpyWBegKCnetQ5O2MRnMF9lLtMmcsrc3C7RWeKBIQd93IjGpaYfF5
         yhtVyRxepXASeUYL4NxZ0uvQ+B2McKyuiQJcY21rGjPCskXvukO+Sn+FyuUSpIZ8Wl
         1K/EuzeX3GRep+Yj1VL2m2HWbzDq3j1V4pNOPcGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7QxB-1n6FzE13Sn-017oiY; Tue, 24
 Aug 2021 01:20:14 +0200
Subject: Re: [PATCH v6 0/4] btrfs-progs: image: new data dump feature
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210812054815.192405-1-wqu@suse.com>
 <20210823171958.GK5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <cd4b123a-604c-24ab-cf8a-f97ad5486c13@gmx.com>
Date:   Tue, 24 Aug 2021 07:20:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823171958.GK5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n5xMl1Ns2UEpDYkceyhkWchO90PzKw8v2G4XCgFLZJZXtHiaX76
 gLUyoVMx9nkCq4RI0pdkiK6Z49QZotWwPrjkYGStVEy+3Tk4AsAOdKKqEMfX/485KAQN04M
 HxH32NJyo9mUq6vinnYLR6fqWhgIkZ8eMcbAIvBohXuWpiNLDlVGUcK0zVqv9pT3seXFDzJ
 SB8OUu7CMuz/AVfbwOwgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U9F5vH2TwsA=:kgfMf0ej3Zn4SwOl4P3add
 I7CxgQTaL5kL72kbxJ+UrujzYNzSZ18+Rkmt5zQyWmbFmedYkz3t0ZUB9IThwkMpa1DdvJciW
 mU6nSK/NecHooKZXvMMh28isyzm4Vf+//o8e5NcqpMzOFDWS+CctW8aDNkMAd9fENcGWxTQAj
 BJUrIW7Cm34QT0qWaiQaj10Xd1UgHQ9XidwewD1DdB1DV61yzokqpKclSjgDbLzd7FS9B8LJD
 QfvhFCmyXXaPVxL49dDeWOq5zCx+vCIlILPWQSHXIcHZw6HKlO+rMC7siKkSl+MlGIniiBXvw
 n4aDaht8LeHVQcFuAKvGIkY+06XFqcu3kcMce/l1WWlAgpmr+bUEmkfo1pljt7whGkHydAd1m
 wxrWfts3vcv2CRCaWWu7pnvrzU4f4+MzcYlOWD5DnTdL5PhfQlPvmcW11SxXiuq+uLa2YmruB
 Vly1Tq7tjol6OovLXDmXm0fM7vNURcZ81cAYTgH8r7WV7gJmsJopyJE0LKKbAFvSZX4250I5G
 gQPyvvvbijUVchO1eZSTcoyffXbshopll8jTMmdm7oP7jnBNqQcEBxh9sPdBjByGpLAlZ7xTa
 TSbdpRdP1/x/yWI1OCMTO6viZCktvGHzvb+qaTA0MiMsDXdvuwwLyoWmI1X68yCt6ZsOf9fMF
 G9Hf8KVqq7uTPYnWRtiRyE4SDj6oG8VjhzRfKHbwPaSTeCqidOWVLtKVVDsswqSAC5rHhxytm
 BPTPjB6MAWASU8xvTQN9LgLwpZDO8yfcBlf/S+8LH2shk5QVj1jSuIYn8LeIC5z/GFwbUgxmN
 PsZVwceVdRhkkzTkKhAdkLy8RC/YhuG1xguqSrRB3CvYvtHoOBX0Q4cojV2pmgsQZmjlpqtb0
 VwOF6lmTyAKe9GTH7j/LHiS3pNuQituRPb5HqLvkjwiLay+ql+LW9/Zlzemsx3iD/GQ6dW+dY
 K/m7spGe42ReZxOqgNspDMvh9v3ZlPf1RBTCZVlLCANucQrpbYuNyjIkJ7aYgAYq0LKNzQbC7
 MPZFfWJ1LWmh1HOSjh0KlED1IviLsdR0zOnQA+9syM5g21fh+oq4ZK+noOZzrfUD2ZeVXxLRQ
 bc4a+frh3yVAUM25wdsEOWNDvzRPjAqt80GqlhpEPhSAb3R4zSypdaVdA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/24 =E4=B8=8A=E5=8D=881:19, David Sterba wrote:
> On Thu, Aug 12, 2021 at 01:48:11PM +0800, Qu Wenruo wrote:
>> This patchset includes the following features:
>>
>> - Introduce data dump feature to dump the whole fs.
>>    This will introduce a new magic number to prevent old btrfs-image to
>>    hit failure as the item size limit is enlarged.
>>    Patch 1 and 2.
>>
>> - Reduce memory usage for compressed data dump restore
>>    This is mostly due to the fact that we have much larger
>>    max_pending_size introduced by data dump(256K -> 256M).
>>    Using 4 * max_pending_size for each decompress thread as buffer is w=
ay
>>    too expensive now.
>>    Use proper inflate() to replace uncompress() calls.
>>    Patch 3
>>
>> - A fix for small dev extent size mismatch with superblock
>>    This no longer affects single device dump restore, thus it's only
>>    for multi-device dump restore.
>>    Patch 4
>
> I'll merge this patchset and try it with the new experimental build (now
> in devel). Which means that the feature would have to be explicitly
> enabled with configure --enable-experimental. This is to get us some
> time to work on it and not be blocked nor block a release of progs.
>
> To mark it as experimental the key bits enabling the interface need to
> be behind if (EXPERIMENTAL) or under #if EXPERIMENTAL, but that should
> be it. Please update the patchset accordingly. This is the first attempt
> to do that so we may need to tweak something but I'd like to establish
> this kind of patch flow for the future and your patchset looks like a
> good testing ground. Thanks for volunteering.
>

The experimental feature looks like a perfect place for us to play around.

No need to bother back compatibility (for a while at least), and can
still get some good feedback (though not from most end users).

Let me update the patchset to be the first test bed.

Thanks,
Qu
