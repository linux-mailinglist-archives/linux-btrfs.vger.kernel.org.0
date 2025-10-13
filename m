Return-Path: <linux-btrfs+bounces-17737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B977EBD6490
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 22:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BD1C4F35F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 20:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B69730AD08;
	Mon, 13 Oct 2025 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Tx1p3DV5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD22EAB66
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388734; cv=none; b=b7/ca49hZBGuZUD5kY7XkVXIzMbp3CKN8usD8U/Gpmuo4xUfjK/3Aaxrce9SoTLB/iKppUt6rib4HLfyc+uHKPUUZcZPiy+1WHFfHHC/+zCVWTYSVXuMpCS8urHz69s2ROYyUidKRhHFBoLKd73LVknLI5gxvmKESJtA2euH1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388734; c=relaxed/simple;
	bh=n41XLOzbp+sZ+0Bjc+DsCu7KNoZzvcnLJriIK8H0cxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mk4h88CsQpHjkzRf+PcqhsNrWBkoF+8Nk7oNeemU39T1MDPTgGDVRrka9mX9hHmUEQFWcPGRCgpav1HSB3TvlN8Sbhd4TGCGhTZm848dV+m7F1WU6nWpqlAps5k2hhz2J7aNX7qQ3JQ7pySi1a/6u2iXYWPQgG/h2juhkvJMi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Tx1p3DV5; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760388729; x=1760993529; i=quwenruo.btrfs@gmx.com;
	bh=lBEPKe8NsLlHLyVbsrSA91WHYHgRTW2/IEut5YburGE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Tx1p3DV5+xej+bGPqtitB1ouwtXBqr5bD00D/SAuOEPCGSG9B5S89lRtdGmCgilz
	 XM3AQ0uZv7zWkWJzGg1/TGvJuhRr93hcD6Q5os/v72DBL+bSx4EtVOxKjaiBDiC8t
	 ivPxndZHj7ibutj/wM7pyh534d6gEL0QdmPaKVOgqZV9O38jcuHWNlc33W/tU80+g
	 vufClnXxlbktj2yMhe8KeSJEQWGKRPe51BNqUhp9cI5PTYKSY+3kNJTTwrj8QIR/I
	 yHrj0RKWTbmSG2nEjeqtqX/F8RkifkenPstajez0sPlU8ici1ejwYnmZrCXYgxusT
	 b5U9QYgQTQUQbyD44w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dwj-1uBt6r1oTl-00tf7q; Mon, 13
 Oct 2025 22:52:09 +0200
Message-ID: <fe49288d-8394-4991-ada5-f1746dde8356@gmx.com>
Date: Tue, 14 Oct 2025 07:22:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] btrfs: split assertion into two in
 extent_writepage_io()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1760356778.git.fdmanana@suse.com>
 <342129175c52b8f7b68fa96d157eb116c9a01873.1760356778.git.fdmanana@suse.com>
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
In-Reply-To: <342129175c52b8f7b68fa96d157eb116c9a01873.1760356778.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jcIeEJQza1QbWorndEwU7i0hl2iNobMmhMlxN3mKNiFYuh01wbd
 OU/ZPLM4ICHKAyJ6UE4Z/mP5MjGoXEbpQ4wuQQS+bCvGntHKGPTj36UEkEJPzqkG7I3zLed
 iQ2bhUk+N7mFA1CHdwwmgJ5IFTjdVPxUiSZcvwluCIw0nlVxs6sjJ8Er70TstBI0dcvNFRX
 JGS5LOQBPZ6DvfuOjWHlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F8YsB7ITqKA=;EKh0aErH51k6kpIQ5FWp66Kk2B+
 ZztJ1HS4itY+ZaEmM0+bgFMB1vdEdAsHJnHAdYsoaP+UWTCMANnO3GI8mihprNdvTXsfEAlHU
 Qh36GOMt52xipFgXWmSQkpqCJ//xR9f7oHXyPHnPbIycQ5xgZOo20r3uaaiVxkpflH1dGQZ8D
 QNLfXSSqfoatDMUom6bn4WvM3yF9SsNIL2mtBqraZElbdqxp6ziHVDlZHCOQ+ZDRAbyv7HwLI
 +M3RXSOJqhGhzys1wTzHEY2hoCezjwxeXyIJm0oGQ3hukSD0tX5Gh1UhjS7lFgMxA852GrKrD
 EXBCqd8myY7Zf42CX0JK3zflmpRbsV4wTvu1fSJ9IMVF5O0hOS6yuwWX7JUtKICfStRja6Yst
 IUAfAoDt73v8wggWwwCB93B1pWdyKmhRRR5BuVXnJ/BeQnr+fzIcdr0KnZbNy4e2n883sxeth
 MZd7ryqvP3QyZyg7R8z+nTyYlttoBISYYod7Yacyn+ILmySng4cYa4nV0KdXwdAFs7Qzh/LxR
 Bi5TV008GFn8JXgrfv6nLUZ9hSVkjNLeXwNXq/ja0EoedRP4VTG88+zXDLzuoVeEgz0d0+QVi
 q3U8y5O1XwMqwff+8qQ8EFUSo5aiDU8HvB/g71xEVDccstuSBLCSBo8olk2UH0a9OqCbPVX3k
 HA+gCX/6mhG1crPnyTkOHR8xpygPtxqj72tf6crDv9qi0DW/qipWTlbPG91EkNK3gywnjCtc9
 /8/jMBS0LK3nuQujhPf8rlypE/cN9evK9rxjHaacJqjX5H3kAN55CaPow+d+N4SaJ2TKpX9Hh
 Qp5Q5UMpphbs0Aeyu77ycxyXAlzMGrVBpJtoikssKrTxh9A9Q5jf870AOrGCbvJ3cvo7IH5Q/
 o6Svp/vaX21HOtYz9pjaYKVe0DOe7Ks3QBpKdOPAzjtsdjXCHF53ibUBIlpkzPdr9AFmWQQeC
 0waYFUwIHt5sG512088JDAA7QBBB/CSBJ6/2st9CX9ZCJfIB/xbloS7RthevxD6+B5zS3bf7c
 F2Aa8izF/duxzLnseNTic9qm9iTaFut5DjwQUneac8LeV1I94gcMzePt0MYBnxoFbXiyXC0mP
 dZfsjbJmw48X4+ofTmjWgsmJMBCR6yht8Z55BbqPGEFRBBiVCbF4Fm1xfYzFWKyc1k9qU+mKC
 YJiqbcQsTVT3RLsGOMv0uWz12iDM4m4iDghCPcSzEDB+FQrNNj+EjNhhcshh596q9f9wJMqMD
 lPs9kNxiH2iHOMzMVy5s19gQ0Gk/tjmyLhp/1XTsrQlqeo3PEZ+3+937MDHruhLhX26BAxnRP
 AgGmxuigWXFZ09r+tbdK7okKW0cSwQupN24jzteSeoLmkGPcjoeTsH2KVnrpLFNumX5aU1k/n
 08JjfmTdNgqiSOXMw25VDTbXjoLPRoGNsjt2lyRrozKH4bdmGYiqSJpP4GV7JIdN8vYgxxpeB
 MN9XtED0a8dMqy7UfhihmK0D7ZANSYjlSeeLqJ3c4o3C31nvhGWkcSU7NRpcJsEnh+USODzRQ
 COWl8cpApHiR01moqGFLDApvchEjQ7lRtc8+cFDAW9jp66N06SgouXgOCvFDXoIHUlZ0wKhvY
 DwaZrDW+ZtQupQWvDztf56aB6ywuoTCIzwDbu4TVDqLS/ZcYYMh6rXj3n65VCimVLu8cANvD4
 T6IxoqpWE0aGuTRmgRn4V3TfQzdZlhfyHa7yyUMkkW8v96ZWsHQuiy3gssApHYHekukAccnfn
 Se3tKGXI9/dYpY6A+/etO9M/V92cCrCRoKKS2uyIpwUw9B6vQjMtgj1LHSWwooXB96M/vBjp9
 pQ0Vq/TPYeGGpRl8GPT3r2AcPB/kBsP8DpFn3zTWH6O4AcfsxjM5MHclHvQfX/aepfEt4dqE3
 BXRttnT+gTxeGfTQsxl6eZ1hMqXkMQRuIz5wMus0zWdX6hIvn0idGUfk5rmtrckewq9SqwERy
 Lfr9v9DqjIx95neURm56W8yPRBLpqZXS2dNOmjpYkKXop+QI1AkO62vQBSTBD756fS4JP1u+V
 pHcR1vSga5R5oHJeIsCSJfsu8ZRj4Pn6aexfG+IrSah9yI0gUx8qGHC2DVsM/B9w+e97mrhv1
 RtpejTcORyGdJutUOHWQdAWWwUeGx/JNhWXcHIvyZTJOZNGVipVEuuxpmEHz9V4IeHuUggNx8
 NL3F+1E/5+8wsQDU88acbBfQWJqAbYRtYGkRpSWBL4DlDAWToH9psAk2KOsitbn5ojSK+2BnU
 +BRLDQsMFQfdX3vxTByl2PC23ToGEWGEIwfIXDektrJxpxxwazD/Vca/Awzka0Rhom6jj8FKM
 fS02gmJbJKl45X8/cXCaz8SZjm5kNCQ/dzIxIpTRV65mgRzXE+YSPS2r4t2ZWc8quvV04abt8
 gkHVfH8JfYhSYhi3szdoEiZ5mlL76txGHEvBkzbziOqjh+9dYrmDKvCxqKAtaCJ+xhffTNkjG
 6bIQP/dgK6Nkchz8ThPS/pFQ/kuhoOp8nvFm7jRb3UhIGl+cf0ViZpgow3qQPCLj8hSBiJUBJ
 86lN+WrYpaKF7uYg1MWTqIc2Pf4vmxGO6X3eDI2wOLZGARHfs+s1eOZlYmJsaYwwFmT/RpePn
 IK4IPEzXdiFB3oi5+1arvSfF3NzfL2KIliaTbsSH7xt14ndz4oBAPeviE70Sh21Hb5q33vMML
 4vdVXJdbKiMuqS550xkPQZjJLQvaWyVpZXDBwctPfJ82IYAWeQBQcJhqSdrey/oh3La0l3vf1
 uSLGGsmVT1HFd2wT18aY61ViQs7Uqc8LsQ8o8/Xdr7AiG0+2X0RkCRTmINUarN354uu5qgHFf
 Mvx4bzb29QpOBxU9RE1Fj6caeNXJ+Q4Vps9XeZvGtkMv/iw8qv3u7P1DcE5CZqnModAooWAA6
 F7TICPmZgRE7v68EkaZrxnrpUNHi70zjxAoqOXyz19PVqK2jbRcr2Jw1NHONIkoD/ROX3Ver4
 +098SBfCoV4QHTOmxkJeQBJij2innMTy6VRVwCoc6ghhb13NUdqVYqXaHbh1o6IVbTtZBxZTv
 Ic5Gt3lARLZky8c5xX+W/SvaQUMImez3rrGzYH+sOwZxJ8Mcdzj6YDs3u0LbXmZbNaAyzxqiG
 zXKxmqHcl6NMpUfKcDq8mdo7tW2ElQqrsgH893jaUyBzkIkT5WkZOfpN12WqTUSUrp0fclYKd
 WdSCddpapekGcNMQBqh3n2xw7tKBtfx1L7xelTXp4R2rNzkTRNe+Hjq/2hlHXCPleoCWCcZDw
 ZrUgJ/b4Q65B+2quqWrWIQ2Ye6BDm2ZHUjaxH+pe+aN4SYwavHc6tG+/twROGVBAURX++4Nb1
 QTiGWJFMzrI5wqbVZq+e/WD/W+kLYOnDiRnMQM+LFHfeHp2bxMfuuBlzuprlp2KuRkNzqHmms
 ROLqdQGg+gXyE5wjEPXd0aNCblto4DdMW7nuTdR/ZHjUnr76MnNPOeGxKprH49Krb6+kvz2is
 5nzrXzj/IgocbX7Xr+Bu5OqPGasEaUhSlRxKRNN6GAVwWhPi9+Qec91mMtTJUCUZmEtoq3Eiw
 ZM+4BsN6W7UQQtR0UMAAMW/8NTtJ3jzWG4mrtv3bp21v8yPbcLzndspUuQK3Q6keATZuW4E/h
 mdbAZKbiitHk2zXALRZKHbqfHM361e8CbDS2/OPlNgi5Pdt8jCvoKrJj9nXb8N39oSguX0ik2
 KrQAN+ZjRcVmk2ieyladlBvEeVZAU++4TEoS1LI446jdpGmnlidrMookmLiOf9flEDDbr4aMJ
 zBuniwMt+QqdMOQgvpOwp/LcrP9WibBk9cnuOp57BSW1MaPpkXzufv0jiGe3z6bbQ95OD767J
 kxRWhqJemQKC6z487BZ1ZpEEBrrqelHhaLFPwsxaMapjYSZ+mPAymPqnNF7+SjNs6LDZV4s8p
 iqQraJoM9dVEVvSRAbvfeM528G39Py1/qtP7sCjWaCyO8zJiiEDATQ4vtbdJXmVaPNAbAdSbU
 PoB7XqyfT3uzUCpa+21DayqKjcl/PUW+QpU4+B4ydEK1znJx1R00SO/GwToHyiOsNF2eCLQit
 jiwojxFX0SZAEnGjgU3NwIJinrlxR0K4ZWVDA+rHDHgpCIUvN4TjPN/t+XxoVv2igo2XgsSR/
 2k4YY+XX6eSPXGxmiIBLN1OCpyjNIHN9o9DIfZO5lmsylzk1zxShaIUDTKwCDdgi6OHi4Rtt0
 SRAWuX0hyCseNRy5xc4ODV4D+66pE+sqkKx+zRzp/eDNYn3Ut8A9q/xzgv0UnpleHwQHckzU3
 AM81m/OtCHiuFYvkZ5NVlmMu19oQ5NDvLECrN2rREJGqP8jGuKRO/1TUMoe419tMC4CDJ+vTR
 tkBcMsF4OGXfAzT0ODcSG0oQTqFzQM/UMfMaSQebiQQQijwZz1E7eww3KfGA/vQN2dV/kQXDp
 zdpmFdmvwCsAyV5Hdar1vZByRwdlzWgNNPoZB6v090JCrz6SZ8gCV9uJw9mw4x1+wJyHA2yhw
 +8ng3vPPf8kFPesbIjQouGppKo0vgx+/Oeco/MxiXbikYFnEkYTLbZo8jLCW9irwQMFyXwKX+
 6sz7DnAZUkuSaObC9lTUASolxloo6vL6plR19skxv0fnHfkwPh/NlfUBMYWUl5uY+mz8qBIjm
 XWQEZoeRXX3HFkDZNeLvC4eQzyNHrCYw8v+pkDKiUFMwklWdFtGeZxQQ8aEYoEOkKsY68Losr
 LmGFHFM+5ehy+RyF0Mc4Zvp/dUcgxW3aPmh0C8A5Gtjd6Bu7FZUZE8mYiJ5/95RJymSOK3hwx
 5a+DaXH2ygbAC/J+l7MrskhD842IYj/yXfKe0LeweY1XzZmV1UqhHIgDCiRKGlRQDFQW92ANi
 iIrBSU8P4aARhmAu5GDg5V37ErGLntO+6DNtLj9TEAOHHkXq8krpZqjDlqeLxWN2sg80L4PBd
 yDaiHapzARRaNcveypUYnGwQkRdA6SYchjxc5SSuGbTlAbdCb1+3PJb+YdnGll13CJ2m58qli
 utApPza+2aGi3mXhpPgyWlh4CuL41paUgDGg/1if+Ne1KVcAVSTzAlK7



=E5=9C=A8 2025/10/13 22:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> If the assertion fails we don't get to know which of the two expressions
> failed and neither the values used in each expression.
>=20
> So split the assertion into two, each for a single expression, so that
> if any is triggered we see a line number reported in a stack trace that
> points to which expression failed. Also  make the assertions use the
> verbose mode to print the values involved in the computations.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c641eb50d0ee..1cb73f55af20 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1698,7 +1698,9 @@ static noinline_for_stack int extent_writepage_io(=
struct btrfs_inode *inode,
>   	int bit;
>   	int ret =3D 0;
>  =20
> -	ASSERT(start >=3D folio_start && end <=3D folio_end);
> +	ASSERT(start >=3D folio_start, "start=3D%llu folio_start=3D%llu", star=
t, folio_start);
> +	ASSERT(end <=3D folio_end, "start=3D%llu len=3D%u folio_start=3D%llu f=
olio_size=3D%zu",
> +	       start, len, folio_start, folio_size(folio));
>  =20
>   	ret =3D btrfs_writepage_cow_fixup(folio);
>   	if (ret =3D=3D -EAGAIN) {


