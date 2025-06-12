Return-Path: <linux-btrfs+bounces-14614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F82AD648F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 02:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154103AC9AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 00:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B63E2940B;
	Thu, 12 Jun 2025 00:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hRBlpBxS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88471182D0
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749688481; cv=none; b=IZdCzVdttu6MLUzuqeOgOzHh6hE8lUoz2NrbcOQli0ul6Pgg6/NqSxwlO19tPs+woIazzJXP2d1OhCapQ8mZyJXkkyrbf8TbG9gDjKwcLfM1BhvFxCd/c7jVy4SeMKiShcnBm2n6WaYSlncqXwgUJ0FYwLu5TbEYS7MiI27ttXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749688481; c=relaxed/simple;
	bh=7BtLjgXmSuC9PFY+xQ2vOgX4hyj7NZGwLfoaDTTOpMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJXWrPu+LBF3h06M9lWle46v+LzDBIC+yZV8j2MadYdXUwvRbePHA13N+34F62WDkjrNGHYDWWNb3amZg7JuUY1sg35F9q97VrTwBJcI56zs6N+mEpsvaCzMenJeE9N6RQbqmM0nIi1FVPPdDkku0/OZCS8Ow+65+zXaakB41C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hRBlpBxS; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749688471; x=1750293271; i=quwenruo.btrfs@gmx.com;
	bh=ydqC+sN4NKPzGvOx00onCDX2nAesjFy8OetLmC/Jvx0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hRBlpBxSWs9PU0cqvRNP6Rf8i8E1nkCRcBxbJ5aPnU3+01QxWNf59CL/CI4WiER3
	 3Dir25dfDARai5J40mEwJEmoztt3yAu/r5bB36/RE6UiKCEsbZQw6lbkB0XRphQ6/
	 fY+TUlzoAtappEbWbVWEej96OHBB5euJEqIyQYSaOwxC2g05Wtc0cfBCv6yHu1zwS
	 IZ0EO1k0OZ1We2suNK7E1AsfQBr7ETRjDWQOABDHBJwmTZX3uoE06cHzd0GmE8y7+
	 8DVKd+9f5atS/X8HobF9Tx6ikKpup/huP1Hr+fphGkLrKGVr0wvLTTCVWS7K+uJ8n
	 EufpBBi7BWPpoxBw7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mf0BG-1v0Wfl0UTS-00me55; Thu, 12
 Jun 2025 02:34:31 +0200
Message-ID: <4bb69863-1fcf-4f60-94e1-88cfc1bc4532@gmx.com>
Date: Thu, 12 Jun 2025 10:04:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: restore: Remove stale debug message
To: Marcos Paulo de Souza <mpdesouza@suse.com>, linux-btrfs@vger.kernel.org
Cc: wqu@suse.com, dsterba@suse.com, anand.jain@oracle.com
References: <20250612002244.381346-1-mpdesouza@suse.com>
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
In-Reply-To: <20250612002244.381346-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eirAKf3Cfc7rhdNUwmcma2qKvNnruS2RVGgQoVpSKnip42MrIIF
 3q2FAkyzzFKF+IGV3E4hvmYyhX5ZoJwvpMT+jXobpJkU6FZ74/6fx9/jaKTSvdPdWJoYyxv
 NzG0NjqqjqqBu5UDer7Vs4hHAMy+uKD4fKqL5YvnChDcJ5JYkseR9cXyBOCzRInirUrR6QP
 CQDu3lG+x3iQgFGzYQbsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FHsgmbuKtLI=;IWfYqo+I6XU/lyk49sYzT+14qpG
 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
 S0VFQZtoB3NBx5q8NBLQi4uGm



=E5=9C=A8 2025/6/12 09:52, Marcos Paulo de Souza =E5=86=99=E9=81=93:
> The message was introduced on 502d2872
> ("btrfs-progs: restore: add global verbose option"), and it was never
> changed. The debug message shows the offset of one  EXTENT_DATA from
> the file being restore, but it's only shown when it's not zero.
>=20
> This field is non zero when the extent was first snapshoted (or a
> subvolume was created), and later changed partially, so the extent was
> split in the part that remained the same and the one that changed.
>=20
> It's not useful to have this message being printed without proper
> context to the end user. The message itself isn't very useful in
> debugging sessions, since it would be necessary more data about a
> problematic file/extent. And given that the message is here for
> more than 5 years being unnecessary printed, it's better to remove it
> since it can annoy the users.
>=20
> If a problem appears at this point in the code, a more appropriate debug
> code could be introduced instead.
>=20
> Link: https://github.com/kdave/btrfs-progs/issues/920
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   cmds/restore.c | 2 --
>   1 file changed, 2 deletions(-)
>=20
> diff --git a/cmds/restore.c b/cmds/restore.c
> index 6bc619b3..464a7079 100644
> --- a/cmds/restore.c
> +++ b/cmds/restore.c
> @@ -391,8 +391,6 @@ static int copy_one_extent(struct btrfs_root *root, =
int fd,
>   		size_left -=3D offset;
>   	}
>  =20
> -	pr_verbose(offset ? 1 : 0, "offset is %llu\n", offset);
> -
>   	inbuf =3D malloc(size_left);
>   	if (!inbuf) {
>   		error_msg(ERROR_MSG_MEMORY, NULL);


