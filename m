Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1708E4ECCA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 20:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbiC3Suf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 14:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350145AbiC3Sua (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 14:50:30 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F33225E0
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 11:48:43 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 85E47804A9;
        Wed, 30 Mar 2022 14:48:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648666123; bh=RW4JCHQILBIK5BmQaMpnhoBX/l26wBjso8ODkDI9SuQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oRb0Eh0p6Gc9XnDoj7qFaXKrLDWoa/kW4vqd0QfGEd2fEwXtj2kGAeR+daEhBJAwh
         cIlvNObk19bL2WHLgKADZxTpyKxdir7jLTE7ZaJRcYCtKgvZaC16aU/gYN5HNvRpDr
         qc98Of68/EpZXPQOLS1hkaPlrdNSAIE0w45O1IbbEfYfxfRI0d8tz3/s4YnygSwLbN
         1nzoxrHVmxmkysnWNGn9nf5TfU9t1kIb7zNDfuivG9E5Xn7Rj7qzFefw2LmKO7/LFh
         HyxNOGJVaLhuq/hSVc44MEgPXqB8qYiakZXG3ud94jjXsQ7OdExKv1z1wYJ+pCj1Ic
         hu5QGU8+RDOMw==
Message-ID: <9b168d90-e0e7-459b-36e1-ea5cbe23c8ea@dorminy.me>
Date:   Wed, 30 Mar 2022 14:48:42 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v14 5/7] btrfs: send: allocate send buffer with
 alloc_page() and vmap() for v2
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1647537027.git.osandov@fb.com>
 <4353fe7122eb0aae24e3c9ff2399f2b58b74f79e.1647537027.git.osandov@fb.com>
 <fb73fe9a-21a4-0744-2a61-bfd3602a0f20@dorminy.me>
 <YkR/QuBrKPYTwIFt@relinquished.localdomain>
 <598151ee-7a14-0c54-34d6-4591bc19fb73@dorminy.me>
 <YkSPsV0l0JV1Lx1f@relinquished.localdomain>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <YkSPsV0l0JV1Lx1f@relinquished.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,DOS_RCVD_IP_TWICE_B,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/30/22 13:13, Omar Sandoval wrote:
> On Wed, Mar 30, 2022 at 12:33:48PM -0400, Sweet Tea Dorminy wrote:
>>
>>
>> On 3/30/22 12:03, Omar Sandoval wrote:
>>> On Thu, Mar 24, 2022 at 01:53:20PM -0400, Sweet Tea Dorminy wrote:
>>>>
>>>>
>>>> On 3/17/22 13:25, Omar Sandoval wrote:
>>>>> From: Omar Sandoval <osandov@fb.com>
>>>>>
>>>>> For encoded writes, we need the raw pages for reading compressed data
>>>>> directly via a bio.
>>>> Perhaps:
>>>> "For encoded writes, the existing btrfs_encoded_read*() functions expect a
>>>> list of raw pages."
>>>>
>>>> I think it would be a better to continue just vmalloc'ing a large continuous
>>>> buffer and translating each page in the buffer into its raw page with
>>>> something like is_vmalloc_addr(data) ? vmalloc_to_page(data) :
>>>> virt_to_page(data). Vmalloc can request a higher-order allocation, which
>>>> probably doesn't matter but might slightly improve memory locality. And in
>>>> terms of readability, I somewhat like the elegance of having a single
>>>> identical kvmalloc call to allocate and send_buf in both cases, even if we
>>>> do need to initialize the page list for some v2 commands.
>>>
>>> I like this, but are we guaranteed that kvmalloc() will return a
>>> page-aligned buffer? It seems reasonable to me that it would for
>>> allocations of at least one page, but I can't find that written down
>>> anywhere.
>>
>> Since vmalloc allocates whole pages, and kmalloc guarantees alignment to the
>> allocation size for powers of 2 sizes (and PAGE_SIZE is required to be a
>> power of 2), I think that adds up to a guarantee of page alignment both
>> ways?
>>
>> https://elixir.bootlin.com/linux/v5.17.1/source/include/linux/slab.h#L522 :
>> kmalloc: "For @size of power of two bytes, the alignment is also guaranteed
>> to be at least to the size."
> 
> Our allocation size is ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED, PAGE_SIZE),
> which is 144K for PAGE_SIZE = 4k. If I interpret the kmalloc() comment
> very literally, since this isn't a power of two, it's not guaranteed to
> be aligned, right?

Ah, an excellent point.

Now that I think about it, the kmalloc path picks a slab to allocate 
from based on the log_2 of the size: 
https://elixir.bootlin.com/linux/v5.17.1/source/mm/slab_common.c#L733 so 
we'd end up wasting 128k-16k space using kmalloc, whether it's aligned 
or not, I think?

So maybe it should just always use vmalloc and get the page alignment?
