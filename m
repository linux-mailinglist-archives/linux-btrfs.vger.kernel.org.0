Return-Path: <linux-btrfs+bounces-20077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE516CEE41D
	for <lists+linux-btrfs@lfdr.de>; Fri, 02 Jan 2026 12:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B72B43000DE6
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jan 2026 11:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78D22E11C5;
	Fri,  2 Jan 2026 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipCfHJYf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1F2E03EC
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Jan 2026 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351885; cv=none; b=lHN+cBVLqliy8uKDX0eskY2sibLsNankTbjX4rjrUUURrAYYM/Xfm/pv7U2BVXUcaj7NfKcBzQ/fvd47oEwerpj6GDw16teJKAKG7CLFkqXlyqNJkAAqU6tEXE/AoUXVDIzFxh0wzLYkHMMIgulLOAPDunkvZ/47qlEESKV5ETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351885; c=relaxed/simple;
	bh=wSApN7eIEmxe+ZlkFun1Wolx+BI8xxAaYv9APOnMXbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpyAz8k3ufIGIZ2WpN8+mvMMBFGlSjY5pHVWh/jEajpAyw2qpt4jqu2wdCa9h2EgkKVEJjnSFCDmBT0FX+tFG/+D4D0cU9V0vFJWgX+tYIIi0XCEBZNGkujYbV2ApVJdOIZON63A5gRu4cxIoT4V3ptOLNtgt5VDa6VgcrGhmg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipCfHJYf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a110548f10so42685175ad.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Jan 2026 03:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767351882; x=1767956682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIDs7EpZgwjKHQTJkjqicwJWn0vuoECrubEqmgA+6vU=;
        b=ipCfHJYf8oQoFqMJ+NDl0a9F86WRdEFeyHHJECOrCJTgF9zJ/8gSfv2wupCMMIxJfj
         eku/SNf83ymrhL/SQUYtzhPbgVk4ruSA1LYT9k/bKsYW9SrdCKgZevYG4Cg9TNfQwqoS
         caWuMb+pHVQgf1AW/BKGS9coLPWn9/MleoZ1hUJ6cuzG1lK59asRwBtVKq9C43ayEBWR
         qdj7iEyYMLFOU/K0uf6CjK8jVAxXEukfQluV/1sjZCjrJvwffOAohbgoIDdSsiOO13MX
         Ie2peETA/AJYICK2qlJpeNUpGfgbkOJ95hXdXg9xP1mWPAXH/MUYeYL6CVBcOSxhjMgz
         2WTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767351882; x=1767956682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FIDs7EpZgwjKHQTJkjqicwJWn0vuoECrubEqmgA+6vU=;
        b=tcSrgpVABucsf+3Ruik0sLYHZ5FHv1aLEd00C88XfvCTE3PhiZxdaMtUbp+mlDoKtY
         NdvuuORD9xHilVoVO5kAW3qR7Ohc7ewOQmzkCrxqMKSMVJsU31/65e7VS95pikNiFLSa
         Vl9Bs+uXjcn7maeyalksGjHkvBowqxvwAa5uujVtASz1WsfUXlti25kmoLluyhq4HN+y
         lu5sKdXc9lZsn7uAA0e78VcuShjKUbwQMsImTEztujsVoFnVUm1ofTY0Nw6/sbNw8uLU
         cNoUOFx1z3uUVDytymW3CWdgpNmyQuitCplKlAuMEDAAbJAGwGxNpyAgYTT/IDvgWfhn
         PUzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw06Hsoo1wCp2u3Vn8/HOVsfnbsgoHR1tXum/kf5civ0u27fSDgNMyMKljWgTCKDtVgRdOsmUWLNPFdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw404Bq1AUeO1IieC9RtlOxU+7/8o/OvmD4WCn9sFT0magWI5+D
	f0kIcqQrKMkIDZcrRwlnHIbu6D/S8jnAg0o9gP+XnKv00tRL2/jST8MZrWT598OWNV73nKQHV8b
	hxG4xuqvsCGk3Vo33dYpOI3xCAmiK4aU=
X-Gm-Gg: AY/fxX6fOixCx+EJSnOi0LjVLT/HAvIempWad6NNjbvggaWkbXxs3LB7x01YlV9tr4a
	NkKZ6I32jgi5B7BjrDrkdrSFW6u5klWfL9E/q8ibi2RmG2uvq4sgr6KhxOaC42SlGvLmRwxtECN
	vpCOA1Nzoak18RjlucjNSKhiGfqnKdRuWYBIxZ7S47bv1/r/6kA6IX0wh1fcmh2syCC0nCosIVy
	7BEQIsmN8MLZU3Nd9FIHQeRBMrAmt+XzIcMZgp7zH90cHGB6HFTMFuiR5w5hwEmvnsZFdI8NUle
	RxURta/LaHweu+5wQyMt9MwUwQ8oGH3Usa2KvgVuH4d5Cj8Qrt8BzsE++QExvwo/6xa8L2zTE1I
	ptjVg0sqmMvZ7
X-Google-Smtp-Source: AGHT+IEZHP2Tt0L93hKtfLRSYNZV76m0YyhGtrMg6HK8YOKF7WDdzMO7LFlzqH2gnVcYBfD5MuH9A9W3GVedPNVkD/I=
X-Received: by 2002:a05:7301:1509:b0:2a4:3592:cf89 with SMTP id
 5a478bee46e88-2b05ea19892mr15172023eec.0.1767351882060; Fri, 02 Jan 2026
 03:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
 <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
 <acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org> <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
In-Reply-To: <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Jan 2026 12:04:28 +0100
X-Gm-Features: AQt7F2rb7qQrF04KAinb0u8Ra4qw05S31gwaEul2jMZEj1pMA4QwOapz60W1DHs
Message-ID: <CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] overflow: Remove is_non_negative() and is_negative()
To: Nicolas Schier <nicolas@fjasle.eu>
Cc: Vincent Mailhol <mailhol@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 9:13=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu> w=
rote:
>
> thanks!  I think it's a bit sad to keep code only to make some checker
> tooling happy, but for now it seems to be the right thing to do.

Perhaps a patch to add a comment explaining Vincent's findings would
be a good outcome, i.e. explaining the reason it needs to remain in
place for the moment (even a link to lore.kernel.org to this thread
would help).

Cheers,
Miguel

