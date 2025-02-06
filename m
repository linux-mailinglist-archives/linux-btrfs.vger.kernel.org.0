Return-Path: <linux-btrfs+bounces-11329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23792A2B3F7
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 22:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2E4168CDE
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9E41DE2D7;
	Thu,  6 Feb 2025 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Uw3LWHYl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EDD194094;
	Thu,  6 Feb 2025 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876363; cv=none; b=TENLxSZg9zN/dLE37DVBjwPeX6t/1Y2IMItuK0xmYP/YVAUSvKnlzyumgyw8JJ88nUYdSOYrudqEtflCOA9VSF0B4l5T4fmR7o3ViPfulbzTu74SC+97gDKbAv015sJZ7nMFGsobm7ErJsCaAP9CjQ3JPG6SROzgTJ9uRqBLZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876363; c=relaxed/simple;
	bh=WdP8nVpvbt1HNkewmz1oeeXsJe3/p4G8wzJ+5Ly9pVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSDMdfZ3CtP+MKuyL6jTO9O/vAUkHHOUGU2Pplb/91FsHdAy9R3JdPYbhjNYXiNweV13PJeNuI+z6Z9I/lOv2CNjngJlceB4+dklDd93pYl1Rt2uuiC81uS8jHWnmJFbc5JpSqlWfurcWVICineCva2a29DcuBRyP4YJXtsyH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Uw3LWHYl; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738876353; x=1739481153; i=quwenruo.btrfs@gmx.com;
	bh=cz0uJpJErd7icSNsdJt716upD4yz+fi2Ia5Orxq/Ht8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Uw3LWHYlxPUPNfdELivQnjpzxausHtR2KWJA2lzfM8yqK7Jf7tgikbJHyZX61Flm
	 wUiR3lKB+LNhVbUNIJp9Kd3ztVbNEDIuO0l+ovLwwAomWqnvauZKeAGKSIJruvvpF
	 Jwfw2s4/JkCams+ag7MByP9KbrgwK+CeM4fU8DlE0sHEbyJX4aE927Rsz5ff/TYrP
	 HAJ4Kg1NV/tsHkfH4l2Yb7FxHlm8Erg/I00GiucNZb+k0OFmQrfFBNEGQ7wzpwIMP
	 ZEE9H+OwiDX0FW3HmRgaPB7DPknOB4aM2Ja9aRAyrqPsqBB/cpE4QTw5N1tHySNa6
	 t1hUbuzms9TwXFLLVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbox-1u4iRW0p2J-00YfSR; Thu, 06
 Feb 2025 22:12:33 +0100
Message-ID: <8ea6c977-7cb2-4d64-8efd-c3587e096c25@gmx.com>
Date: Fri, 7 Feb 2025 07:42:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: suggest fs specific fix only if the tested
 filesystem matches
To: Christoph Hellwig <hch@infradead.org>, fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>
References: <8c64ba21953b44b682c72b448bebe273dba64013.1738847088.git.fdmanana@suse.com>
 <Z6TC_yP7pTlzDOH4@infradead.org>
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
In-Reply-To: <Z6TC_yP7pTlzDOH4@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UE9EQlPzkfu2sWwz0fWelhmKaDj3QvnJWsId3JcDk7zG29ein2h
 z2bQJAa6eHxsLp6TzQzNFLumypgEMQ/vNe7GMNAUu0PPW9XtXh2CscfQkcCEdCm0JKtmT1k
 h1qVHJutJhCCJDvFt56PZipT8qu9LXdNUMvxXdfaOkjk5H9rW82OuX6HaNlK0C9CYES7gGN
 SyuksyMtx67o0qrncmEtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ytsoDkE+77Y=;a0hHGwC4lpUIaXgZOV3c4/h74cN
 EI/bKjaGbx42HQ9xTwdlBtcmuIfl+xjbfIL6yWDO2eTEKdd6ohKPxEeRSQGsclLLvPxcFOyDH
 4lMw4YlgJzjy8kualisI4FG+gwP0WoaAFQBdpRfDwjNPWXsxDjSzfGOXzTmM/hlOZntvgiTf5
 2FKkT++qxHi7qKtr3NGhkfKY1SfGXs3Isj6FxHvoRevCCpCEapdD3VaBKgHLwY2wAgYwxtfaR
 IiCHXC8wltjNHtEip5cmXc0niLsDxrgDg8aAjVorBiJ3Qh0pMr2HJeBzwfsa1CipP4/kTmR1/
 MPJI3G+j3/2vWFWZecuO95+5v7ZVZPDnt8I3ggpzkM0oslnr1xta640KH1tqHE3jd/BZovatm
 r5Ti7bb+SCYWwJe+MLYMd2UIfnqzd4D7X1UujjC6p+9Gt+D3ss6YCdmsss7to1zHQwrlQ1fqF
 VxJBPwBD+1ZpmGvX+3Hx2IUB/ZBBZuxCWmjbiaTIImNWGdH3A+dUjCob0DbB+VW6wVUCc6u6U
 F5bvYKoEpOkc2gv8+FHD3HR9mhoS4m+hQhGovJHlIfLiCfiP2/g+ciBZj9O676p3BPDWXZ9St
 CXuStLVTVKydkA2gmXpHYbbjbJi6BPd5+w7YmrZR36kW0mZDnKHf6Nd7NcxN8iyWd9d611kyP
 TY8h3PK0ZXXwbt9Z72sNrQCTI2TGXh/Q7Ork0KgnwcuNhbnsnexdsnJ72gDDeuFKbN73IJhkj
 5fe2uDC/ICc9/Lzzh6oTLaTG8n51I0SuDpWKzlNv0+4OQ8IcoVz9DbLts4SJIAKu7+c7bABs0
 pJoG4tMyOl7T1ye6n7k1ixZB/uL76jy8Hdrgrns9rIO5qdyl61eeIExaY+9GU/bdVt+ze1c0P
 vJN/Qdfa9hjPIN5rM4pEBHf0OKgqRCykiC8a8n7oOog8/LygHPZxJhVXxqBPgTCdd6Cbhy7q5
 92zu2VsyQUR1inp95uY6993WBowEQUpCwkW0WdbVN4Di/w6uRBYS0fq9xZSEjP02MJ5pQLazy
 5dw9fqsQ5cWubrHZVSlI829uzTOApYQ7hJt7qjrkTeC2159K52Bp3DDiN6QXfxHC4RSOXO561
 vLevgRaleW7LO80GjT0YsChAmM72Y8yKNRsYRwzAcyuEoZQYANjcOdpNpGQiqZeMO6neIVVey
 M3zh2G8TmKVu2vEH4bzbeS/T3wAeeaVsOpj79N7t87BDyiV+IITH0ez0WfeJcIOts6VPwZBZ4
 lUvSCZ0uxTCdcb2CBPYEjozT9s23CfkHAPxtBuTAdPzQWtEz2qLKGakgCZkMwYFWodmXrUof4
 8XAtEBAi0qlC1kU2RlOwVmDwuhm75N4OFJfpVRyIfmaJ/Llz1aoaTPvznLlgJXCyhuyYjgwqS
 Em40UPhWf2kS4DGmDo0xXXOj6WBoZ3Vzam1zMSNHEI9eYxtouOXPg9PWse



=E5=9C=A8 2025/2/7 00:41, Christoph Hellwig =E5=86=99=E9=81=93:
> On Thu, Feb 06, 2025 at 01:05:06PM +0000, fdmanana@kernel.org wrote:
>> +if [ "$FSTYP" =3D "xfs" ]; then
>> +	_fixed_by_kernel_commit 68415b349f3f \
>> +		"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
>> +	_fixed_by_kernel_commit ca6448aed4f1 \
>> +		"xfs: Fix missing interval for missing_owner in xfs fsmap"
>> +fi
>
> How about you add a new helper instead of the boilerplate, something
> like
>
> _fixed_by_fs_kernel_commit xfs 68415b349f3f \
> 	"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
>
> ?
>
But what if the fix is generic? E.g. in mm/VFS layer?

Should we choose some placeholder name like "generic" as a fs type instead=
?

Thanks,
Qu

