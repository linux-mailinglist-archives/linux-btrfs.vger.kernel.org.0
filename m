Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EA52A2EE6
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 17:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgKBQCQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 11:02:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:42052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgKBQCQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 11:02:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E4E1AF37;
        Mon,  2 Nov 2020 16:02:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67CA8DA7D2; Mon,  2 Nov 2020 17:00:38 +0100 (CET)
Date:   Mon, 2 Nov 2020 17:00:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/10] btrfs: precalculate checksums per leaf once
Message-ID: <20201102160038.GH6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1603981452.git.dsterba@suse.com>
 <33195f212e58bb0150017b3c1ac6df5c2d8c8dc7.1603981453.git.dsterba@suse.com>
 <037ace4b-0293-f43d-f340-68e766c6fd3b@gmx.com>
 <20201102152445.GG6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102152445.GG6756@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 02, 2020 at 04:24:45PM +0100, David Sterba wrote:
> On Mon, Nov 02, 2020 at 10:27:25PM +0800, Qu Wenruo wrote:
> > On 2020/10/29 下午10:27, David Sterba wrote:
> > > -	csum_size = BTRFS_MAX_ITEM_SIZE(fs_info);
> > > -	num_csums_per_leaf = div64_u64(csum_size,
> > > -			(u64)btrfs_super_csum_size(fs_info->super_copy));
> > >  	num_csums = csum_bytes >> fs_info->sectorsize_bits;
> > > -	num_csums += num_csums_per_leaf - 1;
> > > -	num_csums = div64_u64(num_csums, num_csums_per_leaf);
> > > -	return num_csums;
> > > +	return DIV_ROUND_UP_ULL(num_csums, fs_info->csums_per_leaf);
> > 
> > Since it's just a DIV_ROUND_UP_ULL() call, can we make it inline?
> 
> Good point, but i'll check first if this does not bloat code due to
> inlining. As it's called once in all callers, the overhead of call is
> not a problem.

On a release config it adds about 40 bytes in resulting asm and reduces
some stack usage due to the removed calls, I guess this speaks in favor
of inlining so I'll switch it. Thanks.
