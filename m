Return-Path: <linux-btrfs+bounces-17815-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0C1BDCCA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 08:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAA319A6FB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 06:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D73313271;
	Wed, 15 Oct 2025 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="nNuO6WKj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D06A3126C4
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510993; cv=none; b=cvSrsvBBGA3wznuHiutxgEv6R36fezkkw5BUlbdyFEF9uIoe1WrsLDze4+Hiv/njovUb0qjM4uDksKa50Ocig6N2w4WdORkCh84su66hnUh90mAK5qN/A5NlTRx+nHdNtsAw44w+pKQpsPvFmQaa+ooBun1ypM78x41NBKTgu60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510993; c=relaxed/simple;
	bh=ZS0eIWksN8/B+oD4HPX6W14xM5PC2fTHuE/hrU4ccPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XM7l4aLxGaZNMs0tFlRrz7fV2oKuUJongSRfZgVGJvdfR25qYnHsOuEcYQ2QduaLjc/6iPnDRdjdKPy6LnfBexLQWAoD9JsrEw7stYGWgBkxE6rMveYHn4Y3irn9g3NDz5XKJmUbn0NdcA4tFvI83WxdIYZsf+2jJiIg3uo4aXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=nNuO6WKj; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760510987; x=1761115787; i=quwenruo.btrfs@gmx.com;
	bh=pvd2Bpof99F9cOqJq8vfEhIRglnocT76rtsC4cxsMGo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nNuO6WKjazWHJnDFRFUqhoBYj/+bd6G0pkbQlNI5Veikj+d0pbS64MNIRRqROj16
	 kOxPDhRpenlSeJOMabHnY6xIkUTkJBiQXxY49VoYYFNx0RknkCFAaFstgFneCAnNT
	 4XWCfv4NBBoLqWZTcGbe+HMxZBuE79dUbRMqutkYTktfd4cQC3iRVd4k951ApAnq+
	 tAz+kZPUVKk0B3aNM5S/G32QDXb6xfOP8Bj4Mt3OUprWKhe651+aglTedTkpaB25e
	 UQGz8j82TpwDQsdkYCy36n6Zhd3PWmxxAosswfEJOKg61YGzI26yjBa/iyDOQtP4F
	 ck7UzFABWEWlqpb65Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9MpY-1uCkDW0v8W-00tvYy; Wed, 15
 Oct 2025 08:49:47 +0200
Message-ID: <3247ee84-5a0d-4561-8d25-b1b8e180215a@gmx.com>
Date: Wed, 15 Oct 2025 17:19:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Setting owner and permissions of subvolumes in newly-created
 BTRFS filesystem
To: Demi Marie Obenour <demiobenour@gmail.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <0ff47dc5-cf0d-4b5a-8d84-f309a74cbf32@gmail.com>
 <9194ad3f-183d-46e9-afc3-b52ab2bf28cb@suse.com>
 <fa8d6257-649b-4de1-b723-64cbc34c0a7f@gmail.com>
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
In-Reply-To: <fa8d6257-649b-4de1-b723-64cbc34c0a7f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0f7EhpE8yZO+/Hz17ApiN7GD9n++EQ3FraS8LW13y68Z2vOnGgr
 0i70l2hUdUMWXrz2PEez2djpwqqnvqH3+/oO1kb8RlltgrSTNHIdj6Rdr1tj0C1THL5t16L
 HpSTMXzTpX+8OXYBL24Shbdquavw6a8hjiGFTbzKtCwNnGY0KJE+QxBE/GP2RYAq19twfqI
 bVnec8FXA3NuVOXX22yDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QhN3fz6HazE=;4D501VJecuK4hUrqB7ogFCrBPoO
 8MggyKWlm+1ujM80XD1+9BYhK6V3ySuUPBnKFF5Tq+Jjmu+uym6wtw4xp0qbOwDlgbZDK04jq
 2v2M6eshRWdvwvoz00JSq2BWT14HwLVMcT+sQULkO0c8cssyu3BkTNn2m3WFKUItPQC9Tf50F
 +JvmvK2xu0vE9hU/je0E98MsiOziqzUER380m3Qo2Ik4GkE5SD9mvKBUhHLcU/AKrS/lizFYy
 VfUgr5mint+Jf3MdC7ZjYjD4k0K6xk4Eg5pa3Yf2btWGBJEjhk6b/79iJBUm5f8MUVjUnBIki
 g89pmR/rMBg68autvfZ7WWkg8QcAKZXnc3kdrcIlsDpSg2d7h/x8aOnRZWEZtedj80ghHLTxh
 DHnYQEAhdAL6YsQNUHyeVuJO3bo8VPDaWcirrlh04CfEwYe0QqNct4luLhIYIle4/fBV7MI0s
 voYmCUZg763GlidYNwIfEbN2xJB59pdNXLNRZC3gS6dfU/3q0iPSghzX+lmh9xJlxh/Um69CG
 GPFfr5CHIEzsrX3JP6FdIY/M97iZZLjk5yhgR8OA0ZFbZ2rqgJ4ZF/v6/lmFdXYDJSOQrKXVq
 t0fO/pQKH/0OVmU2nPtqLriu8u6/eHLOuJeRT6wjezPaiHyWwpnujQ9tFZeUIteDc4OJPPCz3
 dDwY53Yp7MnsS/LXepByahX00FsJQareLVy29LX0UPG+N/f78cE7qHZW2Ibj4uZX5wbhjVDIM
 3OAjv1YRJTkJ+1GhD50h3Fm0lCdOrV32Xerkg/yyrJ/yY35YjhcZfBNkfqcph8DNVMLm9D78O
 ciWjVL6DR24N2EDpNJOrJo4LKQtWf83wQCzpvdbQ4VNySZQIj3+AkuE6DhRCfBeGP9Awh1L61
 zyHktLn+NPLlzXF9w7fo5F19uAFnAokSX6rT8ItRGz1TtO6oG9adTfyf3XOtH+cX5Bx0nc405
 B4KO21y5LsZUNOEKrarRZAdCHJgvx1hdTVLfpqxScAAkP/MT+BqH1Ic7BXoA00tXBPS7N2VXs
 aCOiXoSwjpgul6njd2AL6s7qldOPnNeJKMOUhj/grXvtGvHehlNMb0hk/vRVkkoCfQ1ZKGfSI
 CsfbDCWaP6dye5TepocpXiidx1lH/sQgf8U+2BRmOCWnDhSQOcDad30L0nqgQ3p4/ye4fmSpm
 /+6Pg7dP7mpUgb+LsVtZTxn/5jety3TmcldgHSLgRWOb2OvA0JdFEKqskGDty5IYLZTpV6vD+
 /gTus3ldXAWDz6puCyv66uh5tTsL8lwZr5HoTBMeglI76xIpqCznC4Tp/VZkpc0z0ZVw4C4/9
 rM+cCUK7lEjbrjUjygR3nFfLXTyvPUsfPud8LuBlket4bS8gIrRliZZaXC3VZ3UWxfZwwEaTQ
 cvaDQ6jrIpkw7JxP0jmC/0CltqOc41miWzqGtiu5z77InGv/5siyG0a6cmqpoGtkv4KhIi2bH
 tJAYJG2m5QZ1PxzpQUi0U2KmwSSPoBBdk6teTlZmQ9B2zwV3wH0bfMwyHaCthnq+KVfIt4ni5
 nx3D7ELK1bJ+FPdsBWAA9GpvEwnlEoYJCgqpcwOcaZ5bK0C7saJbTkZgB12kBhjK2weUXpf7b
 DfIm5ueCoe7OnSU5+/9mLLI2u0BdbqL6leHok5XunYvEEMP8hfxbyURtkBwduYic43PWskA80
 qcNkYQJ81CaxPvEvFANIrCN8URDIes2C6pjE3peRFxLIUhRwMaNF8YgtJRxXc8vnIdr+sLjTI
 d4nunq9Yf8tKpOUIvxsmPhGHQ9nUuTK8ycEx/u0RN7MFumxOf2TstYQ3JVXZkwwZZGM37u78T
 Vh8k/hlC975MtkRMElRm8N5Oiee1oUlaKlo3n+lSmyo1gBolvGIjUDj4bRW+aPeweeU9l7jcP
 m7LxPUQG52aOfGx0h8uoG8GrjqZ04BQ5703IH8/EUKl2Kmzx3z1+Bm0Qehdbhuid3Za65HwvT
 FhQJfZmeLZ2z4CcUyIxrASTIaxqtH7IYCAdViOyZQnIEsUmOS82iipZqmNaYYtE+euMeQ65Em
 PylSZRGOt6XtsOhf6mdp48hzxukHSq2QlS7PIZtTf8qVZhs1D8nqQGMXwv0/eT6BelaHuPjXQ
 vs7bWl7JAklLeBtqCV8tf+D+sDK16kHAl/7w4w+K0OIia2Ent6WPcbGlP7Ou+genpEuiqFhH3
 UNlkaKed4RhzDHKBqmVdyA1PvBopCAjdvbsLXR4SofFSqnObKaGlIxIqmZRB541cjvZOSXtHI
 VLy89zBISacZlYqxoMPxN+tzGnlJT5sdDdEhmgD3e3TeZtUy4kZ4+VZOH4pX2wFn5U6z/E1G4
 j5PZqgjw7g3AmIluAbDFKkEeA+8+rIR4XC8OnI9SjyPweVNjWe7365BbVjkSrv6CkGw7KzezD
 +MbH2wmbXdeAP/1/pcFocGm7VGh7GhXtTRCgenNpoybuUBdbQZQ3p4aw4XOwbdAgjh5maFNRM
 VEm/7lOyHuNPv1NKpKIz76wTJPLC7N2S1yB2+2QSg8rCl7YU1kHXLSwl9iXT2A/YD0pd6WWQQ
 M6puCcdcz1s+FSMHhgrtmUAWWf6RqL70LvS9gkyqT3JJ0T3dkhINBsDFSd8PwqzsizQ8P8Bi9
 IwxChIwAbJZ/MQgFmert8qPiYibyd0z6L8lJC2WyjQDV5YJM16QUIsZpCeFvStoaX5TOGlnbM
 DkJjT98rMVPALSyrkf6NA1BXbrgZUG0bay7aaezHgFRZv3/qUQ6lsi6W8BrvFNtSFtsII3Jxi
 a+ioZpmVxusahQCeoThoYCQvwbrETJ+6RJp72aTO4dB0CdUjn8zGuwOpykXbwFTPGUn17wwbB
 9O3r57JV8SYwXjuK6QNjSfpmElcSR5fYS+lhIzI23LkKVIcxfrm5S5SlKvYg9SAwrTVPRDoxW
 Cjn193jM6BFGJCtg+8BZhfMFkN4pP5dhyboJ+z07EhDVHcLIbhL64Flj5vIhNG43e/kzqH0Kn
 GKkwyQ0j5gnM0CMKNsHQG2bFQfdcSX5dXJgRzhJniMVtpsQ0LmZwuwGZZQfooUezf/2qcjvZm
 wxqFioZ98TLC1/EazfjNXcp5CndOtXzC7vEfcQHfN2YWMPGX/8YPwUvaB8T3arCc9ZV+y3SEN
 vFyZkXdOxk0yhy/epmx5gqcKnRMwYybXBb7PkRem1aC+t7wQV2GVU2ETI/gmtHnJgym5kxc6P
 mxbDhhlyOQD+9di/0RYunm157CxlHI/DktpzHu9GBUIJ8x42wBuN6/UcS+I51pODfKieuLx3S
 Tg3s9gh0S7/uj0gyjitkT6g4TPFW5tb6lCwxdEJGxdrqHN6d09qtZPfOuyjwc9wgen6SGBp6H
 TgG4WI5L/4j0UTG08K/XcXJXaTKIFHhY+FDcZdMC/EGnxcJKv3Z2Wb13TY7HbvvkHM4MPrwSb
 Mys4ETkTrP0OEDcyPLFumPFZRuDOPurz7ROULMD4Aw1jQW2ibLvni62QiP8QDIk2QRi6chOAD
 5PP/ZGFvJRTSZqnI4sUhWfRXnJQOg9MKNJnzfqrQzd2CNioIl95v0xpCrI1CJndl/XlLNAynC
 N84IrcQn+5Sx/ptW1WapXPdyKYf6Wk61s/4zyiZNjQjdYJ4xPYNfmzSkxG0fH0yk037ws5tIy
 O5kAynLZ558I4t/yOVZYIQawF/1UOgXxlXSMvNbMSI+RhN93Yf876nt0yGyLE65xpHzZUzSh2
 Y53T1nEJwLGilRWK4n+/pLNVK0Z37Tf5MPkUSvr7yNwEk58sUE+ZZOM9SJLVIuMSi12b3GWvb
 lmz/SJSibkFrMlixLrfE0GPjvlOMHHC1l4egEdZ6ipvRw1Ses5UIOhDXi6xOKdR11tV9NvPLP
 dFOtCWlKWp0Gp5dFTf5xbaPuPth0adhfrAY9waNNOnBMc+q+/IdbeYf1CLczL3jnoFponNAU9
 UPI/8HbWtj/VHa9nIyC8iJ3ZZdY7SRsPN1hHHRWzAMcoTSxmQxe3VFKelJE+jxVrMGmMjlA1v
 l/MgvT7s160D0Cqzmuu/M8GPTZRJVRS4U87aI/Kthth2AAiJ2tsTrqaXptNSAHQOnnG041o7X
 AHoTE6CZDqz7oPus69VUIANGeiXS9iYQcg24T6tNtVa3uu9C61xxB4PHH7tRBn3gU8bPjvg9H
 5rVZmvcjD/UGKyCIPlLE5dc7zL0HWScFdlWvUSgV7GVFSk2KowiwkKkp6FFKbmdwHrQXdm2P3
 DnUb3Fvs7yjOoAvcCWOAm0rz4O/42Bl7zgIAY8fI4914MkCjw58K0ImG4MuEYu94mE/9APZjB
 Dl1P8CTaTHlPQPngTriTNlPrGD6JGBNrgkSk5rPFRiB836MVkOasgI+uoxm1h/7HrCRewNVbc
 yRA/PWZHgZ2SsX2ggj1jn9gzHzWYbK+tQDbMHYvDMzicAZvUfsd/X7mYoQ5BZxVeE2XKWl7Zb
 J/dcGgDLianr21cq3cYV2cMSJXymHjC/uWW/XdEex64gsbZzddy0zORGtBue0p2qb6ZIo/r16
 /tWydS6GMuno4PdJ/wVrwkYLIPUacUmuMoCXyMFpbsyuloXrYyyUqencSKOtzKZQDvdPVFi9W
 PYnO1INXqY2RvaWmh2OdN5iWDFnAeUoVfHP7x+gbLNpf99r00Ur2YNp9Adv00ouZNj79DQ2rN
 l7DyngRO8u2ZQwKVCDXWGIB8MG6OlEPVaRQlx5A4mNc4kmlYvCNgP1Rfq3UHBBtk5w8ME0pNx
 ujj0V6cLb8t4b8hR9JRbt5GYawVwIYp9yhO+OFChEUQIwf8+YmSjg6aXVsxRYY+cDIoxJi9J0
 O0IH2+kUcEXQMV78UEXv3kb8QFLb82/0/6cvnLxRQT+GfrmTirs1Cc+lalNsraR4y8Zq3vLxZ
 oDwSGFGLVKYVwy1wS8cinM6C0tlPinuHQcCgbejpzPoEy/lVX4GFSjCQGwirb4nxAD94i6I4j
 M1tgafIgH/aXbckd7IgEzWnUaHWCyGkZiiAgoQomTfNgtiWIOWGycQMUUzYtlni9j1xiDvPpT
 qyqaMcqdv8Wcc9gn7A6vAH2YTZoLMzges33Y3nlNVzOsBnNTyrSD+n0LkjfvBQHyUS0Fg4LW5
 EyKPogJcFfiipkdVwiFO2SO7qg=



=E5=9C=A8 2025/10/15 16:31, Demi Marie Obenour =E5=86=99=E9=81=93:
> On 10/15/25 01:47, Qu Wenruo wrote:
>> =E5=9C=A8 2025/10/15 16:13, Demi Marie Obenour =E5=86=99=E9=81=93:
>>> I need to create a BTRFS filesystem where /home and /tmp are BTRFS
>>> subvolumes owned by root.  It's easy to create the subvolumes with
>>> --subvol and --rootdir, but they wind up being owned by the user that
>>> ran mkfs.btrfs, not by root.  I tried using fakeroot and it doesn't
>>> work, regardless of whether fakeroot and btrfs-progs come from Arch
>>> or Nixpkgs.
>>>
>>> What is the best way to do this without needing root privileges?
>>> Nix builders don't have root access, and I don't know if they have
>>> access to user namespaces either.
>>
>> Not familiar with namespace but I believe we can address it with some
>> extra options like --pid-map and --gid-map options, so that we can map
>> the user pid/gid to 0:0 in that case.
>>
>> Thanks,
>> Qu
>=20
> Thank you!  This would be awesome.  In the meantime I worked around
> the issue by having systemd-tmpfiles fix up the permissions.

Mind to share some details? I believe this will help other users, and I=20
can add a short note into the docs.

Thanks,
Qu

