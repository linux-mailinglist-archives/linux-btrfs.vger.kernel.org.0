Return-Path: <linux-btrfs+bounces-5031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B458C6F88
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 02:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183FE28427E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 00:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6224E110A;
	Thu, 16 May 2024 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a29R6tot"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BDE394
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715819512; cv=none; b=I18y2uMgNOMUQColwdqhoJZRxbAwYvFrRqn/Qrg4U2FndFDAGvirsGun63UjGlhjCYIH5GxfQhQSflJpH82aQakVR84MD32Cba6teMzmAw2VHozVHZZ6/6+HDTos3LHDCdJvqsSERXb0b+yfWTwSYeL61EL8LnizAedbBCRsHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715819512; c=relaxed/simple;
	bh=jEyumzpkWwYSzcvpMppl0gq1MCtH5yDL7td38D8uy+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBEPwJE0m31bCFI0d2p6ui/YUyZ4xt9rzPp2MEuZH6t3w7EYUnuRNVEUfzcrK+IUAAYIShYvCYmwVHbWpFIdvkqR0YSh13yI6rTfOpNtI+vrZKWTlEkXLX1djBykBiJRMEh/YUwHWpM/AfbCmsGUkY9Y7ia6nhwnLW/BS8dAk+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a29R6tot; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59cdd185b9so335728166b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 17:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715819508; x=1716424308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/1ZOEzEyRsWPFtMmIxhfNXeTL3zlVab8wCdGYOykNMk=;
        b=a29R6totSD2VtZoArZ7/dJcbsMtfjF+EZmMePLdJxX1puf+qHa+VkswVzbJt84WKtT
         FskzLtFCRRVURybuSyW/K4snYV4ubQWg+snBcQHPHPGUFc7I2EVF9hEHaBbEjN0MtWi6
         hO9rEWPD0+rc+XCof2ql06OnGHujbJ1BQ9XDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715819508; x=1716424308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1ZOEzEyRsWPFtMmIxhfNXeTL3zlVab8wCdGYOykNMk=;
        b=gwDrjI8qOklFxQIr0xOBpMoXdyDD+VXdW5OrO7AIt+TIOFwTxbGD1KBP2JFpVK88TS
         xzichtz9tCQeVUysw4g3TZxpaqiccNMBnoR3CMIzvhfTCJ1grW1SGF4+o3faCuWhiRTK
         NdtuxJmQjNewMHfrPSoYzvSCM1bfrNWGHbfhwR6GfMbhqAh8PE/eFYODqlLxIzbIOAIF
         KFA96IepxiyciMN/3BOvkAEJ3S4ktJ3nd+PYV2DJ7SN8HzCuFYi6MNPFd8V2z9vO3FJQ
         O2q/9kEpt/sDvtTESK/581+e6TTzsozKlqrB4Q8hkhl2VK+fErjZCJBLtjKZ7DnK5UiT
         HxZw==
X-Gm-Message-State: AOJu0YwcifdpUtRkvtqfyXU06Tl59F/zEszueC2SOrnb+NBEohc1Kz7D
	fEyOw55SeetUgLyjlM4AJQB2pKyDvfruSQr14XDocZwIXOjhBhXMSifuar/rnVZaK150nPeBXND
	09FGSgA==
X-Google-Smtp-Source: AGHT+IG6suXEPT5Ad5/T9Sbnb9PhslEtpg1H0nCuc1UqSy6Y2ormt9n9/DPoVrb2RMDyKOi5LZ90CA==
X-Received: by 2002:a17:906:fe0e:b0:a5a:5c8f:120d with SMTP id a640c23a62f3a-a5a5c8f12a7mr1135100866b.36.1715819508558;
        Wed, 15 May 2024 17:31:48 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a534bfb05sm653262166b.36.2024.05.15.17.31.47
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 17:31:48 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59cdd185b9so335725766b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 17:31:47 -0700 (PDT)
X-Received: by 2002:a17:906:f582:b0:a5a:66a7:47f3 with SMTP id
 a640c23a62f3a-a5a66a74d79mr966476866b.35.1715819507655; Wed, 15 May 2024
 17:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715616501.git.dsterba@suse.com>
In-Reply-To: <cover.1715616501.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 17:31:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com>
Message-ID: <CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.10
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 09:28, David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-tag

So I initially blamed a GPU driver for the following problem, but Dave
Airlie seems to think it's unlikely that problem would cause this kind
of corruption, so now it looks like it might just be btrfs itself:

  BUG: Bad page state in process kworker/u261:13  pfn:31fb9a
  page: refcount:0 mapcount:0 mapping:00000000ff0b239e index:0x37ce8
pfn:0x31fb9a
  aops:btree_aops ino:1
  flags: 0x2fffc600000020c(referenced|uptodate|workingset|node=0|zone=2|lastcpupid=0x3fff)
  page_type: 0xffffffff()
  raw: 02fffc600000020c dead000000000100 dead000000000122 ffff9b191efb0338
  raw: 0000000000037ce8 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: non-NULL mapping
  CPU: 18 PID: 141351 Comm: kworker/u261:13 Tainted: G        W
  6.9.0-07381-g3860ca371740 #60
  Workqueue: btrfs-delayed-meta btrfs_work_helper
  Call Trace:
   bad_page+0xe0/0xf0
   free_unref_page_prepare+0x363/0x380
   ? __count_memcg_events+0x63/0xd0
   free_unref_page+0x33/0x1f0
   ? __mem_cgroup_uncharge+0x80/0xb0
   __folio_put+0x62/0x80
   release_extent_buffer+0xad/0x110
   btrfs_force_cow_block+0x68f/0x890
   btrfs_cow_block+0xe5/0x240
   btrfs_search_slot+0x30e/0x9f0
   btrfs_lookup_inode+0x31/0xb0
   __btrfs_update_delayed_inode+0x5c/0x350
   ? kfree+0x80/0x250
   __btrfs_commit_inode_delayed_items+0x7a1/0x7d0
   btrfs_async_run_delayed_root+0xf7/0x1b0
   btrfs_work_helper+0xc0/0x320
   process_scheduled_works+0x196/0x360
   worker_thread+0x2b8/0x370
   ? pr_cont_work+0x190/0x190
   kthread+0x111/0x120
   ? kthread_blkcg+0x30/0x30
   ret_from_fork+0x30/0x40
   ? kthread_blkcg+0x30/0x30
   ret_from_fork_asm+0x11/0x20

Note the line

    page dumped because: non-NULL mapping

but the actual mapping pointer isn't a valid kernel pointer. I suspect
that may be due to pointer hashing, though. I'm not convinced that's a
great idea for this case, but hey, here we are. Sometimes those "don't
leak kernel pointers" things cause problems for debugging.

Anyway, it looks like the btrfs_cow_block -> btrfs_force_cow_block ->
release_extent_buffer -> __folio_put path might be releasing a page
that is still attached to a mapping. Perhaps some page counting
imbalance?

This all happened under fairly normal - for me - workstation loads. I
was (of course) doing an allmodconfig kernel build after a pull, and I
had a handful of terminals and the web browser open. Nothing
particularly interesting or odd.

Does the above make any btrfs people go "Ahh, I see how that would be
a problem"?

            Linus

