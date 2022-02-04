Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8094A9223
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 02:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356566AbiBDByZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 20:54:25 -0500
Received: from mout.gmx.net ([212.227.17.22]:51619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234520AbiBDByZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Feb 2022 20:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643939663;
        bh=Zms0/RZgNmlPPypWqq5TTYFmuM5wGuId3BWTYAgzh2Q=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=LGKBT0D+Q/AGgFMsuPUzVoVSiqOb4tk/6kX1BDBHQ3dHbZT6rKYtnJWYkTyivr3Gy
         WzuZt+jFG6sntXf+8djQRoUbyD+MFfa3zzUsqQIP+/ngBQsOsdDGVzvP0Zr/0HDdXL
         fYSrtcIWCAy9c8QZc1rnxdmmbinOxPKLQF0pe8P4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DNt-1nCmSh2Jqv-003a4g; Fri, 04
 Feb 2022 02:54:23 +0100
Message-ID: <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
Date:   Fri, 4 Feb 2022 09:54:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Benjamin Xiao <ben.r.xiao@gmail.com>, linux-btrfs@vger.kernel.org
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
 <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
In-Reply-To: <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:df+/kgd/Q75WrdAKl/pNJ7p3ecg20disrjWzN6R+HpWfUWN2qvR
 RTrd4jfOlosIVh5+Fl11nH86BGttu6im3styBQ/i9qnM0Zm6XHeHhhHN9QE6kMi1RbkxLZO
 IsBMw+ApEjIMmJ3/J7v6eWWZ14yxrg4MSPUgbDQD7czylfLHhnI5hawdzYgPL+4MHWAnytd
 q8qJIp+q4u2CFzp1q+eKg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jPQpg9Tqr2A=:JtCQOmzKON2eFHFZpwovVC
 pAeSj9XSddYcFutrVDdDwxCtwP2HPh3gm2m3MMqUdqb2BnjmQp7OOtothscyf47+1kVhNGFrs
 eG8slVV2R4uL070iI4T2GVHY2y31+7Dnm7rDFT8OxLmRwcpXYRYjlhG0FW62pbHqRnx/+86py
 XAEe3eBBDqXt4o+XBD8moV5tNXwzmUGS5qnPFAhYOscAVcaDVl8WubMdeesOWFv1+t3zR7OJI
 8x/3SkxemwboowjWY8W3lk/Mfz80jLlwdgyPwYVOJAi8ZIZWlDT2Z/tBtOhO7Y7oKoga4WPUX
 4518/b/L+J1NB41uX+C+OdgdFsMT6wmNM121Xl/hPGvd+v+vqZ079obnXGS0EvI/m9ShqRFsX
 x6V0ZecMrsLQb8OLMAzZjms+t9VRpxt9MWUcJlPLFx/h2w/5yB2mgDw7Ek5Mg+woqUWcqZmqJ
 tOMFRAQOPp5yKOMLwBfirJsyTfvLPqn/MHSlFzwoxrMGh2MoxjSn9dXMdjlXKCHAFzYgkwPfc
 dD1vYnkSe4RqyDeoRPtYvYz5hKhN2QC4DIVEckGs56jg5DmCeuYOMxyN9lZNe1GzuCYKJQ8Om
 rxz1QakqvH2RWyYTHlaL3eKKS3OycWRkhhe9u+afLAFoteR6XyIvVnHnyxKRqmj2gn+eZDowD
 baUc+ChcvY9S+5PEiv6bT+FML4t9JeapTfyM2RUdYhZpGN3QK8thmwtZAaxxWachO/a14pXlR
 qmrvZvzj2/jnpkeRhyWWrZD2zWwiFFg2CAm6rveJgRE2jeKfMTv8AzlYQCIZX/jdsBOMDy5O+
 kNj3RwKhREz1HDpFMOOKiZNUmZFb2fE1WgADKe95j1O+MyBK2aPKYfmkyDaZYiqC+LvetNmYh
 JDK4g6RHfW6cc3rqPJikTdUs2effr3YII94CobpH0wwlKMelbQl2l77YuBGYpqJo9ZEXE4SjI
 nCQYM0Gf6FD4B+PpmKEONtUBD/G42ShlstwKjCnIYVnZsLO7oitqMBivoCnZFTvsNHraZEcIc
 5u5sX8C80sOY+BISpUC90ABiiyBaP2eq6nmlRC63SIsLFzUvOc3o57zN/3hk1TOCufv7+c+O1
 GkYke6oGg9/SRU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/4 09:17, Qu Wenruo wrote:
>
>
> On 2022/2/4 04:05, Benjamin Xiao wrote:
>> Hello all,
>>
>> Even after the defrag patches that landed in 5.16.5, I am still seeing
>> lots of cpu usage and disk writes to my SSD when autodefrag is enabled.
>> I kinda expected slightly more IO during writes compared to 5.15, but
>> what I am actually seeing is massive amounts of btrfs-cleaner i/o even
>> when no programs are actively writing to the disk.
>>
>> I can reproduce it quite reliably on my 2TB Btrfs Steam library
>> partition. In my case, I was downloading Strange Brigade, which is a
>> roughly 25GB download and 33.65GB on disk. Somewhere during the
>> download, iostat will start reporting disk writes around 300 MB/s, even
>> though Steam itself reports disk usage of 40-45MB/s. After the download
>> finishes and nothing else is being written to disk, I still see around
>> 90-150MB/s worth of disk writes. Checking in iotop, I can see btrfs
>> cleaner and other btrfs processes writing a lot of data.
>>
>> I left it running for a while to see if it was just some maintenance
>> tasks that Btrfs needed to do, but it just kept going. I tried to
>> reboot, but it actually prevented me from properly rebooting. After
>> systemd timed out, my system finally shutdown.
>>
>> Here are my mount options:
>> rw,relatime,compress-force=3Dzstd:2,ssd,autodefrag,space_cache=3Dv2,sub=
volid=3D5,subvol=3D/
>>
>
> Compression, I guess that's the reason.
>
>  From the very beginning, btrfs defrag doesn't handle compressed extent
> well.
>
> Even if a compressed extent is already at its maximum capacity, btrfs
> will still try to defrag it.
>
> I believe the behavior is masked by other problems in older kernels thus
> not that obvious.
>
> But after rework of defrag in v5.16, this behavior is more exposed.

And if possible, please try this diff on v5.15.x, and see if v5.15 is
really doing less IO than v5.16.x.

The diff will solve a problem in the old code, where autodefrag is
almost not working.

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index cc61813213d8..f6f2468d4883 100644
=2D-- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1524,13 +1524,8 @@ int btrfs_defrag_file(struct inode *inode, struct
file *file,
                         continue;
                 }

-               if (!newer_than) {
-                       cluster =3D (PAGE_ALIGN(defrag_end) >>
-                                  PAGE_SHIFT) - i;
-                       cluster =3D min(cluster, max_cluster);
-               } else {
-                       cluster =3D max_cluster;
-               }
+               cluster =3D (PAGE_ALIGN(defrag_end) >> PAGE_SHIFT) - i;
+               cluster =3D min(cluster, max_cluster);

                 if (i + cluster > ra_index) {
                         ra_index =3D max(i, ra_index);

>
> There are patches to address the compression related problem, but not
> yet merged:
>
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D609387
>
> Mind to test them to see if that's the case?
>
> Thanks,
> Qu
>>
>>
>> I've disabled autodefrag again for now to save my SSD, but just wanted
>> to say that there is still an issue. Have the defrag issues been fully
>> fixed or are there more patches incoming despite what Reddit and
>> Phoronix say? XD
>>
>> Thanks!
>> Ben
>>
>>
