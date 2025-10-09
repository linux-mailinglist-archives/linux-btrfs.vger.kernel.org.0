Return-Path: <linux-btrfs+bounces-17598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04021BCAD0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 22:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C658423F3D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 20:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23B126A1AB;
	Thu,  9 Oct 2025 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fZ/8MHhd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B3343ABC
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760042276; cv=none; b=ozjHZTFpCHibW8F6mIp8AV0Yn1zUI1JzIXsWNr2PQlKYcTVQN2U4MAAq8cMU5SOMZK6fGVCkzFkwHNQXuUCVEF7iqNMU/AP5QdUXaIhnWRQ81aXiL/MP1apZd0E1tJJbm3y8yWswTwTqYTcgnpALi/zhhL9FXzDfcqQDxkJN9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760042276; c=relaxed/simple;
	bh=RPbJzUcUJeSqwevvI73w0PtUoMFIW6fFXHsGICN7hXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aUm+hgNtloIALkG6X2uJqqylVPyI3N90nl2B4hkgjXvtRtDel3J3fgk0b3+JrxvAlRERMUKwCFr/GjKC0xlucmuYBEPL0jyrVql0+fYrra64/DRgxF7lz6fJYK35W3mJa3WjuizwxnE6wkqQiEu5L4A06hPsBU3dFTc/LfkU29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fZ/8MHhd; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760042271; x=1760647071; i=quwenruo.btrfs@gmx.com;
	bh=04QDHbmb4b+smxV9QYrvU5S3avHjVG9O2E8EK2wX0o8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fZ/8MHhd7YkQXcJ7O4ptQFUNptBm/IRWAcpHUhoDTvm5uOiIgrOd983SvNlbshoG
	 9XBLyPjr+1s6HYqQSJIi4/DQ18jASIV8HrImZi4X5OpYEzCbj1nN+m8/32eCiN5GA
	 ntsvP9h6yrYKh0Tk21VxKyoGAnFK8wQ7YUu8t2RCq5IKQVAcuz4q0l/AnoMx1u6W5
	 vqpRbDLCyNUosii+vh4q1XomW1ipqn+CEA3SI3Yhu+X9kNtqKS+Ko7IkCSmjbxG6p
	 mqImUPpBf5G/87Y51CRNs/0Pg9s+yw4SwFQ1wXPml7mtcR1Hj1dX4wZnxHJdFTmwf
	 hglZog+rv02yJ5j7Qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkHMZ-1uNCK748Vd-00pU1S; Thu, 09
 Oct 2025 22:37:51 +0200
Message-ID: <5d465706-b7bd-4302-89d1-7f6b5e16e350@gmx.com>
Date: Fri, 10 Oct 2025 07:07:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: check: stop checking for csums past i_size
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <6e3df8da61ea11e45809208e3795452c5291f467.1760028487.git.fdmanana@suse.com>
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
In-Reply-To: <6e3df8da61ea11e45809208e3795452c5291f467.1760028487.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z18PCeSgnVglxSaeeL1cudhw1+/I2pN/Gp5RhGLjx3RP2n3S27V
 +u41iJjNUeGkZ/aygrnLuvnYLv2vgcflf6Ib9EzzbgcOFS6n7HJA0/+ybFQgjI+w94rSy1R
 Eu4hItBevFsJRIHvFdi1TZjpfEWZ4AFKdrSuc3gMGG1e9dPwCxWVi+muZxNXWhMjAJzOTv0
 ECBB7/hGXqJCxah3ALP3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pUKD1NnjmYU=;rthCy+xptCJtS0RHPQ/a35DMrik
 DXnw7JYpaScvFadzivCzsreQUIVbfEWjH02VwxioHTxVeTl4DBi8+lq7HpOQOpg8urDwGDMk1
 xOvNShWWeGu3e4R4czXFPuDkVdMuyMeOLZuO4vLWfUQtYVz0jzusG0qOTJTyW3y3UJHoNxOY9
 HTHHYpEFenOq79obrOghJyn72qW9415V2AH1b0RXwSEs8zlyla0PUNArE7OQrzLejRJ/GwWm2
 BeN2N77ED4GwYYOTorq7UkwiFe/hoUrLMv4dpt9+WlZv8E6G9b7QyjfBJ0dEGOyY1M+44+yJe
 V86GvPafCWQwxYIagI/+A01lgs+2fbIeOdm5CLz6KNnzglVvdCUSjjvsFBBh9QV8JLcjsvZtx
 D84vjO7WuJxWBC5xOU6TUpKHwVabxdzteItLz223JU5tSEG485lk52hbP6jsIGqe0XFa23E0G
 OZqDwbC076YdVi9hqxRouA3q+hARsA83d4idyVQ1EGnO6eXbkSG2mxF2mDZDdsLwQWSe8621L
 0oAvn6JbUgrwOb9qpbxDB6BE9RtXrFFBdGIMdq4Z0RGhFvSz3OGipuYbH7mk3DCGt2X9Juumq
 8XjEfiWzL4CcFZI2C2l0dsmdQATimOQpWqrndCCBbXPkx0cp5hoBYIZ+NEKURQ4hV2Ih4FDyV
 WCWoxsFHMuMViiP/bjz5//BtNf4myZY6ZqXHGU0Ej8pmMUEX2igpNERG5zLsjhaavgnKef4G+
 kzXumWTQCAWIRuwho5WepaaXtQnUwTg97UFbgFSPLZjx47POiTqokIf+JGAy9G9Z9oTRpBfoe
 mYFo+dhzKQBxBFDJ/zDphWlhdrwwgd3ckFn+H2HH7wP4074I+C4u1OWPQd0Zyy8l1ODqPfrHe
 W3oT7HRNV1SLJq9WapP+kdnVZfldZ5AJezMpRI74dYvl0HhV+6KpgU5HWoq9DAd/CNcF5Zm6O
 5ojzU+3YPyJrKhm2wqCNuzni64g5ee2+TTs3GizhkY49ezu5ZYymwQJgTOiv8j7QxyrlCxHmD
 xZbWyMLUZ6FRT7eREioQ896gsK2WkGN68S77QhkbfYjNiZ4BB/wV+ViitdyX2ORHljk2AWem2
 5b73mW6w2kxttxzBSrEjR95RlOo12379WLbo4njK3y0CfACi/R3t4HNXctZApzSC7z+m+x/Dv
 8C1S3qQk88Vcy9x8bIsl5A9lE1rYSWMHaK1FrHSeUZr8APJHP+rO3ODVnRM0PW4CFl2Qk9IQI
 /0T/v9ZNnd3+r3vsFcsXL5JC1UDkkvu4VYkvEFcUO8JXidDaWDrnGdxvbIfCxh7+yk3c7YqeN
 ZjT3D5HVdm4DpLE6+GTRdA7K70Qr3UmV+tB8x9fYwrMto9O0ygw6vjQ4Q24jaqhQ8PQEDsO1T
 OcuDXT5fbl7hI2Iz1C/LO+5XZlqf1qOGc+konQ6kCJXB3wcKiXCTtvSz2NNsnhM143H4pgL6Y
 iAacfQyk/dv2L432bjcDz3qNfU/A4v1ER8ieD+P3mGXZm80sK6uB6NKs5qGEdBh53icpjXT12
 haruI/OYAUnn39kd3jK2CCeClH3i0ux5kuwPPi+l7xghM61EEAIFElF3xcnxoiRK2PUuiz2RI
 c8qOaWAW1eUz6lOpocId2aurT7QJ/NZo2yC+kZ7X8A+lOZOJty+HPjs/t1DUaEYezrCP6cow5
 iadqN3ZYs1hsFC5UjolOT7TFswSuNYeWyHkVEoudwTqAVN3PdBu61exmYnAL9B7aslMDCI8Lp
 ZnyrM7hWf6366u0psZlYUrEWq6oH5CPrQw6GRj0XCVQiXD/w06Imed4YLWn79/6hqlJ4yKtlc
 5elmjs0tCdj+XAjjeXQmNDzYjaiBugWmx1Xox3s82cdT1WqE6bTDliiTF7tFZrW9Z2MTJkU6P
 oHYwu2scJ+y/k/QwoPSjFrvyqlNTnh0FVWqzuhh5jwvemEF7j+Y/RkmkusPxd1DuR1FPCSz2b
 nuQzK3y+bXVGNImFDx5X0p1ZjogamD0UdpMuLJYsOgbimKuB8MVJGCjXmcam99QnFBwIVnrZ7
 6uUG81r+NOCC5Kau9crfue+9075O/KKggpu3jzWWjRPatSRXmTadgeDjdQ1nzRRrT4vQKomJS
 4IQPkIxRCvM28iH72KGHXjsH7jQBwh1YkFBRjMLlow+S/tP0E5F/vORu0gPfDcy5svaHz38+m
 9mqahpNGR03HtRlRf9L1vylAopIJ4EkVCakCnXiivChMxygDaTrN6F8/CX4nxAYYKKNeqw0Y8
 1hB5wPicrra9hz35fiKj8vw9zpmK4/xcjaVVJAKvSzyjPnyxbQelHxcF1E0w9ADuE81/XCKyy
 endH2jWJM1wxD2ePwP3JF1eQ8685SjwlzgTVJU7095380I5r2/Rr1bv2ijrltNkmS02QyQvwG
 eZBZfJLavEMffkwE2AsrIhpQpn+Leca754vjjLincMuAubEfj2wOHB47drk50igGgG0PMEdRR
 Ei0S1NTyKTvCYQk2GyFXLtrXh6yWL9+b2H8HQdEEF0hwURQfjD4z/DBX6bGNNYkDcl4KVpHE9
 Q0wJRhhcAN4MRLSIlCPvQuUVrh4eJfDoreiuYkj+0iZi7vIMEq5k/y+cCjIdxsMaWP/tCoLu4
 y6bUBJ7yoTNJgoIzy7iDdtFDxhcO2CfzItDnsYk4tKDgaGSh28eawWawwfzPkpgPoVQdGayZY
 838Of1QIOAlc9FPDtd0J5qwwze8VKXu1H6ui6oYfuyAtJofoYiGB36kG3jf8RiUiEzK4r5pXH
 F/WwWKroW9krGRzIuY2HZPdCiolDoVMvPP0pqiFLC6nNHDRjeJmTpCI+JkAIucg61S/hu1Bdq
 k3TCZomEX0wuopVafEopIRijdYM3Ag+N0U/R4sI6Vg1uJGvSrqg1DHjPdIHGRnWcPVTa4XVYJ
 Bm3Xy64q880zZQvk1hmIHduTPBZiYHBQjbmeKiHWFq4NERQJ/IsHpgzYOdh8p9fnXVQFN4pl8
 +Waa2VIeVFJl63VfslQmIaT7GbKqbj3+gPmaMDjkx9Eui6Am29sf0bLNA2/SNoB7f69BW3jMv
 5R3KrZTJsJHXGLaX1i/meAFqutx6wmPhNQDFoo3pS0c6ekirsTLC5ThkvobOAFGKumQPwBGvN
 C/lzPXS5EYo/V8RM7Uh/0N0Iky0BGaNp3I9y99IWDAWPCA5oKFX7JS6fc8KHzGlZdfTIsk2Ud
 G1iynlXwAITTaL88VLUOX5C2BqQaLqMewYN+dS7mUZqyvopskIpEt0dPDet7IenkSDsMLQSrW
 pqZPkC1DoczOIzM/MJS5HgxGr6GpESFLeRgk1VqiUcXq32AwI0Rg/dXCpDNpZEXzn2cnx3dD9
 FRe5ybdGEGjGqtQIJ2/4eEOnyz2L1sVYK85oBJektLs/+lKlrx0wn8frDo+FIMOD82WpTlkTY
 ZfrvIcZ8RofjKKR4VZjs91LCoEW+B93ROlkF9TqttEXnP9Fxoxe3fvRa/OWVs+XE+KHFvMeQl
 GdOm8c725evBY92gAaFSXmnMfpi1DosnZfKRSC3+YwaHCQDpul2fKNvLUwzU7YQMHvaY6q3j2
 t6CxYJd6tVEY3PcSZpbJlzuCytmaXMdaXSYe02BSgiYFNg8ZhAIZIC+cRRjqI1l4w9k7L6Frx
 vjSA7/0TVMIvMTmyT02GXKwSyOVz14he2HZTT9reHuD1tmKJEeFwJOhRK+EV7Kr4NdfQDOvUy
 XdMLlBqQVNrS7mjSmLjMohxTStCa7fHcnn5edv4VYvgRPJ5Sk+Jm7KYt0mt9zcBvgZZH0e/eD
 vbbzGtxTd5u34u8rdVD/TUHZrORgRgTUC4Vo9DcFBtCCbdYHaHB3MQkyFapHHRFDBa8APf06r
 4Qw/ZM2lYnlpfQb5N+3o+l5oPRn+p9WjDX4GHjD2xV+NGmOsEDaHvh8WYg1zJmjT/mywQuGvW
 /A/hxusmeXdR+AtOKqvWlVQf7P6Ck0eG6euXobjDJLd2oqaTBickX7r578kCZgrYvno7xgi9n
 /VuXk+PXpPOUDruQdyZdLOOdVACWQgHX25pMFabKG/OQ0lMyWSZUI8GROGO0GNeUNEOjhmPeZ
 At+tx550bi83+9QXGuAEDX1cUH/8UaUwA5Lxc+6uOqnSU5glfuAAKN9dl6PY4E7ehsKK5n8/V
 l+KwKM2S4exWdeG+8HwjkUN36ucp/mIMDmzqc1PWNnXdTko5MpGbbqp2+y8lLZci1EyQQoWGw
 cnsVxArPDUgIM0UaE8dQFbQUlmDVIGUXpH5J7tUwDKp8SVPr5m5/aTKv3p0Synctii/MfjFu9
 4Hy3FaHlhd+bZU9+gYzkQZ3nzSv4B8R6p6rrVXzGIEe9c45M9YqQtEwX4OLTaLknZsiJKGuuw
 R3HJe2aVCzpLGXYebdB6uVSkWB6PoNT7mJrB2ihZUoCcR4KBd4Me+Ek9joJW2/RII8vN0KPxT
 WwitROpGmMFv1+0eP4iYw33EnJC8tREXaujbsZ7BWVC+X1vqoN/s2dhyqY0rmDM+N85mbZ9DD
 aTAGlyAO+zKrIsEkyGpcTlTiCpSd0iAcBR5O4CA/Neu/j8nRai8PkechsoOl9vmhYewSpN5HD
 U/wRHX1R89gi74fkq2S98MqkQ9+IWX0d6ZpKIhie0+UMgOlroTwVsIojyGgo5mz6mbyK6Xb6Y
 PNi0izvQvcimXLo9VbhJid/pvpx39ml7pgJxbSLh3p2R6n0oYFQ0tsOl/EgZKDi4cXb23vSSJ
 QwWwGDQMRPTo0AlzAxWtEnCidzKZS6iJC/BUvOeOf+TZ3UEJGzAJjTKcluSlvMB9RP8eJFyYH
 B9qc04UPZgObdRT4FUUnleezrB9/S+mDUXKQWJQBFN7AcIPjbZdQOgLKozlVlSmPMgiFOykNj
 cdIEMIFH7nQuY0UqO68V0tZZF1S6vhfFV21zQuIWOYz4wn2kbK+38T0gtoGU+EaDhPQFBKugp
 d5qpb3GqB1zuzvIR2rNUFqa6YxQ9Sz+9gF9Qy8DoLu0zxW69q9DJ2gmJnRWC6Z9WM9ko6xx/U
 KNJJTS4SJbjPtZekUOl9DUEwm62IHVCzds4N3nwhE2oWBlnycVLV4RuLYAzQgIfK5y5IOeGZL
 zexsT5NahV49qFxGvO4QqrzvCkbPsL9NcaNoVA5+63z65XE



=E5=9C=A8 2025/10/10 03:19, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> While running test case btrfs/192 from fstests on a kernel with support =
for
> large folios (needs CONFIG_BTRFS_EXPERIMENTAL=3Dy kernel configuration a=
t the
> moment) I ended up getting very sporadic btrfs check failures reporting
> that csum items were missing. Looking into the issue it turned out that =
we
> end up looking for csum items of a file extent item with a range that sp=
ans
> beyond the i_size of a file and we don't have any, because the kernel's
> writeback code skips submitting bios for ranges beyond eof.
>=20
> Example output when this happens:
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
> 10) Only after transaction N is commited that at btrfs_truncate() the ca=
ll
>      to btrfs_start_transaction() starts a new transaction, N + 1, inste=
ad
>      of joining transaction N. And it's with transaction N + 1 that it c=
alls
>      btrfs_truncate_inode_items() which updates the file extent item at =
file
>      offset 589824 to reduce its number of bytes from 64K down to 24K, s=
o
>      that the file extent item's range ends at the i_size rounded up to =
the
>      sector size - 614400 bytes.

Thanks a lot for the detailed reason.

>=20
> So fix this by skipping the search of csum items beyond the sector that
> contains a file's i_size.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   check/main.c | 13 +++++++++++++

And lowmem mode is missing the same handling.

In lowmem mode if we hit a file extent we still expect @csum_found to=20
match @search_len.

Thanks,
Qu

>   1 file changed, 13 insertions(+)
>=20
> diff --git a/check/main.c b/check/main.c
> index 49a6ad25..f4a135c1 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -1774,6 +1774,19 @@ static int process_file_extent(struct btrfs_root =
*root,
>   		else
>   			disk_bytenr +=3D extent_offset;
>  =20
> +		/*
> +		 * A truncate, reducing a file's size, can temporarily leave an
> +		 * inode with the new i_size falling somewhere in the middle of
> +		 * the last file extent item without having any csum items for
> +		 * blocks past the new i_size (rounded up to the i_size). This
> +		 * happens when the new i_size falls in the middle of a delalloc
> +		 * range and that file range does not have yet any allocated
> +		 * extents. So make sure we don't search for csum items beyond
> +		 * the i_size.
> +		 */
> +		if (key->offset + num_bytes > rec->isize)
> +			num_bytes =3D round_up(rec->isize, gfs_info->sectorsize) - key->offs=
et;
> +
>   		ret =3D count_csum_range(disk_bytenr, num_bytes, &found);
>   		if (ret < 0)
>   			return ret;


