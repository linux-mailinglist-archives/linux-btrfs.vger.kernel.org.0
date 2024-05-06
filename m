Return-Path: <linux-btrfs+bounces-4778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D358BD0DC
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 16:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247B0B2262C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F271D15383A;
	Mon,  6 May 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4j0/6mb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A3381AA
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007497; cv=none; b=itMfq/rviTB+91p8KbAb3eZWd+wPcyKx4YlJOwSwCLx3uz2rsK8VA7R1722z+pxS+fccVkaJN+z5/w3YwEMxkmdOi5/uQ0uOQgKSriH9hLaWeUK5KOxLN2TsEqAII1pZOKntkd0BL/lS1LW7yDY2VGEQWxDRWSqr3daeGcxf99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007497; c=relaxed/simple;
	bh=Sn22q7PLMQUJ/u8XmCwpUDMtxReiZen8COc2Z4ScssM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n32byrRaKPH4M8zFwhHOsrZKZOitldTUBuGjSorWg9m4GH7H2B2ISQxqxWejn6lllLVs4wtA3/YIv0bol8iVVa0P/egX9ZNz3cHMVz/3X3GvQbkgwopiW2XjRnTelcjspAWdhRasRGAU4RhqSULdMlDONV+jsfEmg5dqpz2F/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4j0/6mb; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a9d66a51so435739566b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 06 May 2024 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715007494; x=1715612294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qujjpKeDbT7AelAzKAdobzxAdDnwPxYV5VSvUfQMTrA=;
        b=Z4j0/6mbBqF1VzDNRxs0G2Qm7YC2cf4M6naxuPI7Z8MldWFo2gbqK1oM2wPivFgbax
         AHVuQcpYar5+/zVTz21x8F23w0z8sqEPUcHxDgXvNzUrP+Lth6evP+DnT4UyOQBwi2F8
         HymFFOn7vsPjY2felKDfjmZdSMwVPs6JSYoiCCgp6sNZUUhRnAV6kwPGDzPMQVMEbpsS
         nxwxH+imjI7cHB/1TB84Yk9ipYm7Hw/XDARNoJj51Kr/Q/vttOub1sltQ5e2zjBZRJRd
         BvPg0/CsSW/XAF+l/m6WyeR3UgfRYcJPQRL9L+UuqsuJN/3y3mtpuwXYtQBMch7xzX0h
         4Ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715007494; x=1715612294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qujjpKeDbT7AelAzKAdobzxAdDnwPxYV5VSvUfQMTrA=;
        b=m214Qhvr/MrEe5unNYYKBCTpZHR4597CzgM0Q5PIYUnt+7p5q3fbgamxhiOGeupvb+
         OWxtRKiWbJIS+rw92vCPe6hDgtQs3aXgWAy9iaqITxLzJ3KYj8RqMxjKfwdkdNB3Qp4z
         qtARvGrBILqqWjro6pFWCz4cOxMeTx6VEBJsLN3vXGbKcIN3GCfUWW+jH8jtW9jQwRgA
         MmbS1Auyyqnj5/kYoXVD0rVwCtyLcnUjX54sOVgU7fSFAjaTF8+ylVy9tPKEwznTiYlg
         +H2x5MkWK3tvcbe+5H4WAYRlS00QZCOGdztEsLXOYeGEEYEjx9FYz9xuEUV9ho3qNP0A
         8k4w==
X-Forwarded-Encrypted: i=1; AJvYcCWFU5M0i83JIpX7JXjMjsy7M8pyNZBPQrh4eA5IvBBrlyp4tPQe1ORVqN4qYQuo019L/lcdYApPFTEZ/7B3rwbkx2R9dVRWzSA4hOY=
X-Gm-Message-State: AOJu0YzTxfRNBDaOKDGFbJdMTAdLPD5cei884I7PbTNTjbgs11my27+f
	Zac/GwGicGfa1YbBLSDdlsV6o5wI5Pd1sDtypDHepgsseJ9m+pm/7qQl0xwTbeIpL5q3aJQDoTx
	RjmMiDfn65MtBO8ZGH5rA0qIA23Q=
X-Google-Smtp-Source: AGHT+IFIBRq3LDIBt2djdbEZVIKoLoYgMZWKUMGQvh9rwrzgPezYtXtEC3GzsAEIr91C8sjw9LZxAr4EmTgSAya4Sws=
X-Received: by 2002:a50:8e1e:0:b0:56e:42e0:e53c with SMTP id
 30-20020a508e1e000000b0056e42e0e53cmr6830055edw.34.1715007493606; Mon, 06 May
 2024 07:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE0VrXJhJT98yucUDDvWTbcdXczTM4Mhy2XCqZtp+H00FYJfkg@mail.gmail.com>
 <CAE0VrXJ_8ZYjnKs+DQo1bmh7PxkQ=J6cWss3Fci0L2__mZbxxg@mail.gmail.com>
 <2bcc9d83-2442-4b06-92e8-2006eb980c83@oracle.com> <CAE0VrXJksFYCHr_JscryWS1TYT9+QX9opmZ9Y_2Lanc_=oybzA@mail.gmail.com>
 <0f97e260-bb17-48fb-898a-a71cdcf68ba7@oracle.com>
In-Reply-To: <0f97e260-bb17-48fb-898a-a71cdcf68ba7@oracle.com>
From: Yordan <y16267966@gmail.com>
Date: Mon, 6 May 2024 17:57:41 +0300
Message-ID: <CAE0VrXKbOXprWU7VdPTWK8+St1eeM2hpjvWOYw+BL9HjW-FSFA@mail.gmail.com>
Subject: Re: btrfs-convert on 24Gb image corrupts files.
To: Anand Jain <anand.jain@oracle.com>
Cc: quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, the same error after patching, and the same error on the original
24G image:

B/btrfs-progs/btrfs-convert sda3.img
btrfs-convert from btrfs-progs v6.8.1

Source filesystem:
  Type:           ext2
  Label:
  Blocksize:      4096
  UUID:           b3a78a9f-37e7-4ccb-bedb-1f800a6a5a19
Target filesystem:
  Label:
  Blocksize:      4096
  Nodesize:       16384
  UUID:           6595aa9c-415d-4ab0-bd9f-9a7f2ee8e3a9
  Checksum:       crc32c
  Features:       extref, skinny-metadata, no-holes, free-space-tree (defau=
lt)
    Data csum:    yes
    Inline data:  yes
    Copy xattr:   yes
Reported stats:
  Total space:     25769803776
  Free space:       8655269888 (33.59%)
  Inode count:         1572864
  Free inodes:         1325061
  Block count:         6291456
Create initial btrfs filesystem
Create ext2 image file
Create btrfs metadata
ERROR: inode 527126 index 2: identified unsupported merged block
length 9 wanted 10
ERROR: failed to copy ext2 inode 527126: -22
ERROR: error during copy_inodes -22
WARNING: error during conversion, the original filesystem is not modified

On Mon, May 6, 2024 at 4:43=E2=80=AFPM Anand Jain <anand.jain@oracle.com> w=
rote:
>
>
> It is meant to be applied on latest devel branch.
>
>
> With the v2 patches:
>
> $ ./btrfs-convert ~/sda3.img
> btrfs-convert from btrfs-progs v6.8
>
> Source filesystem:
>    Type:           ext2
>    Label:
>    Blocksize:      4096
>    UUID:           b3a78a9f-37e7-4ccb-bedb-1f800a6a5a19
> Target filesystem:
>    Label:
>    Blocksize:      4096
>    Nodesize:       16384
>    UUID:           d8c61c42-1b2c-478d-8ae6-bf45213e8df4
>    Checksum:       crc32c
>    Features:       extref, skinny-metadata, no-holes, free-space-tree
> (default)
>      Data csum:    yes
>      Inline data:  yes
>      Copy xattr:   yes
> Reported stats:
>    Total space:       536870912
>    Free space:        326238208 (60.77%)
>    Inode count:           32768
>    Free inodes:           32743
>    Block count:          131072
> Create initial btrfs filesystem
> Create ext2 image file
> Create btrfs metadata
> ERROR: inode 20 index 0: identified unsupported merged block length 1
> wanted 12
> ERROR: failed to copy ext2 inode 20: -22
> ERROR: error during copy_inodes -22
> WARNING: error during conversion, the original filesystem is not modified
>
>
>
>
>
> On 5/6/24 21:35, Yordan wrote:
> > NO, I have problems applying patch4, so its unpatchet
> >
> > error: patch failed: convert/source-fs.c:316
> > error: convert/source-fs.c: patch does not apply
> >
> > I just sent you a small problematic image so you can test it yourself.
> >
> > On Mon, May 6, 2024 at 4:17=E2=80=AFPM Anand Jain <anand.jain@oracle.co=
m> wrote:
> >>
> >>
> >>
> >> On 5/6/24 18:53, Yordan wrote:
> >>> The attached file which is a reduced version of the problematic image=
,
> >>> produced by removing all files and directories, except 5 of the
> >>> problematic files and their path. Then its filesystem filled with zer=
o
> >>> file, shrinked with "resize2fs" to 512M and compressed to 7M.
> >>>
> >>> md5sum sda3.img.zst
> >>> 9eec41fee47e3db555edeaba5d8d2e9a  sda3.img.zst
> >>>
> >>> (chroot) livecd / # zstd -d sda3.img.zst -o sda3.img
> >>> sda3.img.zst        : 536870912 bytes
> >>> (chroot) livecd / # mount -o ro sda3.img k
> >>> (chroot) livecd / # find k/ -type f | xargs md5sum >files.md5
> >>> (chroot) livecd / # md5sum -c files.md5 | grep -v OK
> >>>
> >>> (chroot) livecd / # umount k
> >>> (chroot) livecd / # B/btrfs-progs/btrfs-convert sda3.img
> >>> btrfs-convert from btrfs-progs v6.8.1
> >>>   > Source filesystem:
> >>>     Type:           ext2
> >>>     Label:
> >>>     Blocksize:      4096
> >>>     UUID:           b3a78a9f-37e7-4ccb-bedb-1f800a6a5a19
> >>> Target filesystem:
> >>>     Label:
> >>>     Blocksize:      4096
> >>>     Nodesize:       16384
> >>>     UUID:           d7c77d2f-d470-450a-ba0e-b6567ad3f4b3
> >>>     Checksum:       crc32c
> >>>     Features:       extref, skinny-metadata, no-holes, free-space-tre=
e (default)
> >>>       Data csum:    yes
> >>>       Inline data:  yes
> >>>       Copy xattr:   yes
> >>> Reported stats:
> >>>     Total space:       536870912
> >>>     Free space:        326238208 (60.77%)
> >>>     Inode count:           32768
> >>>     Free inodes:           32743
> >>>     Block count:          131072
> >>> Create initial btrfs filesystem
> >>> Create ext2 image file
> >>> Create btrfs metadata
> >>> Copy inodes [o] [         1/        25]
> >>> Free space cache cleared
> >>> Conversion complete
> >>>
> >>> (chroot) livecd / # mount -o ro sda3.img k
> >>> (chroot) livecd / # md5sum -c files.md5
> >>> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/ch=
rome/idb/3561288849sdhlie.sqlite:
> >>> FAILED
> >>> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/ch=
rome/idb/1657114595AmcateirvtiSty.sqlite:
> >>> FAILED
> >>> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/ch=
rome/idb/2823318777ntouromlalnodry--naod.sqlite:
> >>> FAILED
> >>> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/ch=
rome/idb/2918063365piupsah.sqlite:
> >>> FAILED
> >>> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/ch=
rome/idb/3870112724rsegmnoittet-es.sqlite:
> >>> OK
> >>> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/ch=
rome/idb/1451318868ntouromlalnodry--epcr.sqlite:
> >>> FAILED
> >>> md5sum: WARNING: 5 computed checksums did NOT match
> >>>
> >>
> >>
> >> Are these test results with the v2 patchset? Thanks, Anand.
> >>
> >>
> >>> Regards, Jordan.

