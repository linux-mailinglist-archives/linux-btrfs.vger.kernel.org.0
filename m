Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF40B52C63F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 00:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiERW2m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 18:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiERW2l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 18:28:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2873F20D4F9
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 15:28:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DCD3F21B95;
        Wed, 18 May 2022 22:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652912917;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BMTIg+9oAd9P86ESTxl0GLY2hsZwwyP8DIQOzPAgFTI=;
        b=SwqMnx0E0H5PGIWFBFLKyI6izhtf1u+KVMbCaoeGEVKbt6bbAGHV7PgDM00pwZxfXkgjaS
        0zPDn8satCA5+XKaF0lLCOHbDPZ7/fdR08ftAgmTpLzN408jKWizFn7eVuznFXzj8+gjPq
        C9nFxKTBFTMOVDPXKGTFUOu8ovF/rgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652912917;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BMTIg+9oAd9P86ESTxl0GLY2hsZwwyP8DIQOzPAgFTI=;
        b=8FLD2ggK88C5WKU3lzPuTFvZAvrRIwV0Zq57wxBDFmsZs49W5qBdR3J88TO6mZGc8qrmH/
        qVQDwsND0ZvzXuCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9B5F13A6D;
        Wed, 18 May 2022 22:28:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ySOWKBVzhWKeaQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 18 May 2022 22:28:37 +0000
Date:   Thu, 19 May 2022 00:24:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v15 2/7] btrfs: send: explicitly number commands and
 attributes
Message-ID: <20220518222418.GL18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1649092662.git.osandov@fb.com>
 <50061db343aa530e65b68e0be85ff246da5b1e7e.1649092662.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50061db343aa530e65b68e0be85ff246da5b1e7e.1649092662.git.osandov@fb.com>
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

On Mon, Apr 04, 2022 at 10:29:04AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit e77fbf990316 ("btrfs: send: prepare for v2 protocol") added
> _BTRFS_SEND_C_MAX_V* macros equal to the maximum command number for the
> version plus 1, but as written this creates gaps in the number space.
> The maximum command number is currently 22, and __BTRFS_SEND_C_MAX_V1 is
> accordingly 23. But then __BTRFS_SEND_C_MAX_V2 is 24, suggesting that v2
> has a command numbered 23, and __BTRFS_SEND_C_MAX is 25, suggesting that
> 23 and 24 are valid commands.
> 
> Instead, let's explicitly number all of the commands, attributes, and
> sentinel MAX constants.
> 
> Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/send.c |   4 +-
>  fs/btrfs/send.h | 106 ++++++++++++++++++++++++------------------------
>  2 files changed, 54 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 6d36dee1505f..9363f625fa17 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -326,8 +326,8 @@ __maybe_unused
>  static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)
>  {
>  	switch (sctx->proto) {
> -	case 1:	 return cmd < __BTRFS_SEND_C_MAX_V1;
> -	case 2:	 return cmd < __BTRFS_SEND_C_MAX_V2;
> +	case 1:	 return cmd <= BTRFS_SEND_C_MAX_V1;
> +	case 2:	 return cmd <= BTRFS_SEND_C_MAX_V2;
>  	default: return false;
>  	}
>  }
> diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
> index 08602fdd600a..67721e0281ba 100644
> --- a/fs/btrfs/send.h
> +++ b/fs/btrfs/send.h
> @@ -46,84 +46,82 @@ struct btrfs_tlv_header {
>  
>  /* commands */
>  enum btrfs_send_cmd {
> -	BTRFS_SEND_C_UNSPEC,
> +	BTRFS_SEND_C_UNSPEC = 0,
>  
>  	/* Version 1 */
> -	BTRFS_SEND_C_SUBVOL,
> -	BTRFS_SEND_C_SNAPSHOT,
> +	BTRFS_SEND_C_SUBVOL = 1,
> +	BTRFS_SEND_C_SNAPSHOT = 2,
>  
> -	BTRFS_SEND_C_MKFILE,
> -	BTRFS_SEND_C_MKDIR,
> -	BTRFS_SEND_C_MKNOD,
> -	BTRFS_SEND_C_MKFIFO,
> -	BTRFS_SEND_C_MKSOCK,
> -	BTRFS_SEND_C_SYMLINK,
> +	BTRFS_SEND_C_MKFILE = 3,
> +	BTRFS_SEND_C_MKDIR = 4,
> +	BTRFS_SEND_C_MKNOD = 5,
> +	BTRFS_SEND_C_MKFIFO = 6,
> +	BTRFS_SEND_C_MKSOCK = 7,
> +	BTRFS_SEND_C_SYMLINK = 8,

Sweat Tea suggested to align the "= number" in the previous iteration, I
agree with that, it's much more readable. As this is just cosmetic
change it could wait until we have all the other changes done.
