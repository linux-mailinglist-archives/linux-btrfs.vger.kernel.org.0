Return-Path: <linux-btrfs+bounces-17202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810B2BA2004
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 01:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABB0165219
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 23:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDCB2ECD27;
	Thu, 25 Sep 2025 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FU69ISxR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AB5747F
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758844403; cv=none; b=URXlkdepIDGwol493l62T7QASlLPo+mdoDqv+TeFLcj6H6veH0XH9o/uDwhPmPrsNpF8xXlrqUxaGySjRWHUyNbKaX35Dp/Vlt+pYBgNiuGSSWYD8vF4oQx760olIfxuCHqouArU2UAO7LcsmZ1LjYoJ97zCC/3S9F8YDmY0tno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758844403; c=relaxed/simple;
	bh=2ZMn4J9SORSOJGvJ9YitMpworZ/x7RyoWbd43y4DKIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CN8HDR7X87j2hqRRyxkBOAxLDzLpyxRQCrA7gGvjC23uFr99NPh1Jq3kiddGVzdPKeYkc0vT36MEaXRAklVhU4j8g0wRgRQBy3Wn6ifVhoDPSrGVJ1vbRdZv/EANBBiQIShj30+tj2IIpLC2HHM8aiWszQCOKT9HKiFf+KTTbJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FU69ISxR; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758844390; x=1759449190; i=quwenruo.btrfs@gmx.com;
	bh=CoE1KTNNPKN3htNHFHH5dRnE88HcVy5oLCP+yd5A/cM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FU69ISxRtk+5oPpquDTeZ/NDRM9N+S6eYUWujOQa8ne++7Uxh5WL1/4paVMNAnuv
	 Pp7e/CzOKdnU2jOsSuRbtJs22en/2kJBHgLj//BqSJUj19cgnWD1ov2xN0le+qlG1
	 TWLvNCrlRhlcvyQm3T+8Ff9L9dVI0Ieh+VhnBQVYUXExeZjDPIRGT6FP771iCGLIO
	 HLm99HGNTcn3XcHVp7Yjz1p77IqGQ5W+wK7yXxy1Z/gbJ0YhLpj7xknjX8mEZLuKF
	 dJl4fqUd6GsiI0PZ3U78RvuMO2gZos5E2nPTClL09lCEEUZHusrHVqLPi2Z28Mjej
	 RnMFmtQ8/050L35heA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsJ5-1uA6CI2Z9T-017er2; Fri, 26
 Sep 2025 01:53:10 +0200
Message-ID: <cae7463b-fa5d-4599-8354-d5524d51bc74@gmx.com>
Date: Fri, 26 Sep 2025 09:23:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Fix PAGE_SIZE format specifier in open_ctree()
To: Nathan Chancellor <nathan@kernel.org>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, patches@lists.linux.dev
References: <20250925-btrfs-fix-page_size-format-specifier-v1-1-8f98d300a909@kernel.org>
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
In-Reply-To: <20250925-btrfs-fix-page_size-format-specifier-v1-1-8f98d300a909@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LIx2/uTfmM3ioNLgRXIq72Oov/03Wzp2L4CYQpt9G9eXWDqnmZI
 l2QiIlf0fzr5jhYs91BuRh4Azom636Kxw94PzbnNxdgQaIf5HJ9kh8uZJyMq1Y0/cRrH2mk
 VBOvCg+wtyxk4c4FSNMzgRa99QeppyKtiKyOqa2ynjxZHGYb1Hya+aDkOBhqQ5mBL02UTdb
 DI2MbEzYOwBZm6GK0GKzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ecWGIrEfOvw=;SvVRdA97wRlbHNPEu+eOH73tuMQ
 yCRI285GJJ2uZNjWstf1DvL5QDVBwNYReFWawzc/dvyYSbaERUnMrEkHPq5jid5jLUOOaUqQ4
 sv5VAe72aVj/0HOWD0oBGZ/DUFoK9OEzb+PG1FfsIEG1Vgb9nArAOk8U3IhC2MbaSWUQfd5Ey
 m7sZOv51JZ2ITGg0rzjWUfKYRu1psxvXc9MWCXC4Zs80sgCFTFZSpzWnH00IU5KfzoeDCs5PG
 PU+dE/4Cx6i0CM7Ak3bQ78asM5ptXohf/HMHEPxmDZ+SBVRCoMa4f9uL6evueWYSouE37PBtB
 f2IRdO+8lhPExyQtuxdCnvJ19FhHK1XNovik9Bga/wPk0h/FsHyXCQo7Ns+KzJhWmtTjIqMjw
 4m0x21WxdqFOTlN4rk3CDvI9RCOsibstwxAlgaxhK9nE4KgGxAe5H507fM4qBVWvMogo7juw9
 udl4wt5BemaQBl6N7cJm26DgeKpOhFPKIa+moZJQwkgUA2Vqh64J5a9gEKHmaGeXqfb9KW0bM
 SPLcrsOmLxaLXew/WksL4C8VDO8qWb3mTsjoxjmLKJ7NhHId5vYHTn43oN3dtX6RdEqBIHY00
 EXrb2Ur8FLREJKOiesqsNVZC9QwrfTiI7a0lsSBtJYk00KQoqKHywwwx/ybasr3hklZm0JEZM
 R5HMcO3GyMpWGkQ7mTziscmZJpR7TOywH43lusCQkdT/BdxbxZXgnwOkaa8pgYt1vTE0COkId
 lk5lEYs6l82oObC49zaZB02JwHkMBs0zm1UkLjeYu8SeGCCQbLc5nEIp5ue2thXB2w7JXXiII
 QRjSPGBvCn7OMFM3HU4skzbmLLtJJRfpI/gRdfp3rHseAWpfFJfE939KpgBDNJ99RjoMhcp3N
 W9I3tmZR96heZGr6cwpdYzPHRxRAv1bRHMXg7d6I6owYbemBD6FgXmzKBBSTVFu0EH71wQuOA
 yiW0bEzScv6Agvtj2Oc6B26nT95+WbIM2FUw0WNc226dvHZXCAYnSTdF3zveH3yUG6TJuZkGY
 nwZA18KIeSjeUmaxAUjYv/ta81d0YxGcONK2UJXd/5MTFOHplhu6Zm2xpJBvOVnWOmAYb8DY+
 T5VlS0YMS/tMcMD8E/Z+7sU9lpOZkwTfc1jFKegWUbr6isv8ZarkZPOMGgjSlJhwiPpNdX73r
 cf5QQFPixPHjwLFBMGwrX46Udj9AaWpJ+YSA9FFT37kf9l3hBOLdoclmdGLz5Eysti1N16D7g
 /Gu5s0i79SsNB6NJ4zuqo6T+ON+swAzDJaJdOFnBPQQa5AfMkeLktS+LUnWqDYvaXlWr8uCeL
 2j7GJp+Wp8IiSKE5BYXMPbUPR6dRk+OYVxxQp2JK8RHhuR77iZtPYvyHhhPsjMXJ+nqdpyGJC
 q8FvOFPvepGLnLNFpfMVuCbGZ4mXoy8b0NgvTIYBrbmfGo0gKhwMiGhIQMHniTUeesw1uwHTK
 j/gShm5Eetui6NrDPPDahpfEyiuraMAAmzvYMDg9JtF1CR/kK/2eayQl1r7yCj4ghFP34ZKuX
 u5g6iOviH/SECHHypEu+73I7M1lZFlQPsnojxoM8qpy9B4QoS+FiU17AQ/mIA8MauTaJpXSy4
 tYqQ4wjuFG6bGSyBcIbhLxufIeND7rfLPvO2kviK2hh8gr1fKs8p9COJC06NnZ7OCse/o7xaM
 diTYc8acs7Bs54iUS981l7xPbiTli8DZH+DkZUf4oxBCR+HEHsLgpOftKezvHY1TshYV0zBH5
 XnSUUC5bEdue4/iEN0mf7xOg6hIlmzs3Utp+BnH8GpKPXqV+TMlXItZ/uQIHHsS8SvW6JHMwb
 8Ftxz0qBMXa4FKBgGozlBsxd290ixG7hnOyAPr/zSJfd10mkHn6BZXxu1J8ATJNui9PzZo+v+
 gECh6h17dTDWvdfRsR8mILMNwjFfpCTTlldNGto+/fArMmG8lCLf39WZoV+EDpWaAI7ZjhXPz
 uepXWmh2WEeFuFXoWoH/wKBvZz+j5ARa96/VfCFhD16TDrIkg4QFlRbh0P8OnjcoCHhOVUlS3
 +0s2y96I8RxaSTgbjr9pNqBpV0wqnC+ay4uWiD7TLHDTQl/Qpm4myzQb/70O1K6p9TEfP7mWb
 1n9jRQx3LWg44dKm+h6DhG0M5rSux07V8HH+KrshfxfFaXatZKVfBStr1qyRud2S17mHEUzpt
 mCXwmmJTedcxdEmmgd4jZ55EmX33aM81R8dEct9CfMiOhaG7IdNQD4PqOX+EHVVnR6wYTUuJ3
 g4KFiFPnt/UOoFW8F+zNQx4duasYZ5t/lVlBtdK85PVnU9PFi5XUUgB1prr8L9gxR6K3/UW3m
 R861WiO4FkgFqNi1ivwv2ubrBQ6AaACP3xejtW0wBINI42nrA68b9U2/KFUdxvBWNljTxs5Fd
 AIxezM+NOgMbzw1Ht99Hiswj7u3RLQX7txAlnQ/3PCm83DG6glp7EDJLBtnxxU7vgrMCqJBwv
 MrIQ8eD/XvEdBsFDX9NQBJahrobMPXc97qPbPkuFxh9sN2/Op3JQHpqF42u1pahTAJ7avmRjX
 rRaFVW4kW3R4QX/v3oW3c0hvgNxWiG0Az3TeT+HVvL0Swc1BXtSnFfRvOg9QIkVEP/YYO4OCK
 uKywECWbCTdyzJuUAnvbkJTAf5hObBUFcEL5X4kx3zV7bEbzMcPZwtWjaqQN4pVvleVBC0K7z
 ZzW6hpXkJZxFbY4jLhubp/dxq6U7quj9bOHe2iSuJ2Okm3GafNHa1XM2KJf50UCN5OI3ipLkW
 v+ikJVrXNUgNOM8Px7OSFVKG04G2BdhpoJLzmPYVl9+yxxjC83ZhoyncKilSrG7INr+BqdA5S
 XpAfXmy4AJT2w0XWbCY3vFjnQrsVPM9otl4xbM6rwkpg0Z9E/Rksemb3ZWePmqfwyMKHhIB1B
 tq2gV50DTQjSPeXlbg8QMOfGTgC3jXmtOWQ0u/GXuP3ntxOTkQyjaIKX7WzmSBwziDQCMEUw8
 HgeJl+CcEKPTBhCHOLfyZuSsMRwUX1gnCujrRGwLLeGo8eW4f3ma9P/O+hpMIX3gzK3SrdnUK
 3gdxoOvn9VNUKfW5wzQd8vjQFL8kiUED1JeVJpf3sT+GODgo85eANmfsmktWxNY5EXXT0tsI4
 L2k2yfp8it2hnKIJfy3+0mj5ggOfZMGZc6cqJZQjJYkMYfGt/q7ipg20pG5Q803j2pBB0ZfF0
 NG64vOs07NCPm6MyC46tjReoezj0Hl8IMOIk4xfMefSs7iqSS1p7sop7dx2fZ35cBP5djss+X
 Ubb1t2AuHqVHN88tCCqhfJHBbg74VIM6WAyaR4XAmZTxc3ZmFACPfMMeAf22fiP1UqHzhLN1y
 K+U6II5hxQ7z8y207qjH8oKh7xuXVnWt3XHUrauncxN7YWpwPtYOsUcSd9K14RpJ1MEcsbqMd
 oFUyLb6Ll1iKNfUgRy1Nlc7Ui7vut0JT4HzKpAshP1KD+n8Rfp2Uyr0GgcguAY/6sapMhJPYe
 fIZuuG4/ZCeVrFl7fnObld8C1qmjUszqfASEpxL3ZBloyOM50+HBRpT+d37tDH8VN8YXNlw4+
 J1xBnCuJSYHyy2e4q5PixQDRxg3rXqw8D+r0R6Nx1+y7nmILCl8BkEOWSHegR4xFuEiJ3wjul
 oXAg0FVUPOh/wlOtxKpM3F3UjaOlWQQCUpOEwD/+2nt7mrVdMlsQTVnFv4vgT1UbeXhGviljD
 mVuX0siA7u411RGAmqU7ZSfbLhn4COXSfacy1vtwIy7uyLwZUhWFjkgqQMe1scWfRtOMisCF0
 g0z5hIJNGTwcLNEBI+cISMKjBIh3PtKYuUxWPCYtyK6C0wr8cJr4X2bD1F5SikfoqEH4raihU
 n6XK29sKjeJKmK/a+H0RsAZztQ0lXJalDXEU6IsnnddbHZel5db8sJd0Oi08TPSdXE1IbJTsq
 vA0g5VqCYBYfkLkXvnytKC6lmn4nQ8eXktqmfg4flBxPBM3i8sB6wTtmEU6oa5km5Y0cT/v3g
 kGjJ4POQ9frL3L8vT7EUw1Ll7LHxJ2mtfAhYQR16oOhzwKKRy5j6JyGnZrksp3KnrDZVrLjov
 dqK2NEHOYtys29dIDgv9+3ZY8lbaRbkZDtLe6WoQWPzeqFIqnd+r+nYNaj2pZnCfaKElrF0tQ
 RJ6LjQZpATKcw75umm3r9xcMsUVJNmh8aBKABrrG6ISFMv+8JMRYJb2XAfiIdP8XVRATy5kdq
 CP6aV2N8MGx0UB8iAomveNqWoXcEW9sdE0gEWOpu+Gwf8XhT2yae9IhTIEI6eSSHdF9q8J5U9
 Iaoq9diYIOrbgUpnXyyVLqgiG9TZFnWOV03nwVCxU8M1swwiTyxj7pcK4dXT6p2/kUWqdly4U
 YdzLMBfBwymj7EVRiD34A/IC8Vpq32kN7JwqrFeh6fUVhW1KkZ9xY7MUXIMdN17vQBMZeVg/s
 lEvgJbaKbxC+0ms72HyHWHnc8DUy68Rf9qlRPOJDoRFdZbt9vj2gVvUcUlHjBJ/vB9L93Jv31
 UAnNk8DAesaVXw+t0iH0N9/SblPsqn0FnnRWOPZUoQu+QALHn7mb1froYSQoAMl60wuFmnBmp
 zoSFItm0vG6uK456i83qjOCkwhszQ/ljoJMeqxQV4xmRYdxxJoaaaOqT7O116LkguuRUtp0wq
 /J5IHCpVjs6v3IkpTAukYU1eTK3aRgLt3gBe1HTOoLN3sVvAdmYkXVv1f2zE+u7LAQCm0CETC
 C2WIbVSTlL9411AgJPcSLtFQkBQDRot0VUS9ZRntlV03weiJD6w3ffROKzDL5QONGJeXMnTwn
 LLjeK8F/TJqZzL9ORQNCaeaKtyfrgYNOiiP8fuoZqGUk3zQus+zHsbsK5b18Z+uapl1hS1cwy
 SgC6QBPs8uk1LSHhI+bNlYj8gzlJR00RvdLbNBEB0R3IAkEp05FS8fy41qSEXzRpPlfVBtYZ6
 q+TTlGugiK8fvMnfNESzDhLcMIng5yisL1jpZ1GukkX2kaDmEEZZqjSGGRJGryaSocWR58he7
 F0Fpe5v5ni/kCCHY8N/B7Uv5gkp2rFaiGjwESbDSsvolkar1Cy+V8mw3



=E5=9C=A8 2025/9/26 08:33, Nathan Chancellor =E5=86=99=E9=81=93:
> There is an instance of -Wformat when targeting 32-bit architectures due
> to using a 'size_t' specifier (which is 'unsigned int' for 32-bit
> platforms) to print PAGE_SIZE:
>=20
>    In file included from fs/btrfs/compression.h:17,
>                     from fs/btrfs/extent_io.h:15,
>                     from fs/btrfs/locking.h:13,
>                     from fs/btrfs/ctree.h:19,
>                     from fs/btrfs/disk-io.c:22:
>    fs/btrfs/disk-io.c: In function 'open_ctree':
>    include/linux/kern_levels.h:5:25: error: format '%zu' expects argumen=
t of type 'size_t', but argument 4 has type 'long unsigned int' [-Werror=
=3Dformat=3D]
>    ...
>    fs/btrfs/disk-io.c:3398:17: note: in expansion of macro 'btrfs_warn'
>     3398 |                 btrfs_warn(fs_info,
>          |                 ^~~~~~~~~~
>=20
> PAGE_SIZE is consistently defined as an 'unsigned long' in
> include/vsdo/page.h so use '%lu' to clear up the warning.
>=20
> Fixes: 98077f7f2180 ("btrfs: enable experimental bs > ps support")

The commit hash is not yet determined as the PR is not merged.

> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Yep, we noticed that through the recent bot reports, and unfortunately=20
it's too late to fold a fix into it due to the code freezing period.

If Torvalds rejected the merge due to this, we will have time to fold=20
the fix into the offending patch.

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 21c2a19d690f..f475fb2272ac 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3396,7 +3396,7 @@ int __cold open_ctree(struct super_block *sb, stru=
ct btrfs_fs_devices *fs_device
>  =20
>   	if (fs_info->sectorsize > PAGE_SIZE)
>   		btrfs_warn(fs_info,
> -			   "support for block size %u with page size %zu is experimental, so=
me features may be missing",
> +			   "support for block size %u with page size %lu is experimental, so=
me features may be missing",
>   			   fs_info->sectorsize, PAGE_SIZE);
>   	/*
>   	 * Handle the space caching options appropriately now that we have th=
e
>=20
> ---
> base-commit: d54be55d7a5eb9ee0a758580079adb2808d71a25
> change-id: 20250925-btrfs-fix-page_size-format-specifier-21a9ac6569fe
>=20
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>=20
>=20


