Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802A9589D40
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiHDOKK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 10:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiHDOKJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 10:10:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0287E43300
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 07:10:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B12064E4DF;
        Thu,  4 Aug 2022 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659622206;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MHsxHF8aIApzNZQb+FllpikbUE8zOJXSG6CkRVVxz54=;
        b=zYz1zCyCscLcsfaCWH5inQHbnOvhjUjXtv1NBPhd4mKo7mjL/oU52pijqwC3X0U2817KFS
        2au61pJK/DH1uFZB8nClE5qMusBvQjdyebSSpoXfT85lbCBN/lB7m5BUbADhCnPn56sHd7
        yciCJDXikymqD26f2xwy0Leldy6Ltt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659622206;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MHsxHF8aIApzNZQb+FllpikbUE8zOJXSG6CkRVVxz54=;
        b=NUPo8PiZb2FLaoXvy8fg+HWNHQbShFKdMzbLBGtP7t9h/Wptwcl83X47LSgoqWYD3LlHvy
        DOc3lIjyciggk4CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8ECDE13434;
        Thu,  4 Aug 2022 14:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6HvXIT7T62IcbwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 04 Aug 2022 14:10:06 +0000
Date:   Thu, 4 Aug 2022 16:05:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: scrub: small enhancement related to super
 block errors
Message-ID: <20220804140503.GN13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1659423009.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659423009.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 02, 2022 at 02:53:01PM +0800, Qu Wenruo wrote:
> Recently during a new test case to verify btrfs can handle a fully
> corrupted disk (but with a good primary super block), I found that scrub
> doesn't really try to repair super blocks.
> 
> And scrub doesn't report super block errors in dmesg either.
> 
> So this small patchset is to fix the problems by:
> 
> - Add explicit error messages for super block errors
> - Try to fix super block errors by committing a transaction
> 
> Qu Wenruo (2):
>   btrfs: scrub: properly report super block errors in dmesg
>   btrfs: scrub: try to fix super block errors

Added to misc-next, thanks.
