Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B2BB844
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 17:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfIWPpe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 11:45:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:32944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbfIWPpe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 11:45:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98AE4ADEC;
        Mon, 23 Sep 2019 15:45:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 889B1DA871; Mon, 23 Sep 2019 17:45:53 +0200 (CEST)
Date:   Mon, 23 Sep 2019 17:45:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: tree-checker: Add check for INODE_REF
Message-ID: <20190923154553.GH2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190826074039.28517-1-wqu@suse.com>
 <20190826074039.28517-3-wqu@suse.com>
 <4c9195c9-5fc1-8524-e7d8-78ad1e942df7@suse.com>
 <a9cb291b-7efe-e1a0-bf9f-a503fdc4001a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9cb291b-7efe-e1a0-bf9f-a503fdc4001a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 26, 2019 at 07:50:03PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/8/26 下午7:45, Nikolay Borisov wrote:
> >
> >
> > On 26.08.19 г. 10:40 ч., Qu Wenruo wrote:
> >> For INODE_REF we will check:
> >> - Objectid (ino) against previous key
> >>   To detect missing INODE_ITEM.
> >>
> >> - No overflow/padding in the data payload
> >>   Much like DIR_ITEM, but with less members to check.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>  fs/btrfs/tree-checker.c | 53 +++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 53 insertions(+)
> >>
> >> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> >> index 636ce1b4566e..3ce447eb591c 100644
> >> --- a/fs/btrfs/tree-checker.c
> >> +++ b/fs/btrfs/tree-checker.c
> >> @@ -842,6 +842,56 @@ static int check_inode_item(struct extent_buffer *leaf,
> >>  	return 0;
> >>  }
> >>
> >> +#define inode_ref_err(fs_info, eb, slot, fmt, ...)		\
> >> +	inode_item_err(fs_info, eb, slot, fmt, __VA_ARGS__)
> >
> > This define doesn't bring anything, just opencode the call to
> > inode_item_err directly.
> 
> I could argue we that in an inode ref context, using a inode_item_err()
> doesn't look right.
> 
> And since it's doesn't do any hurt, I prefer to make the error message
> parse to match the context.

I agree the alias inode_ref_err does not hurt, there's no penatly in the
code so for sake of readability let's do it.
