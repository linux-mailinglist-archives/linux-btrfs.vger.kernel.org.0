Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0761823488E
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbgGaPg2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 11:36:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:47448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732554AbgGaPg2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 11:36:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69735AFC1;
        Fri, 31 Jul 2020 15:36:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F0DE5DA82B; Fri, 31 Jul 2020 17:35:55 +0200 (CEST)
Date:   Fri, 31 Jul 2020 17:35:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: convert: report available space before
 convertion happens
Message-ID: <20200731153554.GO3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200729084038.78151-1-wqu@suse.com>
 <20200729084038.78151-4-wqu@suse.com>
 <8sf28zdt.fsf@gmx.com>
 <9904022e-8c16-bd93-960a-93f9019d19ba@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9904022e-8c16-bd93-960a-93f9019d19ba@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 29, 2020 at 05:13:14PM +0800, Qu Wenruo wrote:
> >> +        cctx.free_bytes_initial * 100 / cctx.total_bytes);
> >>      memset(&mkfs_cfg, 0, sizeof(mkfs_cfg)); mkfs_cfg.csum_type =
> >>  csum_type; mkfs_cfg.label = cctx.volume_name;
> >> diff --git a/convert/source-fs.c b/convert/source-fs.c index
> >> f7fd3d6055b7..d2f7a825238d 100644 --- a/convert/source-fs.c +++
> >> b/convert/source-fs.c @@ -74,6 +74,7 @@ void
> >> init_convert_context(struct btrfs_convert_context *cctx)
> >>      cache_tree_init(&cctx->used_space);
> >>  cache_tree_init(&cctx->data_chunks);
> >>  cache_tree_init(&cctx->free_space);
> >> +    cache_tree_init(&cctx->free_space_initial);
> >>  }  void clean_convert_context(struct btrfs_convert_context
> >>  *cctx)
> > 
> > Did you forget the clean path? :)
> 
> Oh, thanks for that!
> Just forgot that.

Which I assume means

--- a/convert/source-fs.c
+++ b/convert/source-fs.c
@@ -82,6 +82,7 @@ void clean_convert_context(struct btrfs_convert_context *cctx)
        free_extent_cache_tree(&cctx->used_space);
        free_extent_cache_tree(&cctx->data_chunks);
        free_extent_cache_tree(&cctx->free_space);
+       free_extent_cache_tree(&cctx->free_space_initial);
 }
 
 int block_iterate_proc(u64 disk_block, u64 file_block,
