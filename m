Return-Path: <linux-btrfs+bounces-17738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A83BCBD649C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 22:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACED44F373D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 20:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678EC2F49F8;
	Mon, 13 Oct 2025 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="F6Je6MXL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F06A2EF65C
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388755; cv=none; b=iHK1MhGOrnAbM7BpSNCqRxnhDH93VxLqUoBeSCyZXq6SqFNn9ZzGAsh1GeyLvN6gaWgfX068iN/B7Q3kecmfSag0ONsIINv6zb9LmcV70flU/wsx6BGzlAyn6gH0jZLaizRXd7nNVN4l8ejwTrmNjNeFPU0kiEh1nTEmpVmsbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388755; c=relaxed/simple;
	bh=5YyO8BnyOjkqYzHFCc22IaVYWiP3NipRizIHZpBtXNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C2H8TAKpjSucFzYMIfKMC8UVxRkKzQw7OL9kgD8urY0KNjTDCNOIMWVE1ZYuHk/gvIK4H6i/nH4+CYW9b2JhoJJPntwHDHj3BrFigUJsqPZS1gcvEd/KdEPCCuMgtaEz7XjrGLVGYeo7OdXl3nDY1Ldu021wlB3r25VsxM6+5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=F6Je6MXL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760388749; x=1760993549; i=quwenruo.btrfs@gmx.com;
	bh=7hY1aKZ3gOSyI4Qlp7RuP9h8mq+rUyWeFc5reFE3XAc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=F6Je6MXLXja7hFwySj0UJydLG+SZreh5GzHSFMURc7/fjaslwBYIn70lI+r7la2M
	 6SOzCJTnMwONOZSxRlygbuyrvYKD45FkljcCEyxMiH3VQNYoRJM/lWWacPIUOIMdl
	 Lg/ussYwMo5GSGyUmr8nCJ6uwK8l7Bq6o1q90OCjq1CPmyKoAoPHgK5vgaAYNPX8F
	 l7UE6IHqIiXc1CnBzPlDBLmzFL+pybiQ6HNrrfpHYBs429OZybunFOBzaDLbB6Xbd
	 QgP66Tat7WcCynKN6t+Bfh/vswCuvoWBjOnSjvySi9xHsrfAp8iFLT8hG8Py0/int
	 OdLlIftt0LWLfS7M/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbAci-1uX9tt085o-00oL4N; Mon, 13
 Oct 2025 22:52:29 +0200
Message-ID: <2152157f-4dcb-4c31-b124-68c8746f03e3@gmx.com>
Date: Tue, 14 Oct 2025 07:22:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] btrfs: add unlikely to unexpected error case in
 extent_writepages()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1760356778.git.fdmanana@suse.com>
 <7bffa1a8631f3dada0ad49265968f56c155c91cb.1760356778.git.fdmanana@suse.com>
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
In-Reply-To: <7bffa1a8631f3dada0ad49265968f56c155c91cb.1760356778.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uLKubsezTa2Xi3ASjCgzhHI2UaAmn+b6jPD7dZb8i1DKrxz6oiK
 F2YEcOWW5hcFoF9oSoXo3/ybU/1beO+H82D5EjAdr/gCvx8s6HOseXFLBkY1kJ0EIUDmVQQ
 +qQ4GxAskUFysCTi5p9GAv2QpOvbnm3e7P5UbZ0PfY/a3TKoQbtmbpqerjTkdnquUNDt2cR
 xYH1+peupFUDdz1jILhzA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ro9kR6THNO8=;UOXJlC+0efzjfTKGyq3vLEd8iyT
 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
 LCwhA==



=E5=9C=A8 2025/10/13 22:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We don't expect to hit errors and log the error message, so add the
> unlikely annotation to make it clear and to hint the compiler that it ma=
y
> reorganize code to be more efficient.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1cb73f55af20..870584dde575 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1874,7 +1874,7 @@ static int extent_writepage(struct folio *folio, s=
truct btrfs_bio_ctrl *bio_ctrl
>   				  folio_size(folio), bio_ctrl, i_size);
>   	if (ret =3D=3D 1)
>   		return 0;
> -	if (ret < 0)
> +	if (unlikely(ret < 0))
>   		btrfs_err_rl(fs_info,
>   "failed to submit blocks, root=3D%lld inode=3D%llu folio=3D%llu submit=
_bitmap=3D%*pbl: %d",
>   			     btrfs_root_id(inode->root), btrfs_ino(inode),


