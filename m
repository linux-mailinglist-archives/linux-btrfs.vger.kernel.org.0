Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEBE62F9C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 16:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiKRPy4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 10:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiKRPyz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 10:54:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981747D50A
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 07:54:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 44C961FCE0;
        Fri, 18 Nov 2022 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668786893;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k9VUygHnFK6SFqJy/3DXOey/N/NArZblIxppIBjtn2M=;
        b=J6xzCZNJH4fpubj7udsoVxjkUK0RMPIWwXpJUtG0g5Xk0sLX6ptKPXAI7KUR7syJUwoy3Z
        Q8w1rMDVBl8hk3jXQadSzad3+xJEiIwaCGR67ZbrXk4ct+ikgb/woYNYpwZ20MOZxzNOO2
        j8rb3Y64TXSSB/VpsFDiFzan8FpyNF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668786893;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k9VUygHnFK6SFqJy/3DXOey/N/NArZblIxppIBjtn2M=;
        b=3de6tW/ooVy01EkXzvcGpzFkGgTubndYO810VKp97+xLjnAHCKqqK1qs8H03y9RwNq3d5a
        7pNgkw0tbt5pESBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2385C13A66;
        Fri, 18 Nov 2022 15:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l5C1B82qd2OodQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 18 Nov 2022 15:54:53 +0000
Date:   Fri, 18 Nov 2022 16:54:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: do not try to handle a ticket for FLUSH_EMERGENCY
Message-ID: <20221118155425.GP5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1f314a6e586b0725b84eb906efbfdafd10890c59.1668696886.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f314a6e586b0725b84eb906efbfdafd10890c59.1668696886.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 17, 2022 at 09:54:56AM -0500, Josef Bacik wrote:
> Even though it is unlikely, we can still fail
> BTRFS_RESERVE_FLUSH_EMERGENCY sometimes.  Unfortunately the condition to
> check if we should just return the error only checks for NO_FLUSH, and
> thus we could get into handle_reserve_ticket with FLUSH_EMERGENCY, which
> has the equivalent assertion of ASSERT(flush != FLUSH_EMERGENCY && flush
> != NO_FLUSH).  Fix this by changing the condition at the end of
> __reserve_bytes to check !can_ticket(flush) to handle both of these
> cases properly.
> 
> Fixes: dfed100c66b2 ("btrfs: introduce BTRFS_RESERVE_FLUSH_EMERGENCY")
> Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Folded to the patch, thanks.
