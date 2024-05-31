Return-Path: <linux-btrfs+bounces-5378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C1C8D656E
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 17:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50591C27003
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81603158DA1;
	Fri, 31 May 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="t6H2wckI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAA9158204
	for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168398; cv=none; b=pFTlYERu/73apc/VU2l3Ozru+olVwsSQnJrNKk2NU9rj6eyFE5dZpQAH16aexbmZZA0iOBxRskUxEOun0a1HLN8e6AuAQBjlZ7wyhyCGlOUrxRRDEd540Cq3s58hTA33to3udZSgORCsr6QpDsPVKGcYxI0o3zofZQ5i5AN+w2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168398; c=relaxed/simple;
	bh=89EDOMJSOZPM7qaeotu2KXwOuZ1roSv8lmpGRL/iW0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTAJc4lrCkC8PLzeM5YZi/OvmkeBIQZyV1vw2uYowzK2/KRnxNSwlYxjZzQ7/zL92iaP7i2NkwdCFIhu0NYYKbvA3Dy2y11GNdodX1yaWt7Vu6daeaJm78csuM70SEgzm0UdqUp2ptbUnTj8d6zcD6v9PCQfYzPw9hWJxEiZDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=t6H2wckI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-794ab4480beso153547085a.1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2024 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717168395; x=1717773195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHmM8thH3ZGD5+8DoCDLFLLec9NIZBIlZW/afOoWZkw=;
        b=t6H2wckIWSZwutOeD75htmD3nKfa2RxP8Y/aVLOBIVlT++Q/FrztSBEFCdEj27uvaS
         oi+5fyqiO4wJS403Nz8NZ4gqgX4OSw0dS9maGVUB5Yxy4SUMzRXn1TajAYeMqUkfmrUK
         qhFHGj5WnLTXTSuShQ3tZSQGaW6I72JtobvVJCYamMYuFm2UZQKQsAwWqEgN22s3oBlj
         tZWQ1PrZ/LorjiSEaqwE7EnKme9PWYUls2QeHa4DGG/4P3+sK74I2NoOQ3nENE4wpXZH
         OvrP+w2sQNM+OjEaNoZHgaI9yiIMtKuCVDaAm2r3EGgvCuIEkHdwt/Ew+X/c61CKCnJG
         Mt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717168395; x=1717773195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHmM8thH3ZGD5+8DoCDLFLLec9NIZBIlZW/afOoWZkw=;
        b=j8AWHGiiwzIUfVDXdi3FAN9jqazzjwVVPdk/G93BfBDva0Er6+IRVtFEoW/erv1oja
         6KjPFIE+u3jaNJ3IgSK726HJxh8dmzT74ZsCy1oHd0yTez28Ho3U/pST9+KB9BzZ2zfj
         EGiDOMXmYuAxau6s26gTmHdYa+4BZrTlB+MzMVC3ddtG4nD74HjDm6OnQM5nGpV5KoS6
         lOPC48vvWCZ1LGQy3UKUr50dArEGi95EoOQLc9MGY60OPPTBs1jD67RmqQW91f1mD9qs
         kx7HU0Snnl5blbp8a5J1r76l+vxrBqcsNzslkbzoMiOH+ZkwD3Lbwh8PZVBuzSybVAvv
         CdRQ==
X-Gm-Message-State: AOJu0Yx8YhRRokrcnbGeZ0OOpn695jHdZGYQLHZDl27Z1sn3eG1VV8am
	KQIxzF2POg97wBAk214KEoqsjTtdj7Q7nI2BR65TIF5D6A+mnDuyAmBmDb3KvJk=
X-Google-Smtp-Source: AGHT+IHEpANI2XAc4ckqyS6CQs4UzeI2xPzKM2G16SXu7MupCaK2xp3Gd+FpcDfS7hpD3wc2lhShhQ==
X-Received: by 2002:a05:620a:819:b0:792:ba44:7b23 with SMTP id af79cd13be357-794f5ee0b28mr199331885a.67.1717168395468;
        Fri, 31 May 2024 08:13:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f317863asm63659485a.114.2024.05.31.08.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 08:13:15 -0700 (PDT)
Date: Fri, 31 May 2024 11:13:14 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH RFC] btrfs: fix a possible race window when allocating
 new extent buffers
Message-ID: <20240531151314.GA2226865@perftesting>
References: <b2192936067ea7e82e7d5958c0aa6baf8c29b5d9.1717130599.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2192936067ea7e82e7d5958c0aa6baf8c29b5d9.1717130599.git.wqu@suse.com>

On Fri, May 31, 2024 at 02:14:11PM +0930, Qu Wenruo wrote:
> [POSSIBLE RACE]
> Commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
> allocate-then-attach method") changes the sequence when allocating a new
> extent buffer.
> 
> Previously we always call grab_extent_buffer() under
> mapping->i_private_lock, thus there is no chance for race to happen
> between extent buffer releasing and allocating.
> 
> However that commit changed the behavior to call grab_extent_buffer()
> without holding that lock, making the following race possible:
> 
>             Thread A            |          Thread B
>  -------------------------------+----------------------------------
>                                 | btree_release_folio()
>  			        | |- btrfs_release_extent_buffer_pages()
>  attach_eb_folio_to_filemap()   | |  |- detach_extent_buffer_folio()
>  |                              | \- return 1 so that this folio would be
>  |                              |    released from page cache
>  |-grab_extent_buffer()         |
>  | Now it returns no eb, we can |
>  | reuse the folio              |
> 
> This would make the newly allocated extent buffer to point to a soon to
> be freed folio.
> The problem is not immediately triggered, as the we still hold one extra
> folio refcount from thread A.
> 
> But later mostly at extent buffer release, if we put the last refcount
> of the folio (only hold by ourselves), then we can hit various problems.
> 
> The most common one is the bad folio status:
> 
>  BUG: Bad page state in process kswapd0  pfn:d6e840
>  page: refcount:0 mapcount:0 mapping:000000007512f4f2 index:0x2796c2c7c
>  pfn:0xd6e840
>  aops:btree_aops ino:1
>  flags: 0x17ffffe0000008(uptodate|node=0|zone=2|lastcpupid=0x3fffff)
>  page_type: 0xffffffff()
>  raw: 0017ffffe0000008 dead000000000100 dead000000000122 ffff88826d0be4c0
>  raw: 00000002796c2c7c 0000000000000000 00000000ffffffff 0000000000000000
>  page dumped because: non-NULL mapping
> 
> [FIX]
> Move all the code requiring i_private_lock into
> attach_eb_folio_to_filemap(), so that everything is done with proper
> lock protection.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/linux-btrfs/CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com/
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Link: https://lore.kernel.org/lkml/CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com/
> Fixes: 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to allocate-then-attach method")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

