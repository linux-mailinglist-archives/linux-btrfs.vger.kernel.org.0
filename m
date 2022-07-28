Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20058583981
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jul 2022 09:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiG1H2T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 03:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiG1H2S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 03:28:18 -0400
X-Greylist: delayed 488 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Jul 2022 00:28:17 PDT
Received: from mail.render-wahnsinn.de (render-wahnsinn.de [138.201.18.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EAD5F9A1
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 00:28:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F9DD3F4D7D
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 09:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1658992806; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=ypPEMbWq5ND3z1egpqZWaDYzfuySUsH3Urn4GfAhblA=;
        b=PUjY5WClqEJxmy4v8OznrTf5X62iXNzpNVc/vzoGSvz7xXhOxpj2dxS3j6UY+uFzdldSAU
        91mqO+EqOa2xKa8aadP6ReAHRD0PVzmu822Ar4XMHFAm6MumTVtLWD+FxZ6PatDhSCaK7C
        DuR3DJweHfMD0DHeZGLWQq/tUu2IAytbI2BYJy7KVL0NDACPsewqd/O9bzggUMGjOgadYR
        P8CGq51iG1qrPZSzB1rj6K8DKswc9Z6Dli4vMdhGcrn1Qloy5s3qSWznNSjX6KM0KqKsT+
        EvP6LY6EGqq3wXY3cdE5k6vqu0LJj7aIvGCXNBW/wXbt6i4FN1yKze7plM0JPg==
Message-ID: <2f106f25-b03d-2864-c31c-0752f5b3aa49@render-wahnsinn.de>
Date:   Thu, 28 Jul 2022 09:19:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Combining two filesystems into single pool
Content-Language: en-US
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAG+QAKUu6TXJqoq=eQczE+CWJCL06bN8oymbSFQVCzXto+fzyQ@mail.gmail.com>
From:   Robert Krig <robert.krig@render-wahnsinn.de>
In-Reply-To: <CAG+QAKUu6TXJqoq=eQczE+CWJCL06bN8oymbSFQVCzXto+fzyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Am 26.07.22 um 22:32 schrieb Rich Rauenzahn:
> I've spent a little while trying to google for this and haven't seem
> to hit the right keywords yet or it just isn't possible.
>
> I have two btrfs filesystems.  These are independent filesystems with
> mutually exclusive sets of disks.  RAID1, if that matters.
>
> They are mounted on / -- let's say /A and /B.
>
> I'd like to combine the disks into a single filesystem.  These file
> systems are large, so creating a third filesystem and merging them is
> not practical, nor is copying /B onto /A.
>
> Could I, say, move /A to a subvolume A in itself and then permanently
> "connect" /B as a subvolume B, putting all the disks into a single
> pool?  And then mount the two subvolumes as /A and /B?
>
> I'd swear I'd seen instructions on how to combine filesystem pools
> before, but I can't find it again.
>
> Thoughts or other ideas?
>
> Rich


If both filesystems are independent Raid1, then you could theoretically 
remove one disk from Array B and add it to Array A. Perhaps temporarily 
rebalance A to be single so you maximize your space, then start copying 
stuff.

Depends on how big your disks are, how many you have in each array.


