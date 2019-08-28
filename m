Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BA5A0317
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 15:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfH1NXj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 09:23:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:56250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfH1NXj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 09:23:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F35AAFA4;
        Wed, 28 Aug 2019 13:23:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DCE93DA809; Wed, 28 Aug 2019 15:24:00 +0200 (CEST)
Date:   Wed, 28 Aug 2019 15:24:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: add BTRFS_DEV_ITEMS_OBJECTID in comment
 in print-tree
Message-ID: <20190828132400.GB2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20190828095619.9923-1-anand.jain@oracle.com>
 <f5992432-3bed-de22-0cb2-3c631aa01a03@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5992432-3bed-de22-0cb2-3c631aa01a03@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 28, 2019 at 04:01:04PM +0300, Nikolay Borisov wrote:
> 
> 
> On 28.08.19 г. 12:56 ч., Anand Jain wrote:
> > So when searching for BTRFS_DEV_ITEMS_OBJECTID it hits. Albeit it is
> > defined same as BTRFS_ROOT_TREE_OBJECTID.
> > 
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > ---
> >  print-tree.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/print-tree.c b/print-tree.c
> > index b31e515f8989..5832f3089e3d 100644
> > --- a/print-tree.c
> > +++ b/print-tree.c
> > @@ -704,6 +704,7 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
> >  	}
> >  
> >  	switch (objectid) {
> > +	/* BTRFS_DEV_ITEMS_OBJECTID */
> 
> That comment looks really cryptic to someone just looking at the code.
> Adding case BTRFS_DEV_ITEMS_OBJECTID: is better.

> >  	case BTRFS_ROOT_TREE_OBJECTID:

Both constants have the same value so they can't be in one switch, but
yeah the comment should be a bit more verbose, just the constant name is
bringing more questions than answers.
