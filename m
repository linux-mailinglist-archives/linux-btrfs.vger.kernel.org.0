Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC6E5FEAB1
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiJNInc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 04:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJNInb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 04:43:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C103E1C39D1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 01:43:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8057E219BC;
        Fri, 14 Oct 2022 08:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665737009;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6gSAemfpnD7RAhad3gKvo/AjNdkUvQEHY+SzXJeIgC8=;
        b=cDKiJ8sIzeQ4VbkQHVpgEwvo3fbcZ3b3aeMC6OjtaiXjBkEDiCGG4fuxLo/3RBdXkJRHxU
        m3SKGkQ7CIXqSqBY7TEbZY4CJBHHHrQ8ej6iKlHUIoOxoiLAvEUrYYnFIhId5hC///29ur
        6AXL0T4EsBO9yx+abYRkw0cebmxzeII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665737009;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6gSAemfpnD7RAhad3gKvo/AjNdkUvQEHY+SzXJeIgC8=;
        b=gV2011kWTOMkN7xpzoFRlPNSpuYTZ4JZtp/c4sCWLUb1p76qekY/x7qXRTURmSnOkZN9HF
        TjkLiZUHvzCvsCDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FAC013451;
        Fri, 14 Oct 2022 08:43:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VX6GEjEhSWPwBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Oct 2022 08:43:29 +0000
Date:   Fri, 14 Oct 2022 10:43:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        'Filipe Manana ' <fdmanana@kernel.org>
Subject: Re: [PATCH v2 2/2] btrfs: re-check reclaim condition in reclaim
 worker
Message-ID: <20221014084322.GZ13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665701210.git.boris@bur.io>
 <5f8c37f6ebc9024ef4351ae895f3e5fdb9c67baf.1665701210.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f8c37f6ebc9024ef4351ae895f3e5fdb9c67baf.1665701210.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 13, 2022 at 03:52:10PM -0700, Boris Burkov wrote:
> I have observed the following case play out and lead to unnecessary
> relocations:
> 
> 1. write a file across multiple block groups
> 2. delete the file
> 3. several block groups fall below the reclaim threshold
> 4. reclaim the first, moving extents into the others
> 5. reclaim the others which are now actually very full, leading to poor
>    reclaim behavior with lots of writing, allocating new block groups,
>    etc.
> 
> I believe the risk of missing some reasonable reclaims is worth it
> when traded off against the savings of avoiding overfull reclaims.
> 
> Going forward, it could be interesting to make the check more advanced
> (zoned aware, fragmentation aware, etc...) so that it can be a really
> strong signal both at extent delete and reclaim time.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-group.c | 65 ++++++++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 684401aa014a..b3e9b1bc566e 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1539,6 +1539,30 @@ static inline bool btrfs_should_reclaim(struct btrfs_fs_info *fs_info)
>  	return true;
>  }
>  
> +static inline bool should_reclaim_block_group(struct btrfs_block_group *bg, u64 bytes_freed)

The static inline does not make sense here, though it's just copied. I'm
doing fixups to make it just static in code gets moved (with a note to
changelog), as it would be a bit excessive to fix in a separate patch.
