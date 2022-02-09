Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA5A4AF51E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 16:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbiBIPXB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 10:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiBIPXB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 10:23:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745A6C0613C9
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 07:23:04 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E7F0B1F383;
        Wed,  9 Feb 2022 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644420182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jI4C9gM+Ex0GnHG+/ctpbIuwVk+MxDGHsAMrsTUIL9U=;
        b=RvWoxv0BIamEOt3JWNPAqBHWj18hkNi0Q3Ww3/3XkEPhu8ZxKCymHFFItbL3ay4XRsJuKB
        4j83zqFv8fvHfNNW63I4jkU2iy5zVnqujScAn78DqgEMdqoxeBAvqsYgo3jswfG4+m/eJj
        j56P1AI5pOPW8d6nW4XVqbgrml9YQ1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644420182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jI4C9gM+Ex0GnHG+/ctpbIuwVk+MxDGHsAMrsTUIL9U=;
        b=vxKYCG0s8DrX2zfIexdalBeFAGl63dp9ktHdv/EB3EELuFegCQbUeq45S8UtT+myswhIfU
        O5IaHy0USbfxZmDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DFAD4A3B8D;
        Wed,  9 Feb 2022 15:23:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 15ED8DA989; Wed,  9 Feb 2022 16:19:22 +0100 (CET)
Date:   Wed, 9 Feb 2022 16:19:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/5] btrfs: defrag: don't waste CPU time on non-target
 extent
Message-ID: <20220209151921.GK12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1644039494.git.wqu@suse.com>
 <20220208220923.GH12643@twin.jikos.cz>
 <b50e1856-f03e-8570-6283-54e5f673a040@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b50e1856-f03e-8570-6283-54e5f673a040@gmx.com>
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

On Wed, Feb 09, 2022 at 08:17:27AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/9 06:09, David Sterba wrote:
> > On Sat, Feb 05, 2022 at 01:41:01PM +0800, Qu Wenruo wrote:
> >> In the rework of btrfs_defrag_file() one core idea is to defrag cluster
> >> by cluster, thus we can have a better layered code structure, just like
> >> what we have now:
> >>
> >> btrfs_defrag_file()
> >> |- defrag_one_cluster()
> >>     |- defrag_one_range()
> >>        |- defrag_one_locked_range()
> >>
> >> But there is a catch, btrfs_defrag_file() just moves the cluster to the
> >> next cluster, never considering cases like the current extent is already
> >> too large, we can skip to its end directly.
> >>
> >> This increases CPU usage on very large but not fragmented files.
> >>
> >> Fix the behavior in defrag_one_cluster() that, defrag_collect_targets()
> >> will reports where next search should start from.
> >>
> >> If the current extent is not a target at all, then we can jump to the
> >> end of that non-target extent to save time.
> >>
> >> To get the missing optimization, also introduce a new structure,
> >> btrfs_defrag_ctrl, so we don't need to pass things like @newer_than and
> >> @max_to_defrag around.
> >
> > Is this patchset supposed to be in 5.16 as fix for some defrag problem?
> > If yes, the patch switching to the control structure should be avoided
> > and done as a post cleanup as some other patches depend on it.
> 
> I can backport it manually to v5.16 without the ctrl refactor.

That's not great if we have to do two versions, and more fixes to defrag
are still expected so a cleanup patch makes any backporting harder. That
we can send a manually ported version to stable is there for cases when
the changes are not possible. In this case the cleanup is not necessary,
but I understand it makes the code cleaner. Given that we need to fix a
released kernel it's the preference.
