Return-Path: <linux-btrfs+bounces-18268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AF8C054F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 11:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A564279F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82250308F0B;
	Fri, 24 Oct 2025 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MzH9VEvJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3D307486;
	Fri, 24 Oct 2025 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297008; cv=none; b=jw5k09VJ1kFnHObHC4s5EjzOOxMREohefDDCMIDpHGaFuWe6RONs0cVizk/9iIhGAUqwVhtRO9pP0H4ikg/3451DFqzJczhLjLyYICxQpv0LpXUjY8o71J2t7ZdGqORt37YmVjZ2Gt2SaFABmoLnPyp+BufTt0FIZ+myiwDH/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297008; c=relaxed/simple;
	bh=OOATCH2ByYTfbEvnAAUIfMU9I6UDiCD4rFMr41VbWiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSigXyh8WlhXRSRy5SbH894DoYNt/SfmUeRkiFjufYBOAy0MfSH2WOxLEsR6Xs/p8hq3lj2IskcytqOMlU5qwMdTUAOjTXwQSxNADiwlCNn3aRLs5FPI2vDWjGziOtwHp6SeNXit9Hb0R86EFoqZEob078AdEAt4FhTmeO8jcxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MzH9VEvJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1761296999; x=1761901799; i=quwenruo.btrfs@gmx.com;
	bh=OOATCH2ByYTfbEvnAAUIfMU9I6UDiCD4rFMr41VbWiM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MzH9VEvJz8lD2qjfKFw5j49eN2HnC1YiiXX8bBwgtc9J5Yq0EgH/RK5X4+8Q+Ul0
	 Pu5LGZTpYiURkNLti0KVN9IK0+7s6m3Gqjk0pdVS8RCjgjht2+vCxGHb0aP9PloLW
	 StiqjggISxGtZ8Gb3KgDHR9eYdQdS6awh6exRuaie/La+xToMG5sAsIsZz9yr9CCd
	 vUOKHlOEcySGxmQhv2ma+zIeR6iXPrqp5n4ws7zWBH8Dor6YR/oVHojOsNEejFKx7
	 L4PLNbEfzjMNnDhXS10rzUEkBtfrI6A2EMHyonHVmljRTWnvT6ogejk9gxNOVTzKn
	 nt9XslKbkYYE/hncnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6lpG-1v6CT23dN8-007VDB; Fri, 24
 Oct 2025 11:09:59 +0200
Message-ID: <1baa687a-22f6-4eaa-8de8-5096e8a29275@gmx.com>
Date: Fri, 24 Oct 2025 19:39:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: make sure no dirty metadata write is submitted
 after btrfs_stop_all_workers()
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 stable@vger.kernel.org
References: <2059d92d64eb181f1d37538d1279ed5b191ce1ab.1761211916.git.wqu@suse.com>
 <CAL3q7H7KmObsE2JURpKLVRT_ufa_2v4M2KAFahUndq5Jqxwnow@mail.gmail.com>
 <6f36e8d0-630b-4cc3-a780-11be4aa0a65f@suse.com>
 <CAL3q7H4TcJNY7cYeYWoByOW0ek6BBEbtgSSFFOvc7aagarfFXQ@mail.gmail.com>
 <63aac204-5ea5-45b1-854e-6b3d78db99fd@gmx.com>
 <CAL3q7H4nO6TB66RhrrrC94GSrjLOb1tOQ1xPJqmZs=m82gX73g@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4nO6TB66RhrrrC94GSrjLOb1tOQ1xPJqmZs=m82gX73g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CbIPHa8NaOHC3NZcp3I73zhXs3LjEtor1qrSHi8wAA+qOyManle
 uAC+Ba1MtTEYHPgfkPNuSXISFoXuBB5Ufe2/eHkNhi4u+tnYWl3+fATdMhHk66O+n+Z4Yhu
 RLtyFjWNHm2SmRhPc6/i5GNUJZXB2PN8vBZ4w9VvaFkq12bHD+9ALpTK4MnvioAG01dQCqj
 bJFw7nV8FwI0TCCIr7GRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1dGfOT4VCYo=;sK/XjMII2PKoCATLiD3WiefawiI
 vTVSur54bp5B0I+/Pe1Xs1u3uJXErb1OAp7+ZkJUdoekLsZazFXe9hjWY3yeiAn8shzHz3d3j
 N/zjVP1D+3vpKJgkAt1dXBBDsE9lFHa/QhiiIg/F6zCdkvwq8kgJ1GSWJ5IbqpB4snrHZi6gQ
 1CiwxKecIN1FPClU1SKds1t4yizQ/6gkVKJBcKfkVUIp+SdxCt4TFlrrchfr6xODBkduOxnyV
 w6PIicAeiWJJetlRlWmIInfwPUbvz5uxvSsBWL8HGl4PRQ3GQQ5KchnnSzWy6CWgJK3BFf9r5
 QfnpTMlLxjeceQO6mwmJ5/lvTObnAZC2FPamVBOWw1mDnc8FC9ITLiXEfRYAtEDuD0JfUQlEj
 xGZ0qyBsZdpVyVCygFA7ElyVPDJOlkyPDhgz6A1IIM75IbDBCdKtT38dVVpqiYz2Oj7dzR7Tg
 DNxcGUOKfaMmrEqpxcGosdHZrV1ISkdr9U+hWowMWO1jfoOacxi+pdIDa8ObWblMDD8/+WR80
 rkq+Dqf5mgNSRUD50pvLgxegh8e/48ZntCCBVP+ZdvUEqP8b9X83yFqYzBYElQmjhUebkmpyH
 6k/+ls0HcPqR9D6jR8rhxDvcHeaVET9B2/QX6ALCQrifm3m66zXg9ZGq0NEyfF1liIYcAO3G8
 ZIpQQ6JYA0abchfMkGAjOhU31C72DxIN0RR3Rcv0gWwQX+cAPis/SA+bzL+5ygj4dNWW/+Obb
 SkHBP9WFQ8rMxMlwsYYhASRf/f5ym7jji7pRYG+qfGVMeQBdwkuKSdLgyT83c6mWvp7jv9/i9
 8YfTQHu6KwCG2jvqgvD3xVjKZ4/doO9Hzd8SZpEsjluEF11P9g3j2VtOX74p2lUu1I6Hx9kUB
 A/KH8ZNhBA2NafyfxZby58EeZMsrEhfsZ0ZMgFPB9I/ze4Y97SS1u57clYQNs4kz4hli9UGmy
 PPmHa/Ao/8BlKRFTiQHs+k6p0XzhV/Jwg2OxrNpKyU3Uyq7TmwtPOOSY1+bhR4YlzqEvX6dr7
 F1iwNtg4IXPFb4t5zkP3RBNz8NmD48VPU8APRGIMU2T65IWN+4AdgSLi70NLvUeUv8BsRzeTC
 DR4LkmJ1GXrABGYB/w9gp5g6pQEaPRC4T9y3BUIa3zjyz3qCB+6QNjwPPqMCbgOl4TghxCyd+
 daWmnOIwhexpabGincQ6njZsbemEjBcBqcbn9XWTzZGjOfmyOP951DV2u+/NI3hjO/HT0KMJL
 4tS4h7yNVY44L7lNU3lSVIBuo0VUn5PLxXXF7GMv5Uc46S5m7wiag/ziXa1DDSAp8DkocgbGl
 k8Ocicl/geVc4ybK1JgXg2/g7fW7cTB6nePDjp4UXll7RS78jt85/AIig1ny5lhywBLejg3Jp
 VM0lWE3BiTe2CT4dVt9LB3Z6eQ2JtCUVVIrZBDAsP4xNRBgkei+mUvqIcfVrGbnlv/0pWaAHm
 QkO7BKZTih9ZkvnwMfVipLH2X2zgkrXUUwCmPT8M/S9ggk3KXTnP+nypuPNPaEoGMZn0Bxp0U
 Ei038d2wvTZdWhhzlnFmv1chpYIdZbxllLysTdKTNsUhpaq1jRlk96THI/KyQFopX9dgVWCsU
 01U5vfcIFp7h7XWxcXA3EyT3O6j3OTcadNaLLEgbZtv3dn3ntswuKK+7CD2l512uFrPQjrmHn
 h2gPmFp+kOs/otHUwphACKjscTeYasAMOycqa69DVmxVz7xxIJ2T6lpDlOp/7HyOv1ZJGzM7b
 PvO/lbaO/dneTidlZOgDL0EbnLrQP3xPvsnNORK8zbpa6+e/UbPc/8J2Rihki6wgs7aMvedM/
 dcFWgAZkrMt3zPI1U9vI6lznAy0r1yMwgfaMYRYlQlMTYt5xfmItJOMREzQXsi44qoZy2bKeO
 Y/+zKGxKz4io9AZ5LBSHQIzbV57eHSvFO17gGSkhqK+PFvY+PLt3S6fwkDDP7OXWle/wWmET5
 l8JHFCucPaw/vCID1ZepAVK/3I6c5ZWEVcNCn5x4S4cQ0ZdHbDEsqow4bVngmwpMhEgovH0KG
 jz/H47OHWP44nM01xtrvpaauHq0MkZF2oFMHa3Gdfz9oUlRt0yF9loENJtWGHWsdoqkBpWket
 ke59RsR5ozCTNHdc7ztw4qdnkWJgE6vWC2BH63lbbvLg2bpU1pek02FFk4slnhAHmqHJ1+IeP
 mJA0b0CzMg86noJBmA0eUxoZfr7+J0KERHCzPGUbQU6i0j0Od2vAl+C8NZjYGK1jeJHb/tWvu
 Jn4B7W75+QISLD8PbLXeeGo+dDGGmuEtxkKTk0YKQ+rPuJ0iXNQyPgiXULIx1erRwwbzkEiTp
 67zYh+hOhc7TmzlR2LPiO56eILEfjl/gsl/55nbKjonnWea6Ll9OQGytkBIeDzCZNxWwCAAnO
 dP4ymByMu1lH0bfANtY1KT7HANeTfpQcaaSz/3oSnoUpPTUeo6TOVI4eAuz/GlglKi+XlPFU8
 baQhXZUT83KZGi8XlaB1DjvbtEf9Ig4i+Mziewsf93JUKLR++3x4kaRQR9ggzLx/Q3lmMBSdI
 Q4uPPmXQuBQBW2WVE3y1Vh72R00Td+3iD+yVw/9jzDPJbuqTG5lPKo9PkgCTyuHigXU1WLSWN
 W2lbMgfLGXRlQYqkXKxcW7SkFyX/SHYVT8uZ265p0Ja//wPoptIrhwqyy/3SQD1r2OTUNTOdO
 7VINKOnBi0d9PhUlODlrSasgvwRiufYVaoNFZ40xJf5ADnUTGLkoKGgPVCNnLcDXx9p1H9Ae/
 Pp+VJq8NFj1sBTYNF7FyZ+DCtZ/13zlu4Og+FdZ4ikDdO5bg4cZxREdzVpruvSkqqzqkG0RPQ
 VQzgmbAyTeznVYX87CcA/Jid4XetkdBJiEKHNAfANHCSEXMFzE/6CywnF9r2bNkiBcNgOHHsA
 8ybFJwBWlNfBQavusKMSHarjROLD6g8+daKD36yTDYzYEz0RhopBmdVmnPNmaub5/91w0SwaD
 Ty2yj7w21zF+2Q7IIcPnLFziIYMR8W/WkJ6hXEc+gT2LSMZoGki0V7mrreJC9EG8u7ii3qqmj
 JxA02J2DQD5AjNIcMR1TlGoqxFG/wY/wbJ+DZb4wmc6aJSsxodjibG7wWymWiFFRZiGfXVyRu
 RFwF/nw0GVEioqkp+LV+8X4VS5yfF7eIQcJDcZuMIFk7eQTCkqn6JWYJ56ZEUFfYOjG8oXtLi
 Oh1yNkPv7e6+uKWriHOnaDVqa3xLabrphb02pZ0w1L0LTRdtHuUxt+Sme6I5W3h0SO2yNf16X
 uV77Pbu9S4NOB9gRR2ht8MvPjBABU9G+nWqoqUd5ugL2mWXJbAhhrLFrbQJ4g9rqizu3Hwe1C
 faAaC3tcYH7Gfr6NipWGQIemgD7rA7mA8GFCvWVNJSaszQm8SreHmvCDyRGtOYnCEa6UqXh20
 qJ8uwAB3PUm79pCMWAfb1no/l9s5EwvRRtDm5x9g1nbtiLO/DsiYQnE9CXX8PSJxBLa8evtWv
 vqtgsPu0O97BZkbCzvBRguSHd1KDS8F14vesCtPO4SghlGZhwMmqns34ShN6Z0Nk1HAJbTaXI
 Uw22pXyIqbGPEYJJlDVUGhA+ossRz0x7h8Z2fxfbW6DTXtSo+E0he3XqpFZEYGlijLc0Uop3h
 2adtDBptAKVRnAQ6hTh2db62r26fZcd85fqg5xneaTsn2/NcyxeVbEcxNpnzkB5tcUZvxWKEy
 EECwzEdZF3NAYmBIxP7plEVdgEsU13fCOL4KP0Z+TnryTk0Dqa9VucD5s82hhuluN9GdBjRws
 z6X0qpJYa4qP+9y/GafmDXFYA/Ya2jjTwlStbpo7cabzXmahxT7lD0mWa4l7UWDb4Rr4Gw7J0
 q3dF+bQkMcUnN7AVGj5UxylKJw3BYFAY+fiiRlWXlOM0XZ4oYSXphvJCUL9ruR36TUuX5d9hW
 +/H5wLDR2791x+QGaq+qZcvHB5EaXpX29bJq6QUa94bL2R59uG+KKtkb5PUD9prVwL6kbFIYI
 mJecNp3CJShLDw8mfXGZH0CphNz67C+Bg1mdWpMqj1Gzjg/tyFiLusONIl8xtQuFtD2KPBJGe
 Za6ef+IM8VPECDe107dcQ8QNkCB6wwXfDkkION+bhzAwvpOYehM5cq5wo/RDSgbjjuauNR0QA
 eePXK8QPaCUBtriIOTz/Zdp7j/77vLeQ6abAdMHGEmu14bN54Uc2TQNMFGcphU+DCvZJzbT6K
 cjyix0vJiibw3q5PzDavTqV5bdTlay3KZcfxEaMYr0h1D3hBE57OaQRm3qQvPnfzUw0hke2vX
 Uk8KQRcWXlXkI//mkUNdFeiGnVCa8MHdD2dj+93cVODnz3oVs25WaacG63N3ZUXnpwf5JM7Yg
 U1Lmyc4z5uoMA72oYfpIiTCUaaUw4Fv7FE8estsB1cx43M5WLwSNdVWNkHjntONg5RinrD0J6
 uNKpTQKY+wh+HQwYJnABh58Vufh21Tmu/tLc/SCJCbYhFpyKVWjgsk0zClyPUPUkUIPE8T1EX
 yVIhXz2ZIim07rJXksDhNiALmFtifntbzdCPaGMUQCLov4zDPpKfUve8RG5oLvzU8ATGlJyOM
 3QAvw2bMy0Ee27foh9DayH07mrw2gQ1D/wGkDarhh+0l/FEqN6OylCP+/fJEUasonVpMzNwk2
 H+dqQpEh70cJjDga1ozNH6alOGHQLSrcvoxGiFLVMBH61Egn1Sq9pcJDY1eqtE48+p0H3aX+V
 TEllthw96glpZl9/l6WTbcxs41zRW+aKBEWYLc1TFXUpZTqs+mgNOX1JUKCaVurLSizmjPzFP
 zwJMJQg9eDHNKPEbwp+QwzmMITr1oLx+M9eK8iERjtUZa6uiQQCu5I29WZA5eVrc/upNRGHE0
 xpOZagF4NseSfDkNtwy40vf3RA9kndscXETkxfdhedSlGrBHIYT0l632LxEkoS4FMa4Hi7d9I
 dAB9RdpbHwXU0xBQlnBphQCdJn5Ef8MvxDC3FAd40+NkkY+LcaXLEpU4J+tjRiAGP2t4tGsZq
 15CYk0JThVSqD5glpkEBjvqfFgcWFBDFb8WaBTCcPiBGL5GeVxcm5VXq



=E5=9C=A8 2025/10/24 19:25, Filipe Manana =E5=86=99=E9=81=93:
[...]
>=20
> If there's no backref in the extent tree and no delayed ref for tree
> block A then we already have a corrupted fs.

Yes I know.

>>>
>>> Even after a transaction aborts, it's ok, but pointless, to allocate
>>> extents and trigger writeback for them.
>>
>> Writeback can be triggered by a lot of other reasons, e.g. memory
>> pressure, and in that case if we try to writeback tree block B, it will
>> overwrite tree block A even if it's after transaction abort.
>=20
> It doesn't matter why and when the writeback is triggered, that was
> not my point.
> My point was if a transaction was aborted, what matters is that we
> can't commit that transaction or start a new one, and can't override
> existing extents (either they are used or pinned).

My point is, your last point (can't override existing extents) is not=20
guaranteed especially after a transaction is aborted, which can be=20
caused by corrupted fs.

Yes, the initial fs can be corrupted, but it doesn't mean we're free to=20
make it more corrupted.

Thanks,
Qu

