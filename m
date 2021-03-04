Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8809B32CBAD
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 05:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhCDEzv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 23:55:51 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37460 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbhCDEzd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Mar 2021 23:55:33 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 2A0679B444C; Wed,  3 Mar 2021 23:54:51 -0500 (EST)
Date:   Wed, 3 Mar 2021 23:54:51 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Christian =?iso-8859-1?Q?V=F6lker?= <cvoelker@knebb.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Defragmentation vw. Deduplication
Message-ID: <20210304045451.GM32440@hungrycats.org>
References: <11d7701c-4fd8-9bf1-c10e-755e55dd5e57@knebb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11d7701c-4fd8-9bf1-c10e-755e55dd5e57@knebb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 02, 2021 at 10:31:08PM +0100, Christian Völker wrote:
> Hi all,
> 
> might be a simple question but I did not find a trustable source for this.
> 
> BTRFS uses COW which might lead to fragmentation.
> So using "btrfs fi defrag -r /mnt" will bring most file extend in a row and
> copy previously deduplicated extends.
> Obviously this uses more disk space. This is not what I want, but I need to
> run "defrag" because I initially skipped the "compress=zstd" option when
> mounting. So many files are stored without compression. Therefor I neede to
> do the "defrag".
> 
> I am now unsure about the deduplication itself.  How does it work?
> I create a file in a directory (ie on Monday). Some days later I create a
> file which has some extents with equal data. Does btrfs recon the equal
> extents and does it doe deduplication then? 

You have to run a deduper like duperemove or bees to get that behavior.  See

	https://btrfs.wiki.kernel.org/index.php/Deduplication

There are a number of different tools that are also available for other
filesystems as well, e.g. jdupes, which dedupe entire identical files
as opposed to blocks.  If most of your duplicates are entire files then
this can significantly increase dedupe speed and reduce dedupe memory
compared to the block-oriented dedupers.

> Or does it only do deduplication when ie "cp --reflink" is used?

With cp --reflink there is no duplication in the first place.

You can choose a deduper depending on how much RAM and IO you want to
commit to the task, whether you need block- or file-oriented dedupe, etc.

If you don't run a deduper then duplicate data stays duplicated.
If you don't run defrag then reflinked data stays reflinked.

> However as I needed the compression and not the defragmentation is there any
> way to add compression and recreate deduplication later?

You can simply run a deduper after compression is done.

> Sorry if this is a dumb question.
> 
> /KNEBB
> 
> 
