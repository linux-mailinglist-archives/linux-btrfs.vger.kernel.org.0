Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC9B2B9C1B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 21:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKSUbs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Nov 2020 15:31:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:39032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgKSUbr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Nov 2020 15:31:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3265AC24;
        Thu, 19 Nov 2020 20:31:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51362DA701; Thu, 19 Nov 2020 21:30:00 +0100 (CET)
Date:   Thu, 19 Nov 2020 21:30:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 03/24] btrfs: extent_io: replace
 extent_start/extent_len with better structure for end_bio_extent_readpage()
Message-ID: <20201119203000.GJ20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-4-wqu@suse.com>
 <20201118160532.74rfxqovyjymzipc@twin.jikos.cz>
 <f624c1a2-f0e6-7d3c-e963-f8aaf0ec3e6f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f624c1a2-f0e6-7d3c-e963-f8aaf0ec3e6f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 19, 2020 at 07:49:30AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/11/19 上午12:05, David Sterba wrote:
> > On Fri, Nov 13, 2020 at 08:51:28PM +0800, Qu Wenruo wrote:
> >>  }
> >>  
> >> +/*
> >> + * Records previously processed extent range.
> >> + *
> >> + * For endio_readpage_release_extent() to handle a full extent range, reducing
> >> + * the extent io operations.
> >> + */
> >> +struct processed_extent {
> >> +	struct btrfs_inode *inode;
> >> +	u64 start;	/* file offset in @inode */
> >> +	u64 end;	/* file offset in @inode */
> > 
> > Please don't use the in-line comments for struct members.
> 
> Even for such short description?
> 
> That's a little overkilled to me now.

Everywhere, for consistency. The in-line comments tend to be too short
and not always an improvement.
