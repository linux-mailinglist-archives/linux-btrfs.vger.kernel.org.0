Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6065664474
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 16:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbjAJPVI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 10:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbjAJPU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 10:20:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E1155B5
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 07:20:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B9900773C0;
        Tue, 10 Jan 2023 15:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673364052;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YcOyi+rtLEgoz5veBA9/eNPzoWOobunX83gTRf/Gwik=;
        b=aJYYMJsZknL+2NC8YYfhe7gcfZhhZsPJrvaC0cDm4cxAP19LV3zA2XRXUaezzdYUKsz09P
        NzPBX7QrsbFqVFye6XPCUGlGAqHvacmZY4amn8qCUDm3M8+H85suy6V4FKqbL+kWp1yy2b
        pAyou3+3ufUp0X3XR1tKsHrBod8U+gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673364052;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YcOyi+rtLEgoz5veBA9/eNPzoWOobunX83gTRf/Gwik=;
        b=iSwEOPLDpzufADfdEb9pzBoQ+/B7d5/KJ4QGlMnaQd96aJfYykBLTgRUzpi1qsblZt4+d4
        q/Z5w8rZoLFn31AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D1C313338;
        Tue, 10 Jan 2023 15:20:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eEVsIVSCvWOMfAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 Jan 2023 15:20:52 +0000
Date:   Tue, 10 Jan 2023 16:15:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Lukas Straub <lukasstraub2@web.de>,
        HanatoK <summersnow9403@gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: do not warn on record without @old_roots
 populated
Message-ID: <20230110151518.GE11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <de9535cd9d3b5b020190bbfc751c3705fee8d55d.1673334821.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de9535cd9d3b5b020190bbfc751c3705fee8d55d.1673334821.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 10, 2023 at 03:14:17PM +0800, Qu Wenruo wrote:
> [BUG]
> There is some reports from the mailing list that since v6.1 kernel, the
> WARN_ON() inside btrfs_qgroup_account_extent() get triggered during
> rescan:
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 3 PID: 6424 at fs/btrfs/qgroup.c:2756 btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
>  CPU: 3 PID: 6424 Comm: snapperd Tainted: P           OE      6.1.2-1-default #1 openSUSE Tumbleweed 05c7a1b1b61d5627475528f71f50444637b5aad7
>  RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
>  Call Trace:
>   <TASK>
>  btrfs_commit_transaction+0x30c/0xb40 [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
>   ? start_transaction+0xc3/0x5b0 [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
>  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
>   btrfs_ioctl+0x1ab9/0x25c0 [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
>   ? __rseq_handle_notify_resume+0xa9/0x4a0
>   ? mntput_no_expire+0x4a/0x240
>   ? __seccomp_filter+0x319/0x4d0
>   __x64_sys_ioctl+0x90/0xd0
>   do_syscall_64+0x5b/0x80
>   ? syscall_exit_to_user_mode+0x17/0x40
>   ? do_syscall_64+0x67/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  RIP: 0033:0x7fd9b790d9bf
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
> 
> [CAUSE]
> Since commit e15e9f43c7ca ("btrfs: introduce
> BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting"), if
> our qgroup is already in inconsistent status, we will no longer do the
> time-consuming backref walk.
> 
> This can leave some qgroup records without a valid old_roots ulist.
> Normally this is fine, as btrfs_qgroup_account_extents() would also skip
> those records if we have NO_ACCOUNTING flag set.
> 
> But there is a small window, if we have NO_ACCOUNTING flag set, and
> inserted some qgroup_record without a old_roots ulist, but then the user
> triggered a qgroup rescan.
> 
> During btrfs_qgroup_rescan(), we firstly clear NO_ACCOUNTING flag, then
> commit current transaction.
> 
> And since we have a qgroup_record with old_roots = NULL, we trigger the
> WARN_ON() during btrfs_qgroup_account_extents().
> 
> [FIX]
> Unfortunately due to the introduce of NO_ACCOUNTING flag, the assumption
> that every qgroup_record would has its old_roots populated is no longer
> correct.
> 
> So to fix the false alerts, just change the WARN_ON() to unlikely().
> 
> Reported-by: Lukas Straub <lukasstraub2@web.de>
> Reported-by: HanatoK <summersnow9403@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/2403c697-ddaf-58ad-3829-0335fc89df09@gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, with the suggested Fixes and CC tags, thanks.
