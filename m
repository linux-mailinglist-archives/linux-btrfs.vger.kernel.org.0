Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0BF7B8347
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbjJDPNr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 11:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbjJDPNq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 11:13:46 -0400
Received: from mail.sweevo.net (unknown [185.193.158.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F42C6
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 08:13:41 -0700 (PDT)
Received: from authenticated-user (mail.sweevo.net [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
        (No client certificate requested)
        by mail.sweevo.net (Postfix) with ESMTPSA id C93372B4A638
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 15:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sweevo.net; s=mail;
        t=1696432418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRaJ7L9mbrJW9PIeCFRoYkQJC7db4qLluVz1dQC1PAI=;
        b=C0U6OLT5wnlU/mqif6GeqlxM4OJ2d5zrhCl2RgPKKKoANwwYpaJCm0urTB5mHg8jEvqmqk
        ZRxCb8+hLRVGJ1E381/9ppAQjTJzWXfL/XEmUCIo4lEWk9cHCHHOMMrTi4otDdb/VV5zAV
        2aCNlJotukDMdA5bA/ejOgowuxZ0+Ak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=sweevo.net;
        s=mail; t=1696432418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRaJ7L9mbrJW9PIeCFRoYkQJC7db4qLluVz1dQC1PAI=;
        b=S6GWDALYaPa9oNbWGg/DkLOlNQjDFMDeK4xWXTwjiBAt5JV0T5yUG4xdk3yGHjG/BnsMd9
        5t3Tc1abo5cJO5GJ01ecDOzmW+AaooFCg0nwSSv0LvmXxkw5jdYrDar+/V6L1lD1Kv/jKw
        9P1OWSF3x7IQ3v3OLxkezfdYalFby7c=
ARC-Authentication-Results: i=1;
        mail.sweevo.net;
        auth=pass smtp.mailfrom=alexander.duscheleit@sweevo.net
ARC-Seal: i=1; s=mail; d=sweevo.net; t=1696432418; a=rsa-sha256; cv=none;
        b=ZCRmW4LqYMaPiSVGregX0u3cY5BDQoHcNWDe/xDUJprLgqARlTFQ5fgtTaF2ca3yP1Hkrt
        DFPEMPjffI/NYfDjGeVABQ/H/F1yXk15O/DQv3SCwqv33udl0XYLcfkXLY3dh5Xr6OR/NB
        ySwHkgCB2UjafnYOsXmknTBoZbhmozM=
MIME-Version: 1.0
Date:   Wed, 04 Oct 2023 15:13:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Alexander Duscheleit" <alexander.duscheleit@sweevo.net>
Message-ID: <6e4a1efe5507f83de07293e61ccb9db5aebcf4b3@sweevo.net>
TLS-Required: No
Subject: Re: Filesystem corruption after convert-to-block-group-tree
To:     linux-btrfs@vger.kernel.org
In-Reply-To: <6c80ca77-1db7-4feb-8349-7ccd8e96819b@gmx.com>
References: <6c80ca77-1db7-4feb-8349-7ccd8e96819b@gmx.com>
 <3b73ff33-34f9-4a98-a73b-19d91f845343@gmx.com>
 <49144585162c9dc5a403c442154ecf54f5446aca@sweevo.net>
 <418ca57f8e70d044bfc8f0822557d91f4aa7dc07@sweevo.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

4 October 2023 at 10:18, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote:



>=20
>=20On 2023/10/4 18:12, Alexander Duscheleit wrote:
>=20
>=20>=20
>=20> 4 October 2023 at 05:27, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote=
:
> >=20
>=20> >=20
>=20> > On 2023/10/4 09:47, Alexander Duscheleit wrote:
> > >=20
>=20>=20
>=20>  Hi all,
> >  earlier today I tried to convert my BTRFS filesystem to block-group-=
tree and the operation seemed successful at first glance.
> >  (I unmounted, converted and mounted the fs without any error.)
> >  Some time later I tried to access a file and got an I/O error.
> >=20
>=20> >=20
>=20> > The error from the dmesg shows a level mismatch in block group tr=
ee.
> > >=20
>=20> >  However the block group tree itself is always fully read at each=
 mount,
> > >  thus it means at your first mount, the block group tree is good, o=
r you
> > >  can not even mount the fs (unless go with -o rescue=3Dall).
> > >=20
>=20> >  So I'm afraid the corruption is not caused by the conversion, bu=
t
> > >  something else, after your initial mount.
> > >=20
>=20> >  I'm more interested in what happened between the initial mount a=
nd "some
> > >  time later".
> > >=20
>=20>=20
>=20>  As far as I can tell, nothing. The array contains mostly media fil=
es, but
> >  also some minor backups (borg-backup). I didn't put any new media on=
 it
> >  during the time in question and no backups were running.
> >=20
>=20>  After the conversion I mounted the fs, restartet nfs, re-mounted t=
he nfs
> >  share on the htpc and then left it alone. I didn't do any operations=
 on it
> >  besides a ls to confirm it's "there".
> >  I noticed the error when I wanted to play some media file and the pl=
ayer threw
> >  an error. >
> >=20
>=20> >=20
>=20> >=20
>=20> >=20
>=20>=20
>=20>  after some updates, reboots and troubleshooting I ended up in the =
following situation:
> >=20
>=20>  The fs cannot be mounted normally, but it mounts (consistently) wi=
th
> >  -o rescue=3Dall,ro (see attached dmesg.log).
> >=20
>=20>  No data _appears_ to be missing or corrupt.
> >=20
>=20>  btrfs-find-root throws many errors concerning corrupt leaf blocks =
but does find the curren tree root. (Again, see attached log.)
> >=20
>=20>  Is there any way to bring this fs back to a useable state without =
starting over from scratch?
> >=20
>=20> >=20
>=20> > It looks like block group tree is corrupted, but without a full "=
btrfs
> > >  check --read-only" it's hard to say.
> > >=20
>=20>=20
>=20>  # btrfs check --readonly /dev/sdb1
> >  Opening filesystem to check...
> >  parent transid verify failed on 7868411314176 wanted 41293 found 413=
70
> >  parent transid verify failed on 7868411314176 wanted 41293 found 413=
70
> >  parent transid verify failed on 7868411314176 wanted 41293 found 413=
70
> >  parent transid verify failed on 7868411314176 wanted 41293 found 413=
70
> >  parent transid verify failed on 7868411314176 wanted 41293 found 413=
70
> >  Ignoring transid failure
> >  ERROR: child eb corrupted: parent bytenr=3D7868939862016 item=3D336 =
parent level=3D1 child bytenr=3D7868411314176 child level=3D1
> >=20
>=20
> OK, this mean is way worse than I initially thought.
>=20
>=20With your dump tree (the only working one), this means one extent tre=
e
> block has written into the location owned by block group tree.
>=20
>=20This breaks the very basis of btrfs metadata COW, thus a huge break t=
o
> the fs.
>=20
>=20Unfortunately btrfs progs is not clever enough to ignore the block
> groups tree corruption and continue, thus no further corruption analyze
> from btrfs check.

If you think of any info that might be useful I'm happy to provide it.

>=20
>=20 From this stage, it's really hard to pin down the cause.
> I can only recommend to salvage data first using "-o rescue=3Dall,ro" f=
or now.
>=20

Most=20data is backed up anyway. Exapnding the array was already underway=
, I'll=20
just=20start over from scratch with the new disks instead.

My main concern right now is how I can prevent something similar from hap=
pening
in the future, since I don't understand how it could have happened in the=
 first
place.

Thanks,
Alex

> Thanks,
> Qu
>=20
>=20>=20
>=20> ERROR: failed to read block groups: Input/output error
> >  ERROR: cannot open file system
> >=20
>=20> >=20
>=20> > Extra dump on the bg tree can also help (needs both stderr and st=
dout):
> > >=20
>=20> >  # btrfs ins dump-tree -t 11 <device>
> > >=20
>=20>=20
>=20>  yields "ERROR: cannot print block group tree, invalid pointer" for=
 each of the 4 devices.
> >=20
>=20> >=20
>=20> > # btrfs ins dump-tree -b 7868411314176 <device>
> > >=20
>=20>=20
>=20>  Attached
> >=20
>=20> >=20
>=20> > BTW, btrfs-find-root is not that useful, thus it should only be a=
dviced
> > >  by developers, but at least it does no harm.
> > >=20
>=20> >  Thanks,
> > >  Qu
> > >=20
>=20>=20
>=20>  System Data:
> >  # uname -a
> >  Linux hera 6.5.5-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 23 Sep 2023 22:=
55:13 +0000 x86_64 GNU/Linux
> >=20
>=20>  # btrfs --version
> >  btrfs-progs v6.5.1
> >=20
>=20>  (Note: The conversion to block group tree was done with btrfs-prog=
s 6.3.3 and Kernel 6.4.12.arch1-1)
> >=20
>=20>  # btrfs fi show
> >  Label: 'hera-storage' uuid: a71011f9-d79c-40e8-85fb-60b6f2af0637
> >  Total devices 4 FS bytes used 8.36TiB
> >  devid 1 size 4.55TiB used 4.19TiB path /dev/sdb1
> >  devid 2 size 4.55TiB used 4.19TiB path /dev/sdd1
> >  devid 3 size 4.55TiB used 4.19TiB path /dev/sdc1
> >  devid 4 size 4.55TiB used 4.19TiB path /dev/sde1
> >=20
>=20>  # btrfs fi df /mnt/btrfs_storage
> >  Data, RAID10: total=3D8.34TiB, used=3D8.34TiB
> >  System, RAID1C4: total=3D8.00MiB, used=3D912.00KiB
> >  Metadata, RAID1C4: total=3D24.00GiB, used=3D23.93GiB
> >  GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> >=20
>=20> >=20
>=20> >=20
>=20> >=20
>=20>=20
>=20>  Thanks,
> >  Alex
> >
>
