Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E1180349
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 17:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgCJQa2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 12:30:28 -0400
Received: from verein.lst.de ([213.95.11.211]:53887 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgCJQa2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 12:30:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A53BC68BE1; Tue, 10 Mar 2020 17:30:25 +0100 (CET)
Date:   Tue, 10 Mar 2020 17:30:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/15] btrfs: fix double __endio_write_update_ordered
 in direct I/O
Message-ID: <20200310163024.GB6361@lst.de>
References: <cover.1583789410.git.osandov@fb.com> <b4b45179cc951dde98feea48723572683daf7fb3.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4b45179cc951dde98feea48723572683daf7fb3.1583789410.git.osandov@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 09, 2020 at 02:32:28PM -0700, Omar Sandoval wrote:
> +static void btrfs_submit_direct_hook(struct btrfs_dio_private *dip)

Just curious: why is this routine called btrfs_submit_direct_hook?
it doesn't seem to hook up anything, but just contains the guts of
btrfs_submit_direct.  Any reason to keep the two functions separate?

Also instead of the separate bip allocation and the bio clone, why
not clone into a private bio_set that contains the private data
as part of the allocation?
