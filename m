Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D32545A3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 04:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbiFJCqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 22:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbiFJCql (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 22:46:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDAB278336
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 19:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654829183;
        bh=DSnd1kxJC6XqQkm7p+/O3eTCrsKFFsvElFVV26Lz1d4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=PlwPrzLuJHNE8wajEuhLc5mZF9O2wrqNx2DWPBndbEpT0NQdbgyxvHisgrIf9YCUN
         wNg76pRiF13+aKQ6Dlkm1kofbm2R8xC0vinT2T8MiLiwJPWYtucItnCvN4YBDKntyC
         fNzPMyKfEi36nVO+xXyoyKWd/JYmgYYHD+x0Ep+o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zBb-1nd6Rp2oPj-0153kT; Fri, 10
 Jun 2022 04:46:23 +0200
Message-ID: <60abd620-0ec0-9ab2-74ac-8fc06e21d193@gmx.com>
Date:   Fri, 10 Jun 2022 10:46:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        nborisov@suse.com
References: <20220609164629.30316-1-dsterba@suse.com>
 <17d8d373-f836-5d23-2939-d9dfcb65ae7e@gmx.com>
 <20220609225906.GX20633@twin.jikos.cz>
 <YqKhCDu0tOcdGpKA@casper.infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YqKhCDu0tOcdGpKA@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PESe/RI4LQPEVP4MHhZnKpc0ph5JZ6rEEV6Iv1OMGZOmVQD5Ao5
 f+W6Pc+EsF8GNBy8xTALm4laoHFwNgQxOaIiCTZU4Ev8/vYiJNsOl8iLLPt42mhL//SVqsb
 wEPRg7vQTz1/HkC1j+gcn0LDX/9U0f2fhPl0vSI1nBOlHuPt1QyzSRuCn1do5Nz1yLFlGGR
 ZmuTwfPZHu80xh7HIEOMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QAALB7v5IlY=:JhGO7wLCa3wmi8bM6yhbbJ
 7r8SqwXffE4QkObvWQ5N+kPdicxAajyCsw10w6ixhouJg5MTgPnYNBmzADzABHFP6y6dP5DKN
 QYj5s8LSB3gG/kKD7RqA/zWXrOomgn9626e2jJ6HbjSqfJWvGXX6JGdwsTrpCfnvDbATB+AwY
 InLklIXN9ljGPLz3j6236twEpfwi6GAOM3eiZcWhij3EuI9MR54voiczxTVxJ9Wia/BFKPO3r
 UbYavIGR59SIr1745K1ItDR362KyL6+7G0zEe2moRTl0q16FdsbP9BvWrMoDv5oOB41VPzV5k
 1UFjqyt5F5c88LjAVe7JjsHf87kZjtnT3szrEm4tCCO6fqaV8HOzM1wsrfw2m7xzVDidaG38K
 4n6gtTuWmG4pOQZqJA+SPjr3Uef/0c289fv91qcVk0wcAmaSzNQqR18ysQwqe4YKsO48TGWMz
 bZL5oxWqjzeDG61fd+gjdQIQ1J4caX/h3Gh5lFgc8MG7zlnGEj2UKfkR6JMBs2uz66VTx7DL5
 OA2PgaOMdZTkD3ehaNVGQi9CWTxfwf/8bKmuRZ6pPn1P2vJ4MkHE2NFqthO5ZyJKlotxEtEP2
 p8VIVAbl8lOcVV3rMtvaE5/CZN4Gr8219w11D2ib0qJtVSlJo4NWlrzF77nrPqinahme78qeW
 cvnpIcEkBpIr+AKiDoVD1OHDAJ2yU/R8EF+wkE9RJRpJgIauPzItcb2qahaV03mEyJOEpulXl
 UmxyG/lVYsNtWkRbhzkMS5rq42JMSe7F72coelCFchLhwFnt+3fBFb+lz6KNosS/PLqdshuqb
 0TXszi2h2owz2JFFFmzMLYx7piihnOkocMATVUCc3pUqOb62tZ9jihUEUYh/NFiHFkb7fMutu
 jninXnM6s5wTVWaFfWnlvR6yAIeKq4nfouc1VfNfHpAxy1rE0k6TKzveW3Cij7NDXSIHM4s9T
 JozEUQIahKAWoFN+Os4hCW2g5+EYbYs+3zliE5mG4MGRploBAhtwhkjAv8Ld3Pol3qv943Jv4
 YYuDU/DTUSenJlrfBItwD8O4YTArE3yDkrp47p9j4IiJqef0QuKuMHvR1xz1S2N8gdpinHkGW
 VmM4Ea86mk3flKHwNsecEXKp7apRIswffW0WPjksyLwjAYVtjtMJn5d2w==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/10 09:40, Matthew Wilcox wrote:
> On Fri, Jun 10, 2022 at 12:59:06AM +0200, David Sterba wrote:
>> On Fri, Jun 10, 2022 at 06:58:00AM +0800, Qu Wenruo wrote:
>>>> v2:
>>>>
>>>> - allocate 3 pages per device to keep parallelism, otherwise the
>>>>     submission would be serialized on the page lock
>>>
>>> Wouldn't this cause extra memory overhead for non-4K page size systems=
?
>>>
>>> Would simpler kmalloc() fulfill the requirement for both 4K and non-4K
>>> page size systems?
>>
>> Yeah on pages larger than 4K it's a bit wasteful. kmalloc should be
>> possible, for bios we need the page pointer but we should be able to ge=
t
>> it from the kmalloc address. I'd rather do that in a separate change
>> though.
>
> Slab uses the entirety of the struct page; if you use kmalloc, you
> need a separate side structure to keep your metadata in rather than
> using the struct page for your metadata.

Any idea what structure in page we need for this super block write scenari=
o?

Currently in btrfs_end_super_write(), it only handle PageUptodate and
PageError.

But we only set them, and never really utilize them, resulting btrfs to
ignore any IO error on superblocks.

I'd say it's really way worse than submit_bio_wait() and handle the
errors properly, and forget the parrallel bio submissions for sb.

Thanks,
Qu
