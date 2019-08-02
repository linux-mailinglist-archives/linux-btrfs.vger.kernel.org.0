Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E1E7F29D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 11:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405495AbfHBJqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 05:46:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405471AbfHBJqG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 05:46:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB1DEB066;
        Fri,  2 Aug 2019 09:46:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9540CDADC0; Fri,  2 Aug 2019 11:46:39 +0200 (CEST)
Date:   Fri, 2 Aug 2019 11:46:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC] BTRFS_DEV_REPLACE_ITEM_STATE_* doesn't match with on disk
Message-ID: <20190802094639.GV28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <e932064c-6182-a87c-3475-bf1765b165bc@oracle.com>
 <e19a1d1c-3d93-7b5c-01b1-83c0c53323c8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e19a1d1c-3d93-7b5c-01b1-83c0c53323c8@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 12, 2018 at 09:50:36AM +0200, Nikolay Borisov wrote:
> On 12.11.18 г. 6:58 ч., Anand Jain wrote:
> > The dev_replace_state defines are miss matched between the
> > BTRFS_IOCTL_DEV_REPLACE_STATE_* and BTRFS_DEV_REPLACE_ITEM_STATE_* [1].
> > 
> > [1]
> > -----------------------------
> > btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED        2
> > btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED        3
> > btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED        4
> > 
> > btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_SUSPENDED    2
> > btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_FINISHED    3
> > btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_CANCELED    4
> > -----------------------------
> > 
> > The BTRFS_DEV_REPLACE_ITEM_STATE_* series is unused in both btrfs.ko and
> > btrfs-progs, the on-disk also follows BTRFS_IOCTL_DEV_REPLACE_STATE_*
> > (we set dev_replace->replace_state using the
> > BTRFS_IOCTL_DEV_REPLACE_STATE_* defines and write to the on-disk).
> > 
> >  359         btrfs_set_dev_replace_replace_state(eb, ptr,
> >  360                 dev_replace->replace_state);
> > 
> > IMO it should be ok to delete the BTRFS_DEV_REPLACE_ITEM_STATE_*
> > altogether? But how about the userland progs other than btrfs-progs?
> > If not at least fix the miss match as in [2], any comments?
> 
> Unfortunately you are right. This seems to stem from sloppy job back in
> the days of initial dev-replace support. BTRFS_DEV_REPLACE_ITEM_STATE_*
> were added in e922e087a35c ("Btrfs: enhance btrfs structures for device
> replace support"), yet they were never used. And the
> IOCTL_DEV_REPLACE_STATE* were added in e93c89c1aaaa ("Btrfs: add new
> sources for device replace code").
> 
> It looks like the ITEM_STATE* definitions were stillborn so to speak and
> personally I'm in favor of removing them. They shouldn't have been
> merged in the first place and indeed the patch doesn't even have a
> Reviewed-by tag. So it originated from the, I'd say, spartan days of
> btrfs development...
> 
> David,  any code which is using BTRFS_DEV_REPLACE_ITEM_STATE_SUSPENDED
> is inherently broken, so how about we remove those definitions, then
> when it's compilation is broken in the future the author will actually
> have a chance to fix it, though it's highly unlikely anyone is relying
> on those definitions.

I agree it's better to remove them, progs use the define but there's own
defintion in ioctl.h so it's not affected by the kernel header. It's not
like we're removing something in wide use so even if there are some
code that uses it it can be fixed trivially.
