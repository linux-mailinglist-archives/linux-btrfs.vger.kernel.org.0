Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7E77EC4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Aug 2023 23:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346678AbjHPVzK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Aug 2023 17:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346699AbjHPVyp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Aug 2023 17:54:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76052723
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692222876; x=1692827676; i=quwenruo.btrfs@gmx.com;
 bh=xTvuXOXE7BO87hV2+GJTWBmibl67GUE8an6GI1NMsfA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=EMS/bfOAdcfFJEaS37FVIQh/c6qetdq1V1kx9qDzwkisNArjxCrt+sHeIlRZnPNTKasT5HJ
 +6GEmyrswBCj6lRSB6LYKexjW5sNLQkyH5i0nodT5JZ6vkG6CgYpV+WgYEsTVCl51cpX0Y3zf
 uwJpZgi7SSoOcaZqpEmYoTMW+c8HlxhXjEBaB7KtOM93nsf+TLkovz1NTZnZ5IQuYW7ISXwTv
 QHe9im2wJ7KMG/ybiOsjesKvMNqbuzelS5SI84xaYai6BqUrbsChwGp3S0RdRK5QRe5+HQe9Z
 2MJMUFBZuix1N3u/6rV+QfOIK6DDvLdXYL1izIOifMbqMNV4NSDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sHy-1qSYyv3cAc-004zvu; Wed, 16
 Aug 2023 23:54:36 +0200
Message-ID: <d34414eb-8ad1-4e9c-bb4d-6167ace2e480@gmx.com>
Date:   Thu, 17 Aug 2023 05:54:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: retry flushing for del_balance_item() if the
 transaction is interrupted
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <77ec19769e75c704cb260b98b41e33340a51c40c.1692181669.git.wqu@suse.com>
 <ZNzE6CFOzu9kDG+G@debian0.Home>
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
In-Reply-To: <ZNzE6CFOzu9kDG+G@debian0.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zqilS7j7LQbFCsh9rfbCFgWBjUDFTXpWNWQKt1+AMrcsJRywRtC
 yt7IsD/pyY5vTqjdHIdNcED64zesFePABvPGGrypJhO01jM498OjVJJ80ReIA0wpF7qO8Ga
 OfddRW0D/EzBzmP4cJhdxgTYMdDfXuDJbTb5Q/iBM18E9ZWRdL+px4LhRiebn/PSUaAme0X
 DrG6/e6b6s586sBhok5Bg==
UI-OutboundReport: notjunk:1;M01:P0:EdR+++5+NnY=;Leyvx0NpaJisBkVL181jXCTYG3i
 pLQch/sWSZDd24PcdBDNWCmnPEHuMDoikfxqu2uumViMQ1XYIJT/890Xe0DEx7lmlmsqNeM34
 2gAMajrVaAquIHdgYThtvAYlL7+/fmD/aAoUxHWxeNAA9da+jpsxDkgEgJ4aagS7FYyZzjFwt
 vjgeIbEWhW8ejYiIJLiSKvMFCDgj8R8JQDUMVadd++VGXL/xE9c22Ahtyn1Z2QX44KHkbMEHf
 SHa40J2igecF16+iJOr7VOBqG0KNLTwnbTe7M0S0oHY84WoYvY9rgGK3c1qfP3PU24TFE2tD8
 3urfLYMje8mkNGUDL4MTzqtFWbfwDYKJfBH715phEWp5Te++Wje7njhGCAPeOoe5pHiwZjBd3
 OJZZJU71uofNnYtY+5oOyuNG4RYiQPyP0EeMJzVbvcgzRNjUquCYcKy+MMZkt4m9LU6AS8N06
 ub2Ufg89CRxxTZp+4AH3aC1PEixMqOqG1IHmrxaF5gUkUwwn3UqHmf0o2r00tGDEsW0vyeS7i
 5J105S0tgTFVlrlTTLeHH1ghgtc9ovgMoANKV6C3bAxes8tTza2h7nDDWO88VOWNpOlGyN2aq
 T66KmKrcV2hq8K+XUWFdsIXAlcN3NY7ilar1FM1vAjwFCTnK0AiDUsIwTF+SCc9ZpZved24iB
 +c+wu37xqSsuS4nPMx2gKu4ksGRK5AXF4NJkKX4bPNW1tUUYR1DPquTJ4yWaSOTQYB4f0wJg3
 qo5+j4/5v7kQgduzvOZNx11gb4yFD8NJ0cZyKGZtpAY5BG9Ob4aCqgzVOEhKyfAyfcz4l0T+d
 dcjUKNGRAUewhTYgvW6u2ZxKf1a3XuFsWkCON+5Uu+G7sEzHM7OZ4W0HjHHlUuhwvgQPElmDO
 gg9kcDLenT8u5FzhAYtqI+Ubv0gJznTcBh4vBNn2cEGstKMACbrxiPfbgLpEBc8QH31cNERXH
 hcKErIFXdeWn4Smvbn4JFwoa39c=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/16 20:45, Filipe Manana wrote:
> On Wed, Aug 16, 2023 at 06:28:16PM +0800, Qu Wenruo wrote:
>> [BUG]
>>
>> There is an internal bug report that there are only 3 lines of btrfs
>> errors, then btrfs falls read-only:
>>
>>   [358958.022131] BTRFS info (device dm-9): balance: canceled
>>   [358958.022148] BTRFS: error (device dm-9) in __cancel_balance:4014: =
errno=3D-4 unknown
>>   [358958.022150] BTRFS info (device dm-9): forced readonly
>>
>> [CAUSE]
>> The error number -4 is -EINTR, and according to the code line (although
>> backported kernel, the code is still relevant upstream), it's the
>> btrfs_handle_fs_error() call inside reset_balance_state().
>>
>> This can happen when we try to start a transaction which requires
>> metadata flushing.
>>
>> This metadata flushing can be interrupted by signal, thus it can return
>> -EINTR.
>>
>> For our case, the -EINTR is deadly because we don't handle the error at
>> all, and immediately mark the fs read-only in the following call chain:
>>
>> reset_balance_state()
>> |- del_balance_item()
>> |  `- btrfs_start_transation_fallback_global_rsv()
>> |     `- start_transaction()
>> |	 `- btrfs_block_rsv_add()
>> |	    `- __reserve_bytes()
>> |	       `- handle_reserve_ticket()
>> |		  `- wait_reserve_ticket()
>> |		     `- prepare_to_wait_event()
>> |			This wait has TASK_KILLABLE, thus can be
>> |			interrupted.
>> |			Thus we return -EINTR.
>> |
>> |- IS_ERR(trans) triggered
>> |- btrfs_handle_fs_error()
>>     The fs is marked read-only.
>>
>> [FIX]
>> For this particular call site, we can not afford just erroring out with
>> -EINTR.
>>
>> This patch would fix the error by retry until either we got a valid
>> transaction handle, or got an error other than -EINTR.
>>
>> Since we're here, also enhance the error message a little to make it
>> more readable.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/volumes.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 189da583bb67..e83711fe31bb 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -3507,7 +3507,15 @@ static int del_balance_item(struct btrfs_fs_info=
 *fs_info)
>>   	if (!path)
>>   		return -ENOMEM;
>>
>> -	trans =3D btrfs_start_transaction_fallback_global_rsv(root, 0);
>> +	do {
>> +		/*
>> +		 * The transaction starting here can be interrupted, but if we
>> +		 * just error out we would mark the fs read-only.
>> +		 * Thus here we try to start the transaction again if it's
>> +		 * interrupted.
>> +		 */
>> +		trans =3D btrfs_start_transaction_fallback_global_rsv(root, 0);
>> +	} while (IS_ERR(trans) && PTR_ERR(trans) =3D=3D -EINTR);
>
> This condition can be simply:  trans =3D=3D ERR_PTR(-EINTR)
>
> My only concern is if this can turn into an infinite loop due to a high =
enough rate of
> signals being sent to the process...

Yep, that's indeed a concern.

The other solution is to introduce a flag to disallow signal for the
ticket system (aka non-killable wait), which can get rid of the frequent
signal problems.

In fact, we may not want certain reclaim to be interrupted at all,
especially for BTRFS_RESERVE_FLUSH_ALL_STEAL, which are only utilized
for very critical operations like unlink and other deletion operations.

>
> Instead of this I would make reset_balance_state() just print a warning,=
 and not
> call btrfs_handle_fs_error()  and then change insert_balance_item() to n=
ot fail in
> case the item already exists - instead just overwrite it.

This means, if a unlucky interruption happened, the left balance item
can cause us to resume a balance on the next mount, which can be
unexpected for the end user.

Thanks,
Qu
>
> Thanks.
>
>
>>   	if (IS_ERR(trans)) {
>>   		btrfs_free_path(path);
>>   		return PTR_ERR(trans);
>> @@ -3594,7 +3602,7 @@ static void reset_balance_state(struct btrfs_fs_i=
nfo *fs_info)
>>   	kfree(bctl);
>>   	ret =3D del_balance_item(fs_info);
>>   	if (ret)
>> -		btrfs_handle_fs_error(fs_info, ret, NULL);
>> +		btrfs_handle_fs_error(fs_info, ret, "failed to delete balance item")=
;
>>   }
>>
>>   /*
>> --
>> 2.41.0
>>
