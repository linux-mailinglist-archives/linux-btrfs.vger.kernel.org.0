Return-Path: <linux-btrfs+bounces-5082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837D98C8E57
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2024 00:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D44B283A13
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 22:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE18D2E84A;
	Fri, 17 May 2024 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dXwoUc5M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E296A94A
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715986308; cv=none; b=Rm72kiAxvXEpugtUgbADA9OXxLv6cvU3BtrFYvpSbY+qCwonHhJ3i082unuMnP1ab9N7OXRCpFXGIhGI4sLbSbbVahh7pV4nUJHV+Y+TgZI8YEgpcbKKpuGUdmiXUS6l413r+9pruQcK02eHzClhuEwNfw8CiDl9nbzF28+DL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715986308; c=relaxed/simple;
	bh=6khChXR+w/AgtrK9O/n9k96mHD/XAGz28yl/+eZXEPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aWoedsVo1IFJYKusXbEa9paLs75ouOgKRp/uN1Pz8vjsPLbIaj1BMM0SIVap6p7U+cCY5FkFFebf7QkoQaHzxuSTRVIGNJWXFnLwK8U6qnt/8WD39ukQeziDfZsZX5GYeG9duyLd+oqC4yUjfbZGHiJJVlj9I7T0332HDaOSxao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dXwoUc5M; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715986300; x=1716591100; i=quwenruo.btrfs@gmx.com;
	bh=HSnzVZoptpCvxKb9H4WIZtw9qqXqktUfE9lsu9Neros=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dXwoUc5MmijqzxurnUW17wLgGTQE1mLCcdG5Vks50BEVb+UylXgIrdzfj0RiLl4U
	 nZu3N1MxZZK74/fPZRB64REz1Wz22F23Utv3nGpXepa2XdUZ4wqC/LMF/GifBUKks
	 VAsbdJJoqeDfgnzkWxaJxz/gkbn5wCzFIV3WrtyF0bcyr1VSIDMq5mZ5AfeBGbcYP
	 xaKYw32jiscYx7abzC3h9x/QOAh6IRu4Unf+sIsxx6pw3hqSnavKYVWw6a0XATy3I
	 lubDI61B76YfMhKd51o1TDQL+U0ab9vIZDZe22sfiSDXvYTFSzcs8HriRSt4qoDo1
	 CPJKlwMEwFhAQDQgWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDnC-1sHTHB2Peg-00Cemw; Sat, 18
 May 2024 00:51:40 +0200
Message-ID: <bdb528e7-8c1d-43bc-8236-a47d9c612983@gmx.com>
Date: Sat, 18 May 2024 08:21:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: use READ_ONCE() when accessing delayed_node at
 btrfs_dirty_node()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715951291.git.fdmanana@suse.com>
 <68f8da7780333faba472e44689f977abd7222ffc.1715951291.git.fdmanana@suse.com>
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
In-Reply-To: <68f8da7780333faba472e44689f977abd7222ffc.1715951291.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w9teGsgpzSp6ZkFIhECN+EJNBTvhEjDiUdI21UHSygaBHALtfCu
 ld93Ef8Uphbw7hStmg0jnp534Cdiy1T5mIgfEDSFEKPd/KKUd8BFjwL90FsbEa7L9NM+g/Z
 y3Nzk92x7UvS0qbIiEdRYmoziwSwPtapb8Ji2DtDOXoGqjR+AMADgyBQjkIG9QrenFEdDU7
 oH6jdy30vOnmH0LeiIybA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HjWcJCTpNOI=;g38DGURTQHx0peILdddzsVbrCSx
 m7cUebWPZfaXBqMcYIAqv1AznzEMrOtS00QoEbJs05jGpB3kEGlGijVAoA0GKER6SgneGAa8b
 6bYuBGbWnMlYpYtH00Mbi0zLs4ZPlrbThtI7HMuBgdg80Khr0X9+K7ib948y5kfooekfg5Tev
 ohiNtGNjTYXRZ1jc4eqLHGG6s5QTGdA4CjvHLkDsynP2Fk8X/WK6Ph5h92guIzIq4NHs0B3tG
 43R1O2HiTBFmN8njPc+ULCRGO9wS5Tv4qfbclhTLkkqsHLS/S8+KfaoD5OwWJhTawK/TbQqid
 UCg+hvqtKJEQzmqSuwERN+238tzMJ+QH9e2JHqK67wAmn0VnQAw6h3mGIOzgvx95t7DJE55t3
 eerrdWznSuxMxNmhuMMav/vSOfmgXL9NuIOLmf/ja+fyzVqegMylVIFm/vBcGOGps7U1RzWQe
 wJG9xLoQbUpWvdPFzkEv6OasLCf9aeHWXMgVX+wcFkMA7/DJxeDQR9L5dmS6gnJqD3AbzindJ
 Zh8gLEYkZj1igq9vGHyHupajfsJBzSmrRe31vfDDTrka6Fj9lTF4gtmzT6tSHISgE987NYVj8
 5GzdzMiHjA5GV4WUP58awo6HKqaiktFTlEZKV3x9KEi/YyMSZiYSYqzzPzl9Tt7oNCrjeUBxE
 CZ38ZyBMwpxtVv8WZkMiL78G7E/QyjRmOgCJn17JodkGONfRfTmbGG+XkEweaJfZyGDlRBMEC
 smsuzYu2QW/EdZjj/BpldwLd7SY1+OynAHBe6KRHSynmV1yHlUQN5KHeuXUovs884wy/Q62mX
 srD/sktNZFIuSxqm029xlCdodzhDh+tUsAXAd888pqJpY=



=E5=9C=A8 2024/5/17 22:43, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> An inode's delayed_node is set while holding the root->delayed_nodes
> xarray's lock, so accessing it without holding the lock at
> btrfs_dirty_node() is racy and will likely trigger warnings from tools
> like KCSAN.
>
> Since we update the inode's delayed_node with WRITE_ONCE(), we can use
> READ_ONCE() without taking the lock, as we do in several other places
> at delayed-inode.c. So change btrfs_dirty_node() to use READ_ONCE().
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 000809e16aba..11cad22d7b4c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6100,7 +6100,7 @@ static int btrfs_dirty_inode(struct btrfs_inode *i=
node)
>   		ret =3D btrfs_update_inode(trans, inode);
>   	}
>   	btrfs_end_transaction(trans);
> -	if (inode->delayed_node)
> +	if (READ_ONCE(inode->delayed_node))
>   		btrfs_balance_delayed_items(fs_info);
>
>   	return ret;

