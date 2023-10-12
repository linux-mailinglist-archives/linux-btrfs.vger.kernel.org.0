Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5196C7C6330
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 05:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjJLDHt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Oct 2023 23:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjJLDHs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 23:07:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F1A9
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 20:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1697080060; x=1697684860; i=quwenruo.btrfs@gmx.com;
 bh=dKe106GR/jq6hUYg0z1UQ5ACODTBjy81C4z8EpddGus=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=BWLGvQlYCUKeowdbeD6/1IVNriTvOJXo7hM6wVGiTlwVpQqGspcKh52/cp7WdTAI592MAqDubLf
 RY1xy1gnIJEg7hjxw1xSZjUzroLj3ZWUqac7wGErSi5ZogE/xeXDMP7Pk9BIvrQQ4rm98XYCfLw9O
 EdqcGiPPz1kga1/OAARnpoeE/K5Ly2rCfw9PjbLPvf9H36KXzTNAUnTOF6SAjkvtmKwe+2YvvQN9R
 ZBBoGSwMjkDpBn4KtZF0MDvDFtRrI9Na/myhFhviqkVIiZn68ktnokPW3rUt9WNUmFEEP76c9qn5x
 t8KeoRdfmjJINVYnTKVu0AE1VThx/QLmLg2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1poA-1qsyyB31bc-002FNZ; Thu, 12
 Oct 2023 05:07:40 +0200
Message-ID: <2fe9aa68-b73b-4c9e-98f6-fba59a401752@gmx.com>
Date:   Thu, 12 Oct 2023 13:37:35 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: output extra info when delayed inode update failed
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <aee666e094ffa89d5d4f6bc733230ae60ee3e6d8.1696573282.git.wqu@suse.com>
 <20231006143614.GF28758@twin.jikos.cz>
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
In-Reply-To: <20231006143614.GF28758@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nRTj7sjxFZBAGltLRqHT9S1QBK0h7c8HsITRLRiYTqbM2+maW+K
 iyEMM/h2azidoC4Wwu5YmiOgKSrvVdKd2LqtCU4hYpBZX4HGpRq14+rRWzoLbXTBbhYUnR+
 AAPfo0ysWY2gYnNceFnqcE0IfAUMACdlNkYyfAfx4jJsEDqU22AnX06skhJ5BPBTEj9moUa
 UQdd64Oln/aQBu1fe0nfg==
UI-OutboundReport: notjunk:1;M01:P0:nwlGFBPjFkg=;mXOYEVRurBtdEAXUrjdiBZh9tub
 2L7Cnc9h15MW9buVZdkZkpjm6Qyy8iJbCqqEgReGUsrg9+PboXKwU/vzTrtAfaiheDM//4/9V
 UBQHVxb2rLiUCPFELAK1J/i2KsJYMvdAoAyLuRtK8bi8PaJp+lRjDKYZtQ5hvOoOjfKH3lUm8
 GsQKAEYJybicXH1m+5+h7Pzb4plntneS2gEJGJVepx2x7xrEc3c7XOKj/xI2XgTiPgoZmTC2I
 thiHXZjUD+U18J5yrTuNPMeeTc3mIf+Q79NYHVy1UlCi47fhmZBqDtTx2UUJMhsb1LE5ogYsH
 sg0AdjhhR6cRB6TQ9cAC1ZPQKC9h+zloWljSNoGwUCBYaAsBVeqRJYw4lHGQrbypVY9kKDoR1
 Wu9qKL/yFVAdXONLJhz67CCNwSJcqDnpxOIgBO52PH0l1JZRdfudWMGbZ/TkNHtLbRbHgIr+c
 eGqlsEC1zfc/xmEkTv7CcsDMWzSnNvL+9wvS21lB8g49X6CowmW/KmRte/ZaJth00SR2izxuN
 WOH8w6RsfsT2S/2tn0pssKlq+nJfTCtmiIHJup/lV8HrxEMJlz7blzfsHFROwNdUoEO4sb06M
 XugiYIou6ZWe3Ilk0YlzCxECj2Pnck5Hd8yskKY2olWoNoJJ7Z4HbTZXExALKLauKKtN0zwrS
 /4TlmVcF4zl3BZsSCCkpR2TxpKsIsRhhakdFo+ZG4uibfX6bG3ohTC7kQ1sbxqoZ+b5SertUD
 16tR7PVJ+eUmoPLpl9kQWLTWG3olQKvZ5+nKJ6INfvHBXW06SnxcZbScDa+e7s62lq4gAqjHp
 2hru7Cq7KFN25WVPNkhRS1lG5+64E1koxa+3w8IiOIbTr+TQi0w+5ufUcLhhjonjT23MYYbOM
 q4JaXZDSU019+oC1V0khxdOiO5EWEpZGKc0sxl/QyU5gDrvbjsWmaG5ssBSHtD73Ko0wkPqmn
 nMkeCQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/7 01:06, David Sterba wrote:
> On Fri, Oct 06, 2023 at 04:52:09PM +1030, Qu Wenruo wrote:
>> There are at least 2 bug reports internally showing transaction abort
>
> Please add links to the reports

Unfortunately all internal suse bugzillas.

>
>> due to -ENOENT, from the btrfs_abort_transaction() call inside
>> __btrfs_run_delayed_items().
>>
>> For now I don't have a concrete idea on why, but strongly it's the
>> following call chain causing the problem:
>>
>> __btrfs_commit_inode_delayed_items()
>> `- btrfs_update_delayed_inode()
>>     `- __btrfs_update_delayed_inode()
>>        `- btrfs_lookup_inode()
>>
>> This patch would add extra debug for the involved call chain, with
>> possible leaf dump if needed.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> I strongly assume it's the the case described above, in that case the
>> fix would just follow btrfs_delete_delayed_inode() to exit early if no
>> inode item can be found, and not return -ENOENT.
>>
>> In that case, some debug here can also be removed as they would be too
>> noisy for regular operations.
>
> This is under the -- marker but somehow feels like it should be in the
> changelog to as it adds more context, you can add it as a Note: to make
> it separate from the regular changelog.

I'd prefer this to be hidden from the change log.
Although this indeed makes the whole patch more like an RFC.

And unfortunately I didn't hear the feedback from the reporter yet, thus
still not 100% sure if the above fix is correct.

>
>> ---
>>   fs/btrfs/delayed-inode.c | 30 ++++++++++++++++++++++++++----
>>   1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
>> index 35d7616615c1..1b05c7a818ec 100644
>> --- a/fs/btrfs/delayed-inode.c
>> +++ b/fs/btrfs/delayed-inode.c
>> @@ -19,6 +19,7 @@
>>   #include "space-info.h"
>>   #include "accessors.h"
>>   #include "file-item.h"
>> +#include "print-tree.h"
>>
>>   #define BTRFS_DELAYED_WRITEBACK		512
>>   #define BTRFS_DELAYED_BACKGROUND	128
>> @@ -1021,10 +1022,16 @@ static int __btrfs_update_delayed_inode(struct =
btrfs_trans_handle *trans,
>>   		mod =3D 1;
>>
>>   	ret =3D btrfs_lookup_inode(trans, root, path, &key, mod);
>> -	if (ret > 0)
>> +	if (ret > 0) {
>> +		btrfs_print_leaf(path->nodes[0]);
>>   		ret =3D -ENOENT;
>> -	if (ret < 0)
>> +	}
>> +	if (ret < 0) {
>> +		btrfs_err(fs_info,
>> +			"failed to locate inode item for root %lld ino %lld: %d",
>> +			root->root_key.objectid, node->inode_id, ret);
>>   		goto out;
>> +	}
>>
>>   	leaf =3D path->nodes[0];
>>   	inode_item =3D btrfs_item_ptr(leaf, path->slots[0],
>> @@ -1054,6 +1061,12 @@ static int __btrfs_update_delayed_inode(struct b=
trfs_trans_handle *trans,
>>   	 * in the same item doesn't exist.
>>   	 */
>>   	ret =3D btrfs_del_item(trans, root, path);
>> +	if (ret < 0) {
>> +		btrfs_print_leaf(path->nodes[0]);
>> +		btrfs_err(fs_info,
>> +		"failed to delete inode ref item, key (%llu %u %llu): %d",
>> +			  key.objectid, key.type, key.offset, ret);
>
> It looks like a return or goto error is missing here, if this is
> supposed to continue without that then please add a comment like
> /* Fallthrough */.

Would add the falthrough comment.

Thanks,
Qu
>
>> +	}
>>   out:
>>   	btrfs_release_delayed_iref(node);
>>   	btrfs_release_path(path);
>> @@ -1114,14 +1127,23 @@ __btrfs_commit_inode_delayed_items(struct btrfs=
_trans_handle *trans,
>>   	int ret;
>>
>>   	ret =3D btrfs_insert_delayed_items(trans, path, node->root, node);
>> -	if (ret)
>> +	if (ret) {
>> +		btrfs_err(trans->fs_info, "failedd to insert delayed items: %d",
>                                             ^^^^^^^
>
>> +			  ret);
>>   		return ret;
>> +	}
>>
>>   	ret =3D btrfs_delete_delayed_items(trans, path, node->root, node);
>> -	if (ret)
>> +	if (ret) {
>> +		btrfs_err(trans->fs_info, "failedd to delete delayed items: %d",
>                                             ^^^^^^^
>> +			  ret);
>>   		return ret;
>> +	}
>>
>>   	ret =3D btrfs_update_delayed_inode(trans, node->root, path, node);
>> +	if (ret)
>> +		btrfs_err(trans->fs_info, "failedd to update delayed items: %d",
>                                             ^^^^^^^
>
> typos
>
>> +			  ret);
>>   	return ret;
>>   }
>>
>> --
>> 2.42.0
