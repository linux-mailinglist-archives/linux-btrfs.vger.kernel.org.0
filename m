Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8C63F01E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 12:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhHRKjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 06:39:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40148 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhHRKjO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 06:39:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A89C41FFB2;
        Wed, 18 Aug 2021 10:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629283119;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gh5oD6NiNI8ERzrlEi/6l99jHJ9GGjIt4IojBXOrGQM=;
        b=I54rpaREMC23a9Z2mDVNyLBWfVskoeyUi0EA6+/bmzYbAfYSzuKpVmeNtjZriLxuqJZS/Z
        gD/UQ0M5QpmQ3zWMs2GkNTHOfVuUJMrjrnJ6SedoiN3P6Lr+RKkrlZWRrRMmfjPnRjMNAL
        wtDh4G7ro7u07fJjlv1+IF6M0EgiOuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629283119;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gh5oD6NiNI8ERzrlEi/6l99jHJ9GGjIt4IojBXOrGQM=;
        b=TFms3kg3LlB1QfoRxwkhw/AtoFGMYwKpAnVLnmq032pPwa/YeLsSPaNqZbHo8DQJ2yaCid
        gjEPhi+cCVCDELAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A0B98A3B94;
        Wed, 18 Aug 2021 10:38:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9501DA72C; Wed, 18 Aug 2021 12:35:42 +0200 (CEST)
Date:   Wed, 18 Aug 2021 12:35:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
Subject: Re: [PATCH] btrfs-progs: Drop the type check in
 init_alloc_chunk_ctl_policy_regular
Message-ID: <20210818103542.GR5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210809182613.4466-1-mpdesouza@suse.com>
 <20210817132419.GK5047@twin.jikos.cz>
 <04abaf84-12e3-3983-dee4-a5073ec786f1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04abaf84-12e3-3983-dee4-a5073ec786f1@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 01:17:46PM +0800, Qu Wenruo wrote:
> On 2021/8/17 下午9:24, David Sterba wrote:
> > On Mon, Aug 09, 2021 at 03:26:13PM -0300, Marcos Paulo de Souza wrote:
> >>
> >> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> >> ---
> >>
> >>   This change mimics what the kernel currently does, which is set the stripe_size
> >>   regardless of the profile. Any thoughts on it? Thanks!
> >
> > Makes sense to unify that, it works well for the large sizes. Please
> > write tests that verify that the chunk sizes are correct after mkfs on
> > various device sizes. Patch added to devel, thanks.
> 
> It in fact makes fsck/025 to fail, bisection points to this patch
> surprisingly.
> 
> Now "mkfs.btrfs -f" on a 128M file will just fail.
> 
> This looks like a big problem to me though...

This is known that the small filesystem size and intial chunk layout is
not scaled properly, the patch OTOH fixes the more common case where the
normal block group sizes fit and leave enough room for the rest.

Can the test 025 be scaled up so we don't have to create the 128M
filesystem? I'd rather go that way.
