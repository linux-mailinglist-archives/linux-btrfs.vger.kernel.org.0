Return-Path: <linux-btrfs+bounces-16762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52E7B50953
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 01:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05053A1C05
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 23:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB7E28A731;
	Tue,  9 Sep 2025 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="bNBOyyaE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FFE289376
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757461201; cv=none; b=Tv0Z7CA4wUzFKX8Jj76xF4a/B15BW4DnBIjE22VXOU3asMdnbdOlvN1/8YG23w7cbxvsHHzPI531ICmZ3jON6KNp2Tpt14ja4LgqQ3ryFArQY1bnEhJrM0WSCbCC/AU8iDzbZoBPBPTTOzFGEGmr0CdVL5/snDPBXtZhJh1xYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757461201; c=relaxed/simple;
	bh=CXzV1J9b4X8/ZSQaMwpT4Uky3mv1jyuJJk+Az6e5mFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTCpLlptzTgdNHaiCUf7HgXl19lutF6I6pgsE9l0EB1DPMEfWBT9gY0n1VDKf1Rxs6s/UU2anx4Eb+tra71ZtGgke1PZgJhbuu/uei/DahH7X4jL5X36SX3E+51HTV1P+XTzuki9q2y3ipcFqMzQmnx61/QTJIgJAFAew+AVMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=bNBOyyaE; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-544bac3caf2so97022e0c.0
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Sep 2025 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1757461198; x=1758065998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXzV1J9b4X8/ZSQaMwpT4Uky3mv1jyuJJk+Az6e5mFY=;
        b=bNBOyyaEiWzi8iGcCJ4Rp8MJBDyjrC9WLMxrQZiXpBtGwCsKrzDn8112Shcdk0t3NV
         g4xOs0xONVByQErIgl64pWq/SUKntS7wnjwjFuDCgBul5+5yNVqtD4iWW0kAn1uFJpq1
         om25PX6scXJvBk//15krPqqhMn5l/NlLGN7i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757461198; x=1758065998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXzV1J9b4X8/ZSQaMwpT4Uky3mv1jyuJJk+Az6e5mFY=;
        b=QFBLFstUP3A17hKAvtp3/CQup/YqeW/7gjFFqdJ5Fu1c+3IJTgMt/qB+4/+U0klHnK
         ZFCJYzIBi15w2J2f9BL7bB4ryucZr3O8GE/YBg8dsGLDacGS0Ikfcbrzbj4vtNUGYq8M
         cACXuq3PXyQvdscq67XLMDE93XVFC1Pc/kj6Klw0dDpDHjiW1+bFXyKqG9zb3ZPcOQrq
         /B+OC0TpFrvD+vtVOzkl/d/SLKQYoQ7z/oBcPhb6l+9sSIsLeGcPuS/weIrsWmEgmoUU
         hAZLQmtHmLIKJ3PEuJC2OLLWsHPE4GPPk6eNFgO3844QCDu87sBiY5zKwd11LvFEvpFv
         +9uA==
X-Forwarded-Encrypted: i=1; AJvYcCWFRWYaFxuP7109TLR8QuujjXjdnlN6SnGOFAvgiejqdpCQvqpmBXsi8kWBTa2xpWK+hAo0qge1lWTJ/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94PJJqTBb3JO/asCmCKUuoAia+n3f6WhoBkYfd82qnqXQ/+QX
	+4N9CuJf1lZm8TM0qyDi/KY5Qk75swC8bEmovtXq642ZcAJgd52WQBHWWIKN3B+AMVLFvAsXZwW
	PNKmhZSAXla7P+xcujHpalxvIXPwogkr0rQJcE/hslA==
X-Gm-Gg: ASbGncupZLjG3XA84rLoYb3O1hRM5q0JJB7T10rXAVNip9bnuVVaLls3uZX+28wsXx+
	oM+T8AX7ra3QDR5PrLKxNUxU5kpcweJJydUOh1D3YX7B3TeZ3E2vBwccrsOe3Y/7Ewn713E9eg/
	HeknZvdTrcwft5YvVZ19IZWeoeV0qR10t2nAvABXBnBjBL7xOJ6tynhx6p+pDZUXbsCQ+2Qm6Aj
	z3PNZqj7NzCa1L4OlA=
X-Google-Smtp-Source: AGHT+IEIp2vYI6Dc5ZDWhG8JNtPTNs9smLCDF5tPVfQuxoQJpoqG35r+lFvhpFLpu0WppBPsv1K2mu57sosnAN/hZVU=
X-Received: by 2002:a05:6122:1828:b0:545:dc3c:a291 with SMTP id
 71dfb90a1353d-547a7344aafmr4544788e0c.6.1757461198406; Tue, 09 Sep 2025
 16:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0cc81bcf-b830-4ec3-8d5e-67afbc2e7c47@allelesecurity.com> <20250909224520.GC5333@twin.jikos.cz>
In-Reply-To: <20250909224520.GC5333@twin.jikos.cz>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Tue, 9 Sep 2025 20:39:47 -0300
X-Gm-Features: Ac12FXz3aXpRlYx3qCFGkt45W05GgIGRovy0Uu8BDfSs4f4R-BsawXSQhGvddUQ
Message-ID: <CAPhRvkx-72vRwTiuBk0WQPhpegBdvsFFtXi8Kfinzxa9bUmj8A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Avoid potential out-of-bounds in btrfs_encode_fh()
To: dsterba@suse.cz
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

On Tue, Sep 9, 2025 at 7:45=E2=80=AFPM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Mon, Sep 08, 2025 at 09:49:02AM -0300, Anderson Nascimento wrote:
> > Hello all,
> >
> > The function btrfs_encode_fh() does not properly account for the three
> > cases it handles.
> >
> > Before writing to the file handle (fh), the function only returns to th=
e
> > user BTRFS_FID_SIZE_NON_CONNECTABLE (5 dwords, 20 bytes) or
> > BTRFS_FID_SIZE_CONNECTABLE (8 dwords, 32 bytes).
> >
> > However, when a parent exists and the root ID of the parent and the
> > inode are different, the function writes BTRFS_FID_SIZE_CONNECTABLE_ROO=
T
> > (10 dwords, 40 bytes).
> >
> > If *max_len is not large enough, this write goes out of bounds because
> > BTRFS_FID_SIZE_CONNECTABLE_ROOT is greater than
> > BTRFS_FID_SIZE_CONNECTABLE originally returned.
> >
> > This results in an 8-byte out-of-bounds write at
> > fid->parent_root_objectid =3D parent_root_id.
> >
> > A previous attempt to fix this issue was made but was lost.
> >
> > https://lore.kernel.org/all/4CADAEEC020000780001B32C@vpn.id2.novell.com=
/
> >
> > Although this issue does not seem to be easily triggerable, it is a
> > potential memory corruption bug that should be fixed. This patch
> > resolves the issue by ensuring the function returns the appropriate siz=
e
> > for all three cases and validates that *max_len is large enough before
> > writing any data.
> >
> > Tested on v6.17-rc4.
> >
> > Fixes: be6e8dc0ba84 ("NFS support for btrfs - v3")
> > Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
>
> Thanks for finding the problem and the fix. It's 17 years old though the
> other patch was sent about 2 years after btrfs merge to linux kernel.
> I'll add it to for-next, with the minor whitespace issues fixed.



--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

