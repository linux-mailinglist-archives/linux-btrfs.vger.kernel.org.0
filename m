Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C01EC3F59
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 20:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbfJASF6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 14:05:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:35630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727269AbfJASF5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 14:05:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1FCDBAFF6;
        Tue,  1 Oct 2019 18:05:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6D6EDDA88C; Tue,  1 Oct 2019 20:06:13 +0200 (CEST)
Date:   Tue, 1 Oct 2019 20:06:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org, Zdenek Sojka <zsojka@seznam.cz>
Subject: Re: [PATCH] btrfs: nofs inode allocations
Message-ID: <20191001180613.GF2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org, Zdenek Sojka <zsojka@seznam.cz>
References: <20190909141204.24557-1-josef@toxicpanda.com>
 <a4f375b2-b610-ed0b-4dcf-147da15065ef@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4f375b2-b610-ed0b-4dcf-147da15065ef@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 09, 2019 at 05:28:11PM +0300, Nikolay Borisov wrote:
> > This is because btrfs_new_inode() calls new_inode() under the
> > transaction.  We could probably move the new_inode() outside of this but
> > for now just wrap it in memalloc_nofs_save().
> 
> If I'm understanding correctly what happens here is that symlinking
> wants to instantiate a new inode
> (new_inode->btrfs_alloc_inode->kmem_cache_alloc with GFP_KERNEL) but it
> triggers background reclaim, hence goes to sleep, while holding a
> transaction. At the same time background reclaim joins the same
> transaction which is now blocked by the symlinking thread, hence it's
> prone to deadlock ?

Yes, that's the pattern, GFP_KERNEL inside
start_transaction/commit_transaction. The more generic fix is in the works.
