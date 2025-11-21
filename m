Return-Path: <linux-btrfs+bounces-19256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 353F6C7B903
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 20:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F5734E8949
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 19:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD029302CA3;
	Fri, 21 Nov 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QtVfEH1A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA7C30214C
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753929; cv=none; b=pDcwmAgWu/TLU67Et7OF/1zkdupSg3a0Y97cXk+OoEVsp5fVpoQphbgMxLo3qRqn/xciM1r0M2mYFGQ15AV2VK4j545PHZKi+cEVF9iWL7+5emzTxK9TOVbxqRiqOdRXdJOtrnoPlvAv37yIUtRQJ6diRX/ml7ZY+L1MROUiZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753929; c=relaxed/simple;
	bh=ZDqdCHi3NfGmzhvNMQ2/047nzPgn9tJWv8gWu2Bn0kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bzSBZbSM72iCQ5GET8l0IC85Arvj4Li5pgW/rykUhhSbvk/6mWceeFtIfJna2tbn01YeVh9f5yuITCEpgtvbS6LW+FUrBlIRCWn3BrvLCNCv7Qt8aTl+7xRIs+N/+OQY+ZRMgWG7neKDJD8Am1EZDaqlmMggFU3thRF4gb7MiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QtVfEH1A; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763753920; x=1764358720; i=quwenruo.btrfs@gmx.com;
	bh=fnVB+qvLRGYEcDXHZIwl6TWJ/lZXP0JUbeC2igzC7b4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QtVfEH1AVZ/KUkHJeUANhDNnyxhaFqWHHR5TjwFM7MRjOdv6E34xNXE/ysBIMWXy
	 DDTchekIKbtJKKcEGWh59bPry4DVPNMMb3CVlY3GcuhW/MoHxbSqWBBdUSkIarasi
	 XRiUYIm/WXb3+p+BixsE5y3dRLIZV68F8gZ+TQXilhkkIwOsdpYE3shbC4DSmU7fa
	 4nxY0Bisefara8tRlc7RkpFuH+7TGgN9sfnzFoW89VSR9vw7jvxquIbQqpxVSISxT
	 FdDzHgG/un3jiZV5MwCO5GzCxLS0Au7iShCvOPdHcJFPP1BZGhA3ByMClnvYXxEze
	 eYUY+pAkIaTzWbt5mw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5mGB-1wBot222X5-011sr9; Fri, 21
 Nov 2025 20:38:40 +0100
Message-ID: <56efc3c4-4401-4304-b24c-2050b67ddb67@gmx.com>
Date: Sat, 22 Nov 2025 06:08:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove unnecessary inode key in
 btrfs_log_all_parents()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <d52f0087209f98c146645cea0fd3f1ab29d29a3b.1763745035.git.fdmanana@suse.com>
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
In-Reply-To: <d52f0087209f98c146645cea0fd3f1ab29d29a3b.1763745035.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fhbFXP5HvQIXsHmQVdysGCWp3b4wQxX5Xrgbt1W4V2zwOfhkLgp
 EPcuwgdP8gNnkm+cmVUgETB1AdK1Jh7e0Lr/CY4naEm9PQvwMtlhyvBy2pkVNmhW7/ZsLp8
 ji17uDSbFr22Imb9BXV8+wR6LN/n8hobszmhZQdgj9O9ZqCmiyau5sUAQHokfb6qMulBMtV
 oJzrGlYVteRBOy70tFa4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ro/OnpyRzP8=;obPLVy5ewMhJ6z5Z2XOg5eF3P/b
 jYQX15GiR3LDG2WMBWEgMY0MeLBETC4FDSMVOz8RUmnCoH3GuSg03ALX0u6n2g1HBgMbp2o/Q
 b/Kohd8Gzh7fYNxK02eO69MHmRDYaQ+lKHT0Hc2EUuedgxqentsGGgBiu0uxBAG8v389NUeZX
 olUdMEJuQCKALE1GUa1kA13SfFu/br+Nc/Ea6Okquo9U0r1f7nywDSVAAquwf6JazckIBU5Yr
 bTP8JImmz2/rTqZheZEhjFduNvac4RNPDphM9Mn7DEHgYNtsIxlCrqY5erjlOhVQBqiI9CU2X
 swMyCqdZh0Z9kCCbjm9OnqCr8T4UNUsdf5Wjb5hGjNvUvw7M9wslgRwt7cYbzkB1YSwnvt1tf
 7odF29iy8WJgqru8/qVWmWKz5tvOGti1O0cTVMkjke+gMnEqipHbskRP5wc2b+j374qf+1n4c
 ZWuPmFg0MyVgI1zCPko0vY+5tLUDXWucIvtPkO2TIXm0ZQ3jR+OiyAFS+EgrfqLIz8FxXakaw
 FemgnTpLm1yWwHG7djYETuDt08YHw/XZ3rqGI4SYklP+5w+9LKx2MAe/+7AVdRAyDHmYeBY2f
 JoXwEIfv0c/LIlz0jYt8GjMC4Qod3xFIx6euSkgLW7lLkRrdc6TMv/UuhsQTpTKtasE5BShVB
 jcjU1SJ+dNSksWoIv+mCtaBHED4rhr4ztILglOWiss/riyd/jafw9CbOeiX9r3t8T9ITZ++id
 biifdtP3K09f5i6FtCD42P4MfNvUbyf7N2mjEsXp5k4ySy27aTFf64mVrvW8euP4CkVHyNRJJ
 MlyBdX48WXmUV2h40wmSEM++UlXDnP3enAHtn9Hdyci01s09xsmwf6uKKWbPFXxgQYN6+UWMk
 vCVCXRjQDjvCe3d+rS6fJhT9JiHrL2aC47rglbQCt7PYRTzuiE6MhmwMjroShX7/TdygPo7RI
 XyjNPrvWS0DYPLu+tax+cENce3EgCkWpNBZ4HoJz74z6uWvXMTSnRBUO9ZWQtDiUVBGKIpVJT
 6czxq/9u/nEZINXMeXd1Uxsz3OjlA4UUmAIXhIEqSlIPKpXvQOhlwsGNETkwMENcqYzM2yK+c
 e3VOfGrd68W/wLST4Z81LgztgzkU/MYdFMVl3rofeeJiHJmdQqR2+bV1AsCv95HZWRQpwyRNb
 CsIaWV8rsLJwgwk2rWsc7JJMuaJftxLkcKdABXMhsc0oydjczuMKnEVc9/svbWGWio3qgq5tv
 Hy7ju8TC+Y+heTX5jecTeK9qD8FB9W6PQ/HNTU8DZKZQFzeD4R1KbY6UkY3eIiramUyPozOYe
 mmZakGe7Vsoy/l4eufAy8Jd+muyEoCLPYMeWZ69gRr3DaOh2eYGvuuvqVc6zbrqoBMkCieAza
 i9D2fLN+F6q6sPLUzis4ns3m0J0O768th31eqJo8czhOOXCypP3tBwgcYYnr3HBjL3NmihgW6
 8uhuO2pUlo9jacLkXxZCL4rDeFtJ1wXQkuiKud2ElLhOikWthhQF5o2lIKT+MFnLewI2RmDVd
 On4dvDQ/sPn3ljOcUTXs+oN1bBuG3kivRHSwYQI2dTFZqLagUeB4tCOMeXNdsYgod6s7WAdSj
 qwlfv3cvhk0+TrbXG5WmtjtVcK0Q2EsF6hs4siDUrmwH6AZOexm1JTy7Hn40bN0rEJyn9yBqS
 7BZf3oQgNoiXreBGAtb9haf0tItvDjMEIHCBAH/hdaH+u6D57gWMb1YUZwgMbZn1oQ+puO6yh
 zY9R4WgjZnCIBHm4AY/oNhtzh/9uTEA0Zp2rMjIyzLAMx5x8AI1GFyRWWvEbhknwOi/7W85C6
 2d60Dl58wuUYdtuZoJ4EFALQexUREqppNTZ6ZSj1jrHYkxb//0eUU9RgBL7K65twCS2gZFYYb
 YJS7i5kuARNd/Qln4qsjsauiXnSCSQTRtaFCSd/xh0cq4JIiTSoeRCX+CTn4PnQ3sagEKIhZJ
 3G5NU6nwD6+5cnkZSSC4pUQjqZvs0PNEUL4Se/Frma6uRsXkoI+Y1lCzBdC72VLfFbkMpef9z
 CfWHtezvb+7htn0jxZEu9LjDz9y4oDdBRmjX3INvrkeNia3U9sUu1ZCmYZTLV+nYsdZMP83KH
 n74h46ZltN9w8VShnREQlPc9eDvxrkGr5xLcuHmwz6msJj2uyiQQhBAmfag0F1+BeCjAJlKUb
 psL0t3Fl3WjJQaJLp2ytsgI2YGUZ0syxoQBvoL1VHdBwxaD/vnKG6bpz8e2TjUAxX1aLvyoEK
 jt48lEZ40GzNs5Icsnuw2ZFMq71x5ntcorcYEU/xyqqPfKzAj7HW148PN+i/5I8kXylNS2WAq
 uoJWhUvuWm0p49rJHvFXDL6JK6Ja+JGE/Rt6bTCEGJTM0qW9Xq+pPvC+pU5w7vrtC5g17Parm
 tQLTnLWKuBQVFrQDd3tvLHcCAVYgQuKMPPtLVeC7vpJ7K4o4feR3m6rul0NVkI6TwP1IBGv4v
 +LGDLN/lUvOa9VJEBR0TkWJzM4pjwtJVH+qDnNc0ZdW9wTmr04nbB0iBr9EOiSMQmL95f60US
 pMcryQxSdSuRNFPcCZl5NPoyS3kjZR2H/9OGFCcNJ4U3mOUREpT21yf2R7E1QqSgyvkulOVQH
 nHcnEDIycFG9f/Bzgb4CEQXAsQot/wI94WhKxB7p8ZdatbOG/fIDdO0I0ri9Rzt8MBXqplqjH
 HIwyzBIZf4WVEQBT72HtqDVl5v+P0trN17OQWgjL96/IrQIbSW3SPD7Zb6Fabr3lJrnBtfJd7
 JB/RT7pM0fSPgVqQ/1mAj/p+zVQ+FQwTqM+ld+JqQRrK5ONYYgLoJV3WiJFxsdMFnT/ICub4i
 SFRm5UYvveAz/djxOFUz0QLVhVAPUkWDncjxLs9/81DuR5Q3tXlXlaeLWciwSpi+M0dEfXhAm
 YcS8R/rmdir2QP7SZn1sLzxVa9FekPO78vIXbvcTQrPY7DtUGvCsDa6cwELIgTonyzNvr6BSA
 0AAHCW5RCCyoHpTIme6fzdsPgLpykbtNjrjRMeX7qrlKLYJEAGScWkvLdm/Yw+7SF5j4Tvq7Z
 PfPkI6B2G1SzJmDXqNttGSW5aWA3Es1E1FWMzS979fIFGr8VrXG3falh/t6dmIfDZStCeBGuM
 12JgNz0P4TzSs9HPGANzhkq8zlnqPbcyOA5HwZpcmeF+6tSvvNt7s9jnKy31U9Zi7bz8yPrgl
 BPBddkbk8J9hCzJZbgnPpB3zktYz7QuZ15rbLg9v1gOQjr9jOi5dUDuR6fT27KwsSAtHRsp0T
 GvxOnrqsxyuMfAKFn+iVDs8n5EYus7TVCgVUNdYptCYHQ12/kGWiA0E2SZoHYchP/WpVDHtpH
 IXi2kykCB6ViWJjmWuFIaPlvDhbwY6a7VfChCczIcAXvSasaJh+E47ci/1vYeUragX10/qAI6
 uWd34gVTEe9QkO1z++n4VLLw9hMMraVkzQSPsSYonYqbIgE4iH4QokjZ31ZEUuHWvANW1H/8O
 nLcmlu05qUr9syrlIQUGSRcIDFbod2L9NWdQ5mBF/fKRd7RmOGL6CiGcIYQoS8VsdpOet40z4
 qW0SO024tBBsKsKk0ZKnhO7ZKMMAk6Tthp8l+cgTHmR/A0tJUGA+/zJ5Tq7W/a07ugsRZNWAn
 xfMAwlewFViqqLYgAIrwI5O5MjaMbewMa5YmgiKdGjVd2xyKcPEueRQ5F/8ypr9sWuVgYJwiu
 UjmoXHRrquQjPWNTjwcEYueazlVTWlHQZWW+c3DTJobPptFzBEdQF/KCfjqU9GmVpsaz6o8ps
 YBK6GBIvyx3Ulr899ZAnPc+VP/6EHfaxegvvEyIWL9ATtz27aujBdKwTet1+++ZYE1vcMWPUG
 2BK4vaDlbGyQKgSZyz89Cb/w6LNKmesSmo9Xk5znCbSTev38G+09Z339KpplcXHlMEE8qc8+J
 L4rcdeZ0G7kgfeRfcQVgWvs9ecxnddeQl/Vy5lqlm7RKqwXlQvMW0pCGHsX99LMB8z9HWXzB3
 xe9TUIWlgVrn99fRkKMaztzaOqUqpeaUvr4Jby0sWHfrMTfiv38Lt1ctrqEBj+2hrpkFN0PQn
 khcijtN5rG8/vjxw53NTZi8JR8e49oSB2J9lyqs9RgkHVMxpAbK6z1idUQY2gbsavgQBI4n8b
 zW5v6BKUUIuWjIyLupPgLbXCGQESdrpwZWG873nW/D7myr64tgMvp61r9fcznB9LdVGCusCTR
 sT0RF7Vg6E6tExo2GPY0IhcFOKLsq2OffUUYdS/7RUy8H1Lv6gURBu7Qdupcnh9lYEJCaxeU3
 gYkK9LFRLp16jUyxpo8NnMHLUss6oWASU5ja3vPlqkwwOPNPPaUmxZ/lm71ZDtfEK0pTcEJjC
 SDXjAqj1iNs4qVYXbpdft0FDbPVsM0rE09e/B5gysGPegft7Fj1ODfzb2QhLq5tVlf9iHV6kT
 IwkOH2kNPDuGbOPJeav9PY5dDf81+r5gJ0MuN3AD6gzUA19vBVcuDhsdNo4NwH09mlHL8Shwn
 bLAmVi3J2TS/s9Pq29Euwn2f5G+Ld98BRt9YzLBVMj82FbOfqgi/4DMgY1a/Nx/2Ye2mcZiwO
 ooPbSGTb3s8a2+d7msp4X6UqHD3NokZOTwBTvFM57e6mi2C005Y4zCKjBSZCigLraAltDpwwd
 YGG06lKQuYfpvE55YMzHMaDgvwTwLsc6NCYgKUgpeMINneS+3oPNY/RpwHM3xAkQnCubMkGnY
 0PStIjwksDbhNr1talBLMUe8P93NbfCOvkCA7VvmX28heGV3pP2+yO6GkLYpft55yqessTZv3
 6XDrgc6PXIeNMiZcBEz4Pi+C9iz1o49caz4WTEtelJYB8tMY0OJfFRlniw3A63nnJU6G8pCLv
 OCtOAkqMnra91eMYM/VZD80S+5qc26p7EUD+Srp1hkS/ZZea/BjBGhzDl7fGBaUSVI5tEa4wS
 T5HBwFXz41cLz2iJKtW4DdpeR5I0iDhxTddGkpiK9qRdH0Ch2GvpKfBWQE1hoEhnd16siUnWq
 hbyUAkQa3mE4x08ieZLiUW6hl63SC6oeARExKEopWcldX8x07GzNcu1E7DiIOBez/NAv7caOi
 5LPBzg5O3kSbf6cDpONSxo5giuHlLec4bU74AiNi/0hThbHowLftCRokV2J1hYUYPGpLv3m3r
 q2c+DeXb08olxmeUc=



=E5=9C=A8 2025/11/22 03:54, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We are setting up an inode key to lookup parent directory inode but all =
we
> need is the inode's objectid. The use of the key was necessary in the pa=
st
> but since commit 0202e83fdab0 ("btrfs: simplify iget helpers") we only
> need the objectid.
>=20
> So remove the key variable in the stack and use instead a simple u64 for
> the inode's objectid.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/tree-log.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 42c9327e0c12..4ec6d7b52a53 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -7203,28 +7203,24 @@ static int btrfs_log_all_parents(struct btrfs_tr=
ans_handle *trans,
>   		item_size =3D btrfs_item_size(leaf, slot);
>   		ptr =3D btrfs_item_ptr_offset(leaf, slot);
>   		while (cur_offset < item_size) {
> -			struct btrfs_key inode_key;
> +			u64 dir_id;
>   			struct btrfs_inode *dir_inode;
>  =20
> -			inode_key.type =3D BTRFS_INODE_ITEM_KEY;
> -			inode_key.offset =3D 0;
> -
>   			if (key.type =3D=3D BTRFS_INODE_EXTREF_KEY) {
>   				struct btrfs_inode_extref *extref;
>  =20
>   				extref =3D (struct btrfs_inode_extref *)
>   					(ptr + cur_offset);
> -				inode_key.objectid =3D btrfs_inode_extref_parent(
> -					leaf, extref);
> +				dir_id =3D btrfs_inode_extref_parent(leaf, extref);
>   				cur_offset +=3D sizeof(*extref);
>   				cur_offset +=3D btrfs_inode_extref_name_len(leaf,
>   					extref);
>   			} else {
> -				inode_key.objectid =3D key.offset;
> +				dir_id =3D key.offset;
>   				cur_offset =3D item_size;
>   			}
>  =20
> -			dir_inode =3D btrfs_iget_logging(inode_key.objectid, root);
> +			dir_inode =3D btrfs_iget_logging(dir_id, root);
>   			/*
>   			 * If the parent inode was deleted, return an error to
>   			 * fallback to a transaction commit. This is to prevent


