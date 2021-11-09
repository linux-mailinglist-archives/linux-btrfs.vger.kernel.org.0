Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EEF44ADA8
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 13:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbhKIMmc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 07:42:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55470 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhKIMmb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 07:42:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2B6E51FDBD;
        Tue,  9 Nov 2021 12:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636461585;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A2dGATSIxsnb1dBVVRfxlKHXoBesq2ja/xDf8V2f8iY=;
        b=BdAPVuhlFF8yf56/0scKAKrNPrm4HACsocURlO0zKwQy8Tdi/5lpPMMUdWVaFKYw9ZSL8E
        FGUTV19zA+73KbRBOEcEyEqCWyHLj3LKqB4wGVf2VGnInYgr9hHpKSo33VrAv5MSaOtfDs
        aQyF/oxUdq7Ef2hI4U69IFlLxJemgcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636461585;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A2dGATSIxsnb1dBVVRfxlKHXoBesq2ja/xDf8V2f8iY=;
        b=AFl5G9eqgkPG+R+g3mdYsz26DnMYanrpMiN98Mo/1u4A9lUaywbzbDVXiU8APqfXvz//2x
        rvU8DNDp1sHx59CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 223C4A3BBE;
        Tue,  9 Nov 2021 12:39:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1C734DA799; Tue,  9 Nov 2021 13:39:05 +0100 (CET)
Date:   Tue, 9 Nov 2021 13:39:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3] btrfs: fix deadlock due to page faults during direct
 IO reads and writes
Message-ID: <20211109123905.GQ28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <e6366328b37847ce815502beaeaf2cce7a9af874.1631096590.git.fdmanana@suse.com>
 <f0788b3a28eaee71b924310561805ee19a9c8a10.1635178976.git.fdmanana@suse.com>
 <CAL3q7H7yx7CnZejovz+fFtaKsfLRr9CSmC5NBRbE-g+FWr_B9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7yx7CnZejovz+fFtaKsfLRr9CSmC5NBRbE-g+FWr_B9w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 09, 2021 at 11:27:25AM +0000, Filipe Manana wrote:
> On Mon, Oct 25, 2021 at 10:25 PM <fdmanana@kernel.org> wrote:
> >    "[PATCH v8 00/19] gfs2: Fix mmap + page fault deadlocks"
> >
> > The thread can be found at:
> >
> > https://lore.kernel.org/linux-fsdevel/20211019134204.3382645-1-agruenba@redhat.com/
> 
> David, Linus merged that patchset (v9 actually, but without any impact
> on this patch) last week, in merge commit
> c03098d4b9ad76bca2966a8769dcfe59f7f85103.
> Do you want me to update the change log to mention it was already
> merged (and which commit)?

Not needed, I'll update the reference and send a pull request based on
the merge. Thanks.
