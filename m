Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E57BE82079
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 17:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfHEPkr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 11:40:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:36488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728680AbfHEPkr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 11:40:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DFAFADD9;
        Mon,  5 Aug 2019 15:40:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BC982DABC7; Mon,  5 Aug 2019 17:41:18 +0200 (CEST)
Date:   Mon, 5 Aug 2019 17:41:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH][v2] btrfs: add an ioctl to force chunk allocation
Message-ID: <20190805154118.GA28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20190805131942.8669-1-josef@toxicpanda.com>
 <ca939ada-e4ef-80a2-9b8f-e64279f48ff7@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca939ada-e4ef-80a2-9b8f-e64279f48ff7@applied-asynchrony.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 05, 2019 at 04:10:39PM +0200, Holger Hoffstätte wrote:
> On 8/5/19 3:19 PM, Josef Bacik wrote:
> > In testing block group removal it's sometimes handy to be able to create
> > block groups on demand.  Add an ioctl to allow us to force allocation
> > from userspace.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> > v1->v2:
> > - I noticed last week when backporting this that btrfs_chunk_alloc doesn't
> >    figure out the rest of the flags needed for the type.  Use
> >    btrfs_force_chunk_alloc instead so that we get the raid settings for the alloc
> >    type we're using.
> 
> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> 
> Now works as intended - very nice, thanks!

Tell me, are you interested in this ioctl because it was the missing bit
for testing or because the chunk allocator is so bad that you need a
command to make work?
