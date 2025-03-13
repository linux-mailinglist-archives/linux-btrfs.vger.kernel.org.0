Return-Path: <linux-btrfs+bounces-12279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F2A602FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 21:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F16189283F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6691F4703;
	Thu, 13 Mar 2025 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="IvCb7ztb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE701F4631
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741899051; cv=none; b=ONewu7uOt3A5v8xKmYFIJ6rEhGpdMAFNhWIn2Vr5ZFuPYrtpcvn/tURXmizuJwPO6PoQyhG9gaPr6sV1aOawiXUJnfQ/7iON52sGRLmK6RuHRqgZ8F7kH3EfH+AaB/+wKCHu5xTp8E7YdM3jjB/0Sv3Tk2aSOZ/C0NNhBdzSZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741899051; c=relaxed/simple;
	bh=kU1otMD3UpaPLHgxm2JtPm83lHrkfDR2eFZQ0x7Ai5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dc50zjTOiwC2nrV1+Q2cLvp1l5loN4dxIoMNogkBeo3EqBDwZK1sqeAdTJcqndv/k5wYGH1nlvT+QOcVgVLtNfXMKONGSi5MeFF+uNWz8lWdXbHZ1dVMityqmRb/uHnuuJAF7o+fE0P76kT7wnpKX5/FCr6JIBahpqY7HE/Osoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=IvCb7ztb; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741899046; x=1742503846; i=quwenruo.btrfs@gmx.com;
	bh=3Nbs6de5cPt1zy2QBHsGbKVd7j2Ze5Sm3Zu61Tcd3GI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IvCb7ztb2njgbTUa6p9u6yUVMj/JOFFhYWlSBnye9KRU1Y8TGra7opm/M+1V1E3k
	 Z9CCCLsaDw6DGlOxmpkawf6GrejXuPB31d5ck3CaIZNzCA5sCI7syALu0C5AIuUDB
	 yDsylwqDM5JXaXyDJ+B0hLM/ULTkPcHLni+0ZuOS7Ii3IS8Gv+m89Kfyvb82iUUdL
	 pGPubZBlkhGKIGwlBpTGGUMe2ZV0utnduyv2im2pwpDSENN8a97yAlYa/AF88hiaL
	 +wkRdkRK89ZwqJzQeoX0WD+/fWzSFpAG+qPSU0YGiZ7UY/Sh8VVDcRE4WcvEegzaW
	 OMvoF8xTzaTdwPxReA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUXtY-1tjzpG0Z7Y-00Nbsi; Thu, 13
 Mar 2025 21:50:46 +0100
Message-ID: <a7d67638-88bd-440d-88a2-3dfcb3c46726@gmx.com>
Date: Fri, 14 Mar 2025 07:20:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] btrfs: prepare for larger folios support
To: Nathan Chancellor <nathan@kernel.org>, David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1741591823.git.wqu@suse.com>
 <20250312134455.GN32661@twin.jikos.cz> <20250313152124.GA2420634@ax162>
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
In-Reply-To: <20250313152124.GA2420634@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pZkRaaIdhST39EDjhxQttt7IWnHNl6es4x1e/tEne/fDoIX7sHp
 0uHY7JyQDSeHxKAoudLPbZtCADl8iNist2y4VL3cFqgr+8vgUjVnKplt4lJ+mUugOMWmv+B
 cwiJ/Yk+bR5I1nwOqUn/CQmdFRjMjscdeisgOQHmcn+I54RBu4bt22m4eIOXA54bCtxwkjx
 KdR7MVr9NcxnRP9bJt9HA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E5kq0pVxiOY=;OTuoitHcbuvUzUE8qzXuuhMCWWE
 ZpSBbtwXNIOUNGxgNoE2GGRENieox0GHHywdJSGXuoFdokp4553Gzd1YwMPUPLWHA+aJGUYJx
 xR6Cl2xX+XWbkjzltbaZJdFm3BQMQGOBzeTHSeKXtfZ37RSIMHdulgeX4AcyqxS2lRMP7jQf1
 hRX1HnmE0pT+XnIwgcUbcl+7gMrLGNVYJoatOUlLf2qLkhzUtZGWH/rCD3LljhITmQUOVLWhx
 OnB2rB8FC88CxYYtSKQeyLr0XhGUQYT8p3U9NBf2fKzAdthOePJzNkoMFSqpzITOsu0apo7RJ
 LohZTQL3g6o+yiIeQXfdCQW5KAyQZgUAZardaEHn74HB1d3UQsO7/y4JMNjP8zepHegoqR8Q/
 7BDYprFG5E7h3Aw61Gi2m6uwbhW0p6f0N3NyoSR/hGE63XYVCvb3jnbLEEQ4F39Y67aUzg9Gv
 6PUb2FUvF3jZZDbUdG3qCGtAZC8wJO7BJVtRzQ+lvdTaDmcg1zEyR//RnLQldEh4pOGq996hd
 NYOMf8iH5Fx0PoYDo3KMhSeCJoTmbQ6fCBzLej7V71URjKDDsVFLwGQ3G/2gM+ebGYXna27uJ
 DGOxsFRNlSjHcTgdTjulJ8NCNAGu4WBErUep5pSkjGnveyBkFJzgkjlazg+TsJYA5nEErc/bw
 EVx3fVauHiIfTP2HZTid7Yl5c1K8T1HSzSzTS4pkfVh+ehhWAje7CUPyKbVvGbY0JDbr2Hx1p
 B7TqRSFayuzgcegNrIjt+33xLhLxmUsUT+LAohJLL7L6A3c7xY8/ZXrASr+Y5FCb91enoZ6Xx
 PeBoRZZ7b/EBW78IkmFXxQnlRbTOcYPK6LoaHenz0tuqL7JTVaqF37UQR743B1EE94V1yKwE4
 9F9K2bG143dtoGB6mFQLGw6BocjPOMgWviaowYg6FYDdJzYm/UTifKCmjEdxJ4OIQrMyk31pJ
 FkP5iXdHXmobqxw86CpV+wv/vUcvqYWJSladhRa0cZApn+2bhYrn08fa//pwSQ1Qqi1IMjYP1
 JogGXfzMGCpI9DPFj8ndaqkp7RH3GzSOTl8GtkiHJ6Iy7rCxTNhxB1JEwlbpUiv1QTkBv/y/R
 OSUC4l0Pi039mgY0OUlFU3It+HZqMhAbIARvlHSxROpZJDhVjl63bc5nW/GnUyUckTkUywbib
 F8eanc9EeHlPC+Hyh/pgo3v+Oa8w6Dce6LFUoh4B8xc0MMvb9gkZ6tuHhlanAy1y90OQG6oW6
 /Ff6zKNmRfCXxVBJeQETUZu1XRAfBaGsuSiGWqnk35KLdTQ1oSn/uU1ca8qhtySfkLMYC2aos
 F0UKI0sV4ONKd9dhRV+XEOyqp7ioushsxXuQO4xmvQQoa2jrIkzL+0sULBgsRGf3F/cvsfgDe
 7jDNCJpwh3h7q7CS8dXQO3849foT7fnGoq1+qF/ZHELEPJLI8U9rbMH5hTPJMKdAYycY/YBsF
 HQVBtPA==



=E5=9C=A8 2025/3/14 01:51, Nathan Chancellor =E5=86=99=E9=81=93:
> On Wed, Mar 12, 2025 at 02:44:55PM +0100, David Sterba wrote:
>> On Mon, Mar 10, 2025 at 06:05:56PM +1030, Qu Wenruo wrote:
>>> [CHANGELOG]
>>> v2:
>>> - Split the subpage.[ch] modification into 3 patches
>>> - Rebased the latest for-next branch
>>>    Now all dependency are in for-next.
>>
>> Please add the series to for-next, I haven't found anything that would
>> need fixups or another resend so we cant get it to 6.15 queue. Thanks.
>
> This series is still broken for 32-bit targets as reported two weeks ago=
:

Now fixed in for-next branch.

Thanks,
Qu>
> https://lore.kernel.org/202502211908.aCcQQyEY-lkp@intel.com/
> https://lore.kernel.org/20250225184136.GA1679809@ax162/
>
> $ make -skj"$(nproc)" ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- mrpr=
oper allmodconfig fs/btrfs/extent_io.o
> In file included from <command-line>:
> fs/btrfs/extent_io.c: In function 'extent_write_locked_range':
> include/linux/compiler_types.h:557:45: error: call to '__compiletime_ass=
ert_802' declared with attribute error: min(folio_pos(folio) + folio_size(=
folio) - 1, end) signedness error
>    557 |         _compiletime_assert(condition, msg, __compiletime_asser=
t_, __COUNTER__)
>        |                                             ^
> include/linux/compiler_types.h:538:25: note: in definition of macro '__c=
ompiletime_assert'
>    538 |                         prefix ## suffix();                    =
         \
>        |                         ^~~~~~
> include/linux/compiler_types.h:557:9: note: in expansion of macro '_comp=
iletime_assert'
>    557 |         _compiletime_assert(condition, msg, __compiletime_asser=
t_, __COUNTER__)
>        |         ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletim=
e_assert'
>     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond),=
 msg)
>        |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
>     93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
>        |         ^~~~~~~~~~~~~~~~
> include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_=
once'
>     98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_=
ID(y_))
>        |         ^~~~~~~~~~~~~~~~~~
> include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cm=
p'
>    105 | #define min(x, y)       __careful_cmp(min, x, y)
>        |                         ^~~~~~~~~~~~~
> fs/btrfs/extent_io.c:2472:27: note: in expansion of macro 'min'
>   2472 |                 cur_end =3D min(folio_pos(folio) + folio_size(f=
olio) - 1, end);
>        |                           ^~~
>
> Cheers,
> Nathan
>


