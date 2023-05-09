Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B551C6FD279
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 00:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjEIWQm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 18:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjEIWQ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 18:16:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4F849CD
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 15:16:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3BBF61F38C;
        Tue,  9 May 2023 22:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683670584;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yQ5ndztkdj44QgjvIEh2X+1fReko0MUrodN+uLs6vPw=;
        b=sw7K2ByitIK6rPmnjZnunvFaarj5SBoAY6Bgu+QSpGoKocemUiqFxTiEQOrLgmg34VEES/
        99Rlnu2HcYSDU4T0UyW8CYXvuekpJ2wAxZBdSJgeshpGZ3kgwbPFmZ5CD1xtqmtSxM54hl
        Vj4QL1FM4N95C3A0sAk3HEzd4tN3ycs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683670584;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yQ5ndztkdj44QgjvIEh2X+1fReko0MUrodN+uLs6vPw=;
        b=f4/Wxkw6h9g0qv9BwtiiPC6qQGgX4CM3QMDXMnKoQ5AJe5suIycksR4Gr3QxtUqeMOuzD+
        eH0PA3roWB6IFfBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10BC413581;
        Tue,  9 May 2023 22:16:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VoBTAzjGWmS7bgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 22:16:24 +0000
Date:   Wed, 10 May 2023 00:10:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/12] btrfs: various cleanups to make ctree.c sync easier
Message-ID: <20230509221024.GE32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1682798736.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682798736.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 29, 2023 at 04:07:09PM -0400, Josef Bacik wrote:
> Hello,
> 
> These are various cleanups I needed to make syncing some of the kernel files
> into btrfs-progs go smoothly.  They're cosmetic and organizational and shouldn't
> have any functional changes.  Thanks,
> 
> Josef
> 
> Josef Bacik (12):
>   btrfs: move btrfs_check_trunc_cache_free_space into block-rsv.c
>   btrfs: remove level argument from btrfs_set_block_flags
>   btrfs: simplify btrfs_check_leaf_* helpers into a single helper
>   btrfs: add btrfs_tree_block_status definitions to tree-checker.h
>   btrfs: use btrfs_tree_block_status for leaf item errors
>   btrfs: extend btrfs_leaf_check to return btrfs_tree_block_status
>   btrfs: add __btrfs_check_node helper
>   btrfs: move btrfs_verify_level_key into tree-checker.c
>   btrfs: move split_flags/combine_flags helpers to inode-item.h
>   btrfs: add __KERNEL__ check for btrfs_no_printk
>   btrfs: add a btrfs_csum_type_size helper
>   btrfs: rename del_ptr -> btrfs_del_ptr and export it

Added to misc-next, thanks. There are still some comments regarding the
ifdefs and export macros, we can deal with that after merge or I can
update the patches as needed.
