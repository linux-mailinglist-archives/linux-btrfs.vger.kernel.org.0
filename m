Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1648B59C0ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 15:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiHVNsp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 09:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiHVNsn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 09:48:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A21612AA8
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 06:48:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A85FD34B5C;
        Mon, 22 Aug 2022 13:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661176120;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uOiA4SYYecGoUNJ6rcFSJbf4Wm2+vnhNvjW7sRDBOQg=;
        b=wFWu+vy4svz1qV/eMklnk/0UDbDXimyUtk4GIDHpGVv6ut1LDJnDQ+A7/AgLag9BCckPC5
        m2mm9/5BJclMHu0tlDCyKB6S9co32VDvlKCwv2hfKZhhWFUgvTnHUMB7l8u5YByJr6bYhO
        BcPip3N6GiEkB6kf5/xbVDLXKYRqu+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661176120;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uOiA4SYYecGoUNJ6rcFSJbf4Wm2+vnhNvjW7sRDBOQg=;
        b=YJVswK43vX2aMXz0xs7npJcuRTFlYGtjjp89BUsrOhMo0ycmAWxL934pjD7sBa71DdZcz8
        TmFbAuevyEmnHfAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73ADF13523;
        Mon, 22 Aug 2022 13:48:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nkfcGjiJA2NPbAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 Aug 2022 13:48:40 +0000
Date:   Mon, 22 Aug 2022 15:43:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/15] btrfs: shrink the size of struct btrfs_delayed_item
Message-ID: <20220822134326.GX13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1660735024.git.fdmanana@suse.com>
 <bd1d34e39a5fe9d226da167f8b970527f980846d.1660735025.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1d34e39a5fe9d226da167f8b970527f980846d.1660735025.git.fdmanana@suse.com>
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

On Wed, Aug 17, 2022 at 12:22:42PM +0100, fdmanana@kernel.org wrote:
>  	}
>  
>  	item->index = index;
> -	item->ins_or_del = BTRFS_DELAYED_DELETION_ITEM;
>  
>  	ret = btrfs_delayed_item_reserve_metadata(trans, item);
>  	/*
> diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
> index fd6fe785f748..729d352ca8a1 100644
> --- a/fs/btrfs/delayed-inode.h
> +++ b/fs/btrfs/delayed-inode.h
> @@ -16,9 +16,10 @@
>  #include <linux/refcount.h>
>  #include "ctree.h"
>  
> -/* types of the delayed item */
> -#define BTRFS_DELAYED_INSERTION_ITEM	1
> -#define BTRFS_DELAYED_DELETION_ITEM	2
> +enum btrfs_delayed_item_type {
> +	BTRFS_DELAYED_INSERTION_ITEM,
> +	BTRFS_DELAYED_DELETION_ITEM
> +};
>  
>  struct btrfs_delayed_root {
>  	spinlock_t lock;
> @@ -80,8 +81,9 @@ struct btrfs_delayed_item {
>  	u64 bytes_reserved;
>  	struct btrfs_delayed_node *delayed_node;
>  	refcount_t refs;
> -	int ins_or_del;
> -	u32 data_len;
> +	enum btrfs_delayed_item_type type:1;

Bit fields next to atomicly accessed variables could be problemantic on
architectures without safe unaligned access. Either this can be :8 or
moved after 'key' where's a 7 byte hole.
