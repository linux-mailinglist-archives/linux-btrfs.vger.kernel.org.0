Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CD46A11B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 22:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBWVLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 16:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBWVLJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 16:11:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870C35D476
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 13:10:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3ED2E337BC;
        Thu, 23 Feb 2023 21:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677186638;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+bpElEP4iECCi4fedEMJkSoNNFrGYMUNxzNfMJQxtdU=;
        b=BBhNTBlzHu2r2QCFyZUFIUd5ooyavSunxt14E0hxbfMdKQhlG/Jw47PtQOxuG9HWroSODd
        kFhemuMELlPAFyaLluGhAgErxIu1uHx8Hj6/BuWzu8x8U7jaDb0LjTYBoAQKphxqHHAOkS
        VEnX/siXSo01PlHBugEqgAkW5F19w+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677186638;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+bpElEP4iECCi4fedEMJkSoNNFrGYMUNxzNfMJQxtdU=;
        b=jfM1WUOkFgMikQDvsLU2x+rDDj6Asf7gPvmQro33y1kjjf00QrXkH4gFe7pvb/8Gfo97/4
        SzrJcZoBqNRhCPBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FD8413928;
        Thu, 23 Feb 2023 21:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hj/yBk7W92P7bgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Feb 2023 21:10:38 +0000
Date:   Thu, 23 Feb 2023 22:04:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Forza <forza@tnonline.net>
Subject: Re: [PATCH] btrfs: fix percent calculation for reclaim message
Message-ID: <20230223210441.GC10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6107ccae94e0af75c60d1d1f6a5a0dd59aaafc58.1677003060.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6107ccae94e0af75c60d1d1f6a5a0dd59aaafc58.1677003060.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 10:11:24AM -0800, Johannes Thumshirn wrote:
> We have a report, that the info message for block-group reclaim is crossing the
> 100% used mark.
> 
> This is happening as we were truncaating the divisor for the division (the
> block_group->length) to a 32bit value.
> 
> Fix this by using div64_u64() to not truncate the divisor.
> 
> Reported-by: Forza <forza@tnonline.net>
> Link: https://lore.kernel.org/linux-btrfs/e99483.c11a58d.1863591ca52@tnonline.net/
> Fixes: 5f93e776c673 ("btrfs: zoned: print unusable percentage when reclaiming block groups")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next with Qu's note how to possibly reproduce it, thanks.
