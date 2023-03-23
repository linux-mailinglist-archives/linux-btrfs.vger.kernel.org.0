Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96BA6C7089
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 19:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCWSum (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 14:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjCWSul (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 14:50:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1722B600
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 11:50:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C1D81FE10;
        Thu, 23 Mar 2023 18:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679597439;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aAdsaCplMTb6YAXQDJ1Hne0rf2rVTDjlW2l18wbmTW0=;
        b=dkxG6WwzO0hyQ0x++A7mii+vG+xYWpeAAgPRNDr+SXX/2M5uZZmQtwi4OtE6M1Luoro6dI
        ABgAJFP6usc5EQezltCzVOQ9h5xgi4gw+sbFC8GB9sfruqOgoj7Tc9QbO3PITMXlhg6ECI
        u6c1wb1U0Ra/IHBaJY+jsZL+4HaQi6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679597439;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aAdsaCplMTb6YAXQDJ1Hne0rf2rVTDjlW2l18wbmTW0=;
        b=eDlH9BVW5LxTcb8fnbYcnI7GG2lXJON21E9Q/kS2CQT6alOrRWad6rrUq4ru0m3rqkAVRk
        AmjUlXOrIOl3gxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02BF7132C2;
        Thu, 23 Mar 2023 18:50:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Eh48O36fHGRYGAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Mar 2023 18:50:38 +0000
Date:   Thu, 23 Mar 2023 19:44:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move comment to the related code
Message-ID: <20230323184427.GY10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b186e39f1c4bd938270918ff0411f9c8ba6e8934.1679571105.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b186e39f1c4bd938270918ff0411f9c8ba6e8934.1679571105.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 07:32:16PM +0800, Anand Jain wrote:
> Commit 12659251ca5d  ("btrfs: implement log-structured superblock for ZONED
> mode") moved only the code but not its related comment. Move to the comment
> code where it makes sense.
> 
> (no functional change).
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index cc1871767c8c..e04b10a73d3b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1360,13 +1360,6 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>  
>  	lockdep_assert_held(&uuid_mutex);
>  
> -	/*
> -	 * we would like to check all the supers, but that would make
> -	 * a btrfs mount succeed after a mkfs from a different FS.
> -	 * So, we need to add a special mount option to scan for
> -	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
> -	 */
> -
>  	/*
>  	 * Avoid using flag |= FMODE_EXCL here, as the systemd-udev may
>  	 * initiate the device scan which may race with the user's mount
> @@ -1381,6 +1374,12 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>  	if (IS_ERR(bdev))
>  		return ERR_CAST(bdev);
>  
> +	/*
> +	 * We would like to check all the supers, but that would make
> +	 * a btrfs mount succeed after a mkfs from a different FS.
> +	 * So, we need to add a special mount option to scan for
> +	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
> +	 */

The comment should not be even here, it got stale during the zonded code
updates. It's supposed to be in btrfs_read_dev_super where it explains
why only the one loop is done, the comment is there but not properly
formatted.
