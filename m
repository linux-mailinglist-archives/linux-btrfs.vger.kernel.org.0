Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55459FE14
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 17:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbiHXPRc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 11:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiHXPRa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 11:17:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389359751A
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 08:17:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E0B572083F;
        Wed, 24 Aug 2022 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661354248;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YTL1B5rQXTeEfKTtffHQDxRR73sbsvpwHGvHG2c7dTM=;
        b=lC/3crF4xeV3sWHVatV2cKZZ6HmWf+sFo7MCgjVIXTqL04WNxw5LkKZDPlUOPUgPSxBZZT
        gT/wCLjumn6J6iPeIaBSkGnNnbkA1rGQG9ZE27O1idPxAdGt/z27neSk9QEMFAEjFGPRZx
        fYNyKc/41nVjJfWKoxSvBIrqvtPhYG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661354248;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YTL1B5rQXTeEfKTtffHQDxRR73sbsvpwHGvHG2c7dTM=;
        b=Nctta82JW7iRuKUa1RgL/dnKXH59DZDxf6mKqvbOiAzqYO1q3N0FG2wDGqX7MTkHuQMAzO
        Ow30MnaTifRi5dAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF3D813AC0;
        Wed, 24 Aug 2022 15:17:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0X1CLQhBBmN5GwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 24 Aug 2022 15:17:28 +0000
Date:   Wed, 24 Aug 2022 17:12:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs: fix a lockdep_assert_locked() warning
Message-ID: <20220824151213.GW13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1659989333.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659989333.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 08, 2022 at 04:10:25PM -0400, Josef Bacik wrote:
> Hello,
> 
> With discard=async we're hitting a lockdep_assert_locked() in generic/475 in our
> CI setup.  This just popped up recently because before lockdep would get
> disabled before it got this far.  This series fixes the problem, and then
> cleans up the cleanup functions to reduce the code and exported functions.
> Thanks,
> 
> Josef
> 
> Josef Bacik (2):
>   btrfs: call __btrfs_remove_free_space_cache_locked on cache load
>     failure
>   btrfs: remove use btrfs_remove_free_space_cache instead of variant

Moved from topic branch to misc-next, I haven't changed the loop
iteration to the postorder macro, that can be done later.
