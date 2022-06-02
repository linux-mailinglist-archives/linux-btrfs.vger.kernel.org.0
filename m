Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E09753C0B9
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 00:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbiFBWQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 18:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiFBWQf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 18:16:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1933465B
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 15:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654208191;
        bh=ATWcba6FZmiGnYtcix6iNCjCTeS4WK4gHxJKol4JUhI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZNpvNjJPjRjFy+MD0NhYeJ1kKv0yg0S9i5pXtoIrDEVynwtt949yOE44eGfGLOlBZ
         JiUVBytbYk8DsGxf9MI3xC8xWrDNrMXMn/IToXOCWQxfVll2j7YQpnGWhedvhL90MR
         X52zLHLjFY/S6ZdzyfSGuMWU60M7gQazN9rtLf60=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXp5a-1oHoAN0GDM-00Y8cn; Fri, 03
 Jun 2022 00:16:31 +0200
Message-ID: <760a98d8-3524-d24f-b5f9-3653ee46661d@gmx.com>
Date:   Fri, 3 Jun 2022 06:16:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Manual intervention options for csum errors
Content-Language: en-US
To:     Matthew Warren <matthewwarren101010@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+H1V9xQEDf0G-Nvcv3irtSPF+09dJ6VMs7F8LBLpUGEUSfxmg@mail.gmail.com>
 <7762988d-0a64-695a-4ccd-ba7b51c0754a@gmx.com>
 <CA+H1V9wSZXVrLdz9ZELx8gc3nOHOJz4b48DQMFcmc8cTEJgXAQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CA+H1V9wSZXVrLdz9ZELx8gc3nOHOJz4b48DQMFcmc8cTEJgXAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:19QEPTtceMWwpPBtAvfGkOXmjmduEuHMmpfWeYlJrqw/1IpOBCP
 R90XuSfnRMJ0Te7zxyw1AsxQVP8Y9tnFdhe5rNBxUOTbCaex/2OPlYXmzcfWoS0IOFpRPUv
 wbmZ0wIP2jsX/1BXo2/YjmSoxVCuwWyQ1MWWCxyqAI4AR2d1GFU9ooJisQVb13ockfUDpN5
 jdN3bYS/gFDoOBQqYHcpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:feNtxPmIviE=:x2PbZLR6RLpgaB+oosPh6L
 ycCatLQ/lc9vsBmpj1pMrGilq0Z2O8dXQQ1+fLnV+XjX9rE8X+9qqkb7W0jtgxBNNyCAAqfHt
 fNwbTlmZLmaBFCFgkRszGiwmTjjoB0Ra11hQN6DDWRW9t+J1ZQqwuC7KksWPtfnV/T0wrdk/q
 tcAm9hQXNPd4puAZBeSxFJ8QQPenQn2U1hlwH3+06FpP+4jDV3ySWYCDN1+XMvdUPugfVAR8u
 1WlnXrEJA9fj7rAZOhLcY6xoeLQLCYFoupa16RDJUv3N+TAgHCDpTDRxu6NIucXCHEl/i9xCc
 jtFx27lZSOIh0zu9vrLqCBe8/WTInoFkc2Az7vgEl95/87l6YzZpF6SiYJpML705PbWWkUXf9
 XLTvTP6mwIVFJm1+67X46w9UU1k5DAbEyW9Rc1xRgysMVx4AfXohgzA6mZ0hSAfbkcJkqQfk4
 d3Q6P0xZd3gdJ08aGANOvS04O5cEv9qG8o5qxfw9J2qJzukX2nZD+wNyZGbaB9fJbbjxmVeBu
 v5isgS6OwbgnI3HbMi42MMAk7v0vf9Os9LMGk2ML40iH6Tn806+xLoyl4qugMIW+PUGJkc7jg
 4vWpVaVgQIQ9Pdza0MDvveva66unF1TgIpzdcXV28H9Iqd6WKHDqZWUjHUXJZ4iKn8OaMH8LE
 Xn6Tj3KNHuxBHJXSFWCjIZdm2Rpw/kHFJ1+kxcelVfonfvNq2iVLbl+hutwFQ6yXyrPd8ZBpO
 7Xqsr5XoXzNSU5xboXG6AqSn5EI/RCreZ7JO3jTGvJuoQ707iUMK0b21yAGYXGZeSwQ9jI77S
 NYgBFCgNiBuXbz3zLZPTLxbuXuDyGoH0K8NAEl0e18fJBjk2SB5g0SSXplSKpMe0kDZgOSnqx
 /dXiYWrulfKsw81W6Fc/SJo83sJ83H5B7trUkMjxpm6V3+jB4j7jNZrFZHI2vkmkSa+vXHvMH
 ZeSFW899oParsuefWq9EjAJYPKwsGR8di1K3bqcOoLuh10hIjTup3lg2B2NR99Gc6Xkob3TH8
 WpGz/E8Srhw8CwsPLshqzwEspa+4dmUTAaBMkm8rJMPV8iL1u3QD3N6Fg5s3ECDo8oxsAg9rC
 mvZRHIlMINBhQalGsUwT9UrZdQ9g8m35wu/HHql/N7Vn1W3N0rMYf7k0Q==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/2 23:30, Matthew Warren wrote:
>> This is not a good sign.
>>
>> Such bitflip can only happen in memory, as if it's a bitflip from disk,
>> then it will cause the metadata csum mismatch.
>>
>> So this means, your memory is unreliable, and a memtest is strongly
>> recommended before doing anything.
>
> I don't think that's the case. The files were last modified all the
> way back in 2020, but there hasn't been any file modifications near
> them since the end of April this year.

Since the bitflip is in csum tree, it doesn't matter if that specific
file get modified.

Any other file modification can trigger CoW on that csum tree block.

> There's also been 2 scrubs
> before the last one where there were no issues at all. Does this mean
> that at some point in the last half month (since that's the time
> between the last successful scrub and the scrub which errored) BTRFS
> read and re-wrote the file to disk?

I'd say yes. And it doesn't even need to modify that specific file.

That's why memory bitflip is so concerning.

Thanks,
Qu
>
> Matthew Warren
