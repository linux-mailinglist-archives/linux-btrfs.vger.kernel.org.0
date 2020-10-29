Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7514C29F57C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 20:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgJ2Tkc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 15:40:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:58380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgJ2Tkc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 15:40:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91A76AD19;
        Thu, 29 Oct 2020 19:40:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 74EC4DA7CE; Thu, 29 Oct 2020 20:38:56 +0100 (CET)
Date:   Thu, 29 Oct 2020 20:38:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 08/68] btrfs: inode: sink parameter @start and @len
 for check_data_csum()
Message-ID: <20201029193856.GU6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-9-wqu@suse.com>
 <20201027001305.GW6756@twin.jikos.cz>
 <bb49899c-c25a-a4e4-825c-4c8a2ea4b176@gmx.com>
 <20201027231754.GG6756@twin.jikos.cz>
 <d53118ab-8d9a-db24-26d3-1a4d66cbe2bf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d53118ab-8d9a-db24-26d3-1a4d66cbe2bf@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 28, 2020 at 08:57:07AM +0800, Qu Wenruo wrote:
> On 2020/10/28 上午7:17, David Sterba wrote:
> > On Tue, Oct 27, 2020 at 08:50:15AM +0800, Qu Wenruo wrote:
> >> On 2020/10/27 上午8:13, David Sterba wrote:
> >>> On Wed, Oct 21, 2020 at 02:24:54PM +0800, Qu Wenruo wrote:
> >>>> +/*
> >>>> + * Verify the checksum of one sector of uncompressed data.
> >>>> + *
> >>>> + * @inode:	The inode.
> >>>> + * @io_bio:	The btrfs_io_bio which contains the csum.
> >>>> + * @icsum:	The csum offset (by number of sectors).
> >>>
> >>> This is not true, it's the index to the checksum array, where size of
> >>> the element is fs_info::csum_size. The offset can be calculated but it's
> >>> not the thing that's passed as argument.
> > 
> >> Isn't the offset by sectors the same?
> > 
> > Offset by sectors reads as something expressed in sector-sized units.
> >>
> >> If it's 1, it means we need to skip 1 csum which is in csum_size.
> > 
> > Yes, so you see the difference sector vs csum_size. I understand what
> > you meant by that but reading the comment without going to the code can
> > confuse somebody.
> 
> Any better naming alternative for that?
> 
> Or maybe I can refactor the function by passing in the current
> file_offset into the function, and let check_data_csum() to calculate
> the csum offset by itself?

It was only the parameter description that was a bit confusing, no need
to change anything else here.
