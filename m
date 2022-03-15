Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD414DA3BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 21:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351551AbiCOUK2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 16:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiCOUK1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 16:10:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B1F3BBC4
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 13:09:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C529721902;
        Tue, 15 Mar 2022 20:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647374953;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4DXy8ZRhbJjdpiuVp94DK0E9cywd3Zg+y/LggzQRcaI=;
        b=sChDY/IKPWISdmHvHD8g0shitObpHJJZVMHWfQmgq2nzboD1+0f8fUlVeljteKvGFflwUB
        hmPoBDm5kTWfbRcyBUjkvi/Xe7YuMBuJZdk5FnukahqAkEgiJEXHbIKaVmGWiHUpVWOCQ7
        xAl2MVi8CMf+50NRD8AqcktAdhTZF+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647374953;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4DXy8ZRhbJjdpiuVp94DK0E9cywd3Zg+y/LggzQRcaI=;
        b=UUB2V8knIf/xLp1W9NDbDCXzolJKtVUFGnzoL1TT3ni1SZhTD6ndkA8D61xKrYlu9aWO8N
        by9W2OGF+UiH2qBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BD623A3B83;
        Tue, 15 Mar 2022 20:09:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EE2A6DA7E1; Tue, 15 Mar 2022 21:05:14 +0100 (CET)
Date:   Tue, 15 Mar 2022 21:05:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make enough noise for fstests to catch extent
 buffer leakage
Message-ID: <20220315200514.GX12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <e29bd3f7a0b167cc6d7a6e40f8b3b62b88a64fc3.1647338477.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e29bd3f7a0b167cc6d7a6e40f8b3b62b88a64fc3.1647338477.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 15, 2022 at 06:01:33PM +0800, Qu Wenruo wrote:
> Although we have btrfs_extent_buffer_leak_debug_check() (enabled by
> CONFIG_BTRFS_DEBUG option) to detect and warn QA testers that we have
> some extent buffer leakage, it's just pr_err(), not noisy enough for
> fstests to cache.
> 
> So here we trigger a WARN_ON_ONCE() if the allocated_ebs list is not
> empty.

I agree with Filipe that a WARN_ON is better here, changed and added to
misc-next, thanks.
