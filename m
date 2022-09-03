Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A7B5AC1A9
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Sep 2022 01:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiICXBk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 19:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiICXBi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 19:01:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BBC3F331
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 16:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662246095;
        bh=2P8p+WG5fyKkSSF0KDN3YvPiohrhSkkDQUJbGu/KsV8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=aa7tSm1yMfIyeeHH7OQMO98RQ6aXEIrBqYJA96otJsHnAmqe6MebKwSf03KNykel5
         tEa9DfsKj6TdziUWZCIcujuSljghMZj3NwWWJ8bHWbjqtF9+ox+dMxVaMavO+lYf9L
         aCLABJGGL70lP5Udp0Q5nXZjedrbCvgqxv9czn1Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVvPJ-1ovndz1CkP-00RpsX; Sun, 04
 Sep 2022 01:01:35 +0200
Message-ID: <5d2ffc82-8b25-fb3b-4074-bb209747edf2@gmx.com>
Date:   Sun, 4 Sep 2022 07:01:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: btrfs check: extent buffer leak: start 30572544 len 16384
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
References: <d8b54f683ae5e711c4730971f717666cfc58f851.camel@scientia.org>
 <aece9d0d0f51f70b1e77bda701a6d4c4f860f518.camel@scientia.org>
 <31ed8b19-ce24-67f8-8567-506d84cd5f4a@gmx.com>
 <5052c751772dd32713db530191a4fb8a4ad724df.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <5052c751772dd32713db530191a4fb8a4ad724df.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S8J7tkAsmXnq1oA3yIhWmQt/v1wsAUz/MQOE6cC5iYS/U889WKg
 qf81pkGfQa8mcOPlRYVwxXj82OabE/XEzXIdRYaX5W2TOUD4tRN/GHUStHk28x8sfUP7lCS
 hX6b3qnbNjvzGbYso8fnnGqk5RCLShybbUc1SqiryZXbVucNQoMJ39AtPO+wm2E1f5sHNU0
 WZ2LkQdIGa/SpR2IlgTEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F+dU4Zv65So=:9OgNwrOoE9FvsVcKls01fX
 TkUiW1sg2MWElzb4Ubd22onG8SzIY1CiuzrBAmqhTo3fOZef1fU8Gu4l43h3shJ78dp/7PcDm
 DeTYz6FCp5joSU9nsvvrZqePuMEHPUu64ECRiiM4TJgkwlrRRp/g1FcKQTTbLuyKVxJP2TDFM
 pq+S0HxHymquUanJ6o9ig0kAMCtyMPT20oVCKNTAkEMisQIXHV5P5QJvN3csiPcqqjykrX7bS
 Ndph+FfZn/9lQHXBuT7oE/0Mm4DGXDrdfkEa6NsdUrECdXw1/TEuSu+F1SgAa6MwsopXp0oPq
 qanXiYSrD/rwQKO5pTEr3/IWb4cdWzxpRaOk3vSTB1ZKsn5v5q26c4hVGvWgXs5EiuiDXu4Vk
 pj66jkWsu1P7OSaH7mRZysmfXhvi9wr+aauARD1Lr5lzA9QGwa6E52Ltgyy69qVcqQZaaKR8F
 33CG7MHsc/kbInepwqXDOja9GW3ZxkK5ugMpFpK0nvAkmIXf4UyDK//l7bRBbhGhzQoV3Km5e
 Tz9tDYiSzwbXgnPije9KwvcsZMryc7A4Hj2f4okbHojtzNXtgHFkrEqZqyZyi3jfz9uMP/Vp6
 7GAP7r5dGOKsUGK9wQMDZ/pBuzFS4rxixdAhnQzZe0BYNz1xHoLVz416V9TmEpeSlJR08hdyi
 6zrEEgBi3McwO+XLsIQT+a+jiyPxj0TjTvQTaMBA3R1wiEEJUO0pABA0t4rkg1rl3LErePnY7
 7DL8oGOB9umtpubc2O3vbX7AFH+AgtI//ZXBbwyrusaruJlrN/4y2pqkmf9j/2CTL1JjP/bYh
 jpWov25DNRaFjxgchV1q/zcbu1+Kd0H5mg1meGnajNFhD/H49T7HbqxKmsPhMtwdn1KK20e/p
 eKHSWDIv/U1Y6EwlivVDyGluelEjd/3rX1L0xBPoHhGRqNQl6l5v12XZGxw1YZ3y+Zfs2CQ5Z
 QwFY+1+HxF+8XjPpMYW7J5lvzCwuGMQBbsVyPaDOv6SxOeYeEl/NbplMnvBtD3FoOi0mJKa9B
 6iM5pnjrX9656cAy4y/Lbygp1bGK4g71KrLeA7t48P6tzNpeaDSKv5/xLSaCDQo39sTvi0PtE
 WRzhvOz+rHAxdz7V7USd7u7u9cOX3z9Ndr/R6w8jaTHQEtm6xYngkH0SBBx8lZ2vcE8dY3/yc
 b9H3d09wZ+4G1c2oJUeIG+J78S
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/4 07:00, Christoph Anton Mitterer wrote:
> Hey Qu.
>
> On Sun, 2022-09-04 at 06:58 +0800, Qu Wenruo wrote:
>> Already known and fixed:
>> https://patchwork.kernel.org/project/linux-btrfs/patch/043f1db2c7548723=
eaff302ebba4183afb910830.1661835430.git.wqu@suse.com/
>
> As far as I understand this means that there's only an error in the
> check,... but the filesystem itself is perfectly fine?

Yep.

All eb leakage is only a bug of progs, nothing to worry about with the
filesystem.

Thanks,
Qu

>
>
> Thanks,
> Chris.
