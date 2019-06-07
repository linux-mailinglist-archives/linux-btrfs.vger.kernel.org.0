Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BEF38BA8
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 15:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfFGNaY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jun 2019 09:30:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:55578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728019AbfFGNaX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jun 2019 09:30:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2965AFBE
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2019 13:30:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09E8DDA849; Fri,  7 Jun 2019 15:31:12 +0200 (CEST)
Date:   Fri, 7 Jun 2019 15:31:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] More lockdep annotations
Message-ID: <20190607133112.GC30187@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1559321947.git.dsterba@suse.com>
 <384c555b-3e7b-2c38-0204-8cf827386915@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <384c555b-3e7b-2c38-0204-8cf827386915@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 05, 2019 at 10:34:24AM +0300, Nikolay Borisov wrote:
> 
> 
> On 31.05.19 г. 20:01 ч., David Sterba wrote:
> > Lockdep annotations are better than comments about necessary locks.
> > 
> > David Sterba (5):
> >   btrfs: tests: add locks around add_extent_mapping
> >   btrfs: assert extent map tree lock in add_extent_mapping
> >   btrfs: assert tree mod log lock in __tree_mod_log_insert
> >   btrfs: assert delayed ref lock in btrfs_find_delayed_ref_head
> >   btrfs: assert bio list lock in merge_rbio
> > 
> >  fs/btrfs/ctree.c                  |  4 ++--
> >  fs/btrfs/delayed-ref.c            |  7 ++++---
> >  fs/btrfs/extent_map.c             |  2 ++
> >  fs/btrfs/raid56.c                 |  4 ++--
> >  fs/btrfs/tests/extent-map-tests.c | 22 ++++++++++++++++++++++
> >  5 files changed, 32 insertions(+), 7 deletions(-)
> > 
> 
> 
> For the whole series :
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Thanks, series moved to misc-next.
