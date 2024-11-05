Return-Path: <linux-btrfs+bounces-9342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96F9BD73B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 21:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCDE5B2308D
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 20:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2D0215C51;
	Tue,  5 Nov 2024 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DygWuC5Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884603D81
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730839856; cv=none; b=Q/ZX+uUkQ1Zw0P0uItd4EeoscwrUBfzpFaCVc2L6TfHkEgGQkcQu3TwXvn9zPWf0SYgh5I2PJYg0JreRKKd9cQZhwIgUw3GSG4fnyF4myNB29VWbhkGAHFDhH2YPgjKPyi3/vmEAU8GRaagMGRGmD4ZJDKmsz2EPQ6oZEmilhLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730839856; c=relaxed/simple;
	bh=fDoNZvIL3uh+d6gVhJMqZMGTHOQMaSZmKM5gRqS6ILE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tkDCXks/W0HsWqVJ0mo0rebtjwI+XUluw75q8a+NGQXNcJY4sSNYWS23hgTxc7BkX+7BmGDTFh0CPU0J7Ds4Y2Sj7qcaVou6ihT49NOXuxmn051gIMDPWP2ernwjXA4MskNfkd+dkVElp4rsEQKiX92akL0MHZky15YfrcGnl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DygWuC5Y; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730839847; x=1731444647; i=quwenruo.btrfs@gmx.com;
	bh=oX5wXzun1ua4hZP7PiaNEPZtQFD0SkBlmk0QNC7HwHI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DygWuC5Yc2xqUZgsmjuxViGI30AXyloI5u7uyUJ8e7uLUZ5jxvZ0Ha8/+MQHK6Ue
	 x/Fp5gvssvWdCxZ03GHZJkl41SP03ap1VRxARO0m1GTXc05DlwVQAtiLSsgNd3Nhs
	 0jZMVmL0SS1ii5W87rokf4pVLHKS+8FXG2TxFKyeowSsNLjc6ioGD4uT9JkHbtoCR
	 YJw+7yHqqFoEhrMSAvxQAUle7I5vFhcj8XbXaEpN6kbFM+7ExuppxVQL/+vkZRa2o
	 eFn31nRTh8DLZSNGNGACRFAagbR+21+EDMX1weWlF9zQ+fOV+1DOP0m+feKCr0ovj
	 V1gXvghOeITBFCQxlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Msq2E-1twxpe2sCO-00yvLI; Tue, 05
 Nov 2024 21:50:47 +0100
Message-ID: <d1392590-f85e-4a1c-8ec9-b757d3d76769@gmx.com>
Date: Wed, 6 Nov 2024 07:20:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove hole from struct btrfs_delayed_node
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <008db737b88fdf9993be37ff44edc89e31a3677a.1730808362.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <008db737b88fdf9993be37ff44edc89e31a3677a.1730808362.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DyrQlVzF2xXe81DLzGUHyk6m/UoQLxNeJr5AP4TZs7pj+qoY64j
 87EdZ7PAjCZPtNn+5DCg1G8S/pzPou7SbpM4nbeFE9kdnYFJon//ygaGXXz2vzQDKlbqwa0
 YqJjT9egnR3rxpw1gqarKxYMmv8cnUEbwyG/5MQs6+M4TrK7W3qGvLMC6/6SBx0hwDzhrS6
 nx41uVjoztqC1q6ofFGAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aoJdbJ9/qgM=;zEp5SgnGjYwm2xuU3zVYjIXUb9k
 AHa6bS60zsklIbsVPdJ+6u9adepbDvt2rTr5HBPQRsfwyjLkYzwQ8inouFxfsDSzXoJRPVkto
 jRJmS2ooeA57wxc23EG32ve1QuYTL+BpwUtTHM3VxrzYMcMgCPB7uVRmkhsbA+iM2mHpCxG69
 8f5bGxoxxDAex/xYNmX0A7yPSpCk8EdMnAUQUMGAzFwn9I5RFVf6W3mTKfxBTU4ENErzy7MZJ
 jDOGS7N70s1xPtFIOnzB8Aeufo+Rk9M7CNi/1CVgD8L5auGKAeCOkWmG0/Ae2Bn+l76mbpxft
 uqsOVhCcPbPeEK0EA8DKOXDtQzcE+A6+3IUXpWusXw3A8o45IGxCvKCNExgth+AcuKzKGIfp/
 lcAffJ30BnWhiu/RxLsc0EL0T9j9izeVzPO/Tk4O2vReBJTnEF9SnnXtsRY7SD8i1bngxJQHm
 pTe3AOxscsifdWu8h6YRuAGm8tWb6kdX7pyNH3bHc9i7dy2F9yFqpSSMmWv7OsgOnTL6IiSPM
 T5FFsG+2S72HkJFMcRIEhxiCXlpcnPpNxg2vxlR7sZrmwsmgp/FnNTDj+4MlwRq2XfkMKytqk
 az+70w+8HjHf6TI3WNzKK5iv3K1li5D7KKq3AIBURg7h6ny6uDFZGT29KFMbawSi5HtBGzZKb
 3OetWT9OPU1DqNdQqwNeUEa1ggWsx1zTeIHA7IbjBBN2Y+93u9JIhQS1RkXnoG0yagr0LXA0G
 GlZan/ibSVBcKPg2nPEh4trjUTCK4tvv5q2PDR+nJeDZrRdF5qHJTPbjes4gRhr8GaoU28SBl
 KQygY1kdStgtFfuR29DtaZVg==



=E5=9C=A8 2024/11/5 22:38, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> On x86_64 and a release kernel, there's a 4 bytes hole in the structure
> after the ref count field:
>
>    struct btrfs_delayed_node {
>            u64                        inode_id;             /*     0    =
 8 */
>            u64                        bytes_reserved;       /*     8    =
 8 */
>            struct btrfs_root *        root;                 /*    16    =
 8 */
>            struct list_head           n_list;               /*    24    =
16 */
>            struct list_head           p_list;               /*    40    =
16 */
>            struct rb_root_cached      ins_root;             /*    56    =
16 */
>            /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>            struct rb_root_cached      del_root;             /*    72    =
16 */
>            struct mutex               mutex;                /*    88    =
32 */
>            struct btrfs_inode_item    inode_item;           /*   120   1=
60 */
>            /* --- cacheline 4 boundary (256 bytes) was 24 bytes ago --- =
*/
>            refcount_t                 refs;                 /*   280    =
 4 */
>
>            /* XXX 4 bytes hole, try to pack */
>
>            u64                        index_cnt;            /*   288    =
 8 */
>            long unsigned int          flags;                /*   296    =
 8 */
>            int                        count;                /*   304    =
 4 */
>            u32                        curr_index_batch_size; /*   308   =
  4 */
>            u32                        index_item_leaves;    /*   312    =
 4 */
>
>            /* size: 320, cachelines: 5, members: 15 */
>            /* sum members: 312, holes: 1, sum holes: 4 */
>            /* padding: 4 */
>    };
>
> Move the 'count' field, which is 4 bytes long, to just below the ref cou=
nt
> field, so we eliminate the hole and reduce the structure size from 320
> bytes down to 312 bytes:
>
>    struct btrfs_delayed_node {
>            u64                        inode_id;             /*     0    =
 8 */
>            u64                        bytes_reserved;       /*     8    =
 8 */
>            struct btrfs_root *        root;                 /*    16    =
 8 */
>            struct list_head           n_list;               /*    24    =
16 */
>            struct list_head           p_list;               /*    40    =
16 */
>            struct rb_root_cached      ins_root;             /*    56    =
16 */
>            /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>            struct rb_root_cached      del_root;             /*    72    =
16 */
>            struct mutex               mutex;                /*    88    =
32 */
>            struct btrfs_inode_item    inode_item;           /*   120   1=
60 */
>            /* --- cacheline 4 boundary (256 bytes) was 24 bytes ago --- =
*/
>            refcount_t                 refs;                 /*   280    =
 4 */
>            int                        count;                /*   284    =
 4 */
>            u64                        index_cnt;            /*   288    =
 8 */
>            long unsigned int          flags;                /*   296    =
 8 */
>            u32                        curr_index_batch_size; /*   304   =
  4 */
>            u32                        index_item_leaves;    /*   308    =
 4 */
>
>            /* size: 312, cachelines: 5, members: 15 */
>            /* last cacheline: 56 bytes */
>    };
>
> This now allows to have 13 delayed nodes per 4K page instead of 12.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-inode.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
> index 7cfefdfe54ea..f4d9feac0d0e 100644
> --- a/fs/btrfs/delayed-inode.h
> +++ b/fs/btrfs/delayed-inode.h
> @@ -64,9 +64,9 @@ struct btrfs_delayed_node {
>   	struct mutex mutex;
>   	struct btrfs_inode_item inode_item;
>   	refcount_t refs;
> +	int count;
>   	u64 index_cnt;
>   	unsigned long flags;
> -	int count;
>   	/*
>   	 * The size of the next batch of dir index items to insert (if this
>   	 * node is from a directory inode). Protected by @mutex.


