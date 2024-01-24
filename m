Return-Path: <linux-btrfs+bounces-1668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF6F839DF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 02:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D021C25656
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 01:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8DD1106;
	Wed, 24 Jan 2024 01:08:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A33EC5
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058528; cv=none; b=M//r7eZ9xRwlNk10UHiDHbbYa6Yj/3QwKiddQ4L37tiCo9ThY4lGzscQYhXEH9IA2QDSQLjD5zU92E9OO3e9uW35dHSwbIRH/w8b0XLIsXvRySVIi+xpP1VCp1ol6uMIkgrcVzFJ5rc1+yywLttau86kjw444Nf5WrYpkzD40BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058528; c=relaxed/simple;
	bh=hriCenPgeX9/jvm+Lx7AfQPyVlASuUSUbfNb2WiN4Bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpSi3zgShh78qnQLfWFtmzJj3R992bKZPsxvPPHarVKfrt6z8yHNCHVlG1HeTyTtqZbt4/GQ5fJ3mQgIt5gWNB2r7/cdoiV3filwGhBgqB+YP/ix2CMxcy7UqKQokW+qvgCNS6KVlBMLN4S2gDjMuhFHJGAgM5PgO6fL8chxZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a293f2280c7so511163666b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 17:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706058524; x=1706663324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4zDOp4VVOH4gDaxGr8TkGiQrxsAA22QqKSqzK2s94w=;
        b=dz9jotVP2aMbTAclh1QRR7mvpNKgI176Tb2Ke0gDwH9FOXHx7Yg28z16ssorxGGizx
         uczJBeE1x8J/iYM8XKxsyHcbZOmLxMloASbN3ykexs3ZBok9+oHdtwRu5eM5Xe7yQQEt
         EPnATSc9W1kN/gESKJcCHlAi/eRQqeTz5ol0TafKuZK26RBu3PNnV/E0sS1SHmtHb9M+
         HXYt9qFJke6/kGIb7U7wkY7BKab0P7x0LvhrmIOE8yVBdLe1l3jYshvQDpNOkURVBCYT
         SCVZZD1w1tbEsIgNvsifCJtroJCmvVgAtBiwDHsa0PjQvo1BE2/7HAUuk/NfSQZpzo6t
         0WKg==
X-Gm-Message-State: AOJu0Yxg7hEP4eiWI5yctfbWWZaKeXD8opx1ROYtB0syQ4L2QmQ9mojk
	tZJlwuuSphY8PEGD02OM9KUd+HHSIxVtGsyrvgMl4IeR7ZkkkfGn0wiCSFDjq3QecQ==
X-Google-Smtp-Source: AGHT+IHQURCrjvCnbJ3pvEdoZTuTq8VRaFSGR1aFdMBz7xRkqtMYaeSbZ5Dr4PbCkorQmTjEsyB89w==
X-Received: by 2002:a17:906:ae87:b0:a30:f774:e42f with SMTP id md7-20020a170906ae8700b00a30f774e42fmr193150ejb.302.1706058523687;
        Tue, 23 Jan 2024 17:08:43 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id tb25-20020a1709078b9900b00a2fc5d30717sm4230148ejc.65.2024.01.23.17.08.43
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 17:08:43 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso32824805e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 17:08:43 -0800 (PST)
X-Received: by 2002:a05:600c:c1b:b0:40e:a488:3044 with SMTP id
 fm27-20020a05600c0c1b00b0040ea4883044mr558326wmb.117.1706058523216; Tue, 23
 Jan 2024 17:08:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c3bed652c4e20c8a446fba371d529a78dc98b827.1705978912.git.wqu@suse.com>
 <CAEg-Je_OygqAdFoAV02PK8zaZm_4HhkvLz8-FQEK6ZnodYst5w@mail.gmail.com> <b12560b9-0fa6-453f-9bcf-94f06371031c@gmx.com>
In-Reply-To: <b12560b9-0fa6-453f-9bcf-94f06371031c@gmx.com>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 23 Jan 2024 20:08:07 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8jVZCESa++dr-LxuiyyT9v8vMLwyh1fJtZ2Ma-=rmEFw@mail.gmail.com>
Message-ID: <CAEg-Je8jVZCESa++dr-LxuiyyT9v8vMLwyh1fJtZ2Ma-=rmEFw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: zstd: fix and simplify the inline extent decompression
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 7:07=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2024/1/24 10:19, Neal Gompa wrote:
> > On Mon, Jan 22, 2024 at 10:04=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote=
:
> >>
> >> [BUG]
> >> If we have a filesystem with 4k sectorsize, and an inlined compressed
> >> extent created like this:
> >>
> >>          item 4 key (257 INODE_ITEM 0) itemoff 15863 itemsize 160
> >>                  generation 8 transid 8 size 4096 nbytes 4096
> >>                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
> >>                  sequence 1 flags 0x0(none)
> >>          item 5 key (257 INODE_REF 256) itemoff 15839 itemsize 24
> >>                  index 2 namelen 14 name: source_inlined
> >>          item 6 key (257 EXTENT_DATA 0) itemoff 15770 itemsize 69
> >>                  generation 8 type 0 (inline)
> >>                  inline extent data size 48 ram_bytes 4096 compression=
 3 (zstd)
> >>
> >> Then trying to reflink that extent in an aarch64 system with 64K page
> >> size, the reflink would just fail:
> >>
> >>    # xfs_io -f -c "reflink $mnt/source_inlined 0 60k 4k" $mnt/dest
> >>    XFS_IOC_CLONE_RANGE: Input/output error
> >>
> >> [CAUSE]
> >> In zstd_decompress(), we didn't treat @start_byte as just a page offse=
t,
> >> but also use it as an indicator on whether we should error out, withou=
t
> >> any proper explanation (this is copied from other decompression code).
> >>
> >> In reality, for subpage cases, although @start_byte can be non-zero,
> >> we should never switch input/output buffer nor error out, since the wh=
ole
> >> input/output buffer should never exceed one sector, thus we should not
> >> need to do any buffer switch.
> >>
> >> Thus the current code using @start_byte as a condition to switch
> >> input/output buffer or finish the decompression is completely incorrec=
t.
> >>
> >> [FIX]
> >> The fix involves several modification:
> >>
> >> - Rename @start_byte to @dest_pgoff to properly express its meaning
> >>
> >> - Use @sectorsize other than PAGE_SIZE to properly initialize the
> >>    output buffer size
> >>
> >> - Use correct destination offset inside the destination page
> >>
> >> - Simplify the main loop
> >>    Since the input/output buffer should never switch, we only need one
> >>    zstd_decompress_stream() call.
> >>
> >> - Consider early end as an error
> >>
> >> After the fix, even on 64K page sized aarch64, above reflink now
> >> works as expected:
> >>
> >>    # xfs_io -f -c "reflink $mnt/source_inlined 0 60k 4k" $mnt/dest
> >>    linked 4096/4096 bytes at offset 61440
> >>
> >> And results the correct file layout:
> >>
> >>          item 9 key (258 INODE_ITEM 0) itemoff 15542 itemsize 160
> >>                  generation 10 transid 10 size 65536 nbytes 4096
> >>                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
> >>                  sequence 1 flags 0x0(none)
> >>          item 10 key (258 INODE_REF 256) itemoff 15528 itemsize 14
> >>                  index 3 namelen 4 name: dest
> >>          item 11 key (258 XATTR_ITEM 3817753667) itemoff 15445 itemsiz=
e 83
> >>                  location key (0 UNKNOWN.0 0) type XATTR
> >>                  transid 10 data_len 37 name_len 16
> >>                  name: security.selinux
> >>                  data unconfined_u:object_r:unlabeled_t:s0
> >>          item 12 key (258 EXTENT_DATA 61440) itemoff 15392 itemsize 53
> >>                  generation 10 type 1 (regular)
> >>                  extent data disk byte 13631488 nr 4096
> >>                  extent data offset 0 nr 4096 ram 4096
> >>                  extent compression 0 (none)
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/compression.h |  2 +-
> >>   fs/btrfs/zstd.c        | 73 ++++++++++++----------------------------=
--
> >>   2 files changed, 22 insertions(+), 53 deletions(-)
> >> ---
> >> Changelog:
> >> v2:
> >> - Fix the incorrect memcpy_page() parameter:
> >>    Previously the pgoff is (dest_pgoff + to_copy), not just (dest_pgof=
f).
> >>    This leads to possible write beyond the current page and can lead t=
o
> >>    either incorrect contents (if to_copy is smaller than 2K), or
> >>    triggering the VM_BUG_ON() inside memcpy_to_page() as our write
> >>    destination is beyond the page boundary.
> >>
> >
> > Have we checked to see if this problem shows up in the other
> > compression algorithms? I know the change was reverted for btrfs-zstd
> > because Linus saw the issue directly[1], but I'm concerned that the
> > only reason he saw it is because Fedora uses zstd by default[2] and
> > this might be an issue in the other algorithms.
>
> Already checked, and new test case is also added (which you have also
> replied).
>
> As replied in the other thread, zstd is really the exception.
>

Then we should be gravy here. Hopefully this time nothing else pops up! ^_^=
;

Reviewed-by: Neal Gompa <neal@gompa.dev>



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

