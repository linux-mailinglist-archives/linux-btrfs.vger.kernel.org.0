Return-Path: <linux-btrfs+bounces-14607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE699AD5CD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 19:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677FF3A7457
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF12D20B20A;
	Wed, 11 Jun 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3iojrdP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C31A317A
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749661593; cv=none; b=TYkTEmbcrcnIumGnPzX//XyM45jSn5JWH4IqjxW908TpEzoBexEYxLnW+qrV26Gb0Qg2N0YVv3WG+VIaNL6OlcOFOtUBUnQtvzOcginnB5Y00G+GBVeJjhI/4EjYmZ+BCuGDEbFarS2V2J78/vcTCpFpuMpL69vQt34XcxMCMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749661593; c=relaxed/simple;
	bh=3gHpvGwqxaIlI9D2AhlfpHWh6ZrquCnqbnGeAOXoWhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWOpocK2spk4ZqHxBMmMHREEgcj+JrD9uAXFFDf6so4Ep/AibhXlOJ18LkgMyuyQb8VU9gO8J4FiVN/O1+BN3/FGwMmqlzOUpaIE7u84WTTWBaqmJA6+RRZu052JNF12DfMx+UBeVg1ENYBt6tCX8eMRgUAQdV//Ws/QIhlpPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3iojrdP; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d0a2220fb0so9136385a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749661590; x=1750266390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gHpvGwqxaIlI9D2AhlfpHWh6ZrquCnqbnGeAOXoWhA=;
        b=M3iojrdPUZpMVOZzgysH9v/M1JLZbSnyxA/+1uzKfwODcITnNtkrXgU33mEf4qsV6+
         PZiod2+f050x/2UmghjBCn8MnuCpBdyhyCV066n2h8jo5FlRzkX5zoTuA/OrTcy3RAzV
         zYVJ23NOaH3L/IdXgbgVKe1AKmQhprwacxU1bSpZJSNgD7L5nH10thAZrBDjd6SVLBBq
         wVWHJtrMVcy22/T7wp43ahznbX5NaCuU62cQSsU1qvJxzOkiAWt8F3K3gR4J078iokbX
         3n1fftzsj0o7q+4t7mm4U8BZHcWiaTpZiwueGp5VlW+0d5xZAF7Ay4HBljYsVFZ34w/6
         /jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749661590; x=1750266390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gHpvGwqxaIlI9D2AhlfpHWh6ZrquCnqbnGeAOXoWhA=;
        b=SUqvyFfWt2gCZ0s6zEt9RgLsbKIgavZ9jsB1Qas/EzOrRu3t+aqiN1NIg+bMXqZJfm
         b2bwNwOi5oE0MNJRyqmFoZqvAjQfGiigqseuUq9U1Tq/X9W4EkzZdeZWC+LLBvKgI/xL
         H4a0QvU2G8NK6Bu36hjTNOEn6ULMCY36anA1Bin3TA+FxtMBcSwnVcNrtrJRL2onXHuK
         Nz1+o0E2B+dfJtXPm43KlI6gLWYbphe6R5GK818K9ZDrZWG8nbtNxjtH1NMUnsbJ1r33
         1IJSaaTv2AYKzuv/gDNhY0Ne2xhf3Lq0JuUr02U+YSd6yjdk/WAmQj+nunlT+yecJwcB
         DjHg==
X-Forwarded-Encrypted: i=1; AJvYcCWCHUDHCy+znfthfZBSiFLng//gUsg2q9m4N8N5JXl8E6vKxWMnOnd/JXbSqOpKhBI6teQV/9RHaLuFPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8kaVAbxCIQiLogRBTIIgX8R22M3tgkocwyrtDFpUVe2u4TYe
	aGcOsX9aOKoCMea0Ln6beWJCyALfHQS+w2oeV+ubV9FdjYJWu/o3JI8fQvPvWm4TtBlGyFSmdis
	Z7Io6ZbA/e9M8ArSVNXVUF8SWEqFDJfA=
X-Gm-Gg: ASbGncvUn3r4dHN1zZBRMk59vo9lWf4tyLvYUAXZ3dWqpzlENM6LW2wiaRI76cTvtvU
	IrUC5CV5M4VafMMqjmwttnLJyTIHm2byGyDsU9WBTkvB9jK+5wouWpp5zt3Mn15V0VQ/EnRNSgP
	TCzol2a7FnJ4ueFwqvSiKxs1NbIo+EfAEeSS5ZPB6CSWc=
X-Google-Smtp-Source: AGHT+IHXfbbiqy4ZXoEcN7iheZqKQdK94BfB1hrjxS5U22NChpDGcGjU0pJfpc1XzfjZFce6u2ZVlWJ7KEASqbUdqm0=
X-Received: by 2002:a05:620a:3198:b0:7cd:27e7:48c1 with SMTP id
 af79cd13be357-7d3a89971fcmr649014585a.48.1749661590302; Wed, 11 Jun 2025
 10:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521032713.7552-1-sawara04.o@gmail.com> <20250521032713.7552-2-sawara04.o@gmail.com>
 <68a7d14b-913b-48e0-be12-5bba0d17ea2b@gmx.com> <CAKNDObChsMqFAYK-QT8DmFEitFX+Pmi7ifGDbYe2GfnPnUr1FQ@mail.gmail.com>
 <af00227c-c301-4311-b570-47f4d404c499@suse.com> <CAKNDObAwjpNv1rJJ1LWis2Eh18QBi8O4Kfje45YZvsqiJa78sA@mail.gmail.com>
 <CAKNDObB25gQHWQEHQCQ1J6SOCY3KPH9VEpDdPjicvEveF8s+vA@mail.gmail.com>
 <3ba600aa-5a79-4fe1-9b24-a45c0a58965e@gmx.com> <20250526092100.GB4037@suse.cz>
In-Reply-To: <20250526092100.GB4037@suse.cz>
From: Kyoji Ogasawara <sawara04.o@gmail.com>
Date: Thu, 12 Jun 2025 02:06:19 +0900
X-Gm-Features: AX0GCFuf3n0G5LwmHIfiz5D0p5bUzvCAap-yU5mxdf05RdRoPLaff8Y5sWJ5EOU
Message-ID: <CAKNDObASz87-DgyBos9U76SYwdy5ns1Vm8OADn9SgFgWGKua2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: Raise nobarrier log level to warn
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, 
	josef Bacik <josjosef@toxicpanda.com>, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is becoming a different discussion than the original patch
content, what should we do about this?

Should this patch only output logs about =E2=80=9Cno barrier=E2=80=9D as a =
temporary
fix, and another patch will restore the log output?

I also think that at least the =E2=80=9C[2/2] btrfs: Fix incorrect log mess=
age
related barrier=E2=80=9D patch should be applied.

