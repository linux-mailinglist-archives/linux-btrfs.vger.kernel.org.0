Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF28F82495
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfHESEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 14:04:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:54022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728837AbfHESEu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 14:04:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E43AAC7F;
        Mon,  5 Aug 2019 18:04:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BD9B4DABC7; Mon,  5 Aug 2019 20:05:21 +0200 (CEST)
Date:   Mon, 5 Aug 2019 20:05:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix memory leaks in the test
 test_find_first_clear_extent_bit
Message-ID: <20190805180521.GE28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190803085316.7448-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803085316.7448-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 03, 2019 at 09:53:16AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test creates an extent io tree and sets several ranges with the
> CHUNK_ALLOCATED and CHUNK_TRIMMED bits, resulting in the allocation of
> several extent state structures. However the test never clears those
> ranges, resulting in memory leaks of the extent state structures.
> 
> This is detected when CONFIG_BTRFS_DEBUG is set once we remove the
> btrfs module (rmmod btrfs):
> 
> [57399.787918] BTRFS: state leak: start 67108864 end 75497471 state 1 in tree 1 refs 1
> [57399.790155] BTRFS: state leak: start 33554432 end 67108863 state 33 in tree 1 refs 1
> [57399.791941] BTRFS: state leak: start 1048576 end 4194303 state 33 in tree 1 refs 1
> [57399.793753] BTRFS: state leak: start 67108864 end 75497471 state 1 in tree 1 refs 1
> [57399.795188] BTRFS: state leak: start 33554432 end 67108863 state 33 in tree 1 refs 1
> [57399.796453] BTRFS: state leak: start 1048576 end 4194303 state 33 in tree 1 refs 1
> [57399.797765] BTRFS: state leak: start 67108864 end 75497471 state 1 in tree 1 refs 1
> [57399.799049] BTRFS: state leak: start 33554432 end 67108863 state 33 in tree 1 refs 1
> [57399.800142] BTRFS: state leak: start 1048576 end 4194303 state 33 in tree 1 refs 1
> [57399.801126] BTRFS: state leak: start 67108864 end 75497471 state 1 in tree 1 refs 1
> [57399.802106] BTRFS: state leak: start 33554432 end 67108863 state 33 in tree 1 refs 1
> [57399.803119] BTRFS: state leak: start 1048576 end 4194303 state 33 in tree 1 refs 1
> [57399.804153] BTRFS: state leak: start 67108864 end 75497471 state 1 in tree 1 refs 1
> [57399.805196] BTRFS: state leak: start 33554432 end 67108863 state 33 in tree 1 refs 1
> [57399.806191] BTRFS: state leak: start 1048576 end 4194303 state 33 in tree 1 refs 1
> 
> The start and end offsets reported correspond exactly to the ranges
> used by the test.
> 
> So fix that by clearing all the ranges when the test finishes.
> 
> Fixes: 1eaebb341d2b41 ("btrfs: Don't trim returned range based on input value in find_first_clear_extent_bit")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
