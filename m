Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5515B41154F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 15:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbhITNMM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 09:12:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42990 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbhITNMK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 09:12:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5CFD0200D6;
        Mon, 20 Sep 2021 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632143442;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGP+GiSNZPHLzM/Yu138nswEJ+HDOEselxX9FiN0RQM=;
        b=osFGdLdbAVbFCuVWdz39XJdlNRh2KunPunGWlXvEwL1MuRfXHhWK2gQ7hWNUr8J/AzjlwI
        gar7m6sZ+8pHHZIz6RT5aLP3BEURCMTUE70W7571i4KbAN9U+o1qoM4L7+/9CpPRBxVofF
        MtQK5kquYcpouIo54PtzEQQ6xY0y+VM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632143442;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGP+GiSNZPHLzM/Yu138nswEJ+HDOEselxX9FiN0RQM=;
        b=J01fYbuXQtBvd3aE/stUw0PUnITBhrVmhkBmGHGV74qNmSJgTho9CXUJId5dXXWlvrqMuh
        lJzkyvm4r8w8pEBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 55F32A3BC5;
        Mon, 20 Sep 2021 13:10:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 12553DA7FB; Mon, 20 Sep 2021 15:10:31 +0200 (CEST)
Date:   Mon, 20 Sep 2021 15:10:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3 3/3] btrfs: rename struct btrfs_io_bio to
 btrfs_logical_bio
Message-ID: <20210920131030.GL9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-4-wqu@suse.com>
 <b49cb262-0239-78eb-8144-523caed28bef@suse.com>
 <20210920122329.GJ9286@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210920122329.GJ9286@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 20, 2021 at 02:23:29PM +0200, David Sterba wrote:
> On Mon, Sep 20, 2021 at 10:04:10AM +0300, Nikolay Borisov wrote:
> > On 15.09.21 г. 10:17, Qu Wenruo wrote:
> > > Previously we have "struct btrfs_bio", which records IO context for
> > > mirrored IO and RAID56, and "strcut btrfs_io_bio", which records extra
> > > btrfs specific info for logical bytenr bio.
> > > 
> > > With "strcut btrfs_bio" renamed to "struct btrfs_io_context", we are
> > > safe to rename "strcut btrfs_io_bio" to "strcut btrfs_logical_bio" which
> > > is a more suitable name now.
> > > 
> > > Although the name, "btrfs_logical_bio", is a little long and name
> > > "btrfs_bio" can be much shorter, "btrfs_bio" conflicts with previous
> > > "btrfs_bio" structure and can cause a lot of problems for backports.
> > > 
> > > Thus here we choose the name "btrfs_logical_bio", which also emphasis
> > > those bios all work at logical bytenr.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > So thinking a bit more about the renaming we are trading "awkwardness"
> > for future generations so that we make backporting easier or rather more
> > fool proof.
> > 
> > What if we backport a patch that does BUILD_BUG_ON predicated on the
> > size of the btrfs_io_bio. That way if a patch backports cleanly and
> > automatically but in fact git got confused by btrfs_bio vs btrfs_io_bio
> > then a build failure would ensue due to mismatched sizes and that would
> > be a clear indication something has gone wrong so whoever is doing the
> > backport can go and correct the backport? David what do you think about
> > this?
> 
> So you want to call the structure btrfs_bio and add build protections?  I'm not
> sure how exactly you want to do the sizeof check, one way would be to add a
> stub structure and compare sizeof against that, because a hardcoded value won't
> work due to padding, or we'd have to have a 32bit assertion version.
> 
> I'd like to see the code, but otherwise I think it's reasonable, the shorter
> name would be better. I don't expect many backports regarding the bio
> related code, it could be referenced in the diff context but that we can
> handle fine. I'm a bit cautious because I've seen patches to other
> subystems that did changes like swapping parameters or repurposing
> structures like here we do and Linus did not like that at all. It's
> trade off if we'll suffer a naming we don't like or would cause a bug
> because we'd forget about the change.

For the record, we had a chat about that and found that explicit build
checks won't be necessary as the old/new structure has no overlap of the
members so the build would fail anyway.

I did the rename from btrfs_logical_bio* to btrfs_bio again in
misc-next, please have a look, it's basically what Qu sent as v2.
