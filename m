Return-Path: <linux-btrfs+bounces-18919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F300C5480B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 21:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88911348365
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234482BEFE3;
	Wed, 12 Nov 2025 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mtvdku0f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C784E28152A;
	Wed, 12 Nov 2025 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980411; cv=none; b=FZ7nY7AQAvqX0kW0I3nFjFl+xOyWjBVLhFRX33X0ay2rnxus9haRx/tQXwtFU1/Wh1+XqtRhELYAlzTcg0Ov1xp0bNnubzuTBYND9ou4QDE5p5GyovQ4B0fjtq2DbdWa8Vpxqq59vXL9/O1P2L2kCzgOp4Qo2Hsp4A/7MpeDl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980411; c=relaxed/simple;
	bh=rkig3yfhTNEFRBW5UmRwIG+ge464fk379PSR/z1XN+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FogDfsGfpyUOEg9azzCOOzPgtKp8DjrDIAv+zU6Ob4WXSphdXaQpCjvqE5xSnpMkY4FSmitUv8OliGP75kr5JlzCvD2DKh7lhQZNfxbIbkjq6snchKcF7OA/KUv+Pv4WJn9XsTTU8qumxs5tqshuvZS4IW2UmLLvIgQiyGtcA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mtvdku0f; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1762980406; x=1763585206; i=quwenruo.btrfs@gmx.com;
	bh=Xl3psTxKSvDqURhtJi/s46bz1YXXd7ZfOOBoCg+v79g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mtvdku0fuPbdzjKKAQlncEqHueRnD0cYZ4+fjgUgCkyrzsNB786O/SQ80KMMbL3N
	 1w2+tK7nlnoX7ztfUyMHKGs8K7nTyL0AmRgTmj1uhoPZh70N2/JvrcaV/dfD4e+Ra
	 /Uo3GZ8GFwPRNHsmzHIjaHm9HgMkaTAr1rSDNclstIvLjaOTd1LgpIfsAD7PowW8t
	 mxGWoVbkbg4Vf2kBEyWZ52oMaz6r14lODMycMcvD9ZNOjwTLWGf49YoLAJLAP51yR
	 xP+vqEQEuagawLKevqI5bWiSOAs5g+wv714AHZBPTQbuYBKvtv0Rnw1Dgf55/rfII
	 j68GjIjSu3BDazR96w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5if-1vZzo832Q9-00PA9u; Wed, 12
 Nov 2025 21:46:46 +0100
Message-ID: <ec7e5f41-6585-4817-a901-e7a1e7e7b760@gmx.com>
Date: Thu, 13 Nov 2025 07:16:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/8] btrfs: simplify cleanup in
 btrfs_add_qgroup_relation
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1762972845.git.foxido@foxido.dev>
 <d9e7808a976e6325bfdc41100bd9b38892663a8b.1762972845.git.foxido@foxido.dev>
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
In-Reply-To: <d9e7808a976e6325bfdc41100bd9b38892663a8b.1762972845.git.foxido@foxido.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y+wyH/cAzHMVnFXtETzifu0fVujy1Ab5Dv/JaBWBb+Q0ICLZQtn
 oYF22GxKKVlxFLPgT5FZVUxoBuZnai6sHbY6g4YK/typrDit6ql2o05A8WinVzpt8SLMGnz
 pvgKUjPyW/3Z0phcxqowGXF2Epq77TrP6ucAB0oqQasJuPOtwCIRw9c2Mn+Wl8OvX3TrRt4
 QhB9GWiDX2lBTtLYO1ZzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JzjpwbLMkcI=;4HPcM7bjuV24lkk5nrktjqWLgqp
 8Cr3GFOTGxeb3Wr+SQ81JXSAck9c0sYh93BFxa8mKxQwyhOPdckHjQ4Oqq9BH/PcMyG+tmdVl
 m+7TcwB9NWu6IqPIltmrNLtYpK8GcmZZ48TMt8y8kQozuQzTx2u5UxhxRRNyPh8TgDwi4LnGu
 +GZX27c3I85dsVqY9lrpB40/pFVCb402wF2RJ/aqgfiSgfgTCNNqMGaHPu/p8MlQtkrAdANJH
 SrRmTbS2MQDs4d4sNSyTZBoLQL2Us6y6jwIGFFaWnuusfOx36V7ldplLWwtCl5VEZfyFL7KAw
 UPaqMUFnf0YrBdiTq+81rhv8XkzHd710kxqQud0WNhXM/ZMMe+hiKxY1Qv8rKd/HkDCDPXJPX
 CDLM93K3/wyaSG5Nmj7GQKdYT2WPYLkJvhq2PHSaFZbg871GOfIb092752poQlvsSAwLXuWnu
 qo+1e64DEwsKyOswT/IzaCYTBBto0a/sgxqQDmcSKyBseenqz8OgFBMZIuiYiltW36l8PKCvA
 C/x3ioS5Nn+RKo2hPdbo4a9hXweXrHBu0tCLWXt7BPuCG84SF2xwquc2rOkpA573QgIRKLvow
 7UEyQuzVGL4x7ianzcZmX6yN4f+cDkUDMsuTzpzYk5xaYFJTh3ydjiboMSlpE57dSxwhKrcWZ
 P0PdFF7NGd2ZNX0pg+ig2LSRlKLvBojXnkZplIEQQRXNU15pNpTlDy33e4O/iVyYOhyMm7cD/
 vHk02tVFO4Lsl3hAIOy5PiwgMPbcL8kXKBHMpRluwT/Nr46bR+b6WrBtYSm+YluwUpYNeqIrF
 QC2OT45YBl3+MwxmyOY02hP3encjbO9MCZd6hoi5J4FbqFqgKNUEdcOLPG+jUqSJD4R/29ipO
 ngIpWJuLi/mzGkN9jkiefwPggkTLtVt132YYaN6f4+AUGE4CHETBkB5QNkHwsG7RFp54+7VO/
 r3OIJwjNvAaX/ULJX4Vns+cdgmdkhabNXzxd9CyFyIAYArBUPi0LIkb+2hZSjD4E8714Njixn
 eyau7mW0wFIEz+75nP041wqZMrQYvS4uIadUZXxoZfll5PyIxLB51sTv56f3DTnO3frpWLiyo
 QpZmCuqOVgab8Dh79hOtGwbHAe3hiQwXnDdK96C303UKtQbt3Uefa8sE+AeLZ53OgBU2onQ5V
 erAWXJCP8IBXeje3kd6BBb0r+h1SFZvOBEsf7rZkD3l7HP3G6UIN1wOkLOkPR+YrlYnSij1D4
 We9hdtwSEjf7F+QIq8oAnGyW5pRSnPRDulduvjmQwH7eLIpCktkP6335q96V27HRW96tlZ/Ga
 xr6Ybr8o238HDqihubmxkng2Z48ViH+n4fjUP3sbMsywfk8epbfKV+vopIqmfwe6JiudbJ3rq
 jbE9d9mHvK0kxPI2QRHZuddpYcZcpA7d6f3CVG4+u0JavK5WgyO70R4DzmDY5DEG51/ODCRfA
 q6ep5QLi430AkW5iHQ0vUcaKp/o5Qzk+emIQ+wuc+uC+jGd/BT3xho5MIJj8BpV+98wJll6qT
 EH1rk032l1L/bvaHoohIHIfzOoi0l47MwBAqIiAA4UKdK4Z770ooWOA9V9p8ducuBlEHz7RWq
 gEUQiGxC+/5BtdVSKFtOmFnOpMxM4u+0+eyKmowU8eBEMpFATuNKR537nDuEUPVwBzA7wMndA
 N7A9WpGW7IA63nxgLPkd7WOVsJodwFUoTmVithit8L/8c8bvVMO02OGxOVfCZovqSPGeZGPjb
 doG/YjzkyRZa5LlirUT8sfBYt8jRuTgmGicKuzfaHoj6PHuKFw/esqhfAt2f0nXbCRV3GirTw
 7bdjXGAvm3hxwpi3abThXo9R4gfxfmbnLCNxl5h89zBv2yQZxtC1Hci0LPk0mUIPlQdtr4TuH
 eQ6O7DxxVhxI+ZeicicEXElmXFmOY4MMUGEaxeX2wK2qsyV5WnV3uRsQOmrHET1piHScIh8lb
 DRlQx4p6viDg94BdQdktukXZS4N2781yQPqLQrscUw21YmSruvjnCcHqJUcs0wPEB0zPqapjf
 qwqEAMFoiVr84hKkkyw2Qyx1ZS8eKacVFN44dkDRUydtPeLhfxUZLG9gaa4L3RUHaDwjp02NQ
 sBcuxiS5X7utqGlVdURcPIBLIHzh3t3nbmJmGOpZcgRwTJay4nHfNov7KiAyzeN+23m+FobB+
 w5DpQ8ylEAOiY5eRddBXzrKSSNB8yxus7VcB2puIeRktQiq5+qnWcZpzIzeMwH5UTn5pQkMLt
 Zc7iwk1n3zwdsAAN/DY26WFSWHdh3lAEHZIHHyElHmbDiU8QIHAWzU8TRmF1ZuNwe4iO+i+3K
 3ekS+7ahpl9ulV4OpcgRUykTZKhN4gL9sLoUEJ3eSPwhYd8EoucVW6g30AfmcaV8pklSRyL9+
 g5DNX9FV5QmK+HLkWdmInZYxCtzBxPrPeFQh3Fc0jXWjQ2QkO4/XhZLFtQqpUdRj4QeewCAwv
 lO/jleNZXVNIRVzKYz63kAII8jhm2QH/+FwQ+e1+behmvpGlTiaN8m1AR8cHbsAVk9PAyxxhw
 XVH7Cqs/2hLpqmh+QSSGlT1MmTuPPtGm4nl1lagrCYet6J4/jhxuPdcyLmgRc7z7TsV7Su8B5
 hBdvsJl9Gjs84llkq00hlsEb+myhM3EZJOUxcQ/p5h5akGr0aj5bNWdISejtU4NJcZRblrjKo
 2qs5rVlJ5xA0aIIHjpC5bxxCGjjyhmQQfS/aFEZP/+o1qhsJbk6CK6lI+R9/S1u4apEVh9yrP
 p/6/H1j17oOrZxRGFlHGsYxYHkYMYzkiyr0EyaUpFieirg3J9kFEWw3ICX5Ebt1sEXlb3U3yq
 uyuo52OSENEBL++N5nk6bRSUbO8IpbXT9QCPAtArGwA/ubmtomCu2AvOqRKjgk/Xir1kekYVC
 +dKJYuJXggW3iy0jjRwBGnsCsY97TqYlWQku+5IZ5KsKL43eoQiRelbjrM/oP2y4WoBfhshyG
 f+Nx0exV3/mS0eD0v0MVczIwMVsZbP4nSFgzuX6ritKkp7p3FKY7gR7kpU7xT98arBAyJmZJg
 GVAE/ktd8llMJf387vqrUlbVgPenqW8/f0fhrvpAPEmW/JD7EiVHJkdfhjEIO0qubeny247f2
 2TelK0+Cike/5isw6f/MLrR4I9yHfjf6QXQn/q03yh8ijFZb7ivSMGvyqEr5ARaLg39a/o3Ix
 3se02Il3QfFrzDNIgyJjuO6msJ+ctpdQU0w5PvervUBLv0nwc8RXuKw5XarfCDMXvix04IZ4C
 j7CSVh2mq07nXempOM/ExMnT0cjAktrsVirTM5P1moohWkO4xYyEeEqg6KAVGz6ZWHHOkO2Sl
 tuDim0nF4lAtd8Y7Mh85c2sBr7z3qnBayLTKNr84dKiLUTz296Q2EaXJdNmFa+5VssOJpPXhz
 imG1iscnmUBnZAmBASpKClnc4TtDJhYpHUAk6DchDn7Koyqh7jthmvcrCY7acA1pmvdR5h+c2
 uGkzm51Y2WGUi3wx4iRtQmOMESB7FDlJNT9fXx9ab4dYAofyxuLkssFgi/rMTkUNfoAUlAVmZ
 s42amMKaP3eSo6bm6GB/SnqCtxUvI2YW63iFuA5G3iGEgihgXNMTG7j2xDcmYoB26xDHWdWJ0
 kVyUhReenq7qY1L4GHn2NzugYXdb/wOIXD3RImhRcYYYs4p7hEDIpPOjh0imb6yyqR7YmYSLT
 nAWsYVPkfq3k9jOFfSOMBS1W19iMXpGIuf+m9va+pUwf1xFwfRJyfEiSN/C6W034p7R+f8WU0
 +48JRgDHXkNyDCPBalLHqizKIcPdaGP3ad4HCaWsTPIlzk0wjiIW4zzLIQaGJvWtByqgA3Gse
 092iu5pq/Aor/xGJX5cbmTXF7hsgSTBQcop/0i8RQsbXDGr/Z32unSzT0SIs+307D2wrPSoUC
 COl+7nCvM5lFZ1EoMy2ZwgGwXz25oLQKbNrDhWLZnL6N3L3iutLOkmxjivqrTiDNcKliVpDOg
 5WCs1pRgGmI9lXUErbq7AiMkH5ZszIINmqFooP0DaQLKMv3l1ENEqL36GnQhqK8dNDYXcqb/v
 xynt6BREN+n+Kn/i4dlzLY+H8zB4FRjcAskZMyeBe3zFxP+qgYDP2eNNifkURul4zibNxk9ly
 fDoJnXt3JR/hAS2eY3+RwhLK0di2U7TqWVuH1nPSn8i2Fa2lhzLzRxWQXiqcixY66uVTwW4sn
 eITQn2LFgf30EsmTwayEitx73eYeLAMQJPrDXorXYEw78pPZsTciGjE4jPzgp3Xq6JJPL/2Nr
 fZe85KnJf9IIrq60ozKmv601GFu+S9IGJxKCKKLA+eg/RnL79OohGioxU+XKEWagJHptkipL7
 +nToWWE6tGrVnvMoDHAuVa/bsi8LNvv/hesb+IhLQ+UovrZiIWVI9VWVsaVXE7GKRTHD9xSr5
 t2ax8h5IYBhoLBuRRzeJ+KchNfpDWMlSlGNkLMfzcaBkj99OA2nDGIZdpoEU8cmt6NxX59uHJ
 LjRBFYBUxnMK5xCPAmHV3UM+vlMcjsuX3Z/he8Mbrua096zRaY0RwJR10js5OcqFIv6lbjmIP
 bUPwdGmXYCoh7YEr9LZmV6u2DFVr42whmvI/6uewecCuOMHX7sDKa8wX9DOGMhBGR5cxnMvrC
 hu8kfEv/CeymxKCyiyAA72foTbsnjUisd8rpKdMA0jko3w8KQCkYpB2F3dJ6P233XCQicV047
 WHOhgAUT15ird5a06HA4oXUyEbkxk7+xrbdTIbrjGo7/z0A+nWiDD4becHklwGNVRZieXRKX8
 t0L9fXZ+PO5NG6vaxiaUqmvH3pfs1cYVSEwcbkAI9r+VfrRJAgeRXN4+5Hoe5zA3n72YBx4dh
 USBSVH8d8YeUsBeMrkw4takKMck7Zm/7zJF1mi1zVudUe6vfAP/H2n8ia/BUwV+LJaBwoZOUv
 Ebe+6jLQ76jXSp2+FACztdSg6i17m3sGY/UD5Tb09xEX8rXz4vRLKWlbwaD/1zeY5JenKxIsq
 e1gci+VAAuEFPLFYxSnvh2rSsR2YCxrbEvlV2xuH3pCSRsJJTsjdzBr3TxI+giPtBAdiXzjiX
 wfqGQ9SR+QmTo1+vv0KMbGO/zcwHuk9EmC+cVWbwH117d9pwu9eo5kfTmL1igKl1+hVj6yVU+
 LATm57dWi05JyXmzg=



=E5=9C=A8 2025/11/13 05:19, Gladyshev Ilya =E5=86=99=E9=81=93:
> Remove from cleanup path mutex_unlock via guard() and kfree via
> __free(kfree) macro. With those two cleanups gone, we can remove `out`
> label and replace all gotos with direct returns.
>=20
> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> ---
>   fs/btrfs/qgroup.c | 42 ++++++++++++++++--------------------------
>   1 file changed, 16 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9b2f2c8ca505..238c17c7d969 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1528,65 +1528,55 @@ static int quick_update_accounting(struct btrfs_=
fs_info *fs_info,
>    * callers and transferred here (either used or freed on error).
>    */
>   int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 sr=
c, u64 dst,
> -			      struct btrfs_qgroup_list *prealloc)
> +			      struct btrfs_qgroup_list *_prealloc)

We don't use '_' prefix. Even '__' usage is discouraged.

>   {
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>   	struct btrfs_qgroup *parent;
>   	struct btrfs_qgroup *member;
>   	struct btrfs_qgroup_list *list;
> +	struct btrfs_qgroup_list *prealloc __free(kfree) =3D _prealloc;

I do not think preallocation is a good use case for scope based cleanup,=
=20
especially when there are two similarly named variables.

This reduces the readability.

Thanks,
Qu

>   	int ret =3D 0;
>  =20
>   	ASSERT(prealloc);
>  =20
>   	/* Check the level of src and dst first */
>   	if (btrfs_qgroup_level(src) >=3D btrfs_qgroup_level(dst)) {
> -		kfree(prealloc);
>   		return -EINVAL;
>   	}
>  =20
> -	mutex_lock(&fs_info->qgroup_ioctl_lock);
> -	if (!fs_info->quota_root) {
> -		ret =3D -ENOTCONN;
> -		goto out;
> -	}
> +	guard(mutex)(&fs_info->qgroup_ioctl_lock);
> +
> +	if (!fs_info->quota_root)
> +		return -ENOTCONN;
> +
>   	member =3D find_qgroup_rb(fs_info, src);
>   	parent =3D find_qgroup_rb(fs_info, dst);
> -	if (!member || !parent) {
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> +	if (!member || !parent)
> +		return -EINVAL;
>  =20
>   	/* check if such qgroup relation exist firstly */
>   	list_for_each_entry(list, &member->groups, next_group) {
> -		if (list->group =3D=3D parent) {
> -			ret =3D -EEXIST;
> -			goto out;
> -		}
> +		if (list->group =3D=3D parent)
> +			return -EEXIST;
>   	}
>  =20
>   	ret =3D add_qgroup_relation_item(trans, src, dst);
>   	if (ret)
> -		goto out;
> +		return ret;
>  =20
>   	ret =3D add_qgroup_relation_item(trans, dst, src);
>   	if (ret) {
>   		del_qgroup_relation_item(trans, src, dst);
> -		goto out;
> +		return ret;
>   	}
>  =20
> -	spin_lock(&fs_info->qgroup_lock);
> +	guard(spinlock)(&fs_info->qgroup_lock);
>   	ret =3D __add_relation_rb(prealloc, member, parent);
>   	prealloc =3D NULL;
>   	if (ret < 0) {
> -		spin_unlock(&fs_info->qgroup_lock);
> -		goto out;
> +		return ret;
>   	}
> -	ret =3D quick_update_accounting(fs_info, src, dst, 1);
> -	spin_unlock(&fs_info->qgroup_lock);
> -out:
> -	kfree(prealloc);
> -	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> -	return ret;
> +	return quick_update_accounting(fs_info, src, dst, 1);
>   }
>  =20
>   static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64=
 src,


