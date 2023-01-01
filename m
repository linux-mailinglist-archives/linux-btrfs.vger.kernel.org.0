Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45A465A876
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Jan 2023 01:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjAAARW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Dec 2022 19:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjAAARV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Dec 2022 19:17:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F18389B
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Dec 2022 16:17:19 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MlNtF-1oXGE41wib-00loDG; Sun, 01
 Jan 2023 01:17:18 +0100
Message-ID: <3d13bfc7-294a-9385-2a52-735c1a738a50@gmx.com>
Date:   Sun, 1 Jan 2023 08:17:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: btrfs qgroup warning
Content-Language: en-US
To:     Lukas Straub <lukasstraub2@web.de>,
        Btrfs <linux-btrfs@vger.kernel.org>
References: <20221231235845.21877393@gecko.fritz.box>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221231235845.21877393@gecko.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gDZMcmOH1H9JGnJ5m3Dte87DD5zuAgtqguMR/xz7zFZ27ViAYkV
 AKJon51DqqmqWeHg4lHYZhH5Z80LLVIh4dYYFoqpBpmYR7KO1suc4RBmCsymJ18E8ifSVH9
 OIT4W/E+6c6ohAb27wUEb5587n+lQzYc5w6tQQR7C1oYltPyn18VfOh/CIuQBfcV3zLWoNB
 c+3e2c8w1JE3TvpxgL0Lg==
UI-OutboundReport: notjunk:1;M01:P0:VjsgMJvCl8k=;B4SNNQeBIKkipvFiZcBz+jw7zi8
 2UhX/xpUW8boKAkV65D8ibgfjZsLoHnl/RWRD8NRI/v5YBShd6UszPaBg+xiZ98a7FU/RS2ZG
 F0eVIcI9z+LyLYnXMrRS+KpBhkLIjOwSxmuIHlVBbvfC7yR35004lcIwbPby239l2VKeQwgKU
 StgiEvDOoZtEHKhxTEfWnwXhcpCfBo14C+0LFfOTkc3zX5bRxiXiuj9vtWhlzK5oMGc2hkkTL
 tCF2Vy6+zit1WXLDczUsYoT/qR7IvrvWD6mzw6oFhZ6aX6+RzFB85kiqKJS87NtP6JWhnUiku
 xexOgbt0DY49i0KncWGwQ0Q8/gfwd8Gw7OXWwR56dfElXs/GAETFmsoLzhN9K79kIor5v5swc
 JFByj9z9kyZJ/HvHdnPLtQNK71yKCmpBrX/m6Lh/5FvZqDXR6LYTYNOLTupUOzEsXl7s2Oadf
 t9uMMJd1XMqIMaSa/HXlwq+WxV7a5Pi2dDYAurkCcjfq1MF8qAmw348aT/Tbhp/8pLZxuX1LI
 kH1E7J5wK2CS8Ej9/CnW/fcW0EBWrGqPmW7UnpGQzYcaGZBn2mX7KdZJImT/asGTVSDRc3zTz
 D3ZJ8B6nqWZYHDV6uFKKYmUP42Jn1D2l3i2pWRYcB0/lxzBAq+Q2q2YZuPpp4eRBrmnCjuBxb
 2tmbcJ6zeUZeHwvv4JsLARgxb/UnUfIQUZ8Uy3sHLuRxaWowtBx2a0jPyUIZACQcf0ZXkmg7k
 6VDGsXA0lK73hywyNLcXT+sk0CSO8vHAr9OUWY7yqOl/9TUutUIWKzTphsAxPe3ukVXOFoq81
 xuEsRyJmz3cYQxOVc3fZ2CVClW+tYh68jzMD+QUvkG3DF9pBYwRhVITfi1jDuipkwHdAD8bsP
 /WwG1wb+Ll2wg14kLTKGoULeY+jotCj88O4WfH2kjoE88RaHhp6B6CLLvgtwM7a6h/JlGJOCa
 jUvu7cGrd3ZH0/GntDW68J+oNhM=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/1 07:58, Lukas Straub wrote:
> Hello Everyone,
> I found a couple of weird warnings in dmesg.
> 
> This is opensuse thumbleweed, looks like snapper already makes use of
> the delayed qgroup scanning?

Snapper is always using qgroup for the accounting of subvolumes (mostly 
to get the exclusive size).

So it's not the cause.

The warning get triggered because qgroup accounting code didn't the its 
old_root ulist populated.

Qgroup accounting for each extent happens in two stage.

- First stage (at the timing when the owner ship changed)
   Populate record->old_roots.

- Second stage (at commit transaction time)
   Populate record->new_roots.

And accounting can only be done with both old_roots and new_roots populated.

Unfortunately your dmesg is not full, it lacks the initial 
errors/warnings at the first stage.

 From your dmesg, it looks like some disks are unreliable, I guess that 
caused the failure of the first stage, and triggered the warning at 
account time.

Thanks,
Qu

> 
> Linux gecko 6.1.1-1-default #1 SMP PREEMPT_DYNAMIC Thu Dec 22 15:37:40 UTC 2022 (e71748d) x86_64 x86_64 x86_64 GNU/Linux
> 
> dmesg attached.
> 
> ....
> 
> 
