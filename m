Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6697C753AE0
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 14:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbjGNM0T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 08:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjGNMZu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 08:25:50 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2072A3A87
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 05:25:25 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qKHqQ-0002o6-NR; Fri, 14 Jul 2023 14:24:22 +0200
Message-ID: <4f475d21-a6fa-06b4-2b80-89f6487042bc@leemhuis.info>
Date:   Fri, 14 Jul 2023 14:24:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] btrfs: scrub: speed up on NVME devices
Content-Language: en-US, de-DE
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689337525;ade67598;
X-HE-SMSGID: 1qKHqQ-0002o6-NR
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker.

On 14.07.23 12:26, Qu Wenruo wrote:
> [REGRESSION]
> There are several regression reports about the scrub performance with
> v6.4 kernel.

Many thx for taking care of this. Could you please consider adding Link:
or Closes: tags to the reports, as explained in
Documentation/process/submitting-patches.rst and
Documentation/process/5.Posting.rst?

For more details why I ask for this, see here:
https://linux-regtracking.leemhuis.info/about/#linktag

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

#regzbot ^backmonitor:
https://lore.kernel.org/linux-btrfs/CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com/
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

