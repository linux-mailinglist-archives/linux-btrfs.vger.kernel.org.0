Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1884CE7DD
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 01:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiCFABP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 19:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiCFABO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 19:01:14 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4CC636696
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 16:00:23 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 81F46235C2D; Sat,  5 Mar 2022 19:00:23 -0500 (EST)
Date:   Sat, 5 Mar 2022 19:00:23 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: status page status - dedupe
Message-ID: <YiP5l4Rq9AOuiIKt@hungrycats.org>
References: <c16169c5b971fe5dee1e50e07e2c7bb8d2bface4.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c16169c5b971fe5dee1e50e07e2c7bb8d2bface4.camel@scientia.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 05, 2022 at 08:21:26PM +0100, Christoph Anton Mitterer wrote:
> Hey.
> 
> I just wondered about the status of the wiki status page?! ;-)
> 
> E.g. it says seeding would be stable, while right now there's an
> ongoing thread on this list about it being broken again.
> 
> 
> In especially, what's the status of out-of-band deduplication (i.e. run
> manually by some program like duperemove or jdupes)?
> Is it safe to be used?
> 
> My understanding was, that for out-of-band dedupe, the kernel performs
> a full byte-by-byte comparison before actually deduplicating, right?
> 
> So it shouldn't matter so much which tool is used in the end and
> whether that's stable or not?

The kernel provides a dedupe ioctl (FIDEDUPERANGE or
BTRFS_IOC_FILE_EXTENT_SAME), and that ioctl does a full byte-by-byte
comparison while locking both inodes; however, there are other ways to
achieve deduplication on btrfs without the ioctl, so you must verify
the tool you are using uses the safe ioctl.

bees, duperemove, btrfs-dedupe, and solstice use the safe dedupe ioctl,
and provide no option to do otherwise.

dduper can be configured to use either the safe dedupe ioctl or the
unsafe clone_range ioctl (--fast-mode).  The unsafe clone ioctl is faster,
and can be used if you know the data is not being modified concurrently
with dedupe.

jdupes can use the safe dedupe ioctl (-B) or very unsafe hardlinks (-H).

bedup uses the unsafe clone ioctl.  There is a branch in the bedup github
repo (wip/dedup-syscall) which uses the safe ioctl but it has not been
merged to master.

Old-school POSIX deduplicators are based on hardlinks and not safe unless
all files are strictly read-only during and after dedupe.

> Thanks,
> Chris.
