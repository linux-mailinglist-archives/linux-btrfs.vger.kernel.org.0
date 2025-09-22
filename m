Return-Path: <linux-btrfs+bounces-17029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD06B8E9E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 02:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEBF189490D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 00:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAE13596D;
	Mon, 22 Sep 2025 00:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fandingo-org.20230601.gappssmtp.com header.i=@fandingo-org.20230601.gappssmtp.com header.b="cq4St2XU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584C51BC2A
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758500108; cv=none; b=fxtiYL3aNihaJbSpcgZmR9igfI7nSficdReLCJpiTFKJUcBqm+pDmwHQ1xqqigqSYt1oqG1zwH2GXVnzdw1u1uTN5gU0EfWy/lON+TIebl2rzDw46rK5ffoLAk7gKCtdCCfqEZjA6Md8qN8MBLxOoDCy7fxMoy62WUZ5nEyGfKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758500108; c=relaxed/simple;
	bh=te4xAFDjvY/fsMmLKPGrh+9epZh0OMW/FqqPt2IZfJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBmhy/qxZdKP9/dNt40SUFKJWEOPoDivgqsk9fj0NQ0AuU1NdrovAsWTzMQjWFHQwaJX/ue6W4yZxqNGpmNqA5GHXIYT5YYY2/nPIul0ZwsH3CwOqZEi/h0WQW/m5CkDK74Is88nUZNbNIidUwXT/3YAEKeVPmZ2cfaS5tp+orA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fandingo.org; spf=none smtp.mailfrom=fandingo.org; dkim=pass (2048-bit key) header.d=fandingo-org.20230601.gappssmtp.com header.i=@fandingo-org.20230601.gappssmtp.com header.b=cq4St2XU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fandingo.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fandingo.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso2191364a12.2
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 17:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fandingo-org.20230601.gappssmtp.com; s=20230601; t=1758500105; x=1759104905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgegE6zmwPDGoGxNdw/jNNo9B8yUrWpCcObWZ9H+2Uw=;
        b=cq4St2XUgvfCNgrQ/2ykxocNDtwJtVMEaxTPAJ0atDnj5mRfwCLFATUh+icCIpjtSe
         ffJUOBDleYdklMzdVIgzLVpmMTFwgC35nMZnWoJJUZghUj/8NTM3yDVbwSAskKu7hOIn
         X+rgW83xf9f2UluRE0SxLqGNvqOThSkqj9zBGban48OPwrr3fOTy7r5UtXyeTiZjSx73
         RncgTamKA0FR2ppoKxzc0aDS66Qmi87I2/HoX3sWFLq4/SXHCa8LPJDWZiBI9wqLsL1k
         UBvaymnIs6ijNOK4shECkn/PJPMNV0Lr89OqdoAGfQJcdmCcFr12QIjmQRuhyyXi+cp9
         XQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758500105; x=1759104905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgegE6zmwPDGoGxNdw/jNNo9B8yUrWpCcObWZ9H+2Uw=;
        b=j7yEUCQ1RHfbGRtmZjhzy6HMcYHU/kMIHSEA0CItpTMBz7GfqcPbxJlj839+uPkoG/
         1b24CY+lZi43r0LBupopgi3TpBjgvEZPOEvMPMv6JHGtbxwp3fcr27RlVURffSEAGY1x
         ZwCC8Y/QrGoBXpHtqPXzzOMYl/ZI+XXttCniQMFTkmEIx3fA7l93Got8vbiFUNu1aaF7
         NSw0dmA3UcUJCosFQuktVXhtPPsODJXMXVqB4ZlXiBKAliuECtH7oSZQ+0YjmAn1MzP0
         mNSnS5kQy4h8l3kut2INDT93tXz0H+ByFHKUxcoB9MFyHTDk5N+GOMtDh68MQRaI/oad
         tIfA==
X-Gm-Message-State: AOJu0Yya2jmOX47rRBDwxZsxGdsO66EFjc8fa6zjLlGCB8qLhpZPLw6z
	bOWrQuV+MzStUgfN4PMYEs1mOzr9yP0nuIJ2uIM5bAqIftw4ooEy5INESGz/21fpfUQApNKCDgb
	JiMaP9yiiNFciDFcFwEai13u6WZOw91bRv5hjbN3/VGfF7onlyRBiwm0=
X-Gm-Gg: ASbGncshHMYzxuTsk8fnXYoaNI/wsb/Jhr/7POLMTwynvsT+w51ieny7Zf3H7oOBVY/
	CGgS6/VqtSzO5JgYAIDub5lzqaeSNS2DnrXYtNkzMz66t2GnPrzJlKR3KCXd34D63YUIEeDI9++
	vJ4QIPqXz/Ln4AiYGFUy9v+ftcE1VC/87VP/KS+ZiAXckVQuMNBZPNO+EsqcaEopztYfCfaPF5c
	qpamTKUn4mPDN7ZgTqWGlBEbw0TjrFYo4UI5wVh
X-Google-Smtp-Source: AGHT+IGbwlJoABEOHKTbnRhIynkFQR/C169nzgjWZeUm3t4a4YYkjiNh9vqzEFVqzv34febfPHmxpvDOMnxAJTFl+q4=
X-Received: by 2002:a17:907:7b8c:b0:b04:3d7b:ad43 with SMTP id
 a640c23a62f3a-b24f3a76137mr1300753766b.40.1758500104439; Sun, 21 Sep 2025
 17:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKZK7uzqNj1336MijN2De-R9+rdjw_Zm6=b-Q1jCCDQb5+fmXw@mail.gmail.com>
 <27b4ca8f-de3a-4b9f-b90d-c6260ba81f9c@suse.com>
In-Reply-To: <27b4ca8f-de3a-4b9f-b90d-c6260ba81f9c@suse.com>
From: Justin Brown <Justin.Brown@fandingo.org>
Date: Sun, 21 Sep 2025 19:14:52 -0500
X-Gm-Features: AS18NWBwWtHMurSYmcudu1o8AeiRt2bFZIDPTty9uLLiNjth2ZOLAJ9E4x3sfWQ
Message-ID: <CAKZK7uxiRmDxk-1goC4yj7QZPSmL-=GAoAuF=OdekbSNVrG8fg@mail.gmail.com>
Subject: Re: [Support] failed to read chunk root / open_ctree failed: -5
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qu,

I tried the command you suggested, but I'm not really sure what bytenr
is in this context. Is that the block number or block number * sector
size (i.e. 4096)? And when you say "verify which works best," what am
I looking for?

I uploaded the full output to pastebin
(https://pastebin.com/LN2bHDGV), but here's an excerpt


[fandingo:~] $ sudo btrfs-find-root -o 3 /dev/mapper/cm
parent transid verify failed on 27656192 wanted 4945 found 2607
parent transid verify failed on 27656192 wanted 4945 found 2607
WARNING: cannot read chunk root, continue anyway
Superblock thinks the generation is 4945
Superblock thinks the level is 1
Well block 22233088(gen: 4451 level: 1) seems good, but
generation/level doesn't match, want gen: 4945 level: 1
Well block 22183936(gen: 3195 level: 1) seems good, but
generation/level doesn't match, want gen: 4945 level: 1
Well block 29425664(gen: 3178 level: 1) seems good, but
generation/level doesn't match, want gen: 4945 level: 1
Well block 29376512(gen: 3178 level: 1) seems good, but
generation/level doesn't match, want gen: 4945 level: 1
Well block 22167552(gen: 2608 level: 0) seems good, but
generation/level doesn't match, want gen: 4945 level: 1
Well block 22020096(gen: 2608 level: 0) seems good, but
generation/level doesn't match, want gen: 4945 level: 1
Well block 27656192(gen: 2607 level: 0) seems good, but
generation/level doesn't match, want gen: 4945 level: 1
Well block 22102016(gen: 2582 level: 1) seems good, but
generation/level doesn't match, want gen: 4945 level: 1
Well block 22052864(gen: 2582 level: 1) seems good, but
generation/level doesn't match, want gen: 4945 level: 1
Well block 27557888(gen: 2335 level: 1) seems good, but
generation/level doesn't match, want gen: 4945 level: 1
Well block 27508736(gen: 2320 level: 1) seems good, but
generation/level doesn't match, want gen: 4945 level: 1
Well block 25329664(gen: 1363 level: 1) seems good, but
generation/level doesn't match, want gen: 4945 level: 1
[...]
Well block 24002560(gen: 69 level: 1) seems good, but generation/level
doesn't match, want gen: 4945 level: 1
Well block 23953408(gen: 68 level: 1) seems good, but generation/level
doesn't match, want gen: 4945 level: 1
Well block 23904256(gen: 67 level: 1) seems good, but generation/level
doesn't match, want gen: 4945 level: 1
Well block 23887872(gen: 66 level: 0) seems good, but generation/level
doesn't match, want gen: 4945 level: 1
Well block 23871488(gen: 66 level: 0) seems good, but generation/level
doesn't match, want gen: 4945 level: 1


Thanks,
fandingo

On Sun, Sep 21, 2025 at 5:37=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/9/22 06:45, Justin Brown =E5=86=99=E9=81=93:
> > Hi,
> >
> > I had a pretty bad power outage that fried my server. I pulled a Btrfs
> > HDD (1 drive, -d single, -m dup), and I'm trying to recover it. The
> > HDD works fine -- the LUKS volume unlocks, and I can dd read from it,
> > but the fs seems to be in bad shape. I've spent a few hours
> > researching, but a lot of the information out there is really low
> > quality. I've tried to stay away from the really dangerous stuff so
> > far, but I did try some of the more benign troubleshooting.
> >
> > Kernel: 6.16.5-arch1-1
> > btrfs-progs v6.16
> >
> > [fandingo:~] $ lsblk -o name,size,label,fstype,model /dev/sdc
> > NAME  SIZE LABEL       FSTYPE      MODEL
> > sdc   7.3T crypt_media crypto_LUKS ST8000VN004-2M2101
> > =E2=94=94=E2=94=80cm  7.3T media       btrfs
> >
> > [fandingo:~] $ sudo btrfs fi showLabel: 'media'  uuid:
> > e2dc4c13-e687-4829-8c24-fa822d9ba04a
> >         Total devices 1 FS bytes used 6.10TiB
> >         devid    1 size 7.28TiB used 6.24TiB path /dev/mapper/cm
> >
> >
> > [fandingo:~] $ sudo mount -o ro /dev/mapper/cm /var/media/
> > mount: /var/media: can't read superblock on /dev/mapper/cm.
> >        dmesg(1) may have more information after failed mount system cal=
l.
> > [fandingo:~] 32 $ sudo dmesg
> > [ 7546.813999] BTRFS: device label media devid 1 transid 4956
> > /dev/mapper/cm (253:5) scanned by mount (6934)
> > [ 7546.814345] BTRFS info (device dm-5): first mount of filesystem
> > e2dc4c13-e687-4829-8c24-fa822d9ba04a
> > [ 7546.814354] BTRFS info (device dm-5): using crc32c (crc32c-x86)
> > checksum algorithm
> > [ 7546.814743] BTRFS error (device dm-5): level verify failed on
> > logical 27656192 mirror 1 wanted 1 found 0
> > [ 7546.814831] BTRFS error (device dm-5): level verify failed on
> > logical 27656192 mirror 2 wanted 1 found 0
> > [ 7546.814837] BTRFS error (device dm-5): failed to read chunk root
> > [ 7546.814933] BTRFS error (device dm-5): open_ctree failed: -5
> >
> >
> > I've tried a few recovery options, tending towards the more safe side.
> >
> > ~$: sudo mount -o ro,rescue=3Dusebackuproot /dev/mapper/cm /var/media
> > Same error and dmesg
>
> This means the corruption in not in the last transaction, but may be one
> generations earlier.
>
> This also indicates that some metadata write is lost, which is a huge
> problem.
> Not sure if LUKS or the HDD is involved in this case.
> >
> > =3D=3D=3D=3D=3D=3D
> >
> > [fandingo:~] 3s $ sudo btrfs-find-root /dev/mapper/cm
>
> Find root should help in this case, but not the default option.
>
> You need "-o 3" option to tell the program to find chunk root.
>
> Then use the bytenr it reported to pass into "btrfs check --chunk-root
> <bytenr>" to verify which works the best.
>
> Thanks,
> Qu
>
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > WARNING: cannot read chunk root, continue anyway
> > Superblock thinks the generation is 4956
> > Superblock thinks the level is 0
> >
> > =3D=3D=3D=3D=3D=3D
> >
> > [fandingo:~] 30s $ sudo btrfs rescue zero-log /dev/mapper/cm
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > ERROR: cannot read chunk root
> > ERROR: could not open ctree
> >
> > =3D=3D=3D=3D=3D=3D
> >
> > [fandingo:~] 1 $ sudo btrfs rescue super-recover /dev/mapper/cm
> > All supers are valid, no need to recover
> >
> > =3D=3D=3D=3D=3D=3D
> >
> > [fandingo:~] 4s $ sudo btrfs restore /dev/mapper/cm /var/media/
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > Ignoring transid failure
> > ERROR: root [3 0] level 0 does not match 1
> >
> > ERROR: cannot read chunk root
> > Could not open root, trying backup super
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > Ignoring transid failure
> > ERROR: root [3 0] level 0 does not match 1
> >
> > ERROR: cannot read chunk root
> > Could not open root, trying backup super
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > Ignoring transid failure
> > ERROR: root [3 0] level 0 does not match 1
> >
> > ERROR: cannot read chunk root
> > Could not open root, trying backup super
> >
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > [fandingo:~] 13s $ sudo btrfs inspect-internal dump-tree /dev/mapper/cm
> > btrfs-progs v6.16.1
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > parent transid verify failed on 27656192 wanted 4945 found 2607
> > ERROR: cannot read chunk root
> > ERROR: unable to open /dev/mapper/cm
> >
> > Same error for `btrfs inspect-internal tree-stats`.
> >
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > [fandingo:~] 4s $ sudo btrfs inspect-internal dump-super /dev/mapper/cm
> > superblock: bytenr=3D65536, device=3D/dev/mapper/cm
> > ---------------------------------------------------------
> > csum_type               0 (crc32c)
> > csum_size               4
> > csum                    0x05e1f6bc [match]
> > bytenr                  65536
> > flags                   0x1
> >                         ( WRITTEN )
> > magic                   _BHRfS_M [match]
> > fsid                    e2dc4c13-e687-4829-8c24-fa822d9ba04a
> > metadata_uuid           00000000-0000-0000-0000-000000000000
> > label                   media
> > generation              4956
> > root                    998506496
> > sys_array_size          129
> > chunk_root_generation   4945
> > root_level              0
> > chunk_root              27656192
> > chunk_root_level        1
> > log_root                0
> > log_root_transid (deprecated)   0
> > log_root_level          0
> > total_bytes             8001546444800
> > bytes_used              6708315303936
> > sectorsize              4096
> > nodesize                16384
> > leafsize (deprecated)   16384
> > stripesize              4096
> > root_dir                6
> > num_devices             1
> > compat_flags            0x0
> > compat_ro_flags         0x3
> >                         ( FREE_SPACE_TREE |
> >                           FREE_SPACE_TREE_VALID )
> > incompat_flags          0x361
> >                         ( MIXED_BACKREF |
> >                           BIG_METADATA |
> >                           EXTENDED_IREF |
> >                           SKINNY_METADATA |
> >                           NO_HOLES )
> > cache_generation        0
> > uuid_tree_generation    4956
> > dev_item.uuid           529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> > dev_item.fsid           e2dc4c13-e687-4829-8c24-fa822d9ba04a [match]
> > dev_item.type           0
> > dev_item.total_bytes    8001546444800
> > dev_item.bytes_used     6856940453888
> > dev_item.io_align       4096
> > dev_item.io_width       4096
> > dev_item.sector_size    4096
> > dev_item.devid          1
> > dev_item.dev_group      0
> > dev_item.seek_speed     0
> > dev_item.bandwidth      0
> > dev_item.generation     0
> >
> >
> >
> >
> >
> > This HDD is used for occasional archival, and it probably didn't see
> > any data writes in the week prior to the power surge. If I could get
> > access to any of the data, even old version (eg. that 2607 transid or
> > whatever the proper terminology is), would be very useful. Any
> > suggestions on what to do from here?
> >
> > Thanks,
> > fandingo
> >
>

