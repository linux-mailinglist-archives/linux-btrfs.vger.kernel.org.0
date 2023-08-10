Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B57776D6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 03:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjHJBNs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 21:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjHJBNq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 21:13:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59944E45
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 18:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1691630020; x=1692234820; i=quwenruo.btrfs@gmx.com;
 bh=Vo5wgzmF6rp8UAP6Z1Col9GOf8tIPPTZOZGkM1WGFo8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=q78qZllbVxuuDv34rZE/dtgULYkLo13MWqDmAvqWhWX0SJPz49db0D4rrMa7g127JwxhxIZ
 3iY8alXMvaY76dk7e1l8D34EAOyGd9OuCa16B//kbM9SIKeIfyw+vDKFfaGRolru3DIuZnToi
 gX1jU4GEzWLKQ3E0tEpGrjym9QaEGGP695jnmQUy5bDdVth57mz5ud5gmvL7kFMjsWFaF532m
 a5EmtO8Uq6CVM7rs9/dk83zGo25Ee5mQP+sEkiZ2YmNaeY5sLSQPKdKe2e+6ezNsLdOaRB9D1
 S5dtt0Q3+pYy6KIBsTfC2JTZQIZ/elarrqQX1+6hEz7UAYuzBcvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbBu-1pcltK0PUU-00sgC9; Thu, 10
 Aug 2023 03:13:40 +0200
Message-ID: <4c05089c-2686-4531-a8ed-24f82302271e@gmx.com>
Date:   Thu, 10 Aug 2023 09:13:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: handle errors properly in
 update_inline_extent_backref()
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <7a56e967d536bbb3d40c90def6e59e9970ef3445.1691564698.git.wqu@suse.com>
 <ZNPiKFZ40tjHUQnr@twin.jikos.cz>
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
In-Reply-To: <ZNPiKFZ40tjHUQnr@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+6hvulHXfZLENbR/e11+quGNmnpK0O6pbMRdEh2vnwsKOpjihuG
 i4Wswfp7Yfo6355YARUrKrl+r5NF5wqQCj3vz2TtqfOLOls4kgSjUsHWPlxGXLTw1Xf084l
 yAaBPtTU9XhGMuOPWS/Yg8gJitwlQ7Fc4RAWZNK95tzLwUvWOB3DL9yqwkRjkW+T2EMLtlD
 JuXXRkUGGJht5vTkw4d8w==
UI-OutboundReport: notjunk:1;M01:P0:WUQguHzwWCw=;8bjjUV3qtN5IE2gg9NcNHF/ki9S
 OY91tE7HGBTDv2b4QyjavguZrcpxFEtz2FAv57yCZlhgiL8xIA0KqUrXQNWwjiuR5VwJDMHkT
 HT7grb/ymGJOLb/zr+w+LsRfp/iiGH849riDb5RWbKUI6BmBOE8Rh+GUE0fzdaU6Cv+wTx1a2
 cFowvW+nzWb7dcxRKr0HsY9AqRiXev19BuTnqBYjzgp7s3qBzXAn0rc0U+OJshFOuv6kk8Su6
 ivczf6X+v0fs/CoO99za9B/hU5eMv1aLqUOdyWp0bu9o4pUMUKLZT4aoUBlfceEdxRtDSMNT1
 0q51h4t/pJmS6n8Z40Yy8ne6SDqywSyAO0anflErdI73eMfrif375x4AUVa3sLohTWMVGIWY5
 G6WJls+7puPfStcU1ColipC1ECLlqWgyOh1yku3aGJ6s8Wh/tryikt2PQb6ac+aUUeM4eVkgb
 dqC4pE1XBsgTdoPWm+TT2w06DxngmphwetoVYsO8c3Z2N5iziQnsNTS2X2XbnPlxdrkgliF4S
 Zijcaa/W7cO5IYCimlXJdSHcEyzGXPRz72g4lb4uSJXsVPwxYhW6TU0T45nzItKSoDbTS9pP9
 64Q2hsRqpGO6kjB2odUq5RYkbQjar7fv0HgoTZ4R1rE27s6xDduvTRPiFv1pdV6jeXWA/8nwh
 q8GGY9eZFtr9rtbN9s75lxgD6tPwnX6bzUVcV/FJW5/CR0V9p//fwkaiZHFwMUgisbDeW4G2M
 oyhDOnwCxMdMern4JOyboB8rvCrHKrPUW+UVD+lVuWD1muhzSYZ5dIxw+aCifC/75netqJkfA
 ttkmZpqnugq3lzjked3fUDGVw2sn4QLs19JbSLgmFQ9Kuq0LLlHgd9aSpqvVwAjnmp1u/VfKu
 W5Y9KMwnUmXSHAMLkub1udU+2HxeUJ88DXcq+/mYdoUGKwqwpF6STNm/KZ+AMCy5AO6Fp2fHC
 yEzPhlrmoTeNfkoo+0iR5yevU7c=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/10 02:59, David Sterba wrote:
> On Wed, Aug 09, 2023 at 03:08:21PM +0800, Qu Wenruo wrote:
>> [PROBLEM]
>> Inside function update_inline_extent_backref(), we have several
>> BUG_ON()s along with some ASSERT()s which can be triggered by corrupted
>> filesystem.
>>
>> [ANAYLYSE]
>> Most of those BUG_ON()s and ASSERT()s are just a way of handling
>> unexpected on-disk data.
>>
>> Although we have tree-checker to rule out obviously incorrect extent
>> tree blocks, it's not enough for those ones.
>>
>> Thus we need proper error handling for them.
>>
>> [FIX]
>> Thankfully all the callers of update_inline_extent_backref() would
>> eventually handle the errror by aborting the current transaction.
>>
>> So this patch would do the proper error handling by:
>>
>> - Make update_inline_extent_backref() to return int
>>    The return value would be either 0 or -EUCLEAN.
>>
>> - Replace BUG_ON()s and ASSERT()s with proper error handling
>>    This includes:
>>    * Dump the bad extent tree leaf
>>    * Output an error message for the cause
>>      This would include the extent bytenr, num_bytes (if needed),
>>      the bad values and expected good values.
>>    * Return -EUCLEAN
>>
>>    Note here we remove all the WARN_ON()s, as eventually the transactio=
n
>>    would be aborted, thus a backtrace would be triggered anyway.
>>
>> - Better comments on why we expect refs =3D=3D 1 and refs_to_mode =3D=
=3D -1 for
>>    tree blocks
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent-tree.c | 80 ++++++++++++++++++++++++++++++++++-------=
-
>>   1 file changed, 65 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 3cae798499e2..45e325523e81 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -381,11 +381,11 @@ int btrfs_get_extent_inline_ref_type(const struct=
 extent_buffer *eb,
>>   		}
>>   	}
>>
>> +	WARN_ON(1);
>>   	btrfs_print_leaf(eb);
>>   	btrfs_err(eb->fs_info,
>>   		  "eb %llu iref 0x%lx invalid extent inline ref type %d",
>>   		  eb->start, (unsigned long)iref, type);
>> -	WARN_ON(1);
>
> Do we even want to print the warning here? There's the whole leaf, error
> message, why would we need the stack trace?

Following the principle I mentioned in another thread, you're right, we
don't need the warning as long as we move the transaction abort closer
to the error site.

Otherwise we have two possible sites calling this function, thus harder
to locate the real call chain.

Thanks,
Qu
