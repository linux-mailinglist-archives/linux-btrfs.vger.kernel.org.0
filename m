Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFAA64CF46
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 19:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiLNSR4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 13:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLNSRz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 13:17:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6233764C9
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 10:17:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 145AC2209B;
        Wed, 14 Dec 2022 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671041873;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q87C/qLVa2TgMkR2CNrMuWfAC41lTBMXmCBwckmWejk=;
        b=UQqAhw8AYLVd2C6bW7N4Ur1E0i5JqS5RhtS6wXBimWZ7uUYkeyye+I6ODlm7VzAmeRAiyE
        5QujA4ae2Jrq0j3ibdektXhep7x9mzid6cvZqQHr9mOCqo8vaty04RFV7EAL9UmRUVJDpz
        ST2NKjeLIqRUDRtIDcJDReVOrKtvuxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671041873;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q87C/qLVa2TgMkR2CNrMuWfAC41lTBMXmCBwckmWejk=;
        b=R8rpdk5l6xjTcIM9YGAcd3D+HC39PDrLTnc8DbJNddvE7NS1FRvgVm7EwKdXOADsEVm6fD
        b6owpC21uN7Uq3Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE674138F6;
        Wed, 14 Dec 2022 18:17:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7rNtOVATmmOmJAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Dec 2022 18:17:52 +0000
Date:   Wed, 14 Dec 2022 19:17:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: move btrfs_abort_transaction to transaction.c
Message-ID: <20221214181710.GH10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <edc2981f978e80b1cd1e4196dcf4a109831a6354.1670426276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edc2981f978e80b1cd1e4196dcf4a109831a6354.1670426276.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 07, 2022 at 10:18:04AM -0500, Josef Bacik wrote:
> While trying to sync messages.[ch] I ended up with this dependency on
> messages.h in the rest of the progs codebase because it's where
> btrfs_transaction_abort() was now held.  We want to keep messages.[ch]
> limited to the kernel code, and the btrfs_transaction_abort() code
> better fits in the transaction code and not in messages.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.

> @@ -178,39 +177,8 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
>  
>  const char * __attribute_const__ btrfs_decode_error(int errno);
>  
> -__cold
> -void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
> -			       const char *function,
> -			       unsigned int line, int errno, bool first_hit);
> -
>  bool __cold abort_should_print_stack(int errno);

This also belongs to the transaction abort API so I've moved it to
transaction.h as well.
