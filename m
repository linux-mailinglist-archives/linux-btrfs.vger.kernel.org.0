Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907484836C0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 19:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiACSWR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 13:22:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59858 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbiACSWR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 13:22:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 40EF51F386;
        Mon,  3 Jan 2022 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641234136;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m2T7Ptw6ivT22notp7XGH744eDJ9q3aTWSw5scKaE7c=;
        b=IhUL+BrNeK04m/jxSIY3+iS654VLE0a9ReZ9QUWzIAFEkEflzyNoFLnuQ1NnXxJI2sGR9H
        kDYQloYwgSpEkxg70B344o5FY64GlXk0zm36LfJVQeem/m4E6chJTmi+o/vTb9PAcRXL3e
        ieWquwm5oKglop9HHGm5PrDmAsslt8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641234136;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m2T7Ptw6ivT22notp7XGH744eDJ9q3aTWSw5scKaE7c=;
        b=SEvKkNpcEODHnL8E9Hc3Gsxk3np/iW8f0Tw3Mrpcus2RuScMx4NISB5iZUfdGDXnuybiA2
        Xp9wnseUGevyLiDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EEBA5A3B89;
        Mon,  3 Jan 2022 18:22:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2DF7EDA729; Mon,  3 Jan 2022 19:21:46 +0100 (CET)
Date:   Mon, 3 Jan 2022 19:21:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] btrfs: Remove redundant initialization of slot
Message-ID: <20220103182146.GN28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20211231122306.13720-1-jiapeng.chong@linux.alibaba.com>
 <f6aa56ee-16b2-9a53-2377-07d638b1289b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6aa56ee-16b2-9a53-2377-07d638b1289b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 31, 2021 at 09:07:45PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/12/31 20:23, Jiapeng Chong wrote:
> > slot is being initialized to path->slots[0] but this is never
> > read as slot is overwritten later on. Remove the redundant
> > initialization.
> >
> > Cleans up the following clang-analyzer warning:
> >
> > fs/btrfs/tree-log.c:6125:7: warning: Value stored to 'slot' during its
> > initialization is never read [clang-analyzer-deadcode.DeadStores].
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> >   fs/btrfs/tree-log.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 9165486b554e..c083562a3334 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -6122,7 +6122,7 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
> >   	while (true) {
> >   		struct btrfs_fs_info *fs_info = root->fs_info;
> >   		struct extent_buffer *leaf = path->nodes[0];
> > -		int slot = path->slots[0];
> > +		int slot;
> 
> If you're cleaning up slot, then why not also cleaning up leaf?

Yes, the variable leaf does not need to be initialized as well, both
should be cleaned up in the same patch.

> And again, no feedback no matter what on other patches from you, and
> still CC to maintainers.

It's better to add the CCs than not, don't worry about that.
