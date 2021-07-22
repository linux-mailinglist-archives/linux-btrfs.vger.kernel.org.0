Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9CA3D2467
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 15:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhGVMcP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 08:32:15 -0400
Received: from verein.lst.de ([213.95.11.211]:34278 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231924AbhGVMcO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 08:32:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 22EFA68D06; Thu, 22 Jul 2021 15:12:48 +0200 (CEST)
Date:   Thu, 22 Jul 2021 15:12:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: change the refcounting for partitions
Message-ID: <20210722131247.GB27213@lst.de>
References: <20210722075402.983367-1-hch@lst.de> <20210722075402.983367-6-hch@lst.de> <YPkvONK78vIEMrMI@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPkvONK78vIEMrMI@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 04:41:28PM +0800, Ming Lei wrote:
> >  	device_del(pdev);
> >  out_put:
> >  	put_device(pdev);
> > +out_put_disk:
> > +	put_disk(disk);
> 
> put_disk() is only needed for failure of bdev_alloc(). Once bdev->bd_device
> is initialized, the disk reference will be dropped via part_release().

Indeed.
