Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4357A4A91BC
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 01:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356292AbiBDAsz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 19:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbiBDAsy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 19:48:54 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6807C06173B
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 16:48:54 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id q132so3700157pgq.7
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Feb 2022 16:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OSSThGXk1c14NtbTYKuZLp4HuHXMQO5wwL1SMCrHlsk=;
        b=NKBt+b0iFwsbOMx48+W3dbmQihfKxJJGpwTkfhRQyMez9seSqqi87tAIEpeKCYrWuU
         2WDii4Vl16dpExoxWUZGmkVWNidKLtRViBoBZ9cG57usqNIuBHGs5+NTrQIr3+FfXHlG
         VC7ePHFZ5YlPgb+6MBqrratWnrKWEI99OrpzMpGYG9R6oAVSKlCnIuDdya/x/uUjK7MG
         iJo6+rJ8GUTOWV2XjPKoh8CHOm4W6JD9eGLJUCp+3gg5+/O+YtvUHzKnjU3NGQDB4NXI
         MQJhkealoCF83S5BUrsrVAVlR72LRiL7iGNzAFYJJzdlTrzLSXZzs6VeUhCChgu2M3ls
         6g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OSSThGXk1c14NtbTYKuZLp4HuHXMQO5wwL1SMCrHlsk=;
        b=GjaJ+5EMYwyXtl0jcwAb0/b5T/PgIp78rpzr+QJ9tkk6qgwMDBJ5b3yx0MxdQc6ika
         +DEkwmcRNSwJbOj4rnN/BTVGL+tEhoZn07cSq6AY6w3rOcGYuwxnWkf7NrQKF5snMqxL
         X8o6eRdeUTkXesVNX46RMAFzdC9ua1LJDaM/tsxJpM9PMHvOrmMTIzvd1U4/GsO4x+uN
         fFEVaqH4r+KhMzrTZgQPc7evGTJWlsN6xA90TdGDh5bhe7X+2otEL24yLBtIMc6VHszm
         P6ufF5EFxq6ST57n6q+KZ2YopsARNOM7PBSAOX0Z/bG/cjyOEfJrHHFabh5ldt3pDAXc
         nn8A==
X-Gm-Message-State: AOAM531ypUOTfrVPWu+OKRdoxg0NrF05ISiX0w/xqKhP9VeEx62WIoDJ
        7SsMgu09PI6lffEjIdFKUD2jZw==
X-Google-Smtp-Source: ABdhPJycE4mPKX3jV7tAeI1NCAnUo4GFHRmG5mxXO7pG+buqSWXhOCDB0bIA5G0IUOPobCygo/qrhQ==
X-Received: by 2002:a63:6cc5:: with SMTP id h188mr511240pgc.359.1643935734120;
        Thu, 03 Feb 2022 16:48:54 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:cf6b])
        by smtp.gmail.com with ESMTPSA id f3sm204538pfe.67.2022.02.03.16.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 16:48:53 -0800 (PST)
Date:   Thu, 3 Feb 2022 16:48:52 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: prevent copying too big compressed lzo segment
Message-ID: <Yfx39HbTJIM0GRXL@relinquished.localdomain>
References: <20220202214455.15753-1-davispuh@gmail.com>
 <20220202214455.15753-2-davispuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220202214455.15753-2-davispuh@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 02, 2022 at 11:44:55PM +0200, Dāvis Mosāns wrote:
> Compressed length can be corrupted to be a lot larger than memory
> we have allocated for buffer.
> This will cause memcpy in copy_compressed_segment to write outside
> of allocated memory.
> 
> This mostly results in stuck read syscall but sometimes when using
> btrfs send can get #GP
> 
> kernel: general protection fault, probably for non-canonical address 0x841551d5c1000: 0000 [#1] PREEMPT SMP NOPTI
> kernel: CPU: 17 PID: 264 Comm: kworker/u256:7 Tainted: P           OE     5.17.0-rc2-1 #12
> kernel: Workqueue: btrfs-endio btrfs_work_helper [btrfs]
> kernel: RIP: 0010:lzo_decompress_bio (./include/linux/fortify-string.h:225 fs/btrfs/lzo.c:322 fs/btrfs/lzo.c:394) btrfs
> Code starting with the faulting instruction
> ===========================================
>    0:*  48 8b 06                mov    (%rsi),%rax              <-- trapping instruction
>    3:   48 8d 79 08             lea    0x8(%rcx),%rdi
>    7:   48 83 e7 f8             and    $0xfffffffffffffff8,%rdi
>    b:   48 89 01                mov    %rax,(%rcx)
>    e:   44 89 f0                mov    %r14d,%eax
>   11:   48 8b 54 06 f8          mov    -0x8(%rsi,%rax,1),%rdx
> kernel: RSP: 0018:ffffb110812efd50 EFLAGS: 00010212
> kernel: RAX: 0000000000001000 RBX: 000000009ca264c8 RCX: ffff98996e6d8ff8
> kernel: RDX: 0000000000000064 RSI: 000841551d5c1000 RDI: ffffffff9500435d
> kernel: RBP: ffff989a3be856c0 R08: 0000000000000000 R09: 0000000000000000
> kernel: R10: 0000000000000000 R11: 0000000000001000 R12: ffff98996e6d8000
> kernel: R13: 0000000000000008 R14: 0000000000001000 R15: 000841551d5c1000
> kernel: FS:  0000000000000000(0000) GS:ffff98a09d640000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 00001e9f984d9ea8 CR3: 000000014971a000 CR4: 00000000003506e0
> kernel: Call Trace:
> kernel:  <TASK>
> kernel: end_compressed_bio_read (fs/btrfs/compression.c:104 fs/btrfs/compression.c:1363 fs/btrfs/compression.c:323) btrfs
> kernel: end_workqueue_fn (fs/btrfs/disk-io.c:1923) btrfs
> kernel: btrfs_work_helper (fs/btrfs/async-thread.c:326) btrfs
> kernel: process_one_work (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:212 ./include/trace/events/workqueue.h:108 kernel/workqueue.c:2312)
> kernel: worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2455)
> kernel: ? process_one_work (kernel/workqueue.c:2397)
> kernel: kthread (kernel/kthread.c:377)
> kernel: ? kthread_complete_and_exit (kernel/kthread.c:332)
> kernel: ret_from_fork (arch/x86/entry/entry_64.S:301)
> kernel:  </TASK>
> 
> Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
> ---
>  fs/btrfs/lzo.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index 31319dfcc9fb..ebaa5083f2ae 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -383,6 +383,13 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  		kunmap(cur_page);
>  		cur_in += LZO_LEN;
>  
> +		if (seg_len > WORKSPACE_CBUF_LENGTH) {
> +			// seg_len shouldn't be larger than we have allocated for workspace->cbuf
> +			btrfs_err(fs_info, "unexpectedly large lzo segment len %u", seg_len);
> +			ret = -EUCLEAN;
> +			goto out;
> +		}
> +

Oof, the fact that we weren't checking this is pretty bad... Shouldn't
we also be checking that seg_len is within the size of the remaining
input?

>  		/* Copy the compressed segment payload into workspace */
>  		copy_compressed_segment(cb, workspace->cbuf, seg_len, &cur_in);
>  
> -- 
> 2.35.1
> 
