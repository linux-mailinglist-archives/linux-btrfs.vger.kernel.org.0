Return-Path: <linux-btrfs+bounces-12986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4C8A87DD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 12:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A718717386A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E4A26A1DF;
	Mon, 14 Apr 2025 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZueIx7hA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9C26A0DC
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627251; cv=none; b=UzKy6bnd7NEGqULuRSqGh+cQLghHy1ZQV3gJ8GFu+nOjmPpk4wUMXbIpbwwUN4VUegLCZbZoXF+n/NUAIcGT4Paget1hM5vqSkvr24El8oF/UrAWiAzR4BKtnWszmzmWqyPO/4HA8iHG8epJU+vxPvWSFvGy78w78R1JLSGWCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627251; c=relaxed/simple;
	bh=dqf0/Fez6cPRacrEC6RY3Ne46rWSZClb3gt6orvL10w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jADNZtWdu0QlQAytZbrmmfv+wt/j1k3MXbPcCwliwePUB/7roFvXcgVI+FM+BqvzuihuNNrYb947sumCNxDgG8W1gyaNTEO1G4z7729xVKm/lXGTjH/JYLqd9qcblwg4x55cr3JVo7kR5XRLMgFQ2efF7Ql+NY3RtQZY+B3SmHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZueIx7hA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so7620462a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 03:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744627248; x=1745232048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZtZcp4Vlo3nVyWcw9UU+b27OjRAgb8WamNSN8GIWmw=;
        b=ZueIx7hA2jQHIFdp0zUqPBpnYhKjAU7PKsXUoSleJNL6wG9fSbp2VgcY249VobiC+s
         AXgVwPqOC9RvzQgRN2ev4EW34kYKVKvKkgO6dhWD5X2mUCAJGdczAcNqDSQFvg1d3++/
         CcYe4YyCfozz6/iLMOeYmdDLqmG7jgasF3VFpyJXuU0YcszSDyYMpA5SkPfe4NqKpohv
         ym0iHObyjA/dbF+zvCrWKB7iLdhkHJF+rJksf5UKUivQ6Fy1fsT7qZImSTOV1iX4Ci7n
         2VW6tfYrXiV1q3v2ztv+SGChSV/QyYRs6jJCpV8fD2aOi/R39pYGgB1rX/d4ArBiUbhC
         J+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744627248; x=1745232048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZtZcp4Vlo3nVyWcw9UU+b27OjRAgb8WamNSN8GIWmw=;
        b=cidWVNLOijuu0NzXacDO1GMmzwd3IDp4PPllmYAYQKX5m0Sbc56Tc1LGmZSZ3K0Fl1
         nrI/qukpNU/aiVbY2twMu5FFlBg0NeT/BVerteI3glli9J8CKjok9BmljVjva+Qo2za0
         IEivWvGEIxhYeiGtUDY+U2iZa17wrhDJ//+25q1e/Cw10WcDU68jtboCANLE/N7wfRD0
         tGQla0tM0ICy2lPtjUrxXZEgldTFmVVcCbMFPi6PWvYsEtHVKyXtdU4yJsXC4O8HizWu
         0YRuaKYXmQ+nb6SoJazOf1hB9OM+DZGDX6x3ziauBPL8PzxAPVMPzzobHsA6mSE/5Vld
         ORfg==
X-Forwarded-Encrypted: i=1; AJvYcCWncrEL6z3myNqX677gADa7uni5T1qScpY9dGOZBDNgUKU/otk+ih7BKhSsevCZotbweOlF5tgBTotzYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj9ShJprNYWB0YXDlNJyF2wChmegcj6m0hRAKttn3qLG2cn+7H
	S56ICX5Fc63kUCDaR38gQhN2pQlwVP5AYJ9VTttfi4f3c5vdneuk3ua+YJ1PbCeUj26Gv0PJh58
	PJ1OTCEvxleOY8kV40z8z8LMjSolkX4mRtRk=
X-Gm-Gg: ASbGnctUirYZ1h7yyRGt64QjAldMQwJSDdgxrvFiYVagkvAFeteFmTGIJ6QO2MeAYsZ
	QrteNUxYLsYdYpXVdPsqgZcs+NRfZF6hjEI6ib7WfigNcT5gC2TDW7WhUvmx+oKSQRs2gp11jJ1
	r8RcFBTIaIhBOAFUCvPvjG5IQN
X-Google-Smtp-Source: AGHT+IG4zWiXfG8H332r5Mog6X5i77NSsCJ1pVz1BygbfZWOG7JKImuuhdyxkNyCpPXbRehyxyiNPJZPgDBPiSRHHJg=
X-Received: by 2002:a17:907:1c13:b0:ac6:f5aa:87f5 with SMTP id
 a640c23a62f3a-acad3493f15mr883876166b.14.1744627248200; Mon, 14 Apr 2025
 03:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744344865.git.wqu@suse.com> <d66c922e591b3a57a230ca357b9085fe6ae53812.1744344865.git.wqu@suse.com>
 <Z_qycnlLXbCgd7uF@surfacebook.localdomain> <37e556c8-d7a4-4d65-81d7-44821d92603e@gmx.com>
In-Reply-To: <37e556c8-d7a4-4d65-81d7-44821d92603e@gmx.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Apr 2025 13:40:11 +0300
X-Gm-Features: ATxdqUGcgv6cleY7lhHrMGOnODZHpqgdt2K7rfed0ahV85hskkTPVn-kmNiMKxI
Message-ID: <CAHp75VdyLRQrnByZtPPL2sn9ucGWVkyZu-kBvZvvpr4P_tOTpw@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: make btrfs_truncate_block() zero folio range
 for certain subpage corner cases
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 4:20=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
> =E5=9C=A8 2025/4/13 04:05, Andy Shevchenko =E5=86=99=E9=81=93:
> > Fri, Apr 11, 2025 at 02:44:01PM +0930, Qu Wenruo kirjoitti:

[...]

> >> +    block_start =3D round_down(clamp_start, block_size);
> >> +    block_end =3D round_up(clamp_end + 1, block_size) - 1;
> >
> > LKP rightfully complains, I believe you want to use ALIGN*() macros ins=
tead.
>
> Personally speaking I really want to explicitly show whether it's
> rounding up or down.
>
> And unfortunately the ALIGN() itself doesn't show that (meanwhile the
> ALIGN_DOWN() is pretty fine).
>
> Can I just do a forced conversion on the @blocksize to fix the warning?

ALIGN*() are for pointers, the round_*() are for integers. So, please
use ALIGN*().

--=20
With Best Regards,
Andy Shevchenko

