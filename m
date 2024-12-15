Return-Path: <linux-btrfs+bounces-10381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6CF9F2230
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 05:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867C21886B96
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 04:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32D5DDD2;
	Sun, 15 Dec 2024 04:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fwUA9sCr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CF9450
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 04:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734237975; cv=none; b=rDl9AU9TWY8mqbIunO7yIcw8RBNU7vaZquI6jbFkusREY9qwzBof7AubUNQOQkT5imJW5Mse7E2GLS8szOe09ylpqpLRgFjYbRfdheQCj9AIwJaH2/4kK7MbGlrnqhgE2tph1yOshmpAoQTyDwLFywy5Cdf1xmse9ueyCaXTBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734237975; c=relaxed/simple;
	bh=zcsDCKDQ2Sa0RD5fGAbCpBnB/T0+j8V/zZiP7O6S5g4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KtX3CYZzfuUmto4B59A/wqU0f4aYmmr1MqM51LekqcYze/z5IwjKVDr//1r+x5AkNSh/bzGMhZJURsHOB4dEGykUFKziRbyqU7q7wFyPJ9FC/kOzrwbsu7paEzWDLAgAOLxXIv4JtshBBSRDgPO/X90Z1e1EESGA1ns3WKm633A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fwUA9sCr; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734237969; x=1734842769; i=quwenruo.btrfs@gmx.com;
	bh=8GXhEQTFssSoJFXAYgChIyWnS/GmxIjwoUtwUtZbKXU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fwUA9sCr3tAK1v6qoR4SnNFxDdCcjVcJ+0DU4rD7f/XQ70mg8LENPcrpJvqLlZyU
	 Is0184l2cV8B2QYy1bzgoKro5G914/ODr9vMYwzOwqruY5Dq9a6OsjYlbaJY7WW7p
	 YmYSP3BnGMm4WhLpfqH37fnAd2wb81TKSEJGbkFvWkOQJ8k7nFbevhGn8zPtAynZp
	 4omxM7236Zx2Pz/k0tJcqFbnAbb2rmRfsygZ/+bCsOjwl029tEOE+v9QBAFucZegA
	 YFT8IN2yuBfUkQGmVqbyMkapHJln+y/j8h8wEpCcc275z8oqgURQ6eUeN6G78uC2c
	 kmOqG84OpgeFyrPRSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvK4Z-1tecwT2l0L-011CBf; Sun, 15
 Dec 2024 05:46:09 +0100
Message-ID: <2809427a-41f5-4b59-9d03-2c2012e16f76@gmx.com>
Date: Sun, 15 Dec 2024 15:16:05 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dev extent physical offset [...] on devid 1 doesn't have
 corresponding chunk
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Ben Millwood <thebenmachine@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <CAJhrHS2b5fv7wmchdqkCy-jEWZ7hD_3YUgCO_oUCNaf9ossq6w@mail.gmail.com>
 <56d3885e-5651-4fd4-af6d-89897f8bd240@gmx.com>
 <CAJhrHS1xgfrp=Wpk18xCBGUEi2tYxaqCxrMQG5UEGSUbR4G-_w@mail.gmail.com>
 <d5372478-70f4-4a3c-bf9d-26366f955e5e@gmx.com>
Content-Language: en-US
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
In-Reply-To: <d5372478-70f4-4a3c-bf9d-26366f955e5e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PcxWDxdnnp0T7R4Zg+5bii5Wh8bYXfD+uquzjRnYhbxK70KECUp
 B3ng7T+uZRjn939p3iuSYwcbaIEajmNn64thrZ1mvgVPdwcCXKLIifqB38pRt7Oo+ZiWRKB
 mKj02ednUkHSywBPiGhrdJkY76/WlZVF7CaFNlHaOmZoYaev/5epaHhl+oy+mapy9nBxfOy
 lfCBc5RrmKfV9hc48J9DA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dQTz+hhqapg=;U/T3vSrbvZH1FapToTk1GSpLmMA
 Me8JZ0yasTpqletZl6Np0iVSQe0K8kjvhvaSQpEkyaP2JdHYHZc2kd8S4vtwRTj7E/U5OLYyg
 mR1nnVFs2XOFJbv59UXugE15OBCGvMWrWkx16tLI8Opw9KrRUWj8ZKFUlz2Zl6HaGTXFVOoK0
 Wh7Egel0aWl1JlEjjIf9w2TFUJQ5bLt515G3Ma5Lwg7praowMpiCcA9uv0H0MJ1hj3owyieme
 J4JrI/T+rILlJM56G0QtP8DORLGhTnDa5tG00AjOOrh4PbMk7VZAWu1iPNdRWhf8g2Ez+QMUN
 0g6tRgQw8H01k5V+KZ2/d2jDB7ClJHWMDqqy3PeQ9YfUMeLx+RsCIwFoTBIS1edEA9t9M2kS1
 t7aJjCIvcZQWNXMuKw5krT946FDAB2xLa/qGT9GnhOtwW+GDOU9BsX9lnThC2enj7gk8mJZv4
 xQbAG7wYpcv52/xHDVvka26d0RTUhbX5pO01gFDWHDsInMIVK7W1cMkR9K2vxUgDBG2Tg5MO1
 toDOQBt/pUkpWPHty1B527ht5hHM0ymFIkJx4eIn3ggX/eHYFKW5ZXjMjTw0v5sZ+t8AhO578
 wr7QAGzMnWWdtsux2KX5SLtm9o8jEk0F5dY8pYmGwJYdsGTSTY1mPZh6A6Vb3D/0gsQoejPfQ
 hJqC8lxgrRa5WsKrLjnRzm4Ws4kzFTYgQUEVI3rzFfiQeDMwuQrDw4CPWgZ078pIwAODg0sor
 adwN0BFiI7Ksphm+yONHRIab+eUHyeSfavniGxPC/+tCY/72fkljMnJ6ygyDiUWcUOFURKF4R
 ONYfdD1hqHwRrareGO7Jeifd0BSfukk96tLeWKjCOZtX/YNC3QnBHld1aq6StRe4JA/l2h+NT
 5yN+OMZEz0XCl+aMgmlubl0xVms8WqunTMqRdhrBt8yLEE8WpyiodaPydp9p1BjroXOjnvKZ4
 CSHwUEOGlQmUeKB7my+aKeMb8q95uofq+qRoVSxKqP1xfDDdv7EKj0Ac7Am2PKPUtdyPx/Fgv
 20Tl6uTW268vHLPzW7sQ0Y5/lAKDEaSdY5FpyuFfkmNdvwOC7MN9KLoZ5hM1KgDT4pjKwt93T
 aOrdnHqUwSkD7iT49OK41h395KSVApyiYQ8nxkdX02eFhAdwpHJQ84Yu65Xs8EHU0R6DS1ztA
 =



=E5=9C=A8 2024/12/15 07:30, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/12/15 04:09, Ben Millwood =E5=86=99=E9=81=93:
>> On Sat, 14 Dec 2024 at 02:51, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>> Both kernel and btrfs-progs should go with metadata COW with transacti=
on
>>> protection, so even something went wrong (power loss or Ctrl-C) we
>>> should only see the previous transaction, thus everything should be
>>> fine.
>>
>> Thanks for the reassurance, that is what I'd hoped would be true :)
>>
>>> =E5=9C=A8 2024/12/14 12:47, Ben Millwood =E5=86=99=E9=81=93:
>>>> While I'm waiting for the lowmem check to progress, are there any
>>>> other useful recovery / diagnosis steps I could try?
>>>
>>> If you do not want to waste too long time on btrfs check, please dump
>>> the device tree and chunk tree:
>>>
>>> # btrfs ins dump-tree -t chunk <device>
>>> # btrfs ins dump-tree -t dev <device>
>>>
>>> That's all the info we need to cross-check the result.
>>>
>>> Although `btrfs check --readonly --mode=3Dlowmem` would be the best, a=
s it
>>> will save me a lot of time to either manually verify the output or cra=
ft
>>> a script to do that.
>>
>> Well, the check is still going:
>>
>> root@vigilance:~# btrfs check --progress --mode lowmem /dev/
>> masterchef-vg/btrfs
>> Opening filesystem to check...
>> Checking filesystem on /dev/masterchef-vg/btrfs
>> UUID: a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
>> [1/7] checking root items=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0:46:43 elapsed,
>> 68928137 items checked)
>> [2/7] checking extents=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (14:31:49 elapsed,
>> 239591 items checked)
>>
>> I'll let it continue. In the meantime I'll e-mail you the trees you
>> asked for off-thread: they don't obviously look like they contain
>> private information, but I'd like to minimise the exposure anyway.
>> (Feel free to send them to other btrfs devs.)
>
> Those trees are completely anonymous, the only information that contains
> are:
>
> - How large your fs is
> - How many bytes and their ranges are allocated
> - The type of the allocated chunks
>
> So it should be very safe to share, unless you have some very
> confidential info hidden in the device size :)
>
> [...]
>>>
>>> That's all the info we need to cross-check the result.
>>>
>>> Although `btrfs check --readonly --mode=3Dlowmem` would be the best, a=
s it
>>> will save me a lot of time to either manually verify the output or cra=
ft
>>> a script to do that.
>>>
>>> My current assumption is a bitflip at runtime, but no proof yet.
>
> Unfortunately it doesn't look like this.
>
> I scanned the last several dev-extents and chunks, it turns out that
> it's very possible `btrfs clear-space-cache` is causing something wrong:
>
> - The offending dev-extent have chunk_tree_uuid set
>  =C2=A0 This is not the kernel behavior, but progs specific one.
>  =C2=A0 This means there are two chunks allocated during
>  =C2=A0 `btrfs-progs clear-space-cache`, but one is missing.
>
> - One of chunk allocated by btrfs-progs is totally fine
>  =C2=A0 And it's still in the chunk tree
>
> - The other (the offending one) points to a chunk that's beyond
>  =C2=A0 the last known chunk
>
> So I guess either:
>
> - The btrfs-progs has a bug in the chunk creation code
>  =C2=A0 So that a chunk and its dev-extent are not created in the same
>  =C2=A0 transaction, and Ctrl-C breaks it, causing an orphan dev-extent
>
> - The btrfs-progs has a bug in the chunk deletion code
>  =C2=A0 Similar but in the empty chunk cleanup code.
>
> Anyway I'll need to dig deeper to fix the bug.

Unfortunately I failed to find why the chunk is removed but free dev
extent is left.

Both kernel and progs are doing the proper chunk removal inside one
transaction to remove both the chunk item and dev-extent item, from the
very beginning.

The same is for the chunk allocation part.

So unless there is something totally wrong, I didn't see why progs or
kernel can cause such mismatch.

Do you still remember if there is any error message for the
clear-space-cache interruption and the next RW mount of it?

Thanks,
Qu
>
> Meanwhile I have created a branch for you to manually fix the bug:
> https://github.com/adam900710/btrfs-progs/tree/orphan_dev_extent_cleanup
>
> Since the lowmem is still running, you can prepare an environment to
> build btrfs-progs, so after the lowmem check finished, you can use that
> branch to delete the offending item by:
>
> # ./btrfs-corrupt-block -X <device>
>
> Thanks,
> Qu
>
>>>
>>> Thanks,
>>> Qu
>>>
>>>> smartctl appears
>>>> not to work with this disk, so I can't easily say whether the disk is
>>>> or is not healthy.
>>>>
>>>
>
>


