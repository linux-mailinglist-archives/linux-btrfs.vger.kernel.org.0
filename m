Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342077ABBC1
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjIVWaI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjIVWaH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:30:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD98B1AD
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695421796; x=1696026596; i=quwenruo.btrfs@gmx.com;
 bh=I5gDMC9XZYePOosPcnHs+o/Xi8zi88gkQ2FV8S/UC6U=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=mtwtGKyaBXKuKJIFGFiuTcuXRvQjxEL1uvYVHvOjesY3KTrD7t0wwnhCzS7q9Rt3xf4yjGborFy
 Z42OxOyIuJ3ZtWYsVWYpjHpTPGMit6zKBjp6zC2HZybM02adZ1eNNEb0bMat2ScOu9QU+nCwlytAY
 lSnJ7iW1nELbjEC8rtHwdgW5cvE/khug0yulj0C8wv9TPcu/Qj/Dgs+c0jTw/Ez9OHXaS03XQukjs
 OM61oPkhz1x1nyMC3nSRFlQEAAard3wtvM3zKfk9akp4Oan9H5bEN6i3lgZ13usfpZqeREjoVqIO6
 6Wr0VNtuOPWMJhg3bPF8TURy7GhKn/lFoJGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.6.112.4] ([173.244.62.37]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3UV8-1qjGgz2QJG-000aD7; Sat, 23
 Sep 2023 00:29:56 +0200
Message-ID: <fb37b3db-3dfd-4bf6-8207-84d318da244a@gmx.com>
Date:   Sat, 23 Sep 2023 07:59:54 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] btrfs: relocation: use enum for stages
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1695380646.git.dsterba@suse.com>
 <e20220675e8d2501f4b98bae12a105615abe634b.1695380646.git.dsterba@suse.com>
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
In-Reply-To: <e20220675e8d2501f4b98bae12a105615abe634b.1695380646.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C7BZhWzgBjJ0wYkWwtW5bWQolbGH5aPbY+O+KSXSl4hVeuqTUUU
 yLvt66n1v8l+1oCKiMkgT8cahtLlfGhm+T9f8hh8wC/IQ2XOyufbthxQ/yW0EoJKJDHqAkt
 0K+PRlt57N2r6y3IFA05uq/Tiwonff7Lx94K58T6yQJrpOpzYppMOJ5zHVbHoOIMb2MxC8r
 TdLu8gTOYWFzeijc8+hrw==
UI-OutboundReport: notjunk:1;M01:P0:zD3NV9s0UZ0=;wb4qlJHf8kpmsv35nHzjb7NyP7r
 5mQ6p3EXN/B8a4LxWahMPloxlOKR/bksKwAp3owIMo3uGnOGtw6Nr6jMPCNbXThNzHhTB1qYX
 FXIKzCND0x6i03XUKrOsdLTLJAfGrM3Yim4M/ALnV3aCAstc3WrVBngqcKMsy8P3BUkmwBgRM
 3UG99fwlIsZZHN6c+PqQ6o7It486S2vtxibAUb219Ca8Dyp1QgdVXmAfqKRfIpgpR7Sl4Mx9f
 1yU7UFAKfREbVuVDAFcTJtWchBLFSJQ3gdX7zluAJVsh7cuoobhz+LYuroMnf92iszEeMkjz0
 VQT8LZIUgFo2yGAk5FpJR2WmgcMhrl8877T0zLMnp9MzkCwiIMQsL1ENLNS09NxsVxepK7QGR
 5STklZz1DK5bKILbZJZ4NpoBxvoLp64DSQTzSci8FodL4d2qIv0ulBMyMPHSi3B9Qx1WQDy7z
 rPaNf21RMSnHEcbwQG5JM9MqHVdm/U+QexF/kHkVbzoWsD/iUDHKogSN7gqiAt75f8W2KegjX
 h5erv560kf1qWb3bDEph0xlN212zxUHMmlu0lG8cgNC/x4lnbOPyPN1leAu++M2B0RANcdjqS
 3zo0tMt33EUin9rXZnwIeI0JOxeMw9eADXSMTDYK8HiieRdUBA8e6niU92OHrQKfasAl/KiM7
 CfUkecziCh3jexwzbVJl2I3suUwexWl5Nrs8kVSf2yqXvMf9j6HL3q8wcDVG38J4RoRSJpMx+
 6yothH07mLj/m7+n8jTethucbfltsbbG+DTb3sGIU+18+0Ho2u82sVvvFLdzIxG6rbC4xwuas
 iXusm1kPItsuQeOSb7okd300920bEh22uDOLTUn0ze/p6bjIcoa7OBcxVn3ddmozoLyjPMpjX
 a3QVatKAEwGJnsV0S6bKcIzKm1YKBXzRYaq19bqjz6BA0ZHRP+fZSib2j735sDROkEPSr5ThK
 ffPlwQfqv0iKA8x0zP8QAzlJcRs=
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
> Add an enum type for data relocation stages.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/relocation.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 9ff3572a8451..3afe499f00b1 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -125,6 +125,12 @@ struct file_extent_cluster {
>   	u64 owning_root;
>   };
>
> +/* Stages of data relocation. */
> +enum reloc_stage {
> +	MOVE_DATA_EXTENTS,
> +	UPDATE_DATA_PTRS
> +};
> +
>   struct reloc_control {
>   	/* block group to relocate */
>   	struct btrfs_block_group *block_group;
> @@ -156,16 +162,12 @@ struct reloc_control {
>   	u64 search_start;
>   	u64 extents_found;
>
> -	unsigned int stage:8;
> +	enum reloc_stage stage;

Wouldn't this cause extra hole?

Thanks,
Qu
>   	unsigned int create_reloc_tree:1;
>   	unsigned int merge_reloc_tree:1;
>   	unsigned int found_file_extent:1;
>   };
>
> -/* stages of data relocation */
> -#define MOVE_DATA_EXTENTS	0
> -#define UPDATE_DATA_PTRS	1
> -
>   static void mark_block_processed(struct reloc_control *rc,
>   				 struct btrfs_backref_node *node)
>   {
> @@ -4054,7 +4056,7 @@ static void describe_relocation(struct btrfs_fs_in=
fo *fs_info,
>   		   block_group->start, buf);
>   }
>
> -static const char *stage_to_string(int stage)
> +static const char *stage_to_string(enum reloc_stage stage)
>   {
>   	if (stage =3D=3D MOVE_DATA_EXTENTS)
>   		return "move data extents";
> @@ -4170,7 +4172,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_inf=
o *fs_info, u64 group_start)
>   	WARN_ON(ret && ret !=3D -EAGAIN);
>
>   	while (1) {
> -		int finishes_stage;
> +		enum reloc_stage finishes_stage;
>
>   		mutex_lock(&fs_info->cleaner_mutex);
>   		ret =3D relocate_block_group(rc);
