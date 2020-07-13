Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264D82197F4
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 07:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGIFci (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 01:32:38 -0400
Received: from verein.lst.de ([213.95.11.211]:38023 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgGIFci (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 01:32:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2292B68B05; Thu,  9 Jul 2020 07:32:34 +0200 (CEST)
Date:   Thu, 9 Jul 2020 07:32:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        dm-devel@redhat.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove dead bdi congestion leftovers
Message-ID: <20200709053233.GA3243@lst.de>
References: <20200701090622.3354860-1-hch@lst.de> <b5d6df17-68af-d535-79e4-f95e16dd5632@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5d6df17-68af-d535-79e4-f95e16dd5632@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 08, 2020 at 05:14:29PM -0600, Jens Axboe wrote:
> On 7/1/20 3:06 AM, Christoph Hellwig wrote:
> > Hi Jens,
> > 
> > we have a lot of bdi congestion related code that is left around without
> > any use.  This series removes it in preparation of sorting out the bdi
> > lifetime rules properly.
> 
> Please run series like this through a full compilation, for both this one
> and the previous series I had to fix up issues like this:
> 
> drivers/md/bcache/request.c: In function ‘bch_cached_dev_request_init’:
> drivers/md/bcache/request.c:1233:18: warning: unused variable ‘g’ [-Wunused-variable]
>  1233 |  struct gendisk *g = dc->disk.disk;
>       |                  ^
> drivers/md/bcache/request.c: In function ‘bch_flash_dev_request_init’:
> drivers/md/bcache/request.c:1320:18: warning: unused variable ‘g’ [-Wunused-variable]
>  1320 |  struct gendisk *g = d->disk;
>       |                  ^
> 
> Did the same here, applied it.

And just like the previous one I did, and the compiler did not complain.
There must be something about certain gcc versions not warning about
variables that are initialized but not otherwise used.
