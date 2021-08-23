Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B863F46C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 10:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhHWIqD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 04:46:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:53139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235387AbhHWIp5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 04:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629708310;
        bh=lEPVJu1Guy8daVTlJhpO+RmBezDeaFZCGtqV6DrAUnE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lat+q6HiH414KChHMT1Bage+NLtWnMRHhAUVMJvPcqzxXAQ/LeO/AUxzqbtTE3Hvv
         2k1AC74rjz70iSrcX7kn6dcC6BfrFLsnuI13tIIdiB5WNlpLitzmi3nv/OEraZcZ12
         Ss083uEEtlcmPMu3GedCIkzYKvXd/TN6jDde8FJ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mgeo8-1mz9cv2Roa-00h9ME; Mon, 23
 Aug 2021 10:45:10 +0200
Subject: Re: [PATCH 3/9] btrfs-progs: allocate blocks from the start of the
 temp system chunk
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629486429.git.josef@toxicpanda.com>
 <2677d6c2568dcdc4eef9ef89e6d0a8d0a45960a8.1629486429.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6112af51-3a3f-1f36-0e22-44d381ac4b5b@gmx.com>
Date:   Mon, 23 Aug 2021 16:45:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2677d6c2568dcdc4eef9ef89e6d0a8d0a45960a8.1629486429.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VquQIvN7ShCrO/SKSgF4XT1X6csDr/WoyTjNbH3JviFwpeISSWF
 Bv6gwsGACzSgu3AqjRKa9Stpxh7XVXdtr/jSGCl+xgEP1EnN/puecP6J9WH7RDAdhpT2Ovm
 DrDAPTvRbqphI5AF08q7tzLYiPGhISx/julr5w5OaSL/7fjg6XQwkh+44zKLwQfdpNle6GN
 w4jgasM5OYV00yFRFAFuQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2myD37rw9To=:wFCQieegR0nlBZSPa/EPxE
 Sn0PwH6c6xddSCWSxM0EVSrLSsH6fMr6DM25ECsKZj7g/pax2/cyyEtsHQR3kEmoSQImu1Upw
 2+PSitptalE7G/hs/n+nSHTxBywYm0WgY4YicC3S8jZ3C7w1dbhr3tznMC3xXfDd6LMzdjKJF
 8zJaUYm7gpsO++Lw5R+sLoMmK7jlZZotE9T0vZik5VQouTB4UEg3QqYRbx2e4i4E2p0C2Pl1W
 SZndGh6C6+TYfSNQHixGkZLsr/QwRtugtcqJgfOuDyoPHPP3JWlPZllwPmDbCTQwH7rAFlx3n
 WW+VsrtwzQJ85l6plOcUyRcI9FRCii6A7tUWxhEOd8z3FGF6A/x22ObBbRH6Y1DDNG05Vhezr
 5HjHjN/MkeHFzE3/sAQRronBE8/LtK7hG8n+yfoyHpGh4WE2O2SlGc2H5dus2jco80ztmF0NU
 bUqHfJEb9RCvvLegPAGu3jSo/t8KZwV9yCfw0GpwGpG4KVyhnpiX4xYJ5P2H01gZgBXCinxpL
 c5m4/QTdaAryVgMPn9W+1dmmlUAIVKz2G0gqe3wwMFQAicAme4s+GiGw5rJIBrkSF4QwdkZF5
 RKNmEvehEma44qsk8+lOpmveIWMy/ieGNZu1CLKsmrvCu7B0WwFfcIb/pQLoTf73wDCWPnqdM
 M9d4S/a4V1At4u09nDQMwulsg+C5qVD0ZQLwF9A4bxkTZI0Pijdn58PT1o0vJdxCKYlPsIq40
 xTiInv9m1+nB46hW0QtUv2vF3DiJ8xKTdcbyoXxwYUBkQM/CmiicXXVOTGunWEJqVcXkZpjQO
 EjyG25adG+fYQhsQcnBiQyeqowB/Jps8ah40iMvJtWko4zmG/+203mG0JpLcbUiTlf2TMafDg
 cmvpeRbUiVKq55876qcIZEOEAV8zF9C2VB7rAwjcC96phbPi8g/MWTBOGxjACZMwXHgod+CTu
 pvUwm7AogK/aE7tqTwyINdqNKq/Roh6JCGs8L7NkbCA9kvRklVEsH/5Gqhuvelooe19x1C+PZ
 GWcl3ZM2qAWeLJCrLlqtpXghyGr9u8Uz3E7v0zuGwhQRNdRQWxedVfP2psGZaunX5CR9Is2w1
 KwF5cXyiVC3IkSMephxT0MvSwlddLWnrGD8fuVuM+nLtEMsC5NbJj1FJQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/21 =E4=B8=8A=E5=8D=883:11, Josef Bacik wrote:
> During mkfs we skip allocating a block for the super block, however
> because we're using the blocks array iterator to determine the offset of
> our block we're leaving a hole at the beginning of the temporary chunk.
> This isn't a problem per-se, but I'm going to start generating the free
> space tree at make_btrfs() time and having this hole makes the free
> space tree creation slightly more complicated.
>
> Instead keep track of which block we're on so that we start from the
> actual offset of the system chunk.

Can't we just get rid the extra block for superblock?

As the superblock is always located at a fixed location, we don't really
need to put it into the blocks[] array.

Thanks,
Qu
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   mkfs/common.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mkfs/common.c b/mkfs/common.c
> index 8902d39e..0e747301 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -153,6 +153,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg=
)
>   	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
>   	u8 *ptr;
>   	int i;
> +	int cnt;
>   	int ret;
>   	int blocks_nr =3D ARRAY_SIZE(extent_tree_v1_blocks);
>   	int blk;
> @@ -203,11 +204,11 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *c=
fg)
>   	uuid_generate(chunk_tree_uuid);
>
>   	cfg->blocks[MKFS_SUPER_BLOCK] =3D BTRFS_SUPER_INFO_OFFSET;
> -	for (i =3D 0; i < blocks_nr; i++) {
> +	for (cnt =3D 0, i =3D 0; i < blocks_nr; i++) {
>   		blk =3D blocks[i];
>   		if (blk =3D=3D MKFS_SUPER_BLOCK)
>   			continue;
> -		cfg->blocks[blk] =3D system_group_offset + cfg->nodesize * i;
> +		cfg->blocks[blk] =3D system_group_offset + cfg->nodesize * cnt++;
>   		total_used +=3D cfg->nodesize;
>   	}
>
>
