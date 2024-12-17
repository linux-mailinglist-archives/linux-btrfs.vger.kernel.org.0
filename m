Return-Path: <linux-btrfs+bounces-10444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3109F9F3ECD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 01:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6EB71888C8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 00:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A628A933;
	Tue, 17 Dec 2024 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ByZx2Ed+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E428647
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734395517; cv=none; b=sFZl/jXme7Np2Y/U7QunmeGMwulCz0lHiXXYZn4HlboclDYBB+h6meLZXcpT5d1KhrmilI8RTSxN7zYN0Ys8UgfzEoYV62AAQZAMCNk081QRxw1G1uaJKxDhsBIB4AwRlTgIijKDQGdAoCPylDSMgPPPFf5B865mQlUFuY41vQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734395517; c=relaxed/simple;
	bh=NLWDTom+oxaw3oDcidJqcmIYnqJ0GOuhoaoUIksni4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W3gAQ9NqOh9w/mYOvKbgLxCkoexNJzKgbRj8aa8EIYSDW0dCoFnFZ1A3bbgtblHgoJRPi/2ZBRdxvsKPJ4IedTsS+GerIXNuDBcma/f7A89lW3tKjRRpPKOm6TF+OogIv7U3QfeqU74AdRAbC/ahKUZBzAlxTkdGfHZS3iWYDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ByZx2Ed+; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734395509; x=1735000309; i=quwenruo.btrfs@gmx.com;
	bh=W19w6PcF6uqgSF60moImClqF3+udm0iRvWPbJp3XmkU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ByZx2Ed+lIel0U5wpCGoehCtnYKq2iGzGXxPrw9flhADvjxRBGLtBFREYAp2ki4m
	 KHkz6UNjUTePsYYauVHV+rYhe2MfJdfKD3X5S+SS7Ob104JEfblDM/efHJeSzYcSz
	 tHUp3lM+fC8po/egqbPI/PoDgQuG1XcMN4XWJYlg5b8z2/hb1NCZ0iQcNhB7kL7he
	 fnnmqQI9lSE9A14W2eDnafmK8pcVJovxKRLadebmficu6QoPiY6ILGT03ly5jjRm8
	 v8dbdSkzPxlbzgc3UwHf5kdA/EwZQfx2wG5I8zKYA5kxuNWbWDnhEb9DP3h8yaev1
	 iEgZTX4fM6apddGjeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mv31W-1tejrQ3p0C-014cVb; Tue, 17
 Dec 2024 01:31:49 +0100
Message-ID: <785dadec-8352-46d2-864d-3df93d979db1@gmx.com>
Date: Tue, 17 Dec 2024 11:01:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] btrfs: move btrfs_is_empty_uuid() from ioctl.c into
 fs.c
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1734368270.git.fdmanana@suse.com>
 <7aef21820a6bad0e41699f18660038546adbbc9c.1734368270.git.fdmanana@suse.com>
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
In-Reply-To: <7aef21820a6bad0e41699f18660038546adbbc9c.1734368270.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l+kfYKxBxq1aa5u6hliiBKNBYVdgHJ8y5IKellQr/VwBKvNM2JQ
 XJ5NFhL3S9RV59VzS79L3XrGHBsjc/77qJLgKt7dVkRqdqZ5SKXWfbPmSBua0vBQVK79baS
 sIMLprMZQHfiZAX7THNnEyl8NhxRy0vZpnqtxkl5hLiR390NR4XRDLvXsN8pyZNymCCAaIl
 BfYigv3/CSn5Qe5PCOwsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2IEq4UbsWMI=;Xv8REsaCbnOnvOr4+qHClEOByZ/
 JPIrTcpip+X6R9wbWyNMCE1fJ1LVJBCxpJUs61oqxp+vTnRn3SUGT1QN6mBs3FdOvnMJb3+01
 SZKI29sGoEbIIyDQtrCjH5zwO+s5QRjfp4Y+1MT3xEQkk2FSYofQQIo54IiHqo7yA5WPTkWXV
 ca/80m0AsCitUTkQaFFZBmWjvzZztYEXpThmLqgxFVCbxWreCbDYO9uZGWkorzI387XN5skWp
 dzZbjhxeFprKETeQWX1QNLxTiPIjhgkCkuPq+xCOPzToSJTDXewzkDf7MqlteGqGRYh+hfykZ
 VoMKAf4iTLlcqW5vw6vl0HGPQXSs4NwbyvoLewf1FP1Q7143M/dE28xvFRFXnMA4VJue0SxYI
 zo2OCbR5FedQ4Xmsq/l/8awOoy+ZqhsXN+vOKJavxlSi7O46tUEPtisuRl1ezOZRI0llLdw9W
 i7y6qyZhtyODMAovlZbhFsIseUqMmSFeRAmvZKyYbqMOG/3TLU2aob0qfm+g/oIcHzuMBf9Go
 OqQQxdx3rRDDqvM4RPn19QDepagOOoyoR5H+UjJjSziIPwCCFki2PcFubIZyAHfCdOGGv0dUV
 mRgEWpYAzroYCueIhMaisXNTjin4d1GtX3duMdkCcdDYi58crscboSSyjamU1T5QRE2zMNCqS
 pluejl/e3mWm4gTxocB94LrfYX3DkTWJk75ax82bX6fpnmFwGradNG0SEavtJ9YX8vI1GJlLy
 iprnEnGLFhCzrP5Zh8x2w1GBDjdcmcr1+3lAfSvXRBhvW/gUUhNeXHV/PCaPLbfTcXZZn62dw
 a6Gd7BOaiSI9sJBoCX5BXyTNNPHoqJN+0hpK2mm5/xoCeYywo4UXi+BwzjLEexpdR++2tEqgw
 x5G9SRKdQ4lze6KQaM8kbhO9bNpEPEQaZyLX9wXQvmtqYuAbZ1A3iy/qQ6j6zMAgLg2YaPfRv
 4QGZefRCGWtTtg1daf46wtrHc6hHuM0SEOyhNRxvU4TQxiWnrsqxIqRGOKQIbd8gYyTern0ZP
 SbRa0HwQznRGQHpw9lDFNpvqIon5Ua9c7n1XqZtvJN1W3PSZikdB2OdNCs2G9duY1Qg68Kxgt
 kcKYF/30l0lUI/9xx28NZo1Fa28Yf2



=E5=9C=A8 2024/12/17 03:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> It's a generic helper not specific to ioctls and used in several places,
> so move it out from ioctl.c and into fs.c. While at it change its return
> type from int to bool and declare the loop variable in the loop itself.
>
> This also slightly reduces the module's size.
>
> Before this change:
>
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1781492	 161037	  16920	1959449	 1de619	fs/btrfs/btrfs.ko
>
> After this change:
>
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1781340	 161037	  16920	1959297	 1de581	fs/btrfs/btrfs.ko
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/fs.c    |  9 +++++++++
>   fs/btrfs/fs.h    |  2 ++
>   fs/btrfs/ioctl.c | 11 -----------
>   fs/btrfs/ioctl.h |  1 -
>   4 files changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
> index 09cfb43580cb..06a863252a85 100644
> --- a/fs/btrfs/fs.c
> +++ b/fs/btrfs/fs.c
> @@ -55,6 +55,15 @@ size_t __attribute_const__ btrfs_get_num_csums(void)
>   	return ARRAY_SIZE(btrfs_csums);
>   }
>
> +bool __pure btrfs_is_empty_uuid(const u8 *uuid)
> +{
> +	for (int i =3D 0; i < BTRFS_UUID_SIZE; i++) {
> +		if (uuid[i] !=3D 0)
> +			return false;
> +	}

Since we're here, would it be possible to go with
mem_is_zero()/memchr_inv() which contains some extra optimization.

And if we go calling mem_is_zero()/memchr_inv(), can we change this to
an inline?

Otherwise looks good to me.

Thanks,
Qu
> +	return true;
> +}
> +
>   /*
>    * Start exclusive operation @type, return true on success.
>    */
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index b05f2af97140..15c26c6f4d6e 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -988,6 +988,8 @@ const char *btrfs_super_csum_name(u16 csum_type);
>   const char *btrfs_super_csum_driver(u16 csum_type);
>   size_t __attribute_const__ btrfs_get_num_csums(void);
>
> +bool __pure btrfs_is_empty_uuid(const u8 *uuid);
> +
>   /* Compatibility and incompatibility defines */
>   void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   			     const char *name);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0ede6a5524c2..7872de140489 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -471,17 +471,6 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs=
_fs_info *fs_info,
>   	return ret;
>   }
>
> -int __pure btrfs_is_empty_uuid(const u8 *uuid)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < BTRFS_UUID_SIZE; i++) {
> -		if (uuid[i])
> -			return 0;
> -	}
> -	return 1;
> -}
> -
>   /*
>    * Calculate the number of transaction items to reserve for creating a=
 subvolume
>    * or snapshot, not including the inode, directory entries, or parent =
directory.
> diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
> index 2b760c8778f8..ce915fcda43b 100644
> --- a/fs/btrfs/ioctl.h
> +++ b/fs/btrfs/ioctl.h
> @@ -19,7 +19,6 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
>   		       struct dentry *dentry, struct fileattr *fa);
>   int btrfs_ioctl_get_supported_features(void __user *arg);
>   void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
> -int __pure btrfs_is_empty_uuid(const u8 *uuid);
>   void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
>   				     struct btrfs_ioctl_balance_args *bargs);
>   int btrfs_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags=
);


