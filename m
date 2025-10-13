Return-Path: <linux-btrfs+bounces-17735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24901BD63CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 22:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555B63E03C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 20:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE722D949C;
	Mon, 13 Oct 2025 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Hwj+7b2L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19A34BA34
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388415; cv=none; b=H6qeVVtxq38E4SwkjmLunNNHPgJekvlTCdPFcbzS0x4pbfpENMOxeqBA88w8hmyQzZuSuxMyNN3wUfqtvbvBcBPlhyPUplh7dlwFNIH2SfH2BvKc3qHJvsVyKVemRxVWOsnPPKgTw8fV9LZTg9/9Nrjar+og8JsDS5BWpeZU5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388415; c=relaxed/simple;
	bh=S88bpwWo2lsZU7waDnJmHznFfQRYpLE03oM/+DmqMCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=thmJgJYHQNzH1k1us+HRv1Fsr2ZZhBCy9Uuts79EY1Bjj9gm0BeFsDCWUm5liEeO2M+ToVvu0lL8IjCO8jiD6LA/Kcg4RDH+li20wng16QXaoGvxeoFCiuDQooSCzd7hahgJGnE4bcZvejgppEpp/cuxu/LuZHF51zG4TJ61utQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Hwj+7b2L; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760388410; x=1760993210; i=quwenruo.btrfs@gmx.com;
	bh=UaPlfPELfnPGMgD5VIBq3AYrKF97aQYWPt/lz8A0FJU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Hwj+7b2LwvNqXkf+EyzISe5QsIIwmdd4XuBUrtMGSlN3D1IEv+W8V+iA/OdxTVGR
	 zQ9fSDK2xbdMt9lmCHt/U21vfjQEPWIIVu9RVuCGqAAX28JFGrWdYk91zzpk1g0pI
	 fw0YvX2jN2fez5T0cMjCbSLvahaRdGc8ESposD9TGy/oDi6REj9H1wBy5MrSpwePy
	 ORT/VGFqextnkxo+yHVL8Wa4OxT2G/1ksMWLEGkX1uqEQ8RUP3BlcoNNZxKgcNRpk
	 hzxMv+rs1i3MTeTZ9JsK7dFh58c+4nYJYTecHc2lGA8yc21EhVk7k3EBy1kM75URJ
	 yodj5IuMVz59LVmUgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mk0JM-1uOKAr34e0-00fZdx; Mon, 13
 Oct 2025 22:46:50 +0200
Message-ID: <1028b98a-2bab-4ad0-bdcd-c77c87b29571@gmx.com>
Date: Tue, 14 Oct 2025 07:16:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] btrfs: truncate ordered extent when skipping
 writeback past i_size
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1760356778.git.fdmanana@suse.com>
 <f3a857b481cdfda08d13e1eba5db53d17c5e774d.1760356778.git.fdmanana@suse.com>
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
In-Reply-To: <f3a857b481cdfda08d13e1eba5db53d17c5e774d.1760356778.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5D6Muqi5UPQPcWiuXn3LxKctpgvKc/JEocjsfvIfo587o6v8I8I
 w7CINN6xVIz3/dfYmJrrnMyJ4CSTvYEbT5RYspWl0H/Zc45HcLGYMOIt6NQ8iRgdTAwRfgH
 +VhhA1pGP5SkwD+liaQ60xpSJ18Xb8mdOAKPgNQXHV0mnKt+M6zNXoQMI8QeE1igZWqivf2
 twEKL1KTjOwzGxq+zHQlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eWfsEdVF9uQ=;E+84QVB8CIq+uYP1SnWYHohYLpB
 jj8Xjz1vawV6wbuGVa9ddzLoIbY6cX0UsX75d+PvXk1jH5Opdra1JPZ7i0LbbIJ8VcQP9UHcT
 fMPEMPANqBCoZ/ITD5H+rXBYUzDUHTy/T4CfEUPRd3w1gqOC+fCQkpsFLJS2xL7LmPJlxMPxr
 Jif6bEbUJ65NSjiZoHZzjsi9fULcCsZYujvt8if0GWPtj+uE726CSVlmQkV1/42191RCKgMgs
 vOuIZa+1GKcsUPkWHg5+2AiICDZC0CIdRv1Nuz+mPfpEcqTSTH0uyaNWSt2sVUDUOdotzAHOH
 GUezq/8BivuC7o+3gtRXxix2k1wvSFktisGe/v13OXVzwTcs4lNswrgliw0pjkeVzFFouhoiv
 DdkaX1ue+ZUOlTki9Nsj1XZmM9TWRh6q8NYHlbzt/hrOvLdCZW5byjBj9mJEo1ctCwqQ0hBVO
 7Xk9r5V7KIv6lX/pDdF2vLSzCcK/jBA3XzCmYgiww6hleFZ+Peq5QcbvuIF1J+rSAL2lHJMIo
 oWo66krCqZcZWHLLAQf083Z8KfJfv8Y0ikSW5lgLxCV49Pb1+cDA7kCBgGp9JwSM0v8GwFfB1
 o88WCdUUe+8IztQJCd2r1d8pwbRqXVVvK+Reoxt/gxiU7seZbKbxhLm9WIKh4DvaowMKLsXPS
 KSmX001OBOEc+mZ6On6Bi6FgNPmzZO14F3vLhVzjWVz3mI4ziAkBVOfnwsNPyM85cdvLJQ4Xr
 EcnlDpJmhMVbX4R4X+dM1JJ6BE7E5dTVy7Cuw1lwYqIIpLpQaJOFWkgn+L9bwOJz4qJcij7Ax
 nNwJob6ZmgfbGn3W/ZwWFmAq73+TtVr3lLRsFwvrui47blziBe5aDlwrCkXBISRLnEWnEdpzI
 IEq5vg6MGDnDHSB5i3+R1dyWFjHk/OVbYvPGe5dKPRGobGHQQLIaEIonWFLdjipcMbnTFtO1Y
 GKXM6NvUQP5ynouGmuFe/AKCAJSFpP5ophET0PrVVp5Lw2SM0UeW3EwoqpKk9EL19fGtfq3z8
 13E3gVtPRxjkj+wd9iW27DFBZ+nvgEXu/Pys1BkwKsaaXVZ+zpW/cztDPfXpJSI58ikpDNzyC
 u3aaDTJEQzrJ73dgpWfgijj3M5hGGiM28kntyYWYRSfpZXmu6siekdbDzadinY1+5S93+dQj4
 4gBp9X8DFkJJ9j4TW5ZpTb7CGisQJJKPmCMfNgEtqX7/e0CZybZDSZfvAf1mP6oJPhB+tWQS/
 mZLhYhuCCVrM18F3xGQ0xZh3cH6YeeXvn3qShrEaRto1datxtubszBnaS25UD6rFMbfRhOhEp
 iEHsF+b21tEEMwDVOSow1EhbCDgrSJtkCEQ5BN2uOXZiB1nKGsyn2yqsimkXUXZAO3AIwKmhx
 AwYik1CRHkXnc0J3/v9PDtJzM2W9PpeXTHmVSmxo3VtXMIjp1ivaeE0bJPA1HRYfeP4yFLhQN
 JAha5BOo1w3p/iAQLDH839t3uIBYJ9x1d3ZrxTfIIXP+km7qi9pVktsWLfrohixchdMpsPuPf
 W5dfSnAtMLIQvjphzU01X9OIP6X5hf4ukeIBj5xECxpYA+utmnnYKa0IPt17Dvqr20qzC3xAW
 lbgFuKOzXplbCny1M8TNF22uNkt01scKIPT9YmimNEWRldNRL+5X3y3PPt0AzR2D23cSbaq6l
 mepYrDGTsYeYe/FJvdLgJ6Y3A2MDbAoWyhWDExYMYqdrdzUN8nmHTusg8fGVoqEDuo7Z07zOp
 OZs/Ne6LBjQdecS9FdxXGPwpt0kBMIvwuF06HMi92dqsz8FEG0vxknQePNhR/OiqqYPbYT+fG
 Fe4rfgTKWm+jWYbPaezAMXLjnG/zDr3zn+8A+DxAQz/N8rPIkfmrEC+AUwoJDs5fpw45T/eHg
 QpZwpwIlN8njNhQvF8+mmUGDDVQCXec4n6qqG0D7f+bGUhxEZRi+Ur9fJYVDskU4dYoyghCv9
 34fusAGnnDATv4xJQyW+qD4YcMbbsr4KyqcAPamd7Sy/Cd20CFtQHII8F2rmomFW/h3Y1Kjtw
 5a1efj2hrrjYXTNbI6auhcPGJrJXWKsz70rQQwHh1FNjos2uAKXw+47MS+9W3Pq/v5LWtTTMd
 O5XO/PB9w9HVNt69zZKx4cPt11Sal+kslF94zp/SGsdATdAMssmKKxQsTEYSXcYm16wFqtVni
 ZSfFLR58lv+khjaTrOqyE3lKzO/SeWvXUPCDszMYV+4iJATb/893+RTWttOU8ZJyzqXx98OVM
 J08pIqHMjMstnF1OgcEh6Hq1+71rE/3gN6GeVbWI3QhU/V2f1mwbVWWnkWoH4I8DxGEIlAN4g
 n0OOqwMpyywlNt705MgLD2gfiX9XnupvnqXE7o9PkeculE79g0nnrhsTStbQPaLzynpiyOXa2
 VCFv/6py9o1hzeeRW3E/T3uIdJHhnDuCaKJ0lCGJ+PoD1UzUIcbDZCvpW2vRZCvi3PIQeTo2x
 i65fQz/3WajOQP8CB/XyRJnHcA4ufkYJHbG62hfUs0K39HnHMDeozzf+sTk/+nIzZ3N1fvpRc
 REYUKgNLJmdMsqueSIy+eScP2RSxVmAG+Je4F5E/K6z6BX7kLzYHz51xKuZW6vJ9D7Z+MN9r0
 rXC4Hkw3Pqn15j76IRv4aWEQbfkZX1Kt4auYk9doh4+z11LALHud3ynLBFzrVRsQTn/RYu3Qw
 VDERM2tpeZgzVaaMDElZKOjWX0WQqNVmEx0FJHg3nkWSppWnUMaweJNrq0XRQ+vuGNHDwlhq7
 Xb5J/XZVNQOTkrTeYoPQhoEloVwggkkuEP2DSDRQTXWZlBW+QfGAFM5JSylJfLCTsIUF5Ghu8
 LtC1O8x7KtnCyvxFugr0E53rDut/1dmfU4ne8fS80nQ6BDEbgjfE7YdvnGdNi2xJXkH5kCiHV
 dzmkCrN9kjjKf0lEQStdlG7M4xxJ1jwPMsi1osadPUHHFREG9IbdI+3Jqh3GMktN4/bUnFhGY
 SZYXM78Q/kYUuHBz1QxRgg1Xkpi3/JXCczhMpnzvrA+9gl5rF7R9Hx2qWNN+N4dmW7ytvUu+n
 UpCL5gnLarOXMkPyk2zDIxXoJrEM1oUeDcjuzAs5Z8FReOtq8A09Aa3t7elRm5nUv6jDwmL5H
 XCkhZQvO1vGjJWMnJilUszZbHnAIXhyaPVflMhqrl33DA4cn/9W6k4yjm7xzNkG8WSQQUBWnI
 0p4dqb7EIU53wkQ+l8PLFlBm0Hb8o0W2LfNZFsBReyqWuwCFnQr1ljHTQA6H77uutE81MzrvO
 N4raj65rJEyDpmdu3+TcIRu7YQYBZ15xFMpuapnzIMqldNmmkEP+ccnZZsKgo3YSKsQvQKO2m
 87szXiT8Nut8QEWWm9+TVt6RoseWAV26vhX5gK9VtC+b9e0o+aNpjvsL20kfJReKcGbrjugXD
 8zfSS7s1/V3kjabHCLqQno+MVrqcoS14fq3p+CF9gEb/eKIeylshrXU/HouUES/ONn9B82v1j
 GK+N6z+LUi9RYhg5Jfk1b/omixSE771BB9bLXKgDC7+bgUjdyeheATm+XjgUdjY/rNAtDwvlD
 +4ftRRgOQWyksz8P7E8eIogNaaQ/O4wFhCR1+y5mZIEM9HxY3XZah39S8Su/rUM9BLLQvt92F
 YiCKMr6Q83JwDihDi5uB2noY8lHzb1w1BosMF+KXHGzY08HOQEh8xcNlsT4+fyFiuVbe3WYzP
 tpqorBPMDS4Mlp4bGYjPOa3yfpBOvWMjTZLCCT57iZPOOeIxwHFpkG/Y9lRNTHIRq9vshhmkV
 fmnho87lMyQ8fC0/hJKsZn3Pdz39g1KHTW7WPbbpfdXPGhNKIbUgINBSwCgKWYxbHpEwHdodi
 cGnAEI2TUMn46/HuUyKEulPiUOYLJCWY1StM2SomwjkzcUN6bHxmmVyom2Kb58ERQKDXQsLT1
 PZ7zqhcRcil5NR7OWf5AQLAoxx6Bl5v6/EbJlGi0QZqjhRXsJvsNPTMz9EWFNRbQz3JdtdMP1
 F++U+xPxywiK++YDsyt5E+kpATgvbXviWers4/R4NvQFnq2tWdTeyHuTMlW8ukOcnX7pGVrTd
 lRVoL8QzwIoZR/s3H6vxA0KZaqIZxghdbItzbgZ37yqYk16TjkAYV5oTylpW2uyWokLKb6Rgd
 JibECWYMCBJgp4902On4DJE5jQuD5yFr1KzehdMg4zAiU4rzywTXfuAgkKEIjaVPkNIK2CT3Q
 We2K99jlO+On/+tMJqNsmpy9LYmHawqybxhBDmrEifGGaOW9qQsERtMydHgG+VCJSVERA2YKz
 EsDbc+0veXIVWS55CwQrPw2+Ygd1iQXJ9ESJimxCAGyeUR1BI764F7UczJUqITX7poXywvLBG
 r0CHUWQuR7tjjXv50yIUl6kDavYihfzd04IT7X4rBxqWFtfi2alUX9iMj0bFOJd34BPo1Jfra
 yotJ145PkbpJskG3sGEiMHtQTANXv5IU54dPjWkjMJiGOon6Z+rfrIDAcjp+usR6tvWIgDxGE
 MKw5Zx+Ja4mAdsqV9RE7ieots2fJVGh2+FqbUe7o3VZPXMJj6Kl9XBLCWKlHCLuLDRGCgVfjC
 f4q8XI1S4HXJ0Zhna8x7ls5ss1ag7sXDyFDWyiS+jXShPPAEpm/+PqgByqT0BVN6MlOx/5IMW
 t/z/kvpB6648Sd8PQPkjImiTxoGXtaOG7Vvq/ibhjLfZBNFL2FzZqlacs08Ctn5/gisHXpmal
 RyuqHB8cBKz+vHnCn3S42qsxVrJMESriT4TOkQvagAQUN7lchn4JWTIEc7jyH9+EOWHwSI4uD
 rZxWMhQhrK1IuGupuvCL0csQLAv2OvIM8BG0j/VZQfgqUTqTme32up8YcQ2OxHohW5wSURNQf
 rzgvNHP8/nkRauoaG6eQATur7NbvNeo8mwIz9/tKTcgYs3oMTkpW9U3btn4f3+Rs2ESVue0em
 LR1nPEJy/yOH68w6A413xcxiTPSuxrvZurLsCJLNInr8NWVx/7lP6fZNDBDG515grh1z3z9yk
 V1okvaP6OSLOo8LtaO7dpYGQrnkrbqWxaDXRuZhm4uM+zEDL4Qb5XBCku3c+u8x+ZVZ9DJ2G9
 kebOQ==



=E5=9C=A8 2025/10/13 22:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> While running test case btrfs/192 from fstests with support for large
> folios (needs CONFIG_BTRFS_EXPERIMENTAL=3Dy) I ended up getting very spo=
radic
> btrfs check failures reporting that csum items were missing. Looking int=
o
> the issue it turned out that btrfs check searches for csum items of a fi=
le
> extent item with a range that spans beyond the i_size of a file and we
> don't have any, because the kernel's writeback code skips submitting bio=
s
> for ranges beyond eof. It's not expected however to find a file extent i=
tem
> that crosses the rounded up (by the sector size) i_size value, but there=
 is
> a short time window where we can end up with a transaction commit leavin=
g
> this small inconsistency between the i_size and the last file extent ite=
m.
>=20
> Example btrfs check output when this happens:
>=20
>    $ btrfs check /dev/sdc
>    Opening filesystem to check...
>    Checking filesystem on /dev/sdc
>    UUID: 69642c61-5efb-4367-aa31-cdfd4067f713
>    [1/8] checking log skipped (none written)
>    [2/8] checking root items
>    [3/8] checking extents
>    [4/8] checking free space tree
>    [5/8] checking fs roots
>    root 5 inode 332 errors 1000, some csum missing
>    ERROR: errors found in fs roots
>    (...)
>=20
> Looking at a tree dump of the fs tree (root 5) for inode 332 we have:
>=20
>     $ btrfs inspect-internal dump-tree -t 5 /dev/sdc
>     (...)
>          item 28 key (332 INODE_ITEM 0) itemoff 2006 itemsize 160
>                  generation 17 transid 19 size 610969 nbytes 86016
>                  block group 0 mode 100666 links 1 uid 0 gid 0 rdev 0
>                  sequence 11 flags 0x0(none)
>                  atime 1759851068.391327881 (2025-10-07 16:31:08)
>                  ctime 1759851068.410098267 (2025-10-07 16:31:08)
>                  mtime 1759851068.410098267 (2025-10-07 16:31:08)
>                  otime 1759851068.391327881 (2025-10-07 16:31:08)
>          item 29 key (332 INODE_REF 340) itemoff 1993 itemsize 13
>                  index 2 namelen 3 name: f1f
>          item 30 key (332 EXTENT_DATA 589824) itemoff 1940 itemsize 53
>                  generation 19 type 1 (regular)
>                  extent data disk byte 21745664 nr 65536
>                  extent data offset 0 nr 65536 ram 65536
>                  extent compression 0 (none)
>     (...)
>=20
> We can see that the file extent item for file offset 589824 has a length=
 of
> 64K and its number of bytes is 64K. Looking at the inode item we see tha=
t
> its i_size is 610969 bytes which falls within the range of that file ext=
ent
> item [589824, 655360[.
>=20
> Looking into the csum tree:
>=20
>    $ btrfs inspect-internal dump-tree /dev/sdc
>    (...)
>          item 15 key (EXTENT_CSUM EXTENT_CSUM 21565440) itemoff 991 item=
size 200
>                  range start 21565440 end 21770240 length 204800
>             item 16 key (EXTENT_CSUM EXTENT_CSUM 1104576512) itemoff 983=
 itemsize 8
>                  range start 1104576512 end 1104584704 length 8192
>    (..)
>=20
> We see that the csum item number 15 covers the first 24K of the file ext=
ent
> item - it ends at offset 21770240 and the extent's disk_bytenr is 217456=
64,
> so we have:
>=20
>     21770240 - 21745664 =3D 24K
>=20
> We see that the next csum item (number 16) is completely outside the ran=
ge,
> so the remaining 40K of the extent doesn't have csum items in the tree.
>=20
> If we round up the i_size to the sector size, we get:
>=20
>     round_up(610969, 4096) =3D 614400
>=20
> If we subtract from that the file offset for the extent item we get:
>=20
>     614400 - 589824 =3D 24K
>=20
> So the missing 40K corresponds to the end of the file extent item's rang=
e
> minus the rounded up i_size:
>=20
>     655360 - 614400 =3D 40K
>=20
> Normally we don't expect a file extent item to span over the rounded up
> i_size of an inode, since when truncating, doing hole punching and other
> operations that trim a file extent item, the number of bytes is adjusted=
.
>=20
> There is however a short time window where the kernel can end up,
> temporarily,persisting an inode with an i_size that falls in the middle =
of
> the last file extent item and the file extent item was not yet trimmed (=
its
> number of bytes reduced so that it doesn't cross i_size rounded up by th=
e
> sector size).
>=20
> The steps (in the kernel) that lead to such scenario are the following:
>=20
>   1) We have inode I as an empty file, no allocated extents, i_size is 0=
;
>=20
>   2) A buffered write is done for file range [589824, 655360[ (length of
>      64K) and the i_size is updated to 655360. Note that we got a single
>      large folio for the range (64K);
>=20
>   3) A truncate operation starts that reduces the inode's i_size down to
>      610969 bytes. The truncate sets the inode's new i_size at
>      btrfs_setsize() by calling truncate_setsize() and before calling
>      btrfs_truncate();
>=20
>   4) At btrfs_truncate() we trigger writeback for the range starting at
>      610304 (which is the new i_size rounded down to the sector size) an=
d
>      ending at (u64)-1;
>=20
>   5) During the writeback, at extent_write_cache_pages(), we get from th=
e
>      call to filemap_get_folios_tag(), the 64K folio that starts at file
>      offset 589824 since it contains the start offset of the writeback
>      range (610304);
>=20
>   6) At writepage_delalloc() we find the whole range of the folio is dir=
ty
>      and therefore we run delalloc for that 64K range ([589824, 655360[)=
,
>      reserving a 64K extent, creating an ordered extent, etc;
>=20
>   7) At extent_writepage_io() we submit IO only for subrange [589824, 61=
4400[
>      because the inode's i_size is 610969 bytes (rounded up by sector si=
ze
>      is 614400). There, in the while loop we intentionally skip IO beyon=
d
>      i_size to avoid any unnecessay work and just call
>      btrfs_mark_ordered_io_finished() for the range [614400, 655360[ (wh=
ich
>      has a 40K length);
>=20
>   8) Once the IO finishes we finish the ordered extent by ending up at
>      btrfs_finish_one_ordered(), join transaction N, insert a file exten=
t
>      item in the inode's subvolume tree for file offset 589824 with a nu=
mber
>      of bytes of 64K, and update the inode's delayed inode item or direc=
tly
>      the inode item with a call to btrfs_update_inode_fallback(), which
>      results in storing the new i_size of 610969 bytes;
>=20
>   9) Transaction N is committed either by the transaction kthread or som=
e
>      other task committed it (in response to a sync or fsync for example=
).
>=20
>      At this point we have inode I persisted with an i_size of 610969 by=
tes
>      and file extent item that starts at file offset 589824 and has a nu=
mber
>      of bytes of 64K, ending at an offset of 655360 which is beyond the
>      i_size rounded up to the sector size (614400).
>=20
>      --> So after a crash or power failure here, the btrfs check program
>          reports that error about missing checksum items for this inode,=
 as
> 	it tries to lookup for checksums covering the whole range of the
> 	extent;
>=20
> 10) Only after transaction N is committed that at btrfs_truncate() the
>      call to btrfs_start_transaction() starts a new transaction, N + 1,
>      instead of joining transaction N. And it's with transaction N + 1 t=
hat
>      it calls btrfs_truncate_inode_items() which updates the file extent
>      item at file offset 589824 to reduce its number of bytes from 64K d=
own
>      to 24K, so that the file extent item's range ends at the i_size
>      rounded up to the sector size (614400 bytes).
>=20
> Fix this by truncating the ordered extent at extent_writepage_io() when =
we
> skip writeback because the current offset in the folio is beyond i_size.
> This ensures we don't ever persist a file extent item with a number of
> bytes beyond the rounded up (by sector size) value of the i_size.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
[...]
> @@ -1724,6 +1724,23 @@ static noinline_for_stack int extent_writepage_io=
(struct btrfs_inode *inode,
>   		cur =3D folio_pos(folio) + (bit << fs_info->sectorsize_bits);
>  =20
>   		if (cur >=3D i_size) {
> +			struct btrfs_ordered_extent *ordered;
> +			unsigned long flags;
> +
> +			ordered =3D btrfs_lookup_first_ordered_range(inode, cur,
> +								   folio_end - cur);
> +			/*
> +			 * We have just run delalloc before getting here, so
> +			 * there must be an ordered extent.
> +			 */
> +			ASSERT(ordered !=3D NULL);
> +			spin_lock_irqsave(&inode->ordered_tree_lock, flags);
> +			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
> +			ordered->truncated_len =3D min(ordered->truncated_len,
> +						     cur - ordered->file_offset);
> +			spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
> +			btrfs_put_ordered_extent(ordered);
> +
>   			btrfs_mark_ordered_io_finished(inode, folio, cur,
>   						       start + len - cur, true);
>   			/*
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 2829f20d7bb5..8a8aa6ed405b 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -1098,8 +1098,9 @@ struct btrfs_ordered_extent *btrfs_lookup_first_or=
dered_range(
>   	struct rb_node *prev;
>   	struct rb_node *next;
>   	struct btrfs_ordered_extent *entry =3D NULL;
> +	unsigned long flags;
>  =20
> -	spin_lock_irq(&inode->ordered_tree_lock);
> +	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
>   	node =3D inode->ordered_tree.rb_node;
>   	/*
>   	 * Here we don't want to use tree_search() which will use tree->last
> @@ -1154,7 +1155,7 @@ struct btrfs_ordered_extent *btrfs_lookup_first_or=
dered_range(
>   		trace_btrfs_ordered_extent_lookup_first_range(inode, entry);
>   	}
>  =20
> -	spin_unlock_irq(&inode->ordered_tree_lock);
> +	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
>   	return entry;
>   }
>  =20


