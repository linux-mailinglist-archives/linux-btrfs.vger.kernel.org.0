Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8763C7DB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 06:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbhGNFCG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 01:02:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:35355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhGNFCF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 01:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626238753;
        bh=4+rqcanT4GED+Ag+ugUvDld3kYWzfyl3dU3zXBGy1AE=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=XvBRWvCjrEZRbg8sEsrUoGryJ3vLCT7ngxitm6bMpPtA2DL6FNzoJuVW4gDX631oS
         OWqFGumv8Wv46DBthxWmzYCgiIyDDWupk3m1+7yNhFlum38vskp4nuqcHOKdZL5RZT
         VUYNBndw2OGBTTaRCqBwMoqOE4hlXfhRrXw3ZOcY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M26vL-1m1b2k3pt3-002ZfB; Wed, 14
 Jul 2021 06:59:13 +0200
To:     DanglingPointer <danglingpointerexception@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
Message-ID: <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
Date:   Wed, 14 Jul 2021 12:59:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:31N8UtQ6IN+uoIHqxYPbqUwDL5WO81zJxQ+S5Z3wmfufQeQfirv
 j7GDFi8J5jTujpNLY7SiM0i52Afn7//FgL8dHT1ZU0r1/Q6x8IyIltHnQeyY58tsRgsAKwi
 aw5QRo1h5+rbpuUvlvl0RpmGikmq+NnKj6ghiuNpB9+T0V0XygMyqg/ASrMW4rtdr5Mvqg1
 /mrj82UHB8oL42MKViK9w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IELzJ0TNfsw=:wd3Ds5htQxqvO0gez6+/ie
 zllEqgWzUcPFM9lvD/9vdSWb2+WHHUhPHjwt8YZu+wDbeOr++u/gqy+8t4XKlizs9bPofTWbD
 IviTA/WzHtuP3ZlIaC4zXqpnUW5NW9BFV7MRGusU8QeNmGqyO/V7PyVl6P+pOzpJkgqAaicHZ
 VvuvTSLRV/WA8Hocb3CO3UQdqceO9K0YAopS4j3UX+0mDCTvrhIvPcIg8qPUe90+RFcdLhTS6
 Jh0xRApOLPQfxuiStH9ESsZ/AsD8DyMfEYs7vPkttpaFMNIJ0rmU8JOq0CnC3UZxQZWeNMJ6p
 tJGDEXg5cF2X10QdE+uEL+BggwKIZLiiUwaoGW7EbuDj+vwjoZuTF/2n4+a3x3PZrQtWtEjKT
 gyKhEyETdbojpp3RNONsa2Tsp1B65ccwONbfQbCVV0hezSBA4oilTSfl/0atUqRm7XlzQJHD6
 HTnPqOwBvDfgr63FKEJtP9YeKLUBZj1wn963qYAtMtxSTJtBq5K+dy0Jsu6FaNdOk34eQKm27
 Jc/ilqT4eiFqa/l8J5JykhuKqMIN47bA3Q2hKvrLSXyKY3LZwLqaBHJ04f75IXXjTyEUtPowb
 mLD+OUNOgbV8gcEmmuYu6BCJYav1cTuXL2ZjDJ95EQepNAn3AkaO4S7hT63yCgfqdcrAYyDjg
 nsxZ2uqBuSVHlE4AsimbannXqrfunq7rpdxsp0wEP0LcFdArdP63xuoHWhKS/xhOqdDQEc6rh
 Kqejw3Y/+IHxjLb+lomeAkjUigCbtHwamNJjPKiLflP7ZcYkKjg+zvZI2gUGgbjfKGMSZNUNG
 zXdDSlnL3IC2Iai4z9qeDHAcj2D3SQFfgek4lo5T3Hcw3YDnm3lFxyc0jA/vyOhRZM30uMxz0
 s1uK4s1KN6+TDhqoKDLsnpLopaDy17ZLDbTVfHket+Y26wmnPvlEqIsdhBraABGOxUpkE+y7D
 8PW7nU0gUvzajpPPA2E28LfZ3K/HvWtjVz8LiddUfncND1KDRhsjIrlX3PvWJXSSK1VBD/Buz
 din1rtQqt+Unk5xtc9nvp6WRcllcoUFuBWZU8f9sI4aQcfH3MvoV/ocsDjVmYqQ9I16tJ7NYH
 U6uCllE8uthXHDtEKE9sYewDQGKCnW+NToP5C0TCLkIxOS0h/UbI5xxZw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/13 =E4=B8=8B=E5=8D=8811:38, DanglingPointer wrote:
> We're currently considering switching to "space_cache=3Dv2" with noatime
> mount options for my lab server-workstations running RAID5.

Btrfs RAID5 is unsafe due to its write-hole problem.

>
>  =C2=A0* One has 13TB of data/metadata in a bunch of 6TB and 2TB disks
>  =C2=A0=C2=A0 totalling 26TB.
>  =C2=A0* Another has about 12TB data/metadata in uniformly sized 6TB dis=
ks
>  =C2=A0=C2=A0 totalling 24TB.
>  =C2=A0* Both of the arrays are on individually luks encrypted disks wit=
h
>  =C2=A0=C2=A0 btrfs on top of the luks.
>  =C2=A0* Both have "defaults,autodefrag" turned on in fstab.
>
> We're starting to see large pauses during constant backups of millions
> of chunk files (using duplicacy backup) in the 24TB array.
>
> Pauses sometimes take up to 20+ seconds in frequencies after every
> ~30secs of the end of the last pause.=C2=A0 "btrfs-transacti" process
> consistently shows up as the blocking process/thread locking up
> filesystem IO.=C2=A0 IO gets into the RAID5 array via nfsd. There are no=
 disk
> or btrfs errors recorded.=C2=A0 scrub last finished yesterday successful=
ly.

Please provide the "echo l > /proc/sysrq-trigger" output when such pause
happens.

If you're using qgroup (may be enabled by things like snapper), it may
be the cause, as qgroup does its accounting when committing transaction.

If one transaction is super large, it can cause such problem.

You can test if qgroup is enabled by:

# btrfs qgroup show -prce <mnt>

>
> After doing some research around the internet, we've come to the
> consideration above as described.=C2=A0 Unfortunately the official
> documentation isn't clear on the following.
>
> Official documentation URL -
> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
>
> 1. How to migrate from default space_cache=3Dv1 to space_cache=3Dv2? It
>  =C2=A0=C2=A0 talks about the reverse, from v2 to v1!

Just mount with "space_cache=3Dv2".

> 2. If we use space_cache=3Dv2, is it indeed still the case that the
>  =C2=A0=C2=A0 "btrfs" command will NOT work with the filesystem?

Why would you think "btrfs" won't work on a btrfs?

Thanks,
Qu

>=C2=A0 So will our
>  =C2=A0=C2=A0 "btrfs scrub start /mount/point/..." cron jobs FAIL?=C2=A0=
 I'm guessing
>  =C2=A0=C2=A0 the btrfs command comes from btrfs-progs which is currentl=
y v5.4.1-2
>  =C2=A0=C2=A0 amd64, is that correct?
> 3. Any other ideas on how we can get rid of those annoying pauses with
>  =C2=A0=C2=A0 large backups into the array?
>
> Thanks in advance!
>
> DP
>
