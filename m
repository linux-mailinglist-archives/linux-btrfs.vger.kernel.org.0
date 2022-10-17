Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDB86015EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 20:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJQSHa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 14:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJQSH3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 14:07:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5E85C958
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 11:07:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4F3542061F;
        Mon, 17 Oct 2022 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666030047;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BVD4naRH6za1WX5Np4Vv3XAZ/fT7/Bg7cMvhHwpGDjI=;
        b=WzgYWzngX4LNChYAi09njZYZ9IpQ4rr19hMF2DV7uwB5g/w8n94Oi8QYLKLJq6/z0oYwEy
        xsaffGoj5SBrnb1fuTF6tqq8B6yhw5O56M9Yk6dkAc+KpjgxbEtr5yMxc9kl8tRDNyRaV3
        1LfliE/ceobV4iwmNNMmoW335KNqZmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666030047;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BVD4naRH6za1WX5Np4Vv3XAZ/fT7/Bg7cMvhHwpGDjI=;
        b=di/yfORZ5I8kbvYflcJFDolvh6JALskGHsMnnnxZHhpwHg5NOh3IyLUyBZT+ykIiN00zP2
        t5BYW6qRcEJIgrAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B8B113ABE;
        Mon, 17 Oct 2022 18:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9NTIBd+ZTWOrcQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 17 Oct 2022 18:07:27 +0000
Date:   Mon, 17 Oct 2022 20:07:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: make btrfs module init/exit match their
 sequence
Message-ID: <20221017180717.GS13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 12, 2022 at 05:22:35PM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> In theory init_btrfs_fs() and exit_btrfs_fs() should match their
> sequence, thus normally they should look like this:
> 
>     init_btrfs_fs()   |   exit_btrfs_fs()
> ----------------------+------------------------
>     init_A();         |
>     init_B();         |
>     init_C();         |
>                       |   exit_C();
>                       |   exit_B();
>                       |   exit_A();
> 
> So is for the error path of init_btrfs_fs().
> 
> But it's not the case, some exit functions don't match their init
> functions sequence in init_btrfs_fs().
> 
> Furthermore in init_btrfs_fs(), we need to have a new error tag for each
> new init function we added.
> This is not really expandable, especially recently we may add several
> new functions to init_btrfs_fs().
> 
> [ENHANCEMENT]
> The patch will introduce the following things to enhance the situation:
> 
> - struct init_sequence
>   Just a wrapper of init and exit function pointers.
> 
>   The init function must use int type as return value, thus some init
>   functions need to be updated to return 0.
> 
>   The exit function can be NULL, as there are some init sequence just
>   outputting a message.
> 
> - struct mod_init_seq[] array
>   This is a const array, recording all the initialization we need to do
>   in init_btrfs_fs(), and the order follows the old init_btrfs_fs().
> 
>   Only one modification in the order, now we call btrfs_print_mod_info()
>   after sanity checks.
>   As it makes no sense to print the mod into, and fail the sanity tests.

I've dropped the change and kept the original order.

> - bool mod_init_result[] array
>   This is a bool array, recording if we have initialized one entry in
>   mod_init_seq[].
> 
>   The reason to split mod_init_seq[] and mod_init_result[] is to avoid
>   section mismatch in reference.
> 
>   All init function are in .init.text, but if mod_init_seq[] records
>   the @initialized member it can no longer be const, thus will be put
>   into .data section, and cause modpost warning.
> 
> For init_btrfs_fs() we just call all init functions in their order in
> mod_init_seq[] array, and after each call, setting corresponding
> mod_init_result[] to true.
> 
> For exit_btrfs_fs() and error handling path of init_btrfs_fs(), we just
> iterate mod_init_seq[] in reverse order, and skip all uninitialized
> entry.
> 
> With this patch, init_btrfs_fs()/exit_btrfs_fs() will be much easier to
> expand and will always follow the strict order.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

> +error:
> +	/*
> +	 * If we call exit_btrfs_fs() it would cause section mismatch.
> +	 * As init_btrfs_fs() belongs to .init.text, while exit_btrfs_fs()
> +	 * belongs to .exit.text.
> +	 */
> +	for (i = ARRAY_SIZE(mod_init_seq) - 1; i >= 0; i--) {
> +		if (!mod_init_result[i])
> +			continue;
> +		if (mod_init_seq[i].exit_func)
> +			mod_init_seq[i].exit_func();
> +		mod_init_result[i] = false;
> +	}
> +	return ret;

The duplication of this code will be discussed in a separate patch that
Anand sent.
