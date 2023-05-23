Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6B70E757
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 23:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbjEWV3p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 17:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjEWV3o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 17:29:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A73FA
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 14:29:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD1DB1FD79;
        Tue, 23 May 2023 21:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684877381;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0N3yFS+187wq3P5yB4YJtOOBUERp3p6sk4Tl04lDr5Y=;
        b=GbpkLZDFVoC3RU7LRo9kbGDr5pqfzytP8fHiA395eZhXdK4jqzmgzSA8ZwCo10h9m5MMPv
        nm9Ijqqt9ysTlSTl5WSYoj5YBOPxuOqEyHrdhjRbXrObCFXtCUhpKaYJ2YDEivkg+oPLFI
        WN0ekANZD75KlqVCWDWydx4jBlGC+qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684877381;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0N3yFS+187wq3P5yB4YJtOOBUERp3p6sk4Tl04lDr5Y=;
        b=fTU3nWndDQyWbm95Y//2eqeFbsg3W9z4Av04X5qpWluPRZbZlLugC9fwvuL0yp/Myi7Hsc
        kQW4fjS5LUabN7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B23AD13588;
        Tue, 23 May 2023 21:29:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /0G3KkUwbWSRCAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 May 2023 21:29:41 +0000
Date:   Tue, 23 May 2023 23:23:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/9] btrfs: refactor with memcmp_fsid_fs_devices helper
Message-ID: <20230523212334.GD32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684826246.git.anand.jain@oracle.com>
 <fec5e2be6fd4c778966edc3c576f7df38cd0ad3d.1684826247.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fec5e2be6fd4c778966edc3c576f7df38cd0ad3d.1684826247.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 23, 2023 at 06:03:21PM +0800, Anand Jain wrote:
> Refactor the functions find_fsid() and find_fsid_with_metadata_uuid(), as
> they currently share a common set of code to compare the fsid and
> metadata_uuid. Create a common helper function,
> memcmp_fsid_fs_devices().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 95b87e9a0a73..8738c8027421 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -427,6 +427,22 @@ void __exit btrfs_cleanup_fs_uuids(void)
>  	}
>  }
>  
> +static bool memcmp_fsid_fs_devices(struct btrfs_fs_devices *fs_devices,
> +				   const u8 *fsid, const u8 *metadata_fsid)

It's confusing when function is named memcmp_* but does not have the
same return value semantics as memcmp().

We could use "memeq_" prefix but I don't see it used in kernel so
there's not a pattern to follow but for readability, either the helpers
should be exactly memcmp() semantics or rename to something better
reflecting that it's a equal or not.
