Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0123F00BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 11:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhHRJkV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 05:40:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58910 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhHRJkU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 05:40:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8E88B1FF9D;
        Wed, 18 Aug 2021 09:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629279585;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q25E3lESNFvdjWR7/jgy/qknNSvv2mT1La7ECgqQIxU=;
        b=oE+XgT1isj1PujMDKlEulEAhcX6Zj9WxZB04CHcg6oIXybHPNotkzIX6kP5J8GPDojnFnQ
        f1BQI3/wObEw+vFfKhPexKZRgyd3p9KIKZExGfBQUSjaFtHW2RGpSEMm3/tJ8XS4Ez2AEq
        bIWPOlZV1amtA6Vyt5efufElTQfbXFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629279585;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q25E3lESNFvdjWR7/jgy/qknNSvv2mT1La7ECgqQIxU=;
        b=aq4aD0IK9jDDBRrQKIXaTI2i2DPbvldIFuqKSAk4lgYUUX5g9SFV4mNZjMQpzCxHBeBxYZ
        OBn6qv25McxAwIBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5E32FA3B93;
        Wed, 18 Aug 2021 09:39:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C3D9BDA72C; Wed, 18 Aug 2021 11:36:48 +0200 (CEST)
Date:   Wed, 18 Aug 2021 11:36:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: exclude relocation and page writeback
Message-ID: <20210818093648.GP5047@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <a858fb2ff980db27b3638e92f7d2d7a416b8e81e.1628776260.git.johannes.thumshirn@wdc.com>
 <20210812142558.GI5047@suse.cz>
 <PH0PR04MB7416785CF79EF72CCDCF931E9BF99@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210812145017.GJ5047@suse.cz>
 <PH0PR04MB741690FBBB6A43279E9F1ED89BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741690FBBB6A43279E9F1ED89BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 17, 2021 at 02:21:51PM +0000, Johannes Thumshirn wrote:
> On 12/08/2021 16:53, David Sterba wrote:
> > On Thu, Aug 12, 2021 at 02:40:59PM +0000, Johannes Thumshirn wrote:
> >> On 12/08/2021 16:28, David Sterba wrote:

> I did some testing with the inode lock and it looks good but does not 
> necessarily fix all possible problems, i.e. if a ordered extent is being
> split due to whatever device limits (zone append, max sector size, etc),
> the assumptions we have in relocation code aren't met again.
> 
> So the heavy lifting solution with having a dedicated temporary relocation
> block group (like the treelog block group we already have for zoned) and using
> regular writes looks like the only solution taking care of all of these problems.

So that means that the minimum number of zones increases again, right.
If the separate relocation zone fixes this and possibly other problems
then fine, but as you said this is heavy weight solution.

We will need a mechanims with a spare block group/zone for emergency
cases where we're running out of usable metadata space and need to
relocate so this could be building on the same framework. But for first
implementation reserving another block group sounds easier.
