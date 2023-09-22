Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96A97ABBC9
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjIVWbD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjIVWbC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:31:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8561B4
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695421853; x=1696026653; i=quwenruo.btrfs@gmx.com;
 bh=AxsOXLFlxL7jHZgEvTNsCRKb/VMlo8dnU3iqmqpAfb4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=eueSzKA3NoeLMm+W+viwWMFIKxWwWygzEPN0gCECEJpJoo3Uya6ATU+OCt4lt7I0idrK5fBFEuj
 sCEx9+pcvvhk6kF38+5nD8J04qgZlzDLWQth3XDYfcGF6Edy1+bAfug8esbdm1qSfYZ7nHsXbp+Di
 s1u7geATx7Pe9CdzOs934Zpj9iq4cbiuGP/zMwLkqNWEOPatcXIzWYqezOelxHTIt5SW/V/BlrjiR
 q3rRJnAytaPNfeFb2rFwGSpAz1jWvgwiWg77mMZL2rNcHGh5tsApA6wkUAJ1xfS7aDkeUadD+oGJQ
 zIDq7imfaCWFrTTaK3Inxj4sI99rX+Dg58Tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.6.112.4] ([173.244.62.37]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5if-1r0ebI1EP7-00J4Ic; Sat, 23
 Sep 2023 00:30:53 +0200
Message-ID: <82902677-a2d0-46d5-b363-c311a7825184@gmx.com>
Date:   Sat, 23 Sep 2023 08:00:52 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] btrfs: relocation: switch bitfields to bool in
 reloc_control
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1695380646.git.dsterba@suse.com>
 <28dd578b57ecb9270fe60b2170b4cac5c1ad77bf.1695380646.git.dsterba@suse.com>
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
In-Reply-To: <28dd578b57ecb9270fe60b2170b4cac5c1ad77bf.1695380646.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P5aYRz5y3G66Y6R6BRd0dO1DdgvgxE6RPediEff2V8gCFL72Njf
 yOrv0r8wwBlYBIwHeEsWWw90qlFmsu7yTbSyo9yProx6vaa086crvFlLlZ6zZWKyvefS6SD
 snhszMdvn+3INgfdhCEWQlNqku3UsAIDvGZ6sntSt+Rbq+hfhwY9ZXxM8/gXy9CddN4IlS8
 PeUIXRwTVmYtdLoocLHNA==
UI-OutboundReport: notjunk:1;M01:P0:nhjbqxlWIIk=;eykkhndjxmBn6TN3ZYzhw+gZ0Y3
 dKO+H3VQgOq17oD6w7zYBdxIqrQGCgtCxyvTCe75NrLkV+CsYTNUeTZyOBdfdnbpcxmOpsyqx
 wNe7p8ueuysOaSSk70Ixztoq4ECHzaUaWkmM6VfnmP2B7IjSRyMHT5tcjmAe9bi7MJwt3imlR
 msURL8yVSdPbZ/oX7dsNx3EnrjkvoKwi7Cy/AhT9HfKgXC7iiku1nae5gVDl2HpKzIVqqrDxD
 goJdnEggmi9aHed+vYRhTv2yPfKDi6LQn9pZQ/r7vPO7uDeeyimoiDe/TVA3jGo5yHGc4Ct3W
 T1XhdBdcGAlgquVnHloFexCvJ7qIrFbdy0mxfmYbiaAUhPpoyQqudTDb7rklejw6WzGmLrEOG
 okAD58yYQoDL8ZpK/biV1o22DfMNcoW/uqaOxN9JA3YP/9o4XTApedu/iOqYBAAG7OiWWdFu1
 E8xBc5DqaHFgzJgWm3vtHPRUPxC0Lwx8Tc6Y76YK05Oqp/9klbISYjl463PewXjlVunrh2syf
 YatTrxj4d7aoTgnbISj/JRTNutkfXhJGDqcEiYfxydC9uaM3FoghEJd7TjWYpcShfNsofQSDL
 X1IASJKu19wbE2MYu89UQLRuvau8+mg0lshgPxlQTxKcGn5JnxshdUYPr5CdKzSARok68nXqr
 tIF7HWRvN17j60FgLwdo2WmRXDAgCcf/y4lytPf/kV5rXJtV+2yha9/5MY68Zwsd8E5XII3Q9
 YQ098yVwjJzvzlNvIv0tql8DMe4/aHtpwPVM0atkqE637812t+zKkQ5EkAagz51cq3apoSTGj
 nCD/TGLr39QJNa6roefuU+1zFqgff3HX6kZ4BtLIUvzUhvcdtldj74iCGnDB85oYrCcGuBPvw
 skeDr2108JzvpDq/oskCihp5rvMZSNU2R/6lXPbqCAa4iFtgVMc+qDRKpiacQcXG/0UxeDeSb
 l7aFXfEujcBCAnLbiEy7ifrKrVc=
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



On 2023/9/22 20:37, David Sterba wrote:
> Use bool types for the indicators instead of bitfields. The structure
> size slightly grows but the new types are placed within the padding.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/relocation.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 3afe499f00b1..87ac8528032c 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -163,9 +163,9 @@ struct reloc_control {
>   	u64 extents_found;
>
>   	enum reloc_stage stage;
> -	unsigned int create_reloc_tree:1;
> -	unsigned int merge_reloc_tree:1;
> -	unsigned int found_file_extent:1;
> +	bool create_reloc_tree;
> +	bool merge_reloc_tree;
> +	bool found_file_extent;
>   };
>
>   static void mark_block_processed(struct reloc_control *rc,
> @@ -1902,7 +1902,7 @@ int prepare_to_merge(struct reloc_control *rc, int=
 err)
>   		}
>   	}
>
> -	rc->merge_reloc_tree =3D 1;
> +	rc->merge_reloc_tree =3D true;
>
>   	while (!list_empty(&rc->reloc_roots)) {
>   		reloc_root =3D list_entry(rc->reloc_roots.next,
> @@ -3659,7 +3659,7 @@ int prepare_to_relocate(struct reloc_control *rc)
>   	if (ret)
>   		return ret;
>
> -	rc->create_reloc_tree =3D 1;
> +	rc->create_reloc_tree =3D true;
>   	set_reloc_control(rc);
>
>   	trans =3D btrfs_join_transaction(rc->extent_root);
> @@ -3786,7 +3786,7 @@ static noinline_for_stack int relocate_block_group=
(struct reloc_control *rc)
>
>   		if (rc->stage =3D=3D MOVE_DATA_EXTENTS &&
>   		    (flags & BTRFS_EXTENT_FLAG_DATA)) {
> -			rc->found_file_extent =3D 1;
> +			rc->found_file_extent =3D true;
>   			ret =3D relocate_data_extent(rc->data_inode,
>   						   &key, &rc->cluster);
>   			if (ret < 0) {
> @@ -3823,7 +3823,7 @@ static noinline_for_stack int relocate_block_group=
(struct reloc_control *rc)
>   			err =3D ret;
>   	}
>
> -	rc->create_reloc_tree =3D 0;
> +	rc->create_reloc_tree =3D false;
>   	set_reloc_control(rc);
>
>   	btrfs_backref_release_cache(&rc->backref_cache);
> @@ -3841,7 +3841,7 @@ static noinline_for_stack int relocate_block_group=
(struct reloc_control *rc)
>
>   	merge_reloc_roots(rc);
>
> -	rc->merge_reloc_tree =3D 0;
> +	rc->merge_reloc_tree =3D false;
>   	unset_reloc_control(rc);
>   	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1, NULL);
>
> @@ -4355,7 +4355,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info =
*fs_info)
>   		goto out_unset;
>   	}
>
> -	rc->merge_reloc_tree =3D 1;
> +	rc->merge_reloc_tree =3D true;
>
>   	while (!list_empty(&reloc_roots)) {
>   		reloc_root =3D list_entry(reloc_roots.next,
