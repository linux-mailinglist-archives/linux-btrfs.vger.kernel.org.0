Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7579F57AA1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 00:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbiGSW6f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 18:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbiGSW6e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 18:58:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADFB62A5A
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 15:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658271501;
        bh=pYsHVogdCQqMIf7j4q7zsH3jaSP09MjNLXvV0qhjrF4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=A2HqIKrHGn990BHg1sImrNdWEWk8yOi+t9M0e1dstYRqQFE/VxWIF6CsiPj6k2akb
         6TeywtMS4YmZVKG13rY6pS4Z4lKwveTsL/ksqgCpjYjaZ1jy98QvVWZ8Fc88ywZn+d
         BnS+b2fjqyu80b+iw7O/jmN9dS5T1EPOVagad1AU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4s0t-1oC0MN440N-0022xP; Wed, 20
 Jul 2022 00:58:21 +0200
Message-ID: <3cfc9569-ff22-c04d-f7d0-fea1396ba4b5@gmx.com>
Date:   Wed, 20 Jul 2022 06:58:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] btrfs: make __btrfs_dump_space_info() output
 better formatted
Content-Language: en-US
To:     dsterba@suse.cz, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <dc40ddc78b7173d757065dcdde910bcf593d3a5c.1658207325.git.wqu@suse.com>
 <a5321725-1667-fd6f-2bfd-8ddb7b78d038@dorminy.me>
 <20220719213804.GT13489@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220719213804.GT13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UwXEvjc5Bz0rHNbHHrXPvY07E/FgaIR9qrepYSjReMnrpOOHfeu
 TOM6ooG43+b467vr7B7wZqqJASDQseJncGHSna/b22yFBfqU2M+yqrTb0nxyO+tc9BMeRlA
 XKX8SAAQJAFFFW+pk3RnsNvNaQrFcoBzlURax03fUusjl8xiEha6+5RmPoH2HZ2Bzmqswtx
 3EC0rCV7XAcy+1R8Uxd+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m9EH7r/MaG4=:MrL0yLAXQRo5TdwMXCpkvq
 EmbpmmV1PaH8/gAH2AODWDggutQ5rfm8MExxx778h4L2XTJ3l+mM4tHUv0sUCC6v1V1/y0D1g
 ifysKFV3JVhlsRkt4KtQ+SD4/ACaAzwtFP9w8p0/mvtmudpUQp4IUa5x6ixET5hik0XSpEsJf
 iMhNhkeKcYDUtkTOaNbfZoudLAwBz5nMYe06pleOh+9o/rVtlw/J3YJQomWeVVMjSR9r0W3fm
 9P191xU2GpLDdP2c7LgKf6nBrwhA/7UGB4kYRCRI7845BYaXpIn3d984b+Bhg7ZsCS1fkBjwK
 cV6hNoeDuZm19axyJiPn0N75JfkelWntY9fkuQbcuG4MfcuxtLcBRtivSsBUkBbAZf0IsFbxK
 3wZefsLfh/hu4gWstP7vryIUjFsLaT49hP2ht79TAqtR1LM3TOm0KmvoTbaMsR7r1JF7lFAMq
 Ugcqd0my6ytoH6LWT3OgLzqjb4AgodhuykulYnJRG1+nv87mxjgj9948pdpIlt0wIhfRPm9Ta
 S3iu1LLykRHIad6uyM8mIfBwmmTWX8OLu6FFu8EqtMvB9fWDvAIlJyhJscly/+qrj37PqF57J
 Z81qF+01/JD3V1Q/O4gI5KPbHuiZq5Yli3nkxgoodvbHovzRdI18BhJrx6XPkn8K7mHFCeNBj
 qG6WdcjlU1Kv/5pFsWlr075kMgR8Kmu++r8KcMpR5nsRfgRTekEpX5n3jL/p0n8lhhvDoTWs6
 XsoyPep9ZZ1bXYfhH4NZ+iF2VAWYiy2Jhl5Si3APtkVlE7BYbtROSJhnw1sR+KLDkxuPqoHp/
 zTxl/KSng2DGEHJ3oBg/0V4+PYXKSVNQNcBR2q1BoIy4ElomCeqzisFnyilQ9qiI9MoYntfWF
 F83IgFwvsvWUEk61L1c7zNKQDxHKP49E0FkIClJJ6Bv2FxpxrwxMelJ7FbmA1CfrK8x2YSruZ
 LRCzUP8JkJ/TrQxPAa6a7AW6jkqULMwHIuTO4Kd1m6jUAXWygcTMMTahtZDjWZEJl8CSyE8b6
 Std1eaHKE36gIdnDIQ+oRnwzLAbfrTD2RluHq32QdoTaZqszO0ywdcrEDrj2gy+tikTRhO5QM
 Put073KcHbgAcYrCAW6Y9GOYQVgPD9sDf5APECcKr/EcPdd6Howh0eEfA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/20 05:38, David Sterba wrote:
> On Tue, Jul 19, 2022 at 04:56:00PM -0400, Sweet Tea Dorminy wrote:
>> On 7/19/22 01:11, Qu Wenruo wrote:
>>>
>>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>>> index 36b466525318..623fa0488545 100644
>>> --- a/fs/btrfs/space-info.c
>>> +++ b/fs/btrfs/space-info.c
>>> @@ -475,11 +475,15 @@ static void __btrfs_dump_space_info(struct btrfs=
_fs_info *fs_info,
>>>    		   flag_str,
>>>    		   (s64)(info->total_bytes - btrfs_space_info_used(info, true)),
>>>    		   info->full ? "" : "not ");
>>> -	btrfs_info(fs_info,
>>> -		"space_info total=3D%llu, used=3D%llu, pinned=3D%llu, reserved=3D%l=
lu, may_use=3D%llu, readonly=3D%llu zone_unusable=3D%llu",
>>> -		info->total_bytes, info->bytes_used, info->bytes_pinned,
>>> -		info->bytes_reserved, info->bytes_may_use,
>>> -		info->bytes_readonly, info->bytes_zone_unusable);
>>> +	btrfs_info(fs_info, "  total:         %llu", info->total_bytes);
>>> +	btrfs_info(fs_info, "  used:          %llu", info->bytes_used);
>>> +	btrfs_info(fs_info, "  pinned:        %llu", info->bytes_pinned);
>>> +	btrfs_info(fs_info, "  reserved:      %llu", info->bytes_reserved);
>>> +	btrfs_info(fs_info, "  may_use:       %llu", info->bytes_may_use);
>>> +	btrfs_info(fs_info, "  read_only:     %llu", info->bytes_readonly);
>>> +	if (btrfs_is_zoned(fs_info))
>>> +		btrfs_info(fs_info,
>>> +			    "  zone_unusable: %llu", info->bytes_zone_unusable);
>>
>> I'm (perhaps needlessly) worried about splitting this up into six/seven
>> messages, because of the ratelimiting rolled into btrfs_printk. The
>> ratelimit is 100 messages per 5 * HZ, and it seems like it would be
>> unfortunate if it kicked in during the middle of this dump and prevente=
d
>> later info from being dumped.
>>
>> Maybe we should add a btrfs_dump_printk() helper that doesn't have a
>> ratelimit built in, for exceptional cases like this where we really,
>> really don't want anything ratelimited?
>
> Splitting the message is IMHO wrong thing, there are other subysystems
> writing to the log so the lines can become scattered or interleaved with
> the same message from other threads.

But that one line output is really hard to read for human beings.

Or do you mean that, as long as it's debug info, we should not care
about readability at all?

Thanks,
Qu
>
> We should prefer single line messages if possible, if not only for
> better grep-ability, pretty printing can be done by any utility that
> parses the logs.
>
> I did not think about the rate limiting, but you're right that it could
> be problematic.
