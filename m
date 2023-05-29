Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BABE714BCE
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 16:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjE2ONb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjE2ON3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 10:13:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBA3E3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 07:13:26 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 90BA621AA2;
        Mon, 29 May 2023 14:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685369605;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jQwbtEuGnrC4Y8MSsMA409bx7dHPFmVgobLWTftehb4=;
        b=dOtnfFCZOjFb1pah/axIAMN8ALwsCHlXWblTcQKonERxbYEHopVZaaHZ3PpPwN8to4O4Vr
        +Cqs75ts73wnb2CXSDm4LH+DI7FNUCjuq3DNctwcWS/J/wJZI9tzGaEVZ23O/4+Sa9nb2B
        sWA1RK2SKLHF4MNYpYcDAHaKTKKDwBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685369605;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jQwbtEuGnrC4Y8MSsMA409bx7dHPFmVgobLWTftehb4=;
        b=Ha4UT6zoyLcKauw6cKPhS+fEyMgEu+avaTmznxsAzLF//w/26C+6xaawBeN9DhnCiqUTpl
        Qed3/lXkFZyqQQBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6B87113508;
        Mon, 29 May 2023 14:13:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id FdUPGQWzdGQpbQAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Mon, 29 May 2023 14:13:25 +0000
Date:   Mon, 29 May 2023 16:07:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     ash lee <ash@bashdev.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: BTRFS kernel BUG at fs/inode.c;611!
Message-ID: <20230529140714.GG575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAMmhH1vkKS2Ot0TyJZ+sDFXhi_-YTWcBkQhSfFxrXmdEAJtK5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMmhH1vkKS2Ot0TyJZ+sDFXhi_-YTWcBkQhSfFxrXmdEAJtK5Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 27, 2023 at 08:31:30PM -0500, ash lee wrote:
> Hi, during running of a BTRFS balance, i ran into this bug. It ended
> up deadlocking the BTRFS balance, and i could not pause/cancel it.
> 
> I have the rest of the kernel logs as well if those would help.
> 
> 2,3508,4363269431,-;kernel BUG at fs/inode.c:611!

The code is

 603 void clear_inode(struct inode *inode)                                                                                                                                                    
 604 {                                                                                                                                                                                        
 605         /*                                                                                                                                                                               
 606          * We have to cycle the i_pages lock here because reclaim can be in the                                                                                                          
 607          * process of removing the last page (in __filemap_remove_folio())                                                                                                               
 608          * and we must not free the mapping under it.                                                                                                                                    
 609          */                                                                                                                                                                              
 610         xa_lock_irq(&inode->i_data.i_pages);                                                                                                                                             
 611         BUG_ON(inode->i_data.nrpages);  



> 4,3512,4363269439,-;RIP: 0010:clear_inode+0x72/0x80
> 4,3526,4363269454,-; evict+0xcd/0x1d0
> 4,3527,4363269457,-; btrfs_relocate_block_group+0xb2/0x3f0 [btrfs]
> 4,3528,4363269484,-; btrfs_relocate_chunk+0x3b/0x120 [btrfs]
> 4,3529,4363269501,-; btrfs_balance+0x7a4/0xf70 [btrfs]
> 4,3530,4363269517,-; btrfs_ioctl+0x2276/0x2610 [btrfs]
> 4,3531,4363269533,-; ? __rseq_handle_notify_resume+0xa6/0x4a0
> 4,3532,4363269535,-; ? proc_nr_files+0x30/0x30
> 4,3533,4363269537,-; ? call_rcu+0x116/0x660
> 4,3534,4363269539,-; ? percpu_counter_add_batch+0x53/0xc0
> 4,3535,4363269541,-; __x64_sys_ioctl+0x8d/0xd0
> 4,3536,4363269542,-; do_syscall_64+0x58/0xc0
> 4,3537,4363269544,-; ? handle_mm_fault+0xdb/0x2d0
> 4,3538,4363269546,-; ? preempt_count_add+0x47/0xa0
> 4,3539,4363269547,-; ? up_read+0x37/0x70
> 4,3540,4363269548,-; ? do_user_addr_fault+0x1ef/0x690
> 4,3541,4363269550,-; ? fpregs_assert_state_consistent+0x22/0x50
> 4,3542,4363269552,-; ? exit_to_user_mode_prepare+0x40/0x1d0

> 20 46 ac
> 6,3591,4708011011,-;traps: iotop[354859] general protection fault
> ip:42b1bf sp:7fff207cf020 error:0 in python3.11[41f000+2b3000]
> 6,3610,5061930113,-;iotop[359003]: segfault at 8e8 ip 00000000000008e8
> sp 00007fff29df99d8 error 14 in python3.11[400000+1f000] likely on CPU
> 10 (core 20, socket 0)
> 6,3611,5061930122,-;Code: Unable to access opcode bytes at 0x8be.
> 4,3625,5313827230,-;------------[ cut here ]------------
> 4,3626,5313827233,-;WARNING: CPU: 21 PID: 392166 at
> fs/btrfs/backref.c:1560 btrfs_is_data_extent_shared+0x2f6/0x3e0
> [btrfs]

A warning in btrfs_is_data_extent_shared but triggered from some inline
function, I don't see a direct call.

> 4,3632,5313827384,-;RIP: 0010:btrfs_is_data_extent_shared+0x2f6/0x3e0 [btrfs]
> 4,3646,5313827433,-; ? btrfs_alloc_page_array+0x5d/0x90 [btrfs]
> 4,3647,5313827463,-; ? extent_fiemap+0x97b/0xad0 [btrfs]
> 4,3648,5313827492,-; extent_fiemap+0x97b/0xad0 [btrfs]
> 4,3649,5313827521,-; btrfs_fiemap+0x45/0x80 [btrfs]
> 4,3650,5313827548,-; do_vfs_ioctl+0x1f2/0x910
> 4,3651,5313827552,-; __x64_sys_ioctl+0x6e/0xd0
> 4,3652,5313827553,-; do_syscall_64+0x58/0xc0
> 4,3653,5313827556,-; ? syscall_exit_to_user_mode+0x17/0x40
> 4,3654,5313827558,-; ? do_syscall_64+0x67/0xc0
> 4,3655,5313827560,-; ? handle_mm_fault+0xdb/0x2d0
> 4,3656,5313827562,-; ? preempt_count_add+0x47/0xa0
> 4,3657,5313827565,-; ? up_read+0x37/0x70
> 4,3658,5313827566,-; ? do_user_addr_fault+0x1ef/0x690
> 4,3659,5313827569,-; ? fpregs_assert_state_consistent+0x22/0x50
> 4,3660,5313827571,-; ? exit_to_user_mode_prepare+0x40/0x1d0
> 4,3661,5313827573,-; entry_SYSCALL_64_after_hwframe+0x63/0xcd

And again
