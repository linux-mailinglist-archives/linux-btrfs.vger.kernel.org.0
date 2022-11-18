Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA3962FA69
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 17:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbiKRQhz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 11:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242164AbiKRQhm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 11:37:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F062C942DC;
        Fri, 18 Nov 2022 08:37:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0988022D0D;
        Fri, 18 Nov 2022 16:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668789452;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TmHDNNy7BK2GoEyCC13zO2kb7K0MrJl1jm1K8E97OMI=;
        b=fQq58YmAep1BITmTRRZH1qa3gG0F+1OQ/XPuwsXHlroCCOxu756fdrNZ7QwU5JQT9vl2J2
        Vnpod6XTLpxashJHXIIUahrRBmLvlIKfLVsYx0nj9hpPboxapxUyhI9L/qjPhHPJ71+VlO
        0CfiMEMcpxgIyeZLgGeHhe/gB5aoP5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668789452;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TmHDNNy7BK2GoEyCC13zO2kb7K0MrJl1jm1K8E97OMI=;
        b=0M+DCbr11FuGL0f0sFKWOyO3xgGAGm0sMMgxd0TN43mEi2/fInL5kk6WwRcZjtWKsufSwD
        yEyJiADRUWEaedCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADDAE1345B;
        Fri, 18 Nov 2022 16:37:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /F9aKcu0d2NjDAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 18 Nov 2022 16:37:31 +0000
Date:   Fri, 18 Nov 2022 17:37:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxiaoxu5@huawei.com, yanaijie@huawei.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com
Subject: Re: [PATCH v6 0/2] btrfs: fix sleep from invalid context bug in
 update_qgroup_limit_item()
Message-ID: <20221118163703.GT5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221116142354.1228954-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116142354.1228954-1-chenxiaosong2@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 16, 2022 at 10:23:52PM +0800, ChenXiaoSong wrote:
> At least 3 places might sleep in update_qgroup_limit_item(), as shown below:
> 
>   update_qgroup_limit_item
>     btrfs_alloc_path
>       /* allocate memory non-atomically, might sleep */
>       kmem_cache_zalloc(btrfs_path_cachep, GFP_NOFS)
>     btrfs_search_slot
>       setup_nodes_for_search
>         reada_for_balance
>           btrfs_readahead_node_child
>             btrfs_readahead_tree_block
>               btrfs_find_create_tree_block
>                 alloc_extent_buffer
>                   kmem_cache_zalloc
>                     /* allocate memory non-atomically, might sleep */
>                     kmem_cache_alloc(GFP_NOFS|__GFP_NOFAIL|__GFP_ZERO)
>               read_extent_buffer_pages
>                 submit_extent_page
>                   /* disk IO, might sleep */
>                   submit_one_bio
> 
> Fix this by calling qgroup_dirty() on @dstqgroup, and update limit item in
> btrfs_run_qgroups() later.
> 
> By the way, add might_sleep() to some places.
> 
> ChenXiaoSong (2):
>   btrfs: add might_sleep() to some places in update_qgroup_limit_item()
>   btrfs: qgroup: fix sleep from invalid context bug in
>     update_qgroup_limit_item()

Added to misc-next with updated subjects and changelogs, thanks.
