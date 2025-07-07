Return-Path: <linux-btrfs+bounces-15284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2B0AFB1E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 13:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B9516FAF3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A3C1EEA40;
	Mon,  7 Jul 2025 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Cyj3osCq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FA927453
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886057; cv=none; b=l5zWPRtn4CK8eJrifRmAq5fOuX33cdxZS4uMF2Plzm/FWfvPfdQDkFxphzik+nbmHygALHAp5sBt+lv4oXldNMM1+aVlVpYvNfjVMZcvVGp4v3/6fCRZNZNtHwx2enTUUDNV5QrN6FfWJWcVdEfjAKE272/2giUVvCKkXKRnCCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886057; c=relaxed/simple;
	bh=G97zFCzQRDqi9wEAZkspk5YpIlDjGXeqV9gqgFnp5lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O++YjYfMh7/oGTEEjDGmFkiGO7bcSXnNLU2KpP3uVJVDejPQADGvkfecvi1hgRxNYvlo6a6A9V2G1jO4oZ1yFZP2jvD+iGVALyYR7jYJqZAmPb2rVLVcNC/asV9afY38uFf/ueiMQiE1LpJCdvubUIQ7cvKyUJF9wUquwZlxUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Cyj3osCq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751886053; x=1752490853; i=quwenruo.btrfs@gmx.com;
	bh=G97zFCzQRDqi9wEAZkspk5YpIlDjGXeqV9gqgFnp5lQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Cyj3osCqsRnu1ekUVxG2T+0Aj0LtACz7ClUK+O5k2pa0EGBs1yOfRyziSyPH9Iyu
	 0hkstrB9TxB6TAGL0yEViXQJwu4Jud9HX9CTx6GJpEhg/+JfWfoYeNOVwWx4KbTGL
	 r/ZN5NVDThQ8XN7OVJ22j8eN+G6YcBrz8B1CZSkU8EHiwKxRB1RWHMwcFFuwnaJA8
	 ihT+vQbh8BHAEtwO5iSgU96eke0uNzJGonZ4DEyPVjZthxceTVcCGP6EfYKmcqzrj
	 wPnArdlw6/9Q6cMcxvhGBk7H3jPVDJdqthQ4DyJczdOa29rcPvOVjLKcgYN2IQ420
	 1cqJn7yLA3lU7o1kTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnaof-1uzn4I3a4r-00ZUIK; Mon, 07
 Jul 2025 13:00:52 +0200
Message-ID: <a6f03aff-c9fc-4e7f-b1fb-42d6a4cd770a@gmx.com>
Date: Mon, 7 Jul 2025 20:30:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Increased reports since 6.15.3 of corruption within the log tree
To: Peter Jung <ptr1337@cachyos.org>, linux-btrfs@vger.kernel.org,
 dave@jikos.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dnaim@cachyos.org
References: <fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org>
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
In-Reply-To: <fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yiEHb16JTCXNPdD/6g6+jTP7xzfDmt0DFFUIPUvJc56Dx+oqdW2
 ox/PyirFJK2yLFyoLOkcjGcwLd/KvCUxhf3qgBXBgPlNja/29LnTDH1mAxPI+LuOmKkj9qo
 zkb5QTI+BipGc9YJaPx00NVMwCyj0La4X6xXOCmp/Gf6gUWphtuNPUvvKBbMQ1mu1H9V+P1
 6bGpVkpwhv1lyL0yzH6uQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0TfuZDP1c3o=;3v+SyWif9/D4SLs5sgeZwdt7VGi
 BcVsR+AwRxsVeVlkFvbafztjY4Js5K9Blz4fRqkcJ2Hq4HYujUF+6rLheoLhD4+fYmtuLzHg0
 K2jD1TApAVokSEQ0UhAxRx8ptkAvgwH6KLnTazYuJUSGWoj3BXyIluQHNsfS9MUx/JTEHlC+J
 xLZJslE2InchcmXgThjkFfIDwxofJUlil0HBk/UbRJoPv51iWCpI/2ZUQVmGHvUZ9P8aWYsHx
 4FdbL1lPcY8JBp7AWay2DdtjW7KB3rhsHKfI8s0PbMzQY1aB/n6DtjnlpGA8iH9LpvToPI/tg
 VY6NMZ6Oi4y3WU6wOb8WBTprNgWDEftrdBcg2HluG2yK+yK1wWPyxBwTe/18/CpAXwfST3vxd
 sq3X40ZYM50Fac8HSWNMK7HnDAdHsn0m6MXt/iSQBtpsaj+BYq63q6mZKktZ7cAY+L+MWG5fE
 agNzGV19+d+lhAL9rJ+wGvvi25LFS/O5o71VnwA6rMWMJZiW5kS4xEnOWEpphlsZOnYmZ9IZQ
 ohmDfl5REcammJSDPZF1rYqcBAbVtUWgxkLcO3N4pKRNZe9KJwX1liKG687F7oFLkZFS/9bdk
 xIO+dU36rA9zFOnqeVwmdY/HG8up+EroN1L2mmeayepmg82QTvEp738PQ5Qsssz2aultuOgIx
 9CgRNJa+eaR+NadTtQ5Qsufhj7FHLqnBIgbIMIxca6U9Ws3hWlHsrSBiJVY1u/V7ESq6bX39D
 mVNFfq9WEUv0eS+IZ3QU23/m/GJKErkrh6/faloxAXt+7j85gBaI0mDiEhmqnmLmoUftMCtWZ
 l2xJrJkWdl/mEFuhuGj5NrkSsm2ckTHmHpHW6moKXE6KdlL+7sPuVNm9LJkwlql1W2J26KsF8
 KgBD3FTztVTi5sKXcrNV3OQQm7dSN8I7f4Lxws4Tt3D1n5uiR9tfXLSk1tRGKS8Y4b43DISYc
 x2wGQUusSa4xZOStpwKOTKmWath43JYJYDsahXGGmPYrdmgupg9liJe62snczIVrejJdZNth/
 OGV0r8YtcHthr3hO82ZirIQZECOQYcwq6fIwFEnACyMySBG4nSBrSXS45n5LgOSN428HKINzW
 3Ezprlc6cu2ICoCO3DEc/7N7iEeXuHAG4zhUPhmDz6aNCjoO7QukN2rpIwIUZber67ESE8CZk
 XdnlRKaxNdU7h4CcfhACitAuWzU6cU2bONHANX8UtKpjCdf7EVLtbKRoFYTArsuQB3XRuXPZY
 xbFhDm48t7K7WXe7VKrp8lx60wlzx6MZnJMHcsHAV4v2E6ESfBeFlBMI4oaone8V6K9S++mtH
 xvdAj9AMdhGq7LlyzfUAAhjc2R+cOe48N/eUZJpeikzfuxnJ3anjiTHhp38KMZmODk1Zuerqn
 LvL8MGxolxKeYRUKZ07WgT11/xHQ9Dg96axBOE+NuEFy1c9/UNYoPZPPsgTpFJQ1JTNubapa2
 peneDc0sKMTnHwO9vDeYJ3kycXDav8FxVMTct1vqGPDAXC0EK0JksDwLQFHMfh2OGh+os7ScB
 sp1BTt/bxSq8NDTj8ncA4KljJgTUr9LZRURjq3IJ7VViwUdkRLWb0NXh8+mftEWPn2gvWLAGu
 PcizoTuJ5tg1kI1AozYvSGztM2JQ70G4RQi2Ysh7D/7CAcZTgfiBtWXSLyZSfXPou8eh0fLrD
 MsLsvAhE3O7l0gFpb77NhAQ+LUtuDhkO2vyI3ofdNliLg7tOwAjPZXweTKs5kohqLDBElIxdv
 ihOZdYRsuM4QjZsmxk74ERik42swycIcp3BSJIXrtiZovidBed/oJZf0eX2B/vmDL6rrR53z6
 JTT1SDLC86fVeMnaBRhp5JW/kg3M16TxGLR0oI+Ek50xOlIqgZ0VhOC+6lA/u0IJNa8EmrbTz
 qR8pRJHHuyoNHaf96ETUCnjSmvV+lwOhL2W8EVasur6KFuUnEHQyjdttau4AkJVmyaS+kYZM1
 VRUD0lQ3MsWtGPI0JGFgD2zMPxyFRxidhGr3f+QmdeSUeko2SDItq4CuyeE4Ocu/0V0/7VnGz
 ElEZbfoQfboCEmct1AbnRh5TYfE0zBQ8L9MDcBN8Qv0TrlZyabpkIrtmyFxSaQQ7hUCD8ZF0f
 oTp1l4G3yWBViuSagtjBmC68HmmWE1S5iwMr5Ahq/imSeDwq7Ohhb5hF3/vRrn89FuEDaVF/h
 9f5xKAvfxi96exrqlrEkjfP5LI6/G1dmPOfWjDjiTZAMkWu5TuT/NCkrbdBns1rVXUbFOJ48o
 P8do65KU+BhJZ4HzWW0L0t6r2Qzp37LD2GPBQOMgaBlJRh6VHyUNYQdMLx9rJJeVV7m+RkTr3
 r+LSkfCFfi3fYYTI340RyES2VMNb6j42iHuPNkabZRgbouEtCZ/q9GJsgMlO/Pl1lOrGd9Ukn
 GhpXFVXa5LT8uwGGsv00Lmuihz999oP2MuTZC2r4PPVsgOQoQBHkoCZT0ZYkr14/FyNsAGbjp
 WfVNAe5IJNLzVVS4+xqw3guw7U60tehmuItwFm8VfniaC+/Eb/ZJ85Z3TKo2A+fW4r7V38+oW
 W8lP6gBtHZWRr5T+cRNsQQ6iDTBzAZerJ6kYnlM/wNLdThj9cdt/SAj3XpdBRcMFnf4Y3K4u0
 R4a91pJuZWCdxgwFAeUJP4MGuVDrbPUGOoATuk7wTjCIY32VD0MeF9RNf6yF7BZHoMPgHSjPj
 lzx/wZHkhoSMIWQitthMnV/jDGneGJC2n9bnHkZRYmGdZ10DGNAyEzMRg5YABS1Psv+g5AwfW
 yevjtjsU8RWLWVkxqal7pEa9e9/QIVGKBjc7YPtRAvIgwsrf/f9Fzcmxq3VBVzE4RAlYbhkbf
 42uv4ZFZziMeh+/hmZhFkkU0HSjoZIiXa7pCLRHmjJKx3jiworbKtC0IMZtDXoPHZycez/BKf
 MDJzLisjNmThnGutYFr/2oGRiWXLvOOzn2F3v+IYDURmD//+LXm2beaa0gaTA9hriB3L8X1Uf
 ZZGmpJ+ZV35mGKRnfeA5fAiDnY+0LmlbnXskMWCkmhnKZqqlMqE2dbZX7NbFCs4Vx3+KjlvX4
 +ERZHzBpw0p2bpElFLGKJIqCcG7ly1e5f5+CbmAZAk3qQiBHiSSJJDtRPc44YLrY50zbXOd+n
 3rasSLxLrnourtwy/kVINZiE7R8nGfobwBQfz30kpRdtji9rXMdch61IWcdJ9XjNfPrInkxjk
 ukHRNshKIUJwHhk16qhCwPaHQjgZmVj30v4HXvh6DEVKnRF4Qeersth5zh+hvxKQ4QmEe4RBD
 4VzlIibwyqWSE6TPSUAahIhYqOwGDq+uNuWZ/Phw/yjXuDDqbrc2CDTFdJaBrCz90ud0yVyAN
 WUnleUmkFdsXaBVoLunWyPOLdab0rnlhh6kqSj6YEkMjIY3XrxSao9GYrXy4EKmfp6Eb3+hJA
 1PZig+0Gj4FRkkhLm4fwPkeLYglFsVASiG3GEc0T3Oz2ZgCV66zJtZFNDCzYWGASHUnW1lCGG
 2Kp/5EYZ1mH6y3oLnZoeNscejq+jlXp+8QaLikqDU6bfvXY5mkhfL



=E5=9C=A8 2025/7/7 20:16, Peter Jung =E5=86=99=E9=81=93:
> Hi all,
>=20
> There has been increased reports of users reporting that they could not=
=20
> boot into their system anymore - sometimes after a needed force=20
> shutdown, but also according the users after a normal shutdown/reboot=20
> process.
>=20
> The filesystem can be accessible again, after running following command=
=20
> in the chroot:
>=20
> ```
> sudo btrfs rescue zero-log /dev/sdX
> ```
>=20
> There is no way to reproduce this constantly.
>=20
> Following commits did land in 6.15.3:
>=20
> btrfs: exit after state insertion failure at btrfs_convert_extent_bit()
> btrfs: exit after state split error at set_extent_bit()
> btrfs: fix fsync of files with no hard links not persisting deletion
> btrfs: fix invalid data space release when truncating block in NOCOW mod=
e
> btrfs: fix wrong start offset for delalloc space release during mmap wri=
te
> btrfs: scrub: fix a wrong error type when metadata bytenr mismatches
> btrfs: scrub: update device stats when an error is detected
>=20
> Some reports:
> https://discussion.fedoraproject.org/t/fedora-kde-no-longer-booting-=20
> likely-filesystem-btrfs-corruption/157232/10
> https://www.reddit.com/r/cachyos/comments/1lmzmm4/=20
> failed_to_mount_on_real_rooted/
> https://www.reddit.com/r/cachyos/comments/1llin1n/=20
> error_failed_to_mount_uuid_on_real_root_cant_boot/
> https://www.reddit.com/r/cachyos/comments/1llrpcb/=20
> unable_to_boot_os_you_are_in_emergency_mode/
> https://www.reddit.com/r/cachyos/comments/1lr5nro/my_cachyos_is_down/

Unfortunately none of those comment is helpful.

They do not provide the dmesg of the mount failure, and that's the most=20
important info.

If you got any new reports, please ask for the dmesg of inside the=20
emergency shell.

Thanks,
Qu

>=20
> We do not know, if the issues have decreased or improved since=20
> 6.15.4/6.15.5 since we can not ensure, that users have their system=20
> fully updated.
> All in all we got on CachyOS around 50-80 reports since the push of=20
> 6.15.3, but there are also increased reports in Fedora and archlinux
>=20
>=20
> Best regards,
>=20
> Peter "ptr1337" Jung


