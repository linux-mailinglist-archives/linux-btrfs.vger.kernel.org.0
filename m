Return-Path: <linux-btrfs+bounces-20211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDFACFF22E
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 18:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B16BA30514DA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1A4345CA8;
	Wed,  7 Jan 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S8VYZRHa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA7A34A79B
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805260; cv=none; b=r9d52uuq8HUku3hJ9H4RySFyNhi1gRVZcnq6fgs7eF4vmBi/YBkNPqPM4ML/C9LzQ6GJfFK2fsSTaORSI2ZgU+AD80tSBMHB8BJKrEXlzrhDHADxpqQTbreBuwMAi/ZYRLVBZQAeSX0ZCNJgmFa3s5Ky7m0WlVsaMtCW2PfSePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805260; c=relaxed/simple;
	bh=EEZX0gmeIxCJEW8Dixu8l3LleO3vQL/HwMgKwe8okdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMsaLNTOwbzvyFYYpzCjEQCPcXqX5mPE5BaLrTZ8aLmlo0E0ENLSu5dYCdqmy9Qb4FMaq8Jj+atE0/L4C+BFhpAYo597iEJy6l+U83K1qMqovRcrV+cvo+VYT2aWqN82wGIBm4iwTLaD8nz/SOS9e1AuQxzFjy2Ij6YbJiDX7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S8VYZRHa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso16929705e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jan 2026 09:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767805248; x=1768410048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C8ots2RRfPSvPCN8lZ4HPOZ03//ZEXekGHk6amm9afI=;
        b=S8VYZRHaO4Dp86DCfcRMMDjAvHBfXPFAlPsB8AM6fOcRQ4ZFtod/PaUyIlxAEHoFr9
         6dZpP6OwvOz48Ip1kXLbB2ePe/u2V9hddRWg56Usq5kuUlQ9RsAi6CQ52j08Eq3afCDW
         pBXL8OFM6wcPfzo6UGK54/NswA6nBHAvZHcSpFygs8ONHJMU9I1lfEloeVeFPqzzkBOq
         d/vLea2zM3x7mgTTrX30QSlRf9zEuYv1vOB2O+EdM332b3o2aek5S2n2f2gr09iy4yEP
         MwRuCZxijjvr4YwJf94I+LGEYzI1bbc392A4AdkWyjI5T4hMqP4JEaQD4iXMpcAOyl9j
         Au1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767805248; x=1768410048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8ots2RRfPSvPCN8lZ4HPOZ03//ZEXekGHk6amm9afI=;
        b=kJXOpfkrzn59hJw4gNIYvdSJelS2+kqJ9Jr1gGblTFwer2lxaqqhIZNJK8vec1ShbH
         ShpR4UTfDACponxewBKtlb8e7RK26ASJQFQ4MjCLTRHJ+iMZhQ5ZcQYzZqgwzgDdSBrU
         431ujmnYbjeQAPZrA66l60+Knpy2ce6QNolFh9vRCUfeZAqV8ucP/sT/a2GEB349XmND
         MYzTRHL/5BhwCDSQocUtssSAtNCjEqTy1Y9IVCSUOIRqiEvMX0iTK/ixCaYNVX66TKfd
         ZyGz2j+uqsK/EFEAQchtUKxnCm19tKL+S5HWldSxlAJkYtjjWkWFhiLH/1vvXW2ntcBV
         /5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCW8rMIK0V9r/Nf1SujC+e1dtRblimPLO5APutY970/E9gVvltZk3X2Q1PjXxorNUGkeQ+pRf5YKLVrmUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3su5S4JkbsjBHBaEElo9kgfpaQ6zKVYHehCQYo1iT7fYZcSJv
	hhfMDCEwFBp8xoJQMlLoRVtPxvwM6ra9+RV8F2EuV+Qvw5O6zmo+z8t0bv2MEGXlRQ7scSlQDqz
	j228ZGzrKotpfMQ4IPawx+Azwp1WjNhD5urdZCtllhA==
X-Gm-Gg: AY/fxX6XLNJGv1xycXzVkYZsMIS7wUUddfUQuRgoZOGB0bK+dCjI5E3Fzbdde2iPrS7
	OeywcMbo3hL6D3RtawHINzKiEGLjO1mXItGYPFeCmqLQAWim/MO+EQs0Iint3rkNuFcIW6coxme
	JxXa5MMg24Jv7wsVgOiSd7ES8flWRTt+6+zI1yCL+0v5uQMzUCUPyOSM6FVUNFG6aEWIDUYTu9n
	HKFqusf5ZRVE4HLvXvq12HOv04epeHLEXnVPbqL1tSn0/SvbuT9+ZnHP1xRuUWCU3AC496x1+cn
	S1XMuXfIHhI3QtgoIrL+tUYBKNHK3mKnyM5asg1ksjqXghslfHWv1v+GULoUKkOgMqJ0
X-Google-Smtp-Source: AGHT+IETeiBGNH/0hZMmPdJeCSLzHXrWmkcqwkgPyUAg+jnO3xwilcqEf2wnOAgHn8AoTL2PFvtXrYoMWXJdWGLvL+4=
X-Received: by 2002:a05:600c:1c28:b0:477:632c:5b91 with SMTP id
 5b1f17b1804b1-47d84b1a2e7mr46376105e9.16.1767805248044; Wed, 07 Jan 2026
 09:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113101731.2624000-1-neelx@suse.com> <20251118120716.GT13846@twin.jikos.cz>
 <20251124180904.GR13846@twin.jikos.cz>
In-Reply-To: <20251124180904.GR13846@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 7 Jan 2026 18:00:37 +0100
X-Gm-Features: AQt7F2qGF6ki6bg2E35T9TzutnneG1xFD1O8nB4C2L6Mk-DmjROcdKHXNL3donE
Message-ID: <CAPjX3FftzNN1PZd+UbJU7WVCCX+J8hqktP20fwOFJ=OYx1-eMA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: simplify async csum synchronization
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Nov 2025 at 19:09, David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Nov 18, 2025 at 01:07:16PM +0100, David Sterba wrote:
> > On Thu, Nov 13, 2025 at 11:17:30AM +0100, Daniel Vacek wrote:
> > > We don't need the redundant completion csum_done which marks the
> > > csum work has been executed. We can simply flush_work() instead.
> > >
> > > This way we can slim down the btrfs_bio structure by 32 bytes matching
> > > it's size to what it used to be before introducing the async csums.
> > > Hence not making any change with respect to the structure size.
> > > ---
> > > This is a simple fixup for "btrfs: introduce btrfs_bio::async_csum" in
> > > for-next and can be squashed into it.
> > >
> > > v2: metadata is not checksummed here so use the endio_workers workqueue
> > >     unconditionally. Thanks to Qu Wenruo.
> >
> > This looks quite useful regarding the size reduction of btrfs_bio,
> > please fold it to the patch. Thanks.
>
> The 6.19 branch is now frozen so this patch will be applied separately
> later.

Gentle ping. It seems this one has not been picked yet.

