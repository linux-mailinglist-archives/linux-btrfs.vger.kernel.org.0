Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7DFA077E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 18:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfH1QhT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 12:37:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:60754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726472AbfH1QhT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 12:37:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8DA70AE89;
        Wed, 28 Aug 2019 16:37:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB638DA809; Wed, 28 Aug 2019 18:37:40 +0200 (CEST)
Date:   Wed, 28 Aug 2019 18:37:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs-progs: add BTRFS_DEV_ITEMS_OBJECTID in
 comment in print-tree
Message-ID: <20190828163739.GF2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20190828095619.9923-1-anand.jain@oracle.com>
 <20190828140605.20790-1-anand.jain@oracle.com>
 <364d1417-c86f-9866-2388-637514037195@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <364d1417-c86f-9866-2388-637514037195@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 28, 2019 at 10:27:41PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/8/28 下午10:06, Anand Jain wrote:
> > So when searching for BTRFS_DEV_ITEMS_OBJECTID, it hits, albeit it is
> > defined same as BTRFS_ROOT_TREE_OBJECTID.
> > 
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> > ---
> > v1->v2: Improve comment.
> > 
> >  print-tree.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/print-tree.c b/print-tree.c
> > index b31e515f8989..b1c59d776547 100644
> > --- a/print-tree.c
> > +++ b/print-tree.c
> > @@ -705,6 +705,11 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
> >  
> >  	switch (objectid) {
> >  	case BTRFS_ROOT_TREE_OBJECTID:
> > +		/*
> > +		 * BTRFS_ROOT_TREE_OBJECTID and BTRFS_DEV_ITEMS_OBJECTID are
> > +		 * defined with the same value of 1ULL, distinguish them by
> > +		 * checking the type.
> > +		 */
> 
> Oh, some bad design from the very beginning of btrfs.

No, why bad design? Objectids need to be unique inside one group, like
tree ids, but are otherwise independent and must be interpreted together
with the key type. Which is exactly what print_objectid does.
