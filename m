Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0270E5FB21E
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJKMKG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiJKMKB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:10:01 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E012C15810
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:09:59 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oiE50-0002YD-LE; Tue, 11 Oct 2022 14:09:50 +0200
Message-ID: <8be1e839-2eb8-43d0-9ecb-6ff8c3aa3f2d@leemhuis.info>
Date:   Tue, 11 Oct 2022 14:09:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Viktor Kuzmin <kvaster@gmail.com>
To:     David Sterba <dsterba@suse.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Bug 216559 - btrfs crash root mount RAID0 caused by ac0677348f3c2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1665490199;f369ea59;
X-HE-SMSGID: 1oiE50-0002YD-LE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

David, I noticed a regression report in bugzilla.kernel.org apparently
caused by a changed of yours. As many (most?) kernel developer don't
keep an eye on the bug-tracker, I decided to forward the report by mail.
Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216559 :

> [reply] [−] Description Viktor Kuzmin 2022-10-08 20:41:32 UTC
> 
> In linux 6.0.0 there was change in block-group.c file in function btrfs_rmap_block:
> [...]

FWIW, the reporter (CCed) here meant change ac0677348f3c2 ("btrfs: merge
calculations for simple striped profiles in btrfs_rmap_block").
Reverting it fixes the problem.

> After this change I have a crash with DIVIDE by ZERO error. It seems that map->sub_stripes can be zero.
> 
> My setup is 2x 1TB nvme with space_cache=v2 and discard=async btrfs raid0.

See the ticket for more details and screenshots from the crash.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: ac0677348f3c2
https://bugzilla.kernel.org/show_bug.cgi?id=216559
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
