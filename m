Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566CF50795A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 20:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353048AbiDSSqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 14:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352569AbiDSSqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 14:46:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C43DDD0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 11:43:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7CAF51F746;
        Tue, 19 Apr 2022 18:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650393801;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QL0Vr9dAerrgVVFAZxmD1aI+65ENtfqkk8JzNp4e9Jk=;
        b=23xzJuJAX1hnvhs09M2enHhJ/nCHrKI2MxIVbuoKB5a2mHp1KISp7x6YmlSeTb4mBNQPWP
        aOgEKU2CG60JYvhYMGzQzc5AN3mq5vbCY7lOQL6D313PPKiKmaYoCdhieiT4bHOpuGcUY0
        NbdU4ivA2j6G6slLveUCxDTXaYBKaQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650393801;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QL0Vr9dAerrgVVFAZxmD1aI+65ENtfqkk8JzNp4e9Jk=;
        b=gOSTp5rP7YSDrD4VyHR+OwMb7CfCkHsvTA0ABLrPXDsEagIr/2D1V8l7MAlprWGP8c6M3B
        6YVsvoYKXZ7a+oCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50AA3132E7;
        Tue, 19 Apr 2022 18:43:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Sym2EskCX2KSBAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Apr 2022 18:43:21 +0000
Date:   Tue, 19 Apr 2022 20:39:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: Re: [PATCH] btrfs: zoned: use dedicated lock for data relocation
Message-ID: <20220419183917.GH2348@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
References: <4ebda439981990cd5903e4fba19f199b4eb36fba.1650266002.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ebda439981990cd5903e4fba19f199b4eb36fba.1650266002.git.naohiro.aota@wdc.com>
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

On Mon, Apr 18, 2022 at 04:15:03PM +0900, Naohiro Aota wrote:
> Currently, we use btrfs_inode_{lock,unlock}() to grant an exclusive
> writeback of the relocation data inode in
> btrfs_zoned_data_reloc_{lock,unlock}(). However, that can cause a deadlock
> in the following path.
> 
> Thread A takes btrfs_inode_lock() and waits for metadata reservation by
> e.g, waiting for writeback:
> 
> prealloc_file_extent_cluster()
>   - btrfs_inode_lock(&inode->vfs_inode, 0);
>   - btrfs_prealloc_file_range()
>   ...
>     - btrfs_replace_file_extents()
>       - btrfs_start_transaction
>       ...
>         - btrfs_reserve_metadata_bytes()
> 
> Thread B (e.g, doing a writeback work) needs to wait for the inode lock to
> continue writeback process:
> 
> do_writepages
>   - btrfs_writepages
>     - extent_writpages
>       - btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
>         - btrfs_inode_lock()
> 
> The deadlock is caused by relying on the vfs_inode's lock. By using it, we
> introduced unnecessary exclusion of writeback and
> btrfs_prealloc_file_range(). Also, the lock at this point is useless as we
> don't have any dirty pages in the inode yet.
> 
> Introduce fs_info->zoned_data_reloc_io_lock and use it for the exclusive
> writeback.
> 
> Fixes: 35156d852762 ("btrfs: zoned: only allow one process to add pages to a relocation inode")
> CC: stable@vger.kernel.org # 5.16 869f4cdc73f9

The format for the stable dependencies is a bit different, I had to look
it up too, so it's ... # 5.16.x: 869f4cdc73f9: <patch subject>

> CC: stable@vger.kernel.org # 5.17
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.
