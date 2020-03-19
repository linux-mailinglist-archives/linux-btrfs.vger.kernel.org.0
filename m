Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E83C18AEE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 10:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCSJDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 05:03:39 -0400
Received: from verein.lst.de ([213.95.11.211]:40823 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgCSJDj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 05:03:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 340E968BEB; Thu, 19 Mar 2020 10:03:36 +0100 (CET)
Date:   Thu, 19 Mar 2020 10:03:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 15/15] btrfs: unify buffered and direct I/O read repair
Message-ID: <20200319090336.GA1577@lst.de>
References: <cover.1583789410.git.osandov@fb.com> <7c593decda73deb58515d94e979db6a68527970b.1583789410.git.osandov@fb.com> <37bf11cc-92b3-2b15-ee87-0cbe8c662cc7@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37bf11cc-92b3-2b15-ee87-0cbe8c662cc7@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 19, 2020 at 10:53:22AM +0200, Nikolay Borisov wrote:
> Is this correct though, in case of buffered reads we are always called
> with bi_status != BLK_STS_OK (we are called from end_bio_extent_readpage
> in case uptodate is false,  which happens if failed_bio->bi_status is
> non-zero. Additionally the bio is guaranteed to not be cloned because
> there is : ASSERT(!bio_flagged(bio, BIO_CLONED));

> If I understand this correctly this is the "this is a DIO " branch. IMO
> it'd be clearer if you had bool is_dio = bio_flagged(failed_bio,
> BIO_CLONED) at the top of the function and you used that.

The non-fragile way would be to pass an explicit is_bio argument.
The is cloned thing is just a side effect of the weird cloning done
in the bio path, which hopefully won't survive too long.
