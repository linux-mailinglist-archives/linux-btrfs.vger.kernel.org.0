Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665C2776D41
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 02:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjHJA53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 20:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHJA52 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 20:57:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F91B1982
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 17:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1691629042; x=1692233842; i=quwenruo.btrfs@gmx.com;
 bh=G8nT9ZeOwiKfAVaYdCtbyD9wGwnmSAB81JqjMGjbHUU=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=QY2SrKHMgZvDnZgpxcyf6ZJziUtoPC6a+W83d8DCnW9YoJem5g9dP231TsbE4ODCgwOee9Q
 Tuy7lJAS/rkZ++nH0xxa/hzwJV9t+Tn+RKwJI3hQSuZrwAfl1Z6XUZADogABdk8w3keYh+8PC
 fYlmtF7eZTbjN6N3cfJMuUlneTb+1jLiaax3iywuMf7jYiVNvnqZwz5IDChaKGoTj6K56r/Iq
 UQ1yTw1kw91I3Y+BpBvLqWdPn3EKw/t9L0s7XvP8fEPL/pDaNIe/GSmMlAt0qgHBQwOmJehZC
 tAbqnlQ6Cpbthh/l5Ilw8G1ig4qKherzbdeLTGb4WUnIzucnIaEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3se8-1pm4lF40jQ-00zroz; Thu, 10
 Aug 2023 02:57:22 +0200
Message-ID: <ed1f5dfa-76ca-4e4b-8e5a-cfa09cef38d7@gmx.com>
Date:   Thu, 10 Aug 2023 08:57:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] btrfs: exit gracefully if reloc roots don't match
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
References: <cover.1691054362.git.wqu@suse.com>
 <30acf23be32724aa2cae7e85a6b88e039f290773.1691054362.git.wqu@suse.com>
 <ZNPoAZ6nNYdm8OOK@twin.jikos.cz>
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
In-Reply-To: <ZNPoAZ6nNYdm8OOK@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j5zpBi4CZN4wVEpav4y+3XMt36MYoqKK/6bR9wewIOJYypXVosf
 2qDCOKDkCUVPvIJbJmSUM87VOqQB9oJ9IJlZK4DEQWgZzUiYUBJaP0FQXliKtDmEr5A5V1I
 tcfz665Do7WNh1cmCdMfFjqNMbvZzuuToG2R5GuD7cuUSQ8s5LIQ+ayYHDjm2ccgzRIxBxZ
 WofLYrIsiWngjGi6lncIw==
UI-OutboundReport: notjunk:1;M01:P0:HhCDizQCCwg=;qv25McL8z7zMbG7QT/MAmbZTN3u
 rt8I5RN1LkMLx4HbGIkKMEEKp4q0M3LkVtiWLNkQPOywJDinZLg5yO3OYYiJWCl3gb+Jm6a6H
 eEVcDMfLxoNrZxn5mQQ82QSuEE/nI9hQXTQep4Epq8lhM1KDNr6fKJqIJ+gRYSPsQr56lvkMg
 cxcEBoG+rwZju8qNWOgIp9BUFJXGIJ725jT7FiSgeZxW2tBA9WSbRxd5N9xBy85p3hiTeE3f9
 EYH183lC02Al7ZpMxy+pGbH1O8gwMZxl4WhAYOBJylIHY1tArXQrCwoz/6Q9izVPsZd1nwoFB
 +Euk3heZaGNvLJvDfL6pf52+9EcxEXy/5+uNX+QVOiH55xkj+Dswt3OFChwrZK/DaM2J4MCnd
 QvY06WlGyPmHf8sIF2uagIJPZGdsThUDtphBzLtlMqnllaN/UjV3ymPHx0micnBG/ii+jk7/q
 bcYzTn9OxPk1ebxZEnkYTWvxr4rCH3u1BKElEBWITlv/De2vak+GNxwkX9ivChpBsbB+DUCqe
 5i2524wvjVJrg1lyVqQ09585VS65B9HrdqahjR7yrFzT41fCt2i7D2Z8JxdryGYZ0y4yaUPqD
 rWsWfA3ljx6f5/pIkT3wt9KB6RqmDCeR3CcapEK5i2w6f46xz62Urz/EuV3vqHsbe6YmkaPag
 FllmQ9bx/Hy/G0kRfhO7Tj1hrHryD776zPmgQMAFDyQz1L/uHRsa6EW4oQEm2jNGnlj8tctn+
 DPlG9IYzSubqOcBzzFrJ1q5kJttLjDwGq+c3DGcXxcbIO9kRjjB3jAl/PEk9dJwjglYzEA5mV
 I6lQJh+5lszRUb5XFsxXGoFU9cp4xAmTAN/L/c2JJfT3aY6v+V6JEDANzSTpfo1/MskTy0owz
 G88bd0n8DXZqif/dpry4aoAP6pRQZBPiewG/xiFMfGpWUccjNvtA7hZ9+stgpvYQ/66NY4brz
 7DOPVI5LMuYyndDCdedWDY9wAW0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/10 03:24, David Sterba wrote:
> On Thu, Aug 03, 2023 at 05:20:42PM +0800, Qu Wenruo wrote:
>> [BUG]
>> Syzbot reported a crash that an ASSERT() got triggered inside
>> prepare_to_merge().
>>
>> [CAUSE]
>> The root cause of the triggered ASSERT() is we can have a race between
>> quota tree creation and relocation.
>>
>> This leads us to create a duplicated quota tree in the
>> btrfs_read_fs_root() path, and since it's treated as fs tree, it would
>> have ROOT_SHAREABLE flag, causing us to create a reloc tree for it.
>>
>> The bug itself is fixed by a dedicated patch for it, but this already
>> taught us the ASSERT() is not something straightforward for
>> developers.
>>
>> [ENHANCEMENT]
>> Instead of using an ASSERT(), let's handle it gracefully and output
>> extra info about the mismatch reloc roots to help debug.
>>
>> Also with the above ASSERT() removed, we can trigger ASSERT(0)s inside
>> merge_reloc_roots() later.
>> Also replace those ASSERT(0)s with WARN_ON()s.
>>
>> Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/relocation.c | 44 +++++++++++++++++++++++++++++++++++-------=
-
>>   1 file changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 9db2e6fa2cb2..2bd97d2cb52e 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -1916,7 +1916,38 @@ int prepare_to_merge(struct reloc_control *rc, i=
nt err)
>>   				err =3D PTR_ERR(root);
>>   			break;
>>   		}
>> -		ASSERT(root->reloc_root =3D=3D reloc_root);
>> +
>> +		if (unlikely(root->reloc_root !=3D reloc_root)) {
>> +			if (root->reloc_root)
>> +				btrfs_err(fs_info,
>> +"reloc tree mismatch, root %lld has reloc root key (%lld %u %llu) gen =
%llu, expect reloc root key (%lld %u %llu) gen %llu",
>> +					  root->root_key.objectid,
>> +					  root->reloc_root->root_key.objectid,
>> +					  root->reloc_root->root_key.type,
>> +					  root->reloc_root->root_key.offset,
>> +					  btrfs_root_generation(
>> +						  &root->reloc_root->root_item),
>> +					  reloc_root->root_key.objectid,
>> +					  reloc_root->root_key.type,
>> +					  reloc_root->root_key.offset,
>> +					  btrfs_root_generation(
>> +						  &reloc_root->root_item));
>> +			else
>> +				btrfs_err(fs_info,
>> +"reloc tree mismatch, root %lld has no reloc root, expect reloc root k=
ey (%lld %u %llu) gen %llu",
>> +					  root->root_key.objectid,
>> +					  reloc_root->root_key.objectid,
>> +					  reloc_root->root_key.type,
>> +					  reloc_root->root_key.offset,
>> +					  btrfs_root_generation(
>> +						  &reloc_root->root_item));
>> +			list_add(&reloc_root->root_list, &reloc_roots);
>> +			btrfs_put_root(root);
>> +			btrfs_abort_transaction(trans, -EUCLEAN);
>> +			if (!err)
>> +				err =3D -EUCLEAN;
>> +			break;
>> +		}
>>
>>   		/*
>>   		 * set reference count to 1, so btrfs_recover_relocation
>> @@ -1989,7 +2020,7 @@ void merge_reloc_roots(struct reloc_control *rc)
>>   		root =3D btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
>>   					 false);
>>   		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
>> -			if (IS_ERR(root)) {
>> +			if (WARN_ON(IS_ERR(root))) {
>>   				/*
>>   				 * For recovery we read the fs roots on mount,
>>   				 * and if we didn't find the root then we marked
>> @@ -1998,17 +2029,14 @@ void merge_reloc_roots(struct reloc_control *rc=
)
>>   				 * memory.  However there's no reason we can't
>>   				 * handle the error properly here just in case.
>>   				 */
>> -				ASSERT(0);
>>   				ret =3D PTR_ERR(root);
>>   				goto out;
>>   			}
>> -			if (root->reloc_root !=3D reloc_root) {
>> +			if (WARN_ON(root->reloc_root !=3D reloc_root)) {
>>   				/*
>> -				 * This is actually impossible without something
>> -				 * going really wrong (like weird race condition
>> -				 * or cosmic rays).
>> +				 * This can happen if on-disk metadata has some
>> +				 * corruption, e.g. bad reloc tree key offset.
>
> Based on the comments, hitting that conditition is possible by corrupted
> on-disk, so the WARN_ON should not be here. I did not like the ASSERT(0)
> and I don't like the WARN_ON either. It's an anti-pattern and we should
> not spread it.
>
> Some hints and suggestions are documented here
> https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#handli=
ng-unexpected-conditions
> but we can make it more explicit how to them.

I don't like the WARN_ON() either, however I didn't have any better
idea/practice at that time.

For now, I believe WARN_ON() should only be utilized when there is a
strong need for a backtrace, and it's not covered by any existing
facility like btrfs_abort_transaction().

If we go that idea, the WARN_ON() is not needed at all, since the there
is only one call chain leading to the error, and the error message alone
is enough to locate the call chain.

For other situations where there are multiple call chains involved, we
may want to remove unnecessary WARN_ON(), with btrfs_abort_transaction()
closer to the error.

Would this idea be more practical?

Thanks,
Qu
