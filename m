Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3226BCA3E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 10:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCPJCL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 05:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCPJCK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 05:02:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6E6A76AE
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 02:02:08 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McYCl-1qFMZD1nFl-00cxCz; Thu, 16
 Mar 2023 10:02:03 +0100
Message-ID: <3f7d8ddc-fab9-f0e7-010f-8ea29f2222d9@gmx.com>
Date:   Thu, 16 Mar 2023 17:01:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Btrfs Raid10 eating all Ram on Mount
To:     Robert Krig <robert.krig@render-wahnsinn.de>,
        linux-btrfs@vger.kernel.org
References: <dd155011-37a5-b597-a3ff-db63176d8fa1@render-wahnsinn.de>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <dd155011-37a5-b597-a3ff-db63176d8fa1@render-wahnsinn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v0gQSGh3innuBOlAQH2kDmQ3emASXNGK+gj4MzG22R/A0paMIrU
 ZMdANWFAchJvqTKaYvdxZM8C8q/2Lr2elzSgrPXMAqDGGtVT/6u6qLm8GwaRm9cHD6I7MyB
 4lR0yBQF20WBBUYihLeba/XhAI7NsX8nDL1yakUjWEVw0DPMFCGyU1dvjEt4rMGPZzOxFAo
 gxZBofXCtxQPCT0vuu0wQ==
UI-OutboundReport: notjunk:1;M01:P0:geDbh8pq6M8=;XMxLmXYxx5QXo1tVE/9Jq0gCzpT
 IjftWmtVyBGrBYW/+b+tpYWzzqtHnbE+7OfRR/aVp25NmeyJQHB3gp76hwfQ2CbV3yN4isokA
 dJ4b+HgGbu48UBBVzl2bhfxs93qMu9SXVtASmXtKQWnjLhhdXK+FlXCGYHRK6+P0LXw9CYWiO
 hsS/1v38LsUOIUH9/ziFOXx4xdzcTQeU31wSYSth+HmQZ0XHgpEolgPtAbZGmLxC7/bkXvqFA
 Cgx6mI3KsmCQFkbZ1PfDz5CQHX9op+m/Oa+jJl1kOteLUP1Q+48bX1pbuqRjsI/bCqEYrLhZ+
 bLuPWgKgL0Va3S/GLHyRJycRO57YIsprChqhiE9IiWbf0LUJqGGah3zXcZe+sYnG2WxhCzbjl
 3gSpzF03ZFo9rjn8qvU/z5bgYe9OUvwXiGcHHab5sFRHEBBwXbWTOWeRZB6ZHZ0ldw4xMknwR
 buFc7OasDXHlHLWp9GrTMqbixebSjDYLLepPok2JMPW9h/U7b8i4BUILwbQBhgAKXc3RO3A8f
 Wpe5bvw8fyKiGB/p6/JMO1OJhBx65Mpz/8uwWW8dZnXgTootsWyLn1wgyDfbcQT8Emg6PXn5R
 Xdwssxx/OitEzmPsg/0VcA0hcTJt7Owjpo3mNEInKgBxyMTSXBoikhDi7zsSfSV2LhCzMbIXJ
 /Zim2tfjQ4VRp6QJ/G+91hilSSkVOe/XjfYSjDaKX5lXyq6SI/ZwulzSEJe441z67WVoqNMOY
 sLJdZcozazEoldh5L4r6vBR2urggPpWTa6B+pcm1ml0uoN9D9ea/jA2jmLfjf6F/qxJTosttD
 8tN3T5DY+K8HCG16EUv0J91l10Yo7QUHn3zXRvYKGuoV5RLOjfDMC3KEIkr3N2T1X0Hco2FTT
 2dF8qPJP2ux/pS/BovV2DrEwvsZSBgU7EidknbR9uE/gwzEpaTCQ535Osn1bvuFyZ35hwd3Lm
 pOmySuMHx305cMXZuVn9RAt+86M=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/15 15:26, Robert Krig wrote:
> Hi,
> 
> 
> I've got a bit of a strange situation here.  I've got a server with 
> 4x16TB Drives in a RAID10 for data and a Raid1C4 for metadata 
> configuration.
> I'm currently retiring that server so I've been transferring and 
> deleting snapshots from it.
> 
> For some reason, this server (Debian with kernel 6.2.1) suddenly starts 
> eating all of my ram (64GB). Even if completely idle. I see that there 
> is a btrfs-transaction process and a btrfs-cleaner process that are 
> running and using quite a bit of cpu.
> 
> Basically, even after a fresh reboot. Once I mount the array, the memory 
> usage will slowly start to creep up, until it reaches OOM and the system 
> freezes.
> 
> I'm currently running a read-only check on the system and as far as I 
> recall, I've never enabled Quotas on that system.

Just in case, since you can already RO mount the fs, did "btrfs qgroup 
show -prce <mnt>" shows anything?

The quota can be enabled by tools like snapper, to get an accurate 
number of exclusively owned bytes.

As the symptom itself looks like quota exactly.

Thanks,
Qu
> 
> Does anyone have any idea what's causing this, or how I can fix it?
> 
