Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7952F52C57B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 23:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbiERVFi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242992AbiERVFh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 17:05:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D0E25BA4A
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 14:05:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8804D1F900;
        Wed, 18 May 2022 21:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652907862;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZncnuJ8LVKQScYiwkR3Zyu9urXbMsIBhz2ePgUe7J5E=;
        b=QBPFvb0fogdyf2eyeHSIHvQ1zob39oV2iZae++PAKL7eOLwsSf3gD09fHVWs2Cl4wE0V0q
        42IknkmVtpz6xvZWORNC4mYmGT2Ncw22OlMn9S0pHwI3Hk1yK56jmoZQmWHbJcbIhEM/Gn
        8IqQowyQadk4czUrBHOvXZgAlwjD7iU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652907862;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZncnuJ8LVKQScYiwkR3Zyu9urXbMsIBhz2ePgUe7J5E=;
        b=PlfSZdz0PAC0xm2SJ1IJ+u94erZzb8YsPgwOhnDeZyNr+E1VwVjQUGwZbQN2g8vyiOFyVJ
        WpGi4JDwzFccwvAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54167133F5;
        Wed, 18 May 2022 21:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MliRE1ZfhWJyTgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 18 May 2022 21:04:22 +0000
Date:   Wed, 18 May 2022 23:00:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v15 3/7] btrfs: add send stream v2 definitions
Message-ID: <20220518210003.GK18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1649092662.git.osandov@fb.com>
 <abea9f460c7341361e58cbba8af355654eb94b5b.1649092662.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abea9f460c7341361e58cbba8af355654eb94b5b.1649092662.git.osandov@fb.com>
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

On Mon, Apr 04, 2022 at 10:29:05AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This adds the definitions of the new commands for send stream version 2
> and their respective attributes: fallocate, FS_IOC_SETFLAGS (a.k.a.
> chattr), and encoded writes. It also documents two changes to the send
> stream format in v2: the receiver shouldn't assume a maximum command
> size, and the DATA attribute is encoded differently to allow for writes
> larger than 64k. These will be implemented in subsequent changes, and
> then the ioctl will accept the new version and flag.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/send.c            |  2 +-
>  fs/btrfs/send.h            | 40 ++++++++++++++++++++++++++++++++++----
>  include/uapi/linux/btrfs.h |  7 +++++++
>  3 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 9363f625fa17..1f141de3a7d6 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -7459,7 +7459,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
>  
>  	sctx->clone_roots_cnt = arg->clone_sources_count;
>  
> -	sctx->send_max_size = BTRFS_SEND_BUF_SIZE;
> +	sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
>  	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
>  	if (!sctx->send_buf) {
>  		ret = -ENOMEM;
> diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
> index 67721e0281ba..805d8095209a 100644
> --- a/fs/btrfs/send.h
> +++ b/fs/btrfs/send.h
> @@ -12,7 +12,11 @@
>  #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
>  #define BTRFS_SEND_STREAM_VERSION 1
>  
> -#define BTRFS_SEND_BUF_SIZE SZ_64K
> +/*
> + * In send stream v1, no command is larger than 64k. In send stream v2, no limit
> + * should be assumed.
> + */
> +#define BTRFS_SEND_BUF_SIZE_V1 SZ_64K
>  
>  enum btrfs_tlv_type {
>  	BTRFS_TLV_U8,
> @@ -80,16 +84,20 @@ enum btrfs_send_cmd {
>  	BTRFS_SEND_C_MAX_V1 = 22,
>  
>  	/* Version 2 */
> -	BTRFS_SEND_C_MAX_V2 = 22,
> +	BTRFS_SEND_C_FALLOCATE = 23,
> +	BTRFS_SEND_C_SETFLAGS = 24,

Do you have patches that implement the fallocate modes and setflags? I
don't see it in this patchset. The setflags should be switched to
something closer to the recent refactoring that unifies all the
flags/attrs to fileattr. I have a prototype patch for that, comparing
the inode flags in the same way as file mode, the tricky part is on the
receive side how to apply them correctly. On the sending side it's
simple though.

> +	BTRFS_SEND_C_ENCODED_WRITE = 25,
> +	BTRFS_SEND_C_MAX_V2 = 25,
>  
>  	/* End */
> -	BTRFS_SEND_C_MAX = 22,
> +	BTRFS_SEND_C_MAX = 25,
>  };
