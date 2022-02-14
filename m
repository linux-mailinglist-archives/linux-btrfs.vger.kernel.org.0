Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9170E4B59DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Feb 2022 19:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiBNS1J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 13:27:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiBNS1I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 13:27:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C0496BB
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 10:27:00 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DFDC5210FA;
        Mon, 14 Feb 2022 18:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644863218;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YYRf8LlK9HvPIaM9ED13TKeUxc94xhEcmlQvMDlxwGU=;
        b=S+7X+7ICu2Yx6+qMgjIrv/RCgSOs7CHa6L87xc6DcpW1OQn8yrCn/frWhBelU8N0jfdAea
        B402WLp6Wp2+PGSFGP6C3D/OKpgXIjGgCwEy4NRq63kQxib83PHqtMKDnEPeiG6DCCyxwY
        ZriN2cpNFOFv3F2mOlonH5DEAgOhWdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644863218;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YYRf8LlK9HvPIaM9ED13TKeUxc94xhEcmlQvMDlxwGU=;
        b=yQDSaoST9VOPQRh1gfB1WGxIQ1QHNDBS3QQ0AMWOcqa3Y2RKjMCfuw9Z9GOhokrtPWQZvq
        fS0LCnrM3sjNM7AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D99BDA3B81;
        Mon, 14 Feb 2022 18:26:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 11851DA832; Mon, 14 Feb 2022 19:23:14 +0100 (CET)
Date:   Mon, 14 Feb 2022 19:23:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/3] btrfs: fixes for defrag_check_next_extent()
Message-ID: <20220214182314.GK12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1643354254.git.wqu@suse.com>
 <20220128215438.GJ14046@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128215438.GJ14046@twin.jikos.cz>
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

On Fri, Jan 28, 2022 at 10:54:38PM +0100, David Sterba wrote:
> On Fri, Jan 28, 2022 at 03:21:19PM +0800, Qu Wenruo wrote:
> > That function is reused between older kernels (v5.15) and the refactored
> > defrag code (v5.16+).
> > 
> > However that function has one long existing bugs affecting defrag to
> > handle preallocated range.
> > 
> > And it can not handle compressed extent well neither.
> > 
> > Finally there is an ambiguous check which doesn't make much sense by
> > itself, and can be related by enhanced extent capacity check.
> > 
> > This series will fix all the 3 problem mentioned above.
> > 
> > Changelog:
> > v2:
> > - Use @extent_thresh from caller to replace the harded coded threshold
> >   Now caller has full control over the extent threshold value.
> > 
> > - Remove the old ambiguous check based on physical address
> >   The original check is too specific, only reject extents which are
> >   physically adjacent, AND too large.
> >   Since we have correct size check now, and the physically adjacent check
> >   is not always a win.
> >   So remove the old check completely.
> > 
> > v3:
> > - Split the @extent_thresh and physicall adjacent check into other
> >   patches
> > 
> > - Simplify the comment 
> > 
> > v4:
> > - Fix the @em usage which should be @next.
> >   As it will fail the submitted test case.
> > 
> > Qu Wenruo (3):
> >   btrfs: defrag: don't try to merge regular extents with preallocated
> >     extents
> >   btrfs: defrag: don't defrag extents which is already at its max
> >     capacity
> >   btrfs: defrag: remove an ambiguous condition for rejection
> 
> Added as topic branch to for-next, thanks.

Moved to misc-next.
