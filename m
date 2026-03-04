Return-Path: <linux-btrfs+bounces-22207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDwxIlmsp2lejAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22207-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 04:51:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 134B81FA85E
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 04:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4C4030B12D4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 03:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D6F37DE9C;
	Wed,  4 Mar 2026 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Jy+kQVWN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AF9C2FF
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772596304; cv=none; b=I7hJyLCL5Z2bppsesUHQgRMwBgmPvw4RIywv5eUTuwobbA1botKGOuBQGquCmv+7xt7JsbQlL1KCO2Jf/3c2GbIiBPKU9n6f495RI7WkMHW7u/KS8eVvYAJ/jKseiWhKGo+eA3BIS/dZOa3BlGp+TwXEdUeW7l7WB5vxcDGm5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772596304; c=relaxed/simple;
	bh=ZrAzj3gZL+wsqQ4X8KXqRjC+Ggxp4B9DOX3bHVSfdRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKx+1kdZGQs3UGfnVzfO2azrVEuBc0V1g9naO0dAyoRlio33EXFDXrx2VPca6gezH34xFU2sqDIcTtQPunsvALlu/ceApkZNHVTCIaX+bjViHa0+bBI8jyM92+K7Mtr6xDjvCeqW7MCWT6qTaIwDSmGkH/kGAJHQ1PDiuzyAViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Jy+kQVWN; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772596300; x=1773201100; i=quwenruo.btrfs@gmx.com;
	bh=ZrAzj3gZL+wsqQ4X8KXqRjC+Ggxp4B9DOX3bHVSfdRM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Jy+kQVWNGJfw+ViK7nH+MXdsOaxNb3Q5awQkuVQflirbd/8Vna9f95YsBHxfllDm
	 mEbNTqslqxd/YwbIudTRQOQCNDxWecXNY2KKmglzS1E+5LHWyHIXTXhf/7gitp19k
	 lzgM2UtSwbTT1bdVq+7XkOWmU6lmsotoagN0b7U7ocstT35cSnF6SBMKM0kX/tjq9
	 VYmN1snDqZeMGrAzlxFbZ3E7qSVAL0ybMW+WzW+d5+BUrrpLrXaotTiRFK72ACPMj
	 SnGp9WwBvzMh7WbiMWuxeNMEO2D/53FLmwp7qG7AXHcnw9ZcfZUXPg1R9VxLz1hR1
	 EuICcOibWjhmx/8zrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mel3n-1vMv4j0OwP-00lDJA; Wed, 04
 Mar 2026 04:51:40 +0100
Message-ID: <1540ebee-ba17-4901-90e8-67f66816fec6@gmx.com>
Date: Wed, 4 Mar 2026 14:21:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] btrfs: drop 2K block size support
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1772162871.git.wqu@suse.com>
 <228a7e9b75212e33b93cd009b08d232b240e9e51.1772162871.git.wqu@suse.com>
 <20260304034808.GG8455@twin.jikos.cz>
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
In-Reply-To: <20260304034808.GG8455@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g4q387Y84MIFjHTKqMTrbx1HV7Yn6o7E+FzjNuiHA8dvPcvFeEU
 Cve+sL1/pzG6Wpo3anoiV6hQNAOM1RLcUPRjT2/Y9GwviyvRz5y3UsDt5nAOCOSrNIhPAF7
 GYF62OETmobVf0NBq8U6BRxPML68WN61Szek1gu6iRkk8rUrP+LIa6wgZG8zO1vH2b0estS
 +M0ad8wsHH3plvvSDCiIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ww44abVxcTs=;1GyCcezfLqEkb57nmg0Y67T7TqN
 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
X-Rspamd-Queue-Id: 134B81FA85E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22207-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,gmx.com:dkim,gmx.com:mid]
X-Rspamd-Action: no action



=E5=9C=A8 2026/3/4 14:18, David Sterba =E5=86=99=E9=81=93:
> On Fri, Feb 27, 2026 at 02:03:43PM +1030, Qu Wenruo wrote:
>> Commit 306a75e647fe ("btrfs: allow debug builds to accept 2K block
>> size") added a new block size, 2K as the minimal block size if the
>> kernel is built with CONFIG_BTRFS_DEBUG.
>>
>> This is to allow testing subpage routines on x86_64 (page size is fixed
>> at 4K).
>>
>> But it turns out that the support is not that widely adopted, and there
>> are extra limits inside btrfs-progs, e.g. 2K node size is not supported=
.
>>
>> Finally with the larger data folio support already in experimental
>> builds for a while, it's very easy to trigger a large folio and testing
>> subpage routines by just doing a 64K block sized buffered write.
>>
>> Let's just remove the seldom utilized 2K block size completely.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Can we keep it? It's under debug and not interfering with anything but
> it can trigger different set of bugs than with the large folios.
>=20

Although we can, I'd say the subpage bugs will be no different between=20
using large folios and real subpage cases.

I just do not want a special case hanging there without many users.

Thanks,
Qu

