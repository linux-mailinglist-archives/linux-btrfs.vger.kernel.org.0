Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18586720AC3
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 23:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbjFBVEi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbjFBVEg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 17:04:36 -0400
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FCF019B
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jun 2023 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1685738462; h=In-Reply-To:From:References:To:Subject:From:Subject:To:Cc:
        Cc:Reply-To; bh=KNcAq9kRS0m79PFOTJAYoJb8zUavriJhHBMLuQ/Y/k8=; b=J2x9FhEv/QqnM
        q8ppeD+bEAA6bQqzYDxbyWP9zKhhzPvZ86JyWB7c0LZzsYGbJw9oufXW2Vz/JJVTWPfTRzCwEJi36
        9wVbUbuW63wXClHG0mtSzgz3vzNs1M5WfS+9Z06zs2C9nX1dczkraaEchkFBh3O9feY2DUOTAVNTI
        rS+1hAppSLYlmPlQ5YHAjHwtvurqqY1kqum+C+rTTe9VaqRlGWniyGiPlkDVQeUx8xuTyhbqBNpyL
        q+PtqyJ2macRNgiGBirHH8qSf8gq3cTKDsLnrE7YBWk9/HJMkT+hPFZ8pE/XOibGOMqB+wd3SiLYU
        2+H5/AwJE0u1CdMTbeNJA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1685738463; h=In-Reply-To:From:References:To:
        Subject:From:Subject:To:Cc:Cc:Reply-To;
        bh=KNcAq9kRS0m79PFOTJAYoJb8zUavriJhHBMLuQ/Y/k8=; b=ZrKQqo1VALCr0WYey+dWLi4C3c
        VoDFFJpBtxJfE27q6XB8NwlBbsjsmrGu5J8Sm0XVbmI7ccLbcY7PNPHOj3BXAl0rDOf+o0Ky/nJvY
        3koQAAE2HrrRJmy0tpKTqf9cmnZvy84JfZRBIrr+Fuh7h3OoKYRZCseG8vTyCSpGKyY4FpPvc5czv
        UyQW9uJ6QeIY4H7L4ESQ6ianODv6Cuqc34hVDyBQ12ex6i79sKRGvAKzXsUwb69iPVtvhhegbgV2d
        cHk8vaNE06lNt3DL3wrURN47fiLShoJnGk44XhmtSSYsqpu2JDbTN1FZtiS2gvRuCr0NvP5DL9E8q
        YyunxH1Q==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q5Bwo-003skC-0a;
        Fri, 02 Jun 2023 21:04:34 +0000
Message-ID: <f15443e5-29c4-1fe7-349e-cd8964b30ade@bluematt.me>
Date:   Fri, 2 Jun 2023 14:04:34 -0700
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
 <cfea3f0f-a683-8337-440d-f762b2104df9@bluematt.me>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <cfea3f0f-a683-8337-440d-f762b2104df9@bluematt.me>
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



On 6/2/23 1:30 PM, Matt Corallo wrote:
> 
> 
> On 6/2/23 1:34 AM, Qu Wenruo wrote:
>>
>>
>> On 2023/5/30 04:48, Matt Corallo wrote:
>>> I could try,
>>
>> Unfortunately I really ran out of ideas, everything doesn't make any sense.
>>
>> Unless there is something special in ppc64, I have no way to explain the
>> whole mess so far.
>>
>> Just a final struggle before the full (and would be slow) trace_printk()
>> patch, have you tried memtest the whole system?
>>
>> This should rule out any obvious hardware memory corruption before we
>> jump into the rabbit hole...
> 
> I'm not aware of a readily-available all-memory testing utility for ppc64, but I did run the 
> userspace memtester utility and it found nothing. Maybe more importantly the system does have ECC 
> and I haven't seen any ECC errors come up on it.
> 
> Sadly, I'm no longer set up to reproduce this issue due to the balance-cancel-WARN_ON/remount-ro 
> described in "[6.1] Transaction Aborted cancelling a metadata balance".

Heh, motivated myself to go trace more, I think I found it (see "Add handling for RAID 1CN to, 
`btrfs_reduce_alloc_profile`", which I'll go test once I get a response indicating I'm not gonna 
brick my fs trying that)

Matt
