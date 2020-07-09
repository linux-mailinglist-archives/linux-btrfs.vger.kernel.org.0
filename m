Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A85621A5C3
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgGIR0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 13:26:37 -0400
Received: from verein.lst.de ([213.95.11.211]:40230 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgGIR0h (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 13:26:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 876C168AEF; Thu,  9 Jul 2020 19:26:34 +0200 (CEST)
Date:   Thu, 9 Jul 2020 19:26:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        linux-btrfs@vger.kernel.org, Andy Lavr <andy.lavr@gmail.com>
Subject: Re: [PATCH] btrfs: wire up iter_file_splice_write
Message-ID: <20200709172634.GA17914@lst.de>
References: <20200709162206.113927-1-hch@lst.de> <20200709172428.GD15161@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709172428.GD15161@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 09, 2020 at 07:24:28PM +0200, David Sterba wrote:
> On Thu, Jul 09, 2020 at 06:22:06PM +0200, Christoph Hellwig wrote:
> > btrfs implements the iter_write op and thus can use the more efficient
> > iov_iter based splice implementation.  For now falling back to the less
> > efficient default is pretty harmless, but I have a pending series that
> > removes the default, and thus would cause btrfs to not support splice
> > at all.
> 
> Do you want this patch to go in this cycle? I have some more patches
> queued and don't mind adding it if it makes development of your patchset
> easier.

That would be great.
