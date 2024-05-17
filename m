Return-Path: <linux-btrfs+bounces-5081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60918C8E56
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2024 00:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C091C20A03
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 22:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9902E62C;
	Fri, 17 May 2024 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kCP65HaE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731CEEDE
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715986285; cv=none; b=IEB1WDVPY67o+X06id9hYAdGOLMZi7autxIIiXV41FpFSVXRM3b96GcUd9QL7kbeiqoqNSBCTixlnrIavxhHYeFjBW3WLw5sd3CN9mS/H15U/DH/7pto+thcghXnQyVxBS8k9bbEKp5Nqop2chaLYio4pdN90t5WtqJJxw58eZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715986285; c=relaxed/simple;
	bh=OTgOxqVG4GlfdqakQRVK7OguanbMps7mfZFiSoL9JME=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WxcKP0K/3AAmDJLn22HnzXQjAyCKnDwvOhf+ZAyUOB3g/ycMVP5wc/XDVWP9q47+wQkHCpElt97KM/+BKIv1CaQa/yyOIWTw6y8QlHdI3zhhwcewHjCvpyneU6fBbkxcQk5xuDd9pKmto7ItDPVyBtyqbMDBzRbwnEKIedAWsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kCP65HaE; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715986276; x=1716591076; i=quwenruo.btrfs@gmx.com;
	bh=AakG+THsHcZqNkD5siBAjrQd/1m/zoJyELm3NS6O/jg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kCP65HaE6avSgfBRXpZtPkBsS1m1b2Qvd/2QK1zy97Cxh8NOAABLFi5UXdVHKR6m
	 C9U163MB3qf/YJx+Y0wMEMSyFG5RITjffwY/ZErLMyZWv4gajxqVjW1GkXz4l5/nL
	 Fg5jJvhtEAaTgrIlBOdWjA0FCwvqje1S7vqjaFvU2PMoTIqRxvvKjlJV8EB/2omx5
	 iIAiztk39kvucD/qrnnlsnXlRAyo432ETEp8GvYxJiu3+OqhSDKXrzXpayo7iCyLm
	 i5eEz7H+/wyhSmm6BcqdkOFzBGQOFb0LtCygTpcgYfjbsA8IHNnjgMwfja+WY72Uh
	 oN3phwbs+VJxlDiR9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVDM-1rscs00fJA-00J6gr; Sat, 18
 May 2024 00:51:16 +0200
Message-ID: <b65a5015-861a-46bb-a93c-61288fffdbd1@gmx.com>
Date: Sat, 18 May 2024 08:21:12 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: always set an inode's delayed_inode with
 WRITE_ONCE()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715951291.git.fdmanana@suse.com>
 <3ebdf6919047ce1eb6ad4f4058e4084047fe1d6d.1715951291.git.fdmanana@suse.com>
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
In-Reply-To: <3ebdf6919047ce1eb6ad4f4058e4084047fe1d6d.1715951291.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jpoF69fe8aOowfJfXmqBrlhMmiWr0baSQ2DQQOWx18RX3/N6oyN
 jtOTLUdxxZKbY7ejyyrBZGYHiAaOUxDLkjaSeZ2ddDmhOW6g/C1bDrUYx9/qRqsSe2SFD9F
 FU4SsM99+3aZWsUvvXiLSkafIlTkJKUKOFrH0+jzgj+NwxgFrxL8rMzwL2HCvfpyAQCBkoh
 d+9jXi/lxMgRbH12mwmdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9dYG6XPR8ng=;CcbGeGmkMosdUB+pcEyBX42MWTO
 B3PYMZ6613KWj+PI8eMXSA7KFGGrW0Ncz8zO2pG5yM/aB2TXTMCBlLPGFmTXjZ4spVyyFhYvr
 9P3SIA1AdH8/0ZK7f81Zjin7yeOY+jdB3do73wYCe/1qLcCsxlSjNpnjOKFuzm0wiDkY8y9l9
 2/1SHH3DFFCrVZLYxtS36lK71u+qDszJ108gkBai/kwgx2tLZlrdU6vOtNKcuGx5M3rTBynrs
 iCGVm9dUOzhcKM56MRqrR7TZ1s4y4ZweZT3lQwBmTcUyXw5B3iZde76hiNYh2QNfOXlMFelZM
 PW8YRSoPoXldf5INMWZToV9Wlswsyxy7TwB95/BVPe2DCHj+7ERYDktqd7vvupZ5hNOZZqTRH
 kuFM1eFA4shvriL+b1N/5gxF6uXdWzJdda5SdGWiepmAuW+7XBSP9xeRSPXI5+gBRTGVbNmQW
 7JZfaLD1w9NprFUMy9RUJWmkTxbrH1RSkygSrmzPudB+NWMkDGOWhR1PUg06eFqq0ICPNPAi0
 N48OsyVNEZBEDAMoVseN+BiwtzXsizvKrIYMYHGSzs+gbprsDz5XlC1lpNWO0COehnPJbFrXf
 luTj6F6gQtcF/0i/KDafu4faMruThoVQZgdrOmhNW/LdeKF6YiAlwvEXdyIXlgaTnPrXRxAoR
 GQ8n4pzMQBhCg2CyHQ8HlQxyAFQvtrXMOJuvh0KIdfA0F4nZFkPj1Jih3YCwgJg5lERqwtbyJ
 fRR1tu5ctjDClFJyHDjvp4QIdHxOXhtP+841iqz1phXqev4QgUPSjIqBCFEFdmXJc8lqyI9Zt
 uR8we5Xx65uaWJPpz7Mc6cUtAwl3vT2dEl4uBwjbXt2+8=



=E5=9C=A8 2024/5/17 22:43, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Currently we have a couple places using READ_ONCE() to access an inode's
> delayed_inode without taking the lock that protects the xarray for delay=
ed
> inodes, while all the other places access it while holding the lock.
>
> However we never update the delayed_inode pointer of an inode with
> WRITE_ONCE(), making the use of READ_ONCE() pointless since it should
> always be paired with a WRITE_ONCE() in order to protect against issues
> such as write tearing for example.
>
> So change all the places that update struct btrfs_inode::delayed_inode t=
o
> use WRITE_ONCE() instead of simple assignments.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-inode.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 483c141dc488..6df7e44d9d31 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -106,7 +106,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_=
node(
>   		 */
>   		if (refcount_inc_not_zero(&node->refs)) {
>   			refcount_inc(&node->refs);
> -			btrfs_inode->delayed_node =3D node;
> +			WRITE_ONCE(btrfs_inode->delayed_node, node);
>   		} else {
>   			node =3D NULL;
>   		}
> @@ -161,7 +161,7 @@ static struct btrfs_delayed_node *btrfs_get_or_creat=
e_delayed_node(
>   	ASSERT(xa_err(ptr) !=3D -EINVAL);
>   	ASSERT(xa_err(ptr) !=3D -ENOMEM);
>   	ASSERT(ptr =3D=3D NULL);
> -	btrfs_inode->delayed_node =3D node;
> +	WRITE_ONCE(btrfs_inode->delayed_node, node);
>   	xa_unlock(&root->delayed_nodes);
>
>   	return node;
> @@ -1312,7 +1312,7 @@ void btrfs_remove_delayed_node(struct btrfs_inode =
*inode)
>   	if (!delayed_node)
>   		return;
>
> -	inode->delayed_node =3D NULL;
> +	WRITE_ONCE(inode->delayed_node, NULL);
>   	btrfs_release_delayed_node(delayed_node);
>   }
>

