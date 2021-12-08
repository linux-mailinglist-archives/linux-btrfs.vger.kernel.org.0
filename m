Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D62846D2E5
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 13:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhLHMIu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 07:08:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40994 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhLHMIt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Dec 2021 07:08:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 36B8C218D5;
        Wed,  8 Dec 2021 12:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638965117;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BgLUbpI+TTkB6XfP1d3lBFtHHBWV0Usm8/pxqIM0c7Q=;
        b=zBOafAa7iwbyYQ3N1ZYzNIuFjvm+Z40VeRy263d0hqlX/7wscg72YAdGg3cdrVJwrSBbxW
        SH+vJ4r8L2pfCePWjlP4nsn+ntEbMXybZNFyUWXCTGE16Sz2aQlOwv0qyKjOiVPmizxP83
        /k6kEV2Epg02+v+4R34si6OAR3Ibg1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638965117;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BgLUbpI+TTkB6XfP1d3lBFtHHBWV0Usm8/pxqIM0c7Q=;
        b=9ulJ/05vZpdeLWCn6avXjxTzzW2Wd+GTt65bxNttM4LVkWSV0zSmL1X16E2W3gXgTCYe9d
        fWztPZE+lc/AzBCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 00070A3B92;
        Wed,  8 Dec 2021 12:05:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 00825DA799; Wed,  8 Dec 2021 13:05:01 +0100 (CET)
Date:   Wed, 8 Dec 2021 13:05:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 1/4] btrfs: zoned: encapsulate inode locking for zoned
 relocation
Message-ID: <20211208120501.GI28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1638886948.git.johannes.thumshirn@wdc.com>
 <b1d1bab106ddc4456224c0bf1c1bfcfaea4844b7.1638886948.git.johannes.thumshirn@wdc.com>
 <20211207190812.GC28560@twin.jikos.cz>
 <PH0PR04MB7416360B934D51D55BB4818E9B6F9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416360B934D51D55BB4818E9B6F9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 08, 2021 at 09:06:14AM +0000, Johannes Thumshirn wrote:
> On 07/12/2021 20:08, David Sterba wrote:
> > All internal API should use struct btrfs_inode, applied with the
> > following diff:
> 
> Ah ok, good to know. I wanted  to have a bit less pointer casing 
> with using 'struct inode'. Anyways I don't mind.

Now it's a mix of both and needs more works to unify but at least new
code should be done the right way. The pointer chasing will go
eventually and I don't think it has a measurable impact.
