Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F963D592A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhGZL1M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233713AbhGZL1M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:27:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8AB3600D1;
        Mon, 26 Jul 2021 12:07:38 +0000 (UTC)
Date:   Mon, 26 Jul 2021 14:07:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 15/21] btrfs/ioctl: relax restrictions for
 BTRFS_IOC_SNAP_DESTROY_V2 with subvolids
Message-ID: <20210726120735.u7ncpcwyv4am4duz@wittgenstein>
References: <20210726102816.612434-1-brauner@kernel.org>
 <20210726102816.612434-16-brauner@kernel.org>
 <a4931bab-c299-3aa0-a700-5b5e8b61f040@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4931bab-c299-3aa0-a700-5b5e8b61f040@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 26, 2021 at 07:31:07PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/26 下午6:28, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > So far we prevented the deletion of subvolumes and snapshots using subvolume
> > ids possible with the BTRFS_SUBVOL_SPEC_BY_ID flag.
> > This restriction is necessary on idmapped mounts as this allows filesystem wide
> > subvolume and snapshot deletions and thus can escape the scope of what's
> > exposed under the mount identified by the fd passed with the ioctl.
> > 
> > Deletion by subvolume id works by looking for an alias of the parent of the
> > subvolume or snapshot to be deleted. The parent alias can be anywhere in the
> > filesystem. However, as long as the alias of the parent that is found is the
> > same as the one identified by the file descriptor passed through the ioctl we
> > can allow the deletion.
> > 
> > Cc: Chris Mason <clm@fb.com>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: David Sterba <dsterba@suse.com>
> > Cc: linux-btrfs@vger.kernel.org
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Although I'm wondering if there is any special use case for this relaxed
> subvolid deletion?
> 
> As for most subvolume deletion it's from btrfs-progs, which has extra
> path lookup before calling the ioctl (even for subvolid id deletion).
> 
> Thus I guess the relaxed check is only for direct ioctl call for
> subvolume deletion?

Yeah, it's for convenience. My think was that it might be helpful when
you already have the subvolume id around and can use it for subvolume
deletion not bothering with paths.

Christian
