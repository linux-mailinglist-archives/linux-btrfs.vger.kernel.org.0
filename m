Return-Path: <linux-btrfs+bounces-19350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC86C87319
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 22:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720043B6B5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 21:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA32FB997;
	Tue, 25 Nov 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AKo4nMvu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCB52F83BC
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764105335; cv=none; b=F2zEhdHqhY7loi+lbRKJiIX4AkrvB6stloGoxM/yCgVPxiFokz2UTu31MXs9DtLG/PMf2fCE9oyQjim806WQmt3nb9w+pqprvyH0SQNEjiRfhH3c2HfJPxt1eklYcISbArS9wmPpdcR7vHo3Ua/IBJwRCdX4CfhmJ/vMsgYvqkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764105335; c=relaxed/simple;
	bh=JwxIsrBpLpWG+7fdNRHQui0k/x1WRs8t+kR7h9dqqpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4WQi6udJHGcUeEgQAAIt/3KdTvsAOYdyWOYUXCH4tmUA/XEwsE+Yu69UaLl0tka1CQRA1zZtLyfHswPDgu6LxvuNgedLNGHlW7MeJO2VNIzDjyPRDHwgZfR2u3dQ7aiGviPgHefeUHZhmzZCVy8cJgYZtjOwKFVwgfcXMpz1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AKo4nMvu; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764105329; x=1764710129; i=quwenruo.btrfs@gmx.com;
	bh=twyhl6f6ZCPsK9OUWWt6+5vPZwMSVMVDNIBef6XRt7w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AKo4nMvuEeSov713xEdBU9hGa7qOUL1JGcoslON5WK6evmbvmPfUCGZC54IbisaL
	 rOTgKO7hXaU2dMfqfkyyaWSSm8hyuhZCvNR2xbQLhDUfL1Of1o3hhZ36KbzG2TvVE
	 iOeAIUXK3u56JRQbwoJ/SedLGiZlxyuiRD+4rDDNykANbZKJc7PeSvZUJhDSGOjVj
	 u5c9HWCvKSc/5p8QuBkitOXzfS7NoeteoV2cKV4wHI2KgDLS8WA4YU22NVZpuMtfQ
	 Orc2dd18udq39fDxsq8h9ipMctJTgq92vow5TyiYuT8sDc/RFuKeBVp0orNjYLRk8
	 U1TN9lA9DOuOC6jlQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlw7f-1voIuQ0QLb-00hhmK; Tue, 25
 Nov 2025 22:15:29 +0100
Message-ID: <319055e4-abd9-4d5a-8aa9-a5973fb56c35@gmx.com>
Date: Wed, 26 Nov 2025 07:45:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: introduce BTRFS_PATH_AUTO_RELEASE() helper
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1764058736.git.wqu@suse.com>
 <f1be8250618a68c9abf1be7f3af416ccfad3784b.1764058736.git.wqu@suse.com>
 <20251125122606.GU13846@twin.jikos.cz> <20251125145142.GV13846@twin.jikos.cz>
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
In-Reply-To: <20251125145142.GV13846@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B8qfWfUfDRFAGKMA4KO3EOoFj9bNnQITsZEDh/zUwuGEPE4/S89
 ivNsbrr9qfvh5/CWhcgbgDyLxmDbVtqstC1ZCqSsWnjtrnn+tZoT/8HeukcVzEPEOGTaLQp
 bbdVRZ0t7ZVrNJacwU/NHrEsFhDtvE5053UmONxYLcp13RlL4C4Nl9cTYJJ3k+mT1hVXnQQ
 PGBJ6gUEfmKU1OS6QGtlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H+0A0CfZsnw=;iChOdnE+rdzqlL6938Zi2LObHfb
 DziX48ZPMynw5dZBASv36DPz615eQlekwCCadHq9hnRoICXtK9hRQl9u6UDL5ejizyBI7NN0y
 PVTkNlsY5Zfzreu3WDjY+jq6adK7QaiJYbGXlJI+6UTAPL2GZ9bZwj3R/hAadObFm+iYOb9mh
 kvliZ0mnQfChlTlZCryiG60h5pGfuyzNAfkpFeTbLy50WmqVgELQ84uvlVTvFITccU+kUbZps
 yMIibTmESpoiRODUW8ujoZwh4ZB8w3g36g7jptQB/vnu9c5UZ63gxX3s8+aAUte5EdxlPUcXO
 XCNYgv7yZpjHQulJiQwu3b3zto4XWifqkjneQBp/R+W4odiBEzTb7LnJaz2qj1fErLU36Wn1/
 AfgK9mccSo2lyy7Ffe0R7caXyMpQfz3ZnLHzYm7l+/DhFb1JMF69z8r5wUxFQaD771psY8wFp
 LiHuRHZOZd0XmJrhgslxTh/fraNfuvP7VLx4cdRIlJmzvfeNo6U0GiAtOmDnE9985z5g9DGJN
 2qFoyZ9C6xPqmlK8FbJlXnt5aTEGZC1MaE66XkiN1fuIZmUR4t82+0gSuMCASij76HAZNGest
 5KHBvzGmHtiwiteBUmyBghlQppH7WBO2DgtZME9/mGmawqqrMMzQeP+ngoOjojUi6RlV3FAmV
 0Mijhs6483EkwZqgKT/OEkSA0Ko0h52lo8EQUcKcO6NxoMlHC8J3MY0b2+3SRRnGKeGxTn9GE
 atwOjROFVeKmY4udmtA0hpICe4AoeOQm2A6W9qKIfMTUdM7Qco5DV3B93HpYchERZpIgepIxi
 rCrRCecvtYckjrXTpNyjOQpr1mGc4o/BtHw9jzceAZthfrv+5wl89KEFOyOoJjdWwluWisLG9
 rBP32eBDtooXBjM/xhSSB9wl3lLMeUk95LgPcuADyIC84UQmvisnCas9QtlbUaicyJK/d/1jU
 hSLNhUb2THOjQWLPXPnCTRMRl3SIzlxdN61Ko45SyS8iSKoiNCNago7Xb/mkfhQCTOXMOLUYb
 o/WnMDWgJpkHeqqHAx2JqraYnETlJVucJ7CfVgeHlVlnUgPovEZc0YRo7BCLbMIAJE3rgdPH3
 28LutpGjyQZ32fGt0Z4ZUHz2O5D1x6BlyTN+5pQR23j+JFOnV7Mlz8JHqu3fSRM0U/S6sPDyj
 F7/r7mTjBZr80fOXGlxzn/CiZ5bpvO3PNpc8DQ5StiuAtmMCJysXq4OLaLN+OSRq7lW5HYWx9
 cfz99GQ+O0HGUtm9RMB0lJA6M4Pcttaoox3qbZQSwykuZaHqgfKU+mSrt4ytLgNZ0OAd8z2L5
 XB49h4Gsu48Gz8uicArcCebNAT0HzEgSN4t7e5gwhMo8IK29QL5/hLKvIDWU1FC8wBerd+nCV
 PscKnakR9ydr04rZZvjuXHIm5XTM17G38tEFk03n6Kv4zgmXecKQ0kOuLbaPppCEmgV/czplW
 X3I92OpPODs4AbZLidBid6JIdzqGjWYt4rFuQm0P8ps7lCAO3ebeg/1YX9do8U0DA+ERnBSBO
 4C7yO5xwQ+tZvAGX5ZWjDdTdIDH1Pis8V4kK95q9lEsR4L2ExgHbEJh4KIWHjgdg7Y80iNYdR
 /gy2dXTuvbcUqejxBY4K+l/Teh4s5wFu3Gk3CoPDTY1Wxp7juuXl4fLzTtSKmTbct08o8bL6M
 3PnwNMxUsvLQAFZkIn3V0rxHc0HSRUxm+wORWQqlJP5/hfnLOmXb4lZQUE6awEbliNiEd0p/8
 Vnibp7cKXJr6aWH5oceVVlOVaKsQJ9KLLgxIWLaxKP/Y7pdetbqeh25EoJJSbM+79sw7nxOie
 0D7clz2eOGg0PMIY8l0ZYGX90Vc5brZXIYmiSgWfZFIbXPlB88AVvFmEH3DY8rs+R0ylCpKeE
 DzpUi8kxY7lRtL3VXgJHhyVPOysNlHe0b0brzzeTMYd6fTktCaoGWOWhVapSGGFk9UGxoJPwG
 awkK+NMsHnEeVa9z9J8O0iQDT9yFSPyoUqaHqKsqI/YtstVGcrka60IEG0/2NHLBSpqsNGCY+
 HFLgQk+jS8yOnab8OJCSX6qDpyEEayT9LKKsSWyXmk6japPmAerktgKt8KfbOBuYVqTBmp43v
 l3KpB4RDfz0lj3FrVpGblr8/OhwPjJqDJ9nfKUtMcyA5o4YGnjvw53liSie9b7Vi3CuAcrybd
 AAycOkODFe3WNQEiKPp3N3+1UhD/naSWyNgPk5uJT6jFoGDgRCokFxYmmbXp8vI6yG7F/ACiV
 Ri2t6bk73D+rKlrIUGKTnPWWWiK9LdQCavymgsUduMzt3p7LN1RfbZffrZ9oDePVU0C32Ylxm
 gTT2pRsBRIP2g2n4v//fF8M80JkbkbAa5EGpLvmblJNSV3O9/XxnbLIZXe7aEQ7JUAbbfmNuy
 afNt6URZRqpyaRr/UgESvDdLatmhzFLQ81fTjyI73C+B8cMm2Kz8HFc6j6Zucp1gv2HiLTuWu
 f1LfEc2SmWF/QthQh+e0u9IuWa9YaxQFd1MWWEO7uddVcf+CFf//ioTqw5JiA2LrOJiwvspZP
 DpO8ELxPLefLOs2SMXl/J7GxFImtW7xtMmfrsZNuBLLkG3anMpkn+6eq/ql0naGnOfyX67ZZK
 ihVz903lpd/DmGEjzm2GpGaFD3lhmA4Pe7e3brG4aFoj48DyqKLSCmstHAxwRva61ez8jvoHm
 v76gBitIU18o6iYyCxpHpFycpNGsIL0Omcip4xKZ5tEBUV+1tHjbRCT3eU7ED17EyjENLFRNU
 WWrTiuiGyHdr0leq075wLnWQKQWw08ve2e2M/YpmSKLFpplUQ0pgni7TXlplpAyGygKgUkZJU
 EqlzJY7iX2lPQXxCeNXk36VX+OdLoqHtE4WIrZlTKDa7TCsenUDo/BYWKy6AEksuqAZ4GZu6g
 7cOlu8k4w6oga+DC+fWbxl4f7ZyO2dRMM2Jo+L6rnH2+rs0ELfndnA0peJGzC4mqboxW4odBt
 3rpFGlei+qkverSmR0yTJLTSIoH3TBBKZ0uldf1T2ogDrOf3nT5nTD2pBExu5vCkfQizGLVrc
 3RSYJBZIMw5bfKEOW2CqdIyu7KmuAxywCETLmWLNmrEuczkFYAgNv6bqL2v58ux0NeAQ/Q7BJ
 0SiKJ9DFAxHWL/PM+0FkxjarlaX5ju6AOBHQ6f1y2HR/E5lXg4T17mZ1qyNQ00SsnXr6qWxYT
 60nCe38nfp/t+7ZZSL8a/z9rY6p4TWRxz4jUxMTL7PjizLvagBy3UAHTjO3uzTALjjarDhAaR
 v1X+0VtcqTOIvBBe3GQV246RF5GOGZYndXXgoFZaym4ojZtzavh+d69rVvdbuWi4Wuc1ofjL7
 uWPu1zRNCs4g+7Jh8DMXjsR2xg8Yj7aRM+l6XRF/TAmKw2g9V4xRZ096NM1NTlDTOhiB3Xx4X
 ivtztUMuA3hChkO3d1t6fDa6kHhsd7BUfDvyNxEdDOsoODUcj7XJm1PFM/CDJwK5V4pxACAA/
 mR3sdyzbYNxWel3N5fUJDIrUDMVFdrjLI1++ZVTOm1T7Ck7MEPLl+HlDTB1ugfmasX8w3d/YF
 /58yHfWJZevMvtOxts5G2dY4an+g438wHR+GstfzmQpgFvTEZP07hIUpli2+duAdC/5W3Vk4Q
 yQOW73Wl0ecAeIfW2CbRMUiU5bWeY78zYmmeoghiYmI7vftM6kc7CEEJUPW++buxlOFDxI8DR
 GS3SoZZeQ+fNMTMrx8CkCVbZs2rx+e96gTilwsChbpp35gFlPm+Uoe6GXk9JAn5RxySx8/qsj
 NX4VtWs330WY+jOiaaP/HgzvLDsR+4RJ6vJiXPhnlleG/r/BhF1yVu/rLv+u1yRp2C7ZZnMBH
 374NbxcTgBBmThRoMJgH2GN00AbrIBPC0ElKe/o/zPPt9xBeNZBREO4eowJM/6bnqpsJc/fCk
 KFXHDh3F8EdyI4A3WjQjSjMUtJ3L3W0zfHi2cf8GLGlPDdxGnMfsK+8BsU/VsAnfhizPIoup4
 d/Xl0LVrxWDMJQ0CB4KKsw6hFenWxw6GHrUAWioIXPjPYr8ibn+7haagvoyGJuN8/iQysn3Bh
 r6gQvdjBTV+O9/5vogEJUSVy2BPiAMDVV/UzsDNTaB4FiCPlAMKg20yEs1POC1gTqBMGWdxPN
 oV04DSTxlhFSP+3wkyscYcalElOE0DSo9EdFkZQbt33YSbnnaCCyLm1Gxwfi4v32Sb9rFRG4f
 OhzqPtido2OadTpobFoxYpVj0accxqrLp59aHJDySrVRJeQjChGum4iTtTslDn7+sVcDukonl
 HSztmv7ZfdQZaTAWdFvrrlGqSVuqzkcTbqVGRa05Xiut2k9Oz1mSX2d16zxuHVoAjFj7saa5z
 KZ+wg+GRjmfiSlzKo7JRzroCIEf9w2Qw/z7nW4X0b24oQmvsmsO4QdY4spM5UtaaWj/C7WNo1
 X+5or/Rd3lA/StExvq8oONTIIpg8HTn8Jq5A/R7qeaQC45zmoPbqfzgPQ569sOyRwFHkiJbc5
 7lMIXc+PMOcclq/lfLSkSZ4A/soUmbKeHdbWgTuQTigTMHlMnyh+FiimiL3fNCyvbYwgHQpiD
 xiACJi+Jyx0irAYjEiEGcTvbAP4d4UnRaD+HM+zypaEAbfwrCuY8J/E+XthW7C41/byqKnLlT
 j6T3e0u3oH2u+RvjXuuGDGt1Nf+AwnPUocY+YoSiWdXMCOKb/AgiXZsSZ6pjWojFLt5xttPT+
 QLomN/deMQ51zpsAZL60xNWq8B7mNMUss40OhTLkmAhUt+wCUo7vvT9bkPV3L/VelP/vu0txk
 BL71wvdlBRZwbfnF7qsJavtX3q1lbe0z1aziv6oQ2UZT+jOklidZRxYhked5wSq1F42SxFm0A
 qAThWmR9jCEF3I5X5rmJubmCMP4gdILn6N8ojRjP7YRxKSiNbQeKRn3af3E2IuHtou391cCEP
 nAxZnktmi7lDZJGIWXHGUoJqWyIoD2M7AV7xaMPn8m7hkOx+c0eayto7B7+oSWiH0WpsfSvWa
 +VqDjfpkuVp4umwhR7V7e7cmrbQZiGHxyRkaCKNt23mlagVO8OAjwQPSeV/Q4rHL7juiNW2AL
 tZG+rOr8zvLeEeWUwDfZ1a5kOFT/X88ek+tiXzliozaf4S/l73BrnpTTbvbRoZYAW8IDegWVQ
 Zl85KzJ9ZnZOEqFCJ+h8vBUG71GSaGg/GM3YTVYgyhnxShnyD8P3USjHKQ12f+hyENjhcpVoi
 bT21381+9BJiv4d1rzOq4ahlFmXw1



=E5=9C=A8 2025/11/26 01:21, David Sterba =E5=86=99=E9=81=93:
> On Tue, Nov 25, 2025 at 01:26:06PM +0100, David Sterba wrote:
>> On Tue, Nov 25, 2025 at 06:49:57PM +1030, Qu Wenruo wrote:
>>> There are already several bugs with on-stack btrfs_path involved, even
>>> it is already a little safer than btrfs_path pointers (only leaks the
>>> extent buffers, not the btrfs_path structure itself)
>>>
>>> - Patch "btrfs: make sure extent and csum paths are always released in
>>>    scrub_raid56_parity_stripe()"
>>>    Which is going into v6.19 release cycle.
>>>
>>> - Patch "btrfs: fix a potential path leak in print_datA_reloc_error()"
>>>    The previous patch in the series.
>>>
>>> Thus there is a real need to apply auto release for those on-stack pat=
hs.
>>>
>>> This patch introduces a new macro, BTRFS_PATH_AUTO_RELEASE(), which
>>> defines one on-stack btrfs_path structure, initialize it all to 0, the=
n
>>> call btrfs_release_path() on it when exiting the scope.
>>
>> Ok this makes sense. Similar to the path freeing, there should be almos=
t
>> no code following the expected place of freeing/releasing. If the path
>> is locked then delaying the cleanup holds the locks. There are relese
>> calls that will act as an unlock so they should stay, one example below=
.

Yeah, I missed a location where the early release has its meanings.

Thankfully the auto-release here (not auto-free) is safe against any=20
existing manual release.

So we should treat the auto-release usage as an extra safenet, and be=20
more carefully removing the existing manual release.

>=20
> One example where a path release (either direct or from inside path
> free) is crucial is e110f8911ddb ("btrfs: fix lockdep splat and
> potential deadlock after failure running delayed items"). So removing
> them from the middle of code should be careful.
>=20
>> Otherwise the hint for auto freeing/releasing is "right before return".
>=20
> With the above let me refine that a bit: use auto path
> release/free before the 'return' when there's no code that depends on
> the path and related extent buffers, or the remainging code is lighweigh=
t.

I'd say the hint should be, use it everywhere unless required otherwise,=
=20
and review if the existing release can be safely removed.
At least for this AUTO_RELEASE behavior.

Unlike AUTO_FREE, we can mix auto-release and existing release safely,
while we can not mix the existing freeing code with auto-free, as the=20
existing code won't re-set the path pointer to NULL after freeing, can=20
lead to double freeing.


But the current objective of RAII and scope-based auto-cleanup are just=20
to ensure we never miss a release.
There will be some quirks as you exposed and the auto-free problem I=20
mentioned, but at least it would be easier to review than catching the=20
original missing release/free.


For the long run I hope we can refine our structure lifespan design to=20
be better, so it can be better suited for something like this (ignore=20
the ret_guard() naming, and put aside your hate against RAII):

	ret_guard(btrfs_new_path, path =3D btrfs_search_slot_new_path())
	{
		/*
		 * Where the lifespan of the path is only inside the
		 * the code block, and get auto-freed exiting the scope.
		 */
		do_something(path);
	}
	if (IS_ERR(path)) {
		/* Error handling, no @path involved. */
	}

Although this is against our current error-handling-first coding style,=20
and not all callsites should be replaced (e.g. callsites using=20
pre-allocated path).

Thanks,
Qu


>=20
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -217,7 +217,7 @@ static void print_data_reloc_error(const struct bt=
rfs_inode *inode, u64 file_off
>>>   				   int mirror_num)
>>>   {
>>>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>> -	struct btrfs_path path =3D { 0 };
>>> +	BTRFS_PATH_AUTO_RELEASE(path);
>>>   	struct btrfs_key found_key =3D { 0 };
>>>   	struct extent_buffer *eb;
>>>   	struct btrfs_extent_item *ei;
>>> @@ -255,7 +255,6 @@ static void print_data_reloc_error(const struct bt=
rfs_inode *inode, u64 file_off
>>>   	if (ret < 0) {
>>>   		btrfs_err_rl(fs_info, "failed to lookup extent item for logical %l=
lu: %d",
>>>   			     logical, ret);
>>> -		btrfs_release_path(&path);
>>>   		return;
>>>   	}
>>>   	eb =3D path.nodes[0];
>>> @@ -285,13 +284,10 @@ static void print_data_reloc_error(const struct =
btrfs_inode *inode, u64 file_off
>>>   				(ref_level ? "node" : "leaf"),
>>>   				ref_level, ref_root);
>>>   		}
>>> -		btrfs_release_path(&path);
>>>   	} else {
>>>   		struct btrfs_backref_walk_ctx ctx =3D { 0 };
>>>   		struct data_reloc_warn reloc_warn =3D { 0 };
>>>  =20
>>> -		btrfs_release_path(&path);
>>
>> The path should be released here because there's iterate_extent_inodes(=
)
>> which can potentially take long due to the iteration.
>=20
> It would be good to add a comment why the release is there, especially
> when the function is using the auto release so it's not considered a
> mistake.
>=20
> In many other cases no comment is needed as the general rule is to free
> the path right after it's not needed.
>=20


