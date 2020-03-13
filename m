Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C88184A71
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgCMPS5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:18:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:40074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgCMPS5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:18:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CC9EDADEE;
        Fri, 13 Mar 2020 15:18:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA2C8DA7A7; Fri, 13 Mar 2020 16:18:29 +0100 (CET)
Date:   Fri, 13 Mar 2020 16:18:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/8] btrfs: free the reloc_control in a consistent way
Message-ID: <20200313151829.GN12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200304161830.2360-1-josef@toxicpanda.com>
 <20200304161830.2360-5-josef@toxicpanda.com>
 <f77683bc-c644-25a8-6d97-fbe339bd5f98@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f77683bc-c644-25a8-6d97-fbe339bd5f98@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 05, 2020 at 07:39:33PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/3/5 上午12:18, Josef Bacik wrote:
> > If we have an error while processing the reloc roots we could leak roots
> > that were added to rc->reloc_roots before we hit the error.  We could
> > have also not removed the reloct tree mapping from our rb_tree, so clean
> > up any remaining nodes in the reloc root rb_tree.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/relocation.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index c496f8ed8c7e..f6237d885fe0 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -4387,6 +4387,20 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
> >  	return rc;
> >  }
> >  
> > +static void free_reloc_control(struct reloc_control *rc)
> > +{
> > +	struct rb_node *rb_node;
> > +	struct mapping_node *node;
> > +
> > +	free_reloc_roots(&rc->reloc_roots);
> > +	while ((rb_node = rb_first(&rc->reloc_root_tree.rb_root))) {
> 
> rbtree_postorder_for_each_entry_safe().
> 
> So that we don't need to bother the re-balance of rbtree.

I'll update the patch with this

--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4240,15 +4240,13 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
 
 static void free_reloc_control(struct reloc_control *rc)
 {
-       struct rb_node *rb_node;
-       struct mapping_node *node;
+       struct mapping_node *node, *tmp;
 
        free_reloc_roots(&rc->reloc_roots);
-       while ((rb_node = rb_first(&rc->reloc_root_tree.rb_root))) {
-               node = rb_entry(rb_node, struct mapping_node, rb_node);
-               rb_erase(rb_node, &rc->reloc_root_tree.rb_root);
+       rbtree_postorder_for_each_entry_safe(node, tmp,
+                       &rc->reloc_root_tree.rb_root, rb_node)
                kfree(node);
-       }
+
        kfree(rc);
 }

