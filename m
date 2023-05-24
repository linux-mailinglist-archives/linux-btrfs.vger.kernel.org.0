Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B80270FF93
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 23:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjEXVC2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 17:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEXVC0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 17:02:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A142B194
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 14:02:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 417721FE29;
        Wed, 24 May 2023 21:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684962140;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bl40Ol676i9N7NyTdJsfC6UQJAjCBm2D/iN/Ag6Qz8o=;
        b=yv+iT+6KMHJo/rtDwVBli0yx3LWtAGnI7dyZTSAU8b6Y7u0Y4nowSkgeBr9OQirKhUbXu8
        sS6Vx9lLQ8rr61GYU/+6TL0t6so0NfaXe5pJunIpzNkI60hfSIlDcVBNmg0uyWGsQjx/fM
        2n7hZciFVm5Rn7EOrOO3S7sP0lJemH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684962140;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bl40Ol676i9N7NyTdJsfC6UQJAjCBm2D/iN/Ag6Qz8o=;
        b=UH024wbZw8MPZhk47JskLUCTs4SiVfi6oFLgRlCsnoxKG6J2fax/zWjawVmUJocdY8IblZ
        /WU7G332L9YNeSDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A50513425;
        Wed, 24 May 2023 21:02:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ayWlBVx7bmRBRwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 24 May 2023 21:02:20 +0000
Date:   Wed, 24 May 2023 22:56:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 7/9] btrfs: refactor with match_fsid_changed helper
Message-ID: <20230524205612.GD30909@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684928629.git.anand.jain@oracle.com>
 <f7ecb8bdf8870988b239f0df65c026c642c26218.1684928629.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7ecb8bdf8870988b239f0df65c026c642c26218.1684928629.git.anand.jain@oracle.com>
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

On Wed, May 24, 2023 at 08:02:41PM +0800, Anand Jain wrote:
> We often check if the metadata_uuid is not the same as fsid, and then we
> check if the given fsid matches the metadata_uuid. This patch refactors
> this logic into function match_fsid_changed and utilize it.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Rename helper function.
> 
>  fs/btrfs/volumes.c | 48 ++++++++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3d426dbd1199..4ef2a8713628 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -458,6 +458,20 @@ static noinline struct btrfs_fs_devices *find_fsid(
>  	return NULL;
>  }
>  
> +/*
> + * First, checks if the metadata_uuid is different from the fsid in the
> + * given fs_devices. Then, checks if the given fsid is the same as the
> + * metadata_uuid in the fs_devices. If it is, returns true; otherwise,
> + * returns false.
> + */
> +static inline bool match_fsid_changed(struct btrfs_fs_devices *fs_devices,
> +				       u8 *fsid)

The argumetns can be const and I've changed the prefix to be 'check_',
we have similar helpers.
