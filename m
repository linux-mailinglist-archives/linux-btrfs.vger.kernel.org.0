Return-Path: <linux-btrfs+bounces-16017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3728FB225B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 13:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 923E04E0EDF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10992E265A;
	Tue, 12 Aug 2025 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sotapeli.fi header.i=@sotapeli.fi header.b="EV638B1s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from se.sotapeli.fi (se.sotapeli.fi [206.168.212.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF82D5C64
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.168.212.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997597; cv=none; b=D8jhX6UPrfZrwO1rI/mEXFqWJv0TAhZLDTxLA2Vldeko/NNeVJ2z1rlp8I0Av84bHsfDMrJ5OCw2VsFIFa3+if9wgwtwtyOBZ/oiQEeYe+kRSlh0nT/xJs+sIjK5lk0ie8uZLcsgNtnzWCQab5SayikvkxWaWL0HfON/qDFY/Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997597; c=relaxed/simple;
	bh=uY7m/yBxu0A+l2cqJ7Y3oZhf1pPlkqlMnpGju7tUZ9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LfraNqjtnJXnTy0ojJUn50Lf5lanX9tuI+xsWS+cNN8jTv2XEVHeUa6T9n0xSZ/fm3I3GvvCChluY7fNbZ9kky9yNOQbi84r13X5HVmQdRt1r0hlIUykg68qrTZcaff4MseTeS7yp9rSDipxM180bnliSWkQ6vUy1SPV08OjLIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sotapeli.fi; spf=pass smtp.mailfrom=sotapeli.fi; dkim=pass (2048-bit key) header.d=sotapeli.fi header.i=@sotapeli.fi header.b=EV638B1s; arc=none smtp.client-ip=206.168.212.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sotapeli.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sotapeli.fi
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A340181AA00;
	Tue, 12 Aug 2025 13:19:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sotapeli.fi; s=dkim;
	t=1754997591; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=Xeo24Y9Tae/EhllUFvmI3Ko1W0nvniU5aIaeOQ+g/pE=;
	b=EV638B1sRRGCc9KjzuzuThRMIWOPVYKiVL5ooSbkxIafTu8aLGbrjL0WSn2vLsvXeVCfVG
	X0gEhe4O2hsSQ+qvqzs6Yoy3jZgx2vp1+2KpGRIWt4TH28Hdljy1bo7SVfylzLWcaIJY8I
	NAib7s9jwo2c5301m0BoU86c9ZtHFqDIIPodMAFHGcGD8Vuo6HtfwwYk0uFemb7q8jNE0z
	anNCbL/gB/rh85HLr2wA4Z61UXCjImCHDmYy9jHgcKbmcFZTi5aI7i/KuXpIfQyL3aLaJq
	8jjnEr0FvpyaLHIP0lNPQGnVGTLBJ8sXsKBz71608Q3RLBlrM/ud1VVUX62L9w==
Message-ID: <fa41cbe0-e419-4cc8-88b4-09a2b0a49ddc@sotapeli.fi>
Date: Tue, 12 Aug 2025 14:19:50 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS RAID 5 array ran out of space, switched to R/O mode with
 errors
To: "johnh1214@gmail.com" <johnh1214@gmail.com>,
 DanglingPointer <danglingpointerexception@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <99bc3ec8-8251-4530-ab4c-7b427883853e@gmail.com>
 <eeec436c-fa53-4644-aec6-5e4381da34ab@gmail.com>
 <89786d48-cdca-4e53-8646-09860a6f5482@gmail.com>
Content-Language: en-US
From: Jani Partanen <jiipee@sotapeli.fi>
Autocrypt: addr=jiipee@sotapeli.fi; keydata=
 xsFNBGT+fKABEADD4vjnZhAQu2eexHX8BoH4X6bWSNRZT0TbOkzuRBlln8T5BixMcItkF+x4
 wBNQrotQGVetb5CIC9MpnDve5NaevpzBPjkTYLK7MLnAt9ar808YCvmPiwY3Wl1zKKIF4cA1
 iSpvx/ywVbrzLHAR2r0VhNpK+62QjVwB9nZtJDmOmmMHx/jB4TepL0GYTiXL0Fb43ZSp1KIS
 dj3d8e7hBoPzo/Y8vyEP99H02srd0HJGna0b1zwwofWri5y6Xlf5urR4np7Eg5x+MTcO9Lvk
 xQGEhHngLsp3EtzYF8sg/uTeyl+fDOlF2X4IA0uNgXGcCTEJK6WwEEuaUHFnenVAr6kO0Ekz
 sGEMmwNUPRW9b6LMhuvvVdcSIMHslPXgH8IrTuI/mvs2LirqLP8q1nbj3ElSHRnCb1IlrWmk
 6zAvAQkL5VcF9zZ188YS9fyR9k3wZw74Og3aMdgfdNvWFbphxD8crROUkR1geLFrtTqfi/I+
 fLUp7CSmU4tJcuvMUB8CKQKCvi1nX29fKoj5blX3+rQ76kPR4mM8VFoTMg9ea0u+PDverbG3
 /a2IQmnuoWLbeQju3+n8wuQOnDcPqDd6pWp3VHnO6kWuS0R9DYGilo/s1EZJY30uukRdS8WX
 gvr+glNWuXySOMrNRv1J3aSupfF8foSKagSEv3u5FkJytBNQPQARAQABzSJKYW5pIFBhcnRh
 bmVuIDxqaWlwZWVAc290YXBlbGkuZmk+wsGNBBMBCAA3FiEEZBllEaGa181p3ndbYtKyRR32
 Z1MFAmT+fKEFCQWjmoACGwMECwkIBwUVCAkKCwUWAgMBAAAKCRBi0rJFHfZnU24jEACwwdJ1
 FglMM5wZRK3KVSGaHhhdUWO57h9dWy0LXJ23jF0ZUBOkGF/GhkpCB4q2/uI/7TIxJrYTaykz
 6NI4wln4970/BW6vGEbPUmAKVrn6UdtR1JEGHN1qq8QIX4epCA4OaBqPdTIH3ALDen4xQKRh
 RDTO4JvImhKXyLUJLD4936B0UOMq+VK/rZ/D8Bw42MvYrY93nFWhc6H2ucOfIJfji1bJBje+
 F8Jls0Y9DjmkJ+d0oO//Y6Pc9/OdexeUDyvSPnuYZOgFEhHRlRAGc89MKiufDaoNkCudXpOD
 FZnfRfD3KZYdu/Ahzda6X79Q2VCgbNqa+oI3IDcCYDZjOdfkY1ooVnS/Rb+zkECP46Pe7BKA
 XMN1cwnpyCq7oX3dQLdy/vp+kx0Weto2B+8KWQv/Dak12J4knlj9/z6kvMgBlO3lsNCpjK37
 FV71qkSWrSjmw0PDHPd3C1k2TbkM3CP3vuWEdBEwRV087voaTvh4kqXpGxZF+TznzU8m9Jfc
 uFD3LrVn2xw5mqmXwOj483KL8VZOcpIUcVCyLs/9Ki1Wmd/KVOnQyk0yH2ekMuhvbsqWXp59
 Y0lGjjEw6k975v1/prTvLKYPDHaDk5JbAD7ZrmGu9ExJy7QOtrioFRqK36NmHSu83ZvWf3LN
 MJBC+NU6EP+DU3T35qy+0FyeHqoUzs7BTQRk/nyhARAA9rmpAGPiLM6YwSZ4Tt3WA35TtrDo
 QlUqkxbs1EoBOA+KC/uyj3P1XgZ+9JwLDcI6Qfk7mQJvCAdAM6nxQvVCCVkSm11FwPOl88zJ
 HpfwCZ8L86q3eRpNdFMyRBBe2fWIAwoxRF9W6F7Ajnft1831z07HVzEWVnfv+/DFfV9w5cJW
 Lq1API3JM6S0l3st6fo5RgqbV3uRvbo8FygDjQ3Fw7dGRn1Z3RoaeDVb4B3vcc7bPdFugOBd
 XA0GRqJprynCn3yclUf0/QXG2IyYO96LFBMaiY4yU0lBsVFqjNeq97l59c/Vrzv7AlpYw4vH
 +RYumgk2Nmg4rGxl95ei90WpjGuSfW504PDCe0W5I37EpmakBB45EbhgtoGk4qI5pEdNVC9U
 XPKAggwLj4iWRNVcxqMe381DaMhREI4V8q48zulEVT/KWI0v6WKCcZx3mkgtFUYciGlMU2gj
 99dpBQcu5I8pfDJoke6+Q/c6QJyD2gDu/DW6haT8iBDx1eTRmisCcnwnVlAsuDM2XKxTssNk
 ur/y++2YQSB0BzhJccUuW/jQOmZHYQ4CAS7sFi5FjHhKYTeatlotkwOlj+hsXg23U47vZqVQ
 jgyl82kge+iFk2jid9cwWX5qVqrl7f4iCQ5zNHQlTJ6kL74ZbhNOvmP5BGESBPxVsWgGVbr9
 G2YRigsAEQEAAcLBfAQYAQgAJhYhBGQZZRGhmtfNad53W2LSskUd9mdTBQJk/nyiBQkFo5qA
 AhsMAAoJEGLSskUd9mdT0ZwQAL1Uvdk9Q1f83mG+W1C3EQTQ6Sj3aDbzXCPsqhJWLP81Amkk
 G2Yr3cGORZGWl+5eLkeqIPAnJm005Q6L4+0sWsOHg2l/hC809+tzXM9QQzSxlUMhUCq/33UD
 xLbK6/iSERgOCBbE+bxeHiuUKgRECYEhlru7OvKetgaY2ejvIqJ45nlGQ51fU6FO7q6zrVED
 gJ6dANxl+0Dqgg84ELn0cjO7fLwnFM2OyEal0e5ESCLEE3Ruqy/whsft7f0hjcb6C1SHqYZS
 MCUPHQ0tZxLg74XfkwxxHkn2+JKM7y25GFcpqnZbxQXlx6eJqm/T4R4RBpt9Qj8WPlQsxPix
 kmQSP1fagxZxxu/J91cnmSiCnSbRCqnZ/6UuU1pMLkuYW8RBdnzo+BpGwtnTcSDIUfR37ydQ
 //cjOeSE4XNvyOXFn0ePOZTxuXUYbPya5nnv/6uRgeURtt7St/ljx/5ieqzSYnXuMDdeyHpu
 A5SEgX7tlnGaWHcH1go9Z/ElSwnyQsRKUMEitxo/q7R8InF8Rf3xLarK27WUGxX4i2uU0ilK
 TavzdWRG0zG2TEKvmX5Ks118pVC/F/WWBQ8Z1ygW4Qek/zgTKfr3d3nR52s91PV8qUyatmZ8
 Li0pNGD1d+9nlNIj2m1iIpBSQ5Bj+XBW+MQRMWKUlpAK4quC32wV95k2ZOrX
In-Reply-To: <89786d48-cdca-4e53-8646-09860a6f5482@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 10/08/2025 23.16, johnh1214@gmail.com wrote:
> The best advice so far, was to copy all the data as is before 
> performing a recovery. After that, if you can duplicate each drive 
> exactly, then you can attempt multiple recovery's, however the array 
> is too big for that much effort, so I have only one shot at it. The 
> idea is to try mounting in "recovery" mode, if it tries to auto 
> repair, cancel it, then add extra temporary storage space, because it 
> was low on data. A balance operation is needed to free up space, but 
> that seems dangerous given there's corruption, however a scrub may 
> fail if there's not enough space. The temp storage should be large 
> enough, very reliable (eg not a plugged in USB), and should have two 
> partitions for duplicating the metadata.


Hey, with overlayfs you can have as many shots as you like in theory. In 
short with overlayfs you can "freeze" your drives and all changes is 
written to temp files so you can start over and over.

But I am not sure if this can be done with btrfs multi volume. Normally 
you just give one device or UUID at mount time.. Maybe with device= 
mount option it is possible to force mount to use all overlay devices, 
not real devices. But someone who knows this better need to answer that 
or some test to be made with dummy drives.

Anyway overlayfs is worth to check out. It helped me to make sure that 
my mdadm raid-5 was running fine when something happened half the drives 
had different metadata update timestamp so it was not possible to 
assembly array. With overlayfs I was able to verify that force assembly 
works and array was fine.


https://archive.kernel.org/oldwiki/raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAID.html#Making_the_harddisks_read-only_using_an_overlay_file


There is some usage example for mdadm.

But like I said before I am not sure if this is possible with btrfs 
multi volume.


