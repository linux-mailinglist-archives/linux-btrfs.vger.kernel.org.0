Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48AC4BE583
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Feb 2022 19:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351154AbiBUR0i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 12:26:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbiBUR0f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 12:26:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E9AE67
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 09:26:11 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B0AE2210F9;
        Mon, 21 Feb 2022 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645464370;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+ERr67PHte7rc5wTwAm5z3mZLnQxr7JzOHS371HH4s=;
        b=bbty4p/SSfabUfRobL4VR7XBJwCIxrHaGPunj9C/xxb32SPFAyORrg8GNMg0ao38Y+e+a8
        baTezabRssiGqcgRVOySsvEBcHabsUHvIQ6D33TL/KJvmRDNqKTO7bRt8NQVTDjyW4Ygdk
        ml7cmk2By8FzCb5NoA44E0M32nLlXO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645464370;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+ERr67PHte7rc5wTwAm5z3mZLnQxr7JzOHS371HH4s=;
        b=KuLDpoONGkXhanGKToBRZNkNMnNipomqHpH6EUI2LjWCesjjwCMs0MDuCqWIwGQCq1qOEu
        1zOQCXMTkiyFAkAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A9176A3B81;
        Mon, 21 Feb 2022 17:26:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6116DDA823; Mon, 21 Feb 2022 18:22:23 +0100 (CET)
Date:   Mon, 21 Feb 2022 18:22:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3 1/2] btrfs: defrag: bring back the old file extent
 search behavior
Message-ID: <20220221172223.GK12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1644561774.git.wqu@suse.com>
 <0dd2be27e93e7db12a3b83bdce48448a1f2f692f.1644561774.git.wqu@suse.com>
 <20220214161506.GD12643@twin.jikos.cz>
 <c372f57e-2ffc-6d6d-b656-5331464b53f0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c372f57e-2ffc-6d6d-b656-5331464b53f0@suse.com>
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

On Tue, Feb 15, 2022 at 08:02:35AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/15 00:15, David Sterba wrote:
> > On Fri, Feb 11, 2022 at 02:46:12PM +0800, Qu Wenruo wrote:
> >> @@ -1216,7 +1367,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
> >>   		u64 range_len;
> >>   
> >>   		last_is_target = false;
> >> -		em = defrag_lookup_extent(&inode->vfs_inode, cur, locked);
> >> +		em = defrag_lookup_extent(&inode->vfs_inode, cur,
> >> +					  ctrl->newer_than, locked);
> > 
> > This uses the ctrl structure, if this is also supposed to go to 5.16
> > please provide a version that applies, thanks.
> > 
> 
> The conflicts are already smaller enough for this patchset and later 
> autodefrag work.
> 
> I can easily do a manual backport for v5.16.

So the change is to use newer_than instead of ctrl->newer_then, right?
I'll use that so it does not depend on the ctrl patches.
