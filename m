Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6EB4D8D66
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 20:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244662AbiCNTxO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 15:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244842AbiCNTws (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 15:52:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18B3EF11
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 12:51:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BFDC3210F4;
        Mon, 14 Mar 2022 19:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647287437;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vH0aheAlmdFt/mlXQAlDxgQrGNsCxH4LFM/WJJ+/WV8=;
        b=W/JqpkVoIWsWnAZS+dMqax/CKSGh6MtP12IF/PtmWeaqsppbXW7lziK96q6/28qScHVb0Y
        1DmjZhaclHF7SyIuXV7NVlygZiO0oTDuiLCu26S0hfSQwMEjZpc6eLtvbu42CElbGZk31K
        H4pwzVSKh9HZBO5KQObPr63jSu2C/wQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647287437;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vH0aheAlmdFt/mlXQAlDxgQrGNsCxH4LFM/WJJ+/WV8=;
        b=2jquwKnJk0xOOY5NxOpJk+/QWDVXf+/sDlaW4RaoVxVg56+jjKLp6PwctzabHN0OnpcYfH
        IMuxnaqcQpwBo/DQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B8AB3A3BA3;
        Mon, 14 Mar 2022 19:50:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 69D62DA7E1; Mon, 14 Mar 2022 20:46:39 +0100 (CET)
Date:   Mon, 14 Mar 2022 20:46:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: scrub: big renaming to address the page and
 sector difference
Message-ID: <20220314194639.GS12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1645530899.git.wqu@suse.com>
 <20220310192900.GD12643@twin.jikos.cz>
 <90dd757a-10ed-2212-6f54-0bd349808dbb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90dd757a-10ed-2212-6f54-0bd349808dbb@gmx.com>
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

On Fri, Mar 11, 2022 at 07:26:12AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/3/11 03:29, David Sterba wrote:
> > On Tue, Feb 22, 2022 at 08:09:35PM +0800, Qu Wenruo wrote:
> >> >From the ancient day, btrfs doesn't support sectorsize < PAGE_SIZE, thus
> >> a lot of the old code consider one page == one sector, not only the
> >> behavior, but also the naming.
> >>
> >> This is no longer true after v5.16 since we have subpage support.
> >>
> >> One of the worst location is scrub, we have tons of things named like
> >> scrub_page, scrub_block::pagev, scrub_bio::pagev.
> >>
> >> Even scrub for subpage is supported, the naming is not touched yet.
> >>
> >> This patchset will first do the rename, providing the basis for later
> >> scrub enhancement for subpage.
> >>
> >> This patchset should not bring any behavior change.
> >>
> >> Qu Wenruo (3):
> >>    btrfs: scrub: rename members related to scrub_block::pagev
> >>    btrfs: scrub: rename scrub_page to scrub_sector
> >>    btrfs: scrub: rename scrub_bio::pagev and related members
> >
> > This conflicts with the scrub refactoring, but applies cleanly on
> > misc-next. I think the rename could go in first as it's a less risky
> > change and any fixups or fine tuning of the refactoring would not affect
> > it.
> 
> No problem, since it applies cleanly, I don't need to send a refreshed
> version, right?
> 
> I'll re-arrange all the scrub related patches in my local branch, the
> planned sequence would be (also the future submission sequence):
> 
> 1. Rename
> 
> 2. Entrance refactor
> 
> 3. Subpage optimization
> 
> Would that look OK for you?

Yeah that should work, thanks.
