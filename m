Return-Path: <linux-btrfs+bounces-17999-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 223E7BED6CA
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 19:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B291019C2B2D
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535D125EFBE;
	Sat, 18 Oct 2025 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tje0r4th"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C881C27
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809855; cv=none; b=TDAiik8PAOfZ4IncRHfPPaBXYNSnG0W/Q049I1BaGsaEiWdLm7Sv5L2NIyeVvMxblwOaLHeWN4kf8HbUU5yZH0F27OSY7CEBEqcNHvMv71hGz4ysIOn+N+lyMRsYVpIL+nCeAdpv5CiQ3NRWK5A1xTOQCcY5Ue9UQBUFSfLEUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809855; c=relaxed/simple;
	bh=FDsT7qTVUE5H0Vve2oMO6RSKaB4ZG4doezkUG2svuYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSrIMHFfA6D2n9H0/zy/voDJZMJVJog0JMZLxHpsJuQag83bOVyv/eImHiA+iRcrJyP+FIpaP7Y7htncQTIScfomo86gDDXhwd9qRlzqaTKPuM01ODvcm1iRBgbmsmbtCovyOmWQNX+KLS1sDF7Y6WUT/oBlMnwbHt+rBMoMXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tje0r4th; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47112a73785so22394775e9.3
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 10:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760809851; x=1761414651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDsT7qTVUE5H0Vve2oMO6RSKaB4ZG4doezkUG2svuYg=;
        b=Tje0r4thQxwhx+1vnlNJy5DPvgdDUGfW5Fx9PGl8t+Mlr67QKcp2T8yoxqKT8va7cx
         a+l3m0Ry9l4qztZfZCxSsbrJGpoUklmUkOQGlQpMD9oLX6G6BSDXCRndW/ZdqPK65yet
         FK4JoKXmHJ+BNM4A35jIP3bMakv/9RdzLjLbl8NhaoBvzF/aFmajm3cWGtnOeRlBehgF
         bYMrUyZ3iQyITK7V+Q+3u2xMm/eStUchme1ASKxZKzEM+o7FHT68OJX5+jRZbs1IaDQi
         wmBQw4BoemXR//wCz8z+ConV99hgeAvwEtGC1Ic4H3FQ47AQKkiqFgRXC/W3ZBI47DjA
         /5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809851; x=1761414651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDsT7qTVUE5H0Vve2oMO6RSKaB4ZG4doezkUG2svuYg=;
        b=F3oeo4MPv7Pwkxx+wIpSyp/dvPDw6jpxOrscrSJA5M0fE4H4/jjqzZm7WgYLDtvwO6
         FDOKmSkqwAlPrnSU04C412vDsphF/+rN5ydHb7s12I4WVahrwF5dFzx0UNqwsRLmheGf
         lCUNNR3+6LU0l9EC2W3KUtP5nBZvKDQP46HDRNP4nO0N2lI5b1sEv7DLuheWB8CVp0IN
         c/hm8yM6tRU8EmJJ7jXtHIwPgscTG4RrGpnHQwdMcLzjv9pinIuBvvVjw5d3pnItwJ7D
         wbp6U9OQDdVk2LMG/fnAeSanVo+79OURyxF5d8N2K4n/DuLifKtG90MqMsh+R57mZ/JJ
         r5Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWMHVW6UM82ZWRHaQqmnol0lrbawqcR+J6CHAek/f1DHhYReN3RSEiHdAdiB1QurI5smsOSBHhs3+lUjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2CGc0Z9MKn3hP9GBJw6W7ppoOdkVh+QbOACftgQAsbqFbFR3F
	ibDBKB4Odz5Y1X6Y2S09LsnyUL1u82pm12DiVf24Sd4IXwn09abXjiA3+UTfZdA5osNAagsCGzE
	bVgIfRzup/OfTaR53TXkn5NtF6VL2v8+kLoaXD2JOqMPcnHa48l1CvcU=
X-Gm-Gg: ASbGnctHb5cM1A2HG5Qk3WiVYKHheTO/B960OYfvr2bZRXQ9lIPGoXl8G7YVJbsVQTA
	9t+nX9iMyIaChe3mMtwUG2MgclVhbePxffVGm8w7zmug58HHzWs3dn+k/sbQXzB/xFjsn5TZITZ
	oQB8uoprFQBsPgWCT+civA/4Mps8yaC+6cYV5B84fyqQCRPAp+vkH3pCmTX1nJBJZP7NmPKU5rc
	+hF/IAgr95P2N4JFPllkRZ6iOMvLDeQREOUJ23weI6Cd2UGMkfjb4f1Aqtud1jDeJT2FtQnlA1f
	6bDKjavW6oKnwDqLmu4=
X-Google-Smtp-Source: AGHT+IFyUsUR7Ud7Qniu6blivQqElTLCY3z/K8jKhpm3cqIVrl3hL9a3g31b6KK3Me2J+RBFt6JZ4UjEaj05jHUiLTs=
X-Received: by 2002:a05:600c:871a:b0:471:14f5:124f with SMTP id
 5b1f17b1804b1-471179258f3mr53856145e9.35.1760809851422; Sat, 18 Oct 2025
 10:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015121157.1348124-1-neelx@suse.com> <20251015121157.1348124-9-neelx@suse.com>
 <20251017164314.GL13776@twin.jikos.cz>
In-Reply-To: <20251017164314.GL13776@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Sat, 18 Oct 2025 19:50:40 +0200
X-Gm-Features: AS18NWDhGkCi5h32iGgemtEKBEa889mqs_5LdEjLgW7dBnwIFVz-fPaLZour-N8
Message-ID: <CAPjX3Ffk5Wdbw5jUncQQKahDTA9_+OXpcUg3Hc4ifFCqdOxRHA@mail.gmail.com>
Subject: Re: [PATCH 8/8] btrfs-progs: string-utils: do not escape space while printing
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 18:43, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Oct 15, 2025 at 02:11:56PM +0200, Daniel Vacek wrote:
> > Space is a valid printable character in C. On the other hand
> > string "\ " in fact results in an unknown escape sequence.
>
> The space is escaped because the helper is used to print stream dump
> or tree dump where space is the separator, so this patch would break it.
> Unless there's another reason than esaped space is not valid in C then
> we can't do that.

The reason is fstests are parsing the output of dump-tree and failing
on any space in the encrypted filename. That's how I found the bug.
Namely it's the generic/582 checking the encrypted filenames, well the
btrfs part of the test as I implemented it. It's the
get_ciphertext_filename() function in common/encrypt. I went through
several iterations but I could not come up with any better solution.
Hints are welcome here.

Thinking about it again, this is also missing correctly escaping %
into %% which I mangled in fstests. I should have really done it here.

