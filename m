Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ECB7AD45D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjIYJSR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 05:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjIYJSP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 05:18:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DE1E3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695633474; x=1696238274; i=quwenruo.btrfs@gmx.com;
 bh=pQbtT5jVw7an8j+ZLwptmbqEpRoLQz96+J+NJuH4rGY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fSukOqx8lhght2fo7gCBO3gcA7oa6HkU/x4cvhtiltS2DWcMl/jyfm1Akv6L8WPzRBE3D+khcp9
 CMnXbnK9gQn0SShOF4ItvMO6fwAQBlcUxptFgwurNPJX4byHtMycNH5WkWSggVPsogZ6AUY9Gyf97
 noGcmeyy6KOXCVfriVhJtYFKHmAiCv0OMAT/wTUgwWW2Pz3Qqyfslgkx0evgTk0pQW057Iz88y46m
 YPQfvTps1RQVCrWMTcIw71JOOrMNIwXVoFcK2zQ4gbigHpi+pBfTmKQlf3Q4m2cZIp1uqZ/GSusB/
 8086HYK7cgDePgJbY/HVbpJBW/11UZlrLcug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.18.112.28] ([173.244.62.20]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCfJ-1r6NSC2gzJ-00V9xG; Mon, 25
 Sep 2023 11:17:54 +0200
Message-ID: <ff3e9fc1-3c22-4645-8442-b08212a6c67f@gmx.com>
Date:   Mon, 25 Sep 2023 18:47:50 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix a race which can lead to unreported write
 failure
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <8bc4c2aaa8d32ad92838b3778a85660ba7c6bfa8.1695617943.git.wqu@suse.com>
 <ZRFLfTSMBXs+JTkc@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <ZRFLfTSMBXs+JTkc@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c/nn85R3pRMpptrVJyoEMZFfzLql0sL+j2UysXvs9aonGvn65NY
 FNk4hxX+2rtBLS+msR1/UwzDgdZu7U+TXjApMeVpbWOWVExw7bwZrqt5Mm6KID/PaOmpYNS
 OOvDE1z1uvF/9PcyOJXbNZBGBUU24keVJe2VzhFwQsJ6psciq+5aNh3/ZgWumeTZIiXoech
 195xZYxgpgBWUDa4hxWgg==
UI-OutboundReport: notjunk:1;M01:P0:M5VAJpXL0fU=;vvUVZ2DtAb+qqeOAI81BSF7to1X
 VMmhd4YH5dpR3WXF2+JW5g8Wpu+ae9hrNO6babL+8wYFYLqgpMMuK6WlwcSaO5XhH+FXJd25r
 B6RwekfjpR5mgDD5qBcE/xj6p3t76KC6qwQonJwRVwZH/W3piQltI1hAx80wkTfsBRgLO4222
 EyL8QRTxG2b68/oSX6R2lmZ9NljzIr5EzVn6i3KJgscWwBjnaE8s+aIwzYnGhu8rBiTZIIz0u
 w5uDRkr7fH1ReXqRVGlnCFuKTE5LmltbDLae/3NtqsARmkcPUL4BaKixKj08Xvcv/FXUjhIKk
 EdOW48XbS8fcPzHBUaDKU5mGOG63DsN4WB4LMy0sikL3wsuBI4Kh6IYBLVkUbB8yREZoyuJp9
 EaYPvJO+in6dzbs7CNrB1wgjmqd0NIuKOLcvZs/p7HG7cvibI6m5gp1BgXjTiXSK3GJ8GqQzt
 xJ2lz2Pn/uE5ESz1Pyt+nLEbEwwraZGKWcNXa3BwSgqKnvXbCTMFbGy8kLtICcUe02u2LtVTd
 HuwNOuHu+ujOI+rsJFOXQVRhbgKM6WcFEAcarhmCZECTRVrCo9SggsYRMaFXqJMarez1jE/BD
 pzNYy/il9Aiglmsqif1KLDoYPYlmR67gg4SkyWM2w6vwNmjjzsyhEC0SnqLs2fPae2UcXIv2N
 QtsH+iPcCczCx2mI4+g8cTkQxhbYYc4iEHNdz9iXTol4V9PO17oPwSchN27jw8cYBPGMsfoj0
 3Dm9amIqqzGmJ0wv83E7DZuTMakSBU+Z8KQcehemOMEzzWUUQMjhraMfcFJ3gMF5KpYN4tLOs
 r9Nx9TTR+c5qXSgXu65wpmCwwInzo7VvgUwpHM7sqEy9I3IjR18O2F404cz3KJoNFBlrrr2vp
 Vo/VH/6dysRkSw5ERGvoDEZ11HKjjm3TLlKPhjN9UqjD0EZsJ4zwqSSDhK7tEHSo56Et8RlZp
 nmB52uofSUn43yRuiVWeZOHk/SE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/25 18:27, Christoph Hellwig wrote:
> On Mon, Sep 25, 2023 at 02:29:28PM +0930, Qu Wenruo wrote:
>>                 Thread A                |            Thread B
>> ---------------------------------------+-------------------------------=
---
>>   btrfs_orig_write_end_io()             | btrfs_clone_write_end_io()
>>   |  this bio failed                    | |  this bio failed
>>   |                                     | |
>>   |- atommic_inc(&bioc->error);         | |
>>   |- atomic_read(&bioc->error)          | |
>>   |  So far we only hit one error,      | |
>>   |  thus can still consider the write  | |
>>   |  succeeded                          | |
>>   `- bio->bi_status =3D BLK_STS_OK;       | |
>>                                         | `- atomic_inc(&bioc->error);
>
> I don't think this scenario can happen.
>
> btrfs_clone_write_end_io increments bioc->error before calling
> bio_endio on the orig_bio, which is the earliest time
> btrfs_orig_write_end_io will be called for this original bio due to
> the earlier bio_inc_remaining.
>
Sorry, I couldn't find out a hard guarantee to make
btrfs_orig_write_end_io() to always be executed after
btrfs_clone_write_end_io().

We can have a case that there is a RAID1, the first disk is an SSD while
the 2nd disk is a slow HDD.

And the last mirror of a write (aka, the btrfs_orig_write_end_io()) is
submitted to the faster disk, thus it can set orig_bio to BLK_STS_OK
even if the faster disk failed the write.

Yes, the chained bio ensured the original endio function can only be
called after all chained (cloned) ones finished, but there is no ensured
on the orig_bio->bi_status checks.
Thus we need to do the check on all chained and embedded bios.

Thanks,
Qu
