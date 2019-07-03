Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94FC65E2DC
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2019 13:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfGCLgY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 07:36:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:33306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbfGCLgY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jul 2019 07:36:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DEA0AFA9;
        Wed,  3 Jul 2019 11:36:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A01F4DA809; Wed,  3 Jul 2019 13:37:06 +0200 (CEST)
Date:   Wed, 3 Jul 2019 13:37:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     WenRuo Qu <wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: Kill ASSERT() for damaged filesystem
Message-ID: <20190703113706.GS20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, WenRuo Qu <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190703072428.13759-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703072428.13759-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 03, 2019 at 07:24:42AM +0000, WenRuo Qu wrote:
> For damaged filesystem like 'bko-155621-bad-block-group-offset.raw' from
> fuzzed tests, there may be no valid METADATA blocks at all.
> 
> Thus we could hit the following ASSERT():
>   extent-tree.c:2484: alloc_tree_block: Assertion `sinfo` failed, value 0
>   btrfs(+0x20ef8)[0x555adf5b2ef8]
>   btrfs(+0x2107b)[0x555adf5b307b]
>   btrfs(+0x27e7e)[0x555adf5b9e7e]
>   btrfs(btrfs_alloc_free_block+0x67)[0x555adf5ba097]
>   btrfs(+0x61188)[0x555adf5f3188]
>   btrfs(+0x70921)[0x555adf602921]
>   btrfs(main+0x94)[0x555adf5a7168]
>   /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7fbd4c658ee3]
>   btrfs(_start+0x2e)[0x555adf5a6cee]
> 
> The ASSERT() expects that every filesystem has one METADATA block
> groups, but btrfs-check can accept any damaged filesystem.
> 
> So kill the ASSERT(), and return -EUCLEAN with one error message.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> To David:
> Please fold this tiny modification to the following patch:
> a970af98a1eb ("btrfs-progs: Fix false ENOSPC alert by tracking used space
> correctly").

Folded to the patch, thanks. The fuzz-tests have been enabled in the
continuous integration but due to other problems the status is red so I
did not notice. Once the CI situtation is resolved, we'll know sooner
that something regressed.
