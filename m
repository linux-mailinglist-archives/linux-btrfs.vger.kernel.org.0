Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8939B4E7C10
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Mar 2022 01:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiCZAPX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 20:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiCZAPW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 20:15:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC251DEC25
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 17:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648253618;
        bh=2peNRaUi10q0ZxxD2yy/LA/sUPwUqSCn7ionmSR8MDk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fC0CQbZZXISpFojJvRkE5AnpqRCJCoD2gshvzlJxIBUpfPIg6dOJr2UOf8x7WRT9L
         ccK0capXLyWgOy6uaLgY+Gb7r9M0YH8dQz5msTNVpSWD/Yq3sT4l/f/pLnNMk/+84G
         AgX36+a87N6NzCBwoPQ/ZN42H67fgcBwunm2rNCI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QS8-1nTUCv1W2S-004SkV; Sat, 26
 Mar 2022 01:13:38 +0100
Message-ID: <84178851-8c88-dea1-1d0e-844b6ba7bb7c@gmx.com>
Date:   Sat, 26 Mar 2022 08:13:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 2/2] btrfs: do data read repair in synchronous mode
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1648201268.git.wqu@suse.com>
 <1b796a483efa008ba5e2090621161684b3c4109b.1648201268.git.wqu@suse.com>
 <Yj2ZALUKtblRSaxP@infradead.org>
 <dd03a779-f996-4e45-e06e-f75acea97ff7@gmx.com>
 <ba5e64e0-8761-3cc3-e3e6-c78f02ab4788@dorminy.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ba5e64e0-8761-3cc3-e3e6-c78f02ab4788@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f6iK8M/InKUNC1mM4BuWkBO+PlU3p6p4q+cMR7OcL4ADWh+1mRh
 JD1XRZmgDoWX5MQfqvj2ztowE+ZlBeTWrx/5SdPTaK+K7eTYvvzVQBqjBMUaueq3RtDiZXf
 WLf3bJ1sLUxuNOc+XPG00CVA7Yhy1Si1gwC+KNZYwWFlZnskThgOWTNAbrTiOS7/P/srS7W
 ZQUTqRvmsjNVzGP4oKRqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+a26/qzwfeg=:Hxe0kyZvKDrSQnORaOl93f
 g1e3x9m1B141I/fr5pPn1j2qw8wJn+vR/zsEUZNA9gFx9g/IwIsF7radlq+jpld1f4cQztURk
 ECDBZZkBcuev8swRSuYW0uKzGW+ZzSI8PzVVek0m7MzeIkequvj0oQFKYkM9TdDD03zZa1zMQ
 f6h/n6G4+MVqHUXpio2/QNXvxaO4ZQWWFyi60lY97Dikd1jZHFJdazJZmSW2RFWUYLY2ZSCe2
 nArWyYFKhIxOeMzbyOaROBsatvSHZD4G7PMq13dMYeuSVNL6lW6woTeEpaPp5cNlcK0/Nyl48
 q2KyJdF3vOhPGhOuxjzs5XCFwU3Ni7B6Bbyu1hsE+K/2tjLByGTIEbsB8Vv5TNhE7AEv5wuRa
 43KbnCMMXItnXZbMApuge6tE84Fk1sdRZAYt6L9E3H8I9tBGAimDVjb2uSN+srzob4Zd8MFkK
 653TUl9l2B8oRk9J1ahGBWhoMBdsTqRHM2OXK1+B/rSTWgMdg+0J+bZgN9Po6Xs5tx6mGGxq9
 9gGxDw9yCxaAltES6e/xq3YG7F63NFjRlLohwPgcR1q+eGj7gcLfRbeZIHjwU9+2xJ0rcLcPX
 FNNzCzjKQiD/ZK+uiFHZV5sM/BV9FsOcVLTtGhrnHRAIQvB5aF3anCFGVISTGm2GZCLF53MeN
 B6ElqxafzMWqiBhDZL1LoZSS1Vw3M80+EyAV6FQ9Rqk/6P2I27mXVGKFmo6wWX5ufbk0gQoK0
 1B1r0kN0bBBX1DcujF34HFYmYryZuCY7xdek14hIRLjT0fl3PV4jncxstcOsvZ7HSqVrgGpzJ
 mv683FuoRHRWKMPqe4E/Fp0qXF3EpBiWr3aipILyQwHkSvZHQv6hhjHPkzR5xJ6amiAfAAZtt
 5wmPlO2bPc1xfwFf2XliEl2wiauLyJELmmItlpUIBqr8oFuTFj+vkEQO5BuUWuQ+sJVJGnlgy
 ihvxwu0drPNBbpNCwY0sM8B1t77zU4ywKlRxltI2Wcefi7tP2lljQofPiWTPEkZAqVp9p8sC3
 1AOUsGaduYYdnuvK4atyGBEvXhgt/gM/WXqZGHRj154Ch3HoYsSmoxC6oW0wP1Ip0TTDvIQn5
 +wwlIBOEbDjQX8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/25 22:58, Sweet Tea Dorminy wrote:
>
>
> On 3/25/22 06:53, Qu Wenruo wrote:
>>
>>
>> On 2022/3/25 18:27, Christoph Hellwig wrote:
>>> I'd suggest to at least submit all I/O in parallel.=C2=A0 Just put
>>> a structure with an atomic_t and completion on the stack.=C2=A0 Start =
with
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
>>
>> But not that sure for larger page size.
>> As the same 256 bvecs can go 256x64K pages =3D 256 * 16 sectors, way to=
o
>> large for on-stack bitmap.
> I'm not understanding the reason why each bvec can only have one page...
> as far as I know, a bvec could have any number of contiguous pages,
> making it infeasible for x86_64 too, but maybe I'm missing some
> constraint in their construction to make it one-to-one.

Btrfs doesn't utilize that multi-page bvec at all.

So still one bvec one page.

Thanks,
Qu

>>
>>
>> If we go list, we need extra memory allocation, which can be feasible
>> but less simple.
>>
>> Let's see how the simplest way go, if not that good, we still have a
>> plan B.
>>
>> Thanks,
>> Qu
