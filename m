Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AB862A08E
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 18:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiKORlz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 12:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiKORlv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 12:41:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDB6303D3;
        Tue, 15 Nov 2022 09:41:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E41AC1F8E1;
        Tue, 15 Nov 2022 17:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668534108;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yb1QWgprwexsQKm4S/Gq/MwPIFzEpTMe+qnWWEHuwCo=;
        b=AOtDzt1M2fGiZ/8NX5AFf2F72XKWlnKtKgjXMQYDehm9G1Z5SDTpQBVmMY8Qa8DhpMKFDZ
        7RI5V9lKC4wC48Krfx4xeEbTOIW5cpz54048nWEoITLRVNewus3EaCRIx8gId5i4CcPgdg
        ieEYKJM8r2TZzvav+MTXywVk59HdQZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668534108;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yb1QWgprwexsQKm4S/Gq/MwPIFzEpTMe+qnWWEHuwCo=;
        b=Ha9x0WWXoA7lnuDcZtLmpSFtBEkGqNKQ797FYv3srYjBjXXgfYUJTSsTuI/oMdX6v7/JBS
        NbGGlaZ+7kfyH1DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A03CE13A91;
        Tue, 15 Nov 2022 17:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sDrZJVzPc2PFXAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 15 Nov 2022 17:41:48 +0000
Date:   Tue, 15 Nov 2022 18:41:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxiaoxu5@huawei.com, yanaijie@huawei.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com
Subject: Re: [PATCH v4 1/3] btrfs: add might_sleep() to some places in
 update_qgroup_limit_item()
Message-ID: <20221115174122.GM5824@suse.cz>
Reply-To: dsterba@suse.cz
References: <20221115171709.3774614-1-chenxiaosong2@huawei.com>
 <20221115171709.3774614-2-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115171709.3774614-2-chenxiaosong2@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 16, 2022 at 01:17:07AM +0800, ChenXiaoSong wrote:
> As the potential sleeping under spin lock is hard to spot, we should add
> might_sleep() to some places.
> 
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
>  fs/btrfs/ctree.c  | 2 ++
>  fs/btrfs/qgroup.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a9543f01184c..809053e9cfde 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1934,6 +1934,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>  	int min_write_lock_level;
>  	int prev_cmp;
>  
> +	might_sleep();

This needs some explanation in the changelog, the reason was mentioned
in some past patch iteration that it's due to potential IO fi the blocks
are not cached.

> +
>  	lowest_level = p->lowest_level;
>  	WARN_ON(lowest_level && ins_len > 0);
>  	WARN_ON(p->nodes[0] != NULL);
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9334c3157c22..d0480b9c6c86 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -779,6 +779,8 @@ static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
>  	int ret;
>  	int slot;
>  
> +	might_sleep();

This one is redundant, no? There's call to btrfs_search_slot a few lines
below.

> +
>  	key.objectid = 0;
>  	key.type = BTRFS_QGROUP_LIMIT_KEY;
>  	key.offset = qgroup->qgroupid;
> -- 
> 2.31.1
> 
