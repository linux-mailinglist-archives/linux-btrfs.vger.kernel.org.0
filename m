Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7330C48EE14
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 17:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbiANQ2y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jan 2022 11:28:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59304 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiANQ2y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jan 2022 11:28:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F07FA219B1;
        Fri, 14 Jan 2022 16:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642177732;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CzX1aSmTooK1EMmhJfbzkcQGSY16OFvSVNFOPoOdA4=;
        b=Lq9y/B8zyJlIuN6E7uTVdUzhHROJtHPAYaXJikQtJWHm44HYkQPSwyjYpH39VEQLhFcr4G
        y4HEXSDC6Kd5yzvGyf9Q/UCTMzJ1l97QG2UjcbDP0kHwCwccYLKZoLsLJmiZBmSqj9qe3K
        wTXLh7fHUgMsYI1HAr0H6HlNgzVxL3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642177732;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CzX1aSmTooK1EMmhJfbzkcQGSY16OFvSVNFOPoOdA4=;
        b=Tfz/6bZiVdWgDm0QwZmHsNJsaixtkdTt4/m1pBJhjCVorrJjnIR01iAlgT3BR3+prF9CsA
        isyfZ09y6y9LHbDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C6FF2A3B81;
        Fri, 14 Jan 2022 16:28:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 28D14DA781; Fri, 14 Jan 2022 17:28:17 +0100 (CET)
Date:   Fri, 14 Jan 2022 17:28:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     lkp <oliver.sang@intel.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, linux-btrfs@vger.kernel.org
Subject: Re: [btrfs]  [confidence: ] c2e3930529:
 WARNING:at_fs/btrfs/block-group.c:#btrfs_put_block_group[btrfs]
Message-ID: <20220114162817.GC14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        lkp <oliver.sang@intel.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, linux-btrfs@vger.kernel.org
References: <20220114082331.GE32317@xsang-OptiPlex-9020>
 <YeFVtonXVkSJsdhq@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeFVtonXVkSJsdhq@debian9.Home>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 14, 2022 at 10:51:34AM +0000, Filipe Manana wrote:
> On Fri, Jan 14, 2022 at 04:23:31PM +0800, kernel test robot wrote:
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> Known issue, and is fixed by:
> 
> https://patchwork.kernel.org/project/linux-btrfs/patch/3aae7c6728257c7ce2279d6660ee2797e5e34bbd.1641300250.git.fdmanana@suse.com/
> 
> But it's not yet on Linus' tree.

Will go as a post-rc1 fix at the latest.
