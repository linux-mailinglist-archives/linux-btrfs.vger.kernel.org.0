Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686F47A5692
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 02:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjISAbL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 20:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISAbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 20:31:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAB710D;
        Mon, 18 Sep 2023 17:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695083452; x=1695688252; i=quwenruo.btrfs@gmx.com;
 bh=MHPq8qo9npPhpYugDittIcKIzactLJBBUJ4cBZhJd8c=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=qvph1/CTXOba9WQtzi6TdpCV3NvycVTPAYbp9UleDs4A/va8UpVWRkL7kfClEhf0i9cEUVqCbz6
 /WqT7EKpCSYagZSWwbMjql1Fd6VYDRbwTD/hyk19XDzI5EPTFbJ8GTiNFusk13gtCpQuYz28+XTm0
 qko9tea4QzmcDH9PHsn0F9TOlusizcz1AjnyoKDAGX+CRDxQhA8Lars0riv02EBtWF9brrO54gkeN
 pKynf+t/Vd0V0X3xUdFh46q2AIwfaVinG8dI7zYzRWRBHJfzj+BMV6Hv0cb0bEtJHQIV+0qdNPITs
 Xry0wMKmZZ59xmj5JDGASRk21l6dldtaF7eQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McH9i-1rGLsV2yqK-00cglU; Tue, 19
 Sep 2023 02:30:52 +0200
Message-ID: <a0ea125f-7d1c-43f4-bf05-7b43853138c5@gmx.com>
Date:   Tue, 19 Sep 2023 10:00:46 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: add tree-checker for RAID-stripe-tree
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
 <20230918-rst-updates-v1-4-17686dc06859@wdc.com>
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
In-Reply-To: <20230918-rst-updates-v1-4-17686dc06859@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g6bYWNdMfKvCTqkZtQwKKqBND4Y9t/29A2bhSo83BTyeQTuYVv2
 f5TbTu6Li8eUBf95kmclO+PdG+r9lFXCPxx7WGQia0EERcfJI1qxrLSMia5+MY7907YFiM4
 +6aQ/YRN4k9HHanw0Nn203MHif8GPtNsnT8n8P4ooBCvkHdbyFKv80rTIu7ZmW18uqs+RN1
 uZBWPbfq0IaAyTTYQoPQw==
UI-OutboundReport: notjunk:1;M01:P0:5bp+MoIxxHs=;5DshjgHutg/cbKh0HQrOAbxeyvR
 gaRehHfGmDemgufUa+wMmeYAcM++41HDSmRTdP40+Up0ctmlqULr34YKS1WyxYoXcJ/01eK0S
 gra2kLx+oeIkYjWf7oQ/ahtFUWlqCbqZdgtlv8Llx+ZBzhwmeCcm2vs8k6fAmQV78QcQ2Dgxe
 /PZuwSSBaT+bAx8k+tNOjzbqOh2Y3UYJmrUA4qOvGXaYr9f6CZ/eIIN/0FLXmTq4grHdiwPw9
 7RdYqnJUIkVD5tdU1ZTepB4FofPQhYs9NYPQGG8iu/N1ddr2jvtJirag0TtOUF4+bQmuC0z6Y
 1j+34+eDX8RTd1dBAI6+ZX63utuPxaGcLMUDNydv5w6es67MwZYITIrO2Y0LiXTRstwhAtz6E
 8zoEmKyhUPFg/xNc2vRdyaNKx86KngOZtJnTVrv/fN/IKkCHZTAjVHSyeufMwT9Q/L433fqiM
 tR/tzUHQAcaGwJVeRdAYRU34qsHy4rUp9fxOh31g9b9Rzzopdg47xDKTW8eoktc3skquzdawx
 yZVC/DlQzmEsw/+VCfrz6rYkNb38csc4IedsL2FFhqwn0Wmybw1GwwBT+2AiNpBoALqqDqdh0
 IQPE6Bh8OUCQblhook2bizEHdR8ZL38aRiJEvvkMMZ6hCLAjfpiXtv8iG+0VcON8vtlHunW4a
 POBKVsL1Do4WoRKqN8Y/AYIyp5rtdr4oP4SczZoPwqFV6541ZV5rYJ8vpHsUBlSIM+47LlHxH
 6FkSYCq1+S+LN3DVfhW94529SSMekd+dPPS6H0UHeGlo4L/o5i2hK4laJ6fGHBWwiErF/BjvM
 W/qTfxI5U/FkBPdcBBfBjjkKkB0LDGb6Ep7gHVskELr5PlxTFw5Ud1D7NHlKQ1QAkn0V4by7a
 Y9BkGkSZiTJGG6uIk/ru72ER7LGioLiZE5mPDkak4nW63exo0kKyI2nqmyyH/NdhshIBcnYHr
 PCfTcF5qfYT2Ce103RUc8SvdksA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/18 23:44, Johannes Thumshirn wrote:
> Add a tree checker for RAID stripe tree items.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/tree-checker.c | 42 +++++++++++++++++++++++++++++++++++++++++=
+
>   1 file changed, 42 insertions(+)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 01bba79165e7..ea84ca2767e9 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -30,6 +30,7 @@
>   #include "file-item.h"
>   #include "inode-item.h"
>   #include "dir-item.h"
> +#include "raid-stripe-tree.h"
>
>   /*
>    * Error message should follow the following format:
> @@ -1635,6 +1636,44 @@ static int check_inode_ref(struct extent_buffer *=
leaf,
>   	return 0;
>   }
>
> +static int check_raid_stripe_extent(struct extent_buffer *leaf,
> +				    struct btrfs_key *key, int slot)
> +{
> +	struct btrfs_stripe_extent *stripe_extent =3D
> +		btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
> +
> +	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) {
> +		generic_err(leaf, slot,
> +"invalid key objectid for raid stripe extent, have %llu expect aligned =
to %u",
> +			    key->objectid, leaf->fs_info->sectorsize);
> +		return -EUCLEAN;
> +	}
> +
> +	if (unlikely(!btrfs_fs_incompat(leaf->fs_info, RAID_STRIPE_TREE))) {
> +		generic_err(leaf, slot,
> +	"RAID_STRIPE_EXTENT present but RAID_STRIPE_TREE incompat bit unset");
> +		return -EUCLEAN;
> +	}
> +
> +	switch (btrfs_stripe_extent_encoding(leaf, stripe_extent)) {
> +	case BTRFS_STRIPE_RAID0:
> +	case BTRFS_STRIPE_RAID1:
> +	case BTRFS_STRIPE_DUP:
> +	case BTRFS_STRIPE_RAID10:
> +	case BTRFS_STRIPE_RAID5:
> +	case BTRFS_STRIPE_RAID6:
> +	case BTRFS_STRIPE_RAID1C3:
> +	case BTRFS_STRIPE_RAID1C4:
> +		break;
> +	default:
> +		generic_err(leaf, slot, "invalid raid stripe encoding %u",
> +			    btrfs_stripe_extent_encoding(leaf, stripe_extent));
> +		return -EUCLEAN;
> +	}

Another thing we can check is the item size, the item size should be
aligned to a single record, or we can get garbage reading the last record.

Thanks,
Qu
> +
> +	return 0;
> +}
> +
>   /*
>    * Common point to switch the item-specific validation.
>    */
> @@ -1689,6 +1728,9 @@ static enum btrfs_tree_block_status check_leaf_ite=
m(struct extent_buffer *leaf,
>   	case BTRFS_EXTENT_DATA_REF_KEY:
>   		ret =3D check_extent_data_ref(leaf, key, slot);
>   		break;
> +	case BTRFS_RAID_STRIPE_KEY:
> +		ret =3D check_raid_stripe_extent(leaf, key, slot);
> +		break;
>   	}
>
>   	if (ret)
>
