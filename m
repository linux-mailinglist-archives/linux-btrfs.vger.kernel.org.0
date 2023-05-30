Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59F87171C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 01:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjE3Xf7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 19:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjE3Xf6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 19:35:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB56AA
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685489748; x=1686094548; i=quwenruo.btrfs@gmx.com;
 bh=cmGQwarRPcM42WKK3WXsF/Of5BZgaafsm9hpRDOaUlU=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=uF8WmRjTt+vjVrVkgG9RBPn4M1I4shdvTde/8oA9Wre/fArTutz1chgU0wZisWy6gntfo/b
 GaG7m18DCamrxxpo+h26GchGTt/7w60LGZV0W4WCuAik/FUh6+o9phOR9c0dXNN8ABRP0O5fp
 8ef6SVavkHRKrqQSVgCVZyBRzMrvZefxg0+4M4URd33OQTuZnH4uXGG6MNLuFwY/u8B3bsMWm
 t/u2UWKZ/vEYfTvDPWUNnmRXh8UyGXM0b4kAmz0GzKEiaOmcC3cVXRsGb7CJTkiKhEWJrCNlt
 Q9KUXL5i36RongyOXAS1qvjKf8FbaWFnvSatEW3T7R0pHvB3cVvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpap-1qVGIu2zS3-00mHuv; Wed, 31
 May 2023 01:35:48 +0200
Message-ID: <b3f0ae3a-5f3d-8525-70e2-ace053350c59@gmx.com>
Date:   Wed, 31 May 2023 07:35:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1685411033.git.wqu@suse.com>
 <5b3edb0ed26aa790fa92d0319739adfd71b3b2f5.1685411033.git.wqu@suse.com>
 <ZHWM5U754Na8KyCi@infradead.org>
 <8267e2d0-2bb4-36c5-b252-bbba7e18bb0e@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 3/3] btrfs: remove processed_extent infrastructure
In-Reply-To: <8267e2d0-2bb4-36c5-b252-bbba7e18bb0e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4TzynqIPejBeRdPvUSv9/wbnciJ/NoXN4MRFTkoBC3rWleEd3gw
 Wuqpt0/eib1BiYsnprDOLXQu/+dhc5Plf+bTCi3GxmvkK3JpwUNJ0Et4G+tJlpjq5CmGR54
 sD8p1qJh+J5VkfCwCaawd05kuf2wqaX5xI6UX7YW/ODMEtWLyBsAXHeARpL7jA6CzC6aB9/
 2Z9TJ8/v6Vo4dxgQWyQKQ==
UI-OutboundReport: notjunk:1;M01:P0:uogfm+O8SzI=;hVub7tppLog5BV3z2S8m7DK8LU2
 ncR97KiYUd1qwY4M1lH6PU5WZ907eegpno206mSqk0Dm+bUVEV+WGNlrapBur9xMYTk0909kK
 ylZRGTAc6P0KnipjKAAULdka7rXdzCWDapakZWfhgbFO3ymhfLhXnu59IhWaaexQlKLjHa03K
 VbRr9y6G73R1/FxcWHwschJ5mej6FZCfLYAxtxkPSCmrlkVsLW32Oy+7C1NmO48/cYRYgWcTp
 Sw5quEIq/OhE5hkhpeiQ5yYcpBl25JI6yxL1dw/SElosUXjqNC2MbHAlGmp7DkVjYgUB+hjVW
 HnCsfswzCu80qxzI/INed0uWxCeitVDrIx3QaopFqK/+EWEJc1PXDox+fqwAUkX3VR2JpgWqS
 J5nH0VJOHTtKKXaMfh2LNGEHJhe/RztZ6rZ1KJ9MYF0mtpoqI53GPEWpSVB1FU1oYIGbo7lzm
 3cPrxwcBKniPo88xv4lYNfva1vpZ1kF9vquxY0ordAaF3n8++/RLP5geHtZVK7EbODVk5268Z
 MWbX7MGYoFVrYgcOlhDMx457fjpesN6cD0f+qiBkrOuSsOHh316idt72OWi3jkmI/PaSbmDYU
 C8uqCqXSldlUx3iX0pOj4sC4nq+MDFtZH2jIwtHcDNn7gMbiWsNHha78p5Tb7PViJuybEo3Za
 Zgzo7tgO9neETTjTtRZgDsYkrsfNZ+D7IwJ1vS905+crsrs/m5jO3MwDg5L5w139113ypahj8
 cEgus/971q0nk11Je7bfgLIHS5JYDnuXh/tk9zlIgwNevSzc5t7jON+LXUK+GSfNoOcilZu44
 JG6wBekuK1n9utW9o6lRF0b7mpqt9iS34s/R+o/TmkZ4BeA4k1uAfOFNMt398Xs7881arpvnD
 UJY1n+CIRQZm+n9GSvEJe/wxNJVCP9LBeZWDyDu64vVlgjZNwpCNVddfly6XGbmlnCcOvi8wI
 wGGb3HAjroVAF5rxqBnlxZrys+Y=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/30 14:19, Qu Wenruo wrote:
>
>
> On 2023/5/30 13:43, Christoph Hellwig wrote:
>> I recently posted an equivalent patch:
>>
>> https://www.spinics.net/lists/linux-btrfs/msg134188.html
>>
>> but it turns out this actually breaks with compression enabled, where
>> due to the ompression we can get gaps in the logical addresses.=C2=A0 I=
IRC
>> you had to do an auto run with -o compress to catch it.
>>
> Great thanks for the mentioning on the existing patch.
>
> However I'm still not sure why compression can be broken.
>
> Yes, data read would also use the same endio hook for both compressed
> and regular reads.
>
> But that endio hook is always handling file pages, thus the range it's
> handling should always be continuous.
> Or did I miss something?

All my bad, indeed we can submit a btrfs_bio that contains two or more
ranges which are not continuous, for compressed read.

For compressed read, we always use the the on-disk bytenr as the
@disk_bytenr for submit_extent_page().

Which means, if we have the following file layout, we will submit just
one btrfs_bio:

	item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
		generation 7 type 1 (regular)
		extent data disk byte 13631488 nr 4096
		extent data offset 0 nr 4096 ram 32768
		extent compression 1 (zlib)
	item 7 key (257 EXTENT_DATA 4096) itemoff 15763 itemsize 53
		generation 8 type 1 (regular)
		extent data disk byte 0 nr 0
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)
	item 8 key (257 EXTENT_DATA 8192) itemoff 15710 itemsize 53
		generation 7 type 1 (regular)
		extent data disk byte 13631488 nr 4096
		extent data offset 8192 nr 24576 ram 32768
		extent compression 1 (zlib)

When reading the whole file, at file range [0, 4k), we will use 13631488
as @disk_bytenr, but at this stage we don't submit the btrfs_bio yet.

Then we hit the whole, just zeroing the pages.

Finally we hit the range [8K, 32K), we still use 13631488 as
@disk_bytenr, and since we have a btrfs_bio with the same disk_bytenr
and it's compressed read, we merge it.

This results the btrfs_bio containing two ranges, [0, 4K) and [8K 32K).

The objective looks like an optimization, if we submit two btrfs_bio for
the two ranges, we will read the compressed extents twice, and do
de-compression twice.

Although this is anti-instinct, it at least has a valid reason.

But I can argue that, this only works for holes, as if the range [4K,
8K) is not a hole, then we still need to submit two different btrfs_bio
for [0, 4K) and [8K, 32K).

Maybe it's time for us to determine whether the behavior is worthy.

Thanks,
Qu

>
> Thanks,
> Qu
