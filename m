Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15AD4CE864
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 04:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiCFDN2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 22:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiCFDN0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 22:13:26 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 857C96395
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 19:12:34 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 856B8236292; Sat,  5 Mar 2022 22:12:33 -0500 (EST)
Date:   Sat, 5 Mar 2022 22:12:33 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Andy Smith <andy@strugglers.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: status page status - dedupe
Message-ID: <YiQmoUnd4jSSdCNt@hungrycats.org>
References: <c16169c5b971fe5dee1e50e07e2c7bb8d2bface4.camel@scientia.org>
 <YiP5l4Rq9AOuiIKt@hungrycats.org>
 <20220306010011.m66pgmvpvetnthok@bitfolk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306010011.m66pgmvpvetnthok@bitfolk.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 06, 2022 at 01:00:11AM +0000, Andy Smith wrote:
> Hello,
> 
> On Sat, Mar 05, 2022 at 07:00:23PM -0500, Zygo Blaxell wrote:
> > bees, duperemove, btrfs-dedupe, and solstice use the safe dedupe ioctl,
> > and provide no option to do otherwise.
> 
> Is there some issue with combining offline dedupe and compression in
> that it undoes all the benefits of the compression? I'm sorry, I
> don't know the details and may have got the wrong impression but I
> thought I had read here recently that there was negative interaction
> here still.

It's more like the other way around:  compression makes some deduplication
tools ineffective.  To perform well, a deduper must have specific
support for btrfs and compression in order to issue dedupe requests
that will remove complete extents and recover free disk space, and it
must not use optimizations that are incompatible with compression.
Without this support, the deduper may fail to detect duplicates and
not have very much impact on total space usage for compressed extents.

All current btrfs dedupe tools choose to keep one duplicate data copy
arbitrarily, without considering the size of the encoding.  So if you have
a compressed file, and make an uncompressed copy, about half of the time
the dedupe tool will replace the compressed copy with the uncompressed
one, when ideally it would measure the size of both and always keep the
smallest version of the data.

bees has limited support for compressed data.  It will avoid shortening
compressed data blocks when this would result in a larger overall
encoding, and it will compress new data extents created by splitting
uncompressed extents.  bees can match compressed and uncompressed copies
of duplicate data.  It uses a variable block size with a small lower bound
for a better hit rate on shorter compressed extents.  bees outperforms
everything else on final data size with compression.

duperemove blindly issues dedupe requests without regard for extent
boundaries or compression.  Compressed data has shorter extents, so it
tends to help duperemove achieve space savings in more cases, but it's
difficult to predict the more or less random effect on the total data
size.  Compression sometimes improves duperemove hit rate, but sometimes
reduces it.  duperemove can match compressed data with uncompressed data.

jdupes gives the same dedupe hit rate for compressed and uncompressed
data since jdupes only handles whole-file duplicates (this also applies
to duperemove in fdupes-compatibility mode).  A whole-file deduplicator
will completely replace all extents in the duplicate files, which avoids
many compression-related issues.  jdupes can match compressed data with
uncompressed data (or any mixture of these in each file).

dduper and solstice use btrfs data csums exclusively to find duplicate
blocks.  Compressed data csums in btrfs are computed on the on-disk
encoding of the data, meaning that they are the csums of the data
_after_ compression for compressed blocks.  The csums cannot be used to
deduplicate data blocks that are uncompressed, that are compressed with
a different algorithm or level, or appear at a different position within
an extent.  These tools cannot match compressed and uncompressed copies
of the same data, and will get very low (often near zero) hit rates on
compressed data.

> Thanks,
> Andy
