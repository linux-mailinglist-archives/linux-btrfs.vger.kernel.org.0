Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D7E18A08A
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 17:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCRQdX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 12:33:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:45514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgCRQdW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 12:33:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C84FBAC5F;
        Wed, 18 Mar 2020 16:33:21 +0000 (UTC)
Date:   Wed, 18 Mar 2020 11:33:18 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 00/15] btrfs: read repair/direct I/O improvements
Message-ID: <20200318163318.yoetyqma7kh4l5y7@fiona>
References: <cover.1583789410.git.osandov@fb.com>
 <20200310163940.GE6361@lst.de>
 <20200311092251.GG252106@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311092251.GG252106@vader>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On  2:22 11/03, Omar Sandoval wrote:
> On Tue, Mar 10, 2020 at 05:39:40PM +0100, Christoph Hellwig wrote:
> > Adding Goldwyn,
> > 
> > as he has been looking into converting btrfs to the iomap direct
> > I/O code.  This doesn't look like a major conflict, but he should
> > be knowledgeable about the dio code by now after a few iterations
> > of that.
> 
> Thanks, I did try to avoid conflicting with the iomap rework, and I'm
> looking forward to the further improvement.

Sorry for the late response, I have been on vacation last week and
recovering from backlog. Most of the code does not seem to conflict with
the direct I/O iomap work.

I am ready with my patches in my git [1]. However, I would like to base
my patches on yours. Do you have them in a public git tree anywhere?
preferably with the acks/review comments.

[1] https://github.com/goldwynr/linux/tree/btrfs-iomap-dio

-- 
Goldwyn
