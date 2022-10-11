Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9389A5FAFBE
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 11:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJKJzm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 05:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJKJzd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 05:55:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEBC1581E
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 02:55:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C16FF1F8BA;
        Tue, 11 Oct 2022 09:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665482129;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeANXOf59WTaR0dH3VD0jzBQ2N6z5HBlv5bEwpWra/Q=;
        b=zU93NZ8Ya28G0NDwVjh2awUTOF73S8zmIjKtilkKxTZqgCdIH2svh5THQdn3zK5h8gfsER
        9R5SSN0DFxujEwrUTcOt9jNMigv6wfpzashVjfpVRGF68+7jtLpdE6o0kdxx3E6Q+W20cj
        k94VT7SAfI1qas72TMHyK/wcFH6Ol/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665482129;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeANXOf59WTaR0dH3VD0jzBQ2N6z5HBlv5bEwpWra/Q=;
        b=ukLca4PD1WI37xgLpCvxuvtQBNjiDIbp3eR6sabR/i/B6SEXGUxQQnszhQOnupFxyOOq7C
        4D0uS6IvczoYR8BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F360139ED;
        Tue, 11 Oct 2022 09:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6Un2IZE9RWN9BgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Oct 2022 09:55:29 +0000
Date:   Tue, 11 Oct 2022 11:55:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 04/16] btrfs: push extra checks into
 __btrfs_abort_transaction
Message-ID: <20221011095524.GK13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663175597.git.josef@toxicpanda.com>
 <6a4275319be8321bf3d87c2259a427ebdfa6d7cf.1663175597.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4275319be8321bf3d87c2259a427ebdfa6d7cf.1663175597.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 01:18:09PM -0400, Josef Bacik wrote:
> The btrfs_abort_transaction() macro uses quite a bit of flags and such
> that aren't local to btrfs-printk.h.  Push this code down into
> __btrfs_abort_transaction to allow for a cleaner header file.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> -#define btrfs_abort_transaction(trans, errno)		\
> -do {								\
> -	bool first = false;					\
> -	/* Report first abort since mount */			\
> -	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
> -			&((trans)->fs_info->fs_state))) {	\
> -		first = true;					\
> -		if ((errno) != -EIO && (errno) != -EROFS) {		\
> -			WARN(1, KERN_DEBUG				\
> -			"BTRFS: Transaction aborted (error %d)\n",	\
> -			(errno));					\

The point of this was to print the stack trace from the function where
it happens and not with btrfs_abort_transaction at the top. IIRC this
was confusing when people were reporting transaction abort and all the
reports were hard to distinguish because all were "warning in
__btrfs_transaction_abort:line".

1a9a8a71ed1d457d "btrfs: report exact callsite where transaction abort occurs"

> -		} else {						\
> -			btrfs_debug((trans)->fs_info,			\
> -				    "Transaction aborted (error %d)", \
> -				  (errno));			\
> -		}						\
> -	}							\
> -	__btrfs_abort_transaction((trans), __func__,		\
> -				  __LINE__, (errno), first);	\
> -} while (0)
