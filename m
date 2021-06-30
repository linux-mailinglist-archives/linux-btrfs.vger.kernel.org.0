Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE03B888A
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhF3Six (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 14:38:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45786 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbhF3Siw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 14:38:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 516B321D00;
        Wed, 30 Jun 2021 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625078182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7Of3y895BTLJnycIzLoMdDAS4u14fS+sUr94O76snM=;
        b=krLFGMs3ElKft3ZdVTnN6Czv59S1yGKFPyPGoVtkBp4dFPdK2mcOABgdmhmw8Ctv0+cc9o
        2tCq5Y9q176JqQYznfjBJ+YpGHXQErZK3V0Peon7RtfhPMIXzseKH23Vbrhn8CbzG16aFv
        fKQD23+SzJwrUGghZXu9oc6p+2fcPj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625078182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7Of3y895BTLJnycIzLoMdDAS4u14fS+sUr94O76snM=;
        b=Kuq+dmp+y78HtH4gDbEd5z24XKQb1fiXNhrleuszw3RI8+b1VD0ssIXyU0Gmmhrvu5xtTX
        m+Duel38QWzjsODw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 22133A3B85;
        Wed, 30 Jun 2021 18:36:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0767FDA7A2; Wed, 30 Jun 2021 20:33:51 +0200 (CEST)
Date:   Wed, 30 Jun 2021 20:33:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 0/2] btrfs: eliminate a deadlock when allocating system
 chunks and rework chunk allocation
Message-ID: <20210630183351.GQ2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <cover.1624973480.git.fdmanana@suse.com>
 <20210630131010.GL2610@twin.jikos.cz>
 <PH0PR04MB741603949B19D52F5CD411B09B019@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741603949B19D52F5CD411B09B019@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 30, 2021 at 02:50:00PM +0000, Johannes Thumshirn wrote:
> On 30/06/2021 15:12, David Sterba wrote:
> > On Tue, Jun 29, 2021 at 02:43:04PM +0100, fdmanana@kernel.org wrote:
> >> From: Filipe Manana <fdmanana@suse.com>
> >>
> >> The first patch eliminates a deadlock when multiple tasks need to allocate
> >> a system chunk. It reverts a previous fix for a problem that resulted in
> >> exhausting the system chunk array and result in a transaction abort when
> >> there are many tasks allocating chunks in parallel. Since there is not a
> >> simple and short fix for the deadlock that does not bring back the system
> >> array exhaustion problem, and the deadlock is relatively easy to trigger
> >> on zoned filesystem while the exhaustion problem is not so common, this
> >> first patch just revets that previous fix.
> >>
> >> The second patch reworks a bit of the chunk allocation code so that we
> >> don't hold onto reserved system space from phase 1 to phase 2 of chunk
> >> allocation, which is what leads to system chunk array exhaustion when
> >> there's a bunch of tasks doing chunks allocations in parallel (initially
> >> observed on PowerPC, with a 64K node size, when running the fallocate
> >> tests from stress-ng). The diff of this patch is quite big, but about
> >> half of it are just comments.
> > 
> > The description of the chunk allocation process is great, thanks.
> > Patches added to misc-next.
> > 
> 
> I also have a first positive response from Shinichiro that he can't
> reproduce the hangs in a quick run.
> 
> He'll probably responds with his 'Tested-by' once the complete tests
> are done.

I was not able to reproduce the deadlock with the patches.
