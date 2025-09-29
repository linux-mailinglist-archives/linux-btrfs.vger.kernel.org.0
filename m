Return-Path: <linux-btrfs+bounces-17272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AF9BAA9D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 23:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194C716B026
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955C320297E;
	Mon, 29 Sep 2025 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kTF+mEy2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279A192B75
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759179609; cv=none; b=ghjfiBxeFpRnkX+DIMFDyt4pjSpgaiGCqA9iZynZVluH698IQFF9BqfPM7tJmuFo+Ao8emaqPUz1onGKuHYNK14KFSnA0uEVJni/5lW50WUzxNQqtq9T3ljHQbI0c8mjOVpQbw6Bf3IvOFvClzEKCJt0JTEqvZdr/92fFm9z/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759179609; c=relaxed/simple;
	bh=mZu9mvrShzAX2euK3X1BvViUXvzHKbcLY+Wcmxn6VXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEHCqmIdUgKNL4bgvowN/N0ZxC3gWeUBe4tLkpJNhg8e/8GXmvQ8jI/DQytv6nCJRGhq383Rz+wqp2XmQDFMDMQFlZGS6HYy11xHh1GqLNmCf+3GHZn4tyC+/av328uHrfS0atfS002graoumbMovQUT3sHDgX1FOEww9owDJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kTF+mEy2; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759179605; x=1759784405; i=quwenruo.btrfs@gmx.com;
	bh=ayds8sU/zdrB4dgCSHAJUJ1Cv+icrYljkaSOqSvZq6o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kTF+mEy2uKAIpD0v8YRX7hga2+m8qc8WH1C5BP39vALDmrn8DOH4sRw5ImHWkRKB
	 hEDAPqTlII/+fhkiD8WYFm+MBLO7BFRtcemx2uA9xnt86Xai/8sRVfm3Qwcpmr1fI
	 T5VRs1fg2kC+rQUYC+5lMk0QDKgQqJo1K66MI0iblmHGPuFET0NW9lRN1fwzTqBC7
	 5ri6xJRiIFjjHj+pd0zvJcYVUXNoqrqQKKudfkApIUSNfZi5EnXjo6Qaig9cqhNjM
	 l4bWcScVJJ+roZUiDJsvnM+ml1ob2Wey/EIARNkHKZ+3jpkZQr/8h5e10xa7cLkkv
	 kLyvOrXK7eev8I9oew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuUnA-1uBmaM1Sks-00w5Qs; Mon, 29
 Sep 2025 23:00:04 +0200
Message-ID: <2bf5fa85-000f-494e-9a61-566b739c2b7d@gmx.com>
Date: Tue, 30 Sep 2025 06:30:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: remove btrfs_fs_info::leaf_data_size
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <635a605be3627ff476d47620f195a74fe5d634a2.1758934058.git.wqu@suse.com>
 <CABXGCsObwh8TfAAYhoFSrgKsC4EKdi5tryThQgTgWPG8irwf8A@mail.gmail.com>
 <c54510bb-601f-4180-bc36-62e494fea9bf@gmx.com>
 <CABXGCsOOtX4+f0P0Aec=Me81bwGLaL37E9RZCyEmkQXv3qKb8A@mail.gmail.com>
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
In-Reply-To: <CABXGCsOOtX4+f0P0Aec=Me81bwGLaL37E9RZCyEmkQXv3qKb8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M3Hjgbf9juP4vAVLlKodjkC7uiBlQcXzu58BDp49/Juf/yYtKHt
 o0bsP5ZBA0ve3Rs4SFsrTadBNWExqp7dtdbYOMirgeUL8YpSNdG7mnBNx21Qqn7KbhJW+92
 Z8iDbtg/uQPjto/o2eoUJszbg+BwhvZjxXUuI2KWGTueOZxol8nnv1C7zRfj5lxQJBH+hUH
 j9Js30gPbiWnfxka07+/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6xwhxG0wn9s=;DtFbTOHiJQ9cS/3XWzbzJD8zUEj
 pjTA2DoOPbMwa87vunw1oMmI9HUmbFhyQG6xz2YMPrfMuhPLPTOFDQc6kzotMUSbX1py80ErM
 +mwn23LU9lCDvIKGOcrsRM2DuBMOoy12Rn+NhlHO2VkzR7IPyrTHdcJgiPQjzWsqOj2eqNFeT
 ZLj5iTLIqPsxz8k0c8saQAxrOFVaf9D7GH9FMtQ7RhgoLB9wdfsc3v2Zm9XWZ1ZwneR6DMo6D
 j3jWBFYO+liedxkdxBgfd6fIWXRGV+kCnn6Dce9VeruBUziUhbSmuPkSHUdF1uUQlKny5a+mv
 qXSyifve0D/K30sngH31SBKRQ7X+WWjMpvT1QeH/KGn20FutTEbkavgwFboPc3HcFvboGkxE7
 5GwmoSo5v9VyDU7t21VYUkNpWyM4HTicqRjc7cjIE8jlLaH8aoG/k7Gb6P7NPQ5xZYD8hZi4o
 ZTBpFz8D3L8nwnXTGu9K40kxFwh22S7GhpOrsLe1yeuCt2Hl0om+etjsq9TwiIQNk3o97/c77
 CkLCAV41A0xr9K7TIPWRpGlGBz7s7qZXP+4OWoNIA5pPCC3dTEFMYZNqTDYW205ANurqoSgsH
 CGTW+lp24g1/VSnA4uH4Ih0iMQfDAo+FHrjpDNuUhB9l5nv5rclLFwsvtmf6rbwbhSZMy+gN0
 /NkPKhrkxHPJci018lgixa7LnEbq0fAy+iUuRwY2F+tE4Xp+nFHPLpmieVm6QgmnNlr2Mwuru
 ubRqPBFTthUJlRjqC1mdAlnO3IIGCKDA0MCj6RmCT+qH0zyUY9Klx7LETYUJyfr5JNv14ltN1
 LvK9ouFJKCH/vSIQ1WNmuASNiaBnPWXBPpGkwgOKHwdEojkzpi0eutBhgDDoLT8NAzqR1aA3C
 JzJcRkfWU92oMYP8l9eWCpIkTJljJ5kepDrT3KwBNXP3PGFtwF62rqhbzpjBEAn2A7tamQ8OW
 HjIxJEqWSyatEjRuL4++y0FwLdRbvW6eYBXz7MRvK/ysyFMsYDotKiOvJDI/Oni/S5+eDyrDr
 wls7AXSAJGg2VPAQ9Gz3gzXcR1unAa2t37KwzwnyAKxTyjMwUZobyJ93Udf3dzjtrGuGSTYWp
 k+UcEu9RdDO6YxNEyDhtobCzj+zjwS/KYBWs9ti2/uF6wZvIaihQk0xE7TsHOoaeXg0EIO2bF
 dtvRKc6cRrnHHyW2GJJK8ajIt08YQ5r8+OEG0qQvt5oQgiJ2tEeN3edmnu+vdjmVeWChfXnLC
 blaeH34LzWnlLf0LNysNmo+TG3ewORqaV21U357ZmZxxcSape5q7DI6TXvT1J/LQ0EhAyQYDK
 6RIDrVYzyyl+dwcNt/GXnyqFZDAN3Rs16Xk4tJIxkVEsNKQFj3x/pMEQAXbUWgNRo0PcOkten
 IGM83XFoo3G1shm2tMzcoS8aJzo7kTCvj8MxrIPIMmuhAxLKCO7j6byIWUcOhQ9dU4AnRJBJb
 mj+2p5Boqu/M75qcE4RWU+xX2trABOZZ+2IAxYhPCLx3koCisJ24R/0JUEc8+pQgiUc5KsOOV
 8eC+d9lfcjEV201W5vSb0J3MNUbC/9yohfKSo+XOiL46sCD1YsOyInzssIuc1RUQP4ZG5uqqq
 NI7UPQ9j9kCNBoplW/icSgTMyXP0tTt+yT7kas+LbFtZBV08hv8D7sjxGIurwGtxJzFScKEaE
 xED/yF7vUFP+ZsOQGV/5rNc2lOb0AsFBeTeAwMH54t3GTWm8fu5jSPU6YirfWCJPfCfGGxzf4
 C/Z325Gx0FqEfXXjFdTqjwoKKBbplqDzaovE2I0zxkyf31V1C40gjw5hW585KgS7ZrB2W7MNS
 cF9e8Z30g3euvsKGggtKziAEs9Vm7ECuPN5Y8UTaZFzpMiSb5nXqlYScBJZCJsB0tYW1vi7aZ
 6v31XoieOlVEo3f89BXNNf6dxmi7yonlIklueIwAPcNN+NrvxC1iPdRlBPeubfyWtaVqNX93d
 F32MN6OVmhYPQ4bhtES0Qs2vST9fPYpqIlXhRvTdS0SnSxs6TH3Xg8fSFrZ7Ox5eqhO4qqest
 B4t9EZk32AQkkW4TLMLuuhfmeBhUjJgC1lyQJeNQjYXRTk6Lmhu9Des9q+TkBygqo0I8SldeJ
 6O/zg7pqnFLUsSU4sI0sSORlZbkSChO36sCX06GnN386d3GFHUqBktyNrCLALnt6jWv59EnmN
 5dD1+0sy4p+6u9lulZx3HfUfBJoKCRD7mu1nE7BWNW/2Y9+XV1bnylpuqzLgHgG7b7RlfmwJp
 N5pu3EJC7hEaaTAlSNWXhX8nJZeqcwUgzXacPa7aSzAYrPG+bXKqTfNYLsfVv7KZgQL17ZR63
 tYBKSrsMQV1N/ggkTlrH8L+S9yT5z50yBuqxij1r4YVfC0jZ2a1w2IPRVNDY4gfEOFdiO6LFG
 3BMihNs+qyknSCtIonuio6chCiesEI6tgeKSWg9JIfmndiIHGwhnGOUbLJJEokFBmLCPcXMzB
 rv+qb+Fg10czyI4Y/XIMotZ3kEJHmh7X3H1ddV0vuhDYoYLr6wS4TP0hJgd8v5jHuzRpvaxxu
 sju+tmYZFANgRiyi8SE+63vq7tepHwrZxQM1+3UljTmr1cT8iWdFf1PaEtjIwjFTRzdRRa5Fv
 iCQxfOTqlBB3KOUHVkEfv1sVSxtuC82SNS164COwfy1kMQZg1COFerOu60bVuDaH9N5zHh/p6
 kGLEsW1yO/2BkX+WRsi/bjFRZCRPqAo4/zK4O2x8BbSAlOgsOJ8WkfF17DPN/ijSUaS0sFl5h
 WGWvW+vFgqdizd21oQFcd4lvLZWvKULql6K88rEZsKYhUVxg5QJceN9rMnjUoc9NBstzGPRAJ
 u9S7/uoe2Z1XZx1v+IWSzJ1W2bHibIMNmAqx3CYOobU5UusFRHy+SZlVwqPq0h8xSpPi97oWq
 qF7O15+g2Rb/CgMgCI0oefg4BwfkyuAXgOpPi5b+C3dXYlGu6QLlVazTBIhzgozEiJkFT8321
 J/lLETJBjMUB0G8traQzaWEJH9Nr+P4iXz7YGOOlNRE3bK3HzCZGzgVIrrzG5TPeEDLAgkuyx
 cQgPLodVEAbU2cfvOQxSrH1IBTcFJgIW7H/6QSOv39OXmSirWToNPF1T21QAjxOG/1Af7y+ol
 Xj3efSJOawwxu6F3Cruw4BQKcOcWboVh4tH5b1gqpfQiqLCSIw1/r8aPfeyMSGmnVCoDLptgv
 CHVbHz445bcpFnkWNedBF3/NRiONOg7duSSaX7WUD3yYpO6bS7pXz8sQ3ThtsSHUD/U0guZo9
 Xdd93FXReemZ8wxbJMLNoGIaJoXAP4mfwF/QVXR+4wPh5jLBlkhr/TEkY3nAYgM1dJILr3Pz/
 8U5+5ZAsKUgtfFvWMw0rja7MnC+2q9zfMxEJATeK/2q7zSJjymKOPFHoYrgEEsJbEWIO0AYmu
 EtDoi1cti8BmHpQSxzyBxf67GDx9Cd0mP0ufF85mFbQAchNLNdTmW7G2A0AjkBQ05WiWsnj8U
 xuRr6IKnPIYO6BdQGNfFMcYOV0LlhDUjIzub6szW2COa298n5WdyABmr6FiDpJQkmKGBC1+gk
 urDKPgOcNlQImC1R4t9vsBb+JWm7kY84+SiOYjomGfwU1og6hlTe+5O9P4a4U+4NahU3T9rU+
 Bil0qjgQEsCK1Ht3cXg/WZfAADo48fXqNzA0Tuv42TW2HTb3bRxsu9F2qobW3q27A3QPSyJRS
 g5EVOPcHlBd6/nJwadOCoFJ/LV0FhQqU7ER70PeG9sYHpcs0B4pSr4erjxVvTunNtNOIX5aaN
 GSxT7FQMDXb81bmYwJ7TRPQhqUvx7acjzAv5pIpr8BNuC4v6GCve5Wf0O4+RJ0xe3quhdsGOu
 KFW+Wag9aH+1d/Ih79MJJ9xthnzxpBYTQdUzlKXQ2cDeNpkDgyZLJkFboBGrqDng2EFxLN/WF
 XjzXVEioV7CHNKlcVYaCmiPuLFYQb0XlVA24tW1Cs4uo5y4J5aMFuCOjO8OsXL+x0VYiwAPLB
 oF/IQCOGNpo9ZbVQpTsigsKrGuqbqUiiLQp7RPCPgsPMQXSiXzPyDOQ52QDq8QZs3GpkMbGDO
 zAcNmkUIdKsfHsA7s3JTTHCYXSm8+rAO4iO24Mf2CSzt0NoDwv2IFi/6rufDlz8MuVmidMB3j
 cp3/1ZCaDRIj2DdYreYFbjEAKWcg/VniPJO8MjDgaoSGGR4kXZZjOFPQeHnZ47leoBX0CJLSs
 HEnMOFFMpfdA/VKBl0q+ihmRkV63zdwhPyMXhHFaLWQ1gKp6+WO9+3NKv5i7P90ySlpKMHy2n
 nJtkHLdtgium3v1guaNl9IVqG/ux2VJYj/dELvXsPc6pX58rcUCuY7JTvMoJo+xqyYibmOi94
 iwCItJfsKdMra1xHXa/k7ECnqacLqxzHCIzC4MS2MZofHig8f41xfJAB4g2YGrI90ZNCtiHlD
 +UtwNmvZAqBg7lk0hI5P3dcmjQed3MaBSM/LApyiv/61K5xtZ/4tvFdUw+5ewjM2NAunsjVJN
 YPG6TrUNtD+h+nLdo/gSNVmQGSLVTSWP2bvn9uPqa/Df/Fc96R066PRI6i0XitmoWO+YUGC4u
 xouO3YQeTo1HMIyCB2SX2nkNBc6ND1wPORKEa8mEEgSdB8uDPiTtZaxiQj+EWXfyPC5FfSGOx
 lKbS10G9gRM4WYLbe5rJpdVTTZzNTj//AgazX8lwTFsMLGIqkfbrTfNWL7vrRWwAcWubtq99d
 VafDGze44QAF2qyzY4uZSiBIZY/jKIV3wd9hme0+OI01db55bHlqB+5PbRN4E2FQH2nbnZyKa
 tnbFeFnero1Em8EiiNJcua20ucTIuZe0H0GlGpK3+Nb49UADXIUv8YAfirxCEZMgjQydLgVBo
 H+Q+LRad4QYk6a3oigw1bfj7iE+jT6M5KDOtJTbLhUq7jQWPO2UskP99mrhaKhzE3uRdkl5VB
 g/c3/4Kc9Wp+RVGNrjFrgmc1Kwu0K9ImWIp6W72OwVzUONGn56ibpR3/TlRf9AhZrvvbXMyA9
 O9sEMbGLoke0U07Who4rnaZGRaybkrQiS00nXay7nh8LPKXBccWZgRis



=E5=9C=A8 2025/9/30 02:08, Mikhail Gavrilov =E5=86=99=E9=81=93:
> On Mon, Sep 29, 2025 at 1:51=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>> This is weird, just as the error message shows, chunk tree leaf should
>> never be empty.
>>
>> Even during mkfs, the initial temporary fs never writes an empty chunk =
leaf.
>>
>> Mind to dump the super block by:
>>
>>    # btrfs ins dump-super /dev/nvme1n1p1
>>
>>
>> But still, this is not a big deal, and you can ignore that.
>> Tree-checker just rejected such empty leaf, and the chunk-recovery can
>> still continue without extra problems.
>>
>>> leaf 22020096 items 0 free space 16283 generation 1589645 owner CHUNK_=
TREE
>>> leaf 22020096 flags 0x0() backref revision 1
>>> fs uuid 95e074d1-833a-4d5e-bc62-66897be15556
>>> chunk uuid deabd921-0650-4625-9707-e363129fb9c1
>>> cmds/rescue-chunk-recover.c:2409: btrfs_recover_chunk_tree: BUG_ON
>>> `ret` triggered, value -1
>>
>> Since this is very old code, it lacks the standard proper error handlin=
g
>> nor error messages to indicate what went wrong.
>>
>>
>> Mind to try the attached patch and rerun?
>>
>=20
> Hi Qu,
>=20
> thanks for the quick follow-ups and the second patch.
> I=E2=80=99ve rebuilt and tested it - now btrfs rescue chunk-recover comp=
letes
> successfully:

I believe this is not expected, at least there are some writes into the=20
fs, causing some older tree blocks being removed, thus it passed the=20
chunk-recovery.

Anyway I'll polish up the debug patch to enhance chunk-recovery.

>=20
> # btrfs rescue chunk-recover /dev/nvme0n1p1
> Scanning: DONE in dev0
> Check chunks successfully with no orphans
>=20
> For reference, here are the additional checks afterwards:
>=20
> # btrfs check /dev/nvme0n1p1
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p1
> UUID: 95e074d1-833a-4d5e-bc62-66897be15556
> [1/8] checking log skipped (none written)
> [2/8] checking root items
> [3/8] checking extents
> [4/8] checking free space tree
> We have a space info key for a block group that doesn't exist

This is a known minor problem recently exposed.

You can ignore this one safely for now. Future kernels will address it=20
at mount time without extra user interference.

Thanks,
Qu

> [5/8] checking fs roots
> [6/8] checking only csums items (without verifying data)
> [7/8] checking root refs
> [8/8] checking quota groups skipped (not enabled on this FS)
> found 17421781766144 bytes used, error(s) found
> total csum bytes: 16988862144
> total tree bytes: 24937299968
> total fs tree bytes: 5389139968
> total extent tree bytes: 737476608
> btree space waste bytes: 2778325600
> file data blocks allocated: 18001721421824
>   referenced 17455888326656
>=20
> And the superblock:
>=20
> # btrfs ins dump-super /dev/nvme0n1p1
> superblock: bytenr=3D65536, device=3D/dev/nvme0n1p1
> ---------------------------------------------------------
> csum_type 0 (crc32c)
> csum_size 4
> csum 0x4e2e8c37 [match]
> bytenr 65536
> flags 0x1
> ( WRITTEN )
> magic _BHRfS_M [match]
> fsid 95e074d1-833a-4d5e-bc62-66897be15556
> metadata_uuid 00000000-0000-0000-0000-000000000000
> label
> generation 1591832
> root 13924626546688
> sys_array_size 129
> chunk_root_generation 1588108
> root_level 0
> chunk_root 23937024
> chunk_root_level 1
> log_root 0
> log_root_transid (deprecated) 0
> log_root_level 0
> total_bytes 30725970608128
> bytes_used 17421823266816
> sectorsize 4096
> nodesize 16384
> leafsize (deprecated) 16384
> stripesize 4096
> root_dir 6
> num_devices 1
> compat_flags 0x0
> compat_ro_flags 0x3
> ( FREE_SPACE_TREE |
>    FREE_SPACE_TREE_VALID )
> incompat_flags 0x361
> ( MIXED_BACKREF |
>    BIG_METADATA |
>    EXTENDED_IREF |
>    SKINNY_METADATA |
>    NO_HOLES )
> cache_generation 0
> uuid_tree_generation 1591832
> dev_item.uuid 895e1909-c683-46cd-98a3-598ed4ea0248
> dev_item.fsid 95e074d1-833a-4d5e-bc62-66897be15556 [match]
> dev_item.type 0
> dev_item.total_bytes 30725970608128
> dev_item.bytes_used 18371747774464
> dev_item.io_align 4096
> dev_item.io_width 4096
> dev_item.sector_size 4096
> dev_item.devid 1
> dev_item.dev_group 0
> dev_item.seek_speed 0
> dev_item.bandwidth 0
> dev_item.generation 0
>=20
> So the crash is gone, and chunk-recover works again.
> Only btrfs check still reports a =E2=80=9Cspace info key for a block gro=
up
> that doesn=E2=80=99t exist=E2=80=9D, which looks unrelated to your patch=
.
>=20
> Thanks again for the fix!
>=20
>=20
> --
> Best Regards,
> Mike Gavrilov.


