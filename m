Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A6359948
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfF1LeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jun 2019 07:34:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:50084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbfF1LeO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jun 2019 07:34:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E85DFAD72;
        Fri, 28 Jun 2019 11:34:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B3DB1DAC70; Fri, 28 Jun 2019 13:34:58 +0200 (CEST)
Date:   Fri, 28 Jun 2019 13:34:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.de>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
Message-ID: <20190628113458.GF20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
 <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
 <20190627145849.GA20977@twin.jikos.cz>
 <dafc56c9-1cd8-2727-049d-99db6504b7e2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dafc56c9-1cd8-2727-049d-99db6504b7e2@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 28, 2019 at 09:26:53AM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/6/27 下午10:58, David Sterba wrote:
> > On Tue, Jun 25, 2019 at 04:24:57PM +0800, Qu Wenruo wrote:
> >> Ping?
> >>
> >> This patch should fix the problem of compressed extent even when
> >> nodatasum is set.
> >>
> >> It has been one year but we still didn't get a conclusion on where
> >> force_compress should behave.
> > 
> > Note that pings to patches sent year ago will get lost, I noticed only
> > because you resent it and I remembered that we had some discussions,
> > without conclusions.
> > 
> >> But at least to me, NODATASUM is a strong exclusion for compress, no
> >> matter whatever option we use, we should NEVER compress data without
> >> datasum/datacow.
> > 
> > That's correct, but the way you fix it is IMO not right. This was also
> > noticed by Nikolay, that there are 2 locations that call
> > inode_need_compress but with different semantics.
> > 
> > One is the decision if compression applies at all,
> 
> > and the second one
> > when that's certain it's compression, to do it or not based on the
> > status decision of eg. heuristics.
> 
> The second call is in compress_file_extent(), with inode_need_compress()
> return 0 for NODATACOW/NODATASUM inodes, we will not go into
> cow_file_range_async() branch at all.
> 
> So would you please explain how this could cause problem?
> To me, prevent the problem in inode_need_compress() is the safest location.

Let me repeat: two places with different semantics. So this means that
we need two functions that reflect the differences. That it's in one
function that works both contexts is ok from functionality point of
view, but if we care about clarity of design and code we want two
functions.
