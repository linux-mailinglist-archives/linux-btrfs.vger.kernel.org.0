Return-Path: <linux-btrfs+bounces-5862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE779115BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 00:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187391C22758
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 22:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF791422D6;
	Thu, 20 Jun 2024 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SKvnTdJ4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772A13E022
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922439; cv=none; b=PXf7Zuo4firbyrmNR0tHnoCt9FDQUL9Q7c5lTnDkXE4Y/e0wSIJQ30vMeLW8MwZLkA18Z6uBxItOHbU7ZtJi8VCIUgguJCEzBjM040Svtm55KPWK5HpCu5QHjvMH5+tdFYZsgK7rktimUuNoug4hHgGG1kKWmMn6vzOnl2qVasg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922439; c=relaxed/simple;
	bh=4cjFGLvLL0W3VgkFXjs8FEYY6XIQ9/i56JqSzZYBkNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F+5Vh2giz9fhUgjdJ1wN7yhGVv0pFBTGTcp5c9bomdH3zpwsQPINxZn9n+yfR5iRRxCqcRxcTg6ER3XrncHGSMjgl4KVr5Ab14tJ08tttrjj8ZTjLEU0KY4vTzi9R2YWGNZf5QYp/MoUYc8hStkmkwjcgRrb/0EIzH/5CLxoDuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SKvnTdJ4; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718922431; x=1719527231; i=quwenruo.btrfs@gmx.com;
	bh=1UMwi+DWCqUieJcnY81xtWWPL3zXinSzaX3OD/Wj6hs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SKvnTdJ4Q2egkMsFXg/zJDtCn8oTUcBR6RNyz+GvA1S8FZ2za33anrD6lDwxLrWx
	 LhwQX6NCZBWMbkwQiJe4WWlqS4SNmU9DZ0tXHqUDRurpmi7kHmmb5+wUwwqikCquz
	 SbDqHcl2JIvsRi9TmMRfEnIl6Jb6g6gsKVhJX2BJSDpkfO+XG/BzaUINNGGmK2rIt
	 D1b7xWU5Eub3ddvSkMK9zKPmTPTw0B2V+LRUpuz9O3fEKXZkdikF9r7msxmUSnMIH
	 KfDiEqAWP28+lhE/aZqqDUQVg2Zq0iKXX1RJYVTOuqIvZ8zNTJ2OX26Thy+M/OWbW
	 6P40yK058+a2+Z8obw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8ofE-1sOBRI1MuM-00uKXj; Fri, 21
 Jun 2024 00:27:11 +0200
Message-ID: <3bb274d5-a859-4571-8358-730515b34f73@gmx.com>
Date: Fri, 21 Jun 2024 07:57:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: fix quota root leak after quota disable
 failure
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <d4186215561658577a9622bf111c79909f0521c6.1718883560.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <d4186215561658577a9622bf111c79909f0521c6.1718883560.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6HAGNnLeDO/brz0vuTALAYkua1l3IzKuISetHEtUPxh6Zm2zOcF
 0ksqSYX1fbIx7Ty/E7srcncFJILASuRtRvJ1Y4Gzu0ZQaHiSNii9w5InA8eWGY6JmBqTylB
 UBii19XtvmZXDIO8VtbsOOtjdOi0t7JZBuWm2jxw7EbIU1zKnLkcwAHs7yCxp/aTQnIEa/t
 3F17n6vdwc6UXb278kcCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j34UyugRRRM=;0qnIccjE+Bmue9D/EotuqJL4xqO
 R6XWTy+Hd/WV3e6f76I15bObTmzs4cV2QBpFEKw/6gnlKoxvacSOB+YlOVqPX4usWS3fy+UmS
 FwKMWzovYArPTGwUYPOWZGQf9BrgnzRVQfmd1QtAFVO9DSEx+ttbIFSaG09gPI6f5HH54EIzW
 mjdsCltv+/v7S3JhylnvYLYmxzRzUp2+hskneHfZzURTHNd5jmTTzR431ufkVczJRyBE1wzVx
 HIHSYeqafDwFt2V+shTe75Qj7AdGZfEkM13MWmy2QGFU0rLBXrDDrjafDbqRKw1eNCKTyJV3+
 1+3+FHxN4iFr0cLiHqeIgX/cd2L1zp4pGhQ5HCKjVN9P+xX9UTNxYvvTcmyhAsZbHwKL7Ix8U
 89nle6N/Auyo7ryQFETLq1wO8ChOj8w02Tc74Nw9ngvRT+P3jhk8nzBWPpuFVhKLlVBxE6Sjy
 ffGIwa1YtOIxjVEYQH5qENEI8Z6EGDOxrnlQLV2LqWWXLevC1Kc24eJcJLeT0v/f2NRLHqZiI
 LuKWUc/5Bzvbi1aF3YgzojsyLsuiCyVRqmnQKYIiXwW0J9begs4qqmzMe9WOv1N2ZNbhjvhLz
 7SS1gW9WLIQ3+EbDO8o9W+ULK0XzbKqsrTi1gfGuSn+2Z7/Dx0ICWH200/JWmuwdV4vrAkxqA
 9u7ANy04SWlE7831uwbrh0z/mDvbrpMZjEnIX0OkK8UBaetffC/hVgcJ+Rna/NSDQ52BnlLLS
 kHJ3GW8j+PFaK9OU67nyXKsi0AYo5DMuvXUEYUSwgl7jhCObS4sTzvKvdNLc5fn58souoYbOO
 1KQVAcBUm49ZTkD5kLRSqbTNoENgbPOaFio5+ZH6tTMho=



=E5=9C=A8 2024/6/20 21:11, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> If during the quota disable we fail when cleaning the quota tree or when
> deleting the root from the root tree, we jump to the 'out' label without
> ever dropping the reference on the quota root, resulting in a leak of th=
e
> root since fs_info->quota_root is no longer pointing to the root (we hav=
e
> set it to NULL just before those steps).
>
> Fix this by always doing a btrfs_put_root() call under the 'out' label.
> This is a problem that exists since qgroups were first added in 2012 by
> commit bed92eae26cc ("Btrfs: qgroup implementation and prototypes"), but
> back then we missed a kfree on the quota root and free_extent_buffer()
> calls on its root and commit root nodes, since back then roots were not
> yet reference counted.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 3edbe5bb19c6..d89240512796 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1346,7 +1346,7 @@ static int flush_reservations(struct btrfs_fs_info=
 *fs_info)
>
>   int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
>   {
> -	struct btrfs_root *quota_root;
> +	struct btrfs_root *quota_root =3D NULL;
>   	struct btrfs_trans_handle *trans =3D NULL;
>   	int ret =3D 0;
>
> @@ -1445,9 +1445,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_i=
nfo)
>   				    quota_root->node, 0, 1);
>   	if (ret < 0)
>   		btrfs_abort_transaction(trans, ret);
> -	btrfs_put_root(quota_root);
>
>   out:
> +	btrfs_put_root(quota_root);
>   	mutex_unlock(&fs_info->qgroup_ioctl_lock);
>   	if (ret && trans)
>   		btrfs_end_transaction(trans);

