Return-Path: <linux-btrfs+bounces-9619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C55E9C7D42
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 22:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83962B25BDC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 21:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8D206E78;
	Wed, 13 Nov 2024 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hd0JqwBS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519213B2A9;
	Wed, 13 Nov 2024 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531777; cv=none; b=CQ4bCH96x/1wP1T/nJBLu6w8Xas9XlkZzuWuhu3ObpHZU2iypMP6Mz7ZMFDF3TA31oLUvpRrKi4ePAbxqjA5r4rrUH6W647YdODBXVIzwOk62MGFHJBTy2Zovl7V8upqjSJcDDkuYYhzvw5kEnEX3uCnA/zukQVqUrUnF8f3sN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531777; c=relaxed/simple;
	bh=cBPSpe8yztKqMAkQS/Y0tcbAqCBtecEG0558RFSZhwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDCqkKo3NRM5NuYUvSeGShxVgs5HUzP4Kjy9+YHzIAMaPRFAi2gshGVCFhaRnw0XEWr7QcgcpByIbdJ1iOGweD9K2pLzvybg5uDbGn7axfFoguuF6Pf3vSpWVKqxtxyq+IftnXGElGZB5xJ6PAI+uOdzALpFORrQntulvAFMKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hd0JqwBS; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1731531769; x=1732136569; i=quwenruo.btrfs@gmx.com;
	bh=HxovTbPvglVD1LIV18rU73GioKzwQdo/QilhjtDUfgc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hd0JqwBSVroy1ApplPfUp6Ubsjm1YNvgm5SW0Wmv6aKbdFwO25wv1Qgi6VODLizQ
	 HCVoP+boQZOl/dZpnqjgCJN5urUyktPM1RFb1rcJnduAYxjiaFY5AR0Qc8KM/5cKG
	 HI+DbvjbnBE9UeyQ0c6vqumJoO3sRwIg05Cgp6fKVE5ZSDmit5mL/QA+AKuN2nCFH
	 v9EGsIdikD2v/bvXZ2+oZE14HtBgoHpBf2xx8Ncc5HpgAlB+TRQOXn9929bvkd5jZ
	 kP0zeR9GUqhIvt2xeiAj/EMzYsdDM2zfx7ARmBEYGt919YRG4Vk/T5GMW+C9dXOV9
	 cx+bNmlo3laJFHUKGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZktj-1tEzVv2iWN-00YmNe; Wed, 13
 Nov 2024 22:02:49 +0100
Message-ID: <9c5033a0-ed89-470c-9a88-3c1b4f68ec8b@gmx.com>
Date: Thu, 14 Nov 2024 07:32:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix incorrect comparison for delayed refs
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
Cc: stable@vger.kernel.org
References: <fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com>
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
In-Reply-To: <fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2L8vTwdAGNvh7FNHkUHa/8AEWWFuhOVrLKQpEC6ZyBL8EWEA2/O
 0J/lYzdHWTZZWwBKV46RPCky6RhDDokDCTVkclA+a8V5oF6cV1PSkLTtuYx8q4pSwMTqd01
 BjLc7LYad8kv69aa8w7xCMnjmmMtYuhB4en48/16e+ksvubJdxj0c2NMKCqzJN/7Vyr5tth
 DIO/YqPWrETDfPHAPWtDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YENwQRLXloo=;aNnzR3llgWRltXcrEtAPf9kw5oc
 wf0QKCwCufNahCKbzS8lGa89IQFSGL/ZK5gpyXjsQrIOy/mrWo/eXqf41jiMGHVEfgwi/wSYE
 xL0eN1MjcX5ySfN+DDRoKRHF7xSWQszE/eCG8q2QrTcSKdWvFNlUcLJpmpf8TLO5YJdquQh3/
 DfZFX7s2GiM+4Tsdk6ZTl9eA2AWN+nwuWBgslEH03pqiCQuDhoUUMmEJ/GCBlPhdTl0PGKxzf
 HJv3FNsHQdJpHZdbr7/DR4PoCDNuh92ttFyMn/hRnHUmiJ/LwIJYqj4Lq7s1ngA9g1VimjX4B
 baZyx+VtIEQS922pXq+UCsHIewbCZ2nFr2Hdccg3ZfdhHIVzCFCMBeVcSvSQCqKmvWDZvxcJo
 jXFC+DJ++9uxYimDGOhc+YBikMp8gd9LB5l3N/PcNVue80yp9EgSNi5H2VZmJN1PDl4PPv2DW
 OjyYB+Ty2YKUqlI7WSXLnYz9w3HlXa/f5fbL9WwxuE9gLsDiQ3Yzoahg25Q6pNpKbR1QU7YJu
 TfxdI4xPtSC/OV8tIXah5ubmyBhkUbnBd384MMo0kSQzx8Wv6Bv7MArcJpbFQOWmx8x3h21+u
 elv3DqVkDZdwVtqIJfO5dhN8C+mZSw4G+Yw1oQY0qUUK7zmIAmhajmKK3YDh4gF3xeAuVmsBw
 avhU3wDBM7lD7vVzDheqCWDVv0tdcAJ/dN0/dDqOMYGTdMo0VBE5n+cL8k63IJi8yoWPkvUGV
 U8mCWKNCz7jV7/dnUvq5RuDT6ekAZb1Mc7HcMJGBFfXTaqrjUt8/dGObTD9JNoX7vhPaD9m5K
 5WddG5kQnOCXRmQkFQZgZViWMPvmmV0TfR6O6G1Ur5gkX8q8ltF+Bltrdr2Mh3r/7hFZqGGNk
 t07uY/BuNXk2UmeW3DBJccqgwcqxlFXLbkET9n2gmas6l1ED8TgF5zQUS



=E5=9C=A8 2024/11/14 02:35, Josef Bacik =E5=86=99=E9=81=93:
> When I reworked delayed ref comparison in cf4f04325b2b ("btrfs: move
> ->parent and ->ref_root into btrfs_delayed_ref_node"), I made a mistake
> and returned -1 for the case where ref1->ref_root was > than
> ref2->ref_root.  This is a subtle bug that can result in improper
> delayed ref running order, which can result in transaction aborts.
>
> cc: stable@vger.kernel.org
> Fixes: cf4f04325b2b ("btrfs: move ->parent and ->ref_root into btrfs_del=
ayed_ref_node")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-ref.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 4d2ad5b66928..0d878dbbabba 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -299,7 +299,7 @@ static int comp_refs(struct btrfs_delayed_ref_node *=
ref1,
>   		if (ref1->ref_root < ref2->ref_root)
>   			return -1;
>   		if (ref1->ref_root > ref2->ref_root)
> -			return -1;
> +			return 1;
>   		if (ref1->type =3D=3D BTRFS_EXTENT_DATA_REF_KEY)
>   			ret =3D comp_data_refs(ref1, ref2);
>   	}


