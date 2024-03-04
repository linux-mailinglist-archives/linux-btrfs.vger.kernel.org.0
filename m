Return-Path: <linux-btrfs+bounces-2989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC4886F8D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 04:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249A3B20C9D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 03:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6AD4409;
	Mon,  4 Mar 2024 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EICJrE7f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64F17CE
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Mar 2024 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709522034; cv=none; b=K4jSgqqhc3LQChgLaBt1uQ4/sVEkKB+cG32rQuzw+sHQV+ZAUjj7tX0U1lWXbOz6BV5xvoh0kTaCjoUJCsgFb12maUmXMlbNhLTqlY0WbNEBC+42FAdK5kMF0FWuKAi0OGCbL/FKSdmnpMnIb0GpWVEo6rMvZ0g624c40VY/mmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709522034; c=relaxed/simple;
	bh=fckmFeLh6WFyGQ9VNntNwfYBUqVyPxDnUPzcTP6NoaA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Cb/gbPhPcv/pEZgKM/SN0JscW5HDebu4q96mRd9aouRekIal4t33iKB6iI1jl5pXL1vD7GRl6bWqkw6zGjNgV7XcJU2wjRsKHKQZapzOTyVaaVxdo9aeh7yhdOmQPnK59FH0vKaPBYx3QetNrnHlBSDCHiOW5LVurFXqZ1spdH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EICJrE7f; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d2fad80eacso47279551fa.2
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Mar 2024 19:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709522028; x=1710126828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLE8sDbjxK6FmMdMRzwC0+ubaBerN6Rupqr7raCrVxY=;
        b=EICJrE7fctoXB3EQX+IBQrAMnb8HQtvAhGcIJFY7sx65Y5swMTtaqHAcbSvlFtALBi
         0GD0Sx7B0dT2+idbzZWW52ZCsEnrVZdqR+q1Kpdoi0+2/Dg/s2ClgicbaNAoWAOqplk9
         1FPwOXfFic7i6rhTlufqk2nvTrElGnFYm1TqeoVLcy0iB6D/AhFbDJo47Kn6GVJd/p75
         NHy8zBKXNCOKCh8dpi1Vzo5bAlicpefD9QpvQNX24DpITwTfMAJp6MQYZNWzkFt3Kg2k
         KMNRtPy4iSLbZCzfFzzejK0Y/Uy/BwI+vjlKr/okWH59oWhdqTnqXwUaBpWrpRrCZ35O
         wLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709522028; x=1710126828;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLE8sDbjxK6FmMdMRzwC0+ubaBerN6Rupqr7raCrVxY=;
        b=IsXSogJbYK4lcuX7v/0cXPxWsG/Lh8ROxYR5IGZKHlLv1t3XXRujAJZzMT1z8jZID4
         +/7vPhe7cAi4SJ/mOUiJW/u8yWsCu+SQa08kAJbSO5dhFigsmnirnm0xvfLffPjbv/cd
         uQlZkDam3EbhzIYBCRIE3fZVYhxaJTEsjZacl2IcrYexBqdYWUtbs7TG870g54WL95mX
         G982D86yCdx5mf6vVOWtrhR54ojHN/Pt4cVU+VGfRcXiK9Wf9V43vTDxDwPKMmY2C1W6
         U7YowFogKWVJ1PH3UG3/RIJT0H4d1lSaMioY8za4uu/flolZhXkWilfm5Jv57W39jxzi
         Zb/w==
X-Gm-Message-State: AOJu0Yxj5FdeypPBsZeh0uNjZUDrVUy59Lf2D0F1gKG20kCGOeC7vC/X
	36QTkQuKq67gQY+R0+TRt1n5P/j6gflIDe73tsnX3HRURcCsiDPBVZzUwEi2N1LzNh3M4N4YTwZ
	rcLw=
X-Google-Smtp-Source: AGHT+IEdmM7qRWVcif2ZTzENNCNhl/jRXxlNYaApveMrJV/HdepoJa/UwQFBz+N+iI13u7FgfFOEBw==
X-Received: by 2002:a2e:920d:0:b0:2d2:2cff:fc49 with SMTP id k13-20020a2e920d000000b002d22cfffc49mr5452186ljg.18.1709522028474;
        Sun, 03 Mar 2024 19:13:48 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b001dcd00165a7sm7451932plk.38.2024.03.03.19.13.46
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 19:13:48 -0800 (PST)
Message-ID: <f9be8d16-a1ae-4fb3-8670-c6c7a2615d36@suse.com>
Date: Mon, 4 Mar 2024 13:43:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: initial subpage support for zoned devices
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1708322044.git.wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <cover.1708322044.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ping?

I know this is a very niche scenario (subpage + zoned), and the change 
itself looks very scary, but the change should be safe for non-subpage 
routine (as the new lock all delalloc ranges covers the page would still 
at most lock one delalloc range for normal cases).

Furthermore without this series, there seems be no proper way to support 
subpage + zoned, unless we do a much larger change to merge 
extent_writepage_io() into run_delalloc_range() (which I believe it's 
still needed, but can be done in the future).

Thanks,
Qu

在 2024/2/19 16:38, Qu Wenruo 写道:
> [REPO]
> https://github.com/adam900710/linux/tree/subpage_delalloc
> 
> Please fetch the whole series for testing, as it relies on 3 submitted
> patches.
> 
> [BUG]
> When running subpage btrfs (sectorsize < PAGE_SIZE) with zoned device,
> btrfs can easily crash (with CONFIG_BTRFS_ASSERT enabled) with an
> ASSERT():
> 
>   assertion failed: block_start != EXTENT_MAP_HOLE, in fs/btrfs/extent_io.c:1384
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/extent_io.c:1384!
>   CPU: 2 PID: 1711 Comm: fsstress Tainted: G           OE      6.8.0-rc4-custom+ #9
>   Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20231122-12.fc39 11/22/2023
>   pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : __extent_writepage_io+0x404/0x460 [btrfs]
>   lr : __extent_writepage_io+0x404/0x460 [btrfs]
>   Call trace:
>    __extent_writepage_io+0x404/0x460 [btrfs]
>    extent_write_locked_range+0x16c/0x460 [btrfs]
>    run_delalloc_cow+0x88/0x118 [btrfs]
>    btrfs_run_delalloc_range+0x128/0x228 [btrfs]
>    writepage_delalloc+0xb8/0x178 [btrfs]
>    __extent_writepage+0xc8/0x3a0 [btrfs]
>    extent_write_cache_pages+0x1cc/0x460 [btrfs]
>    extent_writepages+0x8c/0x120 [btrfs]
>    btrfs_writepages+0x18/0x30 [btrfs]
>    do_writepages+0x94/0x1f8
>    filemap_fdatawrite_wbc+0x88/0xc8
>    __filemap_fdatawrite_range+0x6c/0xa8
>    filemap_flush+0x24/0x38
>    btrfs_remap_file_range_prep+0x100/0x1a8 [btrfs]
>    btrfs_remap_file_range+0x2ec/0x448 [btrfs]
>    vfs_copy_file_range+0x4cc/0x520
>    __do_sys_copy_file_range+0xc4/0x2e8
>    __arm64_sys_copy_file_range+0x30/0xd0
>    invoke_syscall+0x78/0x100
>    el0_svc_common.constprop.0+0x48/0xf0
>    do_el0_svc+0x24/0x38
>    el0_svc+0x3c/0x138
>    el0t_64_sync_handler+0x120/0x130
>    el0t_64_sync+0x194/0x198
>   Code: 9108c021 90000be0 913d8000 9402bfad (d4210000)
>   ---[ end trace 0000000000000000 ]---
> 
> [CAUSE]
> There are several problems involved in this case:
> 
> - __extent_writepage_io() would always try writeback the whole page
> - extent_write_locked_range() would only lock the first delalloc range
> 
> This two limits combined, result the following page cache layout to
> cause the problem:
> 
>       0     4K     8K    12K    16K
>       |/////|      |/////|
> 
> - btrfs_run_delalloc_range() called on the above page
> - run_dealloc_cow() ran for range [0, 4K)
> - __extent_writepage_io() called for the whole page
> - __extent_writepage_io() submitted bio for [0, 4K)
> - __extent_writepage_io() try to submit IO for [8K, 12K)
>    But this range has no OE covered, and the existing extent map is a
>    hole, and triggered the ASSERT().
> 
>    Even if we ignore the ASSERT(), we would still hit other problems.
> 
> - run_delalloc_cow() would unlock the full page.
> - btrfs_run_delalloc_range() called again on the page
>    The page is no longer locked, triggering another ASSERT() on
>    PageLocked.
> 
> [FIX]
> This series would try to fix the problem by:
> 
> - making __extent_writepage_io() to only write the specified range
> - making writepage_delalloc() to lock all delalloc range first
>    Then btrfs_run_delalloc_range() for each locked range.
> 
>    This patch is a temporaray solution, until needed subpage interfaces
>    are introduced, and allowing me to do extra testing to make sure the
>    lock-in-one-go behavior is safe.
> 
>    This is a preparation for allowing subpage delalloc async submission.
> 
> - adding subpage interfaces to go through all subpage locked ranges
> 
> - using new subpage interfaces to make sure the full page is only
>    unlocked when the last writer lock owner is releasing the lock
> 
> But please note, this fix is only for the above mentioned problems.
> There can still be other problems related to zoned+subpage, but at least
> we won't trigger ASSERT()s and crash.
> 
> Qu Wenruo (4):
>    btrfs: make __extent_writepage_io() to write specified range only
>    btrfs: lock subpage ranges in one go for writepage_delalloc()
>    btrfs: subpage: introduce helpers to handle subpage delalloc locking
>    btrfs: migrate writepage_delalloc() to use subpage helpers
> 
>   fs/btrfs/extent_io.c |  95 +++++++++++++++++++++++-----
>   fs/btrfs/subpage.c   | 144 +++++++++++++++++++++++++++++++++++++++++--
>   fs/btrfs/subpage.h   |  10 ++-
>   3 files changed, 228 insertions(+), 21 deletions(-)
> 

