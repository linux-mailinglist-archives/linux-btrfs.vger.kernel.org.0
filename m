Return-Path: <linux-btrfs+bounces-11204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16345A24398
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 21:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EB13A2638
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 20:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618721F3D4E;
	Fri, 31 Jan 2025 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KGSa80TL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBB15B546
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738353619; cv=none; b=LdTVs913l5EAPou7bIMt3jQ8ieOz0NUChbPUFeBNtIHXPVkhNCsuwWBS++MJ3xdwRh3i5HT4umJlOV/5gzZ4GZUz8KRm+2K7oh1PUBMKrbNvpsaqDWKlK6lBEWrtyuE/urxWEpKlECF25FOTzTZ08/4jM6GHDaPKRglPP1ygqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738353619; c=relaxed/simple;
	bh=mESJj9WNZAGhoP88PwXyk6SgSBIq1RXBtiH16frMzTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsR8YXCFiFM7+az30j7lNWXP0rgFr+xN8BG8WA1YMO7hwSb/h/0L8tRu7J8XQ5FWaS4auHs5ucXfqgID4hQThWiLopfoEZT7nIeo6ymjZqFLyfbA/fGcKnxPxU7kUt/w6GCFHNl63ORFqnB/of/85AiyhBU/X+ltv5v0nTFdLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KGSa80TL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dc7eaaed68so3320709a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2025 12:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738353616; x=1738958416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1VEMyzp2lsoEGf8wTQK/Tt97K6OMqjZreNFMoOiXZ5E=;
        b=KGSa80TLg620yNDDIpK1ibI9YCILmNQyNtXmpVrItvS2hdLFYV2en0+MIJex2GOjpD
         4ZpoloHSWr7Rqo5gG+FjKGoN4esDP8hJAytm4Iu22VpZNsxEwBrJoxaSW1Bw4WIv1XrR
         4Vzz9Qs1aN1eJjKb5jd4cVfmiRtLmfsg+x0qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738353616; x=1738958416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VEMyzp2lsoEGf8wTQK/Tt97K6OMqjZreNFMoOiXZ5E=;
        b=sdUVbSL0nbvt6WBb82oAsxgAD6YGfXsgLo9uewMEqMVd+xS6GM3wuvK+ka2OIXIuYB
         Yp+GHNBUBoY+TGNTG2cpGu1ovNI63J+4P1UWyZeZVu3sHw7P7vz8lIB8Z5EidaL4gTNo
         eKXEgnuMcYoJflsKGsCqKcktI77yygZY8atZi/aedE6HO8ky33wpkDSHzsF50t2UnZ/O
         vlO8d1Ggt/TZUDQlNZOsmrQpbPjDbroNALIn5xk/xWdmptRYN/b+Sk/Klo8lyIHU3HC7
         eC4uV5AxtVbQgKsbt2NA0608xS8NiNPH6OlY/jl6O19CFfKebU9yAC0fQNUb0sLPsw56
         718A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ5A5z0nVVEVIPpnm0EEh1AUtuyO8ALQ4NBsrFcKzH6exBjq6QmNL09dnPOPbFHtSwwogMza3JhGzCag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqcpkKiFy1hsDcCifqx9H2V9JMQiXbmlsQjU/3YuO9aBnsqE/t
	3jGDhpMDiATiiPPO/WjNZg0x2Z4ync7AJ80HZPldM1gr1F/qp6GQPXvo6ddagbPHf8Tna2CQdoa
	imrU=
X-Gm-Gg: ASbGncvAm1hxNhBidTcAACPI1h5NoN2GIgTkuPXq8H6YT/MV9AJO9mStB+LmrZd4LTV
	G6Y8Qyt3tgCKzFrQjRoQxLslJKmnxeWSWNYdtibu1xG5POQM86w5qCPIu4Oo53RwYpOjmmTI2gG
	XP7VVIwAuMK94Oe1tOJNt9wf3kVcOoNBdK8kMi9n1OLf4afFI7RJqjOpsJAwp7j5MRBrINhzpna
	YmcZ7dHnGfj7U3kXFG0HbtxqiNLTJWA7aAF62sGFuJN2THX9cahjHCVz/y/NfCCefs5ZcajWbCR
	HDjRygUF0RVOhbe9f2RtVjGiljkvVmSGv839z0m1kdTttOZdz3VERMtUIY68cRWFNA==
X-Google-Smtp-Source: AGHT+IFQWScJxFO1CVCuHFUlmxNtOf581SLv+zPCWOWpSv0E1izLGiZqfYduISS6Pqi8KaeoNJCT8Q==
X-Received: by 2002:a05:6402:239b:b0:5dc:7374:2638 with SMTP id 4fb4d7f45d1cf-5dc73742737mr7209663a12.7.1738353615581;
        Fri, 31 Jan 2025 12:00:15 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc72404acdsm3338753a12.39.2025.01.31.12.00.12
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 12:00:14 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so3940662a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2025 12:00:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXc08xtVBlJGprpwx+8SkcfBeknCUPFkq09LCf8GsaqKpbUMvCMxIzgY0uFAGD7EUYR/MWuENLuhDw0gQ==@vger.kernel.org
X-Received: by 2002:a05:6402:2709:b0:5da:1448:43f5 with SMTP id
 4fb4d7f45d1cf-5dc5effcc33mr12325224a12.31.1738353612239; Fri, 31 Jan 2025
 12:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
 <20250131121703.1e4d00a7.alex.williamson@redhat.com>
In-Reply-To: <20250131121703.1e4d00a7.alex.williamson@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Jan 2025 11:59:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
X-Gm-Features: AWEUYZmJHVy_un_wj0EXjvnXlSLyiKtpaVCBTRVD7w7Khb3Vui_AFXvwFXKGqO4
Message-ID: <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults for
 files with pre content watches
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, amir73il@gmail.com, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org, Peter Xu <peterx@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jan 2025 at 11:17, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> 20bf82a898b6 ("mm: don't allow huge faults for files with pre content watches")
>
> This breaks huge_fault support for PFNMAPs that was recently added in
> v6.12 and is used by vfio-pci to fault device memory using PMD and PUD
> order mappings.

Surely only for content watches?

Which shouldn't be a valid situation *anyway*.

IOW, there must be some unrelated bug somewhere: either somebody is
allowed to set a pre-content match on a special device.

That should be disabled by the whole

        /*
         * If there are permission event watchers but no pre-content event
         * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
         */

thing in file_set_fsnotify_mode() which only allows regular files and
directories to be notified on.

Or, alternatively, that check for huge-fault disabling is just
checking the wrong bits.

Or - quite possibly - I am missing something obvious?

             Linus

