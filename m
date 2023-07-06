Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D6C7499F6
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjGFKy6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 06:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjGFKye (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 06:54:34 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C49E1BDB;
        Thu,  6 Jul 2023 03:54:17 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qHMco-0005gy-HF; Thu, 06 Jul 2023 12:54:14 +0200
Message-ID: <7336b8ea-64bd-d08d-1d85-bf942d5660e2@leemhuis.info>
Date:   Thu, 6 Jul 2023 12:54:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: vmalloc error: btrfs-delalloc btrfs_work_helper [btrfs] in
 kernel 6.3.x
To:     Forza <forza@tnonline.net>, Uladzislau Rezki <urezki@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz
References: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com>
 <fcf1d04.faed4a1a.18844d8e78f@tnonline.net> <ZGwcVTpQNBoJHBB+@debian.me>
 <ZGyVVQxnw6Tn7Xb8@pc636> <c9db92d.faed4a1c.1884c5550fb@tnonline.net>
 <20230524091357.GH32559@suse.cz> <ZHClGA9szxSqzDf8@pc636>
 <cf07f03.70397026.18918ef7f95@tnonline.net>
 <2063d59.8f9f4a3a.1892a3ec50f@tnonline.net>
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2063d59.8f9f4a3a.1892a3ec50f@tnonline.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688640857;1fe2e194;
X-HE-SMSGID: 1qHMco-0005gy-HF
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06.07.23 10:08, Forza wrote:
>>> On Wed, May 24, 2023 at 11:13:57AM +0200, David Sterba wrote:
> [...]
> A small update.

Thx for this.

> I have been able test 6.2.16, all 6.3.x and 6.4.1 and they all show
> the same issue.
> 
> I am now trying 6.1.37 since two days and have not been able to
> reproduce this issue on any of my virtual qemu/kvm machines. Perhaps
> this information is helpful in finding the root cause?

That means it's most likely a regression between v6.1..v6.2 (or
v6.1..v6.2.16 if we are unlucky) somewhere (from earlier in the thread
it sounds like it might not be Btrfs).

Which makes we wonder: how long do you usually need to reproduce the
issue? If it's not too long it might mean that a bisection is the best
way forward, unless some developer sits down and looks closely at the
logs. With a bit of luck some dev will do that; but if we are unlucky we
likely will need a bisection.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

