Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5953C94B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 01:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhGOAAY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 20:00:24 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.51]:32473 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhGOAAY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 20:00:24 -0400
X-Greylist: delayed 1356 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jul 2021 20:00:23 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 65FAE1ABF3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 18:34:53 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 3oOzmPzmS7sOi3oOzmGjHa; Wed, 14 Jul 2021 18:34:53 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f4BTjqWy3Nl8KYQYjBW9oW+8v4acTgFa9ttcl6KGQHU=; b=zV/B3sLiz9TUUrbSdZRyaNXG+r
        x7BhKCeX3DR2hcx7iF5vjbDuympOC/CUvOWSM6swbBDHzpgM9eh2NRM1zsuzQF+qNJSGEvLcd1+hC
        2xIbn22MEBHlyMwSw//DYBeud9DPg32mCEkeEmmWgbybZrceY3EM506PLdElEyYhkqL0Z/8UCofiy
        2S2pA4uoPEK9K6/SP2ES74PkEme41rMhmZDfDetVc0yUqYW6F3kMeGKXK59VABfeoZ8jonHkXUVIR
        MhDB5b29PRuXtpVtja3nuJqu6V1DML6IScAdLvyst+IO3FRUdl25ji2TdZJLMnMIvuSgj+K33V5z5
        nGbnXnOg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:50678 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1m3oOx-001W1G-1k; Wed, 14 Jul 2021 18:34:51 -0500
Subject: Re: [PATCH] btrfs: add special case to setget helpers for 64k pages
To:     dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
References: <20210701160039.12518-1-dsterba@suse.com>
 <YN67+nvpQBfiLXzh@infradead.org> <20210702110630.GE2610@twin.jikos.cz>
 <YOLD3CJjDgiq+kfR@infradead.org> <20210708143412.GC2610@twin.jikos.cz>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <333c5709-0d10-635e-656f-32263ec7f0a5@embeddedor.com>
Date:   Wed, 14 Jul 2021 18:37:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708143412.GC2610@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1m3oOx-001W1G-1k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:50678
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David,

Is it OK with you if we proceed to enable -Warray-bounds in linux-next,
in the meantime?

Apparently, these are the last warnings remaining to be fixed before we
can globally enable that compiler option and, it will be really helpful
to at least have it enabled in linux-next for the rest of the development
cycle, in case there are some other corner cases that we are not aware of
yet.

Thanks
--
Gustavo

On 7/8/21 09:34, David Sterba wrote:
> On Mon, Jul 05, 2021 at 09:33:34AM +0100, Christoph Hellwig wrote:
>> On Fri, Jul 02, 2021 at 01:06:30PM +0200, David Sterba wrote:
>>> On Fri, Jul 02, 2021 at 08:10:50AM +0100, Christoph Hellwig wrote:
>>>>> +	if (INLINE_EXTENT_BUFFER_PAGES == 1) {				\
>>>>>  		return get_unaligned_le##bits(token->kaddr + oip);	\
>>>>> +	} else {							\
>>>>
>>>> No need for an else after the return and thus no need for all the
>>>> reformatting.
>>>
>>> That leads to worse code, compiler does not eliminate the block that
>>> would otherwise be in the else block. Measured on x86_64 with
>>> instrumented code to force INLINE_EXTENT_BUFFER_PAGES = 1 this adds
>>> +1100 bytes of code and has impact on stack consumption.
>>>
>>> That the code that is in two branches that do not share any code is
>>> maybe not pretty but the compiler did what I expected.  The set/get
>>> helpers get called a lot and are performance sensitive.
>>>
>>> This patch pre (original version), post (with dropped else):
>>>
>>> 1156210   19305   14912 1190427  122a1b pre/btrfs.ko
>>> 1157386   19305   14912 1191603  122eb3 post/btrfs.ko
>>
>> For the obvious trivial patch (see below) I see the following
>> difference, which actually makes the simple change smaller:
>>
>>    text	   data	    bss	    dec	    hex	filename
>> 1322580	 112183	  27600	1462363	 16505b	fs/btrfs/btrfs.o.hch
>> 1322832	 112183	  27600	1462615	 165157	fs/btrfs/btrfs.o.dave
> 
> This was on x86_64 and without any further changes to the
> extent_buffer::pages, right?
> 
> I've tested your version with the following diff emulating the single
> page that would be on ppc:
> 
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -94,7 +94,8 @@ struct extent_buffer {
> 
>         struct rw_semaphore lock;
> 
> -       struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
> +       struct page *pages[1];
> +       /* struct page *pages[INLINE_EXTENT_BUFFER_PAGES]; */
>         struct list_head release_list;
>  #ifdef CONFIG_BTRFS_DEBUG
>         struct list_head leak_list;
> diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
> index 8260f8bb3ff0..4f8e8f7b29d1 100644
> --- a/fs/btrfs/struct-funcs.c
> +++ b/fs/btrfs/struct-funcs.c
> @@ -52,6 +52,8 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
>   * from 0 to metadata node size.
>   */
> 
> +#define _INLINE_EXTENT_BUFFER_PAGES 1
> ...
> ---
> 
> And replacing _INLINE_EXTENT_BUFFER_PAGES in the checks. This leads to
> the same result as in my original version with the copied blocks:
> 
>    text    data     bss     dec     hex filename
> 1161350   19305   14912 1195567  123e2f pre/btrfs.ko
> 1156090   19305   14912 1190307  1229a3 post/btrfs.ko
> 
> DELTA: -5260
> 
> ie. compiler properly removed the dead code after evaluating the
> conditions. As your change is simpler code I'll take it, tahnks for the
> suggestion.
> 
