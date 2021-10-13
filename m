Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6423142C1C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhJMNyz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 09:54:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37494 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhJMNyy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 09:54:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A8E0620211;
        Wed, 13 Oct 2021 13:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634133170;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Agec/DvixSfSOiADqvh+Iw6ER8PkZ594LLTgdRLR0Cs=;
        b=nAUpBW12fNianUCWx3OdOK/tnQv8Ebi/nzgfEwGetOY+TO9QYfK2muESZzG3NjpyZ9rrlU
        HAUMph5AF6wHTJuczSmAr2IbpHGiZxptuDh7pIMPBpSNPWEpVKL+YeUpCypp+oCxPT9tmU
        ZIhxhod7djf4mM+T++fjNvaCArV97mI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634133170;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Agec/DvixSfSOiADqvh+Iw6ER8PkZ594LLTgdRLR0Cs=;
        b=7tTu6rE+uIq+TWpv7kS0oTYf0ifPTrzNAQLUIs+GI8jtFhIhSmLQyurNiIK9R13oojAguX
        Fqd256UM3SkpjOBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D5F0FA3B81;
        Wed, 13 Oct 2021 13:52:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4B739DA7A3; Wed, 13 Oct 2021 15:52:26 +0200 (CEST)
Date:   Wed, 13 Oct 2021 15:52:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: zoned: use greedy gc for auto reclaim
Message-ID: <20211013135226.GG9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <75b42490e41e7c7bf49c07c76fb93764a726c621.1634035992.git.johannes.thumshirn@wdc.com>
 <3d5b7f4e-646b-8430-6970-e287ebbb7719@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d5b7f4e-646b-8430-6970-e287ebbb7719@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 12, 2021 at 04:56:01PM +0300, Nikolay Borisov wrote:
> On 12.10.21 г. 15:37, Johannes Thumshirn wrote:
> > Currently auto reclaim of unusable zones reclaims the block-groups in the
> > order they have been added to the reclaim list.
> > 
> > Change this to a greedy algorithm by sorting the list so we have the
> > block-groups with the least amount of valid bytes reclaimed first.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> > ---
> > Changes since v1:
> > -  Changed list_sort() comparator to 'boolean' style
> > 
> > Changes since RFC:
> > - Updated the patch description
> > - Don't sort the list under the spin_lock (David)
> 
> <snip>
> 
> 
> > @@ -1510,17 +1528,20 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
> >  	}
> >  
> >  	spin_lock(&fs_info->unused_bgs_lock);
> > -	while (!list_empty(&fs_info->reclaim_bgs)) {
> > +	list_splice_init(&fs_info->reclaim_bgs, &reclaim_list);
> > +	spin_unlock(&fs_info->unused_bgs_lock);
> > +
> > +	list_sort(NULL, &reclaim_list, reclaim_bgs_cmp);
> > +	while (!list_empty(&reclaim_list)) {
> 
> Nit: Now that you've switched to a local reclaim_list you can convert
> the while to a list_for_each_entry_safe, since it's guaranteed that new
> entries can't be added while you are iterating the list, which is
> generally the reason why a while() is preferred to one of the iteration
> helpers.

Like the following? I'll fold it in if yes:

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1507,7 +1507,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 {
        struct btrfs_fs_info *fs_info =
                container_of(work, struct btrfs_fs_info, reclaim_bgs_work);
-       struct btrfs_block_group *bg;
+       struct btrfs_block_group *bg, *tmp;
        struct btrfs_space_info *space_info;
        LIST_HEAD(again_list);
        LIST_HEAD(reclaim_list);
@@ -1532,13 +1532,10 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
        spin_unlock(&fs_info->unused_bgs_lock);
 
        list_sort(NULL, &reclaim_list, reclaim_bgs_cmp);
-       while (!list_empty(&reclaim_list)) {
+       list_for_each_entry_safe(bg, tmp, &reclaim_list, bg_list) {
                u64 zone_unusable;
                int ret = 0;
 
-               bg = list_first_entry(&reclaim_list,
-                                     struct btrfs_block_group,
-                                     bg_list);
                list_del_init(&bg->bg_list);
 
                space_info = bg->space_info;
---
