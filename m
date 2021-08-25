Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3EC3F759C
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 15:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhHYNJG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 09:09:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55320 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhHYNJF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 09:09:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4A895221BB;
        Wed, 25 Aug 2021 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629896899;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X3tXzHKH9/oH5JUO5Li53ZIkTjrqoY8X1IS3ftnX4m4=;
        b=10OmVhtDxtMf00dGcuipISSmPeTRTjpPxWCR9Tnx6TjCclz/H1OD9nX2ytAMdbYsjQJg3X
        wU/7WVZSYkwr1HUSRl41Z5Ut7kThDrKxUzXoFCPAvG8iSuP22XcIe+N4rHF08F/+shhVz5
        +sow7uK01H8gqjD8V3XIEEkK6ZJjSdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629896899;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X3tXzHKH9/oH5JUO5Li53ZIkTjrqoY8X1IS3ftnX4m4=;
        b=pyLQEer0t65njxTwuAWl8piZiM8VNKGnz6l2IXDcdV4XJvLT2mC1DARXD914voxldVI9RT
        SDcRp/TmjGHzjmAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 18260A3B81;
        Wed, 25 Aug 2021 13:08:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B3186DA799; Wed, 25 Aug 2021 15:05:31 +0200 (CEST)
Date:   Wed, 25 Aug 2021 15:05:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: Re: [PATCH 1/7] fs: btrfs: Introduce btrfs_for_each_slot
Message-ID: <20210825130531.GI3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "nborisov@suse.com" <nborisov@suse.com>
References: <20210824170658.12567-1-mpdesouza@suse.com>
 <20210824170658.12567-2-mpdesouza@suse.com>
 <PH0PR04MB74165AAE8DA3D7BA81C2A0AC9BC69@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74165AAE8DA3D7BA81C2A0AC9BC69@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 25, 2021 at 07:42:43AM +0000, Johannes Thumshirn wrote:
> On 24/08/2021 19:13, Marcos Paulo de Souza wrote:
> >  static inline int btrfs_next_old_item(struct btrfs_root *root,
> >  				      struct btrfs_path *p, u64 time_seq)
> >  {
> 
> Shouldn't below xattr code be in a separate patch? Just like the block-group,
> dev-replace, etc changes?

Yes.
