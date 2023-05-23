Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0C170DAD3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbjEWKsH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjEWKsG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:48:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289E112B;
        Tue, 23 May 2023 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684838868; i=quwenruo.btrfs@gmx.com;
        bh=JIgR5r0+mnwhRkW2tx0EMf3IMNV/daw/lmHQqh0Zo6k=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=k+OFC1XG7wPR7YCYDI/GM6Leg6pDDnD0G3HxU87dYG3wR1up22wN7IliNcjfZuYXr
         tL76dRtm8CJ4wViNQ1/UvF8/to+Ii56HcwsYPY66P9qjDRmPFBc27IYd0UgzF/k84G
         vvHfr8YRDk7OvcV3Vb6BhffHDOJfbGc2RzNp+kLZrxujMllfYODbTiAQDKJ+EuXxTF
         L1sQkg/fVGDbPfsmYT1Nlnw1OuuN+6xqNMVvbutPxOza/aEPiWKsprBpkiwJ3jQYYF
         r7o1LR0P1XaO4Q8FhHxKua0kxWpxNM4rl6oj2wG05yR7EX4dQg0kcM00B7BZcR1AI5
         6b17Zkeucaksg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mz9Z5-1qO9IW2QQl-00wG7w; Tue, 23
 May 2023 12:47:48 +0200
Message-ID: <409455a1-560f-24d0-e28f-74c665668050@gmx.com>
Date:   Tue, 23 May 2023 18:47:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] btrfs: fix uninitialized warning in btrfs_log_inode
Content-Language: en-US
To:     dsterba@suse.cz, Stephen Zhang <starzhangzsd@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
References: <20230516013430.2712449-1-zhangshida@kylinos.cn>
 <f90eb6c1-4491-ecd2-1fdd-56580088c993@gmx.com>
 <CANubcdVZ4tUZo=HDytwYFTZiQwo8QSABskBfZXL+y_swXvb_DA@mail.gmail.com>
 <20230522215144.GS32559@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230522215144.GS32559@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DWq8wCg7gTpFXbj6kdsqkgNR5QQ0zgjYkO7me1Wc3Q8giCTysp8
 6BITvhk8SnjgHDPE/ou/Bnfl0FIW1TXcIqT4IdNkTGhWO0dbNXLwoRF6ySfS5rE9UcwLuuj
 pdUfTNIJ/IX3Q0h/Jx1aRlkQ9QQD5SyPNbNQak6DTiWquSmLl+jzNgMrHzRs7w/gWj67k0E
 6Bv6RFf3E3pnyH9Mw3yRw==
UI-OutboundReport: notjunk:1;M01:P0:tAS0LJ4TgLs=;WZTPaAH6h1L42z8J4jv1mQY2qAv
 lCX5vgfu+viiA+cIsLm0qbOPJVCfnRINDe+MbApOo2gl9ITRXzhiIxPo3uRfs0oKHQdq8IQsk
 qg/Q8DHJkYdfg1qd/lOqONZGL2KeZ/3ze050rmqmpsoJHdZEtY/LtFtGvSOVJVlM3/g2i9x3T
 fCZ2iMpU2tW9GuqlfACvytRRzB043s6GjJRZHNp6tiZFK7I/okDuzKGzA+70vTvtYdMcjqK/l
 L2mIpinV0auVwI7uVHNGoDtsvPZxJ/DIEw4OBmpfx+ynLBvRLtt9M8zEn4BdZc+A9hbLiXeV5
 Nv0F/wdwXz28OIJ4WEei3z2bSnP26LlLSDpB8zjs8R9+t3tKrE4p5n4BT3rR3Jh5jgJ/BHrfS
 nD5cBz4uec249bKnN6bJ7tw5ETlhGe4nqxoqSs/nwTdoZa0AiEfkFciPQ5RryrrahZfSeixOo
 Fqj8GiNU28T12k53OlUxQZGIeFir/Ds+T3LtwZTkxDNoLUFYtpWjtZ+6inj94C+Z+WsTh8icI
 6o4KzQRTT12cYKl7KGKlLYpGpg0v0ETuStdkwr5oicm+2Vd4F7MtqQxDtHSb0zSyWPmjRj6bc
 WiPEslGgf3DW6Qa8lPDMeRcSqpGfU1PvHOBFc2DA0fBjOxdvG8u+/7b1qLMZ//gNtWlMBXxnW
 Vk4rry8jU1qGsOj64x0ltPmO/0QTushqWv0WnpVMApHBi1QgTXi0W+t/QjwZd2/h/OcQoT004
 oFJbEd6kr2W32LyD3NuuKt4jWtvR7nB48Gm8/sk5AVmUjpDfMOCQXdCgyr6pbCR4d5tLoiSum
 IhkBnT4LGoT0gZYPMBW5hWAQURfGIV19D6cCYdR6qE31qSVArJIeaZsM/G/zHluu2pSHOjuGB
 tAGb/zD1yGcZbaxSRckUaorPr4fOd9H0R/MLZdLU0wp5g2f+iHnu7om91giOr0hjTkPhgv2co
 k7WQJhAs21aiTiKwUYU0PWs9biA=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/23 05:51, David Sterba wrote:
> On Wed, May 17, 2023 at 05:07:55PM +0800, Stephen Zhang wrote:
>> Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=B8=89 15:47=E5=86=99=E9=81=93=EF=BC=9A
>>> On 2023/5/16 09:34, zhangshida wrote:
>>>> From: Shida Zhang <zhangshida@kylinos.cn>
>>>>
>>>> This fixes the following warning reported by gcc 10 under x86_64:
>>>
>>> Full gcc version please.
>>
>> it's "gcc (Debian 10.2.1-6) 10.2.1 20210110".
>>
>>> Especially you need to check if your gcc10 is the latest release.
>>>
>>> If newer gcc (12.2.1) tested without such error, it may very possible =
to
>>> be a false alert.
>>>
>>> And in fact it is.
>>>
>>> @first_dir_index would only be assigned to @last_range_start if
>>> last_range_end !=3D 0.
>>>
>>> Thus the loop must have to be executed once, and @last_range_start won=
't
>>> be zero.
>>>
>>
>> Yup, I know it's a false positive. What I don't know is the criterion
>> that decides whether it is a good patch.
>
> If you have analyzed the code and found out that it was indeed a false
> positive then please state that in the changelog. Fixing it still makes
> sense so the compiler version and briefly explaining why you fix it that
> way makes it a good patch.
>
>> That is,
>> it doesn't look so good because it is a false alert and the latest gcc
>> can get rid of such warnings, based on what you said( if I understand
>> correctly).
>> Or,
>> It looks okay because the patch can make some older gcc get a cleaner
>> build and do no harm to the original code logic.
>
> In general I agree here.
>
>> In fact, I've seen Linus complaining about the warning generated by
>> some gcc version in another thread.
>>
>> https://lore.kernel.org/linux-xfs/168384265493.22863.268385285765989377=
8.pr-tracker-bot@kernel.org/T/#t
>
> I share the POV for warning fixes, I'd rather see new reports after
> fixing the previous ones than reminding everybody to update.

Or can we only enable -Wmaybe-uninitialized only for certain builds?
Like binding it with CONFIG_BTRFS_DEBUG?

So far all warning are false alerts, and I'm really not a fan of false
alerts.

The -Wmaybe-uninitialized option doesn't look that reliable on older
compilers, and for developers we're more or less using uptodate
toolchains anyway.

Thanks,
Qu
