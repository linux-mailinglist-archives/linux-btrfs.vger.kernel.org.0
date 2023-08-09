Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA6577697D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 22:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjHIUIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 16:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjHIUIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 16:08:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD82210CF
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 13:08:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E3E421871;
        Wed,  9 Aug 2023 20:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691611712;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6pE/fACLNX828NvGWdzAHJspjKo71yyhHmpihvaOA6M=;
        b=tctjc/VVhRnF2h00XpZCEPgo/0Za8Bu4ZDuYtvpE8VRTsvRVo4zIl91FpB74RrSuGKUwdk
        W0BVwe545m9xmnSTpfdUHfSJhVLPWp0NgVW5Pdj3X3nODw1Zu2gR1xEzWVY78a93jLn79M
        S6X0N0Z7tgAQ+N8eHlGWcC3PV5FmFr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691611712;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6pE/fACLNX828NvGWdzAHJspjKo71yyhHmpihvaOA6M=;
        b=6z4HgkezqA/+3MPB+I2041/nwjBE6BNsjQ3FZ4B/8Vv4+TiNxSUedbtG13AyqzvbUPNiCl
        jvmPh/fiXDkdTvBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8359F13251;
        Wed,  9 Aug 2023 20:08:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1a4rH0Dy02TVQAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Aug 2023 20:08:32 +0000
Date:   Wed, 9 Aug 2023 22:08:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: set cache_block_group_error if we find an error
Message-ID: <ZNPyPwjVGw9mU0s_@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <8717f1907f699058ab6a6941c007ad43c903a3ca.1690982408.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8717f1907f699058ab6a6941c007ad43c903a3ca.1690982408.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 02, 2023 at 09:20:24AM -0400, Josef Bacik wrote:
> We set cache_block_group_error if btrfs_cache_block_group() returns an
> error, this is because we could end up not finding space to allocate and
> mistakenly return -ENOSPC, and which could then abort the transaction
> with the incorrect errno, and in the case of ENOSPC result in a
> WARN_ON() that will trip up tests like generic/475.
> 
> However there's the case where multiple threads can be racing, one
> thread gets the proper error, and the other thread doesn't actually call
> btrfs_cache_block_group(), it instead sees ->cached ==
> BTRFS_CACHE_ERROR.  Again the result is the same, we fail to allocate
> our space and return -ENOSPC.  Instead we need to set
> cache_block_group_error to -EIO in this case to make sure that if we do
> not make our allocation we get the appropriate error returned back to
> the caller.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
