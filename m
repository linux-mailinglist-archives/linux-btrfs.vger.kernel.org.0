Return-Path: <linux-btrfs+bounces-17740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260A6BD64A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 22:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D613E8670
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 20:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF75C2EFDAF;
	Mon, 13 Oct 2025 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="IISh/iG8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DAB243969
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388800; cv=none; b=CcA7zSeMWkOAYKjQVVHZPGYe5ZZHUDdRJHPLdIF8DaeMHqM89hCgMGdVbuehRtkJI7bFgEc68M2f6BwBZp1ZFkLZMfXaErcyUhtzqhId6xNbZ5FLVPYJUeWrbPO5uo+MC6mUtY45PCFvsmEU2MKTjUKga5fA/Zn4R9oNpkc3VQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388800; c=relaxed/simple;
	bh=owWCAbliUG1J/ABp9PLcqM/TAXMN3A9XXDc//AxLAq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qsj+YaQwTCq3TuhX5LXuVkV7oZRsa6EmpyRGRjhpYyUAeaGppxHuoEoxS9+c2MnrvaPWa4qQt41Iwp7sLyPMfwbcBpSe2QUhU3HIYIKK7QO6dTsoSxY0u00Qp2s6d5zzLUZ2sAT50LwK/FpA7YeuGUNlpXkAUL4f8NRJRGkkelk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=IISh/iG8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760388792; x=1760993592; i=quwenruo.btrfs@gmx.com;
	bh=xZVrUgU5dtBr5dmT6wnX8KI8lHdXZXRuY35X6eH9f9o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IISh/iG8xPn9K0Wpf15PHe0+OA4tpdmuPtdVQIQAXWHlZxUTlUwFNYnYBldQPxA5
	 6HC7Ply29JJniln0pbSxhnVXczOHP27a3l7FtI93RxaMWGyZix5dh+MpYWXHcB3CE
	 kRLuqx53timGJN2TTsNiOvn1q4temSz73BLT0gnSa+MFLrJf8QG6z70kTPEDPG6If
	 xm7+fi4r9+8tFsXC/nBTUhLcinWo6AUCoSEYwo3NfSK8FaguODIv4v/SRha8aNhVl
	 x5nl/Yj8u3JIi+GDTqC57cxn5GJsHsxA8Z2YrdqYGIJ1zjYo4RNXnsOy1UKTq3ZKe
	 GQpiIPd4wG/LcIXMXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZktj-1ulUpL0ObX-00K2h0; Mon, 13
 Oct 2025 22:53:12 +0200
Message-ID: <4b7b3166-5d29-4b20-84d7-40c69a3e106b@gmx.com>
Date: Tue, 14 Oct 2025 07:23:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] btrfs: avoid multiple i_size rounding in
 btrfs_truncate()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1760356778.git.fdmanana@suse.com>
 <612de94ba1f20516b12b89e9ceb7e1defa1babae.1760356778.git.fdmanana@suse.com>
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
In-Reply-To: <612de94ba1f20516b12b89e9ceb7e1defa1babae.1760356778.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AdXk7RYFyKERYUrmfpA3vQ3JyWakL/87unrpCxFJEpLG1Wn/cV4
 taVLf60R3l36K3TVinE1EU/K4ofhhK74w+Ql1AZxKudwbqXy37x7UBCYcQIDlIyQxgzgZ70
 fMNv4Tps7f+86gohvq5+L9q2fyzulCZH6ztmBvQSLnU7s4muC7DMRY0W/nYgNHytx75bs+3
 8i5U/wjBJJ5ydkU9tsORA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:614pmsLtwKA=;sjq6plaCg7eDjL+w4UEAJ78AU/C
 DAiWgNqpkUkC9giqnXzxf/eLwlSBH32DfNgEJL85QNNlEEAeZKbz3AZsqWCceHxB+kArA39JS
 mq4NqQJVK0f4swkWLyANrVBBLMGiF2pnBhm7BmKX4Sy/hLPUhbpXxNG2NdkyTXfScsVntTyyD
 47WGNcEZFmxeunKMx/iwAy6KoDp1jgapmkw320QP1WNOOrGtvvaS48KL2OPi4iT1kNisF00TU
 zz8utw4hsv6JG9o+JZI/UZIJDCA58tY6WMY/N6PzGvdx/eQZOwYM6WZO6m1u8RNX5Q/T4EFOJ
 +5gC/5TeNO2kp/3SbKbImR8DDNTR208nqzQ7MAOU2Llo6CjfZcX/kwpC8fsHApoj9gJWfOq8/
 DKqQqDGcAvSyDb6fWha7iYvYVsYYiW22M9aQJP3jFgDrRRvlC7UHA0coT7RnyxWM47l6K3dFi
 B1ft3p5cs9cxpve4FgO5E08g0AXveTw5HFgyXe4AIo+RRo+wksxUcfrH5RdWchee3GR0mZfg5
 3I3qGg7N08hsFENYni2LJEThK0zXaxEvFd3Etwg7vmD69ruRq0SkPi6DzoJ03Rxo9XnAv1awJ
 lSvsfR7F1SVzFpvbfDRKbdF3HAwqL+31yKxIc062iPYM8z/ZRKUVyNRE/emuTvokMQPQljBuB
 gKNYDuV8iEZrX44nVpoM9CqVQGF7GXQ7rWsGD8oDVARoQepvit0A32fQkchgTn6/sYBVjyphu
 6E5T6uzK1ML3j9sxNRKE9CZRtT60xGoobq0yfdex9XhWewqMaPO4abb+RDAOJjP/AFs0yI1/z
 Rxk8Z/P4dLrhnCJH9nYsVDClYsx433b8qOtn0Yhnlp/c/Fhzzonip5uDO1entLt+Tdg2rguDV
 GqXt6Tmr01S0QotZ8eRx8yFlo6Fhf5HFaAVJtFphJXojXLvfOFk8oIGXVyzgMBUGDyPVbR0EA
 eyLkK1QQ1n/+xdIqBswClayrOSSQri8Qo/6K0U+qsp2INUgYXQpP6vaDtwpYI32CcqdyytI0n
 3jwrkgw9qULza/l+6FgkRWlaq8kUszEiecVDhH/C8dJYOfyUq/sUuc9sQWl77uVP0E/LK1Tx6
 Ie/mO843JOzEeiMeVrmss0jBhGuolSlK6VXvmlarZiv43356e76cCBD4J1SGKXU3cwNSgdwsi
 z95/cpQ3fxDQz0zLKA/JhjA4F6ysTCRXUdKLcgAFfh5IbP93p5jy8Vk4jPobJ8DSrbnotTXjR
 fGUGFOvqy9gBoi5tluQLCiq6536vmOKkiKL+E113Dbh7SKOjPjbOAeeehFu2gp7ocWJ3MXqgc
 Q/swyGK8fm7wamIRRi5jYKxclZBE4QHCfj/OsWBuMrermszputgoV/zCbAaA78mndwASZJIwg
 ENvlJucyxXJP42uUoWLEUcTV4E8HRrBxK4WYaZ413N/dMRn5kNcSttx8UzB2dM9iJcwS6l/bb
 J8KMvc9mqOOSLOZkRezxO5Z+PQfpVFl80fo8Wkvdz6VDNc43X3BEYrrBfhgGxFpKoBmd9ApVf
 QObS3qFvvGN0p8qQL1Ndd4c5PoAs7j8lGjSLH+TCQcd+6k+IGPMvNvFf+mtkFnKFjCO9v2yoT
 3wWeDefOPfRvF7V7OqXvX8q0KX3ibZpJJRROkjdYAxzFta/obsB2OQsOx7zI5CLex2J7iVPDO
 7wcc4IeX/vbTGMjtAnCF4vtP4iaXt5Uox6jjpxzPR1HjWE/QigQwAc/asDlMHIkz31Q9tpiHv
 b+VZ/+97H8I27e34uAnQ8Y2UUS11ANdaO5NxFzd9IIJVhziuwi81jvcMusHlLDQ3PEuMMp2l+
 I9IpCVsN9EDYW3XklxEpkiBRG24nN/Ut/kLvz+o4UYynAr1ZdUqhjg5ZvaouUidPOTwrEru7d
 MeTPeVQ9tzdGnnI4fB0AYgjwLB3LPuHXLHXJxA4A81NK3XAu+d/3kWW1BPiZoRk0dz8+RjTRx
 FRzyb/MsXsan4RdMtsPzomDG48kPPLiUV18kXeEkOgkz+wvF03FKcp/eThKcodm8XSLo8tmSP
 bfO1O7i79bbNb6uJcx7dTRuByBFg6bJKlElXj/gP7eaRGFsEcxf/4i2tm1Z+EhatLfUjwOUpJ
 UnKivlD2DEw8kXgrf5G6qooMlziXS7R2veMbd0Vm5FNGgeO1tMCYbvJ9kmeMx3VdqM5RNCENF
 WWJDnebTIU9Z0eijDm003rEAvIEezqcYt2oHK5wKNX7I3yJiyMt1osM2jkFvGsZ26Gdi0sOQR
 rHDu/PzM1VsZ7OLHbjwqjzJgi87G+3Uk6vBNxFqOE806iwCrf/A3XJrzLL8epbEmnikktIJuh
 UiX1BUtJ6U25gVEOBav1TO+89dYL6Bo7lcKyiWQRGabw4lSiMZK4p3ccv0tebuPtqD1AH1sCR
 v7IBhrT1DPdnrjgYAOl8FoLBioL9cbFpq42SdQY5O87YDj9sK38ggX5A1h1vj7lM0rjJegcjd
 uROc7IznkXlGETTPjNK+0qrZx/R8VQ5XlNnEIEB9ovolo803M1BcczHlWdLc1B4ulzjcxvLgu
 SkxUhtuYGeQWFo4MxnKX/XfLLMmnemEPsyvLOb2wsZno2OSIFzFTei3fA4ZXy6FmqafEefhjq
 /4CE4MwTSP/vJx5RKwrNYC0frBO0Tj1ArpQnQ9bzQrcMIFlFWP4kkh0Ybekv/9Dn4JZOoZ1Sa
 y6+/PynNNh+FA8gObOxlRDL3cyCAhYAfgu+eYoh8GGS+1ut/MbxN/kAho4/t5elHp55x7ZA2h
 E9YVSfpQlIXuwExb633JZu+t5kDhART5HrdjSFxgEUgu2kgCeYMpmxKMKCJLlT4ALX1h1w9jJ
 z65qbzKyv2dHTZXHE5/76/sEx2rlMWSZJJzloEySjR1/9dyY9c30Oy+ezud7b8NrcnIBc2mB7
 Wb31Y1pNnQBipuPOVgXEyWM8s5a1i+DfMaapmpiYU7ZoqvWRcFh0odgJv2C3OoFd/a4yqvogJ
 zD94QDswIUw/hDbdCfXeO6LsDoWgrtjsH3gG+MF+N59PvC4M/J7S1sgwM4CiBSvgYcQZ5H+Tg
 Ty7IItEA09ulV1hFZwtlk6qxPewt976JZh7cT6tpqTY+Wu6txfw0qdqsAEAmepH4+/4DeH6It
 8oDRgCmw1SGywCEdmewlmjCi16XxHj3r2pv0CZBCbY2vq1H7Nqn3vt/TfF8RIoQFaR36Atclr
 heiBGvAoteA9v3e+VDLsNrxc/iBBlhuz3NF69kUS26wZv7oF3RWR+to7WZQVXdh/NUqxI6mlb
 igC04NxLJUW3umUGQgn4gyeW3/25UD7sRXqlr9jJtZ2uGymEYTlvhDDwSTKQ20nGDZr8VAAvT
 vHhxbtePb3tqEtimShVVboZbgwh0VVIx9Ju1SVD/Jq963V/Mvx8kK0mTmPzsX6MgvfOvycPb6
 i32wt9uwnT72YYV+u/0Lm1hGVvZk4F8099aCMtcbj9d4XPkhwifyY2epUqdR6qKs3/+2Lg/TY
 hP1UHr5OQw55IGkEBmXeV6JJoktiTDGFOByzZTT8ridgZkW/UR58eXFY6Uu+zfWUATflzB3fg
 +NC2b8vNrhkn3SBa1l2OEE800vuPzWEO2OnuXwiEZTjBiEf/0cKl8d1LaesiQeup/8pwsgsXS
 kPejGONmQXWn8IrzwnuXrCSSRJKbumJzMk9Rbu+cPzkqBo2Ygo+ItcH3KOrNJOJIHbfmffdL0
 uT+t1aJNOcz5TlaeqxzsFhM1zb7Ol57LAcgoIQbk+LBGIXyPtryrp6Ukpnkv2mJXyNRLadr/Q
 lPccvMpoBXuPHmTOuCYxqfFoU5+AsYw5P1TUTLNPH39SXFMtGzG/Yw7hGvgPYvHxBMGA+pGb9
 LG9Oqx/labV8vsQ5fFYO4cONJVo5C37vY+h12HX2MDKFsfnDIvlmiaRDS3aSXKTsrSfPOugZ9
 AGu4lJk5f1akJFATtPJKUdvJVaFvlS2aC1jjbT09Emeo0g6MpmDqyeRAuTa9oz7QYIDN5Gk3R
 6hBdX2ZH+dHDVjTIENX/FQHPyF5zaeCo4dnVxAyGYPDHgVY0+PtBBAn6sSaRn10ktu7jSLP/d
 2VMGlSjKAqBkWuOE8g7GbuuZWc2ChD2Ac49WFWG4buQwrxqjPxY0nvu6bEbPawYzqzZWmA4UZ
 kdsErDQ2JH2eUI79ljxhi7LTQcphAP1jTyVjNAo00hLuSQsTU/pO8dSmIH/dRNMhm7uifDGvq
 U7+/p/b/QZ+kUxdD90LWRX/QW/ZaygoQWMnkph9HX22EM5Hfx4k0UK56Z24YezJZUT+gWuCqS
 blPRixh3SE+3Cl4dwsFJkFBOhm4qzY+xvlmUykN2Y83ocN0JuchE0BbU4FfRJvWt/YOneBMFL
 j4eWC90SIj8paMcXfWw7Y2bvGHF37h8T/9VSftxhf7p+izp/1vFYdkNz/qAYOl0vyP5ghzzWy
 ZuoYlSSb2XiXhBh1KWrEmSIdUnb7fS1vY5ndwmXfsZ/SrGApUYo9RI+t2KuowXhZkcw8PbAJG
 th4jEXmkEc54H9+6/t2UEz55yST5ztoIUoZ+xl4Q9/ccuUG40X7ukg609828h1JJDlUcYkrqD
 s1IYDZtJsDFTI2YR8VMyfUcw+KnC6k1jwZwE+sWw2u9g+tNr1JkUuUAQHMPBvVSaZe9sDsSZz
 gqsyaOrre15M2RZHY0oI5tW6vGmiiX2AWvZ9t/H7TQArXaBzJ2j4OW3YrkKDXn6HwbEWp1PrU
 1OB6cYXRurq08AkTkAzdb/fU/NaQ2XG/68Px7L9+/6e34TLGjMG6LpEhah5AsAv4x5lNeZnDN
 o+ip/QEzOlDyjhNWRN6LMqpIyiPakIbQH3Rw7PySOp9yOAQ1Rilf8EQMx3FkuCshUZ0eMqYJd
 nRpJS6rn6JIPODSdoMrW0YKZOlz2ImwGgriW9XtFOvokJdSY8a1VCIzaDLnfoMOn0M0FfizdE
 A2TNtPHoId0lUrdvJt+d+MfszbNWua7jFuXaGyA/GWmwK90CXdprMyMQ9+2I7IyZqSBNNfSnd
 Gq4pdg4uFsO30s0Ud0Ez7mLqruKjcJuD9JOZ9ZscHzlMVvr8i5/af6IK6BFCkAjBczXnnQQ5K
 Y3Mh57peug6xXp3Z4mFZSBQQXM=



=E5=9C=A8 2025/10/13 22:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We have the inode locked so no one can concurrently change its i_size an=
d
> neither do we change it ourselves, so there's no point in keep rounding
> it in the while loop and setting it up in the control structure. That on=
ly
> causes confusion when reading the code.
>=20
> So move all the i_size setup and rounding out of the loop and assert the
> inode is locked.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4a4cb91b7586..096b995fe87b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7643,6 +7643,7 @@ static int btrfs_truncate(struct btrfs_inode *inod=
e, bool skip_writeback)
>   		.ino =3D btrfs_ino(inode),
>   		.min_type =3D BTRFS_EXTENT_DATA_KEY,
>   		.clear_extent_range =3D true,
> +		.new_size =3D inode->vfs_inode.i_size,
>   	};
>   	struct btrfs_root *root =3D inode->root;
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
> @@ -7650,12 +7651,14 @@ static int btrfs_truncate(struct btrfs_inode *in=
ode, bool skip_writeback)
>   	int ret;
>   	struct btrfs_trans_handle *trans;
>   	const u64 min_size =3D btrfs_calc_metadata_size(fs_info, 1);
> +	const u64 lock_start =3D round_down(inode->vfs_inode.i_size, fs_info->=
sectorsize);
> +	const u64 i_size_up =3D round_up(inode->vfs_inode.i_size, fs_info->sec=
torsize);
> +
> +	/* Our inode is locked and the i_size can't be changed concurrently. *=
/
> +	btrfs_assert_inode_locked(inode);
>  =20
>   	if (!skip_writeback) {
> -		ret =3D btrfs_wait_ordered_range(inode,
> -					       round_down(inode->vfs_inode.i_size,
> -							  fs_info->sectorsize),
> -					       (u64)-1);
> +		ret =3D btrfs_wait_ordered_range(inode, lock_start, (u64)-1);
>   		if (ret)
>   			return ret;
>   	}
> @@ -7719,19 +7722,14 @@ static int btrfs_truncate(struct btrfs_inode *in=
ode, bool skip_writeback)
>  =20
>   	while (1) {
>   		struct extent_state *cached_state =3D NULL;
> -		const u64 new_size =3D inode->vfs_inode.i_size;
> -		const u64 lock_start =3D round_down(new_size, fs_info->sectorsize);
>  =20
> -		control.new_size =3D new_size;
>   		btrfs_lock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_stat=
e);
>   		/*
>   		 * We want to drop from the next block forward in case this new
>   		 * size is not block aligned since we will be keeping the last
>   		 * block of the extent just the way it is.
>   		 */
> -		btrfs_drop_extent_map_range(inode,
> -					    round_up(new_size, fs_info->sectorsize),
> -					    (u64)-1, false);
> +		btrfs_drop_extent_map_range(inode, i_size_up, (u64)-1, false);
>  =20
>   		ret =3D btrfs_truncate_inode_items(trans, root, &control);
>  =20


