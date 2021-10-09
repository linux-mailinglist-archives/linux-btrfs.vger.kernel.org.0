Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAD3427A0B
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Oct 2021 14:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhJIMVd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Oct 2021 08:21:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:39617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhJIMVc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 Oct 2021 08:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633781973;
        bh=01ujE0HnCb8pcB+UEd6+t+H+qVKHz5togOZwQzyfdU4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=IfGXvhbj8N679RsFqrBV1NL+HuWTTjUQwkxYY7OZnZKtalBurNsCuNVPr4hRWF9n8
         YEyHtHCVMa4dqGHjx6u5EnCAX2Z1b7LNl+oHF5x1zifZyKICGp+OwRUBreKnK0JZ+0
         V1btmn9T6p38IpuhapRqbdYjpQ28/UTXQWdxAaPM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbRm-1mYgIM3wA2-00HAle; Sat, 09
 Oct 2021 14:19:33 +0200
Message-ID: <08f71656-b775-3fe0-62f7-f04c44501858@gmx.com>
Date:   Sat, 9 Oct 2021 20:19:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: Bug / Suspected regression. Multiple block group profiles
 detected on newly created raid1.
Content-Language: en-US
To:     FireFish5000 <firefish5000@gmail.com>, linux-btrfs@vger.kernel.org
References: <CADNS_H6MvByBaYQ7h94DMVQUU9ZjANN8bz90km_6DZykBh6mxw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CADNS_H6MvByBaYQ7h94DMVQUU9ZjANN8bz90km_6DZykBh6mxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VUaVOytGDRLdFOufGu94Jih4TtKYLoFINi78BfZEMrKfgTcdTqm
 dUUwnSsLXSXpKIuDJy959nm743eAvM94JV368rxhCxjiwsm8wFFlT2ZNUrSutGqVepTGzz7
 yaKLwIiDi2hYBfN7hbr9aHdamCw+3vGxzwpSuSomonuvs4RljEPlt+uw6JXbGHaPIDw2KLH
 WMY/zdi/UwQPqsOAH/HvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bjfBo11aQ6o=:M4OeeIIkSeCat9T94ftPeJ
 iQ14PqQc0pQgjrWG51kx/0nYt8Tj0mcLiLigeGiGgDuZ9BZZ4kGUrVXZcVx/6qb5d2yH0SAAc
 NV+BCqzRxT/emc0lNrH9xT8xtUOJ73Uyo9ke+iitheQoumvI7pr8jlwKNi//jv/LfA7/sepHH
 aeYxY7wG8+DGR3BQePeEavVTsF2eocuZAmNVUxfXr9rtlTr/9NO/X4Iw5zjvnbNphxMfZ26Ur
 9cF0oKAi4IJ012gwc1QoFDQsLeh92/z1maMno6H8Gqi3q/ujmO7lLGp2xLSl+4/8XyugGk+e1
 dRF2aD0sHSb/CH/IvX2u3bvvOyrFpc0kLIhArpjEU0wpypAktpnIM0LQ/nQnlDl9qI/coAIJg
 P+XqZk1UqjX4RxspMZ8LexxrtEz4W2ooScHi9bXtGRPtUpIGG8Uvkq8v9S6hGxbpRi+RTiw+N
 qtybEW7vRC0qLYe06IkqW0VCgOjSggudksBD8/IwA1NCycVdAOTUtO2+bS9DuIuYxDXvX5D2J
 bIrwOhNJo++UFI+XHi+BF26P6cH9FbEg5+sN6301szFS1Vu97CrJZAc3ZAwAwGt/oXivyXW3D
 Zl72uf71Shsv7bzMajuTmB+gkaQ20v/RqN01H1TFUm+rxn8QDD5ZCMGfWaUBbTrx+ZUgkBwmH
 i5y9TS/GDZ7Lz85n4I/2kOgiObgUo0HdKSNjsQgt6+smmNMcP1OcqkPcIPXQCO0+7yVDpUKrZ
 WqL5P36clwQ9rfeBYJVzGX/+ND8ecAV6onfiZ+1fxWACr6VPvgBk4bzRM/ICg+ebYd4C6+MON
 MXhQAiKYGnu9IfymR89PzQUVpxIz+kElk6iqSqS4iHEZu5BLdh/zWussZZfFqOc/g3zV55PVw
 R4OXYBKElnVXnQOUXWVrqZTBQNS6tYueoFfJxroSNfgReSH6HgvxzONcC7JpZoolVpJsgu6m/
 HrrWi4Zomu1EEJvpcygQuuoqDe3h9rtZq8eWd6Uy1ArWoZHUTm925j/9uMszdUUVVhec/HgVe
 SeAhNGI0BvB/tbrxmqb7lQPYmW3g17W5NpRB5zfoeibn+NFgPMXXq3+XtxuYjUh3CpOGHJ/nW
 KwRM/YjoPo94lM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/9 19:44, FireFish5000 wrote:
> After creating a new btrfs raid1 and was surprised to be greeted with
> the warning
>
> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
> WARNING:   Metadata: single, raid1
>
> I asked on the IRC, and darkling directed me to the mailing list
> suspecting this was a regression.
> I am on 5.14.8-gentoo-dist with btrfs-progs v5.14.1
>
> I have attached a script to reproduce this with temporary images/loop de=
vices,
> Along with the full output I received when running the script.
>
> A shortened version of the commands that I ran on my *real drives* and
> the relevant output is also provided below for convenience. P at the
> end of the device path was inserted incase sleepy joe copies it
> thinking its the reproduction script:
>
> # mkfs.btrfs --force -R free-space-tree -L BtrfsRaid1Test -d raid1 -m

This seems to be a recent bug in btrfs-progs which doesn't remove the
temporary chunk.

You can try the latest v5.14.2 to see if it's solved.

If you want to use the fs, just do a btrfs balance with "start
-musage=3D0" should remove that SINGLE metadata chunk.

Thanks,
Qu
> raid1 /dev/sdaP /dev/sdbP; mount /dev/sda /mnt/tmp; btrfs filesystem
> df /mnt/tmp
> btrfs-progs v5.14.1
> ....truncated....
> ....truncated....
> Data, RAID1: total=3D1.00GiB, used=3D0.00B
> System, RAID1: total=3D8.00MiB, used=3D16.00KiB
> Metadata, RAID1: total=3D1.00GiB, used=3D176.00KiB
> Metadata, single: total=3D8.00MiB, used=3D0.00B
> GlobalReserve, single: total=3D3.25MiB, used=3D0.00B
> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
> WARNING:   Metadata: single, raid1
>
