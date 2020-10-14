Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E86828E1FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 16:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbgJNOOR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 10:14:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:37410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731395AbgJNOOQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 10:14:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 96598AD1E
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Oct 2020 14:14:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9374FDA7C3; Wed, 14 Oct 2020 16:12:48 +0200 (CEST)
Date:   Wed, 14 Oct 2020 16:12:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use iosize while reading compressed pages
Message-ID: <20201014141248.GN6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
References: <20200915154140.mlmlwmctre2prf2s@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915154140.mlmlwmctre2prf2s@fiona>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 15, 2020 at 10:41:40AM -0500, Goldwyn Rodrigues wrote:
> While using compression, a submitted bio is mapped with a compressed bio
> which performs the read from disk, decompresses and returns uncompressed
> data to original bio. The original bio must reflect the uncompressed
> size (iosize) of the I/O to be performed, or else the page just gets the
> decompressed I/O length of data (disk_io_size). The compressed bio
> checks the extent map and get the correct length while performing the
> I/O from disk.
> 
> This came up in subpage work when only compressed length of the original
> bio was filled in the page. This worked correctly for pagesize ==
> sectorsize because both compressed and uncompressed data are at pagesize
> boundaries, and would end up filling the requested page.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Added to misc-next, thanks.
