Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4B44B7201
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 17:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbiBOPtY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 10:49:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiBOPtX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 10:49:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D10EDD
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 07:49:12 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 26FCE1F37B;
        Tue, 15 Feb 2022 15:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644940151;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dcswK+I6ToRL6zjNkQChY0De60ebuw9Kj+2U/R+QVw=;
        b=GqcHfHptMmmNj0fykVidf0aeIbXjvsfx/UAn2WpcypoBvYnQKUM3Xni8cgiCOLxmN0w/X9
        dB868uf8MMroGVC8bFPYHyaGpGTeYgjZEdiLmnjQ8OcuvBB5CiYdn5m6RHPWDZMUESu238
        SAICCFbHwEa1HCRsY0jAhZEyRm1vyTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644940151;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dcswK+I6ToRL6zjNkQChY0De60ebuw9Kj+2U/R+QVw=;
        b=9vdWxsyySrblJLS+2iVt37j+RFH97RxcH+oKPmoqHhEKQ/d8Qv/9HrXwEWLWePj/EmJAjt
        UKlbbAns+fKh3zCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1F528A3B8C;
        Tue, 15 Feb 2022 15:49:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1B7E0DA818; Tue, 15 Feb 2022 16:45:27 +0100 (CET)
Date:   Tue, 15 Feb 2022 16:45:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/5] btrfs: defrag: don't waste CPU time on non-target
 extent
Message-ID: <20220215154526.GO12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1644561438.git.wqu@suse.com>
 <20220214164011.GG12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214164011.GG12643@twin.jikos.cz>
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

On Mon, Feb 14, 2022 at 05:40:11PM +0100, David Sterba wrote:
> On Fri, Feb 11, 2022 at 02:41:38PM +0800, Qu Wenruo wrote:
> > Changelog:
> > v2:
> > - Rebased to lastest misc-next
> >   Just one small conflict with static_assert() update.
> >   And this time only those patches are rebased to misc-next, thus it may
> >   cause conflicts with fixes for defrag_check_next_extent() in the
> >   future.
> > 
> > - Several grammar fixes
> > 
> > - Report accurate btrfs_defrag_ctrl::sectors_defragged
> >   This is inspired by a comment from Filipe that the skip check
> >   should be done in the defrag_collect_targets() call inside
> >   defrag_one_range().
> > 
> >   This results a new patch in v2.
> > 
> > - Change the timing of btrfs_defrag_ctrl::last_scanned update
> >   Now it's updated inside defrag_one_range(), which will give
> >   us an accurate view, unlike the previous call site in
> >   defrag_one_cluster().
> > 
> > - Don't change the timing of extent threshold.
> > 
> > - Rename @last_target to @last_is_target in defrag_collect_targets()
> > 
> > v3:
> > - Add Reviewed-by tags
> > 
> > - Fix a wrong value in commit message of the 1st patch
> > 
> > - Make @orig_start const for the 3rd patch
> > 
> > - Fix a missing word "skip" in the 5th patch
> > 
> > - Remove one unnecessary assignment in the 5th patch
> >   As we don't return the defragged sectors to user space.
> > 
> > v4:
> > - Move the skip behavior before the btrfs_defrag_ctrl refactor
> >   So it can be backported to v5.16
> 
> Thanks, I've picked the patch to misc-next. I'm not sure about the rest
> because of the ctrl structure cleanup and there are still some pending
> defrag fixes. So I'll add the remainig patches as topic branch for
> testing.

Rest of the patchset added to misc-next, as the remaining fixups ported
to older stable trees will be easy enough.
