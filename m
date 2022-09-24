Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B795E8F94
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Sep 2022 22:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiIXUIl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Sep 2022 16:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIXUIk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Sep 2022 16:08:40 -0400
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Sep 2022 13:08:39 PDT
Received: from lazarescu.org (lazarescu.org [66.23.245.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4321E3ED5F
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Sep 2022 13:08:39 -0700 (PDT)
Received: from lazarescu.org (93-51-19-110.ip299.fastwebnet.it [93.51.19.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by lazarescu.org (Postfix) with ESMTPSA id 8E402622B7
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Sep 2022 21:58:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 lazarescu.org 8E402622B7
Date:   Sat, 24 Sep 2022 21:58:53 +0200
From:   Mihai Lazarescu <mtlagm@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Recovering suddenly corrupt Btrfs partition?
Message-ID: <Yy9hfbPwK0yFlNA/@lazarescu.org>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <CAPXZLEraHWJRj+QQ+RRGhEB4K4+_4tuUo+r80mzbfYRkpnhaPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPXZLEraHWJRj+QQ+RRGhEB4K4+_4tuUo+r80mzbfYRkpnhaPA@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_40,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_PASS,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thursday, September 22, 2022 at 22:16:33 -0700, Daniel Trescott wrote:

> If anyone could please advise me on how to get the partition into a
> usable read-only state, I'd be extremely grateful. Thank you!

> [ 8613.636194] BTRFS error (device sda3): parent transid verify failed
> on 66931867648 wanted 541837 found 541832

Important disclaimer: I'm only a user, not developer. I just 
share my own experience, without any deeper knowledge of BTRFS.

"parent transid verify failed" is what I got (then I discovered 
that the disk also had bad sectors).

First think first, I strongly recommend you to do a byte-by-byte 
copy (image) of the full faulty disk. You can use dd or, if you 
have bad or unreliable sectors, ddrescue is doing a much better 
job (can install it with dnf).

In my case I could not mount the disk, not even with the second 
or third superblock copy.

So I used

btrfs-find-root /dev/...

to discover potential root candidates, then I used

btrfs restore -m -S -i -t <id> /dev/... <some_dir_with_enough_free_space> 2>&1 | grep -v '^trying another mirror$' | tee btrfs-restore.log

with <id> the highest that works.

My BTRFS FS was plain (no snapshots, etc.). Here are some 
additional details: https://btrfs.wiki.kernel.org/index.php/Restore

Hope this helps.

Mihai
