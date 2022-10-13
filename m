Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF765FD6EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 11:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJMJWL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 05:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJMJWI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 05:22:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3AFFA002
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 02:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665652924;
        bh=SXChz+wVG2ZfR2aCC/GaGL1rKX4Iba3ExpZrftS7ygs=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=E7rpaD1hub5Nw4gFkzHB5EcpjqPzy02YqxEy6i+bpT3Fof+N7TV77n2slgmMKyC8O
         lHwLnQ/4dwfjQes65oAZdL/LUgHuVMrxORAPOSobs+h2N1x3xUQjGBl7upQYsxhYZj
         gtbXfcp5aggXbiPH5SkVY+M6zw2mP+k+8fyVI1AY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLR1f-1oQQ5g2ud1-00IYPC; Thu, 13
 Oct 2022 11:22:04 +0200
Message-ID: <0fc3dd35-de05-7654-b813-15367f2a71c0@gmx.com>
Date:   Thu, 13 Oct 2022 17:22:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] btrfs: make btrfs module init/exit match their
 sequence
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
 <89f06268-d610-1282-02aa-ba1c78fda772@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <89f06268-d610-1282-02aa-ba1c78fda772@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0lLNpeRtO++bayYucsClGrGMOHY0XCVJU59i4sF4oxRgl3G1KVm
 DiDcgmfXkPDkmXH6OLY1sMr6cvuyT6UGzZ/3WyFt2bGDVYhURxyN9J13LJbArvP5KceuBSg
 pSHIOyWApx/7Fc4EH+zm6iI6oIH8X7UOHSKLC8bNWx5OPAXWqT5ahdL7x9bOBds/0bIu7HZ
 KGhy4zCDb/aVf0qS8mtTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EzGtRbWLHRM=:nykgwg8EvMedzqPeiCQaA2
 jauMpcZp+/hjc6Rlpa/2sO/4Y1oN6rVzamWEZkQB1UaCO1o+HzY6UVYREJK11G6p8RMh9uDRh
 HBypvZP8SeHXdRpqTqqpLwcopWFK1Bd4EVDCQw6xbDL05hNJAwNwtQ5lqcuEJBVB9G6LOVvNJ
 7uegpbpMuGScjU7TNIJnfRWu3D4AnoSv92atWnSfIhHdPqE550pOX4ONc09XsUdx9ta+CAk5V
 qC0v9bcYhzTKhRfOHxAMbS1cVGWA1EmBXBV0s2NCEVMAPrpYdiVUme0y8O60QfV89ev/4PbGd
 uFZJylyv1tGkMx7o3rjFaa98cdXS38FrxACedhbkM0Duu+d97/ihIzmvUbXuJCczgJjStwHYO
 QWdfbPPx1UmClNHt+xm/vy/yfQsolknF8dg7poI4UO5/YYGVqhf3IKjSh5ENsPe1lhMHgnhhe
 fSH4RHW+ajCzjCKIBb0Pt2nTaAN+0kPvC3zJ9wq7zs4GGiQ5NodbR9tfqs7YKoH9+shGyJOC4
 NmVNNGt0+11nxbrEczmnc25tqJoDA7dVdebj2qI/B8Tqtp8CpOO6wGr9k8Gtbzp8o7hAzlFIF
 Rntx64bjTGy3gns04ABpVkBoefgxM0jYZGj5KR7ssNtdIYrVtWjfTLurLGJMneBf4/Efcydcg
 AHp8SRrn3JNox8295ISUMyTMF8mb7AwOEOc+MPY9Y6yryNUEEyg2Ym3/wGngoh8RqMG04ReGz
 8WmtlhhZ7TZPxtZJS0c1lCs2YwLCYccirO+SmQvBGk4jlYU3/gWyB6xaKYfr7QDJBHbmi0jUx
 aJ8vrmV8cslITgoxu3VczLn5mfZm4+IIXFZhDV1bkQgHbzq4w6O7BJ0Uh2yh2h0JwUE2dESv9
 c1RmUDEtQMuHEW3CJhC9lO6/tVnErKox8bEvVxm0csgVDlCm39K4NwyA647Ug51OL1LhGUu4A
 QGXSmCwASJCwcFX8Jn22gee7b3GZNnYUOOBcxJx71/NQ2ODjFYMi8ufPwrR6Sem2+uW5SYbBM
 jpJtjwvF0qaFqOOrEqjF/PyFtarSqLjQXKzJJ9IEZnnUmq6mVlj/vdozSI2YXjW3C1buRIa56
 YdO0CDWFRBihTrPrfVDFZd/b4TSp7pyzTQMrq33Z5zUUXcJSzfsZ5/PDRInUkGRIOnEXVy3P2
 v1Re74dpflJ4bhlSyijO4lCePMuvg89nnGrDqvdJKpOcy9JtzbCHJuKjFNppMlfzr8nqhYwhF
 8A3xyoYqVxec6uvLho8QpgUR0ZT6owTJix2c90UHvXmuES+zoTkvYz8M+B7yEcsFRXSYS695I
 1trVOFOXHON+Cu4pM1yi+PWiWcrIADMhAzp/Hr80FAzQOAwzLuf9oh53zXlWVZHgbHSFHWV7U
 JLzRXMt6z3m15hWIOZWBNR1a2n+FsoJ5qUuf+vrirKCtxM0Frd/ImHZtK79UVvXHwV0NskF4I
 /v+lehifyrkfpjFPxKL6KM+rikERR5+yIM5SqUrJHrhChWQqiPnw6xssh8No573CgPF0eudLW
 B+wNauiVVczGaFo1BYiaivczcOQXkGPHI39t2Q4S/pW2W
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/13 17:14, Nikolay Borisov wrote:
>
>
> On 12.10.22 =D0=B3. 12:22 =D1=87., Qu Wenruo wrote:
>> [BACKGROUND]
>> In theory init_btrfs_fs() and exit_btrfs_fs() should match their
>> sequence, thus normally they should look like this:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 init_btrfs_fs()=C2=A0=C2=A0 |=C2=A0=C2=A0 exit=
_btrfs_fs()
>> ----------------------+------------------------
>> =C2=A0=C2=A0=C2=A0=C2=A0 init_A();=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0 init_B();=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0 init_C();=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 exit_C();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 exit_B();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 exit_A();
>>
>> So is for the error path of init_btrfs_fs().
>>
>> But it's not the case, some exit functions don't match their init
>> functions sequence in init_btrfs_fs().
>>
>> Furthermore in init_btrfs_fs(), we need to have a new error tag for eac=
h
>> new init function we added.
>> This is not really expandable, especially recently we may add several
>> new functions to init_btrfs_fs().
>>
>> [ENHANCEMENT]
>> The patch will introduce the following things to enhance the situation:
>>
>> - struct init_sequence
>> =C2=A0=C2=A0 Just a wrapper of init and exit function pointers.
>>
>> =C2=A0=C2=A0 The init function must use int type as return value, thus =
some init
>> =C2=A0=C2=A0 functions need to be updated to return 0.
>>
>> =C2=A0=C2=A0 The exit function can be NULL, as there are some init sequ=
ence just
>> =C2=A0=C2=A0 outputting a message.
>>
>> - struct mod_init_seq[] array
>> =C2=A0=C2=A0 This is a const array, recording all the initialization we=
 need to do
>> =C2=A0=C2=A0 in init_btrfs_fs(), and the order follows the old init_btr=
fs_fs().
>>
>> =C2=A0=C2=A0 Only one modification in the order, now we call btrfs_prin=
t_mod_info()
>> =C2=A0=C2=A0 after sanity checks.
>> =C2=A0=C2=A0 As it makes no sense to print the mod into, and fail the s=
anity tests.
>>
>> - bool mod_init_result[] array
>> =C2=A0=C2=A0 This is a bool array, recording if we have initialized one=
 entry in
>> =C2=A0=C2=A0 mod_init_seq[].
>>
>> =C2=A0=C2=A0 The reason to split mod_init_seq[] and mod_init_result[] i=
s to avoid
>> =C2=A0=C2=A0 section mismatch in reference.
>>
>> =C2=A0=C2=A0 All init function are in .init.text, but if mod_init_seq[]=
 records
>> =C2=A0=C2=A0 the @initialized member it can no longer be const, thus wi=
ll be put
>> =C2=A0=C2=A0 into .data section, and cause modpost warning.
>>
>> For init_btrfs_fs() we just call all init functions in their order in
>> mod_init_seq[] array, and after each call, setting corresponding
>> mod_init_result[] to true.
>>
>> For exit_btrfs_fs() and error handling path of init_btrfs_fs(), we just
>> iterate mod_init_seq[] in reverse order, and skip all uninitialized
>> entry.
>>
>> With this patch, init_btrfs_fs()/exit_btrfs_fs() will be much easier to
>> expand and will always follow the strict order.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> RFC->v1:
>> - Change the mod_init_seq[] array to static const
>>
>> v1->v2:
>> - Rebased to latest misc-next to handle new init/exit entries
>
>
> Only thing I'm worried with this is whether it will have any long-term
> maintenance repercussion if someone wants to add a new sequence, i.e is
> it sufficient to tack it at the end of the array, or shall one go
> through the list of pointers, inspect what actions each function do and
> decide where in init_sequence to put the new functionality?

For adding a new sequence, one has to understand the dependency (if any).

If no dependency (which I believe is the most common case), then the
generic idea is just to add it before the selftest.


The question would be more critical for open_ctree(), in fact
open_ctree() has a lot of cases that something can only be initialized
after its dependency.

In that case, your concern is correct, one has to go through the init
functions to find a proper location.
And unlike the original code, it's one extra level of indirection.

But I'd say, for most part, the init function names should explain
themselves, thus I hope it won't cause too much hassles in the future.

Thanks,
Qu
