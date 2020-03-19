Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3664818B8B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 15:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCSOJP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 10:09:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:41318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbgCSOJP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 10:09:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 40BEEABF6;
        Thu, 19 Mar 2020 14:09:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6E4A6DA70E; Thu, 19 Mar 2020 15:08:45 +0100 (CET)
Date:   Thu, 19 Mar 2020 15:08:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 00/15] btrfs: read repair/direct I/O improvements
Message-ID: <20200319140845.GC12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@lst.de>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1583789410.git.osandov@fb.com>
 <20200310163940.GE6361@lst.de>
 <20200311092251.GG252106@vader>
 <20200318163318.yoetyqma7kh4l5y7@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318163318.yoetyqma7kh4l5y7@fiona>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 18, 2020 at 11:33:18AM -0500, Goldwyn Rodrigues wrote:
> On  2:22 11/03, Omar Sandoval wrote:

> I am ready with my patches in my git [1]. However, I would like to base
> my patches on yours. Do you have them in a public git tree anywhere?
> preferably with the acks/review comments.

I have the branch for testing in my github repository,
https://github.com/kdave/btrfs-devel/tree/ext/omar/dio-fixes .

Regarding the two patchsest, it makes things easier to test at least if
the code does not conflict but I'm a bit worried about adding 2
different reworks of the DIO in one release. OTOH, we' have focus on the
same subsystem, so at this point I'm preferring the option to merge both
unless something serious pops up. The merge target would be 5.8, plenty
of time to revise the desision if needed.
