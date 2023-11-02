Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513AD7DFBB5
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 21:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjKBUt4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 16:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBUtz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 16:49:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03910188
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698958186; x=1699562986; i=quwenruo.btrfs@gmx.com;
        bh=mjpHnvMrB9tzuTMl0y2e/hjJ8VkUm+D+VfUpV0akluc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=lhgEq0wJ8BswIaFd37YhLEWL90tmyMlRv6nPzrS8k8kzJUut/p6hx+bXWxM6sm0w
         vx1TgS+/MzxBdsj2VSbKdicLaEV+PL/h5Ydzyah129FD2/lFyNoNbyL+FDpC+rgTa
         NJZMRHJ230FuMPA5yaY/nQaH/1f3FSgFPK+UhfrdwYmGh+wz30Up6fwMpZHv3xye8
         thZ9hCveUT84HEq5WVS1zEkgO6z7q1bys55N7T8/i+GiEt6cMJ53GcCjLWNFVTH9j
         nVJXnFVZUkFWoWmuwmae0pg++ne/Aof3Jja6WcSUKw7OLIKybQiMDDtp3QNEbuIgY
         GnWKT4xt+YiQCrHcYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Md6Mj-1rYoOo1Iod-00aFoz; Thu, 02
 Nov 2023 21:49:45 +0100
Message-ID: <196ebcda-afff-45bc-a32a-bc313369e405@gmx.com>
Date:   Fri, 3 Nov 2023 07:19:41 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
 <20231102203640.GB3465621@perftesting>
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
In-Reply-To: <20231102203640.GB3465621@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e9PUvtCQ5B+D4NOOkvkb2JVhmLzUnSbJrstJxOKmAqa/a4Bvbt1
 NVMKF5r79XV4KHkfQRSvTtR5Q3XPMHzfxPh4j3I4zQmof3GiAkqmtAKfXhhbljK1AqpkKUg
 Rus5uk5I6bb48K0mD+tJ5w7bVaeeJRaPkMM/aY5lw3HtNC+BWEDa0n9o5e9ry3toP8nOxOm
 Y1lxe5aB9ZpPzPTca8RDw==
UI-OutboundReport: notjunk:1;M01:P0:zu4ZRhMwi7g=;8MjMseTYnpzFk5Pl/ari8jaia25
 j4DGd1RtekQSX+NSIe6NyFAZF/358LBqsae+EQFuax/0HJ+SRH+GYj6TGT9BNP5mqW7CGaTu+
 7acoK+a/isHNAzci4N8t92CudvRjtDhrULea322HbaCjyzHe0HYt4AymSWmGocyrZMut00PLW
 5UbJXlYy3VixEzDkGvW4FLotI+6dIwn+gvYCsI4bicOH/MUlK8uwLW7hhGn0FxPsSn/OQJipI
 MuvKT15qjOocvNLZm8DGsE5xjKdzXscqKm3/6m+YArHn8MQHOJoxORHsv2clBMV9vx7rmlbRQ
 Zwl5hnuc9XTOXqmOf6IMEXVaMPPcb53b2eZG64TfBBlHXG4SnnhMbgFAJFh6R+RSRM4KnPSNN
 55tTJ173YgbZM+qZS05lLxprkKjHrSb3rJzoDx7qmfCuoh6OuaX7gdPAaGLQJY99mOHlpIYjT
 B9d4ZI9jQfD+zChmgOwzuB+u6vr2znT7UJxxjCR4Hlx0W+e9RdqOHXPVcx4nEOGrrcsYC+lR1
 hN5bnA54lxDF8cLhpklr8AYvF6q6pMazY0wkEFyWtGV9HWMglS2J7L6ARaUfXPQSHoIVsDA/U
 qj16F8ZtE3kyJUK91wifwfhYUo2R23zmVQJ93yOJ6SyjTJs1H9eCQr5PM2dTalvoUPiohNnQ7
 a90s6aD0yVXpxfunnbXvrUyJGEVvy21hDZ8fAzXyus4xMzJBdkobl97p0BHoPh084bwh+ED9t
 b6oKf2TgI+Hk32tlz9BUj4vOy95QPkJEfxOPPz8noTH8bfcLQr2jPeB3YxJ4xbSb1fjzEMTUc
 5VbWKqSjEEWBXMUD8x+rK8/gGUCs9tfgpBaD8fFdncgvKpILeeTrQYkDMf0GRtxD8r1iuF5/2
 8K5+80ypI/jz+4PimCI3dVskFvCHl1+eB+lqmFWmKuqhPSR10K3XqKjCi3FiAy49R9mvYuhUy
 B8YSZGgGcxO/kvD4vvwM39nsFmY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/11/3 07:06, Josef Bacik wrote:
> On Tue, Oct 24, 2023 at 12:41:11PM +1030, Qu Wenruo wrote:
>> [BUG]
>> There is a bug report that ntfs2btrfs had a bug that it can lead to
>> transaction abort and the filesystem flips to read-only.
>>
>> [CAUSE]
>> For inline backref items, kernel has a strict requirement for their
>> ordered, they must follow the following rules:
>>
>> - All btrfs_extent_inline_ref::type should be in an ascending order
>>
>> - Within the same type, the items should follow a descending order by
>>    their sequence number
>>
>>    For EXTENT_DATA_REF type, the sequence number is result from
>>    hash_extent_data_ref().
>>    For other types, their sequence numbers are
>>    btrfs_extent_inline_ref::offset.
>>
>> Thus if there is any code not following above rules, the resulted
>> inline backrefs can prevent the kernel to locate the needed inline
>> backref and lead to transaction abort.
>>
>> [FIX]
>> Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added th=
e
>> ability to detect such problems.
>>
>> For kernel, let's be more noisy and be more specific about the order, s=
o
>> that the next time kernel hits such problem we would reject it in the
>> first place, without leading to transaction abort.
>>
>> Link: https://github.com/kdave/btrfs-progs/pull/622
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> This broke squotas and I didn't notice it until I was running the CI for=
 my
> mount api changes.
>
> Lets try to use the CI for most things, even if you send it at the same =
time you
> submit a job, it'll keep this sort of thing from happening.  Thanks,

My bad, didn't utilize CI at all.

Any quick guides/docs on the CI system?

Thanks,
Qu

>
> Josef
