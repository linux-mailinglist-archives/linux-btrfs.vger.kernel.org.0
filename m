Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A9D4EC9B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 18:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348828AbiC3Qfj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 12:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348711AbiC3Qfg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 12:35:36 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EDCBCAC
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 09:33:49 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 3011C8082C;
        Wed, 30 Mar 2022 12:33:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648658029; bh=CDCNTIoptADzQ+d5aJmC559qTeIjVfHFFm75oVf6uQE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GJWtHCGje2hR5WB45NZ6/i1QYaDyqY6Y6wt5dd1Gf12f8ISKtAAEEnbV0MLs1euHn
         E0yVusFQr+PqURRH2qb0WEWHSrza8rJCIo4ZK/Q72/+qMySehfnQwB0LCTIWTHZOEL
         ZYrycQBXVvnU9EcxAuQdfaWC1QS/co56kaTDSRlZOa0Nhouy8zUf/F/bFuTa0hxDGB
         DJ98uJc2+qtsoeRNyN5Xy7OfePNZA7Mua4EB1bJScytiqXxrGcEGKhfaWVDLIAkbNV
         XQFVc9PVE8+SDSUBFwVsp6V+vBNLKBsklDOnHc6g/UyQPM3UKP6Bt+LPcIjfJsWHAt
         y4KjI24LCLhQQ==
Message-ID: <598151ee-7a14-0c54-34d6-4591bc19fb73@dorminy.me>
Date:   Wed, 30 Mar 2022 12:33:48 -0400
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
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <YkR/QuBrKPYTwIFt@relinquished.localdomain>
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



On 3/30/22 12:03, Omar Sandoval wrote:
> On Thu, Mar 24, 2022 at 01:53:20PM -0400, Sweet Tea Dorminy wrote:
>>
>>
>> On 3/17/22 13:25, Omar Sandoval wrote:
>>> From: Omar Sandoval <osandov@fb.com>
>>>
>>> For encoded writes, we need the raw pages for reading compressed data
>>> directly via a bio.
>> Perhaps:
>> "For encoded writes, the existing btrfs_encoded_read*() functions expect a
>> list of raw pages."
>>
>> I think it would be a better to continue just vmalloc'ing a large continuous
>> buffer and translating each page in the buffer into its raw page with
>> something like is_vmalloc_addr(data) ? vmalloc_to_page(data) :
>> virt_to_page(data). Vmalloc can request a higher-order allocation, which
>> probably doesn't matter but might slightly improve memory locality. And in
>> terms of readability, I somewhat like the elegance of having a single
>> identical kvmalloc call to allocate and send_buf in both cases, even if we
>> do need to initialize the page list for some v2 commands.
> 
> I like this, but are we guaranteed that kvmalloc() will return a
> page-aligned buffer? It seems reasonable to me that it would for
> allocations of at least one page, but I can't find that written down
> anywhere.

Since vmalloc allocates whole pages, and kmalloc guarantees alignment to 
the allocation size for powers of 2 sizes (and PAGE_SIZE is required to 
be a power of 2), I think that adds up to a guarantee of page alignment 
both ways?

https://elixir.bootlin.com/linux/v5.17.1/source/include/linux/slab.h#L522 : 
kmalloc: "For @size of power of two bytes, the alignment is also 
guaranteed to be at least to the size."
https://elixir.bootlin.com/linux/v5.17.1/source/mm/vmalloc.c#L3180: 
vmalloc: " Allocate enough pages"...

