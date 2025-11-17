Return-Path: <linux-btrfs+bounces-19077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CDEC661C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 21:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id AF6F1242A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 20:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE3D3446AF;
	Mon, 17 Nov 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OXu2bXdD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679ED340D92;
	Mon, 17 Nov 2025 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411312; cv=none; b=kit17otBCGcuJmuNNLgSHth1Wmld6RS3aycOLHLiR1v9+wJO26PSXxJj4x3G9sTVo8uWQzjI+BgL6aJZ7nyh9CJyvYNH9LBYTFu/4nWCSgSAIYQUJpDBQ0szoDl1OXsQwup0l83htcAaOtTkV0PnUjZSeVlkYoFxKx7QjYNHULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411312; c=relaxed/simple;
	bh=IuV+1h4Oq8NbOPKCXqhp07+0KPycf+PJIITiMZP3Nhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T56cIX0A2OyNVJVKIp/9WSVsfwlipPU1c3Y4VArWY4nr1Yk9cmvgVHMqQK+ZjEbCtpZAJDhGd1wxgdgbNHt+juB+uDXhQF+ByttCZfBAIRHrRgE/1SAFxttvJqM/19XYkouI3QckOGvFkASdR6znaXcThYZwnEEgGZuxY4Ia8jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OXu2bXdD; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763411282; x=1764016082; i=quwenruo.btrfs@gmx.com;
	bh=fgtmX0tU1cSmyhuPHgURHY5hRcOu0zcQXZANAYqnoYM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OXu2bXdDV5E1KIz6LHuCO5Gpic3/JvW2KelKiGJwaWOTYpCCRiG6jnpTkmjPtEQw
	 ss3SB5a1O6eoYR9QDgpqs6isXTDZvb/KvMvWFIsrh5vSdtKc4H412UEPtIBLrMss7
	 5NcmBtJG6sj7l4lm8hmxLRVWV/oyaowlMpaeZBE4JzmAh+w9EhB8fMoDqf5PUasPJ
	 6RlN+x8Upgov9uo5oQd5sQb3cOEjqvyDUxXv4rismSCHdRlcFLMCPTtUAj2yODb1r
	 /o0SucJ88jcTHaTc9h3VUcUwHZJesf14fNiMi0qwob05Taqjau1OY+JfyhFIlHOq0
	 VZD/xkHX/7MOaQ6HvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0Fxf-1w7i6Q2yOd-015I13; Mon, 17
 Nov 2025 21:28:02 +0100
Message-ID: <2625850d-de30-42ae-bd0d-5f92f7f2f6e7@gmx.com>
Date: Tue, 18 Nov 2025 06:57:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Objtool segfault inside an VM, based on commit 24172e0d7990
To: Nathan Chancellor <nathan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <0b7d3e02-0609-410e-a221-8e68a0bd89b0@gmx.com>
 <cfc6e0f7-8924-4276-b29c-a6a72ebf2300@gmx.com>
 <9cd36c00-b2e0-4d57-94b1-840b084d0a3b@gmx.com>
 <20251117175041.GA703155@ax162>
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
In-Reply-To: <20251117175041.GA703155@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wCjj0TcUpSma3gIY/gCVJTp96j/ky2UQx6kityDP1R8/li0aEXg
 FTObG/YJkOGcXBasL/TzQqVgxeFVA3Yo6vIsBIQ+vb9/l0GqsgKJeqwFRnGVhbKqtkgxkJs
 aw5NoiYOKZROv6QyCVZFiM3kIkr0yJjgOnn4QOiUQ/FzJ9ENvJCTgmBpM4X1CM2Z4fEhiel
 ChhiJU0hKKRPk+P869dWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lsVuFR/rLjM=;Py5lLxy1piWMjzO7mbfNxtonbYa
 fYUK7btuxR6yvgHThP0GmQN/ALTaUjxn2dg5Q2e7aCEYpKP1xG39naqARE/LDX8Os5+1/m3pP
 8u8NdrZVoszJ3ib+rCtifc26pPtWLnBAvxHKGKNRBasbL8YHWcuccJP2Fp8KqU4f1MaX6rZOW
 k3rlGDAYbLcH5hCcscyGBXoOTu+DplygSMjkIaiONS6Eat1xFaIhhPbMGNxX808IG4ZMT/HR5
 Fxgxi54B/PONaQqN2MsiTXn5X6uUMM8X/TGODxXHcZCx1n8u9ffAXqLtvpOoXmpz1T2U9g+C0
 mFoOSStVtt/nT9/kZ81ickzdzYitfKE+3EE1KHF8mAsWw6UVcODUFG9gQ9Z2GX1wmLisqGcct
 h311zuBZb32MSQ6DvOpxRN98sp9SgusJ4a9L7yLKVO/uCo6j08Jn6piPenfyEdbJafda1mC/w
 64Rql0j9GcZdA5Tr8077EZnRl4t92L+LO6FHVz9zgsCwCMAT/1/+AqR91tdsASciB4D68ktEu
 jO3lODZpqe8TzPnrj7bwQTNBdoF1q2TcY11ncHGB+oyuBT/rM2VfKcHyIwOgw/nv+4yN2P2eN
 3PDLRPzafy+5sBpsJyUUm1VPoK9v1KBheUVylDN32Swffl0qS+fJ0zc9gBJ89x97GRMT3mKj3
 y+ip1EwGL+9Q57XsJ9ESUzwhTaHCbuowr3Y3IvrxQqixGdT/4xB7mr3QcDjIyO6Gf7chCs4IV
 ImxewdmR8rDWl7QNiRxjxWVcDHipZfraKEDPDpVKbC8VVQo6QH9DSXlUTkS8k8XKRdTUsa12R
 BAuZ70P7b9nY0+z1CeqjxEk1dflUUT0YS7Je8KDAsu5r3RlxcdbS4jju/43NxWVxuzy9SFm4h
 d0ETU/DdHWlWZGfryQWI7dKIUKp/pK3lg8vuS6y4V26Ya/EuixzzvHq5eXsz4+4XOTic9FXHe
 072BlEPiiptwjKpdCMEFkMO/b2xzBokOP46JN3bIeKbX8MFMDRFaZjsDIVptIQQDKI17cJGOs
 KxVQresWjsLaChncWsqhdq4tvm+MHLLV7ADwr4wkLdKUiyiVxQJIK/4caaH8wtLF+ahd5fO7T
 pPSn5m8jyd/eHF6fTfEJM75pM5jXjrGzXpJcjRNt4MkU5spZk8xcY7nEzmGZAbPNPjj5EWHCz
 t+vArL5BOTiNmfXczqF3aieKkE2qifvZ8DV+RWZ6FeQFUM2buWgrp6P4xXVdRbx8XhP89RWw0
 6g2hLwB4o6IpjzF2DTQ0B0QJLoDGF84zcnvjMOIdF+pZxczl5l+7FjKngTQMOyXXER+OIg+Ut
 wbVfSDH0hdKGLo9LnJlMm4qrLJD4hUe8+ZNfPzf0ZJ+3CrTCYEflyD+tvhznODtOrHsBZ6v53
 jd7Ny+nNjsOJACmVAnqLMdi0uDqxXidm+aUMBqqDeO3u9AWLTQxmlAID2k3sa76BMDUCH1K3Q
 hws+cNholFRREAioo5PY5xiw/KIDaLDYLirWlXDvYSj7PJ9jKnaXLe6A1T1tr/NYKiAow6rd2
 mTYO1PssFt9FmHYQPhWY+jTGZNedUBJxlAkHFnhV2H9Nff3DReSvyza9ir0/4AfdYHlTdgqNH
 fqGk+8OLiK/7zgdHioo1CObDcJmek+NxppySYSa61tlSLmqAFMDEOBImWU1EIdTZvWRz3B5RI
 dKDWvKxEMd+TzzcQzWd2jgIRfpR4UNJNWoAqWyjim5bh2e4ak+Cb0xurnNWpNNWfkifOao4bR
 fJjrckJWyRzOQRAUugOjj2mTonJ1OX+9oXF5kAr52ABbSplmO840t1HmP28rLrLaLx+03QoL9
 ozTRjvLWJMiPpnaSh/f+Jwy2hcD+lmPZdfFx/KhOTpnjA5ojd+A++lnHt9j2Jq/zCGFXq0A/A
 12a4tf1slr4DJEJDX/7likbblaIJ4wbDS8QW3C2epr8uAXZmYdt4T3pKsyliNH/pazbdLu6yC
 3BpcOPGFPsWJQ456N529u4uAZx+PlBSahTmluD/hHDTr8b9aZoPy3Ugk0jlNqmMtZyNXKMIHM
 IlB1B/y9BcBAyXriVJCAccIJIV5dcu/juVOu6k6UFF58ifh0+9KGvUcCXN07Rh5PtHMMn+Fou
 BrcnbyQeVD0zRrMWTyczoOmvPMcFc1iPvUzg0TZKTDA9ctseXXUmpjad7GBchUov+wxc+Ya5K
 L1KONrqUv8G8dXq+eZ68527OttC/06pvg3HTho+ui7+TzpaV7+365Hd9Cew+f1WcGf8K2Kiz7
 g5vVqTMvCjQpJ2yY84OC3fnAcaM5jUeWJoek2ctIB9JUJf7yYeCBtF6D8dMlbnWzqazE+nMx9
 X1N9rp/hxYh0bSYnm1iwGKG8Lh3u/N/9GAZl4qdSD5w20dyavRydMepBSCsu06zW3gvi1xPqG
 guU+X9gvdBsXMJU/8wXUZhopPV3xWLueu1XCqaCqlbUaXUA+vYZ4+LskXmvmZkr7LWuSP4ZT2
 BGEzX3Cgu5hg8qaxpQuh51xQ5w+UdbHbZPcRTSxTewuv5lMLmLmqBDvUqQ4huhHxjYuUO0xaP
 p3tolpwJqetnhbgmuJwr6jvo2uCMShJx3Bi1FE1Q7YzC4MpWFPmQCyK+99J76hL7gjeimEnb+
 NgN+Z+qg5wq7HOcfQqSwZVLKkOKl8OMhoCAwbmq6jDB0MWbRKN+k/4NxDqBZHZGSahPnaej+o
 7SzPKAm6V42e70v/I+SK5aLa+R3UurxeBIACOX1+bVCFVSEzr6qE24bImWW3hrXyaLxMP/eHp
 /JlMPixsR3IerS9Oks41Ki+MV28Lmfw02lnujCEzkc3RLQOJ+zLffSHhjKZBwH90E6abbIbnD
 8HanDvt4ppZzn9Lvih97ogV3gK3kUvw6lJrEh8NjpwlI/AMK2SqWG02lgrlf0tBBWObLM4RsW
 FNBkHpHig+xhiV0ZeB4xPNBOol2+cbKHTDYH3s/PVomHx/m+16A912Bk1j0dCoKrzmCmi5nsD
 AM9oPHp5z+txGA4H9U6FXbKnWri/E7nKEJjMszdhnyKJbwG4Qo9SmvyqK73M11o/poQvxvv0f
 CyTVue6bImM782huGLJtQrhG2u0n2OUjZYyniLF6sgx7EQZUvlc3MuRtOE3x8eVZ7sZRC2KiK
 l7VdKyQzcskfT2IYnBPpqOcTzUX2j4Sb6NKd3fRoPoHujS5kAHqx9Ab7QneyFewRMeJ8x7mO+
 r2WT4vsUGuPATt7++LEOSU6kfHMcBYqI0nDNdHP8ooyjdMFw9hFR6Q6WSktjeqyw+Ov+aq0lu
 d1HQocSJWkT1cRT6K21vXfyG2kcJl+taY8CpfS0WdODG40k/ny1RdT5gdUKYvYQ+IKOFTrucI
 WU63FQIwHGEQXfXzsE9rUSDjwErTb/m5s/LTuZqGj+Hg2198+lA5L79a6xIevxqb2cp1OMfUF
 KtB0d7hJV6qgTGnDyUpCO+arEvzfWLSx1AjS9fbUd2lLDhJOqJZvEcsJmOGXQDd/7Fz3Cz04B
 yq/y6uK0qI9a2FHdVso6TvkF7LX029aMNCKaYpCFdDTRVDz4Tl/L6p6ZuRMmJJu12Aiv3uVnm
 OTkUKLrRzFv2e5iYJfisvOg7xyyk2w/pwRVHWu+Va2ppsBn4+IIdUsLBAV4iI7vYDd/AnIdHK
 +HPTj93F9BjUY6IDamsP/Py2ExcqYSO/yuKgUJsmhrFJGnBiz0d32T637emKU9ObqZJnSHacX
 74rn09ha4QaPagn7T9ko5XNDxOz2t1kx7h7Ck8it4fEkvmSmBZWamT7ER/nBP2ooJaUWPDyAe
 4we+ceX0ZeymHHu5WT54EihFZIKAwLuBCF+HF6Eg76zNVAKkk/cONRzPwVzW+UCOSGETBrlcf
 fPFKL0x+VzSFDjnlSmTWAtZYdNsQY2jMaqZXcmEI7mOBuVLG9Kg2JFjQhwvRcEYnDdtQXmnXx
 vqW7QW6zYekbRZFPwzx8Wa7JEPjCYm8YIbWa8xTXJq/jRYi3V1XYlKfnodl7/9RjXeeeogg9x
 cmJGPD0YQlLppTiZ4BwIywQhYVyT3tbALniW1epvEloUzIck6xUC8Z8tdg2HMbmGR0Fp+/4Rh
 JV8dyzhRFykGS6fhdAqxjiCh1ZbYZsMgdDaqgg/IqW1eAXfZs79x+6SfXdzAxzhWtwHfCNVkr
 N/7wlQ4yUWCiBGJ4y4K0lz02b8DpVH65A5u44lV7tRHuAPh3wy2PrQk4oqOlsX6EY/5JZbYQ/
 IkFlEybGSKhG9gbcvihww350j4XqO5j5P0YJ/owtURo2+D2YZjfao+OmrwhlSnY4EALCZxpy5
 jJNczMzsRsj+sv0EPL6K/im3X22txEJl0U9Z0nsNAUwrWakgyi5CqrTnTYWn3hvolDpjEkcR1
 MYDa8c6+6kEFHpdd6QI8GLLSHSDeXvSapYsgTTTKp9idHWsG/F/sHhpWyUoGNWrZnQ0gP3/r1
 pv2rarkpnNrEs4JXkESDgYmtv0I8wPTV3J1GD2zS5hd5l8H/yoSPL/1ef5dR88CUW5edSOK1F
 fDzboSeD3FO0IDZuTHJ0XkZ+D88ayapZkljNqTCrZZ/b7KCBdcHZ76wx7WzB4BmIkA3vgi+7v
 SXH7d9QL0gqsuo5v0h7VtrdWwndqpcd/LJnawt3osX2GyAhwP66b2NSYshN2gfdZqy11OnD9Z
 4TSherNpvec92KMzOQc1J58SIMWbDofIh1XpGr+xzbZpDj7AYI4qZB2chXUlZ3II4TjQ34PKL
 D/QLAvcpViPhGPVj11QohYSKZo8REnbfvC5A3xIe3FNRkM1ovcKbzLHIFTexFHcUDMQuIOEBx
 Y00BoMED2ZHE/izWWn3FW3sh8aUxMGnt2vKWzeITye692hyds45cPnfvRP7kf/hj1uKeVGMDu
 XNFHPmuvh75FMxSHplvykZ1qtk7EbEC/8DaTWwVFhLt1JFKTVlDz5q9mqu/fk2NmcT7M/vEVV
 wpcy/SInHvZcU9M/PA2R2o43Mh1JmyaNmskJKw5jB4Q/UAU/y5feG1el6nGP20m/8OKFjuN9A
 ZH46dFhAW0yMFSRQ7YZb8lCKOg345SnvxD4sHmht5jIw81FWX4XyX8dqkVa1Kpi/MppyJVz4l
 +xjU9efEWfdnjqi2k8yxnTVZvTc0912h3nziNCpTlqze0fOeaV5YU3NNO5FUswcKw2Mwg==



=E5=9C=A8 2025/11/18 04:20, Nathan Chancellor =E5=86=99=E9=81=93:
> On Mon, Nov 17, 2025 at 03:40:35PM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/11/17 13:33, Qu Wenruo =E5=86=99=E9=81=93:
>>>
>>>
>>> =E5=9C=A8 2025/11/17 13:10, Qu Wenruo =E5=86=99=E9=81=93:
>>>> Hi,
>>>>
>>>> Recently I'm hitting pretty frequent objtool crashes, sometimes
>>>> during module linking (btrfs in my case) sometimes during the
>>>> vmlinux linking.
>>>>
>>>> Unfortunately I don't have a coredump for it.
>>>>
>>>> The only info so far is from dmesg (and obvious the compile failure):
>>>>
>>>> [=C2=A0 625.066787] traps: objtool[46220] general protection fault
>>>> ip:563ab54c6eb0 sp:7ffd9c2ba7c8 error:0 in
>>>> objtool[19eb0,563ab54b2000+1f000]
>>>>
>>>> The involved VM has the following spec:
>>>>
>>>> - Kernel branch
>>>>  =C2=A0=C2=A0 Btrfs' development branch.
>>>>
>>>>  =C2=A0=C2=A0 The base commit is 24172e0d79900908cf5ebf366600616d29c9=
b417, around
>>>>  =C2=A0=C2=A0 v6.18-rc6.
>>
>> Furthermore, if just compiling on old kernels (in my case, 6.17.8), I
>> haven't yet hit a linking time segfault.
>>
>> So it's something in the v6.18 release cycle.
>>
>> Not sure if it's the recent Zen5 related hassles.
>=20
> I had similar objtool crashes and David's fix [1] from another bug
> report thread [2] appears to resolve this for me.
>=20
> [1]: https://github.com/davidhildenbrand/linux/commit/58e62699f777381887=
30d489accd01ad8e3cdeeb
> [2]: https://lore.kernel.org/20251117082023.90176-1-00107082@163.com/

Thanks a lot!

Indeed this thread explains why aarch64 doesn't crash and with the patch=
=20
applied I haven't yet hit another kernel compiling crash.

Thanks,
Qu

>=20
> Cheers,
> Nathan


