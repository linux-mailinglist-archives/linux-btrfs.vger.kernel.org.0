Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796D73F51FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 22:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhHWUYU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 16:24:20 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47262 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbhHWUYQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 16:24:16 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 49B24B44D0E; Mon, 23 Aug 2021 16:23:29 -0400 (EDT)
Date:   Mon, 23 Aug 2021 16:23:29 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Forza <forza@tnonline.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Support for compressed inline extents
Message-ID: <20210823202329.GG29026@hungrycats.org>
References: <afa2742.c084f5d6.17b6b08dffc@tnonline.net>
 <20210822054549.GC29026@hungrycats.org>
 <1097af0f-fb9e-3c68-24b9-2232748ed77c@tnonline.net>
 <20210822083356.GE29026@hungrycats.org>
 <ca2452a6-3f5d-76df-e91b-dff2dcb53052@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca2452a6-3f5d-76df-e91b-dff2dcb53052@tnonline.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 23, 2021 at 09:34:27PM +0200, Forza wrote:
> Further up you showed that we can read encoded inlined data. What is missing
> for that we can read encoded inlined data that decode to >page_size in size?

In uncompress_inline():

	// decoded length of extent on disk...
	max_size = btrfs_file_extent_ram_bytes(leaf, item);

	...

	// ...can never be more than one page because of this line(*)
	max_size = min_t(unsigned long, PAGE_SIZE, max_size);

There might be further constraints around this code (e.g. the caller
only fills in structures for one page, or doesn't bother to call this
function at all for offsets above PAGE_SIZE).

All the restrictions would need to be removed in the kernel and support
for reading multi-page inline extents added where necessary.  There would
have to be an incompat bit on the filesystem to prevent old kernels from
trying (and failing) to read longer inline extents.  The disk format is
already technically capable of specifying a longer inline extent (up to
min(UINT32_MAX, metadata_page_size)) but that was never the problem.

(*) OK I said unencoded_data_len < PAGE_SIZE in earlier messages because
that's the write-side threshold, but apparently the read-side code uses
a different constraint unencoded_data_len <= PAGE_SIZE, i.e. we can pack
one more byte in there without changing anything else.
