Return-Path: <linux-btrfs+bounces-16872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329C0B5A3C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 23:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87158178235
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 21:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C79D2848A2;
	Tue, 16 Sep 2025 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="g/1YMmtp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E1279788
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057448; cv=none; b=Q8YerCyBQammjh36Hdx478YIW2J75AusyQGPE/5s/+tr76jcMModxPo5B0aJBW4k9Iniz3ISqR/Mlr9AYyDdJyU2on+i9weMH9FtoLKM8p3aV/ARsp1QesDijlKVpjpfhR697TkoQSfTxI4BAApaaL7pkq28vi338c0IrIuQWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057448; c=relaxed/simple;
	bh=r5ilNivRxo4G3VHZfJ+k4G7CGvQwduTT1ts3A11VKEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HdiKp3suYIM8m9/eDe/I1LUEZ5gM6IG/I1JlPgQwb/dFBGjFTqsw++iCfs2rZu1AonMBIVD6O75X1UEmPGI27X3wsdyBHDdJUbEFmVcFCXPCtZ+zY8UOG2g/71wdREMUK97tGnBeLdOGfOM1WVJQckNRDCHny0OfJesd/3yJVEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=g/1YMmtp; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758057442; x=1758662242; i=quwenruo.btrfs@gmx.com;
	bh=tIVDjGqsFrPCss/R5+w0GWU7KbbN61kJ1PX2UAPRqs4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=g/1YMmtpE0U88KpNFXIGdmr+KKMaGRU8mZASzMXGAN+7DDSwFur7gs1c29ngfAsF
	 c4od2HUAl5y5MVccVFiDq0wB4yq/KefBvm81o7ZhvR96hYxcZMnicu4lt6RFmlVI6
	 YYHdHNcsbbeUsSVYZ0pK42p0j5wcvMp2vv1DTWuvbdFn4pkSW9PQRa+W+TMs7ZPj7
	 orM3cgxukPL3vdaKVXUDfUHhkrg13YZYkz00WGJC1RqIgKQZI9UW56xKewR+tDWaD
	 lPmCsHs1zOdyLQIkVkDGW/WoBfU9bwllOpflaVW55iaeYsjoZ8QdyKcPo2Wl7I7O0
	 4vPSqgv7TvqSjpiobQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJmF-1ucmUU2qrT-00iIlX; Tue, 16
 Sep 2025 23:17:22 +0200
Message-ID: <967be80b-f683-4611-a473-0ad02897c451@gmx.com>
Date: Wed, 17 Sep 2025 06:47:18 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SSD overheating during scrub in laptop
To: Martin Steigerwald <martin@lichtvoll.de>,
 BTRFS <linux-btrfs@vger.kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <1938311.tdWV9SEqCh@lichtvoll.de>
 <44330134-4c22-4fea-9a14-84c78daecdb5@gmx.com>
 <45131321-5ed8-4abe-9edb-19b1936e83b4@gmx.com> <2031348.PYKUYFuaPT@laptop>
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
In-Reply-To: <2031348.PYKUYFuaPT@laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wl4sCXoHakX6oSmyRG9rVSCyRQ0POzpDI9GOZhS5yc2uLUh3N9o
 s9T9j/IGWbPAnQqsmQiuCe0uVGiwtNxXl2ko5EYy7blEE7Wgm31TF8dDhyxePcjfo3WiJBN
 HfOM+k/FW3xeG9S1LphvBDGcU5pnCsDreg+yX3fRQYK1TzmeiQgVAQrc3Vmf2a0XBJV9TDF
 /CUy4ujj7rbzGiGCebHlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ffZmQ66z89I=;YSROLy5Wg4wUCzIyoVcct+/FHMe
 /akRYMrZCdKEF+FArr2S1kHZbrCAW7XW/sJHaNN0Lq44uVqJbBaRqrNl0xK//Gy49hJie4skv
 VHvuguJqh4r4J0kKZdiEeuqANzl/3UT40p01n1ygM7WTfSU3aYQ5GDFJYCvePLmr9utZ5Lca/
 XDVEwLFuLoNRPfZlYFD5qOTX2d8DnmNTWyZnBSVJTNNtuSnd6Bqj8sIgJVSbXJqEM+M8CEm13
 UHa16Q1yqga3iGDD90wA+Ymx0z36hmO96WIuQfMlQE5BnkFQWTv7RHVrLthUaDAG4aIP9+eQj
 tPVcYc+RgDrEDBMJhqUfQLodGl30HWKgPgSmexBFY2w82L/oOn4E0ZA2KVQ0oxec6tKtj6aBV
 6xEuW0t9NDAEhLbMaD+Yo/4ay+QNPf2GtkCh9d84pW1n4XgTrMg9nOim94gziDeBBNxwBv7iw
 2yQSR6uDZuHXcoooFpDw/HI1kGzTm2elhQtUFxJZElRbk5QyKXkKjhgIBGWC7JjVT2oo6c+Pz
 H7fS0macvjql1mp5TZpCFx7CBQsiHPn6cU2m6yYO7qjEp3BzNgiLzxQeNg4SZSRxOSiYcTI8n
 Nnodc9BLnqIjNfy6be8oNYDkB+8XKQ/dloDzd51FxiYNTDZ/Wc36glAR+GRxOXB4S7NcCeYYT
 IMl1ryhK9haG6Bc1HXBUeuwamVCw9djV74eUz7YVmFYRqqGlO2cWWDpRLQtzqtxnLIWuRZbD8
 Wq/KhJvezOEAfJ6+3InRop7Q58IgRIpL14FkiWkoZQV9P9L6ouGpc5VFyoZxfAvLAq7DRjarf
 gqbrtw1fVo59W/ZJxlkdpxbZOB5OIZE/ksQovkBXaXt892dgmY6/7vFhLgt3VKtW9lAg8KPqg
 G7Q9pg+d6e8L9VsWwwEpwAa5jKcu+90Fj+oVrGg2pJfJWZHAYg/BHOOatHD2ekjrhgK/9lhLh
 sWETHZAw4fNXORrDbHuXF3z1Tot+E2V5HJ1yYWCATyZdGkTaHoBBRF4dQF1laB9rCXrxKRt7g
 4nPmN0ff/yUtA0+7KwGGPvIAKNcHnPIM8PPRSV4YnKBcq2coUJA0JfT/wtr8EuSF7WyGjpYnS
 vpWv+lPy+PX1jW2poNBZGWDofUhYKyMJul7zsJaX6AKeG2OHg9vbFC8jGJJtEAqqPAE0PRA45
 V7tptZwftbkwp70yGVMCVhl4yY4Cd/EEleXaL6WLJEOPljBVAWbkqGfycodtIRTf6PMKEQnKE
 xLtFQCjaVSXPAryPJ/USD4FPHzfOZvBBmWFDA1x+DF+2uKgBI6i1zw3mF8+YfXjwBCFNOGZ1n
 9jp5xSq4go58aizpOCUuKyrXLuWvnfIcNig+uQmuHyoU+bub43po6M/JCRqh1/+bRVd5pKSw5
 fOiAD29ZgaUhJwQnpv8/EcnBjX7uWtePW6kj1GampJ/rZ8puek490x5i7IVIBS5Nq3g8ya4tf
 39cyV9ciu52PSIHIuSXQIsbmyj3/uh4WXJg4OzyvoRurzTE9LiaiDmEIc+AUpoDuwDnI6S0TZ
 nEYJiqwbEyORSf4PbzKgxmriHi9DvxhtpqI+ZsFt0XG6UmqtmqXXEQDdQyrtHD0/BTj+F8fej
 ERSBCf0thR7hmOV8eNJNdMPH2pE39sN8d46+f4+KFMYXs+vyuyRjv5/zlrhieouOX47eCV6AK
 3BmtQeGorhIGZctiu47xrtx6ypgdoP9E9cjPTQFwBw9tQS1HFyFdL3XegAjK03U+beZXLjiyA
 ssf7a53/JuHR672dlM+AfmKpilDhZNfeVJ9S5HqCoppRpunmFCLMSeCt6g85erllppRtYkETO
 txQOofsJMMELIalQOYTPhvaD/iJgt2Hn89QQAUXjkp32L3b/bfRu2e/LcaXnviRQQR2woJRkT
 CoN6uk/YieXqYnZpTKRoGRV0c93mLVl1qn9l8uYhF512X3iyop8lkW5BHFoykof8woQGdrMgk
 MOOuRLmKsPyUjiPr5IWUd+PivRndtNtSEXEDbKtoWTEUtr8YeeoFO18lpIAsg0Xw1gni3q0bf
 tUPSjSONGq3jJJcD6Zhq01/AXon06xVpls9GZKM2ukqSxgAIsu10FPUf6mi3s7DwTs5MwpAJ/
 JEtJ4casA+2LB3GLjfg18dCgBTan9p74sC3tiVW1693wDxB2+OjW5CDGMRUBIeF2Xl24FhGBb
 V0tzAaf+Xi3Io1NHszhCXF6FFH64jjBL7iUvFE8JdGLAgpOGbj5c7OnWpkPsGvs1/XeqEGPjx
 pImgb6AAqV17ncZlyqgMgtg59pnnsb9hMAWVR3Dxbl0WiNWMZ0eoLSInYWoTLKsIGOLK8ASnj
 PSGPSENMS0QRTgKKx2N1Ru+iec2RkpU2q28FaGw3bkroDnUzd/vKBQXjaBie+IncOoJBaEIee
 4fP19nJVD9Q1iCpPcD/1xV8ZjWNugiSM6Q0QWHFBbwNJjtNrzFdyt3W5OfJsAIA15lGmrJ38B
 4Xssi5hdKSlN3hfyM7UlpCW0FEuSt7Hf9d0BLbYZ11yS7Va9cAgZa2rsIbZnKn30uZYnLRMI4
 MZS2JBTs859Dv7qYm8YHAJeRh7rV2I5gGiaKUZhOdcfiiEUJLSKJBp067XzUsP6Zb2dT92UOI
 ZYSyU/1XsUO38P5RWsj+/Jzjfq4y+M2WZ8xXmcjaNenBshWh8cQnmDl3mW3aOAPIaMqsGLIbF
 8dy9ipYyQteRsTpa+YfuonLbWYBYcdo3p+RALWpismn96sm8GFAHNonIu/ncafdVHMkN1unWH
 B88ZZi6Onbx3Q87K67378a3z1n7RyFr48RHaAs0ziNmJlKsiJGRcHnLku6gl4qQEXaaORfSPm
 EJqF9/kso3qs24gCv+WR4KgS0wquLBwVaDWifmGgl6rmDUbBOLp1XhH5wim7SNtFdJfPBmI9U
 ALUwL+ZTfdpLy5qI0VPYC/WrBcXIVLXz5j0qSXNkZ08m44W3sffBomYfqxsAXZrzdH9r27eWa
 FmOvGANge6dIs/xmgFbWVPVKE7KoZrWeu3jIGoQybiTxjPVBmDk+iBR6T9g5u0q9RHmvFdRHL
 7V23daNzmaNZPZP7rbaenA7+NnfbtWad60qrpSaZCIT/TCPuXimxuqbTEXsijQuq9G3v0lfcN
 3eHzVp07wha24j1O/2HpEAQAoMZzKafZzqbJXBS91TzM8J71akuRtGf98cQMLWgeJc9KKvUF6
 OvxYgOEcl+CXx+59YogOCr8aF96+XXy9qGcmVf0joRk5jQaSgxPTy/+mW/qdUQM2Si4plhhny
 n3h7oGBGUAhvle+Y31d8l0uYUo0eb/XoErwIq6Ijo65hjZuJQPs8Nssl4Jz9kjU1uwGP3v341
 8d5410dqWyg83ARKvhfbrK9RcuCtrBF+fdJc2wHBjS+1dhhxCQRIofkEz/vYO9AHji8bOI4TN
 XwF034LeRM4ZJ6iESvsFMMelLfRHHoLPN8R1c4HTXvX/kzs+RhigSIuvA+paowlP/RqInKSMS
 vpYznPM2tPwVq/BRYq+woaBBa3K63slHL9PS+rwSEKgdNpA+6uZRpNQj+UVG0QJUpNNIeMm+Z
 YktIzlvDlyRS9ddNmN/2rfu+zd6uacwnlsJnkHDtxvTm7ejJdsC6kbI2yhDv9ubimc99457/H
 3fbeYUcr6QAAPqxzL14Ldck6n8WXFX8tlNZ3Y5+fz11epBl4kQCXgbQfT15LbgkRfEX+DAgKD
 XE00CEdUyhg6mbQCeRdHdgeIfo3188oDnj0FdSVhO0jeCEHr9aCkUz+SE4BZpmoiJG0tqrrcD
 VOyNqsJG3pXTkHSGUSmJet3inqhZVOdM/qdH2XZOzBISDW1+RSFz+judEF0fIKXomHzZe4+fP
 yOTR3RVmcJK/o/bxNkDqUbVjG/QkUlRdnf3dBi/xWtPNR9N4lSJpnCxMeRaGOEDuF2NRD1R+Q
 HMzlkk6qUiU5xkl+Hk33rIO/tiNXvXvTWZ7ZCuhbmdZ5aOsAN+DSyy/zX98MT0tvI8FpM09Bx
 g+6v3x8I/scPWdjGYOuPxcxSag9B6RpLMV7d/kBvQOZbiXhWlFQo2uv6B2KWY+fFur3YzitEu
 Gsk9QlQW8tYtSsTnKRgEbxKuBtsXb71R0qg76E5wCSNhrUopGARw2X3rSpyTmKPUDxZfi2tU/
 ChKBbmYOOmXjVy/dinhmhH1nuGPwGH6jizNCOSOL9HS3jKv1d/SEt7sOdgdGUu9jfAeKhQfy2
 vjlMBWgLX4Ha377rQw1f7JM9lbusVkMogVUOC5QgHDY8ZLgvUlPGuhJUgepZ2strMqo2UDwpC
 wfYKULWqqgRK6hwS6SoQehQ8YDv/9UXiq/K4qJd6BLUXe4nk0oIFfsFUi69cBMuVq8bJfygbd
 noUfAIrn2dW9DUjbz7XVLNVM0CoYlWQ+BdatNI9TqWQP0CmOGNgH2zZoa+GpsBFgU+oDQxhoQ
 5DsJ7dWvOmip60bBnWByKZe+HY9XDAzZjEO4GOnQ+R3lwP4uU20rupAFKL4G2PSvQ5gt8EWL8
 gDU3hzeGv8kpMk6aC+KrCay6nSqWvkAoTRZnkXsIfcsIYFI6czBrcvNB5gqt1akkbRrt2mjVp
 W4ekEVt0fCcmsYv4CYoIm1OXS40XgmLSOkpDy312f9Wdq7gPlIgxuiajQ03jvJ1Frz23vXpZn
 FM9bWJ9xV7AAm5xhOLI/oO3Mzq7Uhzn1fjFWeLSo+d88GELahWn2bskKyx0QqsEoHrgBQJc7A
 3ek2ZPireY3o1pkk7om7L89hwRRLuPPhdilMBPJ8N/GWTO4w7eAwZctdn+oe+y07ggn/yEbkf
 9Y7lpNr4IrqbzyUzDlAOlzTqoxMNezjmVi+LRTr8mV0PDYs07lPjUUQnV6NiplWM1f/yXHf2h
 yv6OEFnoPK



=E5=9C=A8 2025/9/16 21:06, Martin Steigerwald =E5=86=99=E9=81=93:
> Thanks.
>=20
> Qu Wenruo - 14.09.25, 23:33:01 CEST:
>> =E5=9C=A8 2025/9/15 06:58, Qu Wenruo =E5=86=99=E9=81=93:
>>> =E5=9C=A8 2025/9/14 21:27, Martin Steigerwald =E5=86=99=E9=81=93:
> [=E2=80=A6]
>>>> Now I had these SSD goodbyes during regular use in times of heavy I/O
>>>> and in the end it could not even scrub that /home partition anymore
>>>> in one go.
>>>> Linux hung and only way to recover was to forcefully power off the
>>>> laptop.
>>>
>>> Can you setup netconsole and catch the dying message?
>=20
> I suppose I could do that as I have several laptops at hand. However=E2=
=80=A6
> after cleansing out at least some of the dust it did not happen anymore.
> And I do not quite feel like putting some dust back or otherwise provoke
> the issue. I do not quite feel like trying to overheat the SSD again. :)=
 I
> looked at it more closely, it looks fine enough. Nothing melted
> apparently, but what do I know? And I think it does not add to the
> lifetime of the SSD to overheat it on purpose.
>=20
> I might have made a photo of some earlier time, but I am not sure. I wil=
l
> have a look and see whether I can find any. I remember the kernel wrote =
a
> lot about NVME opcodes. However I do not recall the details. Unfortunate=
ly
> at this recent occasion I did not make a photo.
>=20
> In case it happens again by itself, I am at going for a netconsole log =
=E2=80=93
> in case I can reproduce it then. Otherwise I would need to run netconsol=
e
> permanently to be sure to catch it on the first occurrence already. Not
> sure whether that is a good idea.
>=20
>>> I doubt if it's really the drive dying.
>=20
> Why? The issue went away after removing at least some of the dust. Of
> course that is a correlation and not necessarily a causation, but what
> makes you think that something different is happening?
>=20
> I checked the drive smart status. SMART status is passed. So everything
> okay. There is 2% of spare area used, but that is still a very good valu=
e.
>=20
> An indication that there is something to your suspicion is:
>=20
> Media and Data Integrity Errors:    0
> Error Information Log Entries:      0
> Warning  Comp. Temperature Time:    0
> Critical Comp. Temperature Time:    0
>=20
> So the drive itself recorded no critical composite temperature times. An=
d
> if it has fields for that, I suppose it could still record it on overhea=
t
> condition.
>=20
> Oh by the way, it is a Samsung 990 Pro with a firmware version above tha=
t
> firmware version that was known to be broken regarding SMART status
> reporting. In the first I bought I made sure of that myself, but this on=
e
> came with a newer firmware version already.
>=20
>>>> I opened the laptop and removed dust with high pressure air can while
>>>> holding the fan still so it would not generate current. And with
>>>> disabled laptop battery.
>>>>
>>>> This fixed the SSDs goodbye issue and I could even scrub that 2 TiB
>>>> filesystem again. However, according to sensors command it still had
>>>> about 80,8 =C2=B0C composite temperature and even 100,8 =C2=B0C for s=
ensor 2
>>>> for the NVME SSD at "nvme-pci-0300" shortly before the end of the
>>>> scrub, with critical for composite at 84,8 =C2=B0C, but no critical s=
et
>>>> for sensor 2. That is still quite high. Granted, it took about 7-8
>>>> minutes of scrubbing at 3,5 to 4,2 GiB/s in one go for it to heat up
>>>> like this. But on the other hand it is not summer anymore and room
>>>> is not as hot as in summer.
>>>
>>> I have hit similar situation, but the symptom is very different, the
>>> death come silently at boot, the drive is no longer recognized by the
>>> BIOS thus no longer bootable, and Linux kernel from liveUSB will not
>>> recognize it either.
>=20
> Hmm, did you capture any logs?

Nothing suspicious at all, except no PCIE device detected at all.

So in my case it's really toasted so that it can not even be detected=20
anymore.
>=20
>>> That's why I'm asking if it's really dying caused by the heat.
>=20
> Ah okay=E2=80=A6 You mentioned your physical solution being a thermal pa=
d. So did
> this symptom go away with it?

The nvme drive went away literally, and never came back.

> Or was your physical solution a general
> solution to reduce temperature, a solution unrelated to that symptom you
> described?

Unrelated to my long-gone drive, but a new drive never suffered critical=
=20
high temperature anymore.

Thanks,
Qu

>=20
>>>> My solution to this will be to remove the dust inside laptop about
>>>> every half year. However=E2=80=A6 I was a bit surprised that the NVME=
 SSD
>>>> would not throttle itself before saying goodbye. Or maybe it tried
>>>> and it was not enough or to late? The laptop is a bit less than 15
>>>> months old. So I conclude that it takes less than a year for the
>>>> cooling system to become quite a bit less effective due to dust.
>>>> Good old ThinkPad T520 took way longer for that. But it is way
>>>> larger on the other hand with more space to distribute heat.
>>>
>>> You can refer to man page of btrfs-scrub, it provides the way to limit
>>> the bandwidth of scrub using cgroup or even the btrfs sysfs interface.
>>
>> And I forgot my physical solution, with a thick thermal pad, you can
>> connect the NVME to the back plate of the laptop to dissipate heat.
>=20
> Well it has some violet colored pad below the NVME SSD. So a pad that is
> between NVME SSD and motherboard. Not sure whether it is a cooling pad. =
It
> might be more about isolating the motherboard from the heat of the SSD? =
It
> has been there for the initial SSD Lenovo put into the laptop that I
> replaced with the larger Samsung 990 Pro one.
>=20
> But yeah, I may order a cooling plate to connection to the back plate.
> Good idea.
>  =20
>> If there is enough space (I doubt for laptop though), you can add some
>> thin heatsink for the drive.
>=20
> Ha ha, no way. I would like to put a 8 TB SSD in there, but it would be
> double layered and I doubt it would be a good idea to put a double layer=
ed
> SSD into the laptop.
>=20
> Best,


