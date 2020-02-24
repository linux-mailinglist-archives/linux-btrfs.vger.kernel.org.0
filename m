Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE61216AE40
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 18:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgBXR6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 12:58:20 -0500
Received: from verein.lst.de ([213.95.11.211]:39476 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgBXR6U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 12:58:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 603D568B20; Mon, 24 Feb 2020 18:58:17 +0100 (CET)
Date:   Mon, 24 Feb 2020 18:58:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 0/4] btrfs: bypass UUID API aliasing
Message-ID: <20200224175816.GA8184@lst.de>
References: <20200224153752.35063-1-andriy.shevchenko@linux.intel.com> <20200224172645.GA2902@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224172645.GA2902@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 06:26:45PM +0100, David Sterba wrote:
> On Mon, Feb 24, 2020 at 05:37:48PM +0200, Andy Shevchenko wrote:
> > UUID API has been converted to differentiate UUID and GUID.
> > Btrfs is using aliases to the new API for some time.
> > 
> > Bypass that aliasing by converting btrfs to use API calls directly.
> > 
> > The series has been compiled only.
> 
> Now it looks good to me, all the objections have been addressed, thanks.
> 
> > P.S. It may be applied either to btrfs tree or to UUID one.
> 
> Both works for me. There are no conflicts with current btrfs queue and I
> don't expect anything serious in the future.

Please pick it up through the btrfs tree.
