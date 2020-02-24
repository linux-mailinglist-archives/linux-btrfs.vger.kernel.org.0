Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A916ADD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 18:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBXRmB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 12:42:01 -0500
Received: from verein.lst.de ([213.95.11.211]:39379 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbgBXRmB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 12:42:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1107368BE1; Mon, 24 Feb 2020 18:41:59 +0100 (CET)
Date:   Mon, 24 Feb 2020 18:41:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 2/4] uuid: Provide a GUID generator for raw buffer
Message-ID: <20200224174158.GB7771@lst.de>
References: <20200224153752.35063-1-andriy.shevchenko@linux.intel.com> <20200224153752.35063-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224153752.35063-3-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 05:37:50PM +0200, Andy Shevchenko wrote:
> In some cases we would like to generate a GUID and export it.
> Though it would require either casting to internal kernel types or
> an intermediate buffer. Instead we may achieve this by supplying
> a pointer to raw buffer and make a complimentary API to existing one
> for UUIDs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
