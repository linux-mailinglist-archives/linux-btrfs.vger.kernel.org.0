Return-Path: <linux-btrfs+bounces-13786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A3CAAE008
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 15:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D8A1BA3E49
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FA6287503;
	Wed,  7 May 2025 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWyegGz8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F8205ABA;
	Wed,  7 May 2025 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623125; cv=none; b=WV3d1sgu4RUkSQoqotXOHGGWnQ7w/alKFzfxDxgm20xdhGDzCKK2jRPICBb7MFRsaLLiYxt84LYtqS5vZljdxTxdlaBm76aCw4T8+4OQV+6a7b4n+tJO+ZOEKZ9MDOqtWy1FmhkLTxMjEXQOkVM0lfPugFIsLiGKnKLADFUbtlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623125; c=relaxed/simple;
	bh=IjdASnf0P/3DHSY41RODYZYYITbHGHJgGhvIKy0pPT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0+YF4QGLkhsDqOIGl0Hh0bR/+VGe39w9dQPRApNYRMETeKRgOzIpX/eDbhjvz8SNfmVtDBAZ0/K9lX2Aa7Ag+QjQhscib2LmkXOCWQKa1lC9zMq1m6Aom/t11k+FNSE8S7Pyz/RBGO6cpPpLDn1/RqsfvgdWFHGK8GohdJY6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWyegGz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D6CC4CEEE;
	Wed,  7 May 2025 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746623125;
	bh=IjdASnf0P/3DHSY41RODYZYYITbHGHJgGhvIKy0pPT8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QWyegGz89X5jZ51rYT3wl2t/EpNI8TV6qPgqu7Ag4/hw0vZbgsCiOIWyNe5mS3taJ
	 Pk2UnR5APEzYRzN8jGZh9sHFKGAxD6W3xAZURMUWogNJOituz6E3DmInwVExbCyVGK
	 JGSrcuQbsou0jOMfVGMhkdrpU4QuGAnUnjfwkNfFi65ep/UVGNpie29T5E+sbto/H5
	 UXf5qG+IhHbOey9OQ39u4HcJ7YrRnQRYq5+PWUNNOJcKvngX0BByM7dey/ZUxDQ8nu
	 sEsv6tlsMTVe5h5Bn9Yy8OYJOz3YABNTyWNblvQ9PCCNH5k2qekivk7hv1OKgCvsY5
	 LwYCysIWz8/fg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f4d28d9fd8so9354032a12.3;
        Wed, 07 May 2025 06:05:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTyd3r/+NVl4nvmXejii6pmJ1tBnw2e7hNGx8GL+jsBcxce5JoMbsAU55xqF8gxi1QnV1QvCd8m24QIw==@vger.kernel.org, AJvYcCWlh2j7yc4+teXDlkBLuGTbclYTWXX1I086YAOmHTl1XZP21Q3xyLjDzBxzETS+vF6TuFMlfTXwJB/G4Cnz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc7M+zhAgkq8yCRyYZhY+DZbZlMnSremwJr4R9AlzXG0zsP+B7
	7yDoysO44SwDaYoKgqBLUxYfDbdjC7OKfxomaeHiWTR3g5Yp1kKMwlA5KFqrCSP5fgtGKhCULO6
	6rVQt6OjYrk1zLmZK4+fPAnx4ytk=
X-Google-Smtp-Source: AGHT+IEJ/CaibXN6mzdK18KZL+vw3DGBUuRON4oUk/6Aj/iyvTAHbQ9DWHAfTSecBW+anB4utFQiqDadOX46QXFdPQU=
X-Received: by 2002:a17:907:868f:b0:ad1:d063:f326 with SMTP id
 a640c23a62f3a-ad1e8c91302mr333121466b.29.1746623123820; Wed, 07 May 2025
 06:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0B1A34F5-2EEB-491E-9DD0-FC128B0D9E07@linux.ibm.com>
In-Reply-To: <0B1A34F5-2EEB-491E-9DD0-FC128B0D9E07@linux.ibm.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 7 May 2025 14:04:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7PqVRnDuooSr6OhvUQ3G5V2gq6VEDpqTqNX9jHmq97aw@mail.gmail.com>
X-Gm-Features: ATxdqUHY_FiOpTMf6FgP45M2NeW-CWyjYlECDizMemJa-649cnX3uHFZ9HE6m_A
Message-ID: <CAL3q7H7PqVRnDuooSr6OhvUQ3G5V2gq6VEDpqTqNX9jHmq97aw@mail.gmail.com>
Subject: Re: [linux-next-20250320][btrfs] Kernel OOPs while running btrfs/108
To: Venkat <venkat88@linux.ibm.com>
Cc: quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	maddy@linux.ibm.com, ritesh.list@gmail.com, disgoel@linux.ibm.com, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 10:02=E2=80=AFAM Venkat <venkat88@linux.ibm.com> wro=
te:
>
> +Disha,
>
> Hello Qu,
>
> I still see this failure on next-20250505.
>
> May I know, when will this be fixed.

The two patches pointed out before by Qu are still being added to linux-nex=
t.
Qu reported this on the thread for the patches:

https://lore.kernel.org/linux-btrfs/0146825e-a1b1-4789-b4f5-a0894347babe@gm=
x.com/

There was no reply from the author and David added them again to
for-next/linux-next.

David, can you drop them out from for-next? Why are they being added
again when there were no changes since last time?



>
> Same traces are seen, while running other Tests also.
>
> Disha,
>
> Can you please share the details of Test and the traces.
>
> Regards,
> Venkat.
>

