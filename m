Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED961B8093
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Apr 2020 22:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgDXUZb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Apr 2020 16:25:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:41936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbgDXUZa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Apr 2020 16:25:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DCFDDABE2;
        Fri, 24 Apr 2020 20:25:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 140CEDA8EC; Fri, 24 Apr 2020 22:24:45 +0200 (CEST)
Date:   Fri, 24 Apr 2020 22:24:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 1/2] btrfs: Move on-disk structure definition to
 btrfs_tree.h
Message-ID: <20200424202445.GY18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
References: <20200415084113.64378-1-wqu@suse.com>
 <20200415084113.64378-2-wqu@suse.com>
 <20200421113138.GA10447@infradead.org>
 <18832f69-073f-ef74-5ec7-3de06df466df@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18832f69-073f-ef74-5ec7-3de06df466df@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 21, 2020 at 07:41:40PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/4/21 下午7:31, Christoph Hellwig wrote:
> > On Wed, Apr 15, 2020 at 04:41:12PM +0800, Qu Wenruo wrote:
> >> These structures all are on-disk format. Move them to btrfs_tree.h
> >>
> >> This allows us to sync the header to different projects, who need to
> >> read btrfs filesystem, like U-boot, grub.
> > 
> > Please use a separate header for that.  btrfs_tree.h is a UAPI header
> > with strict ABI guarantees.  Just add a fs/btrfs/btrfs_format.h that
> > can be copied into the projects where is needed.
> > 
> Doesn't on-disk format itself need strict ABI guarantees?
> 
> Thus it looks like the perfect location for on-disk format definitions.

Right now I'm not sure if it's a good idea to put the on-disk format to
the UAPI path or not. The exported code is to support the ioctls,
there's an overlap with the on-disk format but providing all the on-disk
structures for general might become an unnecessry burden.

We know that there's a small number of projects that want to sync the
on-disk format so I don't think it's going to be a problem for them to
use a private header.
