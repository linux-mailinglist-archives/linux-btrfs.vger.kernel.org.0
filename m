Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373677ABBA3
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjIVWGj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjIVWGi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:06:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A39AA7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695420386; x=1696025186; i=quwenruo.btrfs@gmx.com;
 bh=2ZWrYsGExfTz0es2IwaQvQ0bsRDecyJaiWodWA8ItXg=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=i+8nvgcN4/mRC6fnYVsymIK4Yh7ZMQimwWHhACE6XMOpb44N5aJgFAVItbSvWWZ5ppwaKirDLOv
 OzJelPVBDdQ6NxtF4KQl4kO93iqe0Mfq1BsjHnF75fd7HOBfVjw+wzdVBArHTCs+ZYXPQErXNV/48
 prmv+pKpKCGLB6dud/QMDjkPtjfC/J9Opv+XjazTS43aiYYoD9iAJqjW738U1z2Zs9fuMTF4e+k6C
 CGSuw/TPx3ydS9JxLw+Zjxy4pHZBOWULlEWGrdsjW6bHPkGcQSryZZtTM+AekbILVulmugD8+QwpS
 Iw76hzyF+WBorp2M4TBoO0Qvo4ICnoe6MJXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdNY2-1rJ92f38lM-00ZQmq; Sat, 23
 Sep 2023 00:06:26 +0200
Message-ID: <fb517862-9cf8-4a86-b021-e9e7ce752e3d@gmx.com>
Date:   Sat, 23 Sep 2023 07:36:24 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] btrfs: remove redundant root argument from
 btrfs_update_inode_item()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1695333082.git.fdmanana@suse.com>
 <4472470053d1a06d99e80292f6a2fe06d6f40041.1695333082.git.fdmanana@suse.com>
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
In-Reply-To: <4472470053d1a06d99e80292f6a2fe06d6f40041.1695333082.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nbsEEe0gx4Uk952NC5QjytR9ipAR9teeHy8WxWT1XKLqid6uDnH
 +Ab7o52QHvQaNplyxbzMuqvwvDUz7zwhJF6IaL/bwGqMMfxLBgAbDtzkmFT3NJaxm1UebvN
 YeYANRTPWYNq8zX9bKK0dSVkyVXa0IOsAbWoPWh9nyt5glDXJCQXKK1jA9Z3jT8/o9ggeuP
 OOBp1ZPYr+0DjFts0UjLg==
UI-OutboundReport: notjunk:1;M01:P0:IWRkoywdFKc=;3Fn570DEKJvCrhSz8461dyFLYjW
 VOEVd7t+4uYSz79kIGDskoV1XTsHDOzDZvsr6J4aWrm2Ghnhoqkm2dsnipeca7wakLIxTmh8n
 wTZdBivYObeG5QysmZJnAV5LiayGaPdSIJtorekDG2EVFVshK4j6xPtSV3mVV42vZFCEMBbtM
 pHX30aRucH8PvCbqYohhFhoS+uTVz1uB6oJ+JKJqwFfxdUN8UzdFw7nPClHtJGt07Bm6YGElB
 izoTeAGeTJqsQ/zcwcMtkAgi/UMQtKDwOE32OecTuccjZqROZhKlMGQdmuQcL+FT7/dYCIs9M
 axrnhzrI4oAVsTsoJpVoz32xaF1BR7S1/1MoCamrRs4QDM1+pTHPTrhLhE2KRJUzG/W65pR5C
 329Y9q0nIVCpxFbQQj7k/32jyNDILe+b7k2jKSQ8Gw0TbCLX2WF+TABcKDopb4FzalUwldYNS
 BB5NjtwjE0GLZEET2cQLOOS5X8buW00xseGHD+QTqz0LQ8QKLo9tUQTDvjvQbvm0uBRYpaPgX
 G+wMQgRF1DORb5L1vOdhB+BmWxppIja1Q5MLyePkHUsUKxsV8HKxeOwaLZH/RYPMjpYtWP0j7
 nNI6TYjFpzW7boXEcuDfQ8IKvc8SLun3L/VJnBrLGNADS8YXUhAG+QoG7PZlUSgsZknXfsel1
 sDfwJqBIQtA/YelDX5RHIFWtGZKNPQqA0HCrnoPwJsWtmWtAHbOf018/TPkXYtot0Ep2+d5Zf
 KrOxejofAxczhSCBxgWhtxHIAzVsHNNWt1mRbXGCb9eHZA2ieaKTNCgSoDuDqNV3P4LcnFcm6
 m6dy0TCITgedzATVWZ+mt8aYdxponGLsQOMSs1zywWmnaD1vXedroTehEFoMmnWT4akmaTjeO
 y1deGQD67MQy5IQlHM6/K/A5JFLOtUkCxKxMs1CfNPiExCf9dAoK0b7FHzywtnJdoupe0/kYZ
 hOwTLMLl86Nnk35ogE3DUY3Xi2A=
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



On 2023/9/22 20:07, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The root argument for btrfs_update_inode_item() always matches the root =
of
> the given inode, so remove the root argument and get it from the inode
> argument.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 13a97d3ce34a..c4b5d4047c5d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3966,8 +3966,7 @@ static void fill_inode_item(struct btrfs_trans_han=
dle *trans,
>    * copy everything in the in-memory inode into the btree.
>    */
>   static noinline int btrfs_update_inode_item(struct btrfs_trans_handle =
*trans,
> -				struct btrfs_root *root,
> -				struct btrfs_inode *inode)
> +					    struct btrfs_inode *inode)
>   {
>   	struct btrfs_inode_item *inode_item;
>   	struct btrfs_path *path;
> @@ -3978,7 +3977,7 @@ static noinline int btrfs_update_inode_item(struct=
 btrfs_trans_handle *trans,
>   	if (!path)
>   		return -ENOMEM;
>
> -	ret =3D btrfs_lookup_inode(trans, root, path, &inode->location, 1);
> +	ret =3D btrfs_lookup_inode(trans, inode->root, path, &inode->location,=
 1);
>   	if (ret) {
>   		if (ret > 0)
>   			ret =3D -ENOENT;
> @@ -4026,7 +4025,7 @@ int btrfs_update_inode(struct btrfs_trans_handle *=
trans,
>   		return ret;
>   	}
>
> -	return btrfs_update_inode_item(trans, root, inode);
> +	return btrfs_update_inode_item(trans, inode);
>   }
>
>   int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
> @@ -4036,7 +4035,7 @@ int btrfs_update_inode_fallback(struct btrfs_trans=
_handle *trans,
>
>   	ret =3D btrfs_update_inode(trans, inode);
>   	if (ret =3D=3D -ENOSPC)
> -		return btrfs_update_inode_item(trans, inode->root, inode);
> +		return btrfs_update_inode_item(trans, inode);
>   	return ret;
>   }
>
