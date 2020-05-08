Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82261CA16A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 05:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEHDOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 23:14:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:35164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbgEHDOK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 23:14:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0BCEFAC7B;
        Fri,  8 May 2020 03:14:12 +0000 (UTC)
Date:   Thu, 7 May 2020 22:14:05 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200508031405.br4dcibcyuoluxum@fiona>
References: <20200326210254.17647-1-rgoldwyn@suse.de>
 <20200326210254.17647-5-rgoldwyn@suse.de>
 <20200327081024.GA24827@infradead.org>
 <20200327161348.to4upflzczkbbpfo@fiona>
 <20200507061430.GA8939@infradead.org>
 <20200507113741.GJ18421@twin.jikos.cz>
 <20200507121037.GA25363@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507121037.GA25363@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On  5:10 07/05, Christoph Hellwig wrote:
> On Thu, May 07, 2020 at 01:37:41PM +0200, David Sterba wrote:
> > On Wed, May 06, 2020 at 11:14:30PM -0700, Christoph Hellwig wrote:
> > > What is the status of this series?  I haven't really seen it posted
> > > any time recently, and it would be sad to miss 5.8..
> > 
> > I've been testing it and reporting to Goldwyn, but there are still
> > problems that don't seem to be fixable for 5.8 target.
> 
> What are the issues, and how can we help to resolve them?

I investigated further and here are my findings.

geenric/475 fails because there are reservations left in the inode's
block reservations system which are not cleared out. So the system
triggers WARN_ON() while performing destroy_inode.

The problem is similar to described in:
50745b0a7f46 ("Btrfs: Direct I/O: Fix space accounting")

To test the theory, I framed an ugly patch of using an extra field
in current-> task_struct to store a number which carries the reservation
currently remaining like the patch does and it works. So what we need is
a way to carry reservation information from btrfs_direct_write() to
iomap's direct ops ->submit_io() where the reservations are consumed.

We cannot use a similar solution of using current->journal_info
because fdatawrite sequence in iomap_dio_rw() uses
current->journal_info.

We cannot perform data reservations and release in iomap_begin() and
iomap_end() for performance and accounting issues.

Ideas welcome.

-- 
Goldwyn
