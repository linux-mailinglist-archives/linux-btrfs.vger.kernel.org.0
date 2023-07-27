Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F34765F14
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjG0WP0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjG0WPZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:15:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C24EE78;
        Thu, 27 Jul 2023 15:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690496118; x=1691100918; i=quwenruo.btrfs@gmx.com;
 bh=tHBaZvQYsrn4NKoqjXmpgLdFlBY9dtppWa7RAlofW5U=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=V3UDKpGc7iU/DJ3ORpOk0bh70AUo7SJ2jpljncKJNCzDwpZvnMT8xj57tE/2BKjv5QmMLLb
 bmRqbkx8Wd/l/6VbkwO5KZTfG8x/yf73mEClROl3KnfMpJHnCJfg1vfVft06jiuCNH4AlELBg
 8GeAADsL8879yFGnXjPYEHE5ZoxPTZ5CHZFnvsBrFuoyVYjrJinAvMW9kw/z8u54XywqtOIDn
 fjDAJCnPiSMicQ/Qaz/4CYhCwlHx6BE2Ln1JENmdCjPL07IDgjHvcXoR7bAKFluz/ODAczj85
 7/6nVEdsGqvAp/y/x44Tb+EWhxxODG7bxox+Aeh2OahXrXAz4J8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9g4-1qfcK13LbA-00GV7L; Fri, 28
 Jul 2023 00:15:18 +0200
Message-ID: <1ff02767-621c-01ac-66fe-7ff3be3b71db@gmx.com>
Date:   Fri, 28 Jul 2023 06:15:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs/294: reject zoned devices for now
To:     Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230724030423.92390-1-wqu@suse.com>
 <20230727155041.u5yr3rtxneqhq2vl@zlang-mailbox>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230727155041.u5yr3rtxneqhq2vl@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F031XwBHTjjwaK5gYDPutXSWrFtU7iS/4GUqPxTXGebE+3NJlK2
 3S0Y3leoouEp6yQXN79mr5rvKRyA5Ot3Ic9uCqRlAbcwiuv/WHti8i3GUioJ6mces4WzK9n
 ZMXV6pwn05F+w+8WkvZHfcE3LpcNbNReNc/pDpYkY3zPiQ8+4PudCEUtKx9QCGKVWzJoKdG
 lAqT1dGalc1tQRG2zSTcQ==
UI-OutboundReport: notjunk:1;M01:P0:PcMaKy9+iEg=;ba5Og9wdxauxGWpOd8WVzJU52mn
 wmXft8aVYjC50pWBDztwuhZoE0OB9oVVzlIo5upaYBRzBKBqNLwgxLQsP5eQMYfxZLAsvg7gG
 Yqk0++3Utoa7YjbkZYZtuNEx6juF880P8RJnnzinb17h5BHpWFibUH2EsOD4TXS5JTLDAg+nZ
 7PKJ/MPOMJoEvO0uXazZUlsWRpkm7kkm1ctld3NwRpjo3uwG/jo1a+QD/kQdXpVzHaE9Fu6ZD
 bnecwDOqHH2BTsOfVSK/z8EmMUkpA8DWyTsWIGxrUihovzNDnMRqWrVUc/oyNShGdLHkkxWrV
 XCJNch64NVU1JPTACYMvBK/0K7TJu/O7xYZ1//roRtP0dD1sajiXXIRNGALLdUqOXckQShDom
 AGGrGz4az91C5WiTVzvLcXm4gfVzs6R8Kf66+240et6xxFp5HinXxsXlj/ToD3S7cevkRjhUZ
 JnISrmK18Znq2Ru34gxfBcRas1Y6EuImywH9rRCaFDMR1XE7xYSlzic2Eh9sJUdYrkDdo9Exf
 dXV4HAWXOWpinRbcdaHFLIdKbBSrRHMz9sCFM9h0CGqoL7j52PPwdNRQkoeoI+SDWDVkHeL3Y
 E8DSqrquXu5whAIxiFVz/Y7pFNB0j1ckGh6+a0SaN0/Bn+Aa5tqiCmDWWPH7J/kCAEd1SlXF2
 PBbB9tnWVu/np6ODUPa9qF4sr+R/KALnfi/E4B5PfBHr756KCbzeJTVTfmMptlNHDlPR/1rRP
 +nu9Z6Q+qW81fozyOrFrhwx8w2DHEt/DwJmf5+a4Bj0XvTF8dxUqotjbeSJf8GOVK+7nHjEVf
 VK4f5m01NkfUisa6PS9dxxcnEpEaiHdQZac57fliNeig0hzN9HNIyjBTIAO7CjZnCA4o5ZR5M
 0I65UEk0M4oUXkRyUlKmCLpuyBDs5DZsJYhcBJUhSuCRSrB2OfdXqrDIp80I5d32FM+kupaCV
 YEM2LGuezeJeoU+IxznYyB1Dg6Y=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/27 23:50, Zorro Lang wrote:
> On Mon, Jul 24, 2023 at 11:04:23AM +0800, Qu Wenruo wrote:
>> The test case itself is utilizing RAID5/6, which is not yet supported o=
n
>> zoned device.
>>
>> In the future we would use raid-stripe-tree (RST) feature, but for now
>> just reject zoned devices completely.
>>
>> And since we're here, also update the _fixed_by_kernel_commit lines, as
>> the proper fix is already merged upstream.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>
> Just check before next fstests release. This patch has been reviewed, bu=
t looks
> like there're still more review points from btrfs list. So will you send=
 a new
> version to replace this patch?

IMHO the patch is fine to be merged for now.

The new comments are mostly a future work idea, which needs some time to
develop and extra kernel features.

Thanks,
Qu
>
> Thanks,
> Zorro
>
>>   tests/btrfs/294 | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/btrfs/294 b/tests/btrfs/294
>> index 61ce7d97..d7d13646 100755
>> --- a/tests/btrfs/294
>> +++ b/tests/btrfs/294
>> @@ -16,11 +16,15 @@ _begin_fstest auto raid volume
>>
>>   # Modify as appropriate.
>>   _supported_fs btrfs
>> +
>> +# No zoned support for RAID56 yet.
>> +_require_non_zoned_device "${SCRATCH_DEV}"
>> +
>>   _require_scratch_dev_pool 8
>>   _fixed_by_kernel_commit a7299a18a179 \
>>   	"btrfs: fix u32 overflows when left shifting @stripe_nr"
>> -_fixed_by_kernel_commit xxxxxxxxxxxx \
>> -	"btrfs: use a dedicated helper to convert stripe_nr to offset"
>> +_fixed_by_kernel_commit cb091225a538 \
>> +	"btrfs: fix remaining u32 overflows when left shifting stripe_nr"
>>
>>   _scratch_dev_pool_get 8
>>
>> --
>> 2.41.0
>>
>
