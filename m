Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887612EAA13
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 12:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbhAELkl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 06:40:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:50918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbhAELkl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 06:40:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F2EDAA7C;
        Tue,  5 Jan 2021 11:39:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 53C32DA7C6; Tue,  5 Jan 2021 12:38:10 +0100 (CET)
Date:   Tue, 5 Jan 2021 12:38:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     bodefang <bodefang@126.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/btrfs: avoid null pointer dereference if reloc
 control has not been initialized
Message-ID: <20210105113810.GL6430@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, bodefang <bodefang@126.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1609080931-4048864-1-git-send-email-bodefang@126.com>
 <20210104151113.GG6430@twin.jikos.cz>
 <125f3257.193a.176d084a633.Coremail.bodefang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <125f3257.193a.176d084a633.Coremail.bodefang@126.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm keeping the rest of the mail as I received it, it's completely
garbled and would need manual reformatting. The changelog and even the
diff are completely on one line(!).

On Tue, Jan 05, 2021 at 11:08:42AM +0800, bodefang wrote:
> Similar to commmit<389305b2aa68>（“btrfs: relocation: Only remove reloc rb_trees if reloc control has been initialized”).it turns out that fs_info::reloc_ctl can be NULL in btrfs_recover_relocation() as we allocate relocation control after allreloc roots have been verified.,so there should be a check for rc to prevent null pointer dereference.
> 
> Signed-off-by: Defang Bo <bodefang@126.com>Reviewed-by: David Sterba <dsterba@suse.cz>---

Oh and don't add reviewed-by unless it's explicitly stated by the
person.

> Changes since v1:
> - More accurate description for this patch to describe how the NULL can get there.
> ---
> --- fs/btrfs/relocation.c | 6 ++++++ 1 file changed, 6 insertions(+) diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c index 3602806..ca03571 100644 --- a/fs/btrfs/relocation.c +++ b/fs/btrfs/relocation.c @@ -626,6 +626,9 @@ static int __must_check __add_reloc_root(struct btrfs_root *root) struct mapping_node *node; struct reloc_control *rc = fs_info->reloc_ctl; + if (!rc) + return 0; + node = kmalloc(sizeof(*node), GFP_NOFS); if (!node) return -ENOMEM; @@ -703,6 +706,9 @@ static int __update_reloc_root(struct btrfs_root *root) struct rb_node *rb_node; struct mapping_node *node = NULL; struct reloc_control *rc = fs_info->reloc_ctl; + + if (!rc) + return 0; spin_lock(&rc->reloc_root_tree.lock); rb_node = rb_simple_search(&rc->reloc_root_tree.rb_root, -- 2.7.4
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> At 2021-01-04 23:11:13, "David Sterba" <dsterba@suse.cz> wrote:
> >On Sun, Dec 27, 2020 at 10:55:31PM +0800, Defang Bo wrote:
> >> Similar to commmit<389305b2>,
> >
> >Please use full commit reference like 389305b2aa68 ("btrfs: relocation:
> >Only remove reloc rb_trees if reloc control has been initialized")
> >
> >> it turns out that fs_info::reloc_ctl can be NULL ,
> >
> >Please describe how the NULL can get there.
