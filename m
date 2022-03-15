Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317184D9D9A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 15:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349360AbiCOOdJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 10:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349300AbiCOOcz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 10:32:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B15D54FA5;
        Tue, 15 Mar 2022 07:31:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0A4571F391;
        Tue, 15 Mar 2022 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647354702;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4cn6JV8O5AWRhPuK4Wz8bFqAnv8oC3Dsib+SHAacxc=;
        b=AeePv1tYMjuFa+aHT+vLeUHCFANUp2upgQvR8FONiCoHkfgRPwtYn+YcU47g8mQR8xGMjj
        dF8lRdVfTicMFe2IfCiJWp6NsR35uAjZHmWjG+23uQTEi+1BZcWZ4Dn05qtApxxz8hgCKN
        /KHQseXyUpbpX4EqAUILwbcg7z/PUQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647354702;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4cn6JV8O5AWRhPuK4Wz8bFqAnv8oC3Dsib+SHAacxc=;
        b=taUQzUafQQZZAq34Z4BXfJfJMlBB/yEH93K5d2DJbUxkQyKCDrlRYIsIzerMcwkYGj5E20
        MrNXb5dXtx/3sNAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 196C0A3B81;
        Tue, 15 Mar 2022 14:31:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 22423DA7E1; Tue, 15 Mar 2022 15:27:40 +0100 (CET)
Date:   Tue, 15 Mar 2022 15:27:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220315142740.GU12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <20220315135245.eqf4tqngxxb7ymqa@unifi>
 <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
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

On Tue, Mar 15, 2022 at 02:14:23PM +0000, Johannes Thumshirn wrote:
> On 15/03/2022 14:52, Javier González wrote:
> > On 15.03.2022 14:30, Christoph Hellwig wrote:
> >> On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier González wrote:
> >>> but we do not see a usage for ZNS in F2FS, as it is a mobile
> >>> file-system. As other interfaces arrive, this work will become natural.
> >>>
> >>> ZoneFS and butrfs are good targets for ZNS and these we can do. I would
> >>> still do the work in phases to make sure we have enough early feedback
> >>> from the community.
> >>>
> >>> Since this thread has been very active, I will wait some time for
> >>> Christoph and others to catch up before we start sending code.
> >>
> >> Can someone summarize where we stand?  Between the lack of quoting
> >> from hell and overly long lines from corporate mail clients I've
> >> mostly stopped reading this thread because it takes too much effort
> >> actually extract the information.
> > 
> > Let me give it a try:
> > 
> >   - PO2 emulation in NVMe is a no-go. Drop this.
> > 
> >   - The arguments against supporting PO2 are:
> >       - It makes ZNS depart from a SMR assumption of PO2 zone sizes. This
> >         can create confusion for users of both SMR and ZNS
> > 
> >       - Existing applications assume PO2 zone sizes, and probably do
> >         optimizations for these. These applications, if wanting to use
> >         ZNS will have to change the calculations
> > 
> >       - There is a fear for performance regressions.
> > 
> >       - It adds more work to you and other maintainers
> > 
> >   - The arguments in favour of PO2 are:
> >       - Unmapped LBAs create holes that applications need to deal with.
> >         This affects mapping and performance due to splits. Bo explained
> >         this in a thread from Bytedance's perspective.  I explained in an
> >         answer to Matias how we are not letting zones transition to
> >         offline in order to simplify the host stack. Not sure if this is
> >         something we want to bring to NVMe.
> > 
> >       - As ZNS adds more features and other protocols add support for
> >         zoned devices we will have more use-cases for the zoned block
> >         device. We will have to deal with these fragmentation at some
> >         point.
> > 
> >       - This is used in production workloads in Linux hosts. I would
> >         advocate for this not being off-tree as it will be a headache for
> >         all in the future.
> > 
> >   - If you agree that removing PO2 is an option, we can do the following:
> >       - Remove the constraint in the block layer and add ZoneFS support
> >         in a first patch.
> > 
> >       - Add btrfs support in a later patch
> 
> (+ linux-btrfs )
> 
> Please also make sure to support btrfs and not only throw some patches 
> over the fence. Zoned device support in btrfs is complex enough and has 
> quite some special casing vs regular btrfs, which we're working on getting
> rid of. So having non-power-of-2 zone size, would also mean having NPO2
> block-groups (and thus block-groups not aligned to the stripe size).
> 
> Just thinking of this and knowing I need to support it gives me a 
> headache.

PO2 is really easy to work with and I guess allocation on the physical
device could also benefit from that, I'm still puzzled why the NPO2 is
even proposed.

We can possibly hide the calculations behind some API so I hope in the
end it should be bearable. The size of block groups is flexible we only
want some reasonable alignment.

> Also please consult the rest of the btrfs developers for thoughts on this.
> After all btrfs has full zoned support (including ZNS, not saying it's 
> perfect) and is also the default FS for at least two Linux distributions.

I haven't read the whole thread yet, my impression is that some hardware
is deliberately breaking existing assumptions about zoned devices and in
turn breaking btrfs support. I hope I'm wrong on that or at least that
it's possible to work around it.
