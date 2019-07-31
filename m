Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06C37C6B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2019 17:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfGaPd6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Jul 2019 11:33:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:45080 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725209AbfGaPd6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Jul 2019 11:33:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2E01AEB2;
        Wed, 31 Jul 2019 15:33:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7A6ABDA7ED; Wed, 31 Jul 2019 17:34:31 +0200 (CEST)
Date:   Wed, 31 Jul 2019 17:34:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: tree-checker: Add ROOT_ITEM check
Message-ID: <20190731153431.GN28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190716090034.11641-1-wqu@suse.com>
 <20190716090034.11641-4-wqu@suse.com>
 <20190726152925.GG2868@twin.jikos.cz>
 <98f0c716-b7ce-df16-a86e-634f03b68b31@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f0c716-b7ce-df16-a86e-634f03b68b31@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 27, 2019 at 07:26:28AM +0800, Qu Wenruo wrote:
> [snip]
> > 
> >> +	}
> >> +
> >> +	read_extent_buffer(leaf, &ri, btrfs_item_ptr_offset(leaf, slot),
> >> +			   sizeof(ri));
> >> +
> >> +	/* Generateion related */
> > 
> > typo here and a few more times below
> > 
> >> +	if (btrfs_root_generation(&ri) >
> >> +	    btrfs_super_generation(fs_info->super_copy) + 1) {
> >> +		generic_err(leaf, slot,
> >> +			"invalid root generaetion, have %llu expect (0, %llu]",
> >> +			    btrfs_root_generation(&ri),
> >> +			    btrfs_super_generation(fs_info->super_copy) + 1);
> >> +		return -EUCLEAN;
> >> +	}
> >> +	if (btrfs_root_generation_v2(&ri) >
> >> +	    btrfs_super_generation(fs_info->super_copy) + 1) {
> >> +		generic_err(leaf, slot,
> >> +		"invalid root v2 generaetion, have %llu expect (0, %llu]",
> > 
> > So (0, %llu] here means that it must be greater than zero, right? I'm
> > not sure that everyone uses the same notation for open/closed notation.
> 
> AFAIK in tree checker it's all the same notation.
> 
> Or any better solution for that?

No this one is fine, let's use it and eventualy update comments or
messages where this notation is not used.
