Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDA54E7BB8
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Mar 2022 01:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiCZAOl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 20:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiCZAOk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 20:14:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E364A1CABD8
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 17:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648253572;
        bh=3+4qu8dZTvh1sP8S7f58wm0mGMyMuJu1XjuimQ00uPw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=i4OPOWycorKigoRXtWASbVaXU7Xo/FMRHeALk5x0vxhAphKKm79RgaZizYKNAPDk7
         Kf76aChoiJ3hlRl/SSHxr340btVAbbTalbcSdcfixRlri2GsRUGXVyUKyzTza1Ze5C
         bSOAnc0zS8nLQZTydQVkYDvKw/ID/xbrwH4yxfyY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiTt-1nddlu2Esn-00U3JQ; Sat, 26
 Mar 2022 01:12:52 +0100
Message-ID: <586ac777-1cd5-f45d-9e7b-1c1d337eedce@gmx.com>
Date:   Sat, 26 Mar 2022 08:12:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 2/2] btrfs: do data read repair in synchronous mode
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1648201268.git.wqu@suse.com>
 <1b796a483efa008ba5e2090621161684b3c4109b.1648201268.git.wqu@suse.com>
 <Yj2ZALUKtblRSaxP@infradead.org>
 <dd03a779-f996-4e45-e06e-f75acea97ff7@gmx.com>
 <Yj3xHarLow3FRMRR@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Yj3xHarLow3FRMRR@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aRlLPwzd17x0+2PkBLpSbWTsKRpnVyGMEDLd75yNfdDy/VBb1mb
 bULF2BQRwH1gaX1uJOVS2X0SUvmIBiW4IMdSPHKTmyko8mzo2lmVCeSOxW/pPVpQfTMzLdm
 RZp3uTZXc1U+pls+Hvl3pinp2zeiBjU0gzCXLJq2dOCtFbwZj9L3A+oXFBWFfztbNYaOSFE
 EDlmMTNUYiypyAJnCbxmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o2EtiT68IqA=:pbL4Gyy8GfIZs/Fk9ql1AD
 7BQfrTfTmKhKkihgpZF0OYIAcrNapP9b8MoJv2+Vk6equUvOfPp/7O+SNfo6vb8KaQpfiioim
 +AnMBiyaCo6WeCrjUWePRVnz7ujZK1HPgjClehFjzm744JVyh6R/0HwXGj0iHyIZlonh/0DLY
 FH95fuWnCHpdla7XFND4dRGtq38D2pEE6qqxN5mmLH22566SLuVkKuw6kERYKNXGBWTjuySq8
 RvB9xHNMub1CqY6cR4Uw1vi5mCN6l9bM3vqBN2RbaRVYmzJcTXebbr7Zn8IcXlatJyjyMDoVF
 hBh3x9VPUUPtL2O2eWUyJRFkBiLIwWTfBoBvRzrz2ZLQZXMYbt008nP4E6M5KsxiIT8hss+2E
 N48y/7w2DRM22MADZwc+Ak4JhxWIG15+vjpYBslb8FqNlEfWZMVgwlV5C+V3W128MC1qbzo4B
 u5CK+pCbdH2mk95pLyLNKOsNQmRxtERwftFtpcqSfLyy81nVls5YWwR9rp0FUJBnWnLCrf1vb
 dBk3a91nQJQ29Do2VljLE/g2upCn60zfBVsFYjFxEExAxYc4ftK0LbglWH8jQtIKOMvlMVI0O
 JkgxMFT+PKsyo/iFRnZoSJdvPWEwKiqMoz0ifZ+qvuyvAnZHPJx9W8x3AEfRnaEWU4AzMpR1D
 MALopQB7ZErMYwLsAjxVCBhIrA/DPsoA19i1zSU9fhSrF6ugJZ9gm1HWCWtyo6ZKmGXmcScDa
 TyXOTgE0a89JLw5q4Coi96suNYG28MXRxH2DoOrTkHFBDBujzVxeRAi9Mff6+6Owwzv72VCfm
 rJm/15uhkBDFHxf5YgGVfXEFf6pY/EViQ9CoR+c6+E1kVVxe9IJRRYixbBt9IVrgQr6zW7CJa
 xQsZp2sH5ccnTTgTZeUbc2lPS1h9rCi5y1IvJQI+aLHJl6u3ZBWpj4A6RYOPZcOWAEB7vYhe9
 z1Jx180tmWyqf9oR0GF5dXmH+G/0tPIMk52X7hFs/RW/pNTBewIgROLnXZNmj9m434zJaNAmj
 W8KG05RM9TTvBlBFn7k2z8gmpD5LrQFT2XzKnrXVORIwRhbwhF+rhvz51MEUljGDILuuVI1od
 JJ24czrf/4zKrk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/26 00:43, Christoph Hellwig wrote:
> On Fri, Mar 25, 2022 at 06:53:31PM +0800, Qu Wenruo wrote:
>>> I'd suggest to at least submit all I/O in parallel.  Just put
>>> a structure with an atomic_t and completion on the stack.  Start with
>>> a recount of one, inc for each submit, and then dec after all
>>> submissions and for each completion and only wake on the final dec.
>>> That will make sure there is only one wait instead of one per copy.
>>>
>>> Extra benefits for also doing this for all sectors, but that might be
>>> a little more work.
>>
>> Exactly the same plan B in my head.
>>
>> A small problem is related to how to record all these corrupted sectors=
.
>>
>> Using a on-stack bitmap would be the best, and it's feasible for x86_64
>> at least.
>> (256 bvecs =3D 256x4K pages =3D 256 sectors =3D 256bits).
>> But not that sure for larger page size.
>> As the same 256 bvecs can go 256x64K pages =3D 256 * 16 sectors, way to=
o
>> large for on-stack bitmap.
>>
>>
>> If we go list, we need extra memory allocation, which can be feasible
>> but less simple.
>
> Just chunk it up so that only up to a reasonable bitmap size worth of
> I/O is done at a time.

But it can be fragmented. Thus even we chunk them up, we may still need
as many submission as the corrupted sectors.

Thanks,
Qu
