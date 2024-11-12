Return-Path: <linux-btrfs+bounces-9555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8589C61E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 20:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B4D1F231AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 19:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D90D219C94;
	Tue, 12 Nov 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RhxEt9Fm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4320B218
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441278; cv=none; b=QZyIbI4y8L1j65AknDmfRktsluqMBv80IlzoZswCi9RGJYuGs6HJ1kJrL9edb5dQ8dFM9EzAqqufWt4HUHOXB5t1ftvloko7km3rxYmzpK6JnGzqSCMycc7s5Ke5G/mNrVyXu/THW0rnYzwZ8ea92ntsbsl/HkYxqLmPpXyMjXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441278; c=relaxed/simple;
	bh=w5M4DdbV0JDQqGXDCjJMEXFd24rwLm/qJCT5r02ClmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2lVoSMGa+/4ufw6aSe2n+9+2sT3dNAszOQ1EdyEKFXcAtVJEp5MqIz9Oi4Px/Leu28KCLj2cmXRpJBfTdQg/t/Gq6fDI0z3paOLkAcSo3IudIK+lgQTUliOF/cjt5NncnkIvj0azA+RoQ0xUD8qg4wG8JHFPGCUdv5D/DdewJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RhxEt9Fm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso975647566b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 11:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731441274; x=1732046074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5b0rySYUL4FjfsS4jGUX3HJrYE8uK75+UecupTqejZA=;
        b=RhxEt9FmPo8St2zCKzhQ/hGs1H7OKOBkXI4LLWLqNbiuCswZA6ZThLG/JuI/Rr3u+5
         b7fyF8esgW9xVh2qbjES17yqj/GUbC7VYr8oSnipbmVLTHvegIjed6O3xNEWX6odCBgw
         gwb5N2SiyhBpBwCBrOl99QOtXWsttlJierXy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731441274; x=1732046074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5b0rySYUL4FjfsS4jGUX3HJrYE8uK75+UecupTqejZA=;
        b=qDZvTHqtBaTuOc/K0VK8TsQgepysMHvmsDFtDfVPhujVhfWrWJMtsNMxKSnufiz71D
         jEwHTFgNTRirpr3dcqgcJYYmb4yEktuXzVVlNE7iTYl83xx7VCqO23FZzlc52jko0Qko
         7fkLxJAJcAlM69zk1VxKYHhVrODE0bHTGqug5pGwdGPnm9rraLmmkKHn9uIbTDv6Fvmx
         k8at4oUaGswBpeO5QusbaIDyzbyv6jyRuV9hk/E9KyJ5E05yRvJs/PlAga541LHdvipC
         DbUHkAmpnzIKsDh9uTsy9gNQeJMJ4SimvjSs4d8g1OWJP/EeSJ2JWnqleXGnlnuDYc27
         RXNA==
X-Forwarded-Encrypted: i=1; AJvYcCU13z0oQ5eOvOQjhdE12mC23P9h/aPxMn42oxKGOSyxEfHv54e4MQmg4S5A/jYUEelS65Aw7jLlDsfshQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6HZdI27R/qertcs+fU+wfgsOmpLkbMV7MiIVInVPiV2UjLWBz
	1v5nz52SL5MzzsoWGJPXFhu0nrXBbKfoYHOPpoDEISwAqgL7BAyumhu/osD9sfm5ikYMWRWSVRI
	OAskjfg==
X-Google-Smtp-Source: AGHT+IFH2DAAovzd557J0o4tZmYoMuQ0MRxUzeKWJLS8cciNWqd0Hfno0AWz5mvET72d6IlPtvsQpQ==
X-Received: by 2002:a17:907:7dab:b0:a99:f283:8147 with SMTP id a640c23a62f3a-a9eeff25cb5mr1637135666b.27.1731441274411;
        Tue, 12 Nov 2024 11:54:34 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17b22sm755358966b.7.2024.11.12.11.54.33
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 11:54:33 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso811286366b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 11:54:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3qxS2/UcGRdStulZYrMCiBki4jFhWQWFMins2gOHu/JvjmwaKH9HJzr8k3nEbyo6U1SuTHyrg0CuIhA==@vger.kernel.org
X-Received: by 2002:a17:907:1b21:b0:a99:ff70:3abd with SMTP id
 a640c23a62f3a-a9eeff25d17mr1761977066b.31.1731441272860; Tue, 12 Nov 2024
 11:54:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <60a2309da948dc81e4c66b9e5fe3f1e2faa2010e.1731433903.git.josef@toxicpanda.com>
In-Reply-To: <60a2309da948dc81e4c66b9e5fe3f1e2faa2010e.1731433903.git.josef@toxicpanda.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 11:54:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNFNYinkWCUvT2UnH2E2K_qPexEPgrm-xgr68YXnEQ_g@mail.gmail.com>
Message-ID: <CAHk-=wgNFNYinkWCUvT2UnH2E2K_qPexEPgrm-xgr68YXnEQ_g@mail.gmail.com>
Subject: Re: [PATCH v7 07/18] fsnotify: generate pre-content permission event
 on open
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 09:56, Josef Bacik <josef@toxicpanda.com> wrote:
>
> +       /*
> +        * This permission hook is different than fsnotify_open_perm() hook.
> +        * This is a pre-content hook that is called without sb_writers held
> +        * and after the file was truncated.
> +        */
> +       return fsnotify_file_area_perm(file, MAY_OPEN, &file->f_pos, 0);
>  }

I still object to this all.

You can't say "permission denied" after you've already truncated the
file. It's not a sane model. I complained about that earlier, it seems
that complaint was missed in the other complaints.

Also, this whole "This permission hook is different than
fsnotify_open_perm() hook" statement is purely because
fsnotify_open_perm() itself was broken and called from the wrong place
as mentioned in the other email.

Fix *THAT* first, then unify the two places that should *not* be
different into one single "this is the fsnotify_open" code. And that
place explicitly sets that FMODE_NOTIFY_PERM bit, and makes sure that
it does *not* set it for FMODE_NONOTIFY or FMODE_PATH cases.

And then please work on making sure that that isn't called unless
actually required.

The actual real "pre-content permission events" should then ONLY test
the FMODE_NOTIFY_PERM bit. Nothing else. None of this "re-use the
existing fsnotify_file() logic" stuff. Noe extra tests, no extra
logic.

Don't make me jump through filve layers of inline functions that all
test different 'mask' bits, just to verify that the open / read /
write paths don't do something stupid.

IOW, make it straightforward and obvious what you are doing, and make
it very clear that you're not pointlessly testing things like
FMODE_NONOTIFY when the *ONLY* thing that should be tested is whether
FMODE_NOTIFY_PERM is set.

Please.

              Linus

