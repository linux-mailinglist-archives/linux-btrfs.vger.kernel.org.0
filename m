Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21A83FF282
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 19:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346979AbhIBRkq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 13:40:46 -0400
Received: from mail.mailmag.net ([5.135.159.181]:58450 "EHLO mail.mailmag.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346968AbhIBRkq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 13:40:46 -0400
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Sep 2021 13:40:45 EDT
Received: from authenticated-user (mail.mailmag.net [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mailmag.net (Postfix) with ESMTPSA id 81EA3EC6821;
        Thu,  2 Sep 2021 09:34:07 -0800 (AKDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=mail;
        t=1630604047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2Bb+LoC4rSzBi0qSMqsLFqyiOjZEf5vNd2K2zfBp3c=;
        b=MY/9BintACHId3SaXj0t5OkAjqf7pb+6Yx10Vbr6TkipLu1GTg/SSgf1APoKhRSKqQtf7G
        6oku+XlzHv5DYCUoc3CMa5sT1BS6Hb2DP4ANlqe5MCTLelTWJ8Qt3dwhbFpGhONyMmQio3
        PkiPfMLGxjxPHF/adGiXCs13x65dDkA=
MIME-Version: 1.0
Date:   Thu, 02 Sep 2021 17:34:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Joshua" <joshua@mailmag.net>
Message-ID: <620f54774033ffc75b1ab2a1d0ebabfd@mailmag.net>
Subject: Re: btrfs mount takes too long time
To:     "=?utf-8?B?RMSBdmlzIE1vc8SBbnM=?=" <davispuh@gmail.com>,
        "Anand Jain" <anand.jain@oracle.com>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Cc:     "Jingyun He" <jingyun.ho@gmail.com>,
        "Johannes Thumshirn" <Johannes.Thumshirn@wdc.com>,
        "David Sterba" <dsterba@suse.cz>
In-Reply-To: <CAOE4rSzkodTb0DFOS4C1tDU-7PVie9v5Sa=yTHHKS5YWQXnKMQ@mail.gmail.com>
References: <CAOE4rSzkodTb0DFOS4C1tDU-7PVie9v5Sa=yTHHKS5YWQXnKMQ@mail.gmail.com>
 <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com>
 <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
 <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com>
 <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
 <c2d2a244-f77c-e0a4-d266-db011fc4154b@oracle.com>
 <CAOE4rSx5+9jXEE2ra5qYOiZWpVU=EcB1MadEf_35fa0M3MZyiw@mail.gmail.com>
 <a0990c37-0b94-53e7-051e-ee7667c4bc94@oracle.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net;
        s=mail; t=1630604047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2Bb+LoC4rSzBi0qSMqsLFqyiOjZEf5vNd2K2zfBp3c=;
        b=K98/P9kuUcLYl+qFkw4JxkwH99EJVS92/SQEOZPNuP3wjRsn410bZWMibZueMvl3b9MBxQ
        kta345276cEk+UiFUyL/He0xpxSY+E3Y1HMd8RVs718TE3OvjMdT9eGW5nraNPOcLj0Yfe
        UezztHhaECwxJRDbo+6X3wLenKSOVj8=
ARC-Seal: i=1; s=mail; d=mailmag.net; t=1630604047; a=rsa-sha256; cv=none;
        b=IKr391NRIeyL/18+ARQu5Bk8RbBns/R17rXMxn6EtcecEObRKnBd0qYCnxT4Fux2zuUM4X
        wP3vzGWtClcNhelubpk3f6RIAX5craoVoq8o/2S3QxJeQFDmBqL8E3COh9SR263lYRUeS1
        h839ifwJr+t9yZk4lpu3FsPbW8gGP/0=
ARC-Authentication-Results: i=1;
        mail.mailmag.net;
        auth=pass smtp.mailfrom=joshua@mailmag.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

September 2, 2021 9:56 AM, "D=C4=81vis Mos=C4=81ns" <davispuh@gmail.com> =
wrote:

> ceturtd., 2021. g. 2. sept., plkst. 00:31 =E2=80=94 lietot=C4=81js Anan=
d Jain
> (<anand.jain@oracle.com>) rakst=C4=ABja:
>=20
>>=20On 02/09/2021 00:11, D=C4=81vis Mos=C4=81ns wrote:
>> pirmd., 2021. g. 30. aug., plkst. 16:08 =E2=80=94 lietot=C4=81js Anand=
 Jain
>> (<anand.jain@oracle.com>) rakst=C4=ABja:
>>=20
>>=20open_ctree() took 228254398 us. And 98% of it that is 225418272 us
>> was taken by btrfs_read_block_groups().
>>=20
>>=20-------------------
>> 1) $ 225418272 us | } /* btrfs_read_block_groups [btrfs] */
>> 1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();
>> 0) 0.967 us | btrfs_apply_pending_changes [btrfs]();
>> 0) 0.239 us | btrfs_read_qgroup_config [btrfs]();
>> 0) * 21017.34 us | btrfs_get_root_ref [btrfs]();
>> 0) + 15.717 us | btrfs_start_pre_rw_mount [btrfs]();
>> 0) 0.865 us | btrfs_discard_resume [btrfs]();
>> 0) $ 228254398 us | } /* open_ctree [btrfs] */
>> -------------------
>>=20
>>=20Now we need to run the same thing on btrfs_read_block_groups(),
>> could you please run.. [1] (no need of the time).
>>=20
>>=20[1]
>> $ umount /btrfs;
>> $./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount
>> /dev/vg/scratch0 /btrfs"
>>=20
>>=20Thanks, Anand
>>=20
>>=20Hi,
>>=20
>>=20I also have a btrfs filesystem that takes a while to mount.
>> So I'm interested if this could be improved.
>>=20
>>=20$ ./ftracegraph open_ctree 2 "*:mod:btrfs" "time mount /dev/md127 -o
>> space_cache=3Dv2,compress=3Dzstd,acl,subvol=3DData /mnt/Data/"
>>=20
>>=20It is better if we don't use the time prefix for the mount command
>> here. The ftrace, traces time syscall as well, which is unessential.
>> And we lose a lot of trace-buffer to it.
>>=20
>>=20kernel.ftrace_enabled =3D 1
>>=20
>>=20real 1m33,638s
>> user 0m0,000s
>> sys 0m1,130s
>>=20
>>=20Here's the trace output https://d=C4=81vis.lv/files/ftracegraph.out.=
gz
>>=20
>>=20The filesystem is on top of RAID6 mdadm array which is from 9x 3TB H=
DDs.
>>=20
>>=20So here is a case of a non-zoned device.
>>=20
>>=20Again it is btrfs_read_block_groups() which is taking ~98% of the ti=
me.
>>=20
>>=203) $ 91607669 us | } /* btrfs_read_block_groups [btrfs] */
>> 3) # 9399.566 us | btrfs_check_rw_degradable [btrfs]();
>> 3) 0.922 us | btrfs_apply_pending_changes [btrfs]();
>> 3) ! 186.540 us | btrfs_read_qgroup_config [btrfs]();
>> 3) * 26109.92 us | btrfs_get_root_ref [btrfs]();
>> 3) + 23.965 us | btrfs_start_pre_rw_mount [btrfs]();
>> 3) 1.192 us | btrfs_discard_resume [btrfs]();
>> 3) $ 93501136 us | } /* open_ctree [btrfs] */
>>=20
>>=20Could we pls get this?
>>=20
>>=20$ ./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount ..."
>>=20
>>=20Hopefully, there won't be a trace-buffer rollover here, as we saw in
>> the other case so that we could account for all the time spent.
>=20
>=20Sure, here https://d=C4=81vis.lv/files/ftracegraph_v2.out.gz
>=20
>>=20Also, let's understand how many block groups are there.
>>=20
>>=20$ btrfs in dump-tree <dev> | grep BLOCK_GROUP_ITEM | wc -l
>=20
>=20It's 22660
> Also by the way `-t EXTENT_TREE` should be faster

Just to add more data, I have a 10-device raid1 array with ~86TB used.

My results:
root@SERVER:~# btrfs in dump-tree -t EXTENT_TREE /dev/sdf | grep BLOCK_GR=
OUP_ITEM | wc -l
44986

I estimate it takes ~83 seconds to mount. (by looking at dmesg) It someti=
mes times out on boot and drops to recovery mode, as systemd will only wa=
it 90 seconds, and for some reason 'x-systemd.mount-timeout=3D500' doesn'=
t work

Note that I defragment the subvolume and extent tree for each subvolume w=
eekly, as it seems to reduce my mount times, and make it *usually* boot w=
ithout dropping to recovery mode.

--Joshua
