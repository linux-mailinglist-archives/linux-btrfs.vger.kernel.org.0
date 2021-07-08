Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFE13BF904
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 13:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhGHLcS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 07:32:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52032 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhGHLcR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 07:32:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2106520201;
        Thu,  8 Jul 2021 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625743775;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJS1vNII59JtzkhMn89hRKO2zi+UUI8eOr/Lcxeq6So=;
        b=qQrhHMKEiH1n2JFPqLQa0DAgs2mYuQDro9Y49JMzLtWaTS36li64q1UlQggGH98d6mjfLq
        IL3Yg9AMRpn2Y/wiqXJuSRrGhA1O0+CP9Tad56HCkMrc9YXbzRmJtLd3gSQzv7ozLPpMlZ
        rSyiSpbTx70ZOGEq6qq72i+noihCfRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625743775;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJS1vNII59JtzkhMn89hRKO2zi+UUI8eOr/Lcxeq6So=;
        b=OI7b0cDtJi1Aj8QxVLBIP5mnwUmmdeJTa32DjEeisbFrbI3wWtgn+5ny+sWkL6H+yIdDMT
        q9YpED7G7uesbzBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 187A2A3B88;
        Thu,  8 Jul 2021 11:29:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DEE72DAF79; Thu,  8 Jul 2021 13:27:00 +0200 (CEST)
Date:   Thu, 8 Jul 2021 13:27:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v6 00/15] btrfs: add data write support for subpage
Message-ID: <20210708112700.GW2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210705020110.89358-1-wqu@suse.com>
 <5ad76de9-d1df-cafa-f5c3-44e316e0fb23@suse.com>
 <CAEg-Je8A=d6JOMfAPFcfppuhXvatLqpLb6UK5dOzdLZnfBfq7Q@mail.gmail.com>
 <20210707181451.GS2610@twin.jikos.cz>
 <843d839c-11f5-40e3-9871-e462254113b1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <843d839c-11f5-40e3-9871-e462254113b1@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 08, 2021 at 07:19:28AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/8 上午2:14, David Sterba wrote:
> > On Wed, Jul 07, 2021 at 01:41:46PM -0400, Neal Gompa wrote:
> >>> But on the other hand, I'm not sure what's the proper way to introduce a
> >>> fix for v5.15 window.
> >>>
> >>> Should I just disable readahead for compression read (which just needs
> >>> two lines to return 0 for subpage case in add_ra_bio_pages())?
> >>>
> >>> Or should I add the proper fix into the patchset?
> >>
> >> If this is going into 5.15 instead of 5.14, just add the proper fix
> >> into this patch set. But if we want to land this in 5.14, I would
> >> suggest disabling it for now and then having a separate patch set for
> >> that.
> >
> > 5.14 is not possible, there are other subpage changes already merged so
> > fixes to existing level of support (still limited) can go to 5.14-rcs
> > but this whole patchses it is targeting 5.15.
> >
> >> You're already targeting 5.15 (though I kind of want this in 5.14...),
> >> so I suggest going with adding the fix to the patch set.
> >
> > For 5.15 it's free to do any change, eg. fold the fix or do a separate
> > patch explaining all the details.
> 
> Another reason why I'm considering to disable that readahead ability is,
> it really makes little sense for 64K page size.
> 
> Our maximum compressed extent size is just 128K, at most 3 pages for 64K
> page size (that's when the extent is not page aligned).
> 
> Just saving two reads (which may only be one or 2 4K sectors) doesn't
> really make it worthy, especially considering the change to ra itself is
> going to affecting common code path.
> 
> Thus I prefer to disable for the initial support, and only add the
> proper fix for the compression write support.

Ok.

> > In general the development changes must be ready at the rc5 time at the
> > latest (with a week or two for some testing and catching last bugs).
> > Once it's due there's like two months until the next code freeze.
> >
> 
> Great, I'll just add a simple disabling patch with comments on why the
> current code doesn't work and why it's fine to disable it for 64K page size.

Yes please, there's a number of things that won't be initially
implemented so we need to keep track (changelogs and/or comments).
