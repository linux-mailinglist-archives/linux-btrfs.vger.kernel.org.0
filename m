Return-Path: <linux-btrfs+bounces-17014-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9428B8E612
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 23:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E95E1893ACA
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 21:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422D2242D9D;
	Sun, 21 Sep 2025 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fandingo-org.20230601.gappssmtp.com header.i=@fandingo-org.20230601.gappssmtp.com header.b="gRVkVqDO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319B1A0BFD
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758489350; cv=none; b=Q247poPER4RnWmtbVLomtMiJ6f51PIzUSiW2hSairrYlvcwHkzLC1Gnmrmk709AvVGWmpWByoBDCY5IV5qYm2CNiE2u0rAMOaUERFhMhf2h/29avRI/MLLBpcRkcO5EI1cLIHh6GbdPhkVIQEljhHqbBxf17TAgaMRCs8z4s8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758489350; c=relaxed/simple;
	bh=6+sJGbdX1Edentok32GYZocUVVXRRTAqND540YL15LA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WgRaMrxDjTQAvQPGj3dQD/4CeUEAbLvfBxvEHMnXSUDzeLY1nljvdC+qta7QejY+5krdsf20RVomnaianzBIYWbDs/7ZnA2mHRH4HbOV6hQ7HOVD/A3KZ+DKC4dtMvP0RqQRoERSBR1QsFIAxRL3TceL9+Wa1DHOQ+W9xpo9dKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fandingo.org; spf=none smtp.mailfrom=fandingo.org; dkim=pass (2048-bit key) header.d=fandingo-org.20230601.gappssmtp.com header.i=@fandingo-org.20230601.gappssmtp.com header.b=gRVkVqDO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fandingo.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fandingo.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0e7bc49263so609884766b.1
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fandingo-org.20230601.gappssmtp.com; s=20230601; t=1758489346; x=1759094146; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sQIUqDMu07hrRwoBOVLmgkq+rEP9ii2M0w0MtOdVGLY=;
        b=gRVkVqDO48LP2f2DtVod+hKslgIcGJ+ip9JmL+I8mwqgoELl2YHcRjYwoXvkwusynS
         A7wXGRMd9zD9SDfDBVandlnIjtPgS5+oE0/nGE1rqKgezbJyMro3OWDFMzUdE6M7ZGC1
         a20QaOVdbP3m6wchxjHADEtIkZUQU8PAulExlWP1Tn/XoWV8V+R7KuumkrtcftTeAeQw
         P45sClGEYtYYRRGJn7IaxWP+B/kjHYAoXQuCDjVGp4a7PmkKK4qp3Rwf95yV3vi4ib9j
         ThYWZufB/XAlqDSgSx+6AQ16cTufitZlxH30dg0//opuXUjVu59BZhkC6qdkYfd1jrDa
         pk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758489346; x=1759094146;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQIUqDMu07hrRwoBOVLmgkq+rEP9ii2M0w0MtOdVGLY=;
        b=nLXCFbfmXQEDzDOmDJ1YGAEfs8R0YY/8GlOw68XASE43BGlW6Mr77WDwI5O09OgzW9
         NHSo1uCRWTNoJta8/GIdCH5q6i6gElEGoIGaZ0V0eI5/cRHKFf6TyyyOkaToM0jl/cut
         JBPtSSIPX6Y8DQCxOagmOpzcB7l0jONoz2rJGIPArkQqJHH90CYiHKErcmCPHkbDRPUi
         3HCxZiVtrlJ8Sb5DbqRX7uNbQtKU5tO21hROBcYBd1H/idcr2bpo9NdfdsGRyiHpEQbf
         EXIHNYRV6LDxlLJaCtncrRgVIMtjzHiLBaCu/7pSJpVi3VUHpgj7kLViDqXmLl/huy1w
         i8hg==
X-Gm-Message-State: AOJu0Yw1x7kSrNTnpaM6j+jApNUYH9X0x3rEv1lJ2hTewmmIRB38JCTP
	BFxeCAb6JYdAcUxuAiz40M6fhJa2kLu7Z//V5pVmx+V2wWtDRFHyMZe0xcZSwY3xkbFyvUZK7KU
	gHibz8Zeg3roDJdZk/o5JeMjU3WOL9iGvmtsHiMrcM72Fp966Y03TJKs=
X-Gm-Gg: ASbGncvUoQxMSmzFGnO41rjwNokSWlVTiU88tTqUTYfXhFtV3JMC4BJgm2+ZrucP0SC
	7HaGBFi7CkA+ufD2aGNByKbxf7iW5m5Wp+PfagP1zCzGpBtw4PBGZxbxeheP/NFuw9bniU2fg/U
	n0fHhxlSAL+QZLmK2gRCCjjCMtQgl53w0bd6MFc1jQdXmN07PmPJq2ZrTJqEyrcu8A0bB0i6xEI
	wK0IsHCmbmIGi2gxIgv81a3fLcFiQR2SMFRyZ9k
X-Google-Smtp-Source: AGHT+IH5Mah67M/fdm6/nFOLLQwyjln3qG+3EkYE1NvksefnGWR1pImi6GE3CVVjITEpvdNy8g0XI+DfUOyHTPllrsE=
X-Received: by 2002:a17:907:7e8b:b0:b2d:604d:acc7 with SMTP id
 a640c23a62f3a-b2d604db6afmr15293966b.37.1758489346080; Sun, 21 Sep 2025
 14:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Brown <Justin.Brown@fandingo.org>
Date: Sun, 21 Sep 2025 16:15:34 -0500
X-Gm-Features: AS18NWCEIVJtLF3Wh-2P8aDM6E5OVqItsR3bNdeLlfCbZflljMfzBZsysZevztM
Message-ID: <CAKZK7uzqNj1336MijN2De-R9+rdjw_Zm6=b-Q1jCCDQb5+fmXw@mail.gmail.com>
Subject: [Support] failed to read chunk root / open_ctree failed: -5
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I had a pretty bad power outage that fried my server. I pulled a Btrfs
HDD (1 drive, -d single, -m dup), and I'm trying to recover it. The
HDD works fine -- the LUKS volume unlocks, and I can dd read from it,
but the fs seems to be in bad shape. I've spent a few hours
researching, but a lot of the information out there is really low
quality. I've tried to stay away from the really dangerous stuff so
far, but I did try some of the more benign troubleshooting.

Kernel: 6.16.5-arch1-1
btrfs-progs v6.16

[fandingo:~] $ lsblk -o name,size,label,fstype,model /dev/sdc
NAME  SIZE LABEL       FSTYPE      MODEL
sdc   7.3T crypt_media crypto_LUKS ST8000VN004-2M2101
=E2=94=94=E2=94=80cm  7.3T media       btrfs

[fandingo:~] $ sudo btrfs fi showLabel: 'media'  uuid:
e2dc4c13-e687-4829-8c24-fa822d9ba04a
       Total devices 1 FS bytes used 6.10TiB
       devid    1 size 7.28TiB used 6.24TiB path /dev/mapper/cm


[fandingo:~] $ sudo mount -o ro /dev/mapper/cm /var/media/
mount: /var/media: can't read superblock on /dev/mapper/cm.
      dmesg(1) may have more information after failed mount system call.
[fandingo:~] 32 $ sudo dmesg
[ 7546.813999] BTRFS: device label media devid 1 transid 4956
/dev/mapper/cm (253:5) scanned by mount (6934)
[ 7546.814345] BTRFS info (device dm-5): first mount of filesystem
e2dc4c13-e687-4829-8c24-fa822d9ba04a
[ 7546.814354] BTRFS info (device dm-5): using crc32c (crc32c-x86)
checksum algorithm
[ 7546.814743] BTRFS error (device dm-5): level verify failed on
logical 27656192 mirror 1 wanted 1 found 0
[ 7546.814831] BTRFS error (device dm-5): level verify failed on
logical 27656192 mirror 2 wanted 1 found 0
[ 7546.814837] BTRFS error (device dm-5): failed to read chunk root
[ 7546.814933] BTRFS error (device dm-5): open_ctree failed: -5


I've tried a few recovery options, tending towards the more safe side.

~$: sudo mount -o ro,rescue=3Dusebackuproot /dev/mapper/cm /var/media
Same error and dmesg

=3D=3D=3D=3D=3D=3D

[fandingo:~] 3s $ sudo btrfs-find-root /dev/mapper/cm
parent transid verify failed on 27656192 wanted 4945 found 2607
parent transid verify failed on 27656192 wanted 4945 found 2607
WARNING: cannot read chunk root, continue anyway
Superblock thinks the generation is 4956
Superblock thinks the level is 0

=3D=3D=3D=3D=3D=3D

[fandingo:~] 30s $ sudo btrfs rescue zero-log /dev/mapper/cm
parent transid verify failed on 27656192 wanted 4945 found 2607
parent transid verify failed on 27656192 wanted 4945 found 2607
ERROR: cannot read chunk root
ERROR: could not open ctree

=3D=3D=3D=3D=3D=3D

[fandingo:~] 1 $ sudo btrfs rescue super-recover /dev/mapper/cm
All supers are valid, no need to recover

=3D=3D=3D=3D=3D=3D

[fandingo:~] 4s $ sudo btrfs restore /dev/mapper/cm /var/media/
parent transid verify failed on 27656192 wanted 4945 found 2607
parent transid verify failed on 27656192 wanted 4945 found 2607
parent transid verify failed on 27656192 wanted 4945 found 2607
Ignoring transid failure
ERROR: root [3 0] level 0 does not match 1

ERROR: cannot read chunk root
Could not open root, trying backup super
parent transid verify failed on 27656192 wanted 4945 found 2607
parent transid verify failed on 27656192 wanted 4945 found 2607
parent transid verify failed on 27656192 wanted 4945 found 2607
Ignoring transid failure
ERROR: root [3 0] level 0 does not match 1

ERROR: cannot read chunk root
Could not open root, trying backup super
parent transid verify failed on 27656192 wanted 4945 found 2607
parent transid verify failed on 27656192 wanted 4945 found 2607
parent transid verify failed on 27656192 wanted 4945 found 2607
Ignoring transid failure
ERROR: root [3 0] level 0 does not match 1

ERROR: cannot read chunk root
Could not open root, trying backup super

=3D=3D=3D=3D=3D=3D=3D

[fandingo:~] 13s $ sudo btrfs inspect-internal dump-tree /dev/mapper/cm
btrfs-progs v6.16.1
parent transid verify failed on 27656192 wanted 4945 found 2607
parent transid verify failed on 27656192 wanted 4945 found 2607
ERROR: cannot read chunk root
ERROR: unable to open /dev/mapper/cm

Same error for `btrfs inspect-internal tree-stats`.

=3D=3D=3D=3D=3D=3D=3D

[fandingo:~] 4s $ sudo btrfs inspect-internal dump-super /dev/mapper/cm
superblock: bytenr=3D65536, device=3D/dev/mapper/cm
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x05e1f6bc [match]
bytenr                  65536
flags                   0x1
                       ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    e2dc4c13-e687-4829-8c24-fa822d9ba04a
metadata_uuid           00000000-0000-0000-0000-000000000000
label                   media
generation              4956
root                    998506496
sys_array_size          129
chunk_root_generation   4945
root_level              0
chunk_root              27656192
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             8001546444800
bytes_used              6708315303936
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x3
                       ( FREE_SPACE_TREE |
                         FREE_SPACE_TREE_VALID )
incompat_flags          0x361
                       ( MIXED_BACKREF |
                         BIG_METADATA |
                         EXTENDED_IREF |
                         SKINNY_METADATA |
                         NO_HOLES )
cache_generation        0
uuid_tree_generation    4956
dev_item.uuid           529d3f9a-52be-4af5-a8e8-7bf6108c65e7
dev_item.fsid           e2dc4c13-e687-4829-8c24-fa822d9ba04a [match]
dev_item.type           0
dev_item.total_bytes    8001546444800
dev_item.bytes_used     6856940453888
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0





This HDD is used for occasional archival, and it probably didn't see
any data writes in the week prior to the power surge. If I could get
access to any of the data, even old version (eg. that 2607 transid or
whatever the proper terminology is), would be very useful. Any
suggestions on what to do from here?

Thanks,
fandingo

