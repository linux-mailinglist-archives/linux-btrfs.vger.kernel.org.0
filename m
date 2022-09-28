Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9535EE9C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 00:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiI1WzO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 18:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiI1WzH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 18:55:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18FD57BFE
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 15:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664405696;
        bh=kpp3MLcyqElzSxS37cjjdyNVNu/ihggr0wPVohNDVYk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CR0rPNnKB7ZX2EYEyLuAwSZRtDFvqkINtNz0DMV9mBB1kMFYUWKpLxEd4qwmft++Y
         bFMg5BBYw2vb1EW1WpvTLpAZc+QXAXMcoag2XsWuIKmIeB2aS6G/MVmFmTnD7gYVE8
         4MNl/aymluheOP9TIdD/Vx0CRXP1hnXdJ7UcpEr0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpDNf-1p1UhM2lKx-00qfEu; Thu, 29
 Sep 2022 00:54:56 +0200
Message-ID: <161d1b67-7f1a-877e-bfe5-84875f9d892e@gmx.com>
Date:   Thu, 29 Sep 2022 06:54:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH PoC v2 04/10] btrfs: scrub: introduce place holder helper
 scrub_fs_block_group()
To:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1664353497.git.wqu@suse.com>
 <ba1a99b5c44dd02a9ebb63cb95d8dc4080bd1949.1664353497.git.wqu@suse.com>
 <20220928223024.79F6.409509F4@e16-tech.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220928223024.79F6.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m9MiyOa41AX3LsJuAEaLbk12ZXBO69Ul9K0StDuzlsAw4iMyXpY
 bs+kraF2GyItHJJU4Q93jlPfi2zBKFaj1RW5NNuiMihcfyqixH+SrfxOU2byJUSC3OK4joS
 HzYh2vv+uLPrBU0AVT6QxHcQi2ZHpNHBhgzHV2mWP2CHNgm8sJTDYQYXizQFeYNfDvL38ba
 MZcluC/lYnLNXuNPYBwJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IjMxznfGQao=:7w7mT21qWlpxLJiMyeLRSf
 Vo3JvUdZvBd4MdvZAVk0FOgQOFdVF+Sm2Wk5pWGybFr8FwS8zTmhIKig4OAzpHKpMzhy+DC79
 Dow6MLI30f+6VbuJeDf3ibznV+w8UwtMFJaMYm6K2dujYGbYc3weiHogcwbpi7j6C2czDTGtf
 ClDZ9aEY9TZjbqMiUjuAt1TJ8iUBZhfU6KBpSB4Z7d05lWlbAp6XqM43nxj40uie5ChaBzO77
 GBhKTtYaT7+Pf2ag/QbqAhSjJhP/1lT+Iq2lfvMlWWSZTYqrpnfwGFtF/SQGtnEVpBVVXCCn6
 lnSssQ1u2b8Rn1kbkwGvXoP1/p20wV2dTHGw4bOtWp2FgykFFWkXvZKsfWwtT3OzGKXdyYbuh
 sWAwOLGMPpNX+ygr/BIIFW0LaQAKFpQI1vXLAqXpLuW37W7TE0zXS5TWZU11AEo8gAzqgU+T+
 ypLJaWk8c4KOLYlAC5Hh69hvMabWjUYLsiq+O+xSm/F74QV6dZ/7epPu1ozU01v0MHWzVA1Vl
 tDoKDb7Cxf+wTIjgwRyIDGky2hRBANERTrtqhuOkj6oL/phUvGZSwlH83LKBoRd2hUt0Rgrox
 gx3iIWv4jK1cGMdusTymU5PWOqvitlH+gufeBYEWR0ijlV9PPAP4LRbHS12OTbkB/b8BL56xM
 aNx5YFf4rp9kgmx0sf+eIr7oTRexWdbWJRotMNjmjdYCiUgcIapP6BA6mm/FcULgaiuJhaiWu
 11D3blOoz6wIUVT0b3UqugurkHkCRta3JK5DMvqSLGkhZvjVIxyVM9wyMVejMIn6+eT3AEbx8
 1w6ZehMN+YYeNwPmGLTj36AUsAg+WO/hwTdh3ywbfwL0LgF+kw3BnQu/o7MQfQOihAmFCMk4L
 IqcnNK43N5S6S6JPbJqZiGPIF/xMX1iq655fi6FKRoJm+9nFikSgYa6tWdRDCDZMTqy7ooxUI
 BnlsuYsmNTn7+mwPD+cUVmWHAlRndzdzgqdO6yy6QM/NTFZqARz0PVbgd8uY7mEtdpXy4JqYH
 DL26gSNTgQAcilXNYaJUmpWyfEoNmehtJkd5vxjWZC5kxFvbiL84pMExco7BCPetWgZmm7GcW
 F3+BsMRIG5Cbv4pUjD7SWKZyt2jJ2FrCE+oD4xOm+4RIB3w32o/BBvZe4xEErvqI1aavbE/8P
 m6m2syCC1JT2QrpCFidVXmpi0v
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/28 22:30, Wang Yugui wrote:
> Hi,
>
>> The main place holder helper scrub_fs_block_group() will:
>>
>> - Initialize various needed members inside scrub_fs_ctx
>>    This includes:
>>    * Calculate the nr_copies for non-RAID56 profiles, or grab nr_stripe=
s
>>      for RAID56 profiles.
>>    * Allocate memory for sectors/pages array, and csum_buf if it's data
>>      bg.
>>    * Initialize all sectors to type UNUSED.
>>
>>    All these above memory will stay for each stripe we run, thus we onl=
y
>>    need to allocate these memories once-per-bg.
>>
>> - Iterate stripes containing any used sector
>>    This is the code to be implemented.
>>
>> - Cleanup above memories before we finish the block group.
>>
>> The real work of scrubbing a stripe is not yet implemented.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/scrub.c | 234 ++++++++++++++++++++++++++++++++++++++++++++++=
-
>>   1 file changed, 232 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 97da8545c9ab..6e6c50962ace 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -198,6 +198,45 @@ struct scrub_ctx {
>>   	refcount_t              refs;
>>   };
>>
>> +#define SCRUB_FS_SECTOR_FLAG_UNUSED		(1 << 0)
>> +#define SCRUB_FS_SECTOR_FLAG_DATA		(1 << 1)
>> +#define SCRUB_FS_SECTOR_FLAG_META		(1 << 2)
>> +#define SCRUB_FS_SECTOR_FLAG_PARITY		(1 << 3)
>> +
>
> there is few use case for SCRUB_FS_SECTOR_FLAG_PARITY ?

For future RAID56 support.

>
> and we may need SCRUB_FS_SECTOR_FLAG_SYSTEM so we can match 'btrfs scrub
> start' well with 'btrfs balance start -d -m -s'

"System" is still metadata.

Please understand why we need system chunks first.

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/09/28
>
>
>
