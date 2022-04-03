Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968CB4F080A
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Apr 2022 08:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350385AbiDCGRF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Apr 2022 02:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiDCGRE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Apr 2022 02:17:04 -0400
Received: from marozi.bezitopo.org (bezitopo.org [45.55.162.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEB51BCBC
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Apr 2022 23:15:10 -0700 (PDT)
Received: from puma (unknown [IPv6:2001:5b0:210f:36e8:e24d:2973:8920:8f2a])
        by marozi.bezitopo.org (Postfix) with ESMTPA id 30BE25FA2B
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Apr 2022 02:14:38 -0400 (EDT)
Received: from puma.localnet (localhost [127.0.0.1])
        by puma (Postfix) with ESMTP id AB9B9483794
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Apr 2022 02:14:34 -0400 (EDT)
From:   Pierre Abbat <phma@bezitopo.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Computer stalled, apparently from filesystem corruption
Date:   Sun, 03 Apr 2022 02:14:34 -0400
Message-ID: <3205109.rnzMqkiUVr@puma>
In-Reply-To: <YiwKA1LTrX56dd9T@hungrycats.org>
References: <12976593.dW097sEU6C@puma> <YiwKA1LTrX56dd9T@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1862209.gKo4GoxMFQ"
Content-Transfer-Encoding: 7Bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart1862209.gKo4GoxMFQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, March 11, 2022 9:48:35 PM EDT Zygo Blaxell wrote:
> There's no indication of corruption in those logs.  Above the kernel
> is complaining that it's taking too long to finish transactions, which
> could be a btrfs problem, or a hardware problem, or even simply a large
> filesystem running normally on very slow disks.  Not enough information
> to tell.

It couldn't be a very slow disk, because all the drives are NVM or SSD.

> When posting logs, extract all lines with 'btrfs' on them, plus context
> lines, e.g.
> 
> 	grep -B9 -i btrfs /var/log/kern.log
> 
> or
> 
> 	dmesg | grep -B9 -i btrfs
> 
> If you can reproduce the hang, enable sysrq and do Alt-SysRq-W when it
> hangs (or run
> 
> 	echo w > /proc/sysrq-trigger
> 
> from a command line).  This will provide stack traces of all blocked
> processes so we can see what the transaction is waiting for.

Here are the whole sections of the logfiles from the first error until the 
computer hung, compressed. I'm afraid to run the rsync script again because it 
might hang the computer. Is there a way to find out if the filesystem access 
hung on a bad sector or something?

Pierre

-- 
Lanthanidia deliciosa: What the kiwifruit would be
if it weren't so radioactive.

--nextPart1862209.gKo4GoxMFQ
Content-Disposition: attachment; filename="syslog-excerpts.bz2"
Content-Transfer-Encoding: base64
Content-Type: application/x-bzip; name="syslog-excerpts.bz2"

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


--nextPart1862209.gKo4GoxMFQ--



