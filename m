Return-Path: <linux-btrfs+bounces-4882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C11B8C19D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 01:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3B11C22C26
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 23:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8F12D771;
	Thu,  9 May 2024 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="nXs7WjvW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D6376E1
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715296398; cv=none; b=J/BR3qeyCzX1Zx7gqcDQo3OPLuXpnA3kvTVm7LVfZhTLnfnw69r+W1Po6IIR42+ujl+yYLzgf5QhUFpRkWkIF28/3j5AASAE1TPZ8cZ/FnvSCMUJD6a0NGJIepWxSoxYY1K2vx0n+7fqd42aevW04RImDjLh25D47VEBsRSC9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715296398; c=relaxed/simple;
	bh=vL+Cdto3jnFlh7Ts38EpPwxYdzqIpHkq2EhbNFPxLxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b6bywmJin09poRklsKiJzrLOLwmLYtYBmMhcst89DMt6wk64Tds8ECl2Onc6Qa0i8tRbLhMuJMNUm2cOabnfv/HELF+JsrGqp2qlm2oZmp5EhFBr8Rylsy1IgOdhVOCOpjjcxvQg2opnh1Z/9ZpzhQIWSnnEWL7k4+ka5/TmXco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=nXs7WjvW; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715296387; x=1715901187; i=quwenruo.btrfs@gmx.com;
	bh=LxfzImceW4py/g+BOHlYSVTvx0ThTKK9no3WVHHoxgg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nXs7WjvWjBEeemyQoW7BhGzCPaiHWlQZcTa1QET06Ly8WNq8LKiJr7VAOa93jlg/
	 Ht/yv/AJQKfjf2azfwcW4O75MedyC2Z6E5FHeG9BHk+7sHq91mMvB9M3WuXJEKI30
	 fcCuOzEA5tAV5MKOQsPnhObMClop1gr/ArNiWuOF+fPns+33a9Zz63OQG3xQRbjx8
	 yD3UjMyhG7GkfUx3SwbkrwJOV5WHF3IKPrT4dQU/kxGBvAseDGFBvaVd/8zgfYQTA
	 rSY8W2VhuzqXQgTIhxuC3QciYhRgN24rG93EfJv72/3olnUAOGlI+2c1/zWLJm0/B
	 0BqkCqSGYGVmQJkF8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKsj7-1sJ9zz0B8n-00LHnF; Fri, 10
 May 2024 01:13:06 +0200
Message-ID: <5c88c882-d153-453a-88d4-4fd16c090ed3@gmx.com>
Date: Fri, 10 May 2024 08:43:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix qgroup id collision across mounts
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <f7e7c99aded1f18703dd19ec6b92cf3c7d635060.1715296042.git.boris@bur.io>
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
In-Reply-To: <f7e7c99aded1f18703dd19ec6b92cf3c7d635060.1715296042.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iZ1BT9bumoutwJEJuVS7djrk52Mf3aoyO9uXwPdNemP/jRyQ9HX
 QOYMpP9BU831WmaLsVpvF9h6D55QmT309iMXOsKy+Q+3tpwZcxC9Z/t8B0XiRpwQOHPeYUU
 yWTs8DezmZFQ1/CHBBXb9ZBWkyNmM4FTqbhXiFDx5e3DOYi6smhTiIUzLYrqQ6b1pQHzOBL
 jxB/dAbacFvzTE9jDX4+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oYl2zpl0wJI=;rm27a9zJoAobIutfDTRJ1UlIH9Z
 IP8fi14y16o7A4aW9+MpjDoOUyQJ2wPUYDEXqQuVYJBav0EmQlCwE0Z/RHoS0ph2XdWj9Eo5r
 bu0QC6X88rMqeW3UFyGogv4su3plzE0EaLIdIaSs3DUmtd3rUd90ZoPqGy3AyYKeTF+e3GQpN
 xXWD5LnAJ7ibrgLznS4kogHKpL4+6s7nN8ChpSBwPhKWMSU9kL4+03zvhhhsKAKZcxb4PkO2D
 OnbZeMXGBq+EtP2vT+eA6teXq6q7GAp/zZBuUewZO/R2CeBfJpkYbH5+zdfRhax/9mptLX91/
 sRpUMfLb+zl+xGYecezItxy8zVPf6LH8vXgmTVIoV0dzsC65Ocevlg6swo2N/rwYjxnK6GhaS
 B86a3UTeYbgtQoSyBhM5df4f+/arvcx0zPS5iVhKHwabnrO3repmYpRjFyTxSDADDRZrehcU/
 jMaGAZh4gQejaV62bsKUIzpIvWKCdGgn15p5cetgY73Argt+hnxCTdtyqSFIy8JddqvQofJgE
 VCYGWdn4Oup5MzQc2w7WSccw8EBsibE7KIYn9BHcwjI0wIOOfS3e4V2ktoN5DeSiV/vHaNOSC
 GXyu7axT1sarreiSLwe1JOtJXt3z28AwQZm9ZHedqgOSb/OwyYvltLgA06oXmKkQoRLqRDPuF
 Ze1GeK9eKjsfFund3sAcH6H8953cr0rDT+nx4LzYD2SKbktgIT/gUK+02Gi/Owt2KDtBtJlCY
 Wy02yZHDkEiyHaW1uGhj71GjLApwg4KYAlZTRZUrgwZG5k3VzECA0/+67k5Y5wcNNUxbY+EvG
 LfgHIpQb17xy43FRvw43gofrykr8brxRUbYD7FiPXTbA4=



=E5=9C=A8 2024/5/10 08:37, Boris Burkov =E5=86=99=E9=81=93:
> If we delete subvolumes whose ID is the largest in the filesystem, then
> unmount and mount again, then btrfs_init_root_free_objectid on the
> tree_root will select a subvolid smaller than that one and thus allow
> reusing it.
>
> If we are also using qgroups (and particularly squotas) it is possible
> to delete the subvol without deleting the qgroup. In that case, we will
> be able to create a new subvol whose id already has a level 0 qgroup.
> This will result in re-using that qgroup which would then lead to
> incorrect accounting.
>
> Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation"=
)
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

This also affects regular qgroup, e.g. the qgroup is already
inconsistent, then the delete subvolume would leave a non-empty qgroup.

Although it's less severe, since we need a rescan anyway.

But for squota it's really severe since there is no inconsistent status
at all.

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 2cba6451d164..243995b95e63 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -468,6 +468,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *f=
s_info)
>   		}
>   		if (!qgroup) {
>   			struct btrfs_qgroup *prealloc;
> +			struct btrfs_root *tree_root =3D fs_info->tree_root;
>
>   			prealloc =3D kzalloc(sizeof(*prealloc), GFP_KERNEL);
>   			if (!prealloc) {
> @@ -475,6 +476,25 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *=
fs_info)
>   				goto out;
>   			}
>   			qgroup =3D add_qgroup_rb(fs_info, prealloc, found_key.offset);
> +			/*
> +			 * If a qgroup exists for a subvolume ID, it is possible
> +			 * that subvolume has been deleted, in which case
> +			 * re-using that ID would lead to incorrect accounting.
> +			 *
> +			 * Ensure that we skip any such subvol ids.
> +			 *
> +			 * We don't need to lock because this is only called
> +			 * during mount before we start doing things like creating
> +			 * subvolumes.
> +			 */
> +			if (is_fstree(qgroup->qgroupid) &&
> +			    qgroup->qgroupid > tree_root->free_objectid)
> +				/*
> +				 * Don't need to check against BTRFS_LAST_FREE_OBJECTID,
> +				 * as it will get checked on the next call to
> +				 * btrfs_get_free_objectid.
> +				 */
> +				tree_root->free_objectid =3D qgroup->qgroupid + 1;
>   		}
>   		ret =3D btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>   		if (ret < 0)

