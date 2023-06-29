Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE3A742A7F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 18:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjF2QUm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 12:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjF2QUl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 12:20:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861DB2D71
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 09:20:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4384221852;
        Thu, 29 Jun 2023 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688055639;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8dxyFIRxU37Q1i+J/qQPyaZA1nGiJbASVICn95fjS1I=;
        b=uLpXEIzihlRHAkntYcqwK6GM3F+dVP1VbSznl/z/tzZxR4656DHGHGuNFILRics6H1l1Ao
        /nadkc8ZOC3CnSB5pPaps5onb3x59gZs3pGHRheA1ZTnnf9VnglK2+dALHe+GllDzohskx
        BZMMz6QN55ZfVksXR7nSm8+vt8ZJ7wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688055639;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8dxyFIRxU37Q1i+J/qQPyaZA1nGiJbASVICn95fjS1I=;
        b=wQ6pNugVqju0dGf7oKs75JePXbaCUmhmAb+CEwvcLWES05fKrjFuxePcVyG5J+F6CiR0qh
        zy2kbmTIbBq0CWCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CAD013905;
        Thu, 29 Jun 2023 16:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ATgXClevnWRgTwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Jun 2023 16:20:39 +0000
Date:   Thu, 29 Jun 2023 18:14:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: raid56: remove unused BTRFS_RBIO_PARITY_SCRUB
Message-ID: <20230629161410.GQ16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <65b7602d5baadf1b7102072abc98515322c67892.1687939844.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b7602d5baadf1b7102072abc98515322c67892.1687939844.git.wqu@suse.com>
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

On Wed, Jun 28, 2023 at 04:11:15PM +0800, Qu Wenruo wrote:
> Commit aca43fe839e4 ("btrfs: remove unused raid56 functions which were
> dedicated for scrub") removed the special handling of RAID56 scrub for
> missing device.
> 
> As scrub goes full mirror_num based recovery, that means if it hits a
> missing device in RAID56, it would just try the next mirror, which would
> go through the BTRFS_RBIO_READ_REBUILD operation.
> 
> This means there is no longer any use of BTRFS_RBIO_PARITY_SCRUB
> operation and we can safely remove it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Subject should say BTRFS_RBIO_REBUILD_MISSING, BTRFS_RBIO_PARITY_SCRUB
stays. Fixed and added to misc-next, thanks.

> --- a/fs/btrfs/raid56.h
> +++ b/fs/btrfs/raid56.h
> @@ -14,7 +14,6 @@ enum btrfs_rbio_ops {
>  	BTRFS_RBIO_WRITE,
>  	BTRFS_RBIO_READ_REBUILD,
>  	BTRFS_RBIO_PARITY_SCRUB,
> -	BTRFS_RBIO_REBUILD_MISSING,
>  };
