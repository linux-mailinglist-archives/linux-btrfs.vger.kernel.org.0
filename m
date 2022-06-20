Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2045511BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 09:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbiFTHp7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbiFTHp5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 03:45:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5FDFD19
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 00:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655711150;
        bh=JpSmR8CMYzQMe1gAVUegVMGT8vVEjCGxpBEiCVPikVM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PBwa+fKDR7KUdL5To+DCtR84xFrWKTY13RECfAtk3ss2wFgO+b1y6bIoCOnK+EpvK
         LVqgudj50ECHVrdVcpys5MVWxYdpmjmxdcEM/HThV9AB892fqo+tvQ6Z9RFghA3C5t
         7wku/VsniKDfuTlcc5IeKZC9Hh+hTewH2h5IN7Pg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1Ycr-1o6EEw2WyJ-0038y9; Mon, 20
 Jun 2022 09:45:50 +0200
Message-ID: <7d0a5aa7-bdfb-e6c4-64b5-028ab73a54c1@gmx.com>
Date:   Mon, 20 Jun 2022 15:45:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 06/10] btrfs: transfer the bio counter reference to the
 raid submission helpers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-7-hch@lst.de>
 <59dc5c97-36c6-9737-b7ab-1d4fcfaba2e3@gmx.com>
 <20220620073725.GA11832@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220620073725.GA11832@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gX+PZaBVVQU4o3FQYjI1q2Am18eI7bmTFSRhuGHLNeRp6JTLK0r
 EYWfywlYHGfGjc/U/vfLoe8VmLjqa+10h5PJxSgoZOpaE+GjL7meGAFVJRNmKljS4WbwBWu
 43Z7RCDOo3vEHtwxFzDUNsA7chGauq5M05wn7l+LxNHTdwI5THDZUuDW1gNdtfhuWgvs7p4
 Z12cJFkknsEDqbRewbl8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hSxcjlWegjc=:lfGiQ4Gm9gtkUknVExqrQ/
 Cl66qVFznwPa7VoCMYBNoP06RvFfcvA+i2t4vJk1V8+WUh0xCX4ZrT6TbOs5ejeVDT3OMYq5m
 3Z0DLE6+F+UTxz50HE2LihsnUMp6i2lCcECkfxrJlGC4CAMFPUd7Cmcx8BntsVcMvMTektrbC
 QXVhlxTYn9QwvCDOSMxtLnXm/O7AdwXzbcUvxsqTqCLoP9BJijz3wfvp9Oat5DhZsNp6mWwxc
 5KpJpEG3AyAvqVhyLtiHm4XGlw4K2Joe5yt94cfE9s3Ge0gFUMDiMLrbeO3dYqBgFF6ttvf2+
 P6L858M5tghS2kt12vQIFWSMbxHxmKK1LJUgijO0DW5qm4vlBzAEP+Kz7zVHvxNAGf9KRyWim
 FO2+WvGBAk2LGdngBVaYeUoDPzUlIK4ciyrCEJVT7JCmTo1v8YBRcS62/AIT2datQMKF9YhJe
 9jVokjZHQVjItSQe/GRoEsCMi2DODTX6wY8fgLw8ol5c6P2j2OfH48LqkxllgBd/0zViwNfDF
 gauqwE+zIRpqAYWSXqt0+qXYoqKtJQx3THnQWNBqcvtX21wdMNMrXTEGCkrup5umnV3XcULAP
 yGMVIBgrQJst2FB0cTNBZk3zBiNp9UgYJZSYzzEm3h7oJUZAG6JuBg0soMrZiI9c+0Hr8NqDq
 hb0ipLu4IcE2UY/pSA+XnRpOVihDf+VjCJNJxV7TKifB2waq3Pmvlgw9LQrcrijYq8W9Ba+Sm
 IjKMHuvOKGrYTQWWJAypPBWpVlwTfcn8FuT8iPtNCxzIFe3HwFxs8Sf/+iPUk65igxaTVLAt+
 vmQbLdctxAMv6UmUOzVKJtL7SdAJf+2NS+jCZHMQl/qLHUrCAa6RXbS8YCBDO4zssuYiRIcI1
 SUX/HwQZ+uZBsufyz/b7FprT8qONQe8fsNQLTP0YAOmSp+HUsbeUIhSiQ6cIOZ0GiWRyHfvdK
 NbUQbUOpO1r1fks3Ieu6rHumvCaY7i07TS/cCjxKYT/TJLnfdJrKYIhN3aPXsuZGaHteAJJPm
 RX3OTwatqjSnsMYjb1d0lCdliWKj7uTzKIJ91qbCZZXMGi71y9/RsZwxhH61AQnFPQB8RFop/
 oLNTvAbi4UGYsu1502aXGWlOt+7czzadZTCKiiNRAI0u3jv4XOc6VN4Xg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/20 15:37, Christoph Hellwig wrote:
> On Sun, Jun 19, 2022 at 06:45:11PM +0800, Qu Wenruo wrote:
>>> Transfer the bio counter reference acquired by btrfs_submit_bio to
>>> raid56_parity_write and raid56_parity_recovery together with the bio t=
hat
>>> the reference was acuired for instead of acquiring another reference i=
n
>>> those helpers and dropping the original one in btrfs_submit_bio.
>>
>> Btrfs_submit_bio() has called btrfs_bio_counter_inc_blocked(), then cal=
l
>> btrfs_bio_counter_dec() in its out_dec: tag.
>>
>> Thus the bio counter is already paired.
>>
>> Then why we want to dec the counter again in RAID56 path?
>>
>> Or did I miss some patches in the past modifying the behavior?
>
> The behviour before this patch is:
>
> btrfs_submit_bio does:
>
> 	btrfs_bio_counter_inc_blocked
> 	call raid56_parity_write / raid56_parity_recover
> 	btrfs_bio_counter_dec
>
> raid56_parity_write / raid56_parity_recover then do:
>
> 	btrfs_bio_counter_inc_noblocked
> 	btrfs_bio_counter_dec on error only
>
> The new behavior is:
>
> btrfs_submit_bio does:
>
> 	btrfs_bio_counter_inc_blocked
> 	call raid56_parity_write / raid56_parity_recover
> 	return
>
> raid56_parity_write / raid56_parity_recover then do:
>
> 	btrfs_bio_counter_dec on error only
>
> so no change in the final number of reference, but on less inc/dec
> pair for the successful submission fast path.

Oh, I see now, the patch only modified the lifespan of the counter for
RAID56 path, while the other profiles still go the old lifespan.

So the counter is still correct.

For the sake of consistency, is it possible that the other profiles also
follow the same behavior?

I guess it will need at least a counter to track how many pending bios
in btrfs_io_context so bio counter is only decreased for the last bio?

Thanks,
Qu
