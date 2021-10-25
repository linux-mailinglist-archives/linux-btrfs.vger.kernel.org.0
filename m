Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D2843908C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 09:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhJYHre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 03:47:34 -0400
Received: from verein.lst.de ([213.95.11.211]:55931 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231905AbhJYHre (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 03:47:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9DE0468B05; Mon, 25 Oct 2021 09:45:09 +0200 (CEST)
Date:   Mon, 25 Oct 2021 09:45:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>, hch@lst.de,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] fs: export an inode_update_time helper
Message-ID: <20211025074509.GA10347@lst.de>
References: <cover.1634231213.git.josef@toxicpanda.com> <32a87813b58c1ddc3ae4d769cd2b667901621f6a.1634231213.git.josef@toxicpanda.com> <20211021163817.GH20319@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021163817.GH20319@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 06:38:17PM +0200, David Sterba wrote:
> On Thu, Oct 14, 2021 at 01:11:00PM -0400, Josef Bacik wrote:
> > If you already have an inode and need to update the time on the inode
> > there is no way to do this properly.  Export this helper to allow file
> > systems to update time on the inode so the appropriate handler is
> > called, either ->update_time or generic_update_time.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> I'd like to get ack from Christoph, though it's a simple change it's
> still in another subsystem.

Not a big fan, but compared to the other options it seems like the
least bad option.  That being said I'm not the VFS maintainer anyway.
