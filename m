Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19F6720A55
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 22:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbjFBUad (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 16:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjFBUab (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 16:30:31 -0400
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 962D6E45
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jun 2023 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1685736061; h=In-Reply-To:From:References:To:Subject:From:Subject:To:Cc:
        Cc:Reply-To; bh=qDRAZf1N9Wi4gOU81lr/zjxeeOihksJuIeasY2RtYpQ=; b=mhRIfxvbCd2Aw
        qzroaH1E8EDEC2+clNSYZkv0J+ZkrsKdsQ0fxIToM6wPLPiU8bMT/YpHvMXG8UHK8/HICGxpHm0BZ
        E+XgczYGOazX1XyymhnlNMF8AWcqRAgTkIAvUiZb5MxQt7J6oAmMT28/gADJeTSr0GVijXSm3pfbe
        GeKK8Ka1iEzIqTfASCmYSkl9eS79X7EvKipLr9nHwYgjljs+SuVSyHveVR4FcyCYNP3wdD8vk4EQH
        CnJAI552DzXvDoa5MHVKFyyG7flN0rhagE8wdPChss7hPtaFDMnRGdClFW6GUCYei0Q1d8Prbsg9Z
        6CioU8wWq2J3ioOvK/uLQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1685736063; h=In-Reply-To:From:References:To:
        Subject:From:Subject:To:Cc:Cc:Reply-To;
        bh=qDRAZf1N9Wi4gOU81lr/zjxeeOihksJuIeasY2RtYpQ=; b=rOble9q9fbVJJq6EexKC8Ro7EZ
        UplVrbcxj5tD5StaJrkgAfn0G3rXveRxPvnJw+WqS9yN1SiAWDrjXTg2QKJF/n6pcudo5I834nXDo
        psYj2bf4LSP1m8pHuBIo1CzNFZmjJRQQTR+Jx7tLLOmKXYzJVV/fXXPrMc3YZ514iJCkPJVsLXNew
        b5+/FFRh/UcdULUvD2OPAMvD5w3f6nj6LqkPvURwfVza5j6W3AhXZeOhvFCWrQJ00PJpW2NqKJDKo
        Lwy55weTNoamkGgCy84tHof9XKe0aHI6quyyT1MM8b7QoGqA+LdxavjN1akhQrc2hOwmz5Kh1O9ts
        6FphYjcA==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q5BPn-003sLK-0i;
        Fri, 02 Jun 2023 20:30:27 +0000
Message-ID: <cfea3f0f-a683-8337-440d-f762b2104df9@bluematt.me>
Date:   Fri, 2 Jun 2023 13:30:27 -0700
MIME-Version: 1.0
Subject: Re: 6.1 Replacement warnings and papercuts
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <4f31977d-9e32-ae10-64fd-039162874214@bluematt.me>
 <2a832a70-2665-eb9e-5b66-e4a3595567e9@bluematt.me>
 <62b9ea2c-c8a3-375f-ed21-d4a9d537f369@gmx.com>
 <2554e872-91b0-849d-5b24-ccb47498983a@bluematt.me>
 <5d869041-1d1c-3fb8-ea02-a3fb189e7ba1@bluematt.me>
 <342ed726-4713-be1f-63dc-f2106f5becc1@gmx.com>
 <fa6ebdfe-acf0-e21b-5492-9b373668cad0@bluematt.me>
 <82b49e3f-164d-a5b4-0d19-b412f40341b9@bluematt.me>
 <07f98d39-de57-f879-8235-fb8fe20c317a@gmx.com>
 <add4973a-4735-7b84-c227-8d5c5b5358e6@bluematt.me>
 <6330a912-8ef5-cc60-7766-ea73cb0d84af@gmx.com>
 <b21cc601-ecde-a65e-4c4e-2f280522ca53@bluematt.me>
 <e82467d6-2305-da7c-7726-ec0525952c36@bluematt.me>
 <b22bbb5f-9004-6643-09ea-ee11337a93f0@gmx.com>
 <e0107d51-57fa-6581-88c8-77f88f6effd6@bluematt.me>
 <9d6b2ad9-24cb-54aa-2dc9-5039f9eca76f@bluematt.me>
 <2ce845b8-add1-072a-239c-18df81381aca@gmx.com>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <2ce845b8-add1-072a-239c-18df81381aca@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_ABUSE_SURBL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6/2/23 1:34 AM, Qu Wenruo wrote:
> 
> 
> On 2023/5/30 04:48, Matt Corallo wrote:
>> I could try,
> 
> Unfortunately I really ran out of ideas, everything doesn't make any sense.
> 
> Unless there is something special in ppc64, I have no way to explain the
> whole mess so far.
> 
> Just a final struggle before the full (and would be slow) trace_printk()
> patch, have you tried memtest the whole system?
> 
> This should rule out any obvious hardware memory corruption before we
> jump into the rabbit hole...

I'm not aware of a readily-available all-memory testing utility for ppc64, but I did run the 
userspace memtester utility and it found nothing. Maybe more importantly the system does have ECC 
and I haven't seen any ECC errors come up on it.

Sadly, I'm no longer set up to reproduce this issue due to the balance-cancel-WARN_ON/remount-ro 
described in "[6.1] Transaction Aborted cancelling a metadata balance".

Matt
