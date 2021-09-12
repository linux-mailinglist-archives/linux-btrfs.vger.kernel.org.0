Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFBD407DAA
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Sep 2021 15:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbhILNgr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Sep 2021 09:36:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:37649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235291AbhILNgq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Sep 2021 09:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631453720;
        bh=jMsWKiyqdkw8eQs41tZ5Avgwxm9Sb3eL+Fwhflf2/vY=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=BF8QDWXkYeoy+RyowkPW/ylhiUproJ987TjXEiHxPa1Ec/Fg9logNtDbmnna1yvtP
         f8Lrf688mfkXjnzqwLuax1qcEUZcb81QkVdTkBI5AhWi97q/IsQ0gwI1F3tWjq8dQ2
         NK6xo/D3kyIb0c985sGSarCt1QFdL2533yeDjWcI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mn2aD-1mobz622JL-00k7kM; Sun, 12
 Sep 2021 15:35:20 +0200
To:     =?UTF-8?Q?Niccol=c3=b2_Belli?= <darkbasic@linuxsystems.it>
Cc:     linux-btrfs@vger.kernel.org
References: <0303d1f618b815714fe62a6eb90f55ca@linuxsystems.it>
 <22ac9237-68dd-5bc3-71e1-6a4a32427852@gmx.com>
 <7163096f475d3c31d7513c22277ad00f@linuxsystems.it>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Unmountable / uncheckable Fedora 34 btrfs: failed to read block
 groups: -5 open_ctree failed
Message-ID: <e71b92f4-43ba-1544-07c7-2dcc1dbf546c@gmx.com>
Date:   Sun, 12 Sep 2021 21:35:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7163096f475d3c31d7513c22277ad00f@linuxsystems.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/5l8vxLsEmq7eQXGoZGgbSYuA5bxPTW/FaJGyHU3AlSbW3wJzpw
 LEVntxqL5Ak9MC+y5tBtqHtHvXPJpl5+lXk27eFhMowa7fe2KP7SuxLcHcdbVy5RKgQZDyD
 UunAz8wg5eePZr+c8Pma4LMgmkC6GLnaFyBIvCm29u5Ht7h6ulbXsfgHjXco4QGqTDiuQbh
 5Y4BWLQgTO+fBDY3GMRMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2jkJnbUgCjM=:8lnOjzwCm9NESAM2CivOhb
 Uana5w6uzvtnxK/6QGt/tatbf6kZ0uV6Hbizn1EA7Ukp1V95zRAD71wJjFeJ4Jej2Jlh8KlaR
 TDxeijsYx4aF9ApBjrF0XqhBRZmfMVjWYsVYgzy60UX/kJB1J9nUWIDGdNZb34j3bLHhsdOEj
 U0MCvsQwRRXmxOle2wX23j2nP9wB/XRygZoGLIdBzQVCu3cSdwOVOQPm6N/D58MKKDQZBIM0U
 /bDO1jFz4lsqkiZn3YNiH4PKaEO6snegqEOiLi5VXmYjJDkRpvGv+ARJHpIYfLXl6Kv/6ZOLe
 1bW/+zCO5TnOWPPYc/n4wqFQrSrlT8x+U2tUQYaJWisdaGVfJFYYEVeEQSkvLod3rQh8HhkZ1
 stjZ/Gpd54mQVCAwRYHED2oof20NNHC6MB6XTUgfFMOX48dsStU36yTohG5Bzd4hTK37w2N0U
 pkkK0w4naQ3UTzFqwhu0hY72NHRyx3Cpn72r3pF5QMNjnNx/dDAgUZuM8fYNYzLBI3Aq0JST4
 sWEvuYyXxLgWlNZ9RK3uuG+uO+y9HTYfrSNyCJ4y9qCpGuekPBzkwSx9i1t/OQYTm8Ul71sj0
 YG+udlRd8jmUhYcLYuRo7hsy/dK5JMZ0p2g0ZP35bKprNtAUwTZOSmrCl8odBVLevVVSBbbpB
 ZRzeL5BErlq3NY3+sUdrbYSmXgpD8o7jEIn08//dUiE2XbrBfOAIyEjW/3AUBcqehgnIHNcVi
 1LiUpu3E1VtMmJWXxuZYdQph0v/reKgQX0EktxbSIfq6XNnZTLmT2qaEvhRn59BYao9WLrNU/
 DFhyFbAdRu4rjrowsdOkgCUGVLtkciXs+3mnk11GeFpIK6bAsJ5gdYOa0RE1gw1hba1V4uWhV
 jyul9B/h56DShYYsdUzas9SgKDkcixyjIPhzfpfvJSyIAjy1BIjSp6fBmW/YHy1mu1VdjxKcj
 Lpm/a6cLCzUhVpMbeRKUeKWiQyw2po8fU/VRab9RMC58i8vVjyIoXDUDFhJyXRXrcIPEtp7j9
 zAC7K3R/WxLjTgHUd4EGPBvu+vTDs0SszaQX0/sGOqQ9ykqCommofstQjLSM5083+fCuDQVHo
 bj7SIAxROoJCyw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/12 =E4=B8=8B=E5=8D=887:41, Niccol=C3=B2 Belli wrote:
> Il 2021-09-12 07:14 Qu Wenruo ha scritto:
>> No, it's already in the upstream, in v5.11.
>>
>> Just a different name, "rescue=3Dibadroots" or "rescue=3Dignorebadroots=
".
>> And it get enhanced to handle the exact case you're hitting, in v5.14.
>>
>>
>> So please try first using "rescue=3Dibadroots" (need to be mounted with
>> RO), then check your fs.
>
> $ sudo mount -o ro,rescue=3Dibadroots /dev/nvme0n1p6 /mnt/
> mount: /mnt: wrong fs type, bad option, bad superblock on
> /dev/nvme0n1p6, missing codepage or helper program, or other error.
>
> $ btrfs --version
> btrfs-progs v5.14
>
> $ uname -a
> Linux localhost-live 5.14.0-60.fc35.x86_64 #1 SMP Mon Aug 30 16:45:32
> UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

My bad, the commit is 2b29726c473b ("btrfs: rescue: allow ibadroots to
skip bad extent tree when reading block group items"), which is only
merged into the incoming v5.15-rc1.
>
> [10496.832659] BTRFS info (device nvme0n1p6): ignoring bad roots
> [10496.832663] BTRFS info (device nvme0n1p6): disk space caching is enab=
led
> [10496.832664] BTRFS info (device nvme0n1p6): has skinny extents
> [10496.845607] BTRFS warning (device nvme0n1p6): checksum verify failed
> on 21348679680 wanted 0xd05bf9be found 0x2874489b level 1
> [10496.845616] BTRFS error (device nvme0n1p6): failed to read block
> groups: -5
> [10496.846085] BTRFS error (device nvme0n1p6): open_ctree failed
>
> Before doing so I restored a previous dd copy of the partition since you
> said that chunk-recover could have been somewhat dangerous.

If you have dd copy, then things can be much easier to handle.

The easiest way to make ibadroots to work in such situation is, to
manually destroy extent tree root manually.

# btrfs ins dump-tree -t root <dev> | \
   grep "(EXTENT_TREE ROOT_ITEM 0)" -A3
	item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439
		generation 21 root_dirid 0 bytenr 1359085568 level 0 refs 1
		lastsnap 0 byte_limit 0 bytes_used 16384 flags 0x0(none)
		uuid 00000000-0000-0000-0000-000000000000

Grab the bytenr ("1359085568" in my example).

Then use the btrfs-map-logical from the following branch of btrfs-progs:
https://github.com/adam900710/btrfs-progs/tree/map_logical_rework

(The current btrfs-map-logical can't handle extent tree well)

$ btrfs-map-logical -l 1359085568 <dev>
mirror 1 logical 1359085568 physical 1367474176 device /dev/test/test
mirror 2 logical 1359085568 physical 1635909632 device /dev/test/test

Then corrupt the first 4 bytes of each copy (in your case, there should
be only one copy) using its physical bytenr"

$ xfs_io -f -c "pwrite 1367474176 4" <dev>

Then rescue=3Dibadroots should work as expected.

Thanks,
Qu
