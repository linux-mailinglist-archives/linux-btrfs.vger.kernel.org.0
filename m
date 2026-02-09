Return-Path: <linux-btrfs+bounces-21531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI+FCbKriWmXAgUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21531-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:41:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F15F10DA9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD668301476D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D443363C5F;
	Mon,  9 Feb 2026 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Qf9pW81R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7685328635
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630045; cv=none; b=R+sqadYYoT5pFaDg+iRl5hRdZrpdJKWiPOnKq4/rXMa0mBwm18Uax+SO52sHWhlZgYwwhKG0EqlZkkeYllz1jP0HRj+fCC5rCvJ0pSOkJ+FBR3dmLvPYNMxDTWsuYFL9FLSnBOLCuGmzyZUA4OZoy9FJg7Hgk8H4p0SPLxPwNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630045; c=relaxed/simple;
	bh=rnmhB0igWckiTXvPULduN3r586DlNlG5H5tVxMKrMhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cC2Hn3di27m7Zquonx9PjKXeHKX7w7/HFPHQlQR6Qm4mD2E7afxQ5IqROuGXqTtSbEU84d0iFWk+ZwNfw1ddfyalxXifsHk0Q7ZCaLmeG8L3r+qV6WbHKnPLHIuzWB+g9dOTHXZVmTN6axSUFQrvrxGcdvO4Wfx28vqrN3iIAzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Qf9pW81R; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770630043; x=1771234843; i=quwenruo.btrfs@gmx.com;
	bh=T+erMpk+vugGesTQRG7aOx+1l7f4ssHXpJsxyoztYVg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Qf9pW81R875bvDZalDNiZPsUVWjgS1r5M2ls1jcuA/NLd+AFjj8xOTQzGsEnECZq
	 BFBQL6z81RTGQtrSahqRQkZKJDLfgvt4G75W3BOQFVYBmNHBiPB6RL/m6QnfqH4ye
	 ELgK8Q3tmJSMHJwjj+/UGl9m1mXSwavrZ48HnSB9RTQ9wJVo6K2jo+LaTJ1BDhZhz
	 tOlpaeGX6hysjqER2LBB4m88VszAXAz98Cu7IF2rrKqpOirzwoUe6XxUOpDho1H0K
	 RzOdSkULUVH1gWHjgpidlNoTfkOIQXA6cElxJOiKK0KRTEM0lck45m9XQOy/lrANw
	 jZcwX2JcLh99CiKTsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJmKh-1w4Z7o2WO9-00RAVe; Mon, 09
 Feb 2026 10:40:42 +0100
Message-ID: <0d0d5929-e40b-4486-a72a-5820b88cacce@gmx.com>
Date: Mon, 9 Feb 2026 20:10:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix invalid leaf access in btrfs_quota_enable() if
 ref key not found
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <78d48962c97102192c0daea9393b0014430024f0.1770225728.git.fdmanana@suse.com>
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
In-Reply-To: <78d48962c97102192c0daea9393b0014430024f0.1770225728.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EzxWezFCHnY9zquMW06GQku9YteUYYCquTMfwfggdRPZlTsvUBt
 XOLuVwLYy1tuSC/rEfE9EMLIjbi1+u3n0EePNTraB4WPzCusaEsBUW19wIRXZ4Dqz+TwFdX
 Z5KV4Pt16S/Bwn8nrKiWcghMpkSie8akugbz6Xho8RUqoPAUmYKbFPlJX0hI0HrMRcLWL4h
 c5Y8emE+uGkHDRnd2wG3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EjOx4HPj/So=;NzVFmKmShles9atSmwI+qW9Us2W
 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
 Wze3HgKnUcS5LEYb8B9UqhRlOXUzk
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21531-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmx.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com]
X-Rspamd-Queue-Id: 9F15F10DA9F
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/5 03:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> If btrfs_search_slot_for_read() returns 1, it means we did not find any
> key greather than or equals to the key we asked for, meaning we have
> reached the end of the tree and therefore the path is not valid. If
> this happens we need to break out of the loop and stop, instead of
> continuing and accessing an invalid path.
>=20
> Fixes: 5223cc60b40a ("btrfs: drop the path before adding qgroup items wh=
en enabling qgroups")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/qgroup.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index f53c313ab6e4..ea1806accdca 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1169,11 +1169,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_=
info,
>   			}
>   			if (ret > 0) {
>   				/*
> -				 * Shouldn't happen, but in case it does we
> -				 * don't need to do the btrfs_next_item, just
> -				 * continue.
> +				 * Shouldn't happen because the keu should still
> +				 * be there (return 0), but in case it does it
> +				 * means we have reached the end of the tree -
> +				 * there are no more leaves with items that have
> +				 * a key greater than or equals to @found_key,
> +				 * so just stop the search loop.
>   				 */
> -				continue;
> +				break;
>   			}
>   		}
>   		ret =3D btrfs_next_item(tree_root, path);


