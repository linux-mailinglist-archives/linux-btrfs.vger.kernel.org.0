Return-Path: <linux-btrfs+bounces-18240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C3CC045E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 07:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 461064E4F48
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 05:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EDF22259F;
	Fri, 24 Oct 2025 05:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJBH6avf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377926AEC
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 05:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761283110; cv=none; b=EnzHeZtj4wC9JouIYuafph89BmIHwCnsURfxfnsBB36nYGVClMkTrbsVtH/dxITuZKtu9M5hboSZXH9nHCaWg46iLu8oPhmmupxLAwjODrhaRS2eQxW+J/zr8w3P8Mc8YIRIKxQmZcu13a9nLLuVfxkNR4LNN+y43PQY6B1Px7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761283110; c=relaxed/simple;
	bh=mtcf6e6KOtoU3+8vG02qvoLQ3hdGuTnyu/EBKdGZUMI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GG1/BinbXb+zajJnBt5xEapTlTeKKDDVnIVktBkidOYP2q23wIGaqbEP356MFL3xlcDiZpYAFL4OS0LM6Ph7i+tWyIBe4lHTRyqAA8/i1TH9T1i5l+kBnNLNXqsiXUJvhfJv7LxGXSZROyoHxYsCkc+pxkyGB9YQ8w2TNiVL4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJBH6avf; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-93f11fdd538so68302439f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 22:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761283108; x=1761887908; darn=vger.kernel.org;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwrG/lEznCyg6zvm2DdNDWnFfiwiNaf/fYGePTantNs=;
        b=QJBH6avfTF41Svgb1BIqIrizIzKTCrkwTj6BOF8SCMHX0pBpRn1BZuJhPOBTc4txIA
         CLx3WUuVVh3qmuI3EgN1XzIuBdUL5nj3V5iuOXUDUDfEZOMMwx0sifetgnFHEV3JeCnz
         i5wPEhRO5dyE0YACIa5g7atW1SyZKZgCGmXO64O5DjDHWBs0oS8hSdOMYFu6msfBvyLb
         h3dAU+HBYGsuRGHDyGBW5I1cV1SU3i42t8azI91S+GqiklqpfTtGHkywA963GCbqi8k0
         4kdJgWJzc8LDKaRRcr08kcZGAy8987nEbqhmQhlaeBUfQYH28cnROTxmEy+kOZAIyyG1
         we1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761283108; x=1761887908;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HwrG/lEznCyg6zvm2DdNDWnFfiwiNaf/fYGePTantNs=;
        b=d+Lghd17aQzzQWzBpjfbDa4vHYf9E5gXxCpTikA7nw3IdV7665AaJ1FMYAxsfxWtOc
         ph/sDOX3umGRjIKV94ExsGK/lBrYc9g0XO51BRsqCHsUJB1Rtu6Z1K+aAjBNIz0Vh3if
         rxCu7lqKHCbL593qkKn3u5umNQZ7+jMHhpkN/vmCPcBLFFF2FYPTELS37/Mbet0dypfE
         AzxSKwT9C7KxbVfI11gn1S/CoBFDV+RKi8SkzrY8HB5ssbnvo/cPnKz0jaeQrymlUuDJ
         4sV0IlzBufrs7o/tJu4Cu1BtzC07jIzBHWVJh7iZ48NVuy/lEXKBgnWSqHUFiBcx67yh
         Aynw==
X-Forwarded-Encrypted: i=1; AJvYcCWt+OsvX48M6Mnv8SwqB4hfSW8a2irp0dZII9+B2QQSJzio+N/byDRshPhOh2KK/00QStxjYCFrKP9yuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwKQ2bfm0tMRQHOKxNa0GzxUEdnsIQG0dqBmNRaJmezhlFvmYj
	UagDu4cOa1JmZrVqwVY1l63BLG8xDhTNY7yTvQqqEV0++nj/xTV/0nt7pBwIMg==
X-Gm-Gg: ASbGncuGAfKccn/VrOQT3NgtRDFrm/2x3wityN2hM0svKZlxBISmADbyZNqrJTO7JCp
	lJCteC1rkAMf//wqd/u/o6iElVW8uVtD5JgcFa3Z60K7eOSFjV4Ab28cf6riyNmMgc0hz8f7Ivy
	X7sK9nwn41PtTV9IojTdGGqTckwg65DNCWEHxQNnIRAvBDs4yiRM4fB3FUcNWoD6OARymURP5r0
	RRUrGl70rgbfnKT6dQS3a5jwGW/hq3MEZg2tIenw2Sk9nK8xjV5vVkqcxRCYJBlxM8dJb+nSz1f
	+o9RWYKUVuGDv4QX1Zxug7aYcmjpqy3VouwBX4ny9e2xZ3fIfb3nRw6yRb0shd34HuWoiau9ii2
	KbX+OJS7Z9+YO6OSA7b5bDvjF1JJKBO2LR1wOpOpH2vJsRZFKIFliv3GpD8sJtEWPZnxInKLK0/
	GKmfU5p6MpdCtQ24GkvQjM5Q==
X-Google-Smtp-Source: AGHT+IGye2fYQVHJB5iejXKfUM9iCWWULBfhfG1kGHd63Kw0TWcdcF8O4ibMThUfQ2NMOi7cznQchw==
X-Received: by 2002:a05:6602:6423:b0:93e:8aee:f98f with SMTP id ca18e2360f4ac-94275525c0dmr158636539f.10.1761283108016;
        Thu, 23 Oct 2025 22:18:28 -0700 (PDT)
Received: from smtpclient.apple ([67.6.34.200])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94102dc99b3sm141695439f.10.2025.10.23.22.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 22:18:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Bug#1116067: linux-image-6.1.0-32-amd64: btrfs compression quietly stopped around 60TB in
From: james young <pronoiac@gmail.com>
In-Reply-To: <gcwabziwxb2u57m7tbku3wnqgsocdi3euyv7cx2yip5t7nyp2y@ncw4nxihp2zx>
Date: Fri, 24 Oct 2025 00:18:11 -0500
Cc: 1116067@bugs.debian.org, Salvatore Bonaccorso <carnil@debian.org>,
 linux-btrfs@vger.kernel.org
Message-Id: <5FFC8167-3F74-401B-906E-0DA5CE4FCDC2@gmail.com>
References: <gcwabziwxb2u57m7tbku3wnqgsocdi3euyv7cx2yip5t7nyp2y@ncw4nxihp2zx>
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
X-Mailer: iPad Mail (22H31)


> On Oct 22, 2025, at 10:03=E2=80=AFAM, Uwe Kleine-K=C3=B6nig <u.kleine-koen=
ig@baylibre.com> wrote:
>=20
> =EF=BB=BFHello,
>=20
>> On Tue, Oct 14, 2025 at 09:05:17PM -0500, james young wrote:
>> [... some btrfs issues ...]
>>=20
>> Any thoughts or suggestions?
>=20
> Last time I seeked for help with an btrfs related problem I was asked to
> share the output of
>=20
>    btrfs filesystem usage /
>=20
> (replace / with the respective path if this isn't about the rootfs).
>=20
> Maybe that would be helpful here, too.
>=20
> Best regards
> Uwe
> <signature.asc>

Good timing with this; I'm about to blow this file system away.=20

Overall:
    Device size:                   1.00PiB
    Device allocated:             48.46TiB
    Device unallocated:          975.54TiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                         48.35TiB
    Free (estimated):            975.64TiB      (min: 975.64TiB)
    Free (statfs, df):           975.64TiB
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:48.31TiB, Used:48.21TiB (99.78%)
   /dev/loop0     48.31TiB

Metadata,single: Size:151.01GiB, Used:150.10GiB (99.40%)
   /dev/loop0    151.01GiB

System,single: Size:36.00MiB, Used:5.06MiB (14.06%)
   /dev/loop0     36.00MiB

Unallocated:
   /dev/loop0    975.54TiB

-James=20=

