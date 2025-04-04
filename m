Return-Path: <linux-btrfs+bounces-12805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200F4A7C58E
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 23:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E366B170280
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 21:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A6A1DFD83;
	Fri,  4 Apr 2025 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="CcS1zIyX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BDE19047A
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743802326; cv=none; b=Ja/eMkTaUjMOvq3kPbzwUhPFGoZsYKHCz49ELTJjDYvyYQ/M/kzQ0gB23aB7htP/USFY2wrR3KRIgzGWRQvOaMYAlCLZ4HwUhlc8IQ9sus0giiUMpD7ugYPpCE9SrM6tuG77NpVBCkXIi+tD3URauKn9FHaBxKrDRHaPkQ0JVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743802326; c=relaxed/simple;
	bh=ytegULpMPOQuNVuzZ4Dx2zyZFUtfZQ8TqI2Eh05i1Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KXrRnWs668mtHLPYS0I1e/rfefUZF4Ggv4TW4Pp5t9u9yMLbdnVkM3Kz1rSb2MPxp+0RS/ps4OMkusTR7AAVD3s+ajk4fuNx7XACJqPAZkwjcMXl06VstrQce9Pjq8dYV3pQYun/rmetLMa9JvL5oVKzMjWpD1Fj1zXDrpDwkF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=CcS1zIyX; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743802321; x=1744407121; i=quwenruo.btrfs@gmx.com;
	bh=eeZrtL7iqzt7wtOgIRecD9MreUUBoQGeSWOJ296bO5k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CcS1zIyXkCE+Ka4TPess7aIG97nDPeBoEmHDB2HlDVnyWEC5HnEW1gFsHt8OsVvy
	 +ib8I3aQQxdEF9878x/UI2HIwAS4P36XljBe4o2QJPgL3VExPBxDn3ykBoKRl9TW0
	 6UzUOPaihGWxhEVVFhodwrBisob4XMNRhTLSyJp1kU/SYjZDtppEN6MMQ1u7UGXJI
	 dgfrr5I8r4adBdSd17AIr3eVPKbbFcd8ixseql+98lJ2tnUqaZYSP1vqI0GHGVwY/
	 Ri6vuNSzSg2ylJj22SBamCd1VFVPuri9A5bCX2ZiQv/xXV2dYxW8bVXuFQhBA1dcT
	 KywoJcO6y7GL2hOzEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt79F-1tCYJ60NUf-00tOlI; Fri, 04
 Apr 2025 23:32:01 +0200
Message-ID: <4c0e8f42-d704-4839-a218-848ff21c9cad@gmx.com>
Date: Sat, 5 Apr 2025 08:01:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Tree-checker unlikely annotations, error code updates
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1743790644.git.dsterba@suse.com>
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
In-Reply-To: <cover.1743790644.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o7D7pae6n2L9ncbDMKfDVbFUHY47cEgnuoL+7xCuy6/Z253CsGf
 zStDbq6CohmVPE9nSbHQuSGVMz+oScNXFYKA5GS3hTZ+hMHub37/v20zb/QDGxb70OIQ605
 2VbwVlR3WO2hdwXe/008NKwlrF3CQETXuRtN/lkdWZbTesI5Ji3HzLHN6ebYF5V9oJV5kyh
 B3sggHu0PGaUXHwQgS9oA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P4ivPm7YKzg=;6gbBxc5vSzdk2cs/CuUuQx4/jyD
 TZNlySdJMjIMqB6udlG4+wsKqgSr7Qt+yWuKJJuSMYyq4aNZnW/HYZWZsfHQ8kDlNYGTwNHce
 W8X1CpeSE8fqE1Yi8hm+5VeWO1HHDlAD3MPrEImgpvz/ojmYWKB5CjSTfXJNHS4OFRgJ9dg3p
 H2WPNZud1WeWqEwdeWBftoA1lEbBdiy+FzIvF0KfzqhXJmZJLT+r3my9AIjY1sIsKY4iBndjb
 +562FNIAO0qhHZ6HmS+9sy2sLnB1EjBwem6qixLrHB476ocpM7kQqaPGny1h6uToD8Voy7H1K
 Gt5xt4XQgeM06NqzoFJ2OfoZdhZCWv75pkab1aVvkb4XT93HuLg3EBnpgSaUM+U/IsWLQlYea
 7qCOiRQRibQn5c+B9rTV+QgNH+pRA+s4IgvOIyhmsJmjll860MWDwKKZPyT7xzxyL77mF5doG
 ld650bry11jH2wDq2shSD3AQg2C+fkeWhOIBWXl718ocEYIxBdDE+t88TG0tLrFoeGC6esTSX
 NqMXgWjDidbQTMXHTVy96I2VLURloWNjeHPGBK4nfbILIFmH36Yc6tbdxQJOlMwlsIRSOkULC
 4BtsfTX99NjTTPSbLxaFHyy+eszX6OhVTNR53+ZmUrCDA3hZXOPu5WYA9k1j+ZoJJc9EyQRSF
 +AXx+u2EUhA/EWD3hmEoO4COfIq9JUE3B2tnBJFVkMq4oMSIoVqS8HxdEvu4t6cckX6+tRuJs
 XfDnhCW2QwKYIr929U/mWyparBj/Yn49f1mcf6rEnD5n1ddG6sUhCZSd3wJk8Qc5NX2u+5mkE
 e6gC0jziE5tHiyw08zEywQPb+WAPd8dfKUzVZSmy7DD4022S9Top5A5ITwQ5CBVh55+otyNTL
 gb6v774ZHmgB635E2ltjZT2LtprLogDeXkXBD0pQrSZGMx4nAL4eC8m8UFOkPCxKP5D3OewwY
 pgPB+Z+sRiJYHhxtEdDPTKadK8o7TuZKH2vbHiU8SOr9czGDS1dPiCXEecjUZ1JX8i88AMlFL
 aIqEX6v8LKczUgw6SlNUmnUjKavUAkoFuTR50MMabz589Vz6ZmzROw3nBxb6X4nDbJ8W81bJG
 a8sFRzh2/Rq38f+B0BiwLv4otI/St8NrL0CrUyQBvnDV5PVzwSRoNJmfoOEjM08YdrS5IiQu/
 3HDco0y2mVkPgl+SZrkGFbgiA3e3beLP2Rncubz2nSPJWnvSd1xtxAQjxqsCgfi5oXTXBFB2N
 cCX0vmVEV1lyUF358KoQ5AiKXhYDAyREOojTS2iYgq4e1gGU7PnjlHi6vnuYzU8Ze24MhWj7r
 zztSAdq28Sg8ITANuEF1iGpUeH3w6+BGhO0Mt87Vu6C4GddmMTFDv57MMZmItGoTc4r7Bm6ou
 Ev5eXlIZFVrSCi9dQK6CIWIiXmdHRVDEbIGi3fzJ/JSKQPOK6ZIIL8/Bcu6/+vCH8oIy0u7YS
 15kZ4Uw==



=E5=9C=A8 2025/4/5 04:49, David Sterba =E5=86=99=E9=81=93:
> David Sterba (2):
>    btrfs: tree-checker: more unlikely annotations
>    btrfs: tree-checker: adjust error code for header level check
>
>   fs/btrfs/tree-checker.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

