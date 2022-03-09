Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69274D2AF2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 09:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiCIIxU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 03:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiCIIxT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 03:53:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101E9163068
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 00:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646815939;
        bh=khBDndqm4XDJhVNGeKqf/5ZUOcYzyNQBezlH9NDNfu0=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=Md9kKFPDyK0G1duyikrR5IMrq0lQPwDi+Re18okCamy0U3wQwVryQXx/atCSFYZwh
         bB0beHtzphy6VXoO9Dzr4oJzloJ5DqvaIpJA1me5blQ7yu+2Xh07pZCYFHSCVXy++d
         O+ze5K5R0Xp/KWM2gfAPaVFOnYCJzsopkK2RZDbM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGhyc-1nO0BM0Meg-00DnAM; Wed, 09
 Mar 2022 09:52:18 +0100
Message-ID: <4a594830-8a8c-dbe3-15d0-1a62a1adfaa2@gmx.com>
Date:   Wed, 9 Mar 2022 16:52:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20220309081418.46215-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/2] btrfs-progs: subvolme: remove unused options for
 create and snapshot
In-Reply-To: <20220309081418.46215-1-realwakka@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:37p9vWC1E5vyFrM8DB/UoqOxxVoS1Ys4p6CpZOUnweE1rgl3F1/
 bctZWqj6aeaLJyPCTl9Ja/uH+X8YWjO1xWUBHX/Yjx8o+vNho35mlbBsRf/mn/qtCAsVdsC
 be09d1Y1hdzEumeCTM/E/jfTUEl6sGLtH4k0NLS55qLtf4drmSyKpsIIyfknVxeNND0+kB1
 MKcv8kjjbjZAqwOJxr2Tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dhVlnJA1O4s=:8wbfUP8Nj1Vh6lz5d7Ij0o
 P8zAIodOGZqfrvL4O24idmmFpxf0SIfFQygS6urN9zmXcECdyqYKk0bHK7vMExzaT6RgVQHRt
 SsCBR2TSTZfVmz5n3z9mwAx2I1HZ/yPOAYq3IeKixPyJez/VatVu/kMtf8Ft50YW4HgYIevvb
 vBBnHtQg2Rp5J72/O8eZKggZ36KG7Cq25lH5UWutly0PqBKJcTrHFHR6wH/HwdhqjZaEYYcS0
 0cXvFNm78qtM4LcQat0cIpyLaFVZcQMpRltVJ5t49TjyM44EQCTYEb2RgHOSNcZlZZCFqOTWr
 qq8/KuhJpI655c+K8XVgYXl8FxlwqxY5926s7wn20XkIrHtw+QHIs42k5mTXTtrVGGEezEH3z
 iBHPfuivWe3IKyF8SIofygNRXd9cIz8aqzQrl4M7CCqIP4dGajN32ht2RDCMN7pMhtMN3rbGQ
 JEAOtMWD2GJqVXm5XEoMf7TZv0Gt1URNYiPZF0a36jXt4HJbsKCsNyZpH2I7rBfQLiJlHg9dx
 BRQk8uu1gysxmOqNMCzABls/XfXM6FAU7wPO3qEy/L/bj/+L+zxN4isbFxg9iY3VNsd0k8ZAW
 BQUMvUXUysFLWomOOhmLW1f2LKjnJmhsIEKo3olhfqxtZ8eskvujTjBinxZs3htYBUBgTGXZQ
 MRczRAztG+ey+2vY70cM4DxShFw5cnxSf4U2gz4tcYXvDs1TGfaCmPu0+KbWQr/WWdALNT5Y5
 M2KQPCDjWXyV5+1VQ2jbo4HjAjY75Uwf3thdtNtU4nszxvtCwMVORnAbTdvkc1adayAPDM2ly
 ULe9oUx7en5o8Okt64gU32YymDFzZkfDTyUmckukKsGDQwHAdAAK+k1NmMxLpx17Fe6U4IPy3
 xAmCKnZLGdZpeBvgdr51eIYEBen0iyiaiNJTwkAKoowDV0+8TX3IWBzOnW8R91GTKRlWLvnci
 /qMy9ad2JBGJ4YyyX2nYgBwrF0Cc8w4/PzwZAYBhNeRExtZbxxU37t9j9c+z0aUYcM8hBDLj5
 6LG8sXeSjy3qdQAgTxP80A4Ra/By1sDEWwC5I9C/EnOIATyaHynuTnZpv4zJW4UzhLCFMHaAh
 2cQIglpa0wbEmk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/9 16:14, Sidong Yang wrote:
> There are options '-c' in create subvolume and '-c' and '-x' in
> snapshot. And the codes about them is there, but not in the manual or
> help. This codes should be removed to avoid confusion.

I'd like more explanation on why we don't use it.

In fact the truth is, those -c/-x allows us to directly copy qgroup
numbers from other subvolumes when creating subvolume.

This is definitely going to screw up qgroup numbers.

Nowadays btrfs qgroup will automatically inherit the qgroup numbers when
-i option is used.

So the old -c/-x is no longer needed, and any inexperienced usage of
them will lead to inconsistent qgroup numbers anyway.

Thanks,
Qu

>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>   cmds/subvolume.c | 25 ++-----------------------
>   1 file changed, 2 insertions(+), 23 deletions(-)
>
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index fbf56566..408aebee 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -108,18 +108,11 @@ static int cmd_subvol_create(const struct cmd_stru=
ct *cmd,
>
>   	optind =3D 0;
>   	while (1) {
> -		int c =3D getopt(argc, argv, "c:i:");
> +		int c =3D getopt(argc, argv, "i:");
>   		if (c < 0)
>   			break;
>
>   		switch (c) {
> -		case 'c':
> -			res =3D btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
> -			if (res) {
> -				retval =3D res;
> -				goto out;
> -			}
> -			break;
>   		case 'i':
>   			res =3D btrfs_qgroup_inherit_add_group(&inherit, optarg);
>   			if (res) {
> @@ -541,18 +534,11 @@ static int cmd_subvol_snapshot(const struct cmd_st=
ruct *cmd,
>   	memset(&args, 0, sizeof(args));
>   	optind =3D 0;
>   	while (1) {
> -		int c =3D getopt(argc, argv, "c:i:r");
> +		int c =3D getopt(argc, argv, "i:r");
>   		if (c < 0)
>   			break;
>
>   		switch (c) {
> -		case 'c':
> -			res =3D btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
> -			if (res) {
> -				retval =3D res;
> -				goto out;
> -			}
> -			break;
>   		case 'i':
>   			res =3D btrfs_qgroup_inherit_add_group(&inherit, optarg);
>   			if (res) {
> @@ -563,13 +549,6 @@ static int cmd_subvol_snapshot(const struct cmd_str=
uct *cmd,
>   		case 'r':
>   			readonly =3D 1;
>   			break;
> -		case 'x':
> -			res =3D btrfs_qgroup_inherit_add_copy(&inherit, optarg, 1);
> -			if (res) {
> -				retval =3D res;
> -				goto out;
> -			}
> -			break;
>   		default:
>   			usage_unknown_option(cmd, argv);
>   		}
