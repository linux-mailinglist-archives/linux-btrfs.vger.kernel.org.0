Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB60727713
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjFHGLY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjFHGLX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:11:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EADE57
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686204676; x=1686809476; i=quwenruo.btrfs@gmx.com;
 bh=DVxkynA39rPaYJlH1H8GGhBFEdXrD1ESf3jb2JyOpAM=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=BW9IZFwHN+pMYcOyLqkNjPhnRbCU5jaTtrETnypsS23YYjtDXU96QVVSXjJOj855HuI2wUW
 B9DDi5BgKW6U6BpyNXoM6UbWQxDyI1MyBfEFYjYsXvB7FxGIA57TuHPSKnKR8nB66eZDexqdB
 KVLCdUH/okZtaVpz9Zw5gLm2MFXNKU8i4zc14HcHhQIJGOUe9MPl8wZsUam8rJ0j7HcNOiDYH
 7QiKf3Io7XfPgc9mRyodpwn27se3uvCPqS8ckxyisr/3J7rQWookINfndfArS857g+vsPmK3u
 LtoFtzfCM2150LwoojZJ/LZ5bugBGJYfxylvTV3fg7D5RA8Zr4pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwwZX-1pwTo83EqZ-00yQVw; Thu, 08
 Jun 2023 08:11:16 +0200
Message-ID: <df38f6d8-09e6-d332-fe56-d194012c878f@gmx.com>
Date:   Thu, 8 Jun 2023 14:11:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/7] btrfs-progs: check_mounted_where: declare is_btrfs as
 bool
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1686202417.git.anand.jain@oracle.com>
 <baed95f39e04b46fba014509af5fced8b300e154.1686202417.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <baed95f39e04b46fba014509af5fced8b300e154.1686202417.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JxK2H7jR2xFENO1SQC5HTtke/c2jXVA3wGQ105FZswL/3KAqBfN
 w3kkjf6dHFBViNa9mIxSXV5YhM88PVKE/CYMTq4+WgVwN5kj2GkVT/cvJEhWHpEyv5LarLe
 kqbZGmiCNbr8UyRUkLWl7dnpGLRY/ddlY+dQ/RsOFQ/MZUlgnZaI8LCm3GgacTVWKcUsuE2
 ehKuSn2nLXnGVv7R6Hg3A==
UI-OutboundReport: notjunk:1;M01:P0:ZagU8OSz2ow=;TrrHIj67QtXg3iYYAWVBqpDeTcV
 QifGAwXWpYD1E2cAMC2nFh/Q8YjaJLgXSbUNKIOI9qM1a+PikP/4lExgzeYxY12X4pPeRZHdD
 vqz9Tx+LrhEbHMSlOQPyzntRbkPqQFXPwrjfj5uLUlJpXT3ifb95ET4DxezoQDuU6Q34+J1T+
 Z9j7f6UO1y9dYebW+kVJNKS0+8PL0Z64+U7tjeOwtzEcdOkNcwYdH5kuBRam0gUBY86GCbawd
 /yKnMzHJJ1Sgv7z3x5nDfjgkuiqlrDu3pdy1VUmYcZjpabQmKs+32sdWeHEeo4x9lAON/fAQ0
 p1Esa61yP4eNHSXRedEH0k9HykQafw7KDT05T3CYR/V/D9THfpEyHEX0p91PAeol1KNz9BjTF
 xBCfS948gDWMI7thVp7SvmWOO2HdPVP2cS1DPiZ8qgpXJezrMIFOOHRyzyMb5Dx/lmCfTme3o
 vpTM7/EfGE3AZErSd+nqlWjRuvOL4u7Lqn7IU6qqy2NC9vXxUIqQok+H0oYcZt9MjB+Dvcvka
 BFC6Gn9H6qVPxThY/C/05Sie4YsjThNlJ455D9Y0TmzhmWFOrQHKxdXmlxG7UlRCoeKU47xB3
 ixyxL4+JkO+bwAI73Q+zBWRDtz2LfzbIKG/sWdhQEelTluXFDAHxAb1T5orKzpzNVmPeopJnZ
 gCCb7vc8kpkorpcBSbqIEtb8WRQBuRmeiF8i+i6Bx8IqX8IW6iVBWOklJhgMQIz3kZDaobA1U
 odcai0SHwzFTCVLkVPZk2e6VgIg94grdrWcrwyZqx3+VCh0RIDlFp383nBWaKO2tE8aMChF9i
 uRqs+pK1yfF6+xFGaTKcv0W9mygK4tAFFNeTyxm5jvIzeMhXKWjVhtYCs6E0GSINsuBT+toqg
 Cf7MvTGDsAprtqm8d6zEINzLobN6A3xnuJUj6A2LBWdft5feXpTU3/uJCmeuKh2gcN/DUWfq8
 aqDau0NAdW7EId1LgLELCcY3+JA=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 14:00, Anand Jain wrote:
> The variable 'is_btrfs' is declared as an integer but could be a boolean
> instead.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   common/open-utils.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/open-utils.c b/common/open-utils.c
> index d4fdb2b01c7f..01d747d8ac43 100644
> --- a/common/open-utils.c
> +++ b/common/open-utils.c
> @@ -57,7 +57,7 @@ int check_mounted_where(int fd, const char *file, char=
 *where, int size,
>   {
>   	int ret;
>   	u64 total_devs =3D 1;
> -	int is_btrfs;
> +	bool is_btrfs;
>   	struct btrfs_fs_devices *fs_devices_mnt =3D NULL;
>   	FILE *f;
>   	struct mntent *mnt;
