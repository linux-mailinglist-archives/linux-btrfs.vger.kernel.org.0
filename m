Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34B073B0A2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 08:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjFWGRa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jun 2023 02:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjFWGR2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 02:17:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846051728
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 23:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687501042; x=1688105842; i=quwenruo.btrfs@gmx.com;
 bh=Db52mf61xgyInTPoQFDp+58juNIzD3uSRXZ1vIPjlTE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=iTXLCqh0HxF6jZaRhtyzvKBYRMnLAVQR0Y/uPoaEgWYuG2t1YAt7cj8FDC3L42qbZ0Hv5mx
 bu5cV876/KHp84hXNTTdRpLY4ayfQgE9G4IMNti8wS0f5xM5nd5EihJg+Af/Axil/+lRSR8V4
 YVP85i04S48oE0LeIH3QDBXUCF/zH47qo36C0+0SG+ls20fqZYtPTrs0iifVCuToLLzLnFpX7
 BFnhtL1zx1ampLmkLeL/9yGNe/IoQ9viaCnqvrF2wp6uv/+CQPNrZOc0HicmGz+56TZoZD/bp
 x22CcLviOaowKiq+rmTalrrpFfR7cQ1JNoFzm2K7xhe3KMsqrWSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnakX-1pkuqz0WTV-00jcSg; Fri, 23
 Jun 2023 08:17:22 +0200
Message-ID: <21ac5eab-ef7e-5b41-8d06-332a1485801b@gmx.com>
Date:   Fri, 23 Jun 2023 14:17:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: use a dedicated helper to convert stripe_nr to
 offset
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <10aca1661eee22e6a74ecab62a48227b51284ece.1687416153.git.wqu@suse.com>
 <20230622143730.GU16168@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230622143730.GU16168@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fWBaHSnuOhilibpXVhq4GSe5TF9LHaG/F8lby3mnk69+MdsIGiR
 Ch2elnNQ1ZJA6BqewTLeLk2nKE7kWBwIYCTOkwUg7t6Qcs3RL4hFUY7ie7+XhKInUyznPdB
 URTRIFB826V2iyrm3BBYicZ687RECFo8jiM5QeQopjbIEBRzLimUOzTWAS1BnylHquMYduX
 COUDwMSc3eSV3BKn9p0+A==
UI-OutboundReport: notjunk:1;M01:P0:nHaOm+xSbDs=;MB+ddJd+OZ13/XFneQ154q4yTsj
 UaEhN6IimaTDWNpcCiImM4e2KVAD1CSNnbdvtlGhgh+VcQn6/Fcq6Ktp+vG/khZYz6asBLvME
 vu079MMFgziKITBYb7oIdDLLmczhnOkdYBoVMRJAA/IYYnFxOALYxlVUd7Pb8Fj/HOEhhtkuS
 FlU5d5t3tIzkdmF191SnD9E3ieKbnL16461XgSZ5Z2V813S++k2+uZeQKcsDDRfmCJl0RWGZt
 sLcTbRreo7hxH5LFRKPJSGFfESChkAtnbV0wE7OVP9QRtv0XbPUQ9aUSrGrztuDMAO722amdV
 CumgRG4sgHN5qwwAqPZXVzzpxeJXAd/UgjrIXxvgbt5o63qZGEHkYXv2VqJz+qT41XPEPMXi/
 AUfnBeUiL1NWzPYPppiuUw6PIKxEk6DNu7dhnMeNmAKkfdC2HcPBoWL0gx9WnHF8zD6BRf2PC
 5w5uAcwtgKJzOjZQyumfzJbr9pUt0OezhNBEXpkrkGCsRkOoAemphPfSV8GO3zGdYp+RF8lov
 5fkISsDyKSLVgVYusxMupjilkIbxmd7wsO3/Q2JmTJbOhvfMNidQaD/9q9S/j8hIUuBoYPV28
 +ItPfjSZCnGHlyuDqbAUwcoMMa+vxOdCO/VjqQgBnxe54v0uh8DpTW3ZlneZZWoGe4lEOo6w/
 mSxAeBEZJduHpSHj9eO9YpM/JYF2NZHCFF1yyyrTUCpTT+MNdWVb+zO+DuyQifRMCphqcjqhc
 lmOXN9YQ1bTiz9w0NwNNCd9JyviA9V5cAWWOgssc98DvjWrSvjkQzdICvf3rJsVu1us25/H1x
 +rF0yoXKOYjlLC8938YzJmSzjqPUFud3U4jH8iasCZeks4FatrAPFp18YGJP67Fe0uVbwSNjp
 V1fP9kmR68oYqtk4m4F7le6A5wnlJ+mbWRsEpT3ZDK4mNlfCl4doxBU9QXC3BHy99ODkBGvnV
 l1b21Cjj0y6u0fqEMhUVGwYzJdc=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/22 22:37, David Sterba wrote:
> The subject should be clear that it's fixing a bug not a cleanup.
>
> On Thu, Jun 22, 2023 at 02:42:40PM +0800, Qu Wenruo wrote:
>> [BACKGROUND]
>> We already had a nasty regression introduced by commit a97699d1d610
>> ("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN"), which is
>> doing a u32 left shift and can cause overflow.
>>
>> Later we have an incomplete fix, a7299a18a179 ("btrfs: fix u32 overflow=
s
>> when left shifting @stripe_nr"), which fixes 5 call sites, but with one
>> missing call site (*) still not caught until a proper regression test i=
s
>> crafted.
>>
>> *: The assignment on bioc->full_stripe_logical inside btrfs_map_block()
>>
>> [FIX]
>> To end the whack-a-mole game, this patch will introduce a helper,
>> btrfs_stripe_nr_to_offset(), to do the u32 left shift with proper type
>> cast to u64 to avoid overflow.
>>
>> This would replace all "<< BTRFS_STRIPE_LEN_SHIFT" calls, and solve the
>> problem permanently.
>>
>> Fixes: a97699d1d610 ("btrfs: replace map_lookup->stripe_len by BTRFS_ST=
RIPE_LEN")
>> Fixes: a7299a18a179 ("btrfs: fix u32 overflows when left shifting strip=
e_nr")
>
> The patch was expected to be based on commit a7299a18a179 as it's meant
> to go to current master branch, and it does not apply cleanly. I will
> resolve it, a few hunks get dropped and no other places need to be
> converted but please try to make it smooth when we're getting last
> minute urgent fixes.

I was basing the patch on the latest misc-next, shouldn't hot fix also
go the same misc-next branch way?

Or hot fixes should go upstream instead?

Thanks,
Qu
