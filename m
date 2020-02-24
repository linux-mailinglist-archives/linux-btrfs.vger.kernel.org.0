Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED3416ADCF
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 18:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBXRl3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 12:41:29 -0500
Received: from verein.lst.de ([213.95.11.211]:39374 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgBXRl3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 12:41:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 44A5868B20; Mon, 24 Feb 2020 18:41:26 +0100 (CET)
Date:   Mon, 24 Feb 2020 18:41:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v4 1/4] uuid: Add inline helpers to import / export
 UUIDs
Message-ID: <20200224174126.GA7771@lst.de>
References: <20200224153752.35063-1-andriy.shevchenko@linux.intel.com> <20200224153752.35063-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224153752.35063-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 05:37:49PM +0200, Andy Shevchenko wrote:
> Sometimes we may need to import UUID from or export to the raw buffer,
> which is provided outside of kernel and can't be declared as UUID type.
> With current API this operation will require an explicit casting
> to one of UUID types and length, that is always a constant derived as sizeof
> the certain UUID type.
> 
> Provide a helpful set of inline helpers to minimize developer's effort
> in the cases when raw buffers are involved.
> 
> Suggested-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

No a huge fan of these trivial memcpy wrappers, but they also don't
seem entirely horrible:

Acked-by: Christoph Hellwig <hch@lst.de>
