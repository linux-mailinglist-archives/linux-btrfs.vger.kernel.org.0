Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F0C24FE03
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHXMrP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 08:47:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHXMrO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 08:47:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B0094ACA0;
        Mon, 24 Aug 2020 12:47:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05510DA730; Mon, 24 Aug 2020 14:46:04 +0200 (CEST)
Date:   Mon, 24 Aug 2020 14:46:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: pretty print leaked root name
Message-ID: <20200824124604.GJ2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1597953516.git.josef@toxicpanda.com>
 <461693e5c015857e684878e99e5e65075bb97c13.1597953516.git.josef@toxicpanda.com>
 <d98bb04e-1bcf-80c7-26ae-e91f3ecfd818@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d98bb04e-1bcf-80c7-26ae-e91f3ecfd818@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 21, 2020 at 10:35:38AM +0300, Nikolay Borisov wrote:
> 
> 
> On 20.08.20 г. 23:00 ч., Josef Bacik wrote:
> > I'm a actual human being so am incapable of converting u64 to s64 in my
> > head, so add a helper to get the pretty name of a root objectid and use
> > that helper to spit out the name for any special roots for leaked roots,
> > so I don't have to scratch my head and figure out which root I messed up
> > the refs for.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/disk-io.c    |  8 +++++---
> >  fs/btrfs/print-tree.c | 37 +++++++++++++++++++++++++++++++++++++
> >  fs/btrfs/print-tree.h |  1 +
> >  3 files changed, 43 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index ac6d6fddd5f4..a7358e0f59de 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -1506,11 +1506,13 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
> >  	struct btrfs_root *root;
> >  
> >  	while (!list_empty(&fs_info->allocated_roots)) {
> > +		const char *name = btrfs_root_name(root->root_key.objectid);
> > +
> >  		root = list_first_entry(&fs_info->allocated_roots,
> >  					struct btrfs_root, leak_list);
> > -		btrfs_err(fs_info, "leaked root %llu-%llu refcount %d",
> > -			  root->root_key.objectid, root->root_key.offset,
> > -			  refcount_read(&root->refs));
> > +		btrfs_err(fs_info, "leaked root %s%lld-%llu refcount %d",
> 
> nit: Won't this string result in some rather awkward looking strings,
> such as:
> 
> "leaked root ROOT_TREE<objectid>-<offset>..." i.e shouldn't the
> (objectid,offset) pair be marked with parentheses?

We need to print either string name or value, and in one go. Unlike
in progs, I'd rather avoid split stings in kernel and using
pr_cont/KERN_CONT.

The option is see is to supply a buffer to the pretty printer that would
be used in case we need the numerical id. Like:

	while (allocated_roots) {
		char root_name[24];

		...
		btrfs_err(..., "leaked root %s ...",
			get_root_name(id, root_name));
	}

where

	char *get_root_name(u64 id, char *buf) {
		if (numeric root) {
			sprintf(buf, "%llu", ud);
			return buf;
		}
		return <root name from the table>;
	}
