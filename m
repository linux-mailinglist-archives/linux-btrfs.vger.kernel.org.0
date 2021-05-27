Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3C392CE9
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 May 2021 13:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhE0LpY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 May 2021 07:45:24 -0400
Received: from verein.lst.de ([213.95.11.211]:38471 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233490AbhE0LpX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 May 2021 07:45:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B82868AFE; Thu, 27 May 2021 13:43:47 +0200 (CEST)
Date:   Thu, 27 May 2021 13:43:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>
Subject: Re: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Message-ID: <20210527114347.GA18214@lst.de>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com> <YKeZ5dtxt3gsImsd@casper.infradead.org> <20210524073527.GA24302@lst.de> <BYAPR04MB49650508F2C5A4EA3B576D5286249@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49650508F2C5A4EA3B576D5286249@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 26, 2021 at 02:55:57AM +0000, Chaitanya Kulkarni wrote:
> Is above comment is on this series or on the API present in the folio
> patches [1] ?

All of the above.

> Since if we change the return type to bool for the functions in
> question [2] in this series we also need to modify the callers, I'm not sure
> that is worth it though.

Yes, all the caller would need to change as well.
