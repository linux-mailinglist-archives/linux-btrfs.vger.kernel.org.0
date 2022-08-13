Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2D459195D
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 10:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiHMIGE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 04:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMIGC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 04:06:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D861AF1F
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 01:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660377958;
        bh=3ew61xR18Gt9yVqcH2DH0w68PH4AWGlsxQndrCkXCJI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=GWe6nteue20DCOnlNORcLmsK+HqJBDgU+XTSnKesQxcEFUmJ9YzFeqKUEOiMSRAeL
         63O1zVn5TuxghCnXfDmftb+enKEE/b52MLHLVovHB0pB639upYaaUg6J/62PrkVxzL
         PadGFab9VrurFft0sImtGZV8xi6WA8DNfBdqeFl4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYvcG-1nrvSX2FHc-00UsVZ; Sat, 13
 Aug 2022 10:05:58 +0200
Message-ID: <a9d3eb38-e939-4751-4dc8-896fa653be73@gmx.com>
Date:   Sat, 13 Aug 2022 16:05:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Corrupt leaf, trying to recover
Content-Language: en-US
To:     Ash Logan <ash@heyquark.com>, linux-btrfs@vger.kernel.org
References: <6270a749-5fb2-0b36-529b-07f0e2ce4639@heyquark.com>
 <0b4a3bca-cafd-b47d-d03c-a97922e49228@gmx.com>
 <c1b246ad-6665-1216-166c-a1ad32222b35@heyquark.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <c1b246ad-6665-1216-166c-a1ad32222b35@heyquark.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6YmGgfSju9XGkxfVj2B3ieF39TQGbgzCPhTJmQM3btl9DYXZwUe
 sOvOQLUGGNBuGk3OogQztxM4XXnNbtQpYVug8MytLXK+sCSaoQCYkYFfpDfY6qt1SxuhFud
 hSUau37xKc/XfsAE2FPPRA9w8X0UXBHoX6ZE6BJPHdqjuXWzekPh/orYGVuHu8yNLEWs0Js
 qwOwCGMUV8Px0gldVVp8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c6btngokW3g=:JGAF4sp240Kc9x/Q7JU3cR
 CSy9ObDiFERtkFQKmioqZfMHMQzV2AmVpimAVOTqjilqbABfHTE2JpwM+En+ULLK734A9/WZF
 QrnU9vc6fY+SYZwjRNKIHb74qw1H80RV6SPT4Qa3J9azvMygLBy58pW5riWZqZ9Mh/lerrBv1
 F3C04jY2OQGKv2DKKtC0Q2DOrcGbFmEmMimHu1OosX/DpR60M01pFVw5MNlMAhD7cG5DEW00m
 Ypks/XNMZEpx2PUIAKOUPbAPm7pO2a+2AXlidSFp0HUdvdk6KEbn1HQtJ51aViVltkTWiyemk
 tDynbzMgbyN2PdgxDfPdNnstzFVkiVBQHLUmRFCiHojivEL8+CYmiNLIkg6frHCyEmJXymrLm
 e+xaOfX9h4dPYM6jwQgEsClZoZQZutGwOkuwZm4lOnRmoaxDmlkrBKGQwgP21zFCahBJziM4J
 9YRFIcyzKFVuGi285IWOF0zoSH5vg38wORqeID6gMEdMn3XgX+jd5Qvml2SNYmsJTCx0yKrNx
 6Ah3lOceUuyWC28Weg29NPo1ILVWhuOO70Rlyxz1uI8yctbLaHn7ioG/dd2qSutCAhaOuIle9
 fC9J3gIKti58gFKvC6eiRlNev73nQem3+z1USAhQVBdi5BsdZN+A//hFiTeDrp1lUyas2vgcu
 np3u6HQlE3Ez+azdWEMpn/3i91V3/UjR80OFaGcYY9fwjH3pU1l9041nltHw2qmDTC5kqRifg
 q7yFMgv6nPIQRMBNVkmQ1FQAhngoxT5RYYd5Fq/AZsWZZqGPRJNyeRzOTADI5Y0yuAMPxtXaT
 AiE+SfJM3h49MYRlsoi94YRP6IgRqV8MM4veH5ywd3ZamaiYUBvVM6bOa89CnR2CbD0xlOvyA
 MftTRjCfyui9jCZ+W5oLiLgBfUChwRoURVQmvfw4/EUgHaSRTo2cof0/2dOwAF1moK5pTmy4C
 yvon4aGvPDAY5qdJFB7v9iNP4jU0jidLGWos17KIedmcDHBNfuOaNpz9KTVxqxuNNls8XPfCR
 dQaUuiuaq6Zebxw75tf3ZaQvuXmARFzwDP+G+rNQYmb+faGzUzx8CRyjDvzYcpSCgkl/v9Rxc
 JE/0ayc7WV+R3bh9K1Vqf1ovWWTWKbw+YWzMo5g8RaS0/g4wZad4vSdlg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/13 15:56, Ash Logan wrote:
> Hi, thanks for your email!
>
>> Please post the output of command "btrfs ins dump-tree -b 35291136
>> <device>"
>
> Attached.

It looks correct, all other ROOT_ITEMS has no extra flags, and only that
offending root has the problem.

Thus it looks more like a bitflip.

>
>> It looks like a bitflip so far, and if that's the case, I strongly
>> recommend to do a memtest before continuing.
>
> Will run now, hopefully it comes back clean.
>
>> Unfortunately since you're upgrading to Debian 11, I believe the damage
>> is there for a long time until you have upgraded to a newer kernel with
>> such sanity checks.
> Ouch. At least this suggests that a kernel downgrade could still allow
> mounting and data recovery.

Yes.

As long as that's the only bitflip, everything else should be fine.

If you want, you can remove subvolume 389 (and if that's the only
bitflip) using the older kernel and then mount using much newer kernel.

Personally speaking, it's strongly recommended to use kernel newer than
v5.11, even if a memtest is clean.

That new sanity check introduced in v5.11 should save a lot of hassle
like this.

Thanks,
Qu

>>
>> Thanks,
>> Qu
>>>
>>> Let me know if you have any advice.
>>>
>>> Thanks,
>>> Ash
>>>
