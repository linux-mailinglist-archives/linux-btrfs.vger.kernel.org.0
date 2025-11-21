Return-Path: <linux-btrfs+bounces-19257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63872C7B96F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 20:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42E784EB0AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 19:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6372DCF61;
	Fri, 21 Nov 2025 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HyzGXvzO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D52848A7
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754592; cv=none; b=a+5kn9ejQJbaBcH/EfViP+KropY7KxexWqktMWWQt8Xw9KNQYRNHHOyw8ZuS+eCQLuNlAnKdmOWwepfJBr5BQhZSivSas1mfv5Zgg/Q0g9aIkAge+Zv9hvOuVsFensZ9zEygbJxLecZd/ohnFJfOKUU0XPZVPRK8ZnVxO2XaZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754592; c=relaxed/simple;
	bh=+e4Rl1ZWKTCWCenuqyVo4ndyxaLnRSqfnn1tB7ZulIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DnKRdQPidarbDH28a34DDuF0lyCT92QgFTUH+2qdCrWFWKJGgjYej0Ne+QnOSP1/EAAFLUpuu/ikrZ7qDLpMRUJoFNxSbuwIuJNBp+ZZ3PYjaa+3YnYNCETAXmXcJoVmc9WILT8OYM4L2bnAmZCV+32DmCnZbpKyB+4LPKo939k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HyzGXvzO; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763754587; x=1764359387; i=quwenruo.btrfs@gmx.com;
	bh=RR57XFh/5nZZe873sW9pSxiNEjVPJvlxVFAvKYltDnA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HyzGXvzOfBvhLoyTa+W5KzqgIb0y2KjZvNjLey41LUoEq0We8kJC/YiZscRlfeOx
	 5nGucFQ742Pl7PA0yw+o1U2er6PN8RTKfK2MVNq4qLEnSdxynlZHDnKjF2qYxlQji
	 jVyo9pZCBVZ0+X8l7vxYoNIfGgQcWYhbXZxNw00GiHBx/SKBvgdctR8M1DqbWcbRv
	 7ouiFtjKqN/EwJhgFOgVID9BggUAPEsjaQ4eTlWz8QkisKrRUXoAr8Mziu8E1W7Mw
	 UoPrxveN21PH3nciG29ipgh680lfgfb/qcenwCWMgfhDByttEe/xDY0yLQdMVdTTq
	 hk9sr8qI0KZpcgQxtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dsb-1wA9kt2tTZ-011La8; Fri, 21
 Nov 2025 20:49:47 +0100
Message-ID: <4ed8c339-2f61-4bcd-874f-0190563ee996@gmx.com>
Date: Sat, 22 Nov 2025 06:19:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix data race with transaction->state
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <cover.1763736921.git.josef@toxicpanda.com>
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
In-Reply-To: <cover.1763736921.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zUqzncmmDjoX7kWTtTvSTqjMaoYE5YEtls8ev4GSEmjZ+A8a/LU
 NU5OpU4OdissBdRra1Oz/gR+vRcBU3U86zT2LfhDinUBPX09jfQSFsjmjcqMqRF7s4nQ2z1
 +rGcJtShmJHU6P3Cxv1N5AkW+Lho8vW2Fka3mHi+V8avehODShWb44uJcXnu+X2PWE7RCr8
 n7mwlabaMnhpX/scrzfvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YJgRjwtpdu4=;hbIqkxovyKFiGuAlhabQ+D1NEe6
 NqtxZZNVua6mLCvhOvsNoTutAxbUmKn19AJ7YJB6w+8pNOltbRzahgS8DHj5mgBQxsx89CTbk
 BW8kuhc0ZUtn0n72bRhrEsbiEAtY2j537+gU2YPdx5nGsSngTxqFmVETki7oMosRBouLWgFJg
 7vAG1l8ZNryYQaS6LyofmeoFUwsmrLl5cdhc//ECo2xrJl9SDUX9vAfAW8pUwRwo+nyLojWo6
 5IZVEHzKznJt2DWOeGB3MbiexcRkCHc0OJ075DJhFO37wA4sLV4DhGy9fDPKQctI9FCtzC/Ed
 2nxv1g/PvT4m6XFYNqz6OLGpW3C+tN1T6PxX+TEnYPH922l4Gv0Tt6gmrJVmVGr3zyeoyGRo3
 EHLho14ZxLLKAJi45cBXuyAXLyMHVUwa7kJI32eeK/GQqlZ2vG1hlPA9jmloQLRXe9ZEQjMbT
 zKJ2p2apBPNPfU+03l+nu3/whZ9WKCOpQYWBpUU6j5+UyRKq4pQda08Vx8/IGNAgTk8smB2rX
 VHj3h13tJjIMSjg6ghKBwfdUzXD6EYI/pMi09EgwKjTJzmieHjq8ulBNzSzzbUPI8mJXfZJXz
 NLT8apVAdRP71xvI7nWpiUaNzuuin5vkGQ948Hr0Eg185U8hKcXTp3aV1MZMUOuffhDe2ek5B
 IFXYAeY5e4rgZPZpfOLG4I+yWNe74q+08fW1Ryj4hLganSh3i0fskmEaDuBRiKLn7dRKmcpEF
 EB1jaTjzgO4IPGdrOyGm+5d/XRQg89B4z2jCVzayrlfhmZRItNP26WmHCPCE+pyVrPc2eQtIy
 ViBJeipC7TTsSv+n0Cn8foLUrI5Z4Q3468KPF1Rckowm6YquSLiIFfuM1fx0Imli/Sf1IYZRH
 BqLqxyS+fsDI4jywnwH5lObKIPxMBp/EoRkB6aq1KxlUPdWGppPZyEmzC2oqDo2OvG5g/mKJy
 nH34arFnpPEoPhOiOJlvSOS4wIJ3rOAAJUC/nFsMr+v3ENO5OUfRkvYPVc4ZuUnCuRR5Eb3my
 iHCspnBUrfZS0gCqEkoy6cpESNNb+7nuIMjmCFum5IgzufoIZsgpUr1NG6vGqK8sAhAPEIJxD
 aYv/i5YNnIf+RwL4qpXrEWvNMymHHqxfrnL42Z1y5ATYTXTuBb/qd1QDtkeu8tp1ospAC01iZ
 TWGGtHwtAdVPD0etyzJ0RI+G7P0SzEs4l8gVGk2FrsbCYDdXiKvkSIuToyaWWRRBoD6NyBM3Y
 sp06egc1ZnZFxwWFwL0XnHTbzTtQJ7WHo7ZoxlV1Qn9rNIzC/TjudHL7ZqD9ibZOAX8cD18QL
 Mx3ZyRMVV/s6n39ntSjaoqG8+MQeS1hLcaHlc67szpGtdYQRgatUzDTTwVN7T7vtR7w/x0hRS
 S3V9WKoPj+NugE7BynIIxAV43LUY/H33N9SLwfxHDtWnL2w2Y6PEYhx7n1iVvrGvpvZlwnqLl
 5UM7n5QA6DYUr78MfV0SA/1XHk4utaheTdlsO7sNuLX8Uadyg3ba+RdGJGbnQs758iO1vNKD5
 oX5KndITJZAxFfAQjPnd8vi+S703kwDP5gZyBdl15XdIflQu9fNDYOtHr0fgQScmBqmWEzeXd
 xzggwvyskoR49kj3+e7DhtweapLnASlyPHjzPIBn0CTWgQNUURtLK1zybunWuwdPGbUVvKgDt
 Gf3qYAa2MBXSjWmnd7Og9iojV9IzvvGSVcsB51Wy2gykfpV01aLN8v27zaLB04OM3ns0Z4Vf1
 HQk9Li8Bx2AQ+UGuAbUKA4HK06Tw9fOlPCaU39Wi/93m6JuOqQZR95Tftbb5tM5hGFn6JKbFy
 frg8bYWNK5cuC0xi8REv2OGOIJ3/RfzcVMM9A3O/rlHhUxivJdFcTZzrn/BjMh5CSAb3x2a3+
 uff7WpwvX0R14kz7bR+nJqKZmh8fKboU0R4ugVMlXSVyiAUtbrNAy3mPNyNxPlGkzeKarcs4G
 B2bwN1IKkpIJp/cuNAXY2/kE4+NcxhYwvFTamb1F1ByEiVA9Hbuw78Vr2lKgFRYvpKIL8NaNz
 Zh6+uLCTlu3L+605n3ExEAGCcbQOa30TmilkR29QkKwz8BhJ/b8Rs0vVo0afsSLTZBXdVo9BC
 yC415gT5DthyqLoNa7YjGF8+NRYjjSrd0v9qkinsHjbkEBapIUC0iYRx9GHnX+BJPvZglX4T1
 vAZHsx4DKkO1qe3FSm6UZRajiL0v5lWYLQcDAArjJaQVP6BWyxgc78CXBvcjZcFKEniDe2xMs
 /qMXWoM5yUSP4FJAwqNtHSkMt8FZ3taXKkMB4GDzWeWKrVnYhISlQXsKZxEJQgW0raPmfNmL8
 swVvesnU7V/8ayxGIeMXE0B4KwR2u67U6DtKuUBG2jgX+fbzrmayG/DcMay3q32l1Wn+m3nC8
 y++UTKy28Whtvp3dVNlo9WFOXab8eKKCoTBwQr18gsVy98MJC991Wl8rRhRuVpEf/CLC3E9bW
 Eey/3b5yo4RU8hOnfRULnDVSOGogGJhBEKk9UpdNvg9Ha8GYDbtTuSah+cC3LknqHJkFO+Ox7
 yfY1oP1CAf915xn9r2Hhi6SuX+X5gPlODSS8G+EZ0bLSBpmtkcpKIREdnTOcnG4987+DC/3Ex
 +bhSEUy3g34ZgYbRzcrX6ZjUnTnK+e9CuKFDYbIJa9aVdiTNZs5EsnAqcWxUzKsznsuO+csum
 1oyWsb+hzjqU4TqpmOgzxMKaSeS7Mss2IwFC/x+llm98ICx9pnZCDla9a7dkfVFVios3LH0zu
 3eGQtF4k+GVxsOHlyZDbBbNl9hIYZyO5r3eraGlx8OneyP0ONhS1Oa0b7/13uBaXX9QJPO1Sz
 qxf4c2bmAQ6/1P2HV02VuBXxieqrvlpipYVTMwiYwR8Hjdj1xVYU2NzVQDLZmYgzVMMJIo7Jt
 j8Wu7KZBjZ345nwGFQRzNuZTndtCCbA9s1wyaZH9u2/hs8gUsWGx4jb7qbmWPiAA4S3XJaE4p
 Cg/UDRCsM5T7WFOHLQ0ieL4A51I1VgFoFRmRWzfSWxVrynmunpyiKNw5LTMOpj/7VvuLRNmNM
 m9CTsn+TOZo25FZWQkCj7EGodKqhlDfjY9JDEjXCRWbbufc9biFW83z5+AbiT3XeVjSiW+7b4
 5NaOs9IT0VZ8iXfrSjgX8UtI3R5Q+MJzLYYBo1zbJaXC/Hy8Dm77OGMXhJbjyPIDtDCmE7JVJ
 QKlVXq1df8yJ6tCETZCiXz7iik0nY5lKQGwx34cxSnrO81MFM5KGebkcwt8H5RuCS7KSnOHrS
 q3rkszNKV6CR7hqfaPJ6+A+GAabtV9p+BK63MqUOew2xHelY1Ykh/oCK2uOqP1aMeRB0ZV1iD
 WlIoufLTK/oA//BkSSow5vbzdsAuvkdjyHurre7sl0/TfbxGsH2LkkytUOBFu0eQTjJWzcH+F
 CUynrYeLfh7pTyhRRJMPFcxh1O+EZG/fqzaIxVB2EUOAflhyeI7J9n7gofvvUKEdcZBKWt5YX
 boCpmmMZOviRyLc6wuEiSAmNLwHBnJlFmIm3Kvfc5c5XTTLFvf/9xAVLD6hhzgRahL5hXOshw
 MvdQRjeGgcvi4ifCoagU6JFdLVPLXCRMM9bSWQ4wnW/XgOekfvWqgcZcPDvLFt2CHW8RFyAx8
 vFdfcJkpk/EdZ3p7rQW8sMLSjhKU8/HO7YUAaihXZioyOzZvyPrqGJsJZlwRgLth2o3o7005p
 HbaPIGUD245AC4XfBvgM62bs1z5rVfGCO/zPnUT3DYAO2goKXnDXIvIrt6FMFX4D6LIQLkF6i
 GUm4t9LvQfEx/xQ4Dnl8HaCln2AucwxFXkCXMPyv1bAtIEDkovM4XeD6tFTtBXvgE2BWLDv6g
 0syhHsHiiIe/6gaGlBGs0TM9u38kqn9CmbhIH1MLJ1BuZrnc8YMkt9WW3kjZGOtv5q3UP9AF4
 SoG5WFtpHiiwEBRAu05dJiEGwTLl0zrSx01B9bH++donIlHdLUoyPeD/PWVu/Wl/4680osyTT
 V9HW/3MxRO2FtAPNwCAQnZ8kF47P3nylmsKPNdXbBr3LXeikwsM2HrnY88a0jNDJ1sQDWx/Tv
 sWlrFlwq+s9ZoJ6maQLSC4FgCyHfj/akgyJR6Yjn+dtnmQ98aWJOvarz4Amj0nRz5eSbB0+ZO
 r1liaL2pXW+SUqX3RuixPULiaGwaS9T2+9rMZqPHWN0aybTmwfy7TowzqdpZ8lvcNkfvi7Dku
 D+5cTcRil2ZE3DdluBg/b3in1s7fkqSYPYURH5KeUzxP1tFdnMSbsl7QqaW2EC7MDZefg13NI
 RgxvLbomdzxO4KfwDcc0rR4XbGvWw3R1FIGQDRgY1Iq6uvDRZxsiQDcia7BZb043itmX+5WZf
 rV39NyJDWL+SOED0BF1TKvKtIIlaDfdPNMIrWxSL/AmhlIhCNerI+l/hXbwfnJNckfPAAmNPr
 gFfFVLeIoF09RQy50zJV6870V51+5IgG9TuN4aLdMC+1tLQCyTdWy0geCD8mnDOpx2sJBh21r
 NPr0eGn9NyuTkC59mKb22rZ6MNmA45wnDVwvFRbf20/cxvLIbNOYgrtsjkdGxIV/cUxGEDWPC
 WgrXeZgYNKoC6PFhRVRzlQbi/XH04BtLIg32Y52d8u1/miUsDTOkbvlRYfIrDTn4sU/SofQs8
 XLF/tLiZvuOD/4hQxazbBBb1ekQH4RUrsHyLiG4Vc2+UsHAbb25mCBzlAVoaSN92cNpDbm0Rs
 VklMaxZoZxyqyFsC6vqW9Gi2rR2DsyMhJ/Ghi0vo5QnRVWTJ7/kMCnQhEcLwbIjUoIvjG0xIO
 6NOLqubVZ1CZQnHROtgKPtukUBpnGLjt/rfawrynndUCJt/Jvw4zeRyiLjJOeHZQ14x74N5ls
 wbDtK17lnHC76GtVW/BRslklLhG8e+BsRGFLQPydYE4Vgt19ytYzTj8j7T9Tt62kF26RRZxkR
 g4F0Hfo5KsZORAhx2JBXzUe6ZyGomWSE5oQKul8sExM3fQXQxpXK8dQAsnh0RWApn4SDB2E6Z
 tLiktglePO43P7yg2kJ+WrX2W7ygLWPAQ8aeFz0vHFKMaCWM4nNOGlIq23faXl9efbE3Ultro
 TBbER3yYShqCTzH3HD/Nu4D70C3F0lu85yWvN4d7JTwuSiV94Pkm/sF0boWQrCo6VxDAbgvDd
 YaTPCMYW15B7WoilA=



=E5=9C=A8 2025/11/22 01:29, Josef Bacik =E5=86=99=E9=81=93:
> v1: https://lore.kernel.org/linux-btrfs/cover.1763481355.git.josef@toxic=
panda.com/
>=20
> v1->v2:
> - I'm rusty and forgot READ_ONCE/WRITE_ONCE doesn't mean smp consistency=
, fixed
>    the race with a proper locked check.
> - Updated the smp_mb usage in start_transaction to use the proper helper=
.
>=20
> I want to note that this isn't actually an observed hang, there was a pr=
oblem
> with MMIO based block IO in my version of QEMU that was making IO just s=
top. I
> happened to notice this because the hung tasks looked very much like a d=
eadlock.
> This fixes a real data race, and we would for sure miss wakeups without =
these
> fixes, but I don't actually have a reproducer for any sort of deadlock i=
n this
> area.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> =3D=3D=3D Original email =3D=3D=3D
>=20
> I've been setting up Claude to setup fstests and run vms automatically a=
nd I
> kept hitting hangs. This turned out to be a bug with qemu's microvm, but=
 at some
> point I was convinced there was a deadlock with running out of block tag=
s and
> ordered extent completion and transaction commit. This actually wasn't t=
he case,
> however this data race is in fact real. We can easily miss wakeups if we=
 have to
> wait on transaction state to change because we do it outside of a lock a=
nd we do
> not have proper barriers around transaction->state. I suspect this expla=
ins the
> random hangs that I would see in production while at Meta that would cle=
ar up
> eventually (we do call wakeup on the transaction wait thing a lot). In a=
ny case
> this is a data race, even if it wasn't my particular bug, we should fix =
it.
> I've run it through fstests a few times, but obviously spot check it sin=
ce I'm a
> little rusty with this stuff at the moment. Thanks,
>=20
> Josef
>=20
> Josef Bacik (2):
>    btrfs: fix data race on transaction->state
>    btrfs: remove useless smp_mb in start_transaction
>=20
>   fs/btrfs/transaction.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
>=20


