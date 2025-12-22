Return-Path: <linux-btrfs+bounces-19959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E38CD7482
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 23:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7C0C303AE83
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 22:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75668349B16;
	Mon, 22 Dec 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuILt5QY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC73491F1
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442300; cv=none; b=I2xG91zHJMYNugU/qeU9e6SUSl1sj3xDVmY/ciK3WBTK/CofW/c6XUd3iPawDdmFUGzXnFkfCq2c9sEa+bt9xpGjba26Kxi8H3ge+pSkaQscWx21uhVN+l5ptf1pJmSciCu1yc9w/GPqF+CJZPenPDzuKbAZ5j/mteb6vFcn5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442300; c=relaxed/simple;
	bh=t2mLLBvt6h8MFjkmzRQlmaA4RDpz8bVYxKkEkTxbYhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUQFs8BJDo9kdraM74tT0lnt7Jqh+NTpSn9I0rzn3q+BP/GZqBTwhG1g/s8LuEWUbKL2gG3QaecMzIL/gl2+TlFVQyPq8WWq3nUy2zQVEMcdV/PqyDuCGbvzdPkSYMeHC7lNdtq9xJckkwVp4UJNx97pY8x2jVsRDkS7xsgllP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuILt5QY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-597d712c0a7so4504399e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 14:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766442297; x=1767047097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn/OAPJtWNCT0eie4rU3UF1I3TWQyxcji+TCrLJ8drY=;
        b=TuILt5QYV9e7+mbWBgmztZecbxPBnnUaLXxvl3J7//On60/URVJ8Q/GI3NZUrXjHmX
         QLGRdZ7Gf1EYCc4U+0sbB8EfgQGa4rGeT/sJGzTH8PJMGNLuOKmOM2IhO8HMpHBcHG4u
         f0IwgLC+SA9lwoXXX4nQ/KRX8uRjwajOETk1Kb+Yq7S9XXoCCc+1nLu/GHKQkdbY08l6
         mxkN9n7tQ2F6hTpqdRhdKM/DhiAJcJQe2blZusYD1dGpF2aZKxc96Yf5a/n8GNvsF9Cx
         zaPNi1OoJxdpQ9JDrl9XfJyWufDFbe5RlXk2ykFzVJQg66Bvgr7dcI9T5AKVevzx/sz9
         KDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766442297; x=1767047097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sn/OAPJtWNCT0eie4rU3UF1I3TWQyxcji+TCrLJ8drY=;
        b=Xj6P7QZCDPlBRurTmI7P97ru1pxopg1Mz9VduhArmX5y5EnhXkYyJvTv0jpialUJJM
         gHYnlJThZ+e0iD5n91W2vUeWPK1NQNCCKq+unAeP2qHEzkaPD/QBC3+5VyEMJ22WDJVE
         0txrbkcruzqZG3j3ZOngfct6OzxIS8ru7FQeC3y5wanu1tPQVYzBC85pMoogJoCx7HaA
         CMt6j4KWtGvBR5r+PzbnkmaX0ftv64U7lrwP1N4tRaOWmDa92GUf12O+ElwAD9wxHOy9
         22Lg/y53axWL2eU7Z2O8C6i392WbjC+adfi+QFL4UwPVBoT6ZlFPQyzJBBEmmBWBbfCC
         KKjw==
X-Forwarded-Encrypted: i=1; AJvYcCUq6xfyOUAUtgBpFQ/GfUIJPJAw/SemzxFEPNayzguIoY0mSc8XQI4x92rhO1k8SFPuWBpoNg5DbRhJdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTVG2pk6MYCs4X9s8YWtx8RxE/eETd3Wmqh0i/zdnozKm9dH+J
	/LF+9sbBOXLMsoK633G/Lt8UL97LZukY0t48tV1WIRVQlRWfhBKyx3FJ
X-Gm-Gg: AY/fxX63WFH1erOHsk/Cdz1WHIl7WLFUefjiKRiOMlLrKmxLD/mqX7hvfBhfvfBSwNc
	7qGAoibaN1nvU6GIuxXtKmovehq3kwIvPx7Jx6OT2jfwhBE5ikAx681OBnqm58Ay+bg4bgVnAF4
	pAkKPNNoxq3hfs7GT6pJnCQV3uSTahqVFWB7IjwHxZgfXOj+OSyZ3G3uWF/hluWOYQPbLuB0WNr
	Wj3FpcThReagvcIWQX8qUCezNj9UjYMvInMIdujmIA4s2/zUe7ppSX2L9fTQ6PyzT7mvA31OZ6y
	9r8nerx9E6axHRWglT0GkgIANCM0+heu51ZUMNuO4eXgbr/SWIg4jzExHkUq6mew46ItGoNEkU/
	DL/RnVRBKkdaxHRFOTMGm3JGNXqVQF3WkHnfUTXH0xPShU3dUjTUbgWERPISnNnz3HE/TpW6TZk
	LBIDMKabAR4y7kVBNhTYM=
X-Google-Smtp-Source: AGHT+IHKzpn400t05hIadcb+Wh63yw6NvPoXhFOWLmAT0LANkEjsAg/G6SFnu7Qr7y/2raDb+pTAgA==
X-Received: by 2002:a05:6512:2388:b0:59a:115f:5b8e with SMTP id 2adb3069b0e04-59a17dd70b4mr4476616e87.45.1766442296571;
        Mon, 22 Dec 2025 14:24:56 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59a1862840asm3524409e87.96.2025.12.22.14.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 14:24:55 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: gmazyland@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	mpatocka@redhat.com,
	pavel@ucw.cz,
	rafael@kernel.org
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device mapper devices
Date: Tue, 23 Dec 2025 01:24:19 +0300
Message-ID: <20251222222419.1814906-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
References: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milan Broz <gmazyland@gmail.com>:
> Anyway, my understanding is that all device-mapper targets use mempools,
> which should ensure that they can process even under memory pressure.

Let me give you more details.

Here is output of "free -h":

               total        used        free      shared  buff/cache   available
Mem:            62Gi        47Gi       924Mi       2.4Gi        17Gi        14Gi
Swap:          378Gi        95Gi       282Gi

Swap is located on dm-integrity on real partition.

As you can see, my data does not fit into physical memory, so swap is required
here.

But swap is big, so in theory allocations should always work.

I have a lot of Chromium windows opened (nearly 200).

My laptop is Dell Precision 7780. It is high speced expensive laptop.
I have 64 GiB ECC physical memory, btrfs raid on two 3.5 TiB partitions.
Everything is located on two 4 TiB NVMe SSD physical disks.

Sometimes whole system freezes for several minutes when I open new memory-hungry
Chromium tabs. In such cases I see in logs:

https://zerobin.net/?383b5c32b958aca8#yXmgYidkC8pUFixwQKB+v+O3bkbis4RHduz3gji4DxI=

Notice that all backtraces contain shmem_swapin_folio, so swap is involved here.

Hibernation works thanks to my patch
https://zerobin.net/?ad6142bd67df015a#68Az6yBUxHA3AXB7jY1+clSRnR745olFHAByxwPGM08= .

My kernel is 6.12.48 from Debian with my local patches.

Sometimes I see messages "page allocation failure" in my logs. This is very
strange: I already explained above, that there is a plenty of space in swap.

Here is output of "journalctl | grep -B 10 -A 100 'page allocation failure'":

https://zerobin.net/?4170949dd9a8b25c#p5Z73TfGgpem4O4UsiWllrMCLCoHzDEw+KwJ7n8LWPA=

Maybe my swap is fragmented?

I that logs I notice that:
- Allocation failures often happen immidiately after wake up from hibernation
or suspend
- We try to alloc page of order 4 (what this means? 2^4 pages?)
- GFP mask is "GFP_KERNEL|__GFP_COMP" or "GFP_NOIO|__GFP_COMP". Failure to
allocate in "GFP_NOIO|__GFP_COMP" case is somewhat understandable. But
what about "GFP_KERNEL|__GFP_COMP"? As well as I understand, we are allowed
to do I/O, so we can drop everything to swap. And swap is big. So why we
fail?
- In all backtraces "dell_smbios_call" is involved

Hibernation always works, but takes a lot of time. Usually several minutes.
When hibernating, I see in logs this:

Dec 20 10:02:18 comp kernel: PM: hibernation: Allocated 26015132 kbytes in 193.21 seconds (134.64 MB/s)

I. e. 3 minutes to allocate space in memory for hibernation image.

And sometimes even this:

Dec 11 08:34:26 comp kernel: PM: hibernation: Allocated 25942484 kbytes in 348.90 seconds (74.35 MB/s)

Also sometimes I notice that in browser background for one site is replaced
with black rectangle. So, I assume that browser failed to allocate something,
too, but I unable to find this in logs.

> Anyway, my understanding is that all device-mapper targets use mempools,
> which should ensure that they can process even under memory pressure.

This seems to be not true. I see a lot of words "alloc" in dm-integrity
code:

$ grep alloc drivers/md/dm-integrity.c

And it seems that allocation happens not only in initialization,
but also in normal operations (but I didn't looked at code carefully).

Also, I see a lot of mentions of bufio in dm-integrity code.
As well as I understand, this is some cache layer. But, as well as I understand,
in my case there should no be any caches, everything should be written
directly to partition.

So, how to debug this next?

Maybe there are some ioctls, etc, to avoid this problems or to enable
more verbose logging?

I even okay with inserting some printfs to kernel code, just send me patch.

-- 
Askar Safin

