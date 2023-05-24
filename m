Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F0E70FF94
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 23:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjEXVCu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 17:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEXVCt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 17:02:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3A6B3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 14:02:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08B1621C8B;
        Wed, 24 May 2023 21:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684962167;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFyM1VNd6v8DK1EtAgA2yC6s9+wlTbtmD8fUhvRRo7E=;
        b=D0b/I6OMlbnODv1zqROe1zl4QN0Scz08vx2XqNM1popNJpp6oXDzmNGXpz7epmwa6sLOfy
        PIh+fKn1TU5+kSqMK9SomjsYYy972aTpMgBu4AB23PtousyzBfnSEvrwfHNWRSb7rSedwA
        2G/govxsKys3mG6SBQtPy71nkk8N/L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684962167;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFyM1VNd6v8DK1EtAgA2yC6s9+wlTbtmD8fUhvRRo7E=;
        b=9C0+2et/kQXMEVFbbONasLasyMf9RQr4wl+Ycf3BjrJNVha+5YRRcCB6VNJRB+ZObZSDKu
        /V+xFtFB/nNCIGCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E425013425;
        Wed, 24 May 2023 21:02:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +2PUNnZ7bmRiRwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 24 May 2023 21:02:46 +0000
Date:   Wed, 24 May 2023 22:56:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 6/9] btrfs: refactor with match_fsid_fs_devices helper
Message-ID: <20230524205639.GE30909@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684928629.git.anand.jain@oracle.com>
 <e9769859dca130abf187cab7861e03f57c507fd4.1684928629.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9769859dca130abf187cab7861e03f57c507fd4.1684928629.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 24, 2023 at 08:02:40PM +0800, Anand Jain wrote:
> Refactor the functions find_fsid() and find_fsid_with_metadata_uuid(), as
> they currently share a common set of code to compare the fsid and
> metadata_uuid. Create a common helper function,
> match_fsid_fs_devices().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Rename helper function.
> 
>  fs/btrfs/volumes.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f573f93024b0..3d426dbd1199 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -427,6 +427,22 @@ void __exit btrfs_cleanup_fs_uuids(void)
>  	}
>  }
>  
> +static bool match_fsid_fs_devices(struct btrfs_fs_devices *fs_devices,
> +				   const u8 *fsid, const u8 *metadata_fsid)

The match_ prefix looks on in this context.
