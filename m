Return-Path: <linux-btrfs+bounces-21725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HD0MjrXlGkYIQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21725-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 22:01:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A2C1508F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 22:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C75423034C80
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 21:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0222D6E62;
	Tue, 17 Feb 2026 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jv8kEBcL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F225CC6C
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362102; cv=none; b=QZJGlq0lXwXc0dafw+pOpf1olT5xTlgywWSL8wNU/zz2nN+7osHTao3N9nMMwdhiUCLuWAI1b1owQHQAc4I2/5OYtL5ZWUKKQQLqLJFimT0ov5mnEtFBOgYyzW+M9+pgS8Pp0blecqO/TTQNtUwCAovmnvysmYIFJrHVuWpHx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362102; c=relaxed/simple;
	bh=u6Mc9gb0qlaISUR54ZnNarKDzkzyTNSd8LGzwJWvGoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0poVtz+1mdSdoMG1MzeYo2+xmwzECqaMfmQSkk0gO/gjB8gql9l+unsi7OQ8T3JJfruHszRWWvvpT4kvLfKVyH0MU0nSpejM/4XAguu3lOGOagjxzc/i+L4rKjDnyIa0UlUpu3KyrPdj34diYf/OsNG9wWuTukq73KSYQEebiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jv8kEBcL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771362095; x=1771966895; i=quwenruo.btrfs@gmx.com;
	bh=AlcjbVsaxmKXMLloe2ulzsyoJeuNOaJSpIQ721KUdrs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jv8kEBcLwAUX7gwoPfhGdmmF6AHicHD1zU+vpSqrH4wEiVnstDXUTjebuIs54iqD
	 qrA8X5JldQdO9yK3inngSFjJ/z/Yh0vY286HxWn2C6EnaWEzQqQRniqiEanODyPMs
	 KboCcKnNmv8igruKgbEsPauyR7yqcfrYNU3Z/hwmUiyXiUH47NF82gH9E9OuhlFyO
	 eYPVZ0d7PzGDz1eGURVEm+kD5W+llqTj3z2Gb8wbg+Kvx6oCd5Vm4abzCvktwbMtv
	 HPY4ZpYpkDzB7rLedb7KZPXB0CY4zo/g5y3ueL7Ad80U8p+CDPuXBAQa4LEg3pVhm
	 slOQRqAJ3ZPq9ttc0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MlNpH-1vTKZk3ffp-00aPZH; Tue, 17
 Feb 2026 22:01:35 +0100
Message-ID: <5727c20b-9d86-4c7e-b760-fe28691ec430@gmx.com>
Date: Wed, 18 Feb 2026 07:31:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix incorrect error message in
 check_dev_extent_item()
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org,
 wqu@suse.com
Cc: Chris Mason <clm@fb.com>
References: <20260217103419.19609-1-mark@harmstone.com>
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
In-Reply-To: <20260217103419.19609-1-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dw90RnisYpV4HBR2qMndblhaI8ZjBna0GH2G9u3aAvG6EoN+RVB
 aJ3SpFrQy+LpgxL8VJ20hSCpIh17adfOz58nraAntMx2mgzA+3Q6rZ+mO962a2guuxs5rv5
 YV3jwCE0s0BActTCn1pCMvDHchj+a4mUxdrfrLyLFnJ0O9LFdzKp6arqMJVL09tj2db780E
 sM/USBGG78H2JILpt646Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6vYvfYyDlQc=;2pHLiVN7qMB+ylFT2lG2EpUqHz+
 wfiB9KcjJPmTSfEocnCD5Xrx8E3wipaof/rhIODU0YdcjVZIjdRh2wrIFgsEF7JOosdi338vh
 zK7yil7Gzfe2voDkaYjYRHIzp4TUCiarv44KE9j2mp7flUQm8Yize8cClNtQnuac79LUNnAbA
 kbTBEEogib0GjjhtQG4CPtXK3jxTUyacU86K4cV9LhHHZAYuJ7U/W/6hbysvV4pAkta7cZS7G
 1ROeOIyPGFaAeHDHhdxPPt+x4KW/pQLISqllMnVqBgF0pxkDWOO0QFVW5f3v/CZUtDUKFr3jK
 WMc7z6I6LW4vgLU6jxRnFC07qc7uEG9jNCkEYHaCe+k/WURTA3/icFBlVGL3/pPkoo3wuX6x/
 UivYqBfk8x5YhFFxFEPA6IU0ws1Ciu8ZhBqzCjMd9HbyXn0pWxANAJCKrE7199u1s2MsXdxYl
 b0vvsfS/eDdP4W/iCSJFdUMb2xzyFh3fv63jDXfQ0Q+4hmTS1hmQqBsQsN07snNSTbeYy/G7g
 Is9E2LBFhXU2oJXmDCVGjDisYng4zBWcQakhhRSDGR3BZ2ea+ABIZKg0I8ZmWTCYflaDPNKj7
 dzED9MvYd+MObf17hjHX+b1Bl3kyAa87hVoUR2Q4YFpOwIRNxHAMyxDL/O1auymvDKnHxzbmE
 Z1HXHQqY0c9KkGDO27SfZUdTyY7B88mMNimazPFSikute3+aFO+I1uFX+KDe8L4klsocBG4nz
 Wg0L2Btr2UYSV0an8YCfbwWHnvkxvEz1/dWajUgP7W5XNvm+ZATfoBWnuSHOxENXVzvy89KSS
 +mvFXsRo1I/QysEb5oEuvnu8d0sh2aCospd3pFuRtlwiJvOTZ/9NSxlCUEv6zZhaIxodibdgI
 z+ImQpwbp3xBpK2mIyUSQqzQqyWTN+J0IRyhKBhQjtwclv9H1luUKpOCUeBPwlFO8mMCOAgVV
 vjIKKy19kuDKpeRRVrqqlvWwq9wr/SDhVU+IzwHyyMo1KkXY+zDUFFrYr2ZS+VFhh2VD1ZK2K
 ZGCg7sDXXbiRJpAmnRcL+kuJCkjONIhNthTrhFSVlON9O4YGBSdFW/YUR5ecZraTpFo375XVt
 Zo6DQkVXArKZRQaeCwHZ1hlcNqoTbTkZGsByWGdNG/kzZ9/jX6o33rZ+MWFFtngnme2ppH463
 t3QEtVW0DuZQVe2Lw7wCYMpi2Ft1VLEM+r9hA67izAS2DgTiu+Q2dkHCt4cCMGAGbKRobZqxh
 HKGJ3HbwqL3ZO3lsRbPIf9EqxMx6nU2TgpFP3SYGOma3FGUeMwrNumPXYQinzPzGUjUG9Q5vk
 DCDBJzCqqvdtRSbmjU/BoWBKHd7GZoxIFHeZKkovxj77K6gGEKpUaGX6ApSc0rn9etpKjvb2w
 X5nafT04k4HWsUBFBfGqBmoNsLvecyWSD6CWUCtS7Znl7203w4gabRQbRW6gAS0XysAvxmEOm
 jJ6fe0vtQICc84sTSuk/tf6j5k4GwkMG++QmivXl+4QjASMP/+V+pAGYGkUnYNqbTQvNfIP/Y
 ZBLnZF9w3/ypeX7KNgYo1Qbv2+Md2L8LYOUKcTucdaRIPIHGpScDYVSq8mmEocJ3iArfsTQDP
 XvRrWm8smNUIEmzPUuYpplrTFAznfutPCDfxSBFCBFiqWNdod5D4IHKTr5sbc7KzJVRlUCI2S
 t1+5tDiQ4jbdTrEZUMfJJ7fBC+8XB34HHRl9+racClgd1mP+fPjb54/FFyKQM3/pu3hUUQgLf
 9o0W/l0IqUFW256yOXqOUIdWqSBwpicBnAPbYFNIdB8wo6PbtldCaR8JuXOZis9xiNZKZieIc
 J0LYRNceJp8lM+Kx0RyI6OlIDOCM2RkMHWIWv/vIIMIt5RLyiJ2U9k5LP/v578CAWV2g1Wchk
 JMGv+BBx5+4lHi3LMlm8Y0V6Dvf1ExphqnRChO7hqZSZ0ZiRcSr3ERe4z1VC3TZBzspw0S6hc
 65HepUGhXIY3eu+BhhoZUPEFSYDx6aP6LTESnwqpLe6fIyK9BFWLomXnkplF8Ep8QmXxNOZXx
 hTqBmipEwxDxtQfGEuKCfihMERY/ErWpADMltcXry9uweeWttAaZ5IopKXts7hVUZ3PZgiHqo
 9pbTWx8BoiUMQczFBe/mnufBdhe8g5751hr/ftcUgCJkZGrvCrH6xuUXz427Qg+g9nx7R7r/E
 E6xmqE1BXU0UYzJ0vncUJu55Ji9WIMVMLRQgsH2o95mTgDjiK430pr8qTUGTcM1gVpMmrwiQi
 /3SeNHdTKcpXofmp77hDKzm78SEYIhbW9KHzxVRLZC5LWgqUsWHSaC5EZ9n5iNUaE7ROHnUqL
 FFq08Y6MUmjISW7aR9dqQTI/nBV1xqvCQXdBlBa3ltoWGexYRuzbqZcsqcVhI+wJMrrDlW1LJ
 7M8G96t36aIbkOUrT5yoya8k0/BoVvfMKfWd5VH+I70RPstj1iuxQccD1A4gEjRXPM6r1COcu
 ocE9Y8+NlLjcAgYN9h0aHwGJ0Yp1PuwZrwfSmptSNLD/MyqN+bLVW3aFR+SaAiMmc1t8vQ8ek
 mpjx3WiibaQe5whxcyVj5M48Tf6e/yIbFJEpbsCU16t7Um06/3KhhOORavXSK3pr/aZmSEfzB
 Cv9sczCzWfC30KKskgjDhWy0YVkSN2dKrX9LxXsUdviyXnzFvOo3EF0TdeDRMqqEDwzcBWtBS
 vALxkWEdY52orOPxxQfOPzEvV8MXfrxKD3N8YSS0RV/vNzaw3P6Es5EjC08B+ieU84Q33aqQV
 G2mcrPyjXeBYNv1N/hhol322AzsLqPqRbA10bHFuCktv3Ikwb+Fkn5sTtxfO7diie6gA6tCAb
 ofeY+DESZNx3CqSM9DCJdLSLR/X22cM3rzUjNMS/keAWB/cjBbLzGQ0mATkZZKPGifiLfnuds
 5b9JNcmClcu/4AcO7GLAUxHg/gpbVRSan/ZAQAXv4uJUGQMsdFJx7g/Fd8bdPzENOpnOZlXRC
 fcJmf8A2QB3K3yjzmX8dd0xpRpCoGwAcn1JuBcrDujFg5e0cOPOTO3PKEeJGehfAfaD2CdgF9
 AhAE+XznuUu57FvjDMO6hUZpQ8sOpQQJny78haySGy8SJc8r9o62KqhbqYnJ5Hv7ig4vdOT1r
 1VxI4ri4OsbqrrsXjzwyUcphDGbHzfNzNx8LwnKjN1LEPS00H/8ncWJA34ahoFXw4ty2LT5iK
 XyqxnqnG8UpONgRwGen0FXrDX8pCJ1po/ljoHY37Zc8qyHlh12zduO4d7nnD9yENzXYtv3HWf
 w+bBDQMeZbMe/8I8wOFhhjTzLEprnMIHicRvR+J9bIJkeNb7M8TwrKtuP3+h5o/kBEnox8vUi
 3RfXE0wMSzpyN7JeYVzNu4KqVvCR8LEsstetymahjAGctXuo//93OvZBxbxl69umytnrBIoyB
 +Ee4bBWg6DYGuFB95xJFrZ9NMkqjwbph+mPPAu2axyf7yOXUZ4yUa8gTK3M80uk/b4JF0sLkg
 rbOfZ6BNzw7zXAwB8/eBZeMzrFFUZy4FjGxxDk3cO6vj0//j4w96ri4nMAmMgw8KJJHvCoZWB
 noC33+wcDcZ62HxD3KuWYTOkygXxlXcxuyCUlf88ek52uCiVb8jDgS1azhSiSANQDbdo1RzIc
 vxTnWtwWoUnz4wGy4VDy1Vkg2gFiA9p4PUAOFxb114FAHr+9vgT9W8m7S1WxdHbJUcZ2tdJzH
 1d48AmuP43SxRSB4JndnClB9or3xExa7bX/4YOCA0bifrdhjFnxdIUJoO0P2mDevWs3bfGW7z
 HcnYxPfiIWl6UdJKztA9dhICPYXgrykuu3J1oDRo3/V65LvsNf9NrPLqfj0tQB6CKkyG/hu5b
 6ulyO4dB+4g5jFWE9pBRhkpozaUwqiTvThgGug1YnJXMColh/23tE0s3wqIzD7LjasKP3J/GM
 KU4RZL9fFqm6ehuVFM/TWvWpyk5/tlMEBBNiEkD0MyyZPaCjjFOnVIyl24p1I24VSHYafJ1el
 WUCfKxrxykJG/gTgDcO9bBXZO051PUpKW/No1aVqTcJxUAZMrlO6OkICkWmREEIQMy8qEgp+c
 5Wb7lvwu3OkNHW9iRMA1zRUj0GDp2LTjBL3hNg2nzr/okOea8uYlbRykoWitvGz7cL5xvdmZj
 L8V4SGhnsSjjrnyDIcv6dLRvhjS40uKAVg2m5rfbDItlOuQq7OizVdV16+yDRQe3ui4rmnhjM
 MV56yEpzzI/19adUHT2fhWFp2SLx9C+bdFyEBzlyoZVEVpzSuGGMSrZ7oEWXALx6w06SCoKx1
 e2LTpWrqNeh0/9H3XAwfR5c3uDII+yHK7OkkjvLLyoKuTEF81ajh6JU6UAmlOmXahvX1xR5gG
 8JSqWJAJVazxLhU4yWzoJNh8jow2RDdAoWX5gDSHjQSh2smB66RhAqqrgtFn8LhzaJ3DdckA7
 p4epNUciN51IeiaRL90vw+J6GjPD+qsENaH/HC9+br8UKFp58FFtiWxYUSEb8CDcRzQsEIMZl
 0XQHiebJJPgNfQ5RfEUyM75SjU/WsG1slt2B9R7zKU5hcHZMkPCJdCvhipaxwUVpnrn3kNydC
 pAtfiMPRsYJvjdajNWR3G7Zr8ZzH61Mga2Uq/bsNKdaBN7AOaqVVMPDqCZGDgoBAFjKHKmSz3
 gblRejG7A0Ll5q0UkYZV1xnxaTRKcUfqbqvDFarZ08nTfCi2+f1sITCq58j5VEByffsI9SJMe
 hhNFjpRkhtrRSSIimxiv28mTKWdSxAFhfEZmaFAZCJrLgwAWfDpyUZWrcQOIXnG357Ol6uxZK
 f99wcOdyY6Dc0qNKJChZ2YQHgmrjxy1EWiBJAAnhr4WNoKm1HOKpuclzM20S5kQAm4i1kJc3n
 SsfMWz4gFhyM0GGwzuY2VDauG28IU4sf0X9US3XMFAwd5Irp20eAgmLJMTyc44YBLpg4UZ3jT
 We8iDCE41Q4Ty+M5A5rk+2wKGTktfHwJnV4b+kKY6CiI0xE8Wu1LL7Lr0inpSf1BLDq4O8xtU
 +o0QUf9PQm7MqHvdVT0P5ijEmVoYyeVzHaUw3jkcVTlXamWPNoc7MZQ+RX1utoaJ1aq1NBxe3
 jYUA6cW1QjqL62IEV4LzqGbzOrFAuUcpcn4guEi3w66M5AkLaDmG5c1txstdjIlMBEkEX2V6k
 L3V5i41wdmmGH6M9fjDA66UCoIKRFO5QY9dTdW8x5v9myczZMHF0wOIiR1/wJ26nQ993lxJ/O
 oanIQdrqx2soXwsbmu6+VBp/Ts4wRUFeb1Pe4c2fe4mzH0gFKwg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21725-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmx.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,gmx.com:mid,gmx.com:dkim,fb.com:email]
X-Rspamd-Queue-Id: 39A2C1508F5
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/17 21:04, Mark Harmstone =E5=86=99=E9=81=93:
> Fix the error message in check_dev_extent_item(), when an overlapping
> stripe is encountered. For dev extents, objectid is the disk number and
> offset the physical address, so prev_key->objectid should actually be
> prev_key->offset.
>=20
> (I can't take any credit for this one - this was discovered by Chris and
> his friend Claude.)
>=20
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Suggested-by: Chris Mason <clm@fb.com>
> Fixes: 008e2512dc56 ("btrfs: tree-checker: add dev extent item checks")

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/tree-checker.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 452394b34d01..9774779f060b 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1921,7 +1921,7 @@ static int check_dev_extent_item(const struct exte=
nt_buffer *leaf,
>   		if (unlikely(prev_key->offset + prev_len > key->offset)) {
>   			generic_err(leaf, slot,
>   		"dev extent overlap, prev offset %llu len %llu current offset %llu",
> -				    prev_key->objectid, prev_len, key->offset);
> +				    prev_key->offset, prev_len, key->offset);
>   			return -EUCLEAN;
>   		}
>   	}


