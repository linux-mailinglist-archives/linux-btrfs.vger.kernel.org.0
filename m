Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CF46F83A7
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 15:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjEENQb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 09:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjEENQa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 09:16:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639FB1E98B
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 06:16:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EC832289F;
        Fri,  5 May 2023 13:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683292588;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPYbF5BucXFrO7K125sqSA+DUmAI/tdbc7rSvvFVMzA=;
        b=Iyawy4EWolx5A994V3KgX6jIYjpIFwwQIOSif0w2RlTRY79E3guHvvPRDLDGe3pFfYzEUY
        Vch67olLgOVDN7yqgaYSuRXuw69J44atVt1iEnRYwrvwS1p+F3No6xRiLAYvoxFtWbBuNA
        6I7+lwVfRiE56dPlW16Q6nu6F8aXDjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683292588;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPYbF5BucXFrO7K125sqSA+DUmAI/tdbc7rSvvFVMzA=;
        b=H5S9Xj3MUgPt/bIkiEVVjrQ/Iy3SwwM9BziQ9dgpI5Qc0YP8j+KnIewx1uaFKUXsUd4Ue8
        iwLNlVGg4j4k9lAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F14BD13488;
        Fri,  5 May 2023 13:16:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Jx8cOqsBVWQOUAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 05 May 2023 13:16:27 +0000
Date:   Fri, 5 May 2023 15:10:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Forza <forza@tnonline.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Regression in Linux 6.3.1 vs 6.2.13 with bees: vmalloc error:
 size 0, page order 9, failed to allocate pages,
Message-ID: <20230505131031.GM6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d11418b6-38e5-eb78-1537-c39245dc0b78@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d11418b6-38e5-eb78-1537-c39245dc0b78@tnonline.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 05, 2023 at 12:32:07PM +0200, Forza wrote:
> Hi,
> 
> I upgraded my Linux kernel from 6.2.13 to 6.3.1 and pretty soon after 
> running `bees`, I end up with hundreds of these dmesg messages. The 
> issue is reproducible within minutes and goes away if I go back to 6.2.x 
> kernels or earlier.
> 
> 
> # dmesg on my bare-metal machine
> #########
> May  4 12:31:29 e350 kernel: [  512.186697] crawl_4065_7997: vmalloc 
> error: size 14680064, page order 9, failed to allocate pages, 

Page order 9 is 4096 * 2^9 = 2MiB

> mode:0xcc2(GFP_KERNEL|__GFP_HIGHMEM), 
> nodemask=(null),cpuset=cmd-zIYd,mems_allowed=0
> May  4 12:31:29 e350 kernel: [  512.186711] CPU: 0 PID: 8832 Comm: 
> crawl_4065_7997 Not tainted 6.3.1-gentoo-e350 #1
> May  4 12:31:29 e350 kernel: [  512.186714] Hardware name: Gigabyte 
> Technology Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS F62d 10/13/2021
> May  4 12:31:29 e350 kernel: [  512.186716] Call Trace:
> May  4 12:31:29 e350 kernel: [  512.186718]  <TASK>
> May  4 12:31:29 e350 kernel: [  512.186721]  dump_stack_lvl+0x32/0x50
> May  4 12:31:29 e350 kernel: [  512.186727]  warn_alloc+0x10e/0x190
> May  4 12:31:29 e350 kernel: [  512.186732]  ? __alloc_pages+0x1fc/0x220
> May  4 12:31:29 e350 kernel: [  512.186735] 
> __vmalloc_node_range+0x60e/0x880
> May  4 12:31:29 e350 kernel: [  512.186739]  kvmalloc_node+0x92/0xb0

The 2M allocation may not be satisfied from the lowmem (kmalloc) and
btrfs uses the vmalloc fallback but even then it may not work. This is a
message from memory management that it can't satisfy the allocation due
to fragmentation or exhausting virtual mappings.

If you see it since some version it most likely means that there was a
change in memory management, otherwise the code in btrfs hasn't changed.

The value 2M comes from the ioctl structure
btrfs_ioctl_logical_ino_args::size, IOW there's a request from userspace
to get back such large buffer.

What can be done
- pass smaller buffers from userspace
- we could possibly add NOWARN option to the allocation
- we could cap the buffer size too but the value would be of the same
  megabyte-size so this wouldn't be primary to avoid the warnings
