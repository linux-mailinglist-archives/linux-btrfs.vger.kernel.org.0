Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF1A27CEFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 15:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgI2NW2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 09:22:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:42194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbgI2NW2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 09:22:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29F73AD71;
        Tue, 29 Sep 2020 13:22:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E3FF2DA701; Tue, 29 Sep 2020 15:21:07 +0200 (CEST)
Date:   Tue, 29 Sep 2020 15:21:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: cleanup cow block on error
Message-ID: <20200929132107.GF6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Filipe Manana <fdmanana@suse.com>
References: <1f84722853326611d5d0d6c74e7af75be7b5928d.1601384009.git.josef@toxicpanda.com>
 <SN4PR0401MB35983F92A10521F7CE5F891D9B320@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35983F92A10521F7CE5F891D9B320@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 29, 2020 at 01:16:50PM +0000, Johannes Thumshirn wrote:
> On 29/09/2020 14:54, Josef Bacik wrote:
> > @@ -1103,6 +1107,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
> >  		if (last_ref) {
> >  			ret = tree_mod_log_free_eb(buf);
> >  			if (ret) {
> > +				btrfs_tree_unlock(cow);
> > +				free_extent_buffer(cow);
> >  				btrfs_abort_transaction(trans, ret);
> >  				return ret;
> >  			}
> > 
> 
> 
> I don't want to be a party pooper here but, now you have this pattern:
> 
> if (ret) {
> 	btrfs_tree_unlock(cow);
> 	free_extent_buffer(cow);
> 	btrfs_abort_transaction(trans, ret);
> 	return ret;
> }
> 
> repeated three times. I think this should be consolidated in a 'goto err' or something.

Hah, you think _you_ are the party pooper?

https://btrfs.wiki.kernel.org/index.php/Development_notes#Error_handling_and_transaction_abort
