Return-Path: <linux-btrfs+bounces-17819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CEDBDD439
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 09:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB9C3A74A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EB0315D47;
	Wed, 15 Oct 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WUCdvxf8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D50315D3B
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515175; cv=none; b=cNclzyzHLKJ9mTaIhTdxCKQPQDjWikmNs5FVmbadMs/zVYrsue7ULMrO+eerI68Wh+OsGmC8hCsVq/G5KNTmwnlayUbLex79svBFUx9xWAqIiZfMrGDGP34t/knThRK/KccIZ9MxYkCCCSJ8KYAWW5ETqBb4fBaZ4rc5JrMgKpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515175; c=relaxed/simple;
	bh=6fP/i69arfF8fWdZlapKSQh9LzzNgkXKJEVrnqonIwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhuAUSCIyuzh9efUh3hP+TUVFaCTml/V9qBagoeHo5Il14b6rlVZ3MKHz1I78itTgXPB352OHDJuEvf+WDejPvzta/vOWZv7PbyimlX/9qWYKUcEaE2Q3zYj1+obzgwM3tzdfudZAmUmzOaNELTE2ZaCJivIK7H7BqKgK+tR+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WUCdvxf8; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-421851bca51so4125814f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760515171; x=1761119971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5B/YsZLvtz4Vz4k84b8+S3byFq2ZeMyQDiX72Vy5xUU=;
        b=WUCdvxf80hDv7juR1Vv7ODPrgA2p/XWsk3leUDKwNgjuntL8mobQv9NQ0Q6P5awEYg
         HDT5Dk9+RzUU8tCA7+qyUKpwmD/20+EzHNtwkuCXTm8pJ417SB3frkqbA8LmHyEw51uw
         aLJP9wodWDr29qy9aaC3FNZ++H4dIMjITFiVIw8WEbYEMXTvqvM7LM+RnISVXrlrSfCG
         ufWxf9icP3TCCxkSrW1GYTWi2t1cPOfDnB7Oe6v0dTmjZG8TqbMeZhniuXiH8+BWGuAr
         Mg+gufDlaz+mt/lw3xBN7eKAqOIGcWeTbIA2WU3IXA+lL6iHIY08V2JtB1rxbKAbicKf
         AFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760515171; x=1761119971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5B/YsZLvtz4Vz4k84b8+S3byFq2ZeMyQDiX72Vy5xUU=;
        b=VvVaMf7WAiLLude8e3oGaH71KdTynhNlSsbHpu3/eqHI6Srhvewiyb8jdLWO5Z0t8o
         h1fJgEKU7KR4SejC4YKg+keETjQllvw+hSgaa7qVjkKGy3OPGn8eNWnqycyQzJhrAhI9
         yQUM4kstfxTpKykSttBGU4MhIKUuOwrtWnEquPKMoOqlwqP7V8rraj9F8B++dyzYeLA6
         P/fda41CrCR1tqX9ym/7ql0BLkq+a4bKS7KOCOkyS4Uh0RqCC91snT37Nmqvp2bz3sR/
         u45jCjoLTCsnGWOPWbn5Ux4FeoZdx13c4PaZSRyZqRtUqkdAfvI2pcs0dq2DoMJMBGq1
         564Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDcPPD7VLvuPzd6q51udC1VtFk8i19dNW+V/ptSLD+LRBgAsCKaVETUmp7+ps1+4cByfRr+i2dTgTf3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMH1S4KaaA4DaIZBVsvLQNEk28PnAKcj1g/BeMdZh/STSCO07x
	M+ORr8uKfDVRcsPZR23OGdRvSXpOwBwPgHnGsC3duM6IcDRWU/OjQh8lK5egBIWRJO9ESHSt6o+
	RPqAUMk996BcePf7C03mvk6MEJS/b+NxqLHskLnBdWg==
X-Gm-Gg: ASbGncvixqUqQokbxg1pMVvUyjh1d8oUrq1D2uzG3CliC3LKAeNzX/KzXobQgr9Lalt
	GxFHoproMoFnBHsuMsTInW8810e8AZxn035t7ouzCn1CTNAB8Dloh0n6bUP1ocqL83WkEaUyI3C
	bGLS/z0kMg/vf9mb4dviNICVq2RbD6KcPhZ/bHYFXNqfp2LE0mAr3LO8aMXw6TcDmMNtSKvtP9z
	o9f6hY7O+DFE+EhRU/wkRUb
X-Google-Smtp-Source: AGHT+IHlYAnGPR4+sBXbnvDD5yiOrLQHUpd+9XPo6Ae95pZZ4ZJRoJI1F9e90h+u2SnMQCRpOX1T6dYbP4QCztVft+Y=
X-Received: by 2002:a05:6000:290d:b0:425:7168:44c3 with SMTP id
 ffacd0b85a97d-42666ab9684mr18960125f8f.5.1760515171153; Wed, 15 Oct 2025
 00:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015072421.4538-1-mengdewei@cqsoftware.com.cn>
In-Reply-To: <20251015072421.4538-1-mengdewei@cqsoftware.com.cn>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 15 Oct 2025 09:59:20 +0200
X-Gm-Features: AS18NWB-SEts5Wua3RsrCioj0InLqkwJBjS_DUAbeRyBw2inxrYnUobVV7xymPE
Message-ID: <CAPjX3FdquokJ380EuYVf-m4M5o=_PwQkg+OJN-cOSHkCc-N97w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Fix NULL pointer access in btrfs_check_leaked_roots()
To: Dewei Meng <mengdewei@cqsoftware.com.cn>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 09:39, Dewei Meng <mengdewei@cqsoftware.com.cn> wrote:
>
> If fs_info->super_copy or fs_info->super_for_commit is NULL in
> btrfs_get_tree_subvol(), the btrfs_check_leaked_roots() will get the
> btrfs_root list entry using the fs_info->allocated_roots->next
> which is NULL.
>
> syzkaller reported the following information:
>   ------------[ cut here ]------------
>   BUG: unable to handle page fault for address: fffffffffffffbb0
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 64c9067 P4D 64c9067 PUD 64cb067 PMD 0
>   Oops: Oops: 0000 [#1] SMP KASAN PTI
>   CPU: 0 UID: 0 PID: 1402 Comm: syz.1.35 Not tainted 6.15.8 #4 PREEMPT(lazy)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), (...)
>   RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
>   RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
>   RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
>   RIP: 0010:refcount_read include/linux/refcount.h:170 [inline]
>   RIP: 0010:btrfs_check_leaked_roots+0x18f/0x2c0 fs/btrfs/disk-io.c:1230
>   [...]
>   Call Trace:
>    <TASK>
>    btrfs_free_fs_info+0x310/0x410 fs/btrfs/disk-io.c:1280
>    btrfs_get_tree_subvol+0x592/0x6b0 fs/btrfs/super.c:2029
>    btrfs_get_tree+0x63/0x80 fs/btrfs/super.c:2097
>    vfs_get_tree+0x98/0x320 fs/super.c:1759
>    do_new_mount+0x357/0x660 fs/namespace.c:3899
>    path_mount+0x716/0x19c0 fs/namespace.c:4226
>    do_mount fs/namespace.c:4239 [inline]
>    __do_sys_mount fs/namespace.c:4450 [inline]
>    __se_sys_mount fs/namespace.c:4427 [inline]
>    __x64_sys_mount+0x28c/0x310 fs/namespace.c:4427
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0x92/0x180 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   RIP: 0033:0x7f032eaffa8d
>   [...]
>
> This should check if the fs_info->allocated_roots->next is NULL before
> accessing it.
>
> Fixes: 3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
> Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
> ---
>  fs/btrfs/disk-io.c | 3 +++
>  1 file changed, 3 insertions(+)

Looks good to me.
Reviewed-by: Daniel Vacek <neelx@suse.com>

Thank you

>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0aa7e5d1b05f..76db7f98187a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1213,6 +1213,9 @@ void btrfs_check_leaked_roots(const struct btrfs_fs_info *fs_info)
>  #ifdef CONFIG_BTRFS_DEBUG
>         struct btrfs_root *root;
>
> +       if (!fs_info->allocated_roots.next)
> +               return;
> +
>         while (!list_empty(&fs_info->allocated_roots)) {
>                 char buf[BTRFS_ROOT_NAME_BUF_LEN];
>
> --
> 2.43.5
>
>

