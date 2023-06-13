Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0796C72E3F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 15:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbjFMNVX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 09:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbjFMNVV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 09:21:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BBCE6
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 06:21:20 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q93xW-0002Up-OL; Tue, 13 Jun 2023 15:21:18 +0200
Message-ID: <b3f6be3d-d540-53e4-d1d5-7994d8ec5c29@leemhuis.info>
Date:   Tue, 13 Jun 2023 15:21:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Regression that causes data csum mismatch
Content-Language: en-US, de-DE
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <da414ecc-f329-48ec-94d2-67c94755effb@gmx.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <da414ecc-f329-48ec-94d2-67c94755effb@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686662480;f294aee3;
X-HE-SMSGID: 1q93xW-0002Up-OL
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 13.06.23 08:26, Qu Wenruo wrote:
> 
> Recently I am testing scrub preparing for the incoming logical scrub.
> 
> But I noticed some rare and random test cases failure from scrub and
> replace groups.
> 
> E.g. btrfs/072 has a chance of failure around 1/30.
> 
> Initially I thought it's my scrub patches screwing things up, but with
> more digging, it turns out that it's real data corruption.
> 
> 
> After scrubbing found errors, btrfs check --check-data-csum also reports
> csum mismatch.
> 
> Furthermore this is profile independent, I have see all profiles hitting
> such data corruption.
> 
> Currently trying to bisect, but 6.4-rc4 already shows the bug.
> 
> And I can reproduce the problem on both x86_64 and aarch64 (both 4K page
> size)

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced v6.3..v6.4-rc6
#regzbot title btrfs: occasional data csum mismatch
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
