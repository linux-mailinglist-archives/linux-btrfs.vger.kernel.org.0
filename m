Return-Path: <linux-btrfs+bounces-4776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AE38BCF2D
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 15:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC79F1C2308F
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD4582872;
	Mon,  6 May 2024 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHVC+kQ/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964B82482
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002543; cv=none; b=Ic3zk/i+Yp8YD/vI3FEmY5SQGRJxdiOoEy47HkvYC8wXWmXDDsUOErbC+ebIAWIu7G9uklt9zcFraZNOnYRo0aVgaAGyCacluPhxnJ7pJbxLS/Jq1dEuDwaYBDJQwrmJlEF0dHL+PqA8b7sxpxX1pdjPJEfnDL4gkmw85HL/h6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002543; c=relaxed/simple;
	bh=F2C7sd7gmJfwQ5fuPNbS2gsh31Fbbn965YYhUevGSGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tait2EL6IE3P2w6GBQvi3lW9dyedv0XtGHvEgWvZR9Gx0wB8gpOw4NlufcLzBJDsb3MriTf6N6BUAj2lVamZlOZpbadeMxe1672OmUDJm8GxyAuy0l4GWMlwSuOyOlXnupiN/125ZYSoLl9PiWgMRShNUXKbuMA3NtckH4lgZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHVC+kQ/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59ad344f7dso340092166b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 06 May 2024 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715002540; x=1715607340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mW2nuYmmaPGmzInWdSn5e2Rcb6N9RpTG222R3gJBjvw=;
        b=RHVC+kQ/hQEQDKU4VRS7o4n2Ib+AspSN24I1N+kTBDQBLGEulNWhxfrN2CL3HSKH7B
         BxbCEI9zPqpoODcj2rQSxlW0s3Fm/EhPQaFI0Y0gJpst6uSUYYjQskfKa19OE5g0COai
         +KbW/SCymMfdIGcF0DF8rS/8lvuOGRXWtD38WuqNI8SYQ92GxbX0bFpgo5BJxZLTnxcl
         Sdd0ajWvICM3s5go8LW4KnZJIMpnF1xryPRsqt/dgahJZYzfixO0eDOl5tFHP12w+KIp
         fBOF03Gi37STsuC3q+awFseTnux5XoIFp16lO9UQS7V0oqlHjGkugBIDZVj5NCuVgrY5
         2daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715002540; x=1715607340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mW2nuYmmaPGmzInWdSn5e2Rcb6N9RpTG222R3gJBjvw=;
        b=GxvMpxeW95OlO++xYgfRZE0LKapTfosQIXTF4CvmUPtpio/2tWlP9TXNXcL8xz9ifG
         g4CLm5juZSA0W1MDw9bfBKO3BsKc9FjpjQHI4xB91Q18r7pAzGvqVP4PqApxCF5+/mXJ
         qhQ2vLLtYE5zvR6bip6V1rkhKZ3jxe2bO9KiJ8d8W966jnz7eZUIeaz2dOPHgL/w+KCn
         QYfqtVfur6D/gdyvc97XH9KkZUpd1MS+1CBtx3jTPrc+YYV/wfdMmJV12PSgSqZjPlmt
         SXDSMrFqt4XRZD/6atOglol8R350CWpqyLYvd21p0WrC3KM/Niqo80HpfAJyC8GlnFhc
         R0vw==
X-Forwarded-Encrypted: i=1; AJvYcCVrV39p0riwjkl+niBTTfDrQ00lp6FXx3FXxoLOfChRdd8pHa+W8JAQSy8Oiw5ajqKbhkCQWHGlfGXeDtCmhKOi+Q509NgmrbRTqs8=
X-Gm-Message-State: AOJu0Yxsz8hyr4uGLNPQIbAZGrUDnbJ0WRJt2WziNt8za4kF83XTaB3q
	geeC41T3jIV6toPScWROtnStyGVJa9HN5q1rA53DI+HGagsI/Nf4I6xGdR8T2wwBAoj/psyhcZ8
	QU1ICmSV3LHEkVqNLMXeKzgOqq2E=
X-Google-Smtp-Source: AGHT+IFQmTZNiO1rQX8By3xPPBFOQTxEbs9YBqHPBDBGOq8Im1OR4OqsdxrEUnXENswuNrgmEwshFsV0okRd4X6AUPk=
X-Received: by 2002:a50:c05c:0:b0:572:6dd4:2ff8 with SMTP id
 u28-20020a50c05c000000b005726dd42ff8mr6228447edd.17.1715002540254; Mon, 06
 May 2024 06:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE0VrXJhJT98yucUDDvWTbcdXczTM4Mhy2XCqZtp+H00FYJfkg@mail.gmail.com>
 <CAE0VrXJ_8ZYjnKs+DQo1bmh7PxkQ=J6cWss3Fci0L2__mZbxxg@mail.gmail.com> <2bcc9d83-2442-4b06-92e8-2006eb980c83@oracle.com>
In-Reply-To: <2bcc9d83-2442-4b06-92e8-2006eb980c83@oracle.com>
From: Yordan <y16267966@gmail.com>
Date: Mon, 6 May 2024 16:35:08 +0300
Message-ID: <CAE0VrXJksFYCHr_JscryWS1TYT9+QX9opmZ9Y_2Lanc_=oybzA@mail.gmail.com>
Subject: Re: btrfs-convert on 24Gb image corrupts files.
To: Anand Jain <anand.jain@oracle.com>
Cc: quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

NO, I have problems applying patch4, so its unpatchet

error: patch failed: convert/source-fs.c:316
error: convert/source-fs.c: patch does not apply

I just sent you a small problematic image so you can test it yourself.

On Mon, May 6, 2024 at 4:17=E2=80=AFPM Anand Jain <anand.jain@oracle.com> w=
rote:
>
>
>
> On 5/6/24 18:53, Yordan wrote:
> > The attached file which is a reduced version of the problematic image,
> > produced by removing all files and directories, except 5 of the
> > problematic files and their path. Then its filesystem filled with zero
> > file, shrinked with "resize2fs" to 512M and compressed to 7M.
> >
> > md5sum sda3.img.zst
> > 9eec41fee47e3db555edeaba5d8d2e9a  sda3.img.zst
> >
> > (chroot) livecd / # zstd -d sda3.img.zst -o sda3.img
> > sda3.img.zst        : 536870912 bytes
> > (chroot) livecd / # mount -o ro sda3.img k
> > (chroot) livecd / # find k/ -type f | xargs md5sum >files.md5
> > (chroot) livecd / # md5sum -c files.md5 | grep -v OK
> >
> > (chroot) livecd / # umount k
> > (chroot) livecd / # B/btrfs-progs/btrfs-convert sda3.img
> > btrfs-convert from btrfs-progs v6.8.1
> >  > Source filesystem:
> >    Type:           ext2
> >    Label:
> >    Blocksize:      4096
> >    UUID:           b3a78a9f-37e7-4ccb-bedb-1f800a6a5a19
> > Target filesystem:
> >    Label:
> >    Blocksize:      4096
> >    Nodesize:       16384
> >    UUID:           d7c77d2f-d470-450a-ba0e-b6567ad3f4b3
> >    Checksum:       crc32c
> >    Features:       extref, skinny-metadata, no-holes, free-space-tree (=
default)
> >      Data csum:    yes
> >      Inline data:  yes
> >      Copy xattr:   yes
> > Reported stats:
> >    Total space:       536870912
> >    Free space:        326238208 (60.77%)
> >    Inode count:           32768
> >    Free inodes:           32743
> >    Block count:          131072
> > Create initial btrfs filesystem
> > Create ext2 image file
> > Create btrfs metadata
> > Copy inodes [o] [         1/        25]
> > Free space cache cleared
> > Conversion complete
> >
> > (chroot) livecd / # mount -o ro sda3.img k
> > (chroot) livecd / # md5sum -c files.md5
> > k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chro=
me/idb/3561288849sdhlie.sqlite:
> > FAILED
> > k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chro=
me/idb/1657114595AmcateirvtiSty.sqlite:
> > FAILED
> > k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chro=
me/idb/2823318777ntouromlalnodry--naod.sqlite:
> > FAILED
> > k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chro=
me/idb/2918063365piupsah.sqlite:
> > FAILED
> > k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chro=
me/idb/3870112724rsegmnoittet-es.sqlite:
> > OK
> > k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chro=
me/idb/1451318868ntouromlalnodry--epcr.sqlite:
> > FAILED
> > md5sum: WARNING: 5 computed checksums did NOT match
> >
>
>
> Are these test results with the v2 patchset? Thanks, Anand.
>
>
> > Regards, Jordan.

