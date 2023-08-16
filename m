Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F1177D853
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Aug 2023 04:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbjHPCSY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Aug 2023 22:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241277AbjHPCSK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Aug 2023 22:18:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1168826A5
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 19:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692152263; x=1692757063; i=quwenruo.btrfs@gmx.com;
 bh=PhCfHCfL3dL/zjcCRVzTzR4bjUeFW5H5Bid4G45JGeQ=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=Pdo2cxtjhQoRKpM2FPqCUkApAwE+62/FROxryy5EyHv7kdusoG/10iYCCyszzgl2jX5crSI
 8DuVfW1l411QwV+Yvb8I5NGAueGlVh1ujqzwakfhO9IU7Tw37OJwPV2jao6kkA9fx/Quy5RLN
 N3SJ3SETM+VDq+bjQC1dVpZuVv98aouo2AAjHYymoLWZxmuN6lt24QE9awJwJAH9vJVXaZUHe
 +tr8A/p5QokxM2O86sXmYx7s4yYI1OPZCFwLZBlRx7vDAKyR3G7mL7IDg0cdrbVfi14L4jy7o
 WKH91GAxsw5p1Q9DKVHQq0RESS/2WS3IvKVPkxpscdQqo0RySeig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N33ET-1plG5T3dl7-013M4x; Wed, 16
 Aug 2023 04:17:43 +0200
Message-ID: <e8d8e41c-b848-4d4b-99be-b13ed507de8a@gmx.com>
Date:   Wed, 16 Aug 2023 10:17:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs-progs: btrfstune -m|M remove 2-stage commit
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <12b53ab9683c805873d26a4881308137e0bd324e.1692097274.git.anand.jain@oracle.com>
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
In-Reply-To: <12b53ab9683c805873d26a4881308137e0bd324e.1692097274.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jwoRNelzPNdNBDRP7d5jeRXs+pg+wdoz94RNRMqK2iijSsaAL5y
 0XmOYspN7Qdmo+14nLmY5ZnHfA/PT27n4r9Wa6ArAhDd4AuH9R9Ux9gyC+YDfewpmt7+MD9
 bNLAyH5uy+6n7z1Gb8g8vUq2eo+WB5fn43ITLWlVtTAZfJUhxikSgXCRwu/oUwWW0nEcMIN
 Ib4VITXY0A2jIYBEoOA3Q==
UI-OutboundReport: notjunk:1;M01:P0:o5hO+CTwOpY=;dMWEFxr94qBv41UTBtCgdngarwq
 4pjQZqkGql/mAzEdezT1CIJNRNHnKRtc/LhoSqf/cv2j4uonx3EI38nLOTrWTZcikgegosO8K
 AYPTfKAxsVbQojLinz6vv1R37QXQ40cmuweLLMWfalVXeIzKER3RRToLjI6mupfUuFNEjc2qn
 yHm7MAheXb/38yfpY5ODvBL3C2GGZaQfGMJTKHpUgOiSHsWats8RuzS9VOQe/sqsI0duh0frL
 ElBnXzzsjp/b+XY6UWkgQCvMxDb/eKCz7JDsxOdCU6FI7BfSSm6FZ9LH6s4G62S0LrtkUaNMy
 U5eI9HcfELEnAVXPxtFd3AH4aOv0Pds6L0TCgT3zJwYTw7HUec6hcEM7YwwqcrhKzouux3zew
 GhMFrDWXB4u6e7gtjKwy0mA2SuP0VaptGnIewWrg4vmSxXjq7STHIE7M6PQHifUIUSuSZVKnD
 D1ubWs4CuWZ/CAYCSi7gYVsZB95VqY5NfI9Sk4eT4KYAAxfm6VmRHR++MnS3OBpOrdyxeAb6l
 OTWXfTY8goTalmEZPBvuoKICVQXZQHGLt2uDSLZaqep1IcjWdnZ+fRY6n5Cq4JowFmmt4VZAc
 mHOOuSgvPWcM2Uk8xnWICF+tCXstX+QPkvnlnGo8/MnkfFi4IDnX3ZruXGNnn1CqD6Ap7OA1K
 9vJaDuwdkWjka9Xxe+SnTiqcyM2G4MskaQAe5YQ09ub75bZEN8Tip1LapPCiuTaL1Q/KBZnWr
 M7x0GakM2xlaIZcgQHGDTMWKUD/OH0CTPp0lYffvRdzozOXPQmI02gst6GQXOhdLZjyZdiTU0
 B+UOORfa/RkhTynnKimYYWRPGrnTw++AGWY3kiC7SyiUWeercp2DMUxkVu3e2RCm81c6FnqjJ
 fsxJsMd8q7lus6hy5MJB4uszGmkoYketfBnUmPMldkzaEEmcOrjn4q+kqermFfvamsOPqbHnN
 CzdzOqpKjPx+b+mxCS6D6TRSKSg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/15 20:53, Anand Jain wrote:
> The btrfstune -m|M operation changes the fsid and preserves the original
> fsid in the metadata_uuid.
>
> Changing the fsid happens in two commits in the function
> set_metadata_uuid()
> - Stage 1 commits the superblock with the CHANGING_FSID_V2 flag.
> - Stage 2 updates the fsid in fs_info->super_copy (local memory),
>    resets the CHANGING_FSID_V2 flag (local memory),
>    and then calls commit.
>
> The two-stage operation with the CHANGING_FSID flag makes sense for
> btrfstune -u|U, where the fsid is changed on each and every tree block,
> involving many commits. The CHANGING_FSID flag helps to identify the
> transient incomplete operation.
>
> However, for btrfstune -m|M, we don't need the CHANGING_FSID_V2 flag, an=
d
> a single commit would have been sufficient. The original git commit that
> added it, 493dfc9d1fc4 ("btrfs-progs: btrfstune: Add support for changin=
g
> the metadata uuid"), provides no reasoning or did I miss something?

To me, it looks very sane to do all the operations just in one transaction=
.

Furthermore unlike kernel, btrfs-progs has full control on whether to
commit the transaction (exclusively owns the fs, thus no one else can
modify/commit the fs), and all the operations are just modifying the
super block flags.

Thus merging the operations should be fine, and I'm a little surprised
why we didn't do it in the first place.

Thanks,
Qu
> (So marking this patch as RFC).
>
> This patch removes the two-stage commit for btrfstune -m|M and instead
> performs it in a single commit.
>
> With this change, the CHANGING_FSID_V2 flag is unused. Nevertheless, for
> legacy purposes, we will still reset the CHANGING_FSID_V2 flag during th=
e
> btrfstune -m|M commit. Furthermore, the patchset titled:
>
> 	[PATCH 00/16] btrfs-progs: recover from failed metadata_uuid
>
> will help recover from the split brain situation due to two stage
> method in the older btrfstune.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   tune/change-metadata-uuid.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
> index 371f34e679b4..ac8c2fd398c2 100644
> --- a/tune/change-metadata-uuid.c
> +++ b/tune/change-metadata-uuid.c
> @@ -33,7 +33,6 @@ int set_metadata_uuid(struct btrfs_root *root, const c=
har *new_fsid_string)
>   	u64 incompat_flags;
>   	bool fsid_changed;
>   	u64 super_flags;
> -	int ret;
>
>   	disk_super =3D root->fs_info->super_copy;
>   	super_flags =3D btrfs_super_flags(disk_super);
> @@ -66,14 +65,6 @@ int set_metadata_uuid(struct btrfs_root *root, const =
char *new_fsid_string)
>
>   	new_fsid =3D (memcmp(fsid, disk_super->fsid, BTRFS_FSID_SIZE) !=3D 0)=
;
>
> -	/* Step 1 sets the in progress flag */
> -	trans =3D btrfs_start_transaction(root, 1);
> -	super_flags |=3D BTRFS_SUPER_FLAG_CHANGING_FSID_V2;
> -	btrfs_set_super_flags(disk_super, super_flags);
> -	ret =3D btrfs_commit_transaction(trans, root);
> -	if (ret < 0)
> -		return ret;
> -
>   	if (new_fsid && fsid_changed && memcmp(disk_super->metadata_uuid,
>   					       fsid, BTRFS_FSID_SIZE) =3D=3D 0) {
>   		/*
> @@ -106,8 +97,7 @@ int set_metadata_uuid(struct btrfs_root *root, const =
char *new_fsid_string)
>   	trans =3D btrfs_start_transaction(root, 1);
>
>   	/*
> -	 * Step 2 is to write the metadata_uuid, set the incompat flag and
> -	 * clear the in progress flag
> +	 * For leagcy purpose reset the BTRFS_SUPER_FLAG_CHANGING_FSID_V2
>   	 */
>   	super_flags &=3D ~BTRFS_SUPER_FLAG_CHANGING_FSID_V2;
>   	btrfs_set_super_flags(disk_super, super_flags);
