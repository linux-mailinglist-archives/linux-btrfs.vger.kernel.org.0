Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02EB4AE3A0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 23:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386903AbiBHWVp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 17:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387251AbiBHWNG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 17:13:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC99DC0612B8
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 14:13:05 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C26A210E7;
        Tue,  8 Feb 2022 22:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644358384;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2wcMO/ZY2l/2I7QE8OIXWK+fsig3OuMkLJ5MyN/El0=;
        b=sJ0vV9DTU9OqtQdAXeaC7E7YPlJFatZ3n3vXsTFIg8wrVAeEJmlA9NbkFa2SEyt5zSyfM4
        2losqh5Q04tJt0N0WaL2iLy6eE5H/kWduqdl4YE5C19nWVL5lVsQAouPua/c1SbCddIWI2
        5iWCo4H73vqpLed7zTTfOoOsrSSRPVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644358384;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2wcMO/ZY2l/2I7QE8OIXWK+fsig3OuMkLJ5MyN/El0=;
        b=Kw+ZXTfvyPrSFLFrl+bQ0cneTe36jRELeZU3FZ0zlW6stLXQfkEilS5urtA9KAJNU0JpPt
        d840q2bvg58fo8CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7278CA3B85;
        Tue,  8 Feb 2022 22:13:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 01BB8DAB3F; Tue,  8 Feb 2022 23:09:23 +0100 (CET)
Date:   Tue, 8 Feb 2022 23:09:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/5] btrfs: defrag: don't waste CPU time on non-target
 extent
Message-ID: <20220208220923.GH12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1644039494.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1644039494.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 05, 2022 at 01:41:01PM +0800, Qu Wenruo wrote:
> In the rework of btrfs_defrag_file() one core idea is to defrag cluster
> by cluster, thus we can have a better layered code structure, just like
> what we have now:
> 
> btrfs_defrag_file()
> |- defrag_one_cluster()
>    |- defrag_one_range()
>       |- defrag_one_locked_range()
> 
> But there is a catch, btrfs_defrag_file() just moves the cluster to the
> next cluster, never considering cases like the current extent is already
> too large, we can skip to its end directly.
> 
> This increases CPU usage on very large but not fragmented files.
> 
> Fix the behavior in defrag_one_cluster() that, defrag_collect_targets()
> will reports where next search should start from.
> 
> If the current extent is not a target at all, then we can jump to the
> end of that non-target extent to save time.
> 
> To get the missing optimization, also introduce a new structure,
> btrfs_defrag_ctrl, so we don't need to pass things like @newer_than and
> @max_to_defrag around.

Is this patchset supposed to be in 5.16 as fix for some defrag problem?
If yes, the patch switching to the control structure should be avoided
and done as a post cleanup as some other patches depend on it.
