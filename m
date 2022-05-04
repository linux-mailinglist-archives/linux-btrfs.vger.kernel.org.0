Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932F251933D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 03:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240596AbiEDBR2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 21:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiEDBR1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 21:17:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D55B75
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 18:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651626827;
        bh=G/3sglbSLsitD5iFCPWdBNpdueiTKF5jh9563As2THM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VVIuZek9cqbbWyoBlfHu2RqHG6Il3iq5HPYKUnyJNw6eF+fFITKRYWZ3Mjx4EvycF
         oAfZbKR91gdbD7rMubV+aBwxFPNkDoQ63yIdmpTOpUH+XtSA7KViF66P76iRWdkzlQ
         IaGrr1jtRO03Sqp/vFy6FkE39hAOhCrxoTsVOlkc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpUUw-1oBFTC3Hlk-00pvSE; Wed, 04
 May 2022 03:13:47 +0200
Message-ID: <22700bdb-7606-a00a-5075-574966737793@gmx.com>
Date:   Wed, 4 May 2022 09:13:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 06/13] btrfs: add a helper to queue a corrupted sector for
 read repair
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1651559986.git.wqu@suse.com>
 <2cfd9d2766824ddce727b06068de24d7a4be9637.1651559986.git.wqu@suse.com>
 <YnFFJGbbs4+MgKY1@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YnFFJGbbs4+MgKY1@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jx06B1TZI6MdxYDMW1qG/MrD2tZ+LNrvHsh3MXzmVfhdORiRlCq
 HdOjpNH+h7Ugac8N9j6BHvaDV8cja7L9OonMIvzyh7TcsvralyLd9WqMBvIONMbbTHkBrAl
 rLhcwzYZRQf7FQAiSdIFZlim7jLjscBTmRzJoBK3rAElf1iYYG3A3qSHB7Az5RdmqhVyjOQ
 fCL7AG6f08+2v5AO8xOtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:63qbIq+zLmM=:3AgkU9egf+YqpIHHu+3Sv0
 09HTdec5X3JWikfM2J2pI1q+sRhm0RRmGzJDB2alUQ3VNkjKTFYg3ztaf8puh3ITzSeoRIisJ
 7KmlsCcPNrCiT5/DLToV47RLS60BmV/Ce/a6cOmfgkHEn6fcc2wC/hPa5tX83OvSvAbge8i3m
 Xv/Il6gkUS0stfYAvAV0fpkXF9VKId2QuAeyCKuq0HZO/Wkh402ja22+XeBdr6VvRiKBDe7Kg
 SxrFl5cQd/X0N9YchKZn44opKYiezgPccYxrerhKoLPtgqACpXxbXI0S3XukCtmeoMtOV61uH
 GYnUAA0KIWbbwAyxzDQeP73zw6+dAiGtG2PrOasM4+SUg5Vp5+zbknoeZWVqEeyCsV1TdlFu8
 Jr0kIudkpRyiWXGwy/+TKicjNzqQgiADMqx/uAV7039/KZjnLjLp71Vjs9+rJYClWqVGriIZ/
 ZX9zJ3df5Ew5wEye1u3P2LcXuwf5wlA+YwV+ij+F8L/45sPJuye3p5Mx/Yo/s/tWXts9A5PMR
 /B+CrwJAn4evwxPkR6nUhUinIXRa/G/OVTO1w5RjYqxXQ3sC8bsC8r3t1uQPJCyda3ZBh9b2x
 r81tkwPsmFkLvbXXZHgmVjLRUlbAgYLGMu1XygH3qkiMBm0/emJbVJ/k+nXtIvsbBiDvIf6hf
 WGvcxPBzRlptSJCU9dIIpMD8/wBGVOoWlJimpNsplkl/aISWBpO1nbOZ6MhcoDzgV3z0Z/SvE
 zyzTAnC0DRaH8db3rolyRkGxN4tGlCpAczp1Cf+Nc17d6Hkl+dVgVFEVlkkTw9e7KtHRGKV6n
 fH1ZY9ncxkof02M115FUrNfkDYtsanfOU2vMfsXM9KBc8QJYBtsIEW5IpKMm5DXLaoHDm3KqQ
 IGfiYJI7p4GjA3RftDMhyFZk9TlWY0tjGn2xWTHn8zN8oM+vIkrXVVwmW2SnZ6QNAq56Cafxv
 h600XJp8mcXv+d2DMFaZuVjL29RkmBJFUmOarbnO9gFW3Oq8acZlVuKrkmCevzS5PpA7WyHVP
 4h+T04vy8qlHTlegs5iJpLceTgM0ObCKYJbhLNo0JDqJHk32eG/10zK+IpzdT9xb09F1UISqW
 d48SmD1dZqksZE=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/3 23:07, Christoph Hellwig wrote:
> This adds an ununused static function and thus doesn't even compile.

It's just a warning and can pass the compile.

Or we have to have a patch with over 400 lines.

Thanks,
Qu
