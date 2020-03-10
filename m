Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB149180397
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 17:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCJQdX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 12:33:23 -0400
Received: from verein.lst.de ([213.95.11.211]:53897 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgCJQdX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 12:33:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3747C68BE1; Tue, 10 Mar 2020 17:33:20 +0100 (CET)
Date:   Tue, 10 Mar 2020 17:33:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/15] btrfs: look at full bi_io_vec for repair decision
Message-ID: <20200310163319.GC6361@lst.de>
References: <cover.1583789410.git.osandov@fb.com> <c0f65f07b18eee7cef4e0b0b439a45ae437a11c6.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0f65f07b18eee7cef4e0b0b439a45ae437a11c6.1583789410.git.osandov@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 09, 2020 at 02:32:29PM -0700, Omar Sandoval wrote:
> +	/*
> +	 * We need to validate each sector individually if the I/O was for
> +	 * multiple sectors.
> +	 */
> +	len = 0;
> +	for (i = 0; i < failed_bio->bi_vcnt; i++) {
> +		len += failed_bio->bi_io_vec[i].bv_len;
> +		if (len > inode->i_sb->s_blocksize) {
> +			need_validation = true;
> +			break;
> +		}

So given that btrfs is the I/O submitter iterating over all bio_vecs
should probably be fine.  That being said I deeply dislike the idea
of having code like this inside the file system.  Maybe we can add
a helper like:

u32 bio_size_all(struct bio *bio)
{
	u32 len, i;

	for (i = 0; i < bio->bi_vcnt; i++)
		len += bio->bi_io_vec[i].bv_len;
	return len;
}

in the core block code, with a kerneldoc comment documenting the
exact use cases, and then use that?
