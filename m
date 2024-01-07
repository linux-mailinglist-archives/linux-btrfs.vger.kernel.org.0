Return-Path: <linux-btrfs+bounces-1287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A02C826353
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 09:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAAB4B21C5C
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FE612B70;
	Sun,  7 Jan 2024 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCCu4Fb+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E7E12B61
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Jan 2024 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7cc705bbb2eso227589241.1
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Jan 2024 00:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704615035; x=1705219835; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxO94uZ2wr08ioNrvt+ElDQ3wmGjjULRjXfxdbTHH0I=;
        b=nCCu4Fb+jIlGQ2wLJns95EmMxTTW3TGU9XXDkqvIKF8JWlfsxxTr7RFT7Mjq8JcYrf
         7VIqeIVoaw/TxTEa2SCa2L00Tg9N/zZiJqm2Pc6CPxLnHOpZ3QuCHXx+njZtjC6xy6fd
         qPBLLQXhRzVjFj9xDYjQEP5oZlX3cDgmKYHi3GAcQcanxt2EImb7zgSxiQx+PLcVIvYY
         fpdZr9JFbMaessXUr0teq66zMsATUFJkIZMF8Oo5e4s6AaCYjF3z/P0Q8/C/zxC2DvJO
         41butPS9mW4Vbsg1IFOiFUQnFbtLW9F2n3J7QrHoZpnAOeH+3CKFy7JHtk/aS3tz0zDN
         mNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704615035; x=1705219835;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxO94uZ2wr08ioNrvt+ElDQ3wmGjjULRjXfxdbTHH0I=;
        b=h++PctgvroVzKRN04WLUOXUZOED7Aa0//n51mMUQtEuwm4GDTY2AxoJi7V4uh7ntrX
         cbKnujc9A612axozoRvH1X323V/EoaYLA0MQ/k/5u/eukO74tEkSTYuAkoC0LdUGZMqp
         fJDD8cuVEDZauryGYu/N2TBMJRtbTXA5kX9Z6DHWYZwl9dRvnpoV6JqhWK4SVGxoMXly
         XlvzeDKFmDVQsKaDaYNkXcG4rghyUVJFa7Qn68mmGmQdRyhI1rTUJz74ROsoBKlT+nV+
         OzXC6+sNpem2wGJmUUU6V078yPA1XB1VUHi4tQSHl8rzSZe/gcM9EeRH/oCMrUOeKh03
         VoAQ==
X-Gm-Message-State: AOJu0YzlNkpkzvQAE3LBiD4h0FAMkXVGKMI9+eXgSK4j7c5F7MPU6zOp
	KxhYfqlVaFBaxxjJIXjECvzymbFW53huySJd+IrHr3anOVY=
X-Google-Smtp-Source: AGHT+IHy/RfKq5wdv3oPvmsN9AF9DPTWWqNTfhnlNjeToW3emkpoNTdiCH91F86jzCM/svZIkW13L8VTvOEDQjMPM4o=
X-Received: by 2002:a05:6102:c8b:b0:467:8539:52b8 with SMTP id
 f11-20020a0561020c8b00b00467853952b8mr677360vst.7.1704615034577; Sun, 07 Jan
 2024 00:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
 <de1e4749-c265-496b-956d-6ab8e56af7d0@gmail.com>
In-Reply-To: <de1e4749-c265-496b-956d-6ab8e56af7d0@gmail.com>
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Sun, 7 Jan 2024 09:10:23 +0100
Message-ID: <CAFvQSYReFG3hUJCoRps36hbR1-PaprSsEirodtSS9Bc9nThEtQ@mail.gmail.com>
Subject: Re: Using send/receive to keep two rootfs-partitions in sync fails
 with "ERROR: snapshot: cannot find parent subvolume"
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Andrei,

Thanks for taking a look.

The exact commands executed where:

mkdir intern
mkdir extern

mount /dev/mapper/ext extern
mout /dev/mapper/int intern

ls extern/
# output: root-ro

ls intern/
# output: -> empty

btrfs send extern/root-ro | btrfs receive intern/ #initial ext -> int
btrfs sub snap intern/root-ro intern/root-rw # rw snapshot to modify int
touch intern/root-rw/newfile #actual modification

umount intern
umount extern

sh sync_int_to_ext.sh #source of script at bottom

ls extern/root-ro/newfile
# output: extern/root-ro/newfile -> sync int->ext was successful

# now modify ext fs
mount /dev/mapper/ext extern/
touch extern/root-rw/anothernewfile
umount extern

sh sync_ext_to_int.sh

mount /dev/mapper/int intern/

ls intern/root-ro/anothernewfile
# output intern/root-ro/anothernewfile -> sync ext->int was successful

umount intern

sh sync_int_to_ext.sh # just to make sure

# boot into extern/root-rw with rootflags=subvol/root-rw
# both newfile and anothernewfile are visible in the root-fs

# reboot into other OS used for syncing disks

sh sync_ext_to_int.sh #to mirror modifications made in ext during it
was rootfs back to intern, worked
sh sync_int_to_ext.sh # just to make sure

# boot into extern/root-rw with rootflags=subvol/root-rw
# perform a few modifications

# reboot into other OS used for syncing disks

sh sync_ext_to_int.sh
# command btrfs send -p extern/root-ro extern/root-ro-new | btrfs
receive intern/ fails with:
ERROR: clone: cannot find source subvol 29fca96e-ca6a-3d4b-b7c9-566f1240d978


btrfs sub list -pqu intern/
ID 330 gen 426 parent 5 top level 5 parent_uuid
29fca96e-ca6a-3d4b-b7c9-566f1240d978 uuid
6409bfb7-1af0-7e4b-8a0f-d5a44e34a15c path root-ro
ID 331 gen 426 parent 5 top level 5 parent_uuid
6409bfb7-1af0-7e4b-8a0f-d5a44e34a15c uuid
258c1fe5-b14e-654b-8ad5-5591268c9095 path root-rw

btrfs sub list -pqu extern/
ID 291 gen 418 parent 5 top level 5 parent_uuid
1c738933-0bb2-2547-ad5f-326bfc6263b3 uuid
939c1ed9-9589-6c4b-ace7-2fcdeb970303 path root-rw
ID 292 gen 418 parent 5 top level 5 parent_uuid
939c1ed9-9589-6c4b-ace7-2fcdeb970303 uuid
155f4370-32f0-5f4b-b288-2e8d7302d279 path root-ro

Best regards, Clemens



script sync_ext_to_int.sh:

unalias cp
mount -o compress=zstd:6 /dev/mapper/ext extern/
mount -o compress=zstd:6 /dev/mapper/int intern/

btrfs sub snap -r extern/root-rw extern/root-ro-new
btrfs send -p extern/root-ro extern/root-ro-new | btrfs receive intern/

btrfs sub del extern/root-ro
mv extern/root-ro-new extern/root-ro

btrfs sub del intern/root-ro
mv intern/root-ro-new intern/root-ro
btrfs sub del intern/root-rw
btrfs sub snap intern/root-ro intern/root-rw

#cp cfgint/fstab intern/root-rw/etc/
#cp cfgint/crypttab intern/root-rw/etc/
#cp cfgint/grub intern/root-rw/etc/default/

umount extern;
umount intern;



script sync_int_to_ext.sh:

unalias cp
mount -o compress=zstd:6 /dev/mapper/ext extern/
mount -o compress=zstd:6 /dev/mapper/int intern/

btrfs sub snap -r intern/root-rw intern/root-ro-new
btrfs send -p intern/root-ro intern/root-ro-new | btrfs receive extern/

btrfs sub del intern/root-ro
mv intern/root-ro-new intern/root-ro

btrfs sub del extern/root-ro
mv extern/root-ro-new extern/root-ro
btrfs sub del extern/root-rw
btrfs sub snap extern/root-ro extern/root-rw

cp cfgext/fstab extern/root-rw/etc/
cp cfgext/crypttab extern/root-rw/etc/
cp cfgext/grub extern/root-rw/etc/default/

umount extern;
umount intern;

Am So., 7. Jan. 2024 um 08:19 Uhr schrieb Andrei Borzenkov
<arvidjaar@gmail.com>:
>
> On 07.01.2024 10:06, Clemens Eisserer wrote:
> > Hi,
> >
> > I would like to use send/receive to keep two root-filesystems in sync,
> > as I've been using it for years now for backups where it really does
> > wonders (thanks a lot!).
> >
> > Both disks contain a read-only snapshot which is kept in-sync between
> > the filesystems (int and ext are the mountpoints of the two disks,
> > original_disk is just used for initial data):
> >     btrfs send original_disk/root-ro | btrfs receive int/ #send
> > snapshot of the original disk to the first of the two filesystens
> > (disk "int")
> >     btrfs send int/root-ro | btrfs receive ext/ #now replicate the same
> > to disk "ext"
> > so both disks start with a snapshot "root-ro" with equal content.
> >
> > in case I would like to work with one of the two disks, I create a rw
> > snapshot based no root-ro:
> >    btrfs sub snap ext/root-ro ext/root-rw
> >
> >    touch ext/root-wr/create-a-new-file # perform some modifications
> >
>
> There was no "root-wr" before.
>
> > once modifications in root-rw are done, the following steps are
> > performed to sync the filesystems:
> >    btrfs sub snap -r ext/root-rw ext/root-ro-new #create a root-ro-new
> > read-only snapshot based on the rw-snapshot with modfications (so it
> > can be used with btrfs send)
> >    btrfs send -p ext/root-ro extern/root-ro-new | btrfs receive int/
> > #send root-ro-new to "int" filesystem
>
> There was no "extern" before.
>
> Never describe computer commands. Copy and paste them in full with
> complete output.
>
> >    btrfs sub del ext/root-ro # delete the original root-ro snapshot, as
> > it is no longer needed for differential btrfs send
> >    mv ext/root-ro-new ext/root-ro #rename root-ro-new to root-ro, as
> > this is the current state of the other (int) filesystem
> >    btrfs sub del int/root-ro # delete root-ro in "int" too, as it is no
> > longer needed for differential btrfs receive
> >    mv int/root-ro-new int/root-ro #rename root-ro-new to root-ro
> >    btrfs sub snap int/root-ro int/root-rw # create a working copy of
> > root-ro which is writeable
> >
> > this works great - i can add/modify files in one root-rw folder, call
> > the synchronization script and everything is found on the other
> > filesystem.
> > When exchanging int and ext in the script above it actually works in
> > both directions, so this is exactly what I was hoping to achieve.
> > Even when executing the script multiple times int->ext, ext->int,
> > int->ext ... with modifications in between, everything works as
> > expected.
> > Awesome :)
> >
> > However, when actually using the file-systems as rootfs, this seem to
> > break when performing the following steps:
> > - create rw snapshot of root-ro on disk "ext": btrfs sub snap
> > ext/root-ro ext/root-rw
> > - boot the system with rootfs=ext-uuid and rootflags=subvol=/root-rw
> > (etc/fstab was adapted accordingly)
> > - use the system, modify file system etc and shutdown again
> > - start separate system to synchronize disks (not based on int or ext
> > rootfs) and call sync script ext->int (shown above)
> >
>
> It is absolutely unclear what it means. As mentioned, provide full
> transcript of your actions as well as the output of
>
> btrfs subvolume list -pqu /mount-point
>
> for all filesystems involved in these commands.
>
> > it now suddenly fails at btrfs receive with:
> > btrfs send -p ext/root-ro ext/root-ro-new | btrfs receive intern/
> > ERROR: snapshot: cannot find parent subvolume
> > 4ed11491-7563-fb49-99e7-86cb47cfb510
> >
> > which I, to be honest, don't understand.
> > Exactly the same sequence of commands worked multiple times when the
> > root-rw snapshot was not booted from but modified directly on the sync
> > system, even with umounts between modification & send/receive.
> > Does it make a difference for btrfs if it is used as rootfs vs normal
> > writeable mount?
> > Or does it just work in the non-boot case because of some side-effects?
> >
> > Thanks & best regards, Clemens
> >
>

