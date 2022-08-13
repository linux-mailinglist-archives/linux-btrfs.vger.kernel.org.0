Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5064F59196D
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 10:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbiHMI2q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMI2q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 04:28:46 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F66559249
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 01:28:44 -0700 (PDT)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3FE6960005;
        Sat, 13 Aug 2022 08:28:40 +0000 (UTC)
Message-ID: <593e9196-7455-1874-750f-2f11443d7841@heyquark.com>
Date:   Sat, 13 Aug 2022 18:28:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Corrupt leaf, trying to recover
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <6270a749-5fb2-0b36-529b-07f0e2ce4639@heyquark.com>
 <0b4a3bca-cafd-b47d-d03c-a97922e49228@gmx.com>
 <c1b246ad-6665-1216-166c-a1ad32222b35@heyquark.com>
 <a9d3eb38-e939-4751-4dc8-896fa653be73@gmx.com>
From:   Ash Logan <ash@heyquark.com>
In-Reply-To: <a9d3eb38-e939-4751-4dc8-896fa653be73@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> It looks correct, all other ROOT_ITEMS has no extra flags, and only that
> offending root has the problem.
>
> Thus it looks more like a bitflip.

Cosmic rays got me, perhaps. Thank you for your help in diagnosis!

> Yes.
>
> As long as that's the only bitflip, everything else should be fine.
>
> If you want, you can remove subvolume 389 (and if that's the only
> bitflip) using the older kernel and then mount using much newer kernel.
Would I be safe to copy the files to another volume before doing that?
> Personally speaking, it's strongly recommended to use kernel newer than
> v5.11, even if a memtest is clean.
>
> That new sanity check introduced in v5.11 should save a lot of hassle
> like this.

Debian doesn't ship it, though.. Will have to see what my options are 
there. Maybe time to build my own.

Thanks,
Ash

>
> Thanks,
> Qu
>
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> Let me know if you have any advice.
>>>>
>>>> Thanks,
>>>> Ash
>>>>
