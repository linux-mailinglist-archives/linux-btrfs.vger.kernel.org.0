Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE32B432369
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 17:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhJRP7F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 11:59:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36072 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbhJRP7E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 11:59:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9474021965;
        Mon, 18 Oct 2021 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634572612;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f6w4yu+TxeQi273SU5WHxJVmhYmVj34WVSYFZGIh96g=;
        b=r0I9DMB9CLAK8XPJ+sTIxy4c9/BScklqUhEnHSR+ec+WBP1ajMGEEYhszmOJKzUV5u1PFQ
        WsKwTf55KZtaygitotxkNRnNg0V8Ijx5/MJFLWmB7ajbVmMJsMW+MxyjEmesi9+dXq1869
        yzVFrEk64t2ilJ+NOQ++aoMmmdZaV1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634572612;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f6w4yu+TxeQi273SU5WHxJVmhYmVj34WVSYFZGIh96g=;
        b=NOtt7fO4/KKuxoIzcJhvKViG2m0V87AQEeEQpaoqWeSMHDAwxe8nlxSpxlrJoGy+rjROZ7
        QlYfSo+cejHx2qDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6357EA3B85;
        Mon, 18 Oct 2021 15:56:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2A6FADA7A3; Mon, 18 Oct 2021 17:56:24 +0200 (CEST)
Date:   Mon, 18 Oct 2021 17:56:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3] btrfs: zoned: btrfs: zoned: use greedy gc for auto
 reclaim
Message-ID: <20211018155624.GN30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
References: <667291b2902cad926bbff8d5e9124166796cba32.1634204285.git.johannes.thumshirn@wdc.com>
 <20211018154202.GM30611@twin.jikos.cz>
 <PH0PR04MB74162F3F81A0639E55807BC39BBC9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74162F3F81A0639E55807BC39BBC9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 18, 2021 at 03:51:44PM +0000, Johannes Thumshirn wrote:
> On 18/10/2021 17:42, David Sterba wrote:
> > On Thu, Oct 14, 2021 at 06:39:02PM +0900, Johannes Thumshirn wrote:
> >> +/*
> >> + * We want block groups with a low number of used bytes to be in the beginning
> >> + * of the list, so they will get reclaimed first.
> >> + */
> >> +static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
> >> +			   const struct list_head *b)
> >> +{
> >> +	const struct btrfs_block_group *bg1, *bg2;
> >> +
> >> +	bg1 = list_entry(a, struct btrfs_block_group, bg_list);
> >> +	bg2 = list_entry(b, struct btrfs_block_group, bg_list);
> >> +
> >> +	return bg1->used - bg2->used;
> > 
> > So you also reverted to v1 the compare condition, this should be < so
> > it's the valid stable sort condition.
> > 
> 
> Ah damn, want me to resend with fixed commit message, subject and compare function?

Not needed, simple fixes are ok. And I correct myself it should be ">"
as was in v2.
