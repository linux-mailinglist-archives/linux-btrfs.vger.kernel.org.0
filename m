Return-Path: <linux-btrfs+bounces-9926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 325729D9F76
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 00:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92EE168AD5
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 23:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824931DEFC0;
	Tue, 26 Nov 2024 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6xCoSzi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B91ACDED
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732662582; cv=none; b=lPDMZBnt3jVY8WlCP0e6jxISrvaYDXVzTc6IiJStsESfcYGXK4A/cpn8rk3T0F+PV0FuUNDindgVkFB7ffRPHB50lD3eTd0454dBipRoMTCPwxdp/SWM/Ag1Qk9SiP6VehmlEFgicAEF35cSDGgOZGkU29SkuQ1F8K0wM+aRiVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732662582; c=relaxed/simple;
	bh=sZmY+CmpI1Oq/9817F5e10FA/AK91kXvlmO1Ek8+2zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGYBcUhoIPhglt0IYXC3LS2fu+CjmOWB6wRsz5um0fAhRRS27IW4/CQZthut/l7LnS5MKoxxTltMnIWYUPRgjDd95t51MvetIT71IDupAMaStbp+x3d0nwQDuBoOxleL8yQJRXyZait2V1pcIQ7+F89NkR+vemLHJaF5XiSd4NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6xCoSzi; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53da353eb2eso9593143e87.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 15:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732662579; x=1733267379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZmY+CmpI1Oq/9817F5e10FA/AK91kXvlmO1Ek8+2zg=;
        b=d6xCoSziX5eS2g9d7TUGHD9HmGOfMrrffdb2yO3FAkSQjb/1mYkofTI7t12mrXMQj3
         e8kZ+oSZjeoUdi9g7AvWY3aSoxeJHwMpFVeHoxdRV6CoQOgrWMINrNTyPki9o9fTP5xr
         FjvAvLiPdcD+/YofzAQKSViknAKEgC4gAVNYsMrQqT2KsXQKMhH5Hd0XULyiZfwv0usj
         uCU745dU6n5ckMR0jZ/+Yy6k2G/CpL3J5rm7KD3MCxk42uz7UhXFoHqZvCmF9HZtzUrj
         pqax2sJwEaEn/QkvGYdSZbZ3QkjDviUsG9e/txVzmm+HyZ5CFA8tQq5mccMW52QxK+kZ
         2GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732662579; x=1733267379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZmY+CmpI1Oq/9817F5e10FA/AK91kXvlmO1Ek8+2zg=;
        b=jPa4O6cWM7G/1Wf3/tgSDhcqD1gqjlzGBwOgVwCo0IREVQU8Id9UVcLiGKCLNJqozL
         R8/nI03/rMG/2FYVNZxv4VWVwtBjyJr+3CvAAK075/CYq8Yfs0tYAJrCdA2HviMstidf
         pP6FqMyMm4JBmQZSgUMYAVxoOgmKSVUbjytbcGVVb5d2U/G6lReosV393b6uw0EKpmOI
         Nd8hlsQ6t0Cda44jrVR7uiMG08WMd/Aa1R9qYTMvCmnqo+0iyIYv6VoQ2OnhAtdA3nDI
         n5GRLqkwK0gADuyZZkKQ9tHyiBfeyUFxJ9LVv+8LsEpUVrqSqViFJnjnlohRSmR7+QN/
         ZInQ==
X-Gm-Message-State: AOJu0YxugDIAoxNGf3JCV4APoK1y7wduf/bHrW01fLKIrj5or8yukS5v
	aYU3PkKFA6GmuB34TU2GC5BRhUfcLS8zMrA+yibDDjkv+/oB6pZRcjshhBDpBdPLIE5/PtAD6vP
	Ov6au6Jw8TlOBu7Fq2GrUfubF7wae462h
X-Gm-Gg: ASbGnct0PNa7LLZDEfoQ7iiftXa6BgQ56ysgeEkPL8pfAxxiUzJUOblARkFZeH8RBzf
	L4Bv/orjvf2ZNTzfs0v6Q3TwSSwUKWtCvkklhEwngzRvs4d+zf3EKUXra+QRfOwEO
X-Google-Smtp-Source: AGHT+IG+8d2G5pIUT0i6y/uPJ2EgGCi+TTKpTsdWn6juIRcJRibguM8qcmpNriI8zD+gLxNE0IftcXvdE0iB+idahpM=
X-Received: by 2002:a05:6512:2389:b0:53d:dbc1:f332 with SMTP id
 2adb3069b0e04-53df00d9452mr453243e87.25.1732662579104; Tue, 26 Nov 2024
 15:09:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFiC_bz7QpCE_bf0VdhV1x4NvQbgnxPDrtD=XOupPKA=N7-yZA@mail.gmail.com>
 <1748c8ff-30a6-4583-bdbb-b3513bc3d860@gmx.com>
In-Reply-To: <1748c8ff-30a6-4583-bdbb-b3513bc3d860@gmx.com>
From: Brett Dikeman <brett.dikeman@gmail.com>
Date: Tue, 26 Nov 2024 18:09:27 -0500
Message-ID: <CAFiC_bzov3zete3VabFQQMQ3rUS-TdHikNqRMUW_xggFmrtoNw@mail.gmail.com>
Subject: Re: corrupt leaf, invalid data ref objectid value, read time tree
 block corruption detected Inbox
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 4:30=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:

> Inode cache is what you need to clear.

Brilliant! Thank you, Qu. It did mount cleanly. Shame Debian's
toolchain is so out-of-date. I pinged the maintainer asking if they
could pull 6.11.

Is there anything I could have done that would have caused the
corrupted inode cache?

'btrfs check' thought the second drive was busy after unmounting, but
a reboot cured that.

check found the following; Is the fix for this to clear the free space cach=
e?

[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
[4/8] checking free space cache
block group 6471811072 has wrong amount of free space, free space
cache has 42901504 block group has 43040768
failed to load free space cache for block group 6471811072
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 1504346918912 bytes used, no error found
total csum bytes: 1466184264
total tree bytes: 2501361664
total fs tree bytes: 718209024
total extent tree bytes: 106008576
btree space waste bytes: 375584870
file data blocks allocated: 1512284389376
 referenced 1380845105152

