Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3C14DEA1C
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Mar 2022 19:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbiCSSdO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Mar 2022 14:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiCSSdN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Mar 2022 14:33:13 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2162986DD
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Mar 2022 11:31:51 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id B21BC803CA;
        Sat, 19 Mar 2022 14:31:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1647714711; bh=EtOzveuYpbIzrvMLsvYzRia5wtbe+9LxI+L60WoPqeQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MpgnnCJIBbIsOLZHl5JP7ZKPVjFAtlwqSTXbNoLv3TobUPr+TotQ05dZXfK980fzE
         o8Cgs2jVrW40Bm9bg/gBuw8TtZ2CFMDOlx+XxwIMngv6XIFXzOgsHnsyPykKtQ0Gzd
         R3zfEf53DQUZLO3q/4hJ002jkweI6o1ON6/jq6pVoEAbTKWVEzKF+5YB7KMdXM6xSz
         7z0jgxnHMtI6YwH7hxLjFj60a0Hlb5hx/jp8lVqCPzaF+Hs6v/2ItY061+X3fAU17v
         nf4NhKOYGx1a9wtKwq73vphY2R1ce2m/5mGbFMseBKOsB6iYvft8kqeb5cHTHuSciI
         atVxLYMKa9+Ag==
Message-ID: <32eaf406-aca7-a17a-813a-631616480e42@dorminy.me>
Date:   Sat, 19 Mar 2022 14:31:49 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: raid56: do blk_check_plugged check twice while
 writing
Content-Language: en-US
To:     Yusuf Khan <yusisamerican@gmail.com>, linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, clm@fb.com
References: <20220319011840.16213-1-yusisamerican@gmail.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220319011840.16213-1-yusisamerican@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Yusuf:

On 3/18/22 21:18, Yusuf Khan wrote:
> Do the check to see if the drive was connected twice in case that
> the first was a fluke.

Block plugging is not actually about checking the connectivity of the 
drive; it's about batching IO submission. Specifically, when a client of 
the block layer (a filesystem or DM device, for instance) knows that it 
needs to send a whole batch of IO to disk from a thread, it can request 
the thread's be temporarily delayed, with blk_start_plug() 
(block/blk-core.c has a lengthy great comment about it). Then it submits 
its batch of requests. Finally, it requests the plug be released. This 
is useful because it can allow better IO by releasing a large, 
potentially better ordered batch at once.

In this particular case, to my understanding, blk_check_plug() checks 
whether the current thread is plugged, and, if it is, it adds the rbio 
to a list; when the plug expires, perhaps from the thread going to 
sleep, the plug callback gets called, specifically btrfs_raid_unplug(), 
which sorts the pending IOs.

As such, it shouldn't be necessary to check whether the thread is 
plugged twice. Your change description is a little light on *why* you'd 
like to check twice; maybe I'm missing something.

Hope this helps,

Sweet Tea

