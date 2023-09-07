Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B3B797938
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbjIGRGu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 13:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbjIGRGt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 13:06:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04281E43
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 10:06:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7C99C1F8A6;
        Thu,  7 Sep 2023 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694086497;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I9dqNgt+owzQZoTdVZPLbDSPv5panE4NLCkXZBoZ3qE=;
        b=1bLwH8mxF0ix+3ZaKikEqyR+4trmxAYG0wXnAEbSNlMuNn+ZKlyKwdWuVwHl5tE27UOFEg
        +0qbvpkg4pbLGdd5ZIlxP3hzvLddfCKteRvpabWyhHgvp4e//p2pV5GF3Rnl/jIZqfsH9d
        8Pehw9VeOtLJLwN2MhAzx0y5BjHfgF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694086497;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I9dqNgt+owzQZoTdVZPLbDSPv5panE4NLCkXZBoZ3qE=;
        b=L9mxbHpTAELZhYFoHLjWs0K+fimGjKgKkvImiDSTlDJuNHJFpWQUX3/KUF0sKWm3dpKAgU
        p4Jitse0qJ3PlODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C8AB138F9;
        Thu,  7 Sep 2023 11:34:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D7UsEWG1+WR6fAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 11:34:57 +0000
Date:   Thu, 7 Sep 2023 13:28:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 04/18] btrfs: add simple_quota incompat feature to
 sysfs
Message-ID: <20230907112825.GD3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <f3aa781253502054034c839ab0d0b18ec35a3d3d.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3aa781253502054034c839ab0d0b18ec35a3d3d.1690495785.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:51PM -0700, Boris Burkov wrote:
> Add an entry in the features directory for the new incompat flag
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index e53614753391..f62bba0068ca 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -291,6 +291,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
>  BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
>  BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
>  BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
> +BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);

I'm not sure if you mentioned in the cover letter or if we had discussed
it before, but does this need to be a full incompat bit? I.e. no mount
on older kernels, compared to a COMPAT_RO which would allow
read-only mount.

>  #ifdef CONFIG_BLK_DEV_ZONED
>  BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
>  #endif
> @@ -322,6 +323,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
>  	BTRFS_FEAT_ATTR_PTR(free_space_tree),
>  	BTRFS_FEAT_ATTR_PTR(raid1c34),
>  	BTRFS_FEAT_ATTR_PTR(block_group_tree),
> +	BTRFS_FEAT_ATTR_PTR(simple_quota),
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	BTRFS_FEAT_ATTR_PTR(zoned),
>  #endif
> -- 
> 2.41.0
