Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9274111C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbhITJPU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 05:15:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46442 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbhITJOF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 05:14:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DA4E522078;
        Mon, 20 Sep 2021 09:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632129157;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A7hasV0PMKYnm7biSuiDLwOWaL+smBGy0Eq+0nePbxA=;
        b=Qut4DaJSQjCIrw/+DBOHQvOkCH1mdEC/V5cUKdkkVF40avfq3zCQkyzfFYBI9hopfYvGkg
        nPjycFMtYu5kJQZcGQffR4IdXYjmisSV+CkuB0Q2z3y58BYqzEN/rmj3IwDDIK43k+2Ge9
        Cg6qBCD3ZR9x8NmSn5yWgrZa+AEdpRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632129157;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A7hasV0PMKYnm7biSuiDLwOWaL+smBGy0Eq+0nePbxA=;
        b=XBY7/KoH/wPRu9izEnzPv0yolnD5nULRdQefS/3GiB/f3LGDsyqbEmT2dmGlXqKb112V30
        psroI34apRgf9VCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A9E92A3BBD;
        Mon, 20 Sep 2021 09:12:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6DDA2DA781; Mon, 20 Sep 2021 11:12:26 +0200 (CEST)
Date:   Mon, 20 Sep 2021 11:12:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Hao Sun <sunhao.th@gmail.com>
Subject: Re: [PATCH] btrfs: unlock the newly allocated extent buffer in
 btrfs_alloc_tree_block()
Message-ID: <20210920091226.GC9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Hao Sun <sunhao.th@gmail.com>
References: <20210914065759.38793-1-wqu@suse.com>
 <20210920084822.GA9286@twin.jikos.cz>
 <PH0PR04MB741600D1F781CF62BB582B129BA09@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741600D1F781CF62BB582B129BA09@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 20, 2021 at 08:56:04AM +0000, Johannes Thumshirn wrote:
> On 20/09/2021 10:48, David Sterba wrote:
> > I found the following lockdep report, it's been with recent misc-next
> > and the functions on stack match what this patch touches but I haven't
> > done a deeper analysis so this could be a false trace (though the
> > warning seems legit).
> > 
> > The workload was some file creation/copy and relocation but I don't have
> > a more specific information.
> 
> This looks very much like a lockdep splat I know from zoned mode, but assumed
> it's a zoned only problem and pushed on the task stack. Was this test on a 
> regular SCSI/SATA drive? 

Yes, it's a multi-device fs, otherwise nothing special about it.
