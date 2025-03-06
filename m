Return-Path: <linux-btrfs+bounces-12067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 112B8A55923
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 22:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7162D18986FE
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 21:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10D5276D2A;
	Thu,  6 Mar 2025 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mfff/iLo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194226FD9A
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298025; cv=none; b=pIMpK8y+mDv4+/KZl5AHV/dW15wbxxc0qHYyVvHQ3gTOj5Fkip1OUVRv49ttUvG+tm2fWhwvjDVMbGLtDvmKJDwNSlwpRaaHi6ngtA9BO8fNCHqx2gDc77dgbKGDcu1FIBTzLwxDYF72UZ8apIRXFZfLHfvfpbi3ORnk5Df9XLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298025; c=relaxed/simple;
	bh=+MFh4J8+cVxs/2El6cyAtZN77Snx0oqXhE2L/nSnQBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l+MhR9d4S0xS3taNwaOlaEJFHRERavJTmAlhpu9eYDJyhznBmMkXD2B5sO/RO0/jjW+RReiDSiSVYGCo6+hHNkjOooCh1+ERML3q54kpq89HY9zQRzgFNqX3s5GG2EfWNMfJQ0iHxqSwLHMfI0gxTHSUBr5tTbhC90QNF2Ynu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mfff/iLo; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741298016; x=1741902816; i=quwenruo.btrfs@gmx.com;
	bh=o7sLP+pUV7ai8GxJ+hw4klZrQ8PpCsulu7mrYdoDHoE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mfff/iLoiZuWECbGmjyM4zmeWDhDNurU+5DAqMt8Ddk7HBkaurMqQr74mTPpBsU4
	 jShmzXvVWlH6F/aTjXsrPnNuzoy786H6rWPcNFnyQhmAPoRluoNXCQjJBG49x6Q2h
	 vmA8KwTiSyZBpismsXjicMpaoWH08qQLgs8UBqiZuxNjIYF81QFRyRxyfg5L/4euy
	 neW9nCz3KAvqOKN5k4L9eFUgI5JSi7YcscDozhEsYMmTvXY9CQnDcgwZ7d0z8Hq4T
	 mSGoaFEIovm35PCwXgoAcBPxB+f4IwKLK7lxGrfJaqb8bJwqQMKkRwNX1zsUFukoZ
	 3GQu2/xOIA7XBXCqsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFsZ3-1u297w3UOF-00247A; Thu, 06
 Mar 2025 22:53:36 +0100
Message-ID: <2c359b95-0181-42c5-a76e-3a9ed0ea31a1@gmx.com>
Date: Fri, 7 Mar 2025 08:23:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: send: a couple trivial cleanups
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1741283556.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1741283556.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0VySIYMf/G7pRu/ZmiN3RdskpeDBy5z+xeqCcbRvWaWss56mL2I
 z41cr51u/op8v2F81w8ImlcA/80D1X4JvtS0yiDCl/48pN/g6B5tzOdxS4/LsKH7Hsh+/LR
 AUFMy1wyc6Z99R/fZd0gtw+Ov8tdM/dkloQ3OzJjPWtgPwfsYRMxbc+aY5LP+9fKDh8UaKi
 Hy7a619JrC/0aKln0i2jA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PFwIoBqSXNg=;ZU8x4c4jkqe8VlMFRYMymiEzrYV
 eAjCBF9yver1dfmCCaLpGhl+c31s7zsQM0Ia8YUtNS4zk41pW0f0wJyXHhustKcTY6V4kiY+z
 GhYWgSvy+tFbW8d2D92O/B1n3iik3zEuaICgxJA373K687o4eduEZjtR2+x/mqMjnfBpfY9gG
 maNOw+utjdTr+2kv5xnN67Qu5bxKSJos+iOk+lVYbG4NYRMekLLseKTpOQKpSqUJ+SNbxNOV0
 o6924clURmSQefX9DzbNpnHYshukT0JSouZfSyQy9f+BdAR0YP2wfpYHhzFthmP8rXl1VF5JM
 4pnYR6cyVttBB2PhaPg5PYgRMbDqjLz+/3iNuIxbTRp9+q4gd7SiSw9UQMeqS43QoxQlUZuFU
 vkSWL94G9ECbNXABk+uIDeqmaDekpgWfgxJj/AeI32LvcQRvc73U/khhRznFtX9INLb292qBn
 WvPsHL/iE1T4ReEwQuLQRR3g4BJKwduv6qBHhKqXStmSoH9kNb9SfM/pARWpbu1Pi+E3ZzGat
 NIWYoObZnzhsJvvUmBr9wrJyNhS9I5VoUGa5nQf7Dx/wJmQcFV8ye5976WKJ0r7dkdmHHEQyR
 nQUwL35T+WhwMyeFSEQRuNKWgQvosxngKINSgHSlnAGceJ9UKIjm5HqwNywjoBiZ0QSCmklYM
 2TVKBZAUTMgxNVif5eadAgEeb2BCYRRF0dSH3XB411B8N0l9xgFIjqhfXGyBvE3HXF95pGQsM
 ourCNGnqUfnBKAkLuo6bZCWw15o7k4b7tBVnUbCiM1d60EHi7HhuqTDBb3rzmFekxYcx7F3hg
 QEOqcRofkjc9dpub6rpqnJBRpGqorh0ECKki69FO9NVImQ++rHRAOiZ7plDjZOsu+zaC1Tf0n
 I47Zc0B5bbgokxQuHeKEoAYKrOaaXjOTfiO6M/4DuDwJrCZObZ0oIIjM+MYCLEhsyBQkxDVbQ
 93DVdRPAkKGa116Uyghq8X6/qwfc7EkT7Wn2UADTRfZGiXrOZqaVsbbcJCgTmJEpkWFYriNOm
 aXn91U+1jpaB4BOAeUXYUyu7gCGHuntvYLVONtJ6N2dQkxg4vezGCbzPAcLVJde0Kyp3ekLr6
 0qAJiBfpl7HR1Q/0V2oUl0m8lytVpfppsxh87empYZqUL4kOOjjV0nP8HdVpHvtOE7Fi5ON1s
 j7zYlHZmWB9heyzl2I5KeJtcCYoq8utzQ2ByLShfjiQJF+oD5zTdVNDTKwCG/kpJKz0IXhhVa
 DDgqopUv248G5QsMAsYdYNa1yvREEFPvgoe+wT3iWb+s9t4rT6QvNRvDdVYTIWLbpPS/4IKKk
 Kcw+fhTMJD6gf1UV5hD3y9wJVvu8rPTojFt9L16mq1N9ZK7vDhLwESEGPZVx6KudvFIN1c1nM
 FziLV5AtsZvhngwoQzp3KqqOR3FIiutSiIkiuQDt40DmG7EoEV5QnGibTs



=E5=9C=A8 2025/3/7 04:25, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Simple cleanups, reduce code, details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
> Filipe Manana (2):
>    btrfs: send: remove unnecessary inode lookup at send_encoded_inline_e=
xtent()
>    btrfs: send: simplify return logic from send_encoded_extent()
>
>   fs/btrfs/send.c | 19 +++++--------------
>   1 file changed, 5 insertions(+), 14 deletions(-)
>


