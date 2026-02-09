Return-Path: <linux-btrfs+bounces-21569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHRiEetrimnnKAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21569-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 00:21:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8E41155FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 00:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76DE830292CC
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 23:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0378232AADA;
	Mon,  9 Feb 2026 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="s/3ryVSd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D020D3254A7
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770679267; cv=none; b=l7D3BEr77smVKmTGr8cRPDDGn6uzHArppBfzMTeW/mJHAv5aFLkrdJVSc+TWDcUYSSgg5T8dG42Lz/0Rczq/TBAb/B6Xpb32YsrA3jgo4yPpUz9CinsN3Y1Qhy/TMystbL+22VpOkhtC9Y7VqtA2kkHS2BgxzUSSTGkl7fwO7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770679267; c=relaxed/simple;
	bh=c4RBPb5jIqdquXbQcv82sNOC9avBDsV0nYschGi/oLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I3l9dLDIpk7jSx7J3TNffQsH1K377X7ra+qdmM8tjxTXZ/LEC9jSHOCODRZTIUTFhRYfBqkpowW0C7jnmUviGQ3POFpASoHsQXLdJWQWT7v0YQiXmQvsl2lFq/GENt9y5wLcZ9gX83gzT/hpwYz7Hh+oJh8XmD7sSz5zy4lto3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=s/3ryVSd; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770679264; x=1771284064; i=quwenruo.btrfs@gmx.com;
	bh=ryHA4VcXjQ7xBt6shja1Id6zxVCsgkIwCfU2H69f6HY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s/3ryVSd+bKbCnqHEG2QrS9da2x02Ir0FyoO3BhmAucUCmD8/97MbdvFsjsfxAA1
	 oDyImFepNhZrjCbBjwhGT9vR3t8FpriecqH24uyYBeRh1eCJ/2yXU3ryRMVK8wYOx
	 QWNyEa8J2DU3EkuxTx81ADuKE4fDyvg6OIqmq861ul+zkRujoR8JANICeVSwN62wM
	 IAyddGcqwXBRUVuXjbuV4UtXmaPDdayAzE1mvWspS/xlPXpeM8hqPt5vxArJHebnV
	 nirx+7wPz6Z9G8p23IZ8/X3Nu3BbSU32NE4Lw5z7XP+jKy0OU5MrSAmNjfhRgghJX
	 Gk15gL4eXf+Rh3tPPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbAci-1vEJrr0zAe-00j7ig; Tue, 10
 Feb 2026 00:21:03 +0100
Message-ID: <565e371e-814c-495d-b4ba-44ccc7d9a0db@gmx.com>
Date: Tue, 10 Feb 2026 09:51:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: cleanup messages and error handling during
 mount
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1770656691.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1770656691.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:REhG8fvClLe4AX8haD82C1q6IaqNUbz6MZFofXud8WtUN4Xargs
 Cs4rRq6Nr/hIFrv8r5ANykf5apvLN2yWGKhnfSbk6/HxeLglifYbe5qBR85zndI0vUy2+Pv
 Si56VoQDndpvNxDIPRHTeUUXouPjz28L18lshpN0RW0JMGLiX9kuAo/Rj4siU61KFTyy9yo
 mn4Ww/8iVsavEcprNvMqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Gg4UDtQTV90=;VLSJV77BfPe/DRBysgnOGgYcAYO
 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
 Ka/c/z2A=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21569-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmx.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmx.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: AF8E41155FD
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/10 03:41, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Short and trivial patches, details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> Filipe Manana (3):
>    btrfs: change warning messages to error level in open_ctree()
>    btrfs: remove redundant warning message in btrfs_check_uuid_tree()
>    btrfs: remove btrfs_handle_fs_error() after failure to recover log tr=
ees
>=20
>   fs/btrfs/disk-io.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>=20


