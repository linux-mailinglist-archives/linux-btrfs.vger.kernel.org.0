Return-Path: <linux-btrfs+bounces-19871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBFFCCDC1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 23:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C86F3026A87
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 22:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ECF2E5427;
	Thu, 18 Dec 2025 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liKa0KNf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCD02D7D30
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766095621; cv=none; b=dj0BT9eZOgqp1FbyAM9BW1MnaNTCZBR11EJABUGrzH0RmSTqE/CvD7JN5dZc3FoTGiJ97uzdfy1N7XtQjtb1jLRJ8wFQ3okYOUjPCicFaIBXlKH2zwoMsFo1zonL31GMzw5CSAIIryIVm/Rzysm5ApFwWD+eGYad49BBvHAoPkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766095621; c=relaxed/simple;
	bh=J4Nn2NlGfDoMoLD2jX96Gn59VTZ3FbVS9Sq+YlKTdug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8iEdJMnI+YW7dBSe3rYdKL6EryVSIZBGh2ATdBUSqziR+KE+SSWu12Ya5yFyeLiXMTpjUqygJmxZXS4DmSq5f4PAUTb0iuVaJTUjw/CjEssv3aES2VJGRBiSig+kzbXHG5giGrLjRbrjEFSrg4KtvGWUUYA7RLZPyjWnVs75Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liKa0KNf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso8238685e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 14:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766095617; x=1766700417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCWNyqqNvxqk0sIuAi6HOTqP3nuQgibcAJ59og/NAJg=;
        b=liKa0KNfSTlpJ0iuaL+p+4S0MpSmTpX9aE6o7KTOJ4tWOjF/2WPsQTVt+WcI6RtCxk
         aQTODRmXd5geqIg+VVirxkzakC0b6jlg2gGV7YjMeD3uGS5G9wezTa5PzxHIL0A6Rbl0
         RgxtZDfCJsXR1MgSk+ahQCQA9+zMjQxyyEfwTVT/8gPfb//3SKWbw+RnVvmLfn8LSvax
         +Pk0ck1dkIIPqKfkHmaR3HFoJ+28UAb8em+W1IeQs/xEZi5x/v6sUtFYra83UrWCOQdq
         WwtOcbCZD5NoybFueDbdIW8mk6uEadc2PhTVvR2QhK09ab0IOiTLrkro1jx067TP95l5
         bbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766095617; x=1766700417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FCWNyqqNvxqk0sIuAi6HOTqP3nuQgibcAJ59og/NAJg=;
        b=OdouhNtRcgj4phMJGgLOGCcTqNjs7+D6fhNbbUu9jRxnw16cdump6pxejrR3Vv8BI2
         Jf0/H7k7l+pL40ao7aKGh7BwB6S6R+Ih4MnYUb50+L+TrtkQUZ8oLO8UR7HdHIDumHwE
         tTscqwVqGozlIam8APUUAMzQ5jseYTh7bvLStT/4ItQDBr/hgbcl5drdAu3RK96r99DJ
         0QyEOUkVwdP3FyHdajZRan3qN8gZDF5uHo90wUdEMNK4mTmm+bigvE1roTr/tJ3qTNWC
         rwT55yE4SA7cSPwjngLeSVW98jcGpJZqgKrSlzzaWuoXVJqnAJPai2NRo4lYvHNTsNpQ
         +IgA==
X-Forwarded-Encrypted: i=1; AJvYcCXLXjEV6eBb8ewXGpy0f7G5uJhPF7DAG4NpDVvaPmNbIANWEGtl98K9GsNjGSNDG+OP3DtIowVjv90X/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVdWefipFDS5XLSzcv38LTX4iZWIn6rOqdGvdN9LBC7dn8eQ6A
	jUWOU6FfjohiXVPDbqkBGLTCBBzYp1rxOUt06Gd4y3uTf4ul4tTcB36C
X-Gm-Gg: AY/fxX4ArjHpotyTg8kiFmcW1sg2/8zrdRibD/wXCc+XgZly5mfCHuCkxejHMEgmKaZ
	8uEbh+sMjLJtJsFCNvzOQKcI0xTmV/zZV4if57+In+YzEumJwv9lHkxZ/xXT9zkxO3R8cw0po7o
	C0w3P12iAMuPBORbFXos1sigGuiJU2jXAJ0TKeO11/Df0ZpPDy/DwC1O9ClLPHZmEVPM4SgPtjb
	CYgyoInSAfE/Gn71LUCsuXrWHtPB316FraGjSCpyiGnWXHlQJ1I8YkZEFnO/WRLO1j7lWp81zeT
	rrEXAEGxZNbx2nnu33E5k/jlD55TpFqF2L+QXJfs4IhkYwNzI8bk7pjEc94Nf0gfcIg+W7nvYw1
	TG/zR/+/Jgo+6JvtKIxlbIYSG/PfYq+DfPV6PwDGQ8yRfK+manejhquILRaL/X6iL8QEExUvfBN
	vJoOOmxaQRwZObaqfBj2SLs/B6r6joEsmczyCvZNHnGx4fyMGvy0xq
X-Google-Smtp-Source: AGHT+IGTunC8kRSxjImDPeRC9HvKyQNV1Ibv0KtdSMjVnMShq1E8PEmRrIAevTE0VIl4mZ+C4NDiJQ==
X-Received: by 2002:a05:600c:3b8d:b0:477:7725:c16a with SMTP id 5b1f17b1804b1-47d1953da58mr7304975e9.10.1766095616415;
        Thu, 18 Dec 2025 14:06:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2723d19sm71561025e9.2.2025.12.18.14.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:06:56 -0800 (PST)
Date: Thu, 18 Dec 2025 22:06:51 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chris Mason <clm@fb.com>, David Sterba
 <dsterba@suse.com>, linux-kbuild@vger.kernel.org,
 linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] kbuild: remove gcc's -Wtype-limits
Message-ID: <20251218220651.5cdde06f@pumpkin>
In-Reply-To: <CAHk-=wjrNyuMfkU2RHs28TbFGSORk45mkjtzqeB7uhYJx33Vuw@mail.gmail.com>
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
	<20251218202644.0bd24aa8@pumpkin>
	<CAHk-=wjrNyuMfkU2RHs28TbFGSORk45mkjtzqeB7uhYJx33Vuw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 08:34:05 +1200
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 19 Dec 2025 at 08:26, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > One possibility is to conditionally add _Pragma()  
> 
> No. That compiler warning is pure and utter garbage. I have pointed it
> out fopr *years*, and compiler people don't get it.
> 
> So that warning just needs to die. It's shit. It's wrong.

True - especially for code like:
	if (x < 0 || x > limit)
		return ...
where the code is correct even with 'accidental' conversion of a
negative signed value to a large unsigned one.

clang seems to have a dozen similar warnings, all of which are a PITA
for kernel code - like rejecting !(4 << 16).

_Pragma() might be usable for -Wshadow, which is generally useful for
local variables (but not global functions like log() and j0()).
(I usually enable it and fix up the consequences.)
Things like the masked userspace access define which carefully
creates a readonly variable that shadows a user local would need
to disable that one.

	David


