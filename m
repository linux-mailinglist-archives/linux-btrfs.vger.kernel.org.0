Return-Path: <linux-btrfs+bounces-15561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CDCB0ABB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 23:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEF81C81D43
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 21:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AD521E08B;
	Fri, 18 Jul 2025 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OCKv/VfH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E4321ABA2
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874947; cv=none; b=B9MDvnP5Dwx32JuqO1SvRLdjYHtGCl7dNimM5XkbthF6DU5efwE0Pvac3qYFLtPuLhx7FfKOAR0YFOneL4/tCI4Hot60yWoKkunoCCtFv3cmkSNoXCcibusCAK6N/bD1XO9alUwnLae8nYgxdn2CQl0nqizAOvQwB6VbjNRb0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874947; c=relaxed/simple;
	bh=7VSyURCk+TueG7/WkzOn3ziAcEefKU+JRA46LMlHd/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qMTHOTiEcVfFrGGLtpAmVmkDaxV4SdinEVTCgo0zoK0P1fWzoMYbw6tFSC7CK/Eo0HxCNjWMV1iigFpP3P9ZjFImcFRkJFo5VDVKtpFg3v3YE0DuWZOsjN7c+wLtN5gTTZn31wCNAq7yjvRO0ty1wFxUWY4zQ5wdHcUyJayhgnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OCKv/VfH; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752874943; x=1753479743; i=quwenruo.btrfs@gmx.com;
	bh=IpefYLMWUiiEFyrxu4bwySmeBwtDUOoLRwT36Uq+Pjs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OCKv/VfHCexmo1A4IVqaAxYvdQd2N17gTXk5Y3gSTlpBZBwRoDKPdrd9AX3HfofM
	 wpvquFCBMX5sjTA2UAIKt8C4YifhGdWfzyPhPUalmRL6gYs+vzHn/8wF6GH80OTcf
	 Dwv/Y6pqb4DVHpSTxhYm3KR2VVE89XLVBbuNNYYze+zQM9k4yLEvvzE9e6mTx6aZv
	 r75h0/FEmOWb4sHKMNx5n4nplLdF7564uWpDzAZd3T0LQObaugaTvdYIHrkd6iZgn
	 XCDCddmpckSJm9HnhYwTPLf9gaIBCfxoBKAw4bgNwGZ/5MuAQVYaGRamNxd8CiDjk
	 1rG3oiG5t3vgo/Gd6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2Dx8-1ujulM34jG-018DCx; Fri, 18
 Jul 2025 23:42:23 +0200
Message-ID: <45b28eee-c05a-4030-a4ac-a3543646be11@gmx.com>
Date: Sat, 19 Jul 2025 07:12:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: send: use fallocate for hole punching with send
 stream v2
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <227dfa8b9395cd21c186fe4122582bdbeff8d2a2.1752841473.git.fdmanana@suse.com>
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
In-Reply-To: <227dfa8b9395cd21c186fe4122582bdbeff8d2a2.1752841473.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VcWX0maeyyFKoSShbYnWWv3GMzeyH4mTwmsIFj/RDnOMUD1ErYj
 JQsLJzVDC+BguvcPDWLWlG1hQWYS8095uiMWm9Ncie5tQWIb2phxHP8rLCxBVP7MI8XDR45
 0O6N415otzS2qratnYseVCiqnRQx5iFLdrdX9eEij0yxj0kZ6pM8nLk/MitQEgf4VYyV6Hr
 DlvEBgm6FL4qbL7bbMUCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BV0YPah5U78=;bUvp+h76cud4MdQSMxvWNyuNbZh
 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



=E5=9C=A8 2025/7/18 21:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Currently holes are sent as writes full of zeroes, which results in
> unnecessarily using disk space at the receiving end and increasing the
> stream size.
>=20
> In some cases we avoid sending writes of zeroes, like during a full
> send operation where we just skip writes for holes.
>=20
> But for some cases we fill previous holes with writes of zeroes too, lik=
e
> in this scenario:
>=20
> 1) We have a file with a hole in the range [2M, 3M), we snapshot the
>     subvolume and do a full send. The range [2M, 3M) stays as a hole at
>     the receiver since we skip sending write commands full of zeroes;
>=20
> 2) We punch a hole for the range [3M, 4M) in our file, so that now it
>     has a 2M hole in the range [2M, 4M), and snapshot the subvolume.
>     Now if we do an incremental send, we will send write commands full
>     of zeroes for the range [2M, 4M), removing the hole for [2M, 3M) at
>     the receiver.
>=20
> We could improve cases such as this last one by doing additional
> comparisons of file extent items (or their absence) between the parent
> and send snapshots, but that's a lot of code to add plus additional CPU
> and IO costs.
>=20
> Since the send stream v2 already has a fallocate command and btrfs-progs
> implements a callback to execute fallocate since the send stream v2
> support was added to it, update the kernel to use fallocate for punching
> holes for V2+ streams.
>=20
> Test coverage is provided by btrfs/284 which is a version of btrfs/007
> that exercises send stream v2 instead of v1, using fsstress with random
> operations and fssum to verify file contents.
>=20
> Link: https://github.com/kdave/btrfs-progs/issues/1001
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/send.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>=20
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 09822e766e41..7664025a5af4 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -4,6 +4,7 @@
>    */
>  =20
>   #include <linux/bsearch.h>
> +#include <linux/falloc.h>
>   #include <linux/fs.h>
>   #include <linux/file.h>
>   #include <linux/sort.h>
> @@ -5405,6 +5406,30 @@ static int send_update_extent(struct send_ctx *sc=
tx,
>   	return ret;
>   }
>  =20
> +static int send_fallocate(struct send_ctx *sctx, u32 mode, u64 offset, =
u64 len)
> +{
> +	struct fs_path *path;
> +	int ret;
> +
> +	path =3D get_cur_inode_path(sctx);
> +	if (IS_ERR(path))
> +		return PTR_ERR(path);
> +
> +	ret =3D begin_cmd(sctx, BTRFS_SEND_C_FALLOCATE);
> +	if (ret < 0)
> +		return ret;
> +
> +	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
> +	TLV_PUT_U32(sctx, BTRFS_SEND_A_FALLOCATE_MODE, mode);
> +	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
> +	TLV_PUT_U64(sctx, BTRFS_SEND_A_SIZE, len);
> +
> +	ret =3D send_cmd(sctx);
> +
> +tlv_put_failure:
> +	return ret;
> +}
> +
>   static int send_hole(struct send_ctx *sctx, u64 end)
>   {
>   	struct fs_path *p =3D NULL;
> @@ -5412,6 +5437,14 @@ static int send_hole(struct send_ctx *sctx, u64 e=
nd)
>   	u64 offset =3D sctx->cur_inode_last_extent;
>   	int ret =3D 0;
>  =20
> +	/*
> +	 * Starting with send stream v2 we have fallocate and can use it to
> +	 * punch holes instead of sending writes full of zeroes.
> +	 */
> +	if (proto_cmd_ok(sctx, BTRFS_SEND_C_FALLOCATE))
> +		return send_fallocate(sctx, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZ=
E,
> +				      offset, end - offset);
> +
>   	/*
>   	 * A hole that starts at EOF or beyond it. Since we do not yet suppor=
t
>   	 * fallocate (for extent preallocation and hole punching), sending a


