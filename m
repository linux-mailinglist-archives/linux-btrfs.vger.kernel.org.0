Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6386E5D59
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 11:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjDRJ2h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Apr 2023 05:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjDRJ2g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Apr 2023 05:28:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F14216
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 02:28:34 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAONX-1pdOxL2AP5-00BwxN; Tue, 18
 Apr 2023 11:28:29 +0200
Message-ID: <4dfc88bb-7af0-524c-9174-1fd31db2c7d8@gmx.com>
Date:   Tue, 18 Apr 2023 17:28:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: output affected files when relocation failed
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <aa446804b679949a1bd77e653a205408af43048e.1681780522.git.wqu@suse.com>
 <9bb5f4ea-717b-2365-652a-01b130452118@oracle.com>
 <6fc3db31-cb9f-de32-cd4d-1d9d63270ba7@gmx.com>
 <30a3f762-5bad-da85-738b-dde8f41b8171@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <30a3f762-5bad-da85-738b-dde8f41b8171@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T1vpGH16S/MSWpGeaVcZEedTNmSzvhvYl1mb15ttbmNIlAmAEfS
 t2SykeGWS9OC5ZeSqThPj6rjKGcBIJGEkFXgGst7ZV0qSjbHGTMluXUtRyjnGgD4CuTSQOQ
 VvusDxnz5hu87w+Im17LHTUeaZ0A/lE4fNCUOE+RlveO05+ttxJbQIjEfXAhFiNHntvT0dM
 pNBTCDkhQaI5uc7IlBegA==
UI-OutboundReport: notjunk:1;M01:P0:TFp8h1Fro/0=;fsh8mqUhA4OZGE1IBdCSnZpbAcu
 DHXkri4FEGpUNvHB+02FgntoTiPBxc5O4riyRLDha8HbrXpMxKr1tn/kRmqVjU4gpt38MGhfU
 AMpT7rIhtCMP2/BKhaWJ6rop1fawqFvD1VfRafByK3dQMZaxML/0GeRicni6Q5xKWsVPFTm9M
 vpr+KnZtlHEp9VTZCGykm8Wg3aoY//RLYrm0o6Yie3uyzHfpYaQTmqjAV/R/R5IOKR9UHAOrb
 Si3sUBE3GkQv4xuJeAU5luyTbi2HQpMvGuahWeaDzFzwE+DEDxg1A7IVIVoKCpEQLOwfEo9DO
 hM6Rel26rQFznbaGbIIKAEXhNRSeS13mwAaSWdQm+QuITKz5hgXjTKc5/IuwgNOPFGdlrPy/E
 bFSONkcIDQZspLRFRjy49mB5dbyvvvJCGfzrcWtKbMIubKIisAYwW6RxhxjDPscN87LqF+HWD
 wJzboQ5njVuPuF9mnq9qusbTPLI1kKFltlwWnAP/ByPndVSYRR6LH/iipa/3cM/jeYPgFLres
 Nj52lEr4ofv2LLbN8raQWKasQyr562K8FPenCC6KfPn88BCk4sOi9GpVfvSNaj/+ubkoxa66r
 y1KDJVqj33hG3HUXPnBisDDSdp6QA1wPJCYOS2k6ST8LqksbJutdGt6YJOrbEL0suqwUroJhf
 6V6yKncwydw0IdRKs/y3SgFM6HDk36w1R5nwVWwNimuQmqhKOCuNpd3DwA4yUoQji1CfYHq6L
 YE8YjjlTQxTQpS8AH/KZsoVct/tp6WHmKxmIsCRqJvy2dMMg9LPEHsV6m8DJMmIPWa6X+/xYu
 wu16SL8ExyTx3svJ4AmltQkt4gQeN2SOueBMghvFM/QD/FtErzpadib7oc5mwQmgpH5RdKksT
 Xp5U1+M+LNxsQCDhhhHyJueXa5lQW8QHk2bV44fgYJmf+P0oOshDOHh2BCO9s3HPAP8edcpRm
 ICU1TLGCb0WkmoufO86nIzzhq+g=
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 17:25, Anand Jain wrote:
> 
> 
>>>>    BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 
>>>> csum 0x373e1ae3 expected csum 0x98757625 mirror 1
> 
>>> However, a nit as below.
>>>
>>>> +        btrfs_warn_rl(fs_info,
>>>> +"csum failed root %lld ino %lld off %llu csum " CSUM_FMT " expected 
>>>> csum " CSUM_FMT " mirror %d",
>>>                                  ^ %llu
>>
>> Nope, that's intentional.
>>
>> Try to put -9 into that %llu output, and see which is easier to read, 
>> -9 or 18446744073709551607.
> 
>   Do you mean btrfs_ino(inode) can be -9?

Oh, you mean ino, then you're right.

Ino can not be minus in this case, all my bad.


> 
> 
>> Thanks,
>> Qu
>>>> +            inode->root->root_key.objectid, btrfs_ino(inode), 
>>>> file_off,
> 
>>>> +    btrfs_warn_rl(fs_info,
>>>> +"csum failed root %lld ino %llu off %llu logical %llu csum " 
>>>> CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
>>>> +            inode->root->root_key.objectid,
>>>> +            btrfs_ino(inode), file_off, logical,
>>>> +            CSUM_FMT_VALUE(csum_size, csum),
>>>> +            CSUM_FMT_VALUE(csum_size, csum_expected),
>>>> +            mirror_num);
