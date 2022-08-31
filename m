Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EE25A86A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 21:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiHaTUM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 15:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiHaTUG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 15:20:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C850B5FFD
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 12:20:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 580292205C;
        Wed, 31 Aug 2022 19:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661973601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Djo770U62zdfHQQdKwk2Pf0H7Oj5RcZd3C/3Gka8rqo=;
        b=xHpokT4RPnLJGvWHff73o6n3WN3jmvZwdLnQ1DmzzW6IfhwplC4/6yCQgGgvn+dVruCLBy
        4o9j1+cYIEz2lMvC6FuI+B+MkGUmRquNQ0lWjP30bQPzuJDzy16bojW8i9DArHD9X0elHo
        fbq0V7wkduw+ZBrQ7yC6jpcxkAg1xtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661973601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Djo770U62zdfHQQdKwk2Pf0H7Oj5RcZd3C/3Gka8rqo=;
        b=EispKez/772CGi2k6dnOqzQdAmw8nj9b51ZxbZKUuCukiUDlfqkTWcMPRZF53wTJSkotaK
        vf89fwqjWzGoTMDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 287C213A7C;
        Wed, 31 Aug 2022 19:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vy/EB2G0D2NUTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 31 Aug 2022 19:20:01 +0000
Date:   Wed, 31 Aug 2022 21:14:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 3/5] btrfs-progs: separate block group tree from
 extent tree v2
Message-ID: <20220831191442.GL13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1660024949.git.wqu@suse.com>
 <5eef4fd2d55a02dab38a6d1dec43dbcd82652508.1660024949.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eef4fd2d55a02dab38a6d1dec43dbcd82652508.1660024949.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 09, 2022 at 02:03:53PM +0800, Qu Wenruo wrote:
> Block group tree feature is completely a standalone feature, and it has
> been over 5 years before the initial introduction to solve the long
> mount time.
> 
> I don't really want to waste another 5 years waiting for a feature which
> may or may not work, but definitely not properly reviewed for its
> preparation patches.

This should go to the cover letter but in the commit such ranting does
not bring much information for the code change. And I rephrase or delete
such things unless it's somehow relevant.

> So this patch will separate the block group tree feature into a
> standalone compat RO feature.
> 
> There is a catch, in mkfs create_block_group_tree(), current
> tree-checker only accepts block group item with valid chunk_objectid,
> but the existing code from extent-tree-v2 didn't properly initialize it.
> 
> This patch will also fix above mentioned problem so kernel can mount it
> correctly.
> 
> Now mkfs/fsck should be able to handle the fs with block group tree.
> 
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -172,6 +172,14 @@ static const struct btrfs_feature runtime_features[] = {
>  		VERSION_TO_STRING2(safe, 4,9),
>  		VERSION_TO_STRING2(default, 5,15),
>  		.desc		= "free space tree (space_cache=v2)"
> +	}, {
> +		.name		= "block-group-tree",
> +		.flag		= BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
> +		.sysfs_name = "block_group_tree",
> +		VERSION_TO_STRING2(compat, 6,0),
> +		VERSION_NULL(safe),
> +		VERSION_NULL(default),
> +		.desc		= "block group tree to reduce mount time"

Like explaining that this is a runtime feature and I have not noticed
until I tried to test it expecting to see it among the mkfs-time
features but there was nothing in 'mkfs.btrfs -O list-all'.

This is a mkfs-time feature as it creates a fundamental on-disk
structure, basically a subset of extent tree.

As it's in one patch please send a fixup so I can fold it. Thanks.
