Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036162172EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgGGPsQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:48:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:52846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgGGPsQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jul 2020 11:48:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13823AD19;
        Tue,  7 Jul 2020 15:48:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10452DA818; Tue,  7 Jul 2020 17:47:56 +0200 (CEST)
Date:   Tue, 7 Jul 2020 17:47:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     trix@redhat.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btfrs: initialize return of btrfs_extent_same
Message-ID: <20200707154755.GB16141@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        trix@redhat.com, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200705142058.28305-1-trix@redhat.com>
 <885129e4-d6d6-57d3-21d3-a83bd98c3994@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <885129e4-d6d6-57d3-21d3-a83bd98c3994@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 05, 2020 at 05:48:17PM +0300, Nikolay Borisov wrote:
> On 5.07.20 г. 17:20 ч., trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> > 
> > clang static analysis flags a garbage return
> > 
> > fs/btrfs/reflink.c:611:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
> >         return ret;
> >         ^~~~~~~~~~
> > ret will not be set when olen is 0
> > When olen is 0, this function does no work.
> > 
> > So initialize ret to 0
> > 
> > Signed-off-by: Tom Rix <trix@redhat.com>
> 
> Patch itself is good however, the bug cannot currently be triggered, due
> to the following code in the sole caller (btrfs_remap_file_range):
> 
> 
> 
>    15         if (ret < 0 || len == 0)
>    14                 goto out_unlock;
>    13
>    12         if (remap_flags & REMAP_FILE_DEDUP)
>    11                 ret = btrfs_extent_same(src_inode, off, len, dst_inode, destoff);
>    10         else
>     9                 ret = btrfs_clone_files(dst_file, src_file, off,
> len, destoff);
> 
> i.e len is guaranteed to be non-zero

Yeah, for that reason I don't think we need to set the value inside
btrfs_extent_same because the caller(s) do the sanity checks.

There are VFS-level checks of the length wrt zero, eg. it won't even
call to copy_file_range from vfs_copy_file_range. The user supplied
length = 0 is interpreted as 'until the end of file' and is properly
reclaculated in generic_remap_file_range_prep.

This looks like clang checker is not able to follow the values accross
function calls, even if the functions are static.
