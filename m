Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B137F4EE4D9
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 01:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbiCaXlx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 19:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243122AbiCaXlw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 19:41:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA12619E087
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 16:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648770000;
        bh=i/xkVZ9ibCS5SxNUJrGry8g4+ihQlE+D+dEhjw8wFEk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=RQBcDOzOCDrD0e34tJXZ3KoImuTnU+My4SaMBVIIn45+n0o2ex9V+J19WbgR8gQdV
         k0duE2/S0Ggn6b0Eiir84NiW79lZjFtTxnShJFWSsyk5kF8+IA/56RdzGDOvSuE7Bq
         p0mZWZn2S2qpApKBuSstSZSdsWUN4r9RrskYA9Oo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0oBr-1nvR2A3iY1-00woJa; Fri, 01
 Apr 2022 01:40:00 +0200
Message-ID: <562b797f-49b6-80a0-4a1e-7dafa1975e86@gmx.com>
Date:   Fri, 1 Apr 2022 07:39:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: btrfs volume can't see files in folder
Content-Language: en-US
To:     Rosen Penev <rosenp@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAKxU2N-FKf-RsbA4S7hrYJXHUe7wJUrRyHGKjzKGgBmNcE1sCA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAKxU2N-FKf-RsbA4S7hrYJXHUe7wJUrRyHGKjzKGgBmNcE1sCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p/8jB16CgWPvfNvd0pi0h6axURW6r912OLNLWzLYWHq+x/Pwze7
 COfR+B8qTA7u3FdKgR5H4l3nEIYPMwR3OU+4ksTrVq8kuVwabDUpvZjocnrqvD8QZc3OUda
 YLjE9HtvuwY1B1S1xGsgMx4DkqLIqvi965RzbyNiBBYFCG4d76/vOjUB04ggXzgVll/4dwa
 HmTteVyaNaGSAzBWCSjkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UVhQaoWkij4=:DwKsCpp6/WYUjbE65ey7ZL
 ux/HzEowTYCyNG1VAhAkPisecIAGulexNoBQNlB67ndGIf8HbwFu7IEPo10NLYC0vNkAGDmTr
 18TeVa2bkP3YJcnn+rphjafDGXDHpbHO0Xf/jOT4/Zx/sVX4IgiV9UVfW8hKB+SGgAIvU78YU
 a402BiIvw+/ap/TWjUbrTQXPRFoVshRmI6WTUYAKUZ/E0RHTQu016EwMS1BPOka/Pvy7wQoEC
 q5KH20iVEVVuc+99uw1WcPCf/0wP/VzqHuLGRBNEEk7m1aH750JljOi4Opw4xTQAGCa1M722Y
 aDy2rDATpHE0QQ85O+XN4jhcAnIltJXKkPRJxvkNbtlDntLLR0F6var7AU6BSQQlKW2XAruaE
 ZCzHD5tWJn/HgrIsDnrzDe1EAiauT1soNOWS/f8ue4JhvTOarz83EVbrQAsXPiXhFFDpyrn3l
 LBuGkff3lVWQSQkFwr+wjga+ze08L4PhmPG+f2TqDUcI7b6sWdsI9FylltZYtg6rgFcwTMuCH
 bki+rwL0LFwh3WJ/XDzmIgGGmFNc7G/klFoMBvcE0NyBq9gUj9iMQOUjQm0Yj62TGEVHcQ9MV
 xJeIvoiq/iRs803F2qaovgwmcTXVj3YYfk1/zw8W23759oeBi/60X1NWTu3mPnBE09bukdOmo
 hSm3zFgHpbm46HrGYy73jeSj1PtfodgCtaHgxtP3MGhkWn9Rci8Iv1thPTYYV/sK8M0i0Cs9x
 p4pKVWbobwBa/Jt+N3FuQHmvpTs2eDOJsU7rMK71OHcmzQqkWS14iS9FV/U/pGN116yzv/wev
 v1gJDzQTRXfMv7zPVq5MoOFXXARBjCTwLNoPm1zt8JBWHR2MTSgTClhFG2jswddKMjSbAbrs0
 k4Vg3U+nkXZ6/jDdyNJlrJQeL8X5Sq6LpbQh9RDtYa3tkqsvlE8T6jAblKSfIGgTNwK8N4lsC
 fznSRP1DPrkXEn6Yohk/Tell4p4qm4bJ3Jq9cR5++p+q7kmW8aH30D2DNAv9PnYxg+vhckZ7G
 Mu/0Mvhr9Z2R/YtgW2YJfJgnrH8hXm9z/Z76dgMTBCFhxL4KKi+H3W9w72e4Fc7gKMsoLhOp7
 SXZjibiY1z1dqg=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/1 03:29, Rosen Penev wrote:
> A specific folder has files in it. Directly accessing the path works
> but ls in the directory returns empty.
>
> Any way to fix this issue? I believe it happened after a btrfs
> replace(failed drive in RAID5) + btrfs balance.

Btrfs check please.

It looks like an DIR_ITEM/DIR_INDEX corruption.

Thanks,
Qu
