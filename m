Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67687B1183
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 06:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjI1E0m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 00:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1E0l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 00:26:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F640114;
        Wed, 27 Sep 2023 21:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695875194; x=1696479994; i=quwenruo.btrfs@gmx.com;
 bh=9lySKOxaGxpPFC8m8YAGAL2mtQmyg6MUdtJrjRtNDiM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cGxLyvdGsGochVgJ7rjjOq89lzwS7l8z+45UGJLcNgFo5LYb7959mv4/8IM9dtcdygdzf1yAtyq
 ijg3qXkVMWPbVe/q7tC/Ky7ClMdSuGfjqSZSWaYrFIDcIty7EOm1RNk45QDeis37z6RO49GEjzUp+
 xjHcs8lQh7aXm6TJgc3w5fAoSdA4nFfR+gQHMNLhXas0eCBd72sYRQ+z7mmYkN0pTVpMCUoaoFs34
 g4UAYgZmXQVOEcyA5cu42S8vIKCGoM+e0P/YaCWLQe8Ywv+tYDkDcM/KxrlODhHFyYSPz7nq0NHY8
 ITSsvSam8m9/USGQpi/ZekQPxGTaBsCIBvLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.112.26] ([173.244.62.10]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYvcG-1r7pwv1bKC-00UtC8; Thu, 28
 Sep 2023 06:26:33 +0200
Message-ID: <dfc4cece-d809-4b5b-93f7-7251ba3a492a@gmx.com>
Date:   Thu, 28 Sep 2023 13:56:29 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fstests: add configuration option for executing post
 mkfs commands
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com
References: <cover.1695543976.git.anand.jain@oracle.com>
 <eff4da60fe7a6ce56851d5fc706b5f2f2d772c56.1695543976.git.anand.jain@oracle.com>
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
In-Reply-To: <eff4da60fe7a6ce56851d5fc706b5f2f2d772c56.1695543976.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:og0r2XXJIV/BmNeKJj9HDM3vGSeHyfQFVRr865oJnu6xnt96QLd
 Hv8+FL0ZmwRhj+1VM7MUU4+5tHlUDvFNxYvuBAdIfOmuFzLUc5riAow7NmJZHRNBC9KpCva
 ffACmWTXowLtXzaiaSkfTYh4zqbdjSqU6RZwdUidkurUjQUMKMlzaKkrlr8SzWkqidvKwVf
 XVZuZeXyfPc54J6vSjC5g==
UI-OutboundReport: notjunk:1;M01:P0:oJq4Vz7ReBw=;sKY/M4o8y0+b2Gy5Yhq0SLKSY/D
 tuWbYTv766lmBcuY27zJjl+9L9rbyomuSJcpvX5C39S0YhnZGDRoEiN6b0G5DjYsanEo5LeRn
 JcjS3nOGx0WchGcAcsuiWXz9EtxTpjQbxjw34FCnVjteZJetYPQiBsJzJeTpeU6AoxqkHielD
 /yVUtiKXW8gRLQNFhN5yAeHDUgdIG4POBeKO2+7o/V0YTBxMhoHK1eaxesfSLj/S69V9ZwDJ1
 u4we2Qhpiv+GM93o5k81Jei0tbiI7U+xKjW46C3F99PeCGHTOxvg+3acqTJ20iKhZivADO57+
 hiUb+CSM4f9aMUejEi03zd5gxjoAvFQFhY0F/YSy4DHeVOWVsjgvMV+khpdeqyaVrsuYnGIt7
 G/V5U2XIHcjkmH+RLeSAmUMvPZQbPUhSAHxm8kMMVnNoJfQ/+n+qR3wHgcHb3BGx6FCZf5wU2
 RDR7mRwywm6iMBZ4zf5D5IrEulfOLy4L6sdZxeyFTfWzB4nFBQiMkQXHVCBHKErQHHDLd7SJ+
 S3wbQFaBLXoY9DTI8WtTBfJ+ulJQugn+Y9AVzZkl8ft1srv8s8Pv531NqyMyg5SOVbBFvG6UY
 Po/lG6BfNzOQFQoL28E78okshDvO5Lecs/VIXN22kUruXscDEjVXfEDwXbCSPAa7ikeJOxUW9
 zRwaGtmnXq/EjdY6utaTE6bEdQkqjgElUgxNME4tkvT8yHaDYrcR+X4/mD9E7NjOr+pqm59eF
 r4ZwVAH1xp0c5+jJEQpviPawToUdQhGL+uVvIf9V7NwYvraai0Af+kTL6DaRMNg7V3Q9eqiQq
 z0nqSXM/Rvwgi/RMd5ix/S7PdrTjvuuC2GjAyfzq/mDJskolRTZ3i1pUihcuz3itllsrB/2Lh
 zxmrarZrPtR0owWkjiuZ5ajehBXJoYanh9WxLNRbIWY4RjoRzfJQAmF/kXVtAv3Y9v2uncSct
 ysWk5/1xoxZyQWPMWjGZhQBF3Ms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/28 13:53, Anand Jain wrote:
> This patch introduces new configuration file parameters,
> POST_SCRATCH_MKFS_CMD and POST_SCRATCH_POOL_MKFS_CMD.
>
> Usage example:
>
>          POST_SCRATCH_MKFS_CMD=3D"btrfstune -m"
>          POST_SCRATCH_POOL_MKFS_CMD=3D"btrfstune -m"

Can't we add extra options for mkfs.btrfs to support metadata uuid at
mkfs time?

We already support quota and all other features, I think it would be
much easier to implement metadata_uuid inside mkfs.

If this feature is only for metadata_uuid, then I really prefer to do it
inside mkfs.btrfs.

Thanks,
Qu
>
> With this configuration option, test cases using _scratch_mkfs(),
> scratch_pool_mkfs(), or _scratch_mkfs_sized() will run the above
> set value after the mkfs operation.
>
> Other mkfs functions, such as _mkfs_dev(), are not connected to the
> POST_SCRATCH_MKFS_CMD.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   common/btrfs | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index 798c899f6233..b0972e882c7c 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -690,17 +690,48 @@ _require_btrfs_scratch_logical_resolve_v2()
>   	_scratch_unmount
>   }
>
> +post_scratch_mkfs_cmd()
> +{
> +	if [[ -v POST_SCRATCH_MKFS_CMD ]]; then
> +		echo "$POST_SCRATCH_MKFS_CMD $SCRATCH_DEV"
> +		$POST_SCRATCH_MKFS_CMD $SCRATCH_DEV
> +		return $?
> +	fi
> +
> +	return 0
> +}
> +
> +post_scratch_pool_mkfs_cmd()
> +{
> +	if [[ -v POST_SCRATCH_POOL_MKFS_CMD ]]; then
> +		echo "$POST_SCRATCH_POOL_MKFS_CMD $SCRATCH_DEV_POOL"
> +		$POST_SCRATCH_POOL_MKFS_CMD $SCRATCH_DEV_POOL
> +		return $?
> +	fi
> +
> +	return 0
> +}
> +
>   _scratch_mkfs_retry_btrfs()
>   {
>   	# _scratch_do_mkfs() may retry mkfs without $MKFS_OPTIONS
>   	_scratch_do_mkfs "$MKFS_BTRFS_PROG" "cat" $*
>
> +	if [[ $? =3D=3D 0 ]]; then
> +		post_scratch_mkfs_cmd
> +	fi
> +
>   	return $?
>   }
>
>   _scratch_mkfs_btrfs()
>   {
>   	$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
> +
> +	if [[ $? =3D=3D 0 ]]; then
> +		post_scratch_mkfs_cmd
> +	fi
> +
>   	return $?
>   }
>
> @@ -708,5 +739,9 @@ _scratch_pool_mkfs_btrfs()
>   {
>   	$MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL
>
> +	if [[ $? =3D=3D 0 ]]; then
> +		post_scratch_pool_mkfs_cmd
> +	fi
> +
>   	return $?
>   }
