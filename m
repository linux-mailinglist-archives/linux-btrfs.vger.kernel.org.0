Return-Path: <linux-btrfs+bounces-13551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C234AA4E2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 16:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF201C07E05
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807BD25E473;
	Wed, 30 Apr 2025 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FipQNXhs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9919B25B1E3
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022417; cv=none; b=TGZPMzhutjOLp/8gmI3i/3BRUKioGU2Nf2pRA+ZMjwcKbvjw7x3ieuQP7mU/x8/B8A8LRANXE/O3++2Xr3AevoARwHQUGfDZt00xO6gSMq4y5YvHiUn+9QTqlogLGLDDJsXFtvSjpPD2dRnYwk4OatEYirrbggpUOa3B3buynLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022417; c=relaxed/simple;
	bh=emAB1rCDyJbLbduld98YJERRm2UpXootehW835nh1M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjrj/4cMkRhElfJ14dn38AOupRDuDGThv69ZPzlUGf4BYrLf5JEQgj2CHf78E1VaIrAPHA7I6oA6MFmStN4J4LcjG7mCnTT0a6y5hTgS2HqA9ZLh1fVGEE6fet7NKmA0GiA9xPtthEazBZxO++Z2gc4zOVPBqyuVVzJV/pTVMOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FipQNXhs; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acb615228a4so200184466b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746022413; x=1746627213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DinvXadkWJDd/MPH5TVPqJgiCAZstFOZlkyQeJrZvag=;
        b=FipQNXhsGUwLvrxonA+UiqkjWN3wmBGcfudhXP5pw6x8BHuIzsQ8RFy++arihqQZzN
         iCHM6undaNEu0PIBWUuQFkeeOPG97XC7IDqn7lWO6zpHvUdPItA6VPaZeWe8seC4tAKA
         o9OhNV+09gL1OxfFu0Asa3sl2Mp+ZYUJdQZXjnusD3fNrMPvJ/KW0H8i+JmP+5gxkI/w
         WSnwG2eeYrKvy5E0kvYiOfs+Hdbgl3UBnRf5nwWYQQWyXWhBPqMXK7gp00voeLHCHXGq
         Su5iClpi9rPGWe/aN0EiZd3RsdHHsYzOeYKt9pmdKanGssHlpEgxvTVDuKG7q0H2dTWG
         qS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746022413; x=1746627213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DinvXadkWJDd/MPH5TVPqJgiCAZstFOZlkyQeJrZvag=;
        b=HGOZaBF96ZXQXOZzH1ZpoBczTxklFVUFlQzgJPpdkgG223LlQXYzW9dkXq24cRW1Er
         Le+LrMcJU7sNSfmbfsFuHl2ayLBpvTpeKeXSpKCAdIxLQ3VKgiqr/Xj05eRqLt5cTJ38
         rQ+eIPoC2z7PptbqcNmOpx1p9zkVm7IFlUIltV9hd4ZGu1/zhopdjvvmqO89/Wmpa3ai
         YI1WBWFQ/QHjs/2ucWaOCnDvuDwwTgFa+eLFKcxZWXuHEOvTxfnrI9RU/XSox4l/DruQ
         kg+J+o+Mq6xjdg6dS4r/XT5U+veQ6tkspCdTTyBXX6RcQs8kOoqqsOHh7PLVbF8MnLLv
         crqg==
X-Forwarded-Encrypted: i=1; AJvYcCUQhqdzy9yIVmBO7pNWtGVk3P1xLMVVJrZ1lytfZ+v4CJBI1X8gXzh65x5SHrQiqA0o4Dz3RyS7mCa6fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJsu+ppYG0BnH4Vos9lx4jA47iIWz0ajS+eDKZuBFIyzTftpc
	okwskKJ00tToxrdPRUAub4SI8Xi10FPkV1h2Ac2AW36ma39cjmAy4Y/3+5H7nso8QjR3CoSweAG
	q7jVfhkI+o5bcalemhnb2MDmKts+x2HAkZItbLQ==
X-Gm-Gg: ASbGncv5pW9MbLqhGe+9/RsVT/Tl3S+G9aHQB4Mf8/A2DkdOK7NQ5EEqHlOIilMS/ug
	gVr3eKM2XlmS+2UHgPUVpwBQHf1vELmbCFv3bP6nEf2Q+h+C0gOs5wTIZg7r2JCrsFuP6Mn6lUY
	B8tCNqag5eMk79ffVrQU98
X-Google-Smtp-Source: AGHT+IGF8VVHxsWimGLaMgV51e98vMXf5Cvr8xjqnI4PAimqGU7YWa/LjUBXN00oPWRpNLZFjXgAkAp6ewpV3YI1ZxU=
X-Received: by 2002:a17:907:7ba7:b0:ac1:791c:153a with SMTP id
 a640c23a62f3a-acedf9d9efamr243537466b.27.1746022412785; Wed, 30 Apr 2025
 07:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429151800.649010-1-neelx@suse.com> <20250430080317.GF9140@twin.jikos.cz>
 <CAPjX3FfBoU9-wYP-JC63K6y8Pzocu0z8cKvXEbjD_NjdxWO+Og@mail.gmail.com> <20250430133026.GH9140@suse.cz>
In-Reply-To: <20250430133026.GH9140@suse.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 30 Apr 2025 16:13:20 +0200
X-Gm-Features: ATxdqUFDV39jRwOvsZi2WAdnQEIPfo7moTPeaZfWz7ORRcNj4p9JKmV3qppnkug
Message-ID: <CAPjX3FdexSywSbJQfrj5pazrBRyVns3SdRCsw1VmvhrJv20bvw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member field
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Apr 2025 at 15:30, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Apr 30, 2025 at 10:21:18AM +0200, Daniel Vacek wrote:
> > > The benefit of duplicating the length in each eb is that it's in the
> > > same cacheline as the other members that are used for offset
> > > calculations or bit manipulations.
> > >
> > > Going to the fs_info->nodesize may or may not hit a cache, also because
> > > it needs to do 2 pointer dereferences, so from that perspective I think
> > > it's making it worse.
> >
> > I was considering that. Since fs_info is shared for all ebs and other
> > stuff like transactions, etc. I think the cache is hot most of the
> > time and there will be hardly any performance difference observable.
> > Though without benchmarks this is just a speculation (on both sides).
>
> The comparison is between "always access 1 cacheline" and "hope that the
> other cacheline is hot", yeah we don't have benchmarks for that but the
> first access pattern is not conditional.

That's quite right. Though in many places we already have fs_info
anyways so it's rather accessing a cacheline in eb vs. accessing a
cacheline in fs_info. In the former case it's likely a hot memory due
to accessing surrounding members anyways, while in the later case is
hopefully hot as it's a heavily shared resource accessed when
processing other ebs or transactions.
But yeah, in some places we don't have the fs_info pointer yet and two
accesses are still needed.

In theory fs_info could be shuffled to move nodesize to the same
cacheline with buffer_tree. Would that feel better to you?

> > > I don't think we need to do the optimization right now, but maybe in the
> > > future if there's a need to add something to eb. Still we can use the
> > > remaining 16 bytes up to 256 without making things worse.
> >
> > This really depends on configuration. On my laptop (Debian -rt kernel)
> > the eb struct is actually 272 bytes as the rt_mutex is significantly
> > heavier than raw spin lock. And -rt is a first class citizen nowadays,
> > often used in Kubernetes deployments like 5G RAN telco, dpdk and such.
> > I think it would be nice to slim the struct below 256 bytes even there
> > if that's your aim.
>
> I configured and built RT kernel to see if it's possible to go to 256
> bytes on RT and it seems yes with a big sacrifice of removing several
> struct members that cache values like folio_size or folio_shift and
> generating worse code.
>
> As 272 is a multiple of 16 it's a reasonable size and we don't need to
> optimize further. The number of ebs in one slab is 30, with the non-rt
> build it's 34, which sounds OK.

That sounds fair. Well the 256 bytes were your argument in the first place.

Still, with this:

--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -82,7 +82,10 @@ void __cold extent_buffer_free_cachep(void);
 struct extent_buffer {
        u64 start;
        u32 folio_size;
-       unsigned long bflags;
+       u8 folio_shift;
+       /* >= 0 if eb belongs to a log tree, -1 otherwise */
+       s8 log_index;
+       unsigned short bflags;
        struct btrfs_fs_info *fs_info;

        /*
@@ -94,9 +97,6 @@ struct extent_buffer {
        spinlock_t refs_lock;
        atomic_t refs;
        int read_mirror;
-       /* >= 0 if eb belongs to a log tree, -1 otherwise */
-       s8 log_index;
-       u8 folio_shift;
        struct rcu_head rcu_head;

        struct rw_semaphore lock;

you're down to 256 even on -rt. And the great part is I don't see any
sacrifices (other than accessing a cacheline in fs_info). We're only
using 8 flags now, so there is still some room left for another 8 if
needed in the future.

