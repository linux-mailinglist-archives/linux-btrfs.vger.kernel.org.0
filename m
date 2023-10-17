Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B623D7CCDAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjJQUOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 16:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjJQUOd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 16:14:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5449F6FB2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1697573664; x=1698178464; i=quwenruo.btrfs@gmx.com;
 bh=wwPt5kWBCDcoVBIhqMk+kFhyUcbY0DdLr9d8CC/D4hQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Uxj6Z9BMjxoAyRO6x36tTP1n6Nl/50dDCNwzvYx8lroCb3GuqtiucL1SRQYX3wUyMvWRygRVUTd
 Sue6bwq6VlQ8IzShgDlq++2u/K0LR1cU0Xq3+TbrJkJNae9XTlTp6i4Tg+RpKXyTmFzu+wCh0rkah
 fcis0BNT3Ex4SJdqC9xUmyc8umXAXyXpegsn3UpeFGsCNQqqSdXlTki6L6rCQtBShH8ihth9sjrDc
 L/eDcMROd54O3RVA+yhZWLyjr9qmml2lET/gd7zoxZrs4XHym8OSZIp+adrmWkv4FygsDmMd3TGSw
 FzqlVgHxIsTPuHl+eCGdW9+j2hj6tsrlnNDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmDEm-1rJ4XP3qzY-00iFe9; Tue, 17
 Oct 2023 22:14:24 +0200
Message-ID: <3df53251-41f6-4655-a0fe-a7baecb2a66d@gmx.com>
Date:   Wed, 18 Oct 2023 06:44:22 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] btrfs-progs: use a unified btrfs_make_subvol()
 implementation
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1697430866.git.wqu@suse.com>
 <7b951f3a0619880f35f2490e2e251eb35e2f2292.1697430866.git.wqu@suse.com>
 <20231017134929.GA2350212@perftesting>
Content-Language: en-US
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
In-Reply-To: <20231017134929.GA2350212@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BC0Dmhwsg6YClHteABZulw8wQfWkXnxbcUOeBFW45xdCZM1Z0OJ
 OJOt64xOkQfeY5MTdNJ81bnXvqW2rNiCEk3Gd7y1SnOHh6OOvJ8fA+DpHVBz94vzPUGbVCA
 EP3wXCsp6jf4tUKgbU4AsgJjr1VPiRxeRBI9hmuEbMaymTiYdzcWEZuQgJD8TK8MXIYcBJq
 p66bDaNgP9KutAhEVb4gw==
UI-OutboundReport: notjunk:1;M01:P0:uxVvd8KUhkQ=;KF6SvUcagIHnr1GFBzp0y5OEBLg
 y7CSqcJmrwrp1MBxJR4WK8t1bPjC0qyk/6UXp97C8cfc44mpHLro/wi9BHO7T5I5WFlwzIuUS
 x1N54gGW1S9CJkr0QhMuwyJ9rsnh19rlQziVCUjDpR0lKMI65y8f/+FEEst1iEWYspt6Giwhf
 +Gmtnce2NDARMP9nVKjbJxaG2WmgsZRFahN43XNa5ikQm7Y5eBNjSNoF3rgDVV031GvTBIZoa
 zPObqyoXG/RMW+IbGmEQQKpxxwvH8tI8Mcq81HOpLcnWnuE3EZu9dZ03gAUgHAI7UqiZXj+c3
 XRPZ3m89vEOG/B8YUQDPeTo1a1g6EdUqygKmMOym49vbGYMitKuokPaTj3cvBPRXPu+XS+4ya
 GYNcxagRFR+RZIEPzz/0loSmXfGKCUUS/OTaJIa8VV70s7Vvg+LlpiZmYJsg0TAfpBysjz4l3
 GX1wA8ZQz0qz5wFHozWOdLUf1HgXUzSKBONjYyVHOWroF4Rz3o9NzOjgmeskeieKeiep6Dw5l
 VMITnJF0H+yq1hwdpcNUQdM+qsYOSjWeXqnXM4dF3yktRXkdhvLYmk37Ti7hdikYnqR6Df8Ji
 nMRCuGgGOvZP3AiJ6n0zXEKiJy0r73OC/QoajI9s3m8S+vDlYilLXVp+2cbR9LrgCfNDQPw5D
 MLZ+2GRYL5x2kwEqWsrhUtCNlOl8jPlA3pJ2aR7lHP31A1OS77kYgVnNtSTKpdeKsPB1jy1H5
 9h6K/LFaWyrv7q/UFp/7fKeoO4eG9Rc6P8fIepPZleXAzkY5EMGqUruTZAx/9+Qnq5ERMKb6y
 dV5hcOCq8R1BOQiBLnyqUJMzzrx8ZruiNkEWepUWsF9zMz/goEsb9twrnPRI0JcQAbDfgfjq8
 sM3eGzKfH16hy5Fsxp4oWIqovY+9kVZjm69GTxtH8vrQRRqyxjnBoaMOAZJ5yyvpFyA6ZLvts
 JfpZYIcBHu/LJefg9GYE7y3IoVc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/18 00:19, Josef Bacik wrote:
> On Mon, Oct 16, 2023 at 03:08:50PM +1030, Qu Wenruo wrote:
>> To create a subvolume there are several different helpers:
>>
>> - create_subvol() from convert/main.c
>>    This relies one using an empty fs_root tree to copy its root item.
>>    But otherwise has a pretty well wrapper btrfs_ake_root_dir() helper =
to
>>    handle the inode item/ref insertion.
>>
>> - create_data_reloc_tree() from mkfs/main.c
>>    This is already pretty usable for generic subvolume creation, the on=
ly
>>    bad code is the open-coded rootdir setup.
>>
>> So here this patch introduce a better version with all the benefit from
>> the above implementations:
>>
>> - Move btrfs_make_root_dir() into kernel-shared/root-tree.[ch]
>>
>> - Implement a unified btrfs_make_subvol() to replace above two implemen=
tations
>>    It would go with btrfs_create_root(), and btrfs_make_root_dir() to
>>    remove duplicated code, and return a btrfs_root pointer for caller
>>    to utilize.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   convert/main.c            | 55 +++++--------------------
>>   kernel-shared/ctree.h     |  4 ++
>>   kernel-shared/root-tree.c | 86 ++++++++++++++++++++++++++++++++++++++=
+
>>   mkfs/common.c             | 39 ------------------
>>   mkfs/common.h             |  2 -
>>   mkfs/main.c               | 78 +++--------------------------------
>>   6 files changed, 107 insertions(+), 157 deletions(-)
>>
>> diff --git a/convert/main.c b/convert/main.c
>> index 73740fe26d55..453e2c003c20 100644
>> --- a/convert/main.c
>> +++ b/convert/main.c
>> @@ -915,44 +915,6 @@ out:
>>   	return ret;
>>   }
>>
>> -static int create_subvol(struct btrfs_trans_handle *trans,
>> -			 struct btrfs_root *root, u64 root_objectid)
>> -{
>> -	struct extent_buffer *tmp;
>> -	struct btrfs_root *new_root;
>> -	struct btrfs_key key;
>> -	struct btrfs_root_item root_item;
>> -	int ret;
>> -
>> -	ret =3D btrfs_copy_root(trans, root, root->node, &tmp,
>> -			      root_objectid);
>> -	if (ret)
>> -		return ret;
>> -
>> -	memcpy(&root_item, &root->root_item, sizeof(root_item));
>> -	btrfs_set_root_bytenr(&root_item, tmp->start);
>> -	btrfs_set_root_level(&root_item, btrfs_header_level(tmp));
>> -	btrfs_set_root_generation(&root_item, trans->transid);
>> -	free_extent_buffer(tmp);
>> -
>> -	key.objectid =3D root_objectid;
>> -	key.type =3D BTRFS_ROOT_ITEM_KEY;
>> -	key.offset =3D trans->transid;
>> -	ret =3D btrfs_insert_root(trans, root->fs_info->tree_root,
>> -				&key, &root_item);
>> -
>> -	key.offset =3D (u64)-1;
>> -	new_root =3D btrfs_read_fs_root(root->fs_info, &key);
>> -	if (!new_root || IS_ERR(new_root)) {
>> -		error("unable to fs read root: %lu", PTR_ERR(new_root));
>> -		return PTR_ERR(new_root);
>> -	}
>> -
>> -	ret =3D btrfs_make_root_dir(trans, new_root, BTRFS_FIRST_FREE_OBJECTI=
D);
>> -
>> -	return ret;
>> -}
>> -
>>   /*
>>    * New make_btrfs() has handle system and meta chunks quite well.
>>    * So only need to add remaining data chunks.
>> @@ -1012,6 +974,7 @@ static int make_convert_data_block_groups(struct b=
trfs_trans_handle *trans,
>>   static int init_btrfs(struct btrfs_mkfs_config *cfg, struct btrfs_roo=
t *root,
>>   			 struct btrfs_convert_context *cctx, u32 convert_flags)
>>   {
>> +	struct btrfs_root *created_root;
>>   	struct btrfs_key location;
>>   	struct btrfs_trans_handle *trans;
>>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>> @@ -1057,15 +1020,19 @@ static int init_btrfs(struct btrfs_mkfs_config =
*cfg, struct btrfs_root *root,
>>   			     BTRFS_FIRST_FREE_OBJECTID);
>>
>>   	/* subvol for fs image file */
>> -	ret =3D create_subvol(trans, root, CONV_IMAGE_SUBVOL_OBJECTID);
>> -	if (ret < 0) {
>> -		error("failed to create subvolume image root: %d", ret);
>> +	created_root =3D btrfs_create_subvol(trans, CONV_IMAGE_SUBVOL_OBJECTI=
D);
>> +	if (IS_ERR(created_root)) {
>> +		ret =3D PTR_ERR(created_root);
>> +		errno =3D -ret;
>> +		error("failed to create subvolume image root: %m");
>>   		goto err;
>>   	}
>>   	/* subvol for data relocation tree */
>> -	ret =3D create_subvol(trans, root, BTRFS_DATA_RELOC_TREE_OBJECTID);
>> -	if (ret < 0) {
>> -		error("failed to create DATA_RELOC root: %d", ret);
>> +	created_root =3D btrfs_create_subvol(trans, BTRFS_DATA_RELOC_TREE_OBJ=
ECTID);
>> +	if (IS_ERR(created_root)) {
>> +		ret =3D PTR_ERR(created_root);
>> +		errno =3D -ret;
>> +		error("failed to create DATA_RELOC root: %m");
>>   		goto err;
>>   	}
>>
>> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
>> index 1dda40e96a60..ea459464063d 100644
>> --- a/kernel-shared/ctree.h
>> +++ b/kernel-shared/ctree.h
>> @@ -1134,6 +1134,10 @@ int btrfs_update_root(struct btrfs_trans_handle =
*trans, struct btrfs_root
>>   		      *item);
>>   int btrfs_find_last_root(struct btrfs_root *root, u64 objectid, struc=
t
>>   			 btrfs_root_item *item, struct btrfs_key *key);
>> +int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
>> +			struct btrfs_root *root, u64 objectid);
>> +struct btrfs_root *btrfs_create_subvol(struct btrfs_trans_handle *tran=
s,
>> +				       u64 objectid);
>>   /* dir-item.c */
>>   int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, struct bt=
rfs_root
>>   			  *root, const char *name, int name_len, u64 dir,
>> diff --git a/kernel-shared/root-tree.c b/kernel-shared/root-tree.c
>> index 33f9e4697b18..1fe7d535fdc7 100644
>> --- a/kernel-shared/root-tree.c
>> +++ b/kernel-shared/root-tree.c
>
> We're moving towards a world where kernel-shared will be an exact-ish co=
py of
> the kernel code.  Please put helpers like this in common/, I did this fo=
r
> several of the extent tree related helpers we need for fsck, this is a g=
ood fit
> for that.  Thanks,

Sure, and this also reminds me to copy whatever we can from kernel.

I'll update this with possible more copy from kernel.

Thanks,
Qu
>
> Josef
