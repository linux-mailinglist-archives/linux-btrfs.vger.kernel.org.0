Return-Path: <linux-btrfs+bounces-1285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8594C826337
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 08:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 130F0B219C7
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA6E12B69;
	Sun,  7 Jan 2024 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUUtsFmW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA112B61
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Jan 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42786ec994bso9535581cf.1
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Jan 2024 23:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704611207; x=1705216007; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m/Z2wBP6ADRqY6ScDPArQ8rum45VRYocNQ0uRCYXNHw=;
        b=EUUtsFmWTtHB2HTkzz+82IhJNrdVkVHoVx0q3Ne0Bsz+xBlSg/3XKmI7QdRfmcYUP2
         m9jA8cBLW36ZyVi+FPDIoyo1yxMBk4Zkm8p22sdfqM/WhBxXlHfXJR4S2E9HahHDoaIM
         D7WhKk6ToC9yfZvrNHpW+XvRA89V6lbEv71Sm5Ec8GBz6zurKcAG3KHGqTOPjcuzqRRA
         9/PqY89Msy5UBNe1kNMqNMd/TfCCkAfhYkR71l2GYqSIuU5HuwR95KMdcLrcxXWq85FM
         n298R3qNNTuAMtrsFOHDX3HI3zqexcbisESYMYUG6FLBbh1wTGbxchTq8a0tLrCgXI5z
         enPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704611207; x=1705216007;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/Z2wBP6ADRqY6ScDPArQ8rum45VRYocNQ0uRCYXNHw=;
        b=WiuwxNYkluiR9x80ACal4Uwbf8TLSs3aq/V4EP3ACdc3yI9dlLf3lrHflzsadQ7bZo
         OBol6l0+SZkoZxiDpgUSx16laJ6vL3NhfG/TEtFdF4oOWjEz+CpA/w2yBTINyEe2GFSL
         nI/r4F2caEWr0H0YobFxim0gCuoK4TGWGAjpRQLTNBguGkS6ZeOO3BhPvKBacRDuPMbK
         I7ocQ3UIpjHsPNyiH3OUP64W3RhdUxAylz5mJaqgp3STSLXrLbTs78ivT2HA+gLdN3y+
         AU7BP5k3h/FZtler4TzNt+jfUo+WN4WR8Bgtf61eqQgMPAllfagPwAXCW2QhJs4w168d
         CbhA==
X-Gm-Message-State: AOJu0Yzw233VEwFtNPePMi6fxy86EcYa04grRPIA4A1Adj5eU7UUY1IY
	EZZ0zDAV2x64FiiK4cDNWKJv2mSeJoMLE2bRnl+3+tZd6ls=
X-Google-Smtp-Source: AGHT+IF0gSQTBilA+JUVOHDSowcXfdecDJ+f5rectkM2cmc9W25T1eUNHPFJS6Dki88P/uyUgFwKLW3brsDJ+kAkXaA=
X-Received: by 2002:ac8:5f12:0:b0:429:7ef9:2148 with SMTP id
 x18-20020ac85f12000000b004297ef92148mr2243153qta.106.1704611207249; Sat, 06
 Jan 2024 23:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Sun, 7 Jan 2024 08:06:36 +0100
Message-ID: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
Subject: Using send/receive to keep two rootfs-partitions in sync fails with
 "ERROR: snapshot: cannot find parent subvolume"
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I would like to use send/receive to keep two root-filesystems in sync,
as I've been using it for years now for backups where it really does
wonders (thanks a lot!).

Both disks contain a read-only snapshot which is kept in-sync between
the filesystems (int and ext are the mountpoints of the two disks,
original_disk is just used for initial data):
   btrfs send original_disk/root-ro | btrfs receive int/ #send
snapshot of the original disk to the first of the two filesystens
(disk "int")
   btrfs send int/root-ro | btrfs receive ext/ #now replicate the same
to disk "ext"
so both disks start with a snapshot "root-ro" with equal content.

in case I would like to work with one of the two disks, I create a rw
snapshot based no root-ro:
  btrfs sub snap ext/root-ro ext/root-rw

  touch ext/root-wr/create-a-new-file # perform some modifications

once modifications in root-rw are done, the following steps are
performed to sync the filesystems:
  btrfs sub snap -r ext/root-rw ext/root-ro-new #create a root-ro-new
read-only snapshot based on the rw-snapshot with modfications (so it
can be used with btrfs send)
  btrfs send -p ext/root-ro extern/root-ro-new | btrfs receive int/
#send root-ro-new to "int" filesystem
  btrfs sub del ext/root-ro # delete the original root-ro snapshot, as
it is no longer needed for differential btrfs send
  mv ext/root-ro-new ext/root-ro #rename root-ro-new to root-ro, as
this is the current state of the other (int) filesystem
  btrfs sub del int/root-ro # delete root-ro in "int" too, as it is no
longer needed for differential btrfs receive
  mv int/root-ro-new int/root-ro #rename root-ro-new to root-ro
  btrfs sub snap int/root-ro int/root-rw # create a working copy of
root-ro which is writeable

this works great - i can add/modify files in one root-rw folder, call
the synchronization script and everything is found on the other
filesystem.
When exchanging int and ext in the script above it actually works in
both directions, so this is exactly what I was hoping to achieve.
Even when executing the script multiple times int->ext, ext->int,
int->ext ... with modifications in between, everything works as
expected.
Awesome :)

However, when actually using the file-systems as rootfs, this seem to
break when performing the following steps:
- create rw snapshot of root-ro on disk "ext": btrfs sub snap
ext/root-ro ext/root-rw
- boot the system with rootfs=ext-uuid and rootflags=subvol=/root-rw
(etc/fstab was adapted accordingly)
- use the system, modify file system etc and shutdown again
- start separate system to synchronize disks (not based on int or ext
rootfs) and call sync script ext->int (shown above)

it now suddenly fails at btrfs receive with:
btrfs send -p ext/root-ro ext/root-ro-new | btrfs receive intern/
ERROR: snapshot: cannot find parent subvolume
4ed11491-7563-fb49-99e7-86cb47cfb510

which I, to be honest, don't understand.
Exactly the same sequence of commands worked multiple times when the
root-rw snapshot was not booted from but modified directly on the sync
system, even with umounts between modification & send/receive.
Does it make a difference for btrfs if it is used as rootfs vs normal
writeable mount?
Or does it just work in the non-boot case because of some side-effects?

Thanks & best regards, Clemens

