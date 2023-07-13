Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E3752049
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 13:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGMLnL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 07:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjGMLnD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 07:43:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DC62D5D
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689248521; x=1689853321; i=quwenruo.btrfs@gmx.com;
 bh=xxHgFrzYzdSPA7cT/6F0GkhxL63FbvDSBOjRQn57Pyw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CJatrKSxRy7wuN+LV0F8QbBOuIb+v0UrXizW944qGvbg0FAGl0X/w6h/6+hapQ6LzPUudDk
 /rVYUNaWcebxF1wtmjFFwh/IZc67jBpQnL9E7y0B7xOLrsg95FHSJhzFbYTGWOHI/0hTWFmT8
 1HzFkzb7BOiF/7dEjmt+TNgP3nPFGp5RgHJBZBxH62zk74muEMT0W4k7KdKVcw4MOCExo4YRu
 YQgODNAJxaJCZmVud1Fh6+nq6XllYXg8zw/Roys9w38W0gRHWt9+ixA5W+batfGzJfmj3OVX6
 /ccKc5Do6X97lDZ4O+NOqwfolPqa9sbrzlbpeRLLk5dH7Bd7kYgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf4c-1pbC2M1SoU-00ihjz; Thu, 13
 Jul 2023 13:42:01 +0200
Message-ID: <4d46cb42-0253-9182-3c61-5610c7f8ff89@gmx.com>
Date:   Thu, 13 Jul 2023 19:41:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org
References: <cover.1689143654.git.wqu@suse.com>
 <ZK7XwgBJZDpWFuz6@infradead.org>
 <ff78f3e8-6438-4b29-02c0-c14fb5949360@suse.com>
 <20230713112605.GO30916@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230713112605.GO30916@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VRgtbJmRdPIvTqREOoBH9kDUuNLfYEmAMaInr0ZH1TVgWb+Grq0
 S+I0z1hg03jmwTS3bKeaPmLHXjhXVhRP42MteAewGqLa+zyhZ2Y4NaNcWDQCpBC2nYiTNip
 BTe22GIkpd95Aa1c12gM8Ny60080LIRgyz6RKkJBN9u5oyrzVuiekvU8qiXURor3hmFE5xL
 tPZWezNBC4c3ZRS0bic1Q==
UI-OutboundReport: notjunk:1;M01:P0:AIPsJmyPrYg=;ufgLK6uVFCly0uz6G3tzQJ9mBxS
 0TOzQ0cAPPdGAlP4Peu1NDze5g4sfSblt9SZZehzO1ESWtvPCSVtyrA1kRDhKUnsZt9+XI4jq
 qIc5/SHivuTt7l6wGTWvJiqxd3XE6fGZpDbRL2x75ASmwanhLMXw3RyxXRpbUKrknfTo5A6Bz
 nixaVH5J9F8UjoEdezQ0Uz14qTZ+Gka81GT7KlttdGdptQvfTLqm7fQO+Oq5cloPy5O3lfneP
 tBIXmDKcQC7C1uwW+CqLleFRyu3sxPZ20ZVqPUh/HmjHVjgBRn3gm/k/RFa6A413D9jUxj6QH
 PfLp4LCRrSnhtc4Q9K5nTNQRMR6mWliIqlRr3eWkgoKtsBETE0+bo54NB6wYIvnNmf0947nYu
 iF5pVHp/aYtztCK78Go7dNokDN0JS/fpuZSj6V0Jw7lZNXM/Gsz9Rb2m0GwdeYHnFdd5JbsIm
 /Sk5CR8xemZrSvmmB0jYY2/uNKKWp55aWavIPLmQ53L7/yQrJlFNeJvdJVToNWrRELz2OrSGV
 TJScRLjXAyDh69imCM71ubVQ6WEZ+Fm884i6MZ8zJviKOgHXnxBAofT7CSDsOrE5MjdhgnBJr
 1Ea5nZqBcXmT6Ehzh2yad7H9X4v9T/ABHYN4626ZUPFG5Ejtvy9zWVVsdmgOZGZLYzFufCuA1
 dUMSHdK39SSdVB+5iqa+8Hfulw5zvpWZl9bmH+b4MFN2VKQVF6l1usRMd4eSqHhUyGJDOhACP
 bDToQZ26dQKmF+LswaFtacC6V3paODtnMbQqaoP3nLDBlQIA6nnL9npZJmDnlxU16VyCqBNq/
 Ht4P2AAboe2fLxrJzEXA+s57iC0f3b+zEklxfi3gTFftHX/upwfHKu8Tg9DpeRqErKHMBndVu
 1i6vgixS9lQDp3tJoIpBSTUvAsfSzFT6fWK8Np36BNUZQlDY5fpvW/9WktYU6eIirTln6DiVO
 vIUNqvZ69TmvatWNY0xmfegEbsQ=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/13 19:26, David Sterba wrote:
> On Thu, Jul 13, 2023 at 07:58:17AM +0800, Qu Wenruo wrote:
>> On 2023/7/13 00:41, Christoph Hellwig wrote:
>>> On Wed, Jul 12, 2023 at 02:37:40PM +0800, Qu Wenruo wrote:
>>>> One of the biggest problem for metadata folio conversion is, we still
>>>> need the current page based solution (or folios with order 0) as a
>>>> fallback solution when we can not get a high order folio.
>>>
>>> Do we?  btrfs by default uses a 16k nodesize (order 2 on x86), with
>>> a maximum of 64k (order 4).  IIRC we should be able to get them pretty
>>> reliably.
>>
>> If it can be done as reliable as order 0 with NOFAIL, I'm totally fine
>> with that.
>
> I have mentioned my concerns about the allocation problems with higher
> order than 0 in the past. Allocator gives some guarantees about not
> failing for certain levels, now it's 1 (mm/fail_page_alloc.c
> fail_page_alloc.min_oder =3D 1).
>
> Per comment in page_alloc.c:rmqueue()
>
> 2814         /*
> 2815          * We most definitely don't want callers attempting to
> 2816          * allocate greater than order-1 page units with __GFP_NOFA=
IL.
> 2817          */
> 2818         WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>
> For allocations with higher order, eg. 4 to match the default 16K nodes,
> this increases pressure and can trigger compaction, logic around
> PAGE_ALLOC_COSTLY_ORDER which is 3.
>
>>> If not the best thning is to just a virtually contigous allocation as
>>> fallback, i.e. use vm_map_ram.
>
> So we can allocate 0-order pages and then map them to virtual addresses,
> which needs manipulation of PTE (page table entries), and requires
> additional memory. This is what xfs does,
> fs/xfs_buf.c:_xfs_buf_map_pages(), needs some care with aliasing memory,
> so vm_unmap_aliases() is required and brings some overhead, and at the
> end vm_unmap_ram() needs to be called, another overhead but probably
> bearable.
>
> With all that in place there would be a contiguous memory range
> representing the metadata, so a simple memcpy() can be done. Sure,
> with higher overhead and decreased reliability due to potentially
> failing memory allocations - for metadata operations.
>
> Compare that to what we have:
>
> Pages are allocated as order 0, so there's much higher chance to get
> them under pressure and not increasing the pressure otherwise.  We don't
> need any virtual mappings. The cost is that we have to iterate the pages
> and do the partial copying ourselves, but this is hidden in helpers.
>
> We have different usage pattern of the metadata buffers than xfs, so
> that it does something with vmapped contiguous buffers may not be easily
> transferable to btrfs and bring us new problems.
>
> The conversion to folios will happen eventually, though I don't want to
> sacrifice reliability just for API use convenience. First the conversion
> should be done 1:1 with pages and folios both order 0 before switching
> to some higher order allocations hidden behind API calls.

In fact, I have another solution as a middle ground before adding folio
into the situation.

   Check if the pages are already physically continuous.
   If so, everything can go without any cross-page handling.

   If not, we can either keep the current cross-page handling, or migrate
   to the virtually continuous mapped pages.

Currently we already have around 50~66% of eb pages are already
allocated physically continuous.

If we can just reduce the cross page handling for more than half of the
ebs, it's already a win.

For the vmapped pages, I'm not sure about the overhead, but I can try to
go that path and check the result.

Thanks,
Qu
