Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44BA3D243A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 15:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhGVMXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 08:23:46 -0400
Received: from verein.lst.de ([213.95.11.211]:34192 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232039AbhGVMXe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 08:23:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4498168D06; Thu, 22 Jul 2021 15:04:08 +0200 (CEST)
Date:   Thu, 22 Jul 2021 15:04:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/9] btrfs: store a block_device in struct
 btrfs_ordered_extent
Message-ID: <20210722130408.GA26825@lst.de>
References: <20210722075402.983367-1-hch@lst.de> <20210722075402.983367-7-hch@lst.de> <20210722125859.GR19710@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722125859.GR19710@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 02:58:59PM +0200, David Sterba wrote:
> On Thu, Jul 22, 2021 at 09:53:59AM +0200, Christoph Hellwig wrote:
> > Store the block device instead of the gendisk in the btrfs_ordered_extent
> > structure intead of acquiring a reference to it later.
>             instead
> 
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> 
> I can add the patch to the next pull request so you can rebase your
> series on top of it and don't need to carry it until the next merge
> window.

Assuming Jens is fine with starting the block tree on -rc3 that would
be great.
