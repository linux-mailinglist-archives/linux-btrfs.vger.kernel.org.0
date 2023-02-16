Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F24769893E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 01:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBPA3v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 19:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPA3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 19:29:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E96A42BC5
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 16:29:49 -0800 (PST)
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26vB-1pPyFA3ukT-002bgW; Thu, 16
 Feb 2023 01:29:34 +0100
Message-ID: <538f28aa-66e1-8c9b-85ef-151e058b35dc@gmx.com>
Date:   Thu, 16 Feb 2023 08:29:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH RFC] btrfs: do not use the replace target device as an
 extra mirror
Content-Language: en-US
To:     Stefan Behrens <sbehrens@giantdisaster.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <2902738be4657ec16e5b5dd38eac1fb53aa5cc44.1675918006.git.wqu@suse.com>
 <Y+sy5xHfz6S16/oc@infradead.org>
 <e7a2cb06-d6b1-f40b-477a-dca130a4a5d2@gmx.com>
 <Y+x+GjgREMyYe5pP@infradead.org>
 <d2f73a10-7ec8-0b42-1a4e-eb86b0740741@gmx.com>
 <Y+yCncfD0EyfsxTe@infradead.org>
 <7f78db15-7f82-5349-a4da-6fa58365e3e0@giantdisaster.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <7f78db15-7f82-5349-a4da-6fa58365e3e0@giantdisaster.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Jji9wVFLgSwMGTs11e84V85OMP5gWTtixMrtsxzINms13ppSw8Z
 K3SXwRAUm+6Dx5wld+rn5IAlnNMKJJvN35FWwPCI6uiRFoxN7rvVnl0Q2MvoGrU7fEsUSZz
 gO2qWececOhNdIQ0YFAKuIiDKwJN44jvxMntcN0aaHRcfE6gf4NEl/wWjrea0AfXKZ9y935
 DqDJ1Lb7pVehieDrlkl4g==
UI-OutboundReport: notjunk:1;M01:P0:jRnwL3yqEkA=;xVqxLPAjEu3jQd0pInUG13tM/4r
 OrZhjgDOxp5HcqU9TbNYfshaOAKc/x904MfQuIdypD/P0oeeIN1v0obidDid/xUW7pxA8/1zf
 4rTRcFrvv4kKraoyRJOOWRhUaYjdj2fqObP6pCtQ3ExuLb3IqCicNus43GEK1pgdMkw2j5Jgk
 o3fFaygwi3pXibhzdfD7Kc55MHB/auR8QCT+AQ0VQZjxLTMqnedchyym/e9KD9NvmxdgV79rH
 CzztOqEqnjGGI470cHoFNPficCn/cra5uxOE1XsDLEmcCAwiKXEcZyVefAe1TGDlX+djmCgW6
 L0WOm0qALboQi4M6DuxGls5V5FV+XlswkSrQZLxh5hUiv304yHhUv5SI4mC3XyjFbpw/7NaHx
 qfr3zMW4WfF+oH9hFFmx6SaecF6NQAdfRUUXXONc3LiCun5sUg/FLi5mkxRGzLLFsquZAd4mF
 JoHK0KzaM75PlI1zOjuytvPxGLkgkTAQbtDsb2xRvwUWKOLJzyxptBBWAaaDn3n5aoY1q3fIm
 zfAfIhisPfw8gRsjKgwtn5CQ4Odlj1M1RGGLIVPf91bf/Ix5BSjkmRQ9Ep6YEqt9amc8LFbmO
 DpZhdL/zDIfy2gLHCzFw4kGFnOE0ckVuqJ/l0Cc+Fy6tVlzSmid1xQTKHRTf2vuVaEbYEepPZ
 oj+t58srHI3+mvrK2gz6u/fLVzFl+HTdVZfEgC8Ywt+1CgprYnwd2e4keUxr8yaUnfGobYkSl
 9e+ljn6p948W2Qki10A/cbCKtP8ei58jSZnZjL8uOAfkkXiVFM9MXddv6JBMgbuov+2ZpylgV
 JxLo6BiLKA8aRAYGUj+8CSY6rz9Z9M+rh0+OlGAnG+vj54WEVKLiPKJ2DObWC11paCzIz9qCm
 uuLfaYyyTd6zw0WB/LTwqTHQ5fQfnltIxR3KvpCYb5uaPqooUnd9feJJ+3jhHy4DGd6a+QsCO
 qi46bs/2xm1fNL3SHNidekC05D4=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/15 21:58, Stefan Behrens wrote:
> On 2/15/2023 7:58 AM, Christoph Hellwig wrote:
>> On Wed, Feb 15, 2023 at 02:56:39PM +0800, Qu Wenruo wrote:
>>> Meanwhile replace hasn't yet reached that bytenr, thus we're reading 
>>> garbage
>>> from target device.
>>> And since NODATASUM, we trust the garbage, thus corrupting the data.
>>
>> Yes, for a read from the target device to be useful, the progress
>> needs to be tracked, and the read only needs to happen on data
>> that actually was written.
> 
> The device replace code maintains (or used to maintain) a concept of a 
> cursor.
> 
> There's a small area on the target device which is currently written to. 
> Left of this area is valid and already written data, which can also be 
> read in case it's needed to fix read errors or to avoid access to an 
> almost damaged hard drive which tries to reread every bad block 2048 
> times (which is 17 seconds at 7200rpm and something you want to avoid). 
> Right of the area is data that must not be read because it is garbage 
> and uninitialized contents of the new disk.

So the main reason for the concept is just to avoid read on the damaged 
device?

Is there any real world data on the behavior?

I don't know which commit removed the cursor, but considering the extra 
work needed to properly handle the cursor and only provide the extra 
mirror on the correct condition, I'm not that convinced it's a total win.

Thus I'm more towards dropping the behavior.

Thanks,
Qu

> 
> There are several comments about this concept in volumes.c. And scrub.c 
> is the place that keeps the left and right cursor up to date which 
> define the area that is already written, currently written to and not 
> yet written.
