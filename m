Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA95F7C1F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 19:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJGRQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 13:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGRQQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 13:16:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8335CD019F
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 10:16:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A4F1210EB;
        Fri,  7 Oct 2022 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665162973;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IHa5GxG1SR99Lt2SLTHjhHOyjgrBuzUw5BLsOAniuk8=;
        b=mPnKh7XJh8IKtVQqeTOqeb1wSYszwga0U2Z3lFu/UFuXf7c52XcGUkuzFGryYbn9u0hw/S
        GMaZ9+Z3qPxO0vK4T7ECbruhslmukLXuIfI3AifYQO9z3ZMQUC0BuCpVekp/kYXUqQNh5C
        t6trkQOzDSjDbs62Gtv9j6tyP889s0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665162973;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IHa5GxG1SR99Lt2SLTHjhHOyjgrBuzUw5BLsOAniuk8=;
        b=Vh7nX9nvWOKcbyXC8r8JCm365G3DrtFMtrlVVEtwT13J82kbpzUPlYNalkdw1Xk5Owsxld
        uuh6a3vDadtnEPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1034313A9A;
        Fri,  7 Oct 2022 17:16:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nzXlAt1eQGNtVgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 07 Oct 2022 17:16:13 +0000
Date:   Fri, 7 Oct 2022 19:16:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 08/17] btrfs: move discard stat defs to free-space-cache.h
Message-ID: <20221007171609.GX13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663167823.git.josef@toxicpanda.com>
 <5e7f34e068513a3a82b3bc810bc92a0eb0254863.1663167823.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7f34e068513a3a82b3bc810bc92a0eb0254863.1663167823.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 11:06:32AM -0400, Josef Bacik wrote:
> These definitions are used for discard statistics, move them out of
> ctree.h and put them in free-space-cache.h.

Maybe it's in another patchset, but I'll note it here, there are some
discard related defitions in ctree.h so the BTRFS_STAT_* should go there
once we have such header.
