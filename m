Return-Path: <linux-btrfs+bounces-8331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 307E998ABAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 20:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F041F213FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 18:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A52C1991A4;
	Mon, 30 Sep 2024 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="W43BCN55"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A4192D97
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719777; cv=none; b=VpTyJ53RDgwY3e/+zghLFHhG4ZGzuhbXkCS5feFTmpv0RMmFb2uNQETzpMlQDrFCOiNH8/MJ7gOYXM7o++qWqRSofGyeb5bhqV9D+SImmz3HtREicKKqQ1bSQqdmJxB8m0S6LwwpzxW6TgruyaQwkQRS994GBSkJMF6GD9z2rJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719777; c=relaxed/simple;
	bh=q5gsS5Tro2P00clTub6r2FSCtvy47vkDAysWkTsvpcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwPD3kpZjfGKoXXfsh0sCnrtQGGk+UTCxYzqRd+Zd2Ww++WXQTX7W+Q0UTjdvsQXtd5OPYNqCFAV2kcjOhGIahBXsea0dYJJGrocWQ/sU16UgTRkjwDBUoTlhIdrZESxM8+wtoc8catNLTEE2611D6/QbVDo1pSGDF3wqoMMz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=W43BCN55; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb2ad51162so39411346d6.3
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727719775; x=1728324575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6qPp3didEccrZEfIo4Gp8djs/M6qQmp19+y7HD6bptM=;
        b=W43BCN55LSwt3tgVVmtVFHbxRd5KPuh7cLpp4Fg7Ed8ozZ6ZHN7k97mZYNS5/rNrr+
         myarJ8/fSAnBmuK9ncaRsNLqpvw8QNRsy0SHRh/+XTzHSPJJ9WmKs5IxLdfJbWPaajy7
         QFsSbBkDYb/h1F94vBifDRBD32AABhP/Rbh4nqNcF7rA8wmHEl6OLAhT3rsgANj2Q2Ox
         0/t55KYtvCi1UFcQTGlzjTS1+qcx6c+tztdScUOgiWfClgYCiyUjEFNcAogOqPs5qI9w
         ShRP8Cjw9F3YIcYA2aQ/Rr+hBWkVQ+heL6En7BhG8SZ39q9ljLa6TSc8Yex88nn38wMH
         qAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719775; x=1728324575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qPp3didEccrZEfIo4Gp8djs/M6qQmp19+y7HD6bptM=;
        b=RqiQ11vixsO746Ag0jQCvB53NqI1oW/DyZh2L+/Q2kE854AECP9o4y/F9MmmfBD8yk
         3jWIoh9/NW9aq0OCuvO0AsBua4AAcpfFzz43dnnLbwnwBxCh/NSqo2lJ6Mkzy3GtxxjX
         /l1gSawr9a2VeB7lgX7ge+t2EXDyLaTjVQs0KITpgjqbXJt3Lm101aDrl0nbKUqsDhzv
         xJgzqcoL4df55nnsoUh6W4/4BvCc/Fbq9HflLhfJyOSHf8OXRt7C1nsLqcb7VxZb13kv
         Tk6F8+uXtey9iHukrcMoxjK7+0E5fJ6Ndg6hDOHMMj2zM3mspZHSCYVBshX3YAizBM73
         /pEQ==
X-Gm-Message-State: AOJu0YwWbEVzKHgODFqWxpPQxdfJvtPamPsLN8ujbu9PNVDoJVvTl3Bv
	EGcqiW/kBVxjq7MQrKPdmeYlrqdOei4pdiEUvQzLGIw2CFWZ1GdHNSffq+lnuptt6ro2/jwYh5V
	f
X-Google-Smtp-Source: AGHT+IH3vdfaBZj5qAkuV6dd3J5vcIMSx9TWD+heEHJnFqbqshIEWQei2h0lkYIoT3DbWrCVBwatKw==
X-Received: by 2002:a05:6214:3218:b0:6cb:3b1c:f681 with SMTP id 6a1803df08f44-6cb3b5e70b4mr189756316d6.1.1727719775260;
        Mon, 30 Sep 2024 11:09:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae37858404sm434603085a.129.2024.09.30.11.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:09:34 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:09:33 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	syzbot+283673dbc38527ef9f3d@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix a NULL pointer dereference when failed to
 start a new trasacntion
Message-ID: <20240930180933.GC667556@perftesting>
References: <c3663ebd875fb3576710f61aefedc25bf452d141.1727476551.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3663ebd875fb3576710f61aefedc25bf452d141.1727476551.git.wqu@suse.com>

On Sat, Sep 28, 2024 at 08:05:58AM +0930, Qu Wenruo wrote:
> [BUG]
> Syzbot reported a NULL pointer dereference with the following crash:
> 
> FAULT_INJECTION: forcing a failure.
>  start_transaction+0x830/0x1670 fs/btrfs/transaction.c:676
>  prepare_to_relocate+0x31f/0x4c0 fs/btrfs/relocation.c:3642
>  relocate_block_group+0x169/0xd20 fs/btrfs/relocation.c:3678
> ...
> BTRFS info (device loop0): balance: ended with status: -12
> Oops: general protection fault, probably for non-canonical address 0xdffffc00000000cc: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000660-0x0000000000000667]
> RIP: 0010:btrfs_update_reloc_root+0x362/0xa80 fs/btrfs/relocation.c:926
> Call Trace:
>  <TASK>
>  commit_fs_roots+0x2ee/0x720 fs/btrfs/transaction.c:1496
>  btrfs_commit_transaction+0xfaf/0x3740 fs/btrfs/transaction.c:2430
>  del_balance_item fs/btrfs/volumes.c:3678 [inline]
>  reset_balance_state+0x25e/0x3c0 fs/btrfs/volumes.c:3742
>  btrfs_balance+0xead/0x10c0 fs/btrfs/volumes.c:4574
>  btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3673
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ---[ end trace 0000000000000000 ]---
> 
> [CAUSE]
> The allocation failure happens at the start_transaction() inside
> prepare_to_relocate(), and during the error handling we call
> unset_reloc_control(), which makes fs_info->balance_ctl to be NULL.
> 
> Then we continue the error path cleanup in btrfs_balance() by calling
> reset_balance_state() which will call del_balance_item() to fully delete
> the balance item in the root tree.
> 
> However during the small window between set_reloc_contrl() and
> unset_reloc_control(), we can have a subvolume tree update and created a
> reloc_root for that subvolume.
> 
> Then we go into the final btrfs_commit_transaction() of
> del_balance_item(), and into btrfs_update_reloc_root() inside
> commit_fs_roots().
> 
> That function checks if fs_info->reloc_ctl is in the merge_reloc_tree
> stage, but since fs_info->reloc_ctl is NULL, it results a NULL pointer
> dereference.
> 
> [FIX]
> Just add extra check on fs_info->reloc_ctl inside
> btrfs_update_reloc_root(), before checking
> fs_info->reloc_ctl->merge_reloc_tree.
> 
> That DEAD_RELOC_TREE handling is to prevent further modification to the
> reloc tree during merge stage, but since there is no reloc_ctl at all,
> we do not need to bother that.
> 
> Reported-by: syzbot+283673dbc38527ef9f3d@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/66f6bfa7.050a0220.38ace9.0019.GAE@google.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

