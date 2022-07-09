Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAFC56C5F7
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 04:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiGICUn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 22:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGICUm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 22:20:42 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149147858D
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 19:20:42 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id y3so358272qtv.5
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jul 2022 19:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=xkTSGTIY9+HfUELVhigds3S5js6+wa/P8i61zThAPpI=;
        b=LPnEUUf8kjiuEjPXp8uTA93Z6RFnJiLhPpbBnTrFNKfr+HWI+asciv4B1jm7zl2/Vd
         k92y3yja/nMBmLh/jZbsO2fSSOWS+IUFBN4yiVjqdHi78k191RD4MpX0XXe56QpbVP9E
         AmVtGdOdnU4griE9gFx9L3u8AJxwONmGFsE0nj6Coinle8ZYnYuIiykQHCZ4Z50QDs37
         ca0RrbF4wP2lVZRv3XTq9p4f/OCQDrqTjEO1sWWJONjfNp2w6eYTluDRmgO9yQohVoRZ
         hZpagaIg9ZE0Ysy08sOgqeQVLQArVz7qeh5RhI17YqAo/mK635Jpk+BGOPBBej/BsQ+V
         wuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xkTSGTIY9+HfUELVhigds3S5js6+wa/P8i61zThAPpI=;
        b=OvILrnOA1JfykN5yoBS38LVzgH8nBx8Dr5wP1MLJFhbCH21Lj8Yt1LSN2tStO864Cf
         vv73zgmf8iSw3/P8xtMhPocFWQiVLUPuCbTL8uWusB4JUAYC7ybMzLpvJo2arsuC5FJq
         KTM68vp97whKmEk5IlaL4i0KxMOpVjr2qXhxHNhZKChtx/r9vwbMEjj3FEwfxSEnMIbE
         4MDfuicjwLxyszgp4jccRUlrTccg6b60EUBMEyVMMkYGep063SLt3FSxxxbEtBcz5neL
         fB+qi5wd5qbKtdTkUaNtUE3Hqxv6gpIhmmehDYMOfcxie/wih3xmTbwFWxSsITJrG9f9
         ZndQ==
X-Gm-Message-State: AJIora+GsJozMfN+61grEmua/uOQxJw/ALsYIsePEr8mxf+XSkvlTUR5
        emuwzo1pOCyTrI5TP1oLicc=
X-Google-Smtp-Source: AGRyM1vmBTr1VHVCzhF0n1icP5TT6W5rCj0xhhg/l+nhuTZ96N0t0tai/Rhnv/bQ7R8a4RMB2mAfjw==
X-Received: by 2002:ac8:5b44:0:b0:318:291d:8f59 with SMTP id n4-20020ac85b44000000b00318291d8f59mr5512947qtw.22.1657333241275;
        Fri, 08 Jul 2022 19:20:41 -0700 (PDT)
Received: from [10.5.100.6] (modemcable117.130-83-70.mc.videotron.ca. [70.83.130.117])
        by smtp.gmail.com with ESMTPSA id az30-20020a05620a171e00b006b14b303b37sm312241qkb.102.2022.07.08.19.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 19:20:40 -0700 (PDT)
Message-ID: <5e151f0f-7600-168e-66e3-f8fbf48953ca@gmail.com>
Date:   Fri, 8 Jul 2022 22:20:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: BTRFS critical (device md126): corrupt node: root=1
 block=13404298215424 slot=307, unaligned pointer, have 12567101254720864896
 should be aligned to 4096
Content-Language: en-CA
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <6a3407a3-2f24-c959-a00c-ec183ca466ed@gmail.com>
 <3ed7ee56-24fe-4fe6-b9ec-857adc8924cf@gmx.com>
 <3b281d71-ad13-2145-fe77-e70051e0faca@gmail.com>
 <18274afe-32ac-6014-c64a-ea041e61d927@gmx.com>
From:   Denis Roy <denisjroy@gmail.com>
In-Reply-To: <18274afe-32ac-6014-c64a-ea041e61d927@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

root@nas:~# btrfs check /dev/md126
ERROR: cannot open file system

that didn't work


On 2022-07-08 10:18 p.m., Qu Wenruo wrote:
>
>
> On 2022/7/9 10:16, Denis Roy wrote:
>> so, what option should I use?
>>
>>
>>   btrfs check [options] /dev/md126??
>
> No option needed. That would be good enough.
>
> Or you may try "btrfs check --mode=lowmem" to provide a better readable
> output, but much slower.
>
> Thanks
> Qu
>>
>>
>>
>> On 2022-07-06 10:19 p.m., Qu Wenruo wrote:
>>
