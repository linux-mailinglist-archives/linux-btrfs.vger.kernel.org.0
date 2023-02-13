Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61263693B50
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 01:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBMAUM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Feb 2023 19:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMAUL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Feb 2023 19:20:11 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5C3EC72
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 16:20:08 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO6C-1olUN20Dpg-00ollt; Mon, 13
 Feb 2023 01:19:56 +0100
Message-ID: <8a85a4bc-3791-72ed-fe9b-b08a36b2ee21@gmx.com>
Date:   Mon, 13 Feb 2023 08:19:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] fs/btrfs: handle data extents, which crosss stripe
 boundaries, correctly
To:     Andreas Schwab <schwab@linux-m68k.org>, Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Sam Winchenbach <swichenbach@tethers.com>
References: <57ad584676de5b72ae422a22dc36922285405291.1672362424.git.wqu@suse.com>
 <87ttzqsxmr.fsf@igel.home> <87pmaeswjb.fsf@igel.home>
 <87lel2svnt.fsf@igel.home>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <87lel2svnt.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zn9BGcjrMxz7SJcEnP5i7IF+DtstRIzMQk5iauGIsqahaPIJjoi
 Pzs06ySaODp3BzdWhlFSOoedlt7QmewlyozM9Y6YpnewZqm9ASlsBNgeDRCH48d5PZ9cZwX
 165ISZS8vXtpuUiO9UyOHIYXnY48Up5CyDo+cCU4H57jT/FsGlMZfuyNdp2d9fpRRosZyF9
 6dkADYcstyQNEqiiImAHQ==
UI-OutboundReport: notjunk:1;M01:P0:Df4LKFoxEnM=;eTazC0D+XkMLJb9p4JIE9xWpquJ
 LxgufAPlwZETdfmk5iHb+xHJr1H1jJ30Q/+veNCOjJH1BuupRSwjEE8dIIK+nYsYBo4MxRKg4
 wQNOZMNFFOi4wfYT0I0DyVQpcnXQlZT9MqNFuqHVO80upNQRh1z2o5Q+mDtK2XFgSt8XOwInk
 xgvZTFINpmOi+/VwB6ySjCe2r/KUaEY1A4Oa1tBeAhvQN8EmsG7DDVxFZsA+kZhvJj0PEmGK2
 NXRSxLy69S5gykqMSpDb+drrT2XKYzXdp6c6BPRoRJMpJsDazoSQ8TNfT7WS1/dByjtz4H4ct
 gbgkM5hgT1VayRtRQyPV8bnyhx6NWiPVGFTE1q+idpnMMwovv8cshTM/hEHl3WQ0QMn7Cbcf3
 1B0wJRgMdFEq9m5Vnr/YqSkkV4sgLsauNEdEXJAwrII6VxtIYYYLH0zGgqmKlcTS4ycOCSIV3
 xk1FwI/EbuXmtw0pizIpF2iwif0FUVFO9hjTP53e73qgZhfWLAFh5wYoAhUgcjSJtc5kYQxTI
 /5haBliYDWZNvzFW2xbNTce6a1qlJg4sL5AKOUsTjsOGMaYlzGX4RIA+i38TtBG3q3QuoxAlY
 0uVtVnO4GXmI0UhxVxjtlnxqoA4WeSTqiSYViWhRyd07ATITgmKmveJl3YmF2xm2qmVzEe1iI
 qMJqBm6voWvKALCih27pu8cA+Z1GrVQqnDke8G5gf/0CVqRbZnQea2OT5+Q1XXA1bYPP/KBU6
 xBlZfb9Ne+HlIE5BvAWFzVUOAUrCgZHMm67f9wySJicCNt+9mZhoDgv43ld4XW9GUy9gEtVy9
 DQhJazEf10qLxwM0G2f404JZ/Cc+nwJogWRmab7j9CXeDPMWgMEd7uCoZASssYlcLv5grqslR
 rwfYOsWz6d73nEp3PKQ7Rc3N3pBjnPj3izjyH0Yr5nKCqiMa5sZ4AFirdJhVzOwKfPGaKm0Na
 PHLR1Uu+dmIDbdUytk67B0S/SCw=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/13 00:20, Andreas Schwab wrote:
> When I print ce->size in __btrfs_map_block, it is almost always
> 1073741824, which looks bogus.
> 
Can you provide the image of that filesystem?

Thanks,
Qu
