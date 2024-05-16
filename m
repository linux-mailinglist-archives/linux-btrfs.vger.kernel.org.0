Return-Path: <linux-btrfs+bounces-5058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F10B8C7EED
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 01:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921C91C20E75
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 23:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431FA364DA;
	Thu, 16 May 2024 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ocWGlTo0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23573219F
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715901453; cv=none; b=P4j5PMaIIHgDf3W2HLS9knfb5OYtEnUWC7JmD4IFa5uuaJLVXL6ekpbWNIW5GohR0AEHg1k0rSS7RwQXgga5vnH9LJl96OG2RADB5lECI8RRM63hTxuLb3HB6Jco9tXWlgCsEmz/iV3nOngVjwv04XT7QtNZRuVfx7GN6sCUCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715901453; c=relaxed/simple;
	bh=yFQ7M2JE+uMGAVouLiNNYTeb8tWzVQbF3RITcp2IGsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TXcSQxl2xYCy/ylI8xgK56xjZ+Waz5Oj8/cR9hL7NRkAoOFpsQeLO7KW2Q4O00T/wB9QNvB3e5IcL3lkwogEh1vW+x2N8YFOcSZJS5R/+ulCg4seLrmMzkJKm+m1IvTFz4z+3u/RQbgYJlErK7ReGx6Bc/99Z4u7pkFZ+JwV3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ocWGlTo0; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715901444; x=1716506244; i=quwenruo.btrfs@gmx.com;
	bh=OmPeRT88fqm6DOE9m/vQqpQNl3jOhWqP75JbR6LIbc0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ocWGlTo0xiQsa0g3kCmt/gFe6XyS1SnuNn0AejEzSY046FnspV/0A/fQUsm9vrW3
	 NxcjIkXdQ6Kr6tNNfAYmvvfV4ro6eRIrghsyr8E3RL7qTZIB1xa1YSeYavE/EiFDF
	 Z3YFgoZw+ZgiAd/9Kv5GlmnvjcfiFpj4gl1i63EJBMZIuoCCNd+sdpF+kMxJr/6xa
	 krZk/NH6UfGt/ZHgRrYK0uGGN5i9+8hJEGYp9TKL5L2/yCNbv7uWOPpxPhhGUQ816
	 09O0evj+myvqcAe3Ke9sOu9ePar/OUG28upc8fKsPzABcQ78JBwh+c35YpaF5iTCe
	 1KLGlGtauS3N4IjuaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3bSj-1sXq7c3O2V-010cye; Fri, 17
 May 2024 01:17:24 +0200
Message-ID: <dd41526a-c594-4a1f-b535-d7869882fe4d@gmx.com>
Date: Fri, 17 May 2024 08:47:20 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: always set an inode's delayed_inode with
 WRITE_ONCE()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <a4dfaf8ca94754560f4d9196b04ba763256124ce.1715873248.git.fdmanana@suse.com>
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
In-Reply-To: <a4dfaf8ca94754560f4d9196b04ba763256124ce.1715873248.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TPVIxzUj8PGQAVFysajgEH5wc3e079oTGkiDJ8ZqLeQqBKao+gm
 BRjI68ncZtYhNDEzW8jyn6wU5sX1XOckZnYEMVnrmTFTSWEqhsRPBttLu/UM4YmyTxFPt2D
 Git45PDTWasctieZxTZwDrZCzoY+6uSuiNxWjQXQNS8sjUYPM3gULO4UJ3eL8sDx0l9vo55
 ovx7+JkNT1Z0H9eT3A2ZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P0DwFGQKNNo=;a8XszxuMNocA/r3NnAQ87a68X5j
 17mYnCRoBUTQCW9qKb5wtmZrRPG0R0SeEoVYAx2X2LFDzJaToAVFwt+XYy8bxe5MZKPDpBaWH
 2dlCtamlmi/9Of32N5a8JEPBTuoCMjWbKlzxThbJkreGPHol+XQPf4IOioyGK8up0SLnr+WRR
 VZcsSppBhgPv086mc5ocMrHowuywDAFO8yYn+ADVmfuVgJd8NjVGEtAJaSyEjoMKPgA6CnylT
 2YUq/cbnt3biEfQdHp8t0kqBvOtP6rvTe2bGgy0wJm8MD7y3HoSdcJIs/QFL5nShN6LDddYji
 zL/CDxYRquJBJru6kMKkG5tDiOMA8/HwKUQZ8fIJ2QLZKXNu5MFVBUaPQAB1EklSyIFLsyDWl
 As6YPpi2wF3FQo/VmbavH3bJGZugL4fP5kFZ/U6n4Bgw5B3IqEKyDWRABUL9eLgabWNO+gkJp
 2BLUs8oqO3HqEbd4vNSjmyGVD9tmn4a7CVZyKCopwB7V4oDQ9JZuhd8mQ42z7zC91JQNyoh7J
 mMAva3ZEQfH8dIUXOAJ2wyLs2bQTJVatv8mViALrkfdhcDcC19vsmyPjuFWof1mJ68WiWuc+9
 BTVbTg/3cVunEkr7rHYGtaYEu+ucfx3VpfBiuSVB/yMihRZ3DoK/ecmu52ofOCW2pCytSISoQ
 NNpw0bH9NIKWxzmyVuMAoBeS1c7DuBfCEYY3czqRcPqUOPotMU+elNhIVgfijM8WjD30VU1w1
 RVFsqTCnn+eiBPbMoZWK16xTgHb1qfuoD21WOfnYusUtryYdkIpH9q5arMBNT2ynonk5p5gPO
 wOcNtXB/utofgctqSoQ4gW8v1WcfmBUlaU4cHpZ82NxT0=



=E5=9C=A8 2024/5/17 00:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
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

A quick search shows that we still have one call site not using READ_ONCE(=
):

Inside btrfs_dirty_inode() of inode.c we have

	btrfs_end_transaction(trans);
	if (inode->delayed_inode)
		btrfs_balance_delayed_items(fs_info);

I guess we should also use READ_ONCE() for it?

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

