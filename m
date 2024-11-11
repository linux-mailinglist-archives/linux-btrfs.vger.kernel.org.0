Return-Path: <linux-btrfs+bounces-9455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A7F9C490D
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 23:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F3C7B2CA9C
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 21:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1791BC085;
	Mon, 11 Nov 2024 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rbje527Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544F1B07AE
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361927; cv=none; b=uOm862AfErgUXqMUbzQzYyTt+hhagWLxWQBCesU5k2dtUalPPGG5GhHK3q23Frcv0KFYAGQbxBks2h7027zBxzKr1HqLUZkH2gR9DoejxsnOcoUbjw81zrTbDHROruEoJi3UDswcfznjglUUUhbAUs5iEA19S0Q/IOQJMJKxhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361927; c=relaxed/simple;
	bh=q/zqChwYsrx4Zy33qGdG8SBhmqndzWb5CoC2UrWb3jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ke3RlwnFrfwSY7aS2bx2NELdZZS6ASjBaF8tKLbI2ww0oJHghlOUpeSXSV3uqfclEUfgF/6AfUeQeEKZ610VzyGFmc8NM+gkIjyJfCc24Klai3pOFzCNZpgk1RforplsFmYWnnYoZstYZnjBrcb+J1hEc9pp8OwZsa7C4fEEFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rbje527Z; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso6539586a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 13:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731361924; x=1731966724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L24fLxFCjFl/hQH9TQaBFKqNsNfJNVwL6H3wGfP4DSE=;
        b=Rbje527ZCqBTE0alugHX34GGw/kMo4XAuWSP8rS107ggibK6UXvnt8p4T9ax3yWyJe
         +vg6idUwSNwr1uosAeLKAb/3/lc3asJDsDXuFbQx9MXuc7ipeLedgksRpvo5yVispmop
         rLshiVru9NuLmxkzrB42lLmSk3BRlrLeNzNu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731361924; x=1731966724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L24fLxFCjFl/hQH9TQaBFKqNsNfJNVwL6H3wGfP4DSE=;
        b=MNE8h/qL1E+RM+xXwCZXzZo74t2lxYQKQ7uSCoR1lht+rZMWRDlc1NV3kTMNhXx9Oq
         2dRlphDfzKfH2r19oHIu5bDD3zo+hCpgzgnouhWpZ7vWn0ag7Gee/y5SAlQ5rmClY7jE
         jy2WNBnfjkBNbEuWtHiuLUuW9se7MWyEofLC4aIjHTvBvkHsABlpLzIC9yh0XTpOzuJh
         BfctIP3K4TGsZ/on0de+JwqCzq+jjwAvA/5Cd8QHP4EBRu9tOVjJQgwiVohxJryVvkua
         quuT79hqvzllOfLa7f2q6jiloe1JFxQGfC/uwJQA1TkkCMOUOZxuiQ+vHpE794GabXLA
         1rgg==
X-Forwarded-Encrypted: i=1; AJvYcCUhN1AFdmdVUc5VWpbsFjHiV1hSDyoewbvPEPimA4uDIpvroRzYEdWpKS9btkQzvGhltk1inPgVL8mRPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6XxlY9ch7EMEZXDx93zrJXvlDlCOmSX/A5T6qidQaK3MRKlpy
	HthBco4+banyH3kQOleoVSWpIO395pyTr0QAGegK8VAmLC0/j4OFVCaf3+9fCgaiRkjSrnQQMli
	YtUg=
X-Google-Smtp-Source: AGHT+IEryrTWFPZb3CwwKwhb+YkI+WErMXbqvXSK1q1XCT/oLQVxXT1N1naJ542jT1HDBKfnUZ3NKQ==
X-Received: by 2002:a05:6402:354f:b0:5cb:dfd8:464d with SMTP id 4fb4d7f45d1cf-5cf0a47260fmr13071374a12.28.1731361924015;
        Mon, 11 Nov 2024 13:52:04 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b7f2b8sm5314208a12.32.2024.11.11.13.52.01
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 13:52:02 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso848338266b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 13:52:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFGVmtX6qPbaer0C2pPUzjtH2PUazcjgF/eTZ0FI72w8rfbaQ9T9gFEqfsU0WFJkge+K74TPdlJuz9kg==@vger.kernel.org
X-Received: by 2002:a17:906:730d:b0:a89:f5f6:395 with SMTP id
 a640c23a62f3a-a9eefeade4cmr1373427066b.1.1731361921497; Mon, 11 Nov 2024
 13:52:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com> <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
In-Reply-To: <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Nov 2024 13:51:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
Message-ID: <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 12:19, Josef Bacik <josef@toxicpanda.com> wrote:
>
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3782,7 +3782,15 @@ static int do_open(struct nameidata *nd,
> +       /*
> +        * This permission hook is different than fsnotify_open_perm() hook.
> +        * This is a pre-content hook that is called without sb_writers held
> +        * and after the file was truncated.
> +        */
> +       return fsnotify_file_area_perm(file, MAY_OPEN, &file->f_pos, 0);
>  }

Stop adding sh*t like this to the VFS layer.

Seriously. I spend time and effort looking at profiles, and then
people who do *not* seem to spend the time and effort just willy nilly
add fsnotify and security events and show down basic paths.

I'm going to NAK any new fsnotify and permission hooks unless people
show that they don't add any overhead.

Because I'm really really tired of having to wade through various
permission hooks in the profiles that I can not fix or optimize,
because those hoosk have no sane defined semantics, just "let user
space know".

Yes, right now it's mostly just the security layer. But this really
looks to me like now fsnotify will be the same kind of pain.

And that location is STUPID. Dammit, it is even *documented* to be
stupid. It's a "pre-content" hook that happens after the contents have
already been truncated. WTF? That's no "pre".

I tried to follow the deep chain of inlines to see what actually ends
up happening, and it looks like if the *whole* filesystem has no
notify events at all, the fsnotify_sb_has_watchers() check will make
this mostly go away, except for all the D$ accesses needed just to
check for it.

But even *one* entirely unrelated event will now force every single
open to typically call __fsnotify_parent() (or possibly "just"
fsnotify), because there's no sane "nobody cares about this dentry"
kind of thing.

So effectively this is a new hook that gets called on every single
open call that nobody else cares about than you, and that people have
lived without for three decades.

Stop it, or at least add the code to not do this all completely pointlessly.

Because otherwise I will not take this kind of stuff any more. I just
spent time trying to figure out how to avoid the pointless cache
misses we did for every path component traversal.

So I *really* don't want to see another pointless stupid fsnotify hook
in my profiles.

                Linus

