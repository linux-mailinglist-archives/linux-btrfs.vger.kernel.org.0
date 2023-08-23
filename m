Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610CE785E9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 19:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbjHWRcX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 13:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjHWRcW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 13:32:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D54110D0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 10:32:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 12F83209B2;
        Wed, 23 Aug 2023 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692811923;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5HuXY740m4p0X9CzbvUuoigMtHOsBEu0JL3J6AdDxM=;
        b=p8mRVduspcfyBWaobsc3IOZ8LU+aEBz+k4A2hyY4hWTeasYIZqLr1x4/LOzMOa4jv2BGKK
        iQq/Oy3rKsadbeGFDDYUvInyEsJq30w2thDafncfC9PtQtnL2jzjLDhADDPuFgnW0luPet
        xM6oGqQ/ywU3PwsNvioZXP2YdLjdW/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692811923;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5HuXY740m4p0X9CzbvUuoigMtHOsBEu0JL3J6AdDxM=;
        b=MOz73dfQn/k1XuzelB/Ofkj5WwIU64tkPURu/GDySO+PkIMFmbUNUbSUredYOtghabKTRO
        v7TvtVQly0XgbxCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1DBF1351F;
        Wed, 23 Aug 2023 17:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8kCENpJC5mR5YAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 23 Aug 2023 17:32:02 +0000
Date:   Wed, 23 Aug 2023 19:25:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 13/38] btrfs-progs: drop btrfs_init_path
Message-ID: <20230823172530.GI2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692800904.git.josef@toxicpanda.com>
 <f39e59024cd38ec1a7e5fa129188bb10f3e556d5.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f39e59024cd38ec1a7e5fa129188bb10f3e556d5.1692800904.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 23, 2023 at 10:32:39AM -0400, Josef Bacik wrote:
> This simply zero's out the path, and this is used everywhere we use a
> stack path.  Drop this usage and simply init the path's to empty instead
> of using a function to do the memset.

This also relies that btrfs_release_path() zeroes the path so repeated
uses of the same path don't need to be reinitialized before search.


> --- a/check/clear-cache.c
> +++ b/check/clear-cache.c
> @@ -130,11 +130,9 @@ static int check_free_space_tree(struct btrfs_root *root)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	struct btrfs_key key = { 0 };
                               ^^^^^
Like here

> -	struct btrfs_path path;
> +	struct btrfs_path path = {};

You should have used { 0 } to initialize the path. I can script the
change in the whole patch, no need to resend.

>  	int ret = 0;
>  
> -	btrfs_init_path(&path);
> -
>  	while (1) {
>  		struct btrfs_block_group *bg;
>  		u64 cur_start = key.objectid;
