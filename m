Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DFA7ABBA6
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjIVWIT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjIVWIS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:08:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5830F7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695420486; x=1696025286; i=quwenruo.btrfs@gmx.com;
 bh=kuqBGtMrF2/vuMEMDa8YSSVQr3XxG4FbPNGOP2bxPns=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=BXmbSfmcPEMvjWKSjSWV56lC4Hv6RqXF6fUiU8SPjX6DiinvOI8eiTb4OqxbbipnJeJNWLtbI1s
 IIGNA42xUTmC5jpUb0hiGx/UcHII//go8C5U8oD+R82/7C7/tC04EwvYkL0Pzhs00d7Kbd7d7crP5
 2o8g+5CU/o7ZBO0Reco82giProchdKYoF8oZxyBngC4UucTgOB0nStQ+8y6VXAZ4Zklg4GublqjQ8
 1YGP6EjodOoBjc1djSks5Uus0hdDaIBrRkAHdmlj3NeknDD/s86pNPllzxLVIQ18Hr1bQRGWjk2Ji
 zKctYTb6OKfnTFnrBbz5jHqjpkH0kW6E0Kow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MI5UD-1qvexm2CP9-00FEzD; Sat, 23
 Sep 2023 00:08:06 +0200
Message-ID: <dc523661-ad5e-497a-be2d-e2c6a60d82ec@gmx.com>
Date:   Sat, 23 Sep 2023 07:38:04 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] btrfs: remove redundant root argument from
 btrfs_delayed_update_inode()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1695333082.git.fdmanana@suse.com>
 <38eb656f778e10215d4b52a1bbb3401025b9110e.1695333082.git.fdmanana@suse.com>
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
In-Reply-To: <38eb656f778e10215d4b52a1bbb3401025b9110e.1695333082.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KyBviqL/Nx/qerTJKhkWezG/LKkWdU3llsskbyfPlz5rayZbAFr
 KUp78GqrgB1Uvt3JHQL6+efYYnL8xKBWxDP5Y1GoDmGv6dEI1TsvE41a3lvql+3fkP8Jl1b
 Lma1rvDvlSeU3qtuuv/bjFXh/Tql6yqK09GiGp/wv5eMNwgxmms+oggvR4xFtZd03XelUlO
 5i/zy6j3fJojJ4QZ0+2Jg==
UI-OutboundReport: notjunk:1;M01:P0:5FeTtfA5BP0=;A+NHUXA8HJFq3iQD2Ws+P1vOpO2
 27HqBV+pArofjmtIjY2/D8a7l9N5AtNPIG7Golh2Q4SDov+j3myhS/7g7rs8v0yEosfVTdadR
 EVZs7cOb6U43fME0zleHIC0k4K4rUTxGTuio0DCy3d/Yy5kWC+RmbW9sm9nJrSDtpzzo2pKJG
 aMFRGhenrcrqZq7/stpTEmqWBbDM9IaFKOqHRYu1QTzM5t8IujtJh5sCj9N8HfF33gQNir1MC
 p7zi2aUFL9U1zPx+ZGmYfzTlEXNyH1vLUhQhycHdSGg95nCoe3bx+p8JVDmfTOYmfRJGp89tm
 y7Xckwe/63qGnD39bqh3MJtX4IO2SNyN3ZEk0DYkj0FYpUUlsXMTDzltQt6uCy3t0+ISyL8xf
 wycK6yqgA1z77v3gFk1XOP486ZZASPcmQeB8FiKxzxKea9U849OVFZrkUWpbZeVbhT6R7qvAC
 Lbnb/A6BqaWxrQsC6fME0nryI5HgNZ0bVB6gK5qw5+Ulgt+zKcZOX5z+1J64GIHdPVztA1C+5
 OPtRpWXflleiuw087jn9P5Z806zQakvTgbDWMCxjc4Kn6dthXvopjT2l2E80tYDVxdaYxAKqq
 Hxy7EAxCYpwnNxqc9d2IqGOYSHz3cuguVYOYvsCI/jMM5GZrv1lkgSAHKvUXI2nZp4401IRM0
 bZUN+ZqyDS3hdf12on8PxpilZKkV72LElEGAG5jjxfi1U//uMTBYEJQ99Z8ha3iO6wZHetNAV
 xs1ny/07kOkCooAJi9H6EK2ZAnk5KF/iTJWtlBddMvT1FPs0l3vPbXsb+2b2ktFCQ97nsePXL
 9ET61VBvZ+rm+rPrOfvIfYwIuqzTAgX/z5GxrZt57aFpwzudui6ajVfG5i0qtYmK4rvLJ0OcV
 CzsjeI3cwiKhjiBtIbE/1fc/6oGl+71d9uq1CQzRg1+cE8MfEjqSO1oIJi9WT7K0KV8s5RiNX
 5zcLwAisPgQaLJ+gWUTuWpK50Lw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/22 20:07, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The root argument for btrfs_delayed_update_inode() always matches the ro=
ot
> of the given inode, so remove the root argument and get it from the inod=
e
> argument.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-inode.c | 2 +-
>   fs/btrfs/delayed-inode.h | 1 -
>   fs/btrfs/inode.c         | 2 +-
>   3 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 8ba045ae1d75..35d7616615c1 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1913,9 +1913,9 @@ int btrfs_fill_inode(struct inode *inode, u32 *rde=
v)
>   }
>
>   int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
> -			       struct btrfs_root *root,
>   			       struct btrfs_inode *inode)
>   {
> +	struct btrfs_root *root =3D inode->root;
>   	struct btrfs_delayed_node *delayed_node;
>   	int ret =3D 0;
>
> diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
> index dc1085b2a397..d050e572c7f9 100644
> --- a/fs/btrfs/delayed-inode.h
> +++ b/fs/btrfs/delayed-inode.h
> @@ -135,7 +135,6 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_in=
ode *inode);
>
>
>   int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
> -			       struct btrfs_root *root,
>   			       struct btrfs_inode *inode);
>   int btrfs_fill_inode(struct inode *inode, u32 *rdev);
>   int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c4b5d4047c5d..54647b7fb600 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4019,7 +4019,7 @@ int btrfs_update_inode(struct btrfs_trans_handle *=
trans,
>   	    && !test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
>   		btrfs_update_root_times(trans, root);
>
> -		ret =3D btrfs_delayed_update_inode(trans, root, inode);
> +		ret =3D btrfs_delayed_update_inode(trans, inode);
>   		if (!ret)
>   			btrfs_set_inode_last_trans(trans, inode);
>   		return ret;
