Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB5D4D0E7A
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 04:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244692AbiCHDuM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 22:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiCHDuM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 22:50:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB8831236
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 19:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646711353;
        bh=79EMwZMkq6BEDRvAtv21uBB2NbZwD3M+IWWTSQln4sA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=NevS7pkfybRdfpYyWab9eA/DtLPBcJQNm+IaV2kPHtAFDyjRBPRh/xBIlnriEWVIg
         pKqZdW0ttgKbpH5FDEhA8zfoGzb9Xtl7FdvRXZV3DSZ/h89GSLnwwCkU+p+Rb0W095
         ZS1IGSm0u6oLKx20aFHDNrJrQCQFdzOjft1SpCnU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N79uI-1oEklQ1AOC-017RJN; Tue, 08
 Mar 2022 04:49:12 +0100
Message-ID: <d8a6c90e-ca77-dcc7-9312-23f175101788@gmx.com>
Date:   Tue, 8 Mar 2022 11:49:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/5] btrfs: scrub: make scrub uses less memory for
 metadata scrub
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1646210051.git.wqu@suse.com>
 <20220307163645.GJ12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220307163645.GJ12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kgB70VcuoJp/8M0QMx01ttrhq5LFQEic7KI14xL2G0Hm0IIachh
 opVW522Z5ljrXoWZch//TS3pbxBO7AVoGWmvs8vp/sfNUKBXuUuxwm+9xrlDVnQ7tLTai+f
 3k0++so3DXZetj84ejo18SQPBYYMTN9R1SEqtKVXzhtakr2uA5/cEz1SJAoN4gcZTerpVN1
 8h4NC8bLtok2RNb3OD2IQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EZ3tNtpudH0=:euA6zgyD037QQv7fiJulCb
 QYC+S6CBpA9RmQPYbqMxkFMXwUsNm7UWjZczH8poGYysEwJN11HhgzRC5b4mfx7dJtWKCs2BB
 p6GbunYH5v/uILDc18q/tLIfT5VfPFQcowOKjcLyfrINDtOirJrAb7Ros1TS0/ljgmUS4IO0x
 p5u/wGfnxoz2qG3kCm6FLpX4Nse6NYlJyfEHtin9++7iA9fr4cF91hAPPcTYpCLi9sySaD4U7
 HMe/5Ec0zjKP/SoAuvnXpQRUxN2lYQ+JTvLLDxayhDTyBEj19CHjF+IfrDRamb32az3tAn/kE
 Ve9jmKEe6oDcP/gZp7iPkB/nHNNg5iGblC1aL5y4T0EytbbWWyqAc0MrtCZwlPcmgaLHafsKD
 GF+EBKdL1cA3N/hu9t7eobh2be/lxiisY2r0M5ziJHHmeLjFlq+K65c6bvTGuav75oHyviEZD
 DCDYyAnOdrxz/AkCw/RgTHyauUIRhnsL1tyFBZJvSmbwTY6I0p6i2SWBO4256t3Udo0R3nFU2
 D17yJUXAFYvMGCrDHuMegL/ZRONDte3+fEutW8m/sFsn4960Yv5hmtAD2sMVMVAww37B2PE2v
 nmWQfJXUVWNH6QmPKvwatS6fzZzPeDdNZS0jZOK4LI9//ZhSRJBqa5gI9do5nLuUfWNTlu0zu
 UFm83GRdtC4iv6yjAP4meTcHajydGcVoOUzPjKdkBlsDERSwlbWK/nhcUAto3t8LaXnvxXH4m
 3Cf/mjWJ3oUQZu5s7p5vxbLbUe6iuHDppKMJDw+he8Todrne7PVdo/8ptNK7tNZIy9T0n18G2
 LSYmowaTnlJQuXs33BUmCUdQ8sC7MBHrXnnvy4dcenXM6ZDpXrO0KGUnEycpF5HMgpZr1RLJs
 8G4TU7KIFyS2EzHAfjK3KyUxgfUUYIcUBgPkaQlg0HeeKKImxocSvsgze/2cJBcR3GR/+YOgf
 oF61kb85UXaUHZepq3kpAA5tKGnoiVUUNxs/Xzj2wqpUevAqHIEGRBXaKpkOFSPPnjeI/gioE
 ameKC5ZyPr1sh4mfDwHCR7UXnj2ccYCtlLbmcwLQiWkXYdMyfQliTLY+1BODUwnyYBi56077P
 97g3X7kSFw9e8s=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/8 00:36, David Sterba wrote:
> On Wed, Mar 02, 2022 at 04:44:03PM +0800, Qu Wenruo wrote:
>> Although btrfs scrub works for subpage from day one, it has a small
>> pitfall:
>>
>>    Scrub will always allocate a full page for each sector.
>>
>> This causes increased memory usage, although not a big deal, it's still
>> not ideal.
>>
>> The patchset will change the behavior by integrating all pages into
>> scrub_block::pages[], instead of using scrub_sector::page.
>>
>> Now scrub_sector will no longer hold a page pointer, but uses its
>> logical bytenr to caculate which page and page range it should use.
>>
>> This behavior unfortunately still only affects memory usage on metadata
>> scrub, which uses nodesize for scrub.
>>
>> For the best case, 64K node size with 64K page size, we waste no memory
>> to scrub one tree block.
>>
>> For the worst case, 4K node size with 64K page size, we are no worse
>> than the existing behavior (still one 64K page for the tree block)
>>
>> For the default case (16K nodesize), we use one 64K page, compared to
>> 4x64K pages previously.
>>
>> For data scrubing, we uses sector size, thus it causes no difference.
>> We need to do more work on data scrubing size to properly handle mutilp=
e
>> sectors for non-RAID56 profiles.
>>
>> The patchset requires the rename patchset.
>> (https://lore.kernel.org/linux-btrfs/cover.1645530899.git.wqu@suse.com/=
)
>>
>> If David is not happy with the big change again, at least first 3
>> patches can be considered as some cleanup.
>>
>> Qu Wenruo (5):
>>    btrfs: scrub: use pointer array to replace @sblocks_for_recheck
>>    btrfs: extract the initialization of scrub_block into a helper
>>      function
>>    btrfs: extract the allocation and initialization of scrub_sector int=
o
>>      a helper
>>    btrfs: scrub: introduce scrub_block::pages for more efficient memory
>>      usage for subpage
>>    btrfs: scrub: remove scrub_sector::page and use scrub_block::pages
>>      instead
>
> Added to for-next as topic branch for now.

I guess you replied to the wrong patch?

The for-next branch only contains the scrub entrance refactor v3.

No the renaming nor the subpage optimization.

Thanks,
Qu
