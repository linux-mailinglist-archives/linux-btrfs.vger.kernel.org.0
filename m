Return-Path: <linux-btrfs+bounces-9181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FB99B115C
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 23:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96DCB22C34
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441D1217448;
	Fri, 25 Oct 2024 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RGK1uiXD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9AF213122;
	Fri, 25 Oct 2024 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890260; cv=none; b=WUGToSDXBHyamWpND7E2+MBD6YThTfosVkQIVllMrJAxJgOghaCxi8oBT5HPme+f055MahuECo2s9si/DwsOXOQkDgVLGjFsmYdIrbmMgv63xgkwNV3frLGDjEVPUpZuy48XWrBKZ5242Z1gzel1cDmoYHZcUOgo3MBubtiJ0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890260; c=relaxed/simple;
	bh=l6rSnfSenp4a+KpZbszpbVj45R2+f83e0lEnS8U/Lpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxMl1iAzuygzEjU7F59vLcAiouBfIEm3xoXBoaZKuQj82ae7jx2h3MpZr1V5qmP1AVbMHTcF0fw0TM4iRRi0Lfw86XWBKEszCWtnUwcJ/BhmgwioDybSeX6Y0JDucDNGMM45MdO2cKlzDTqFcH0+LC0RM0Nyoz+zKL5AvLDw6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RGK1uiXD; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729890245; x=1730495045; i=quwenruo.btrfs@gmx.com;
	bh=/8VZ/hC6+2pUWzCMQNIABWAwuRdNxobmZZxyBKXusGo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RGK1uiXDsbeSD3n+YnZljPd5mYF2b1thVx2AasgjT4t/d/4lQsxcnwtqFd825Wov
	 vFg0JqPViF8u0bU+V1dVXMKISfFiPvQ+LsDkjfUCDe6WiKhbTIMlX3V/w03YXp9Tv
	 tlaBO6QzwxhoGvM4xydgPGpBXtfnrfJbjxpuhZ+IE+PFgyDoiH2DRWQPyPXvw1NIz
	 TuujOqbavMwf4sXUSXr/qs8pcL/k+rXcxfsPNq3fLkGoiDnRKztRrE2y/8/sDhNyg
	 NXkY1PB9jSC8dYIiT4BRxmIS9ooXUyhaWGsQzZXmwTTv/LQDGh2glJqQnNEYG6hk+
	 wyW2kvtnPYEYFbPw1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLzBj-1tMNpl22DZ-00Pl8Q; Fri, 25
 Oct 2024 23:04:04 +0200
Message-ID: <e5bc8c4e-771f-4cc7-91e7-291018b9468c@gmx.com>
Date: Sat, 26 Oct 2024 07:33:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add a sanity check for btrfs root
To: dsterba@suse.cz
Cc: Lizhi Xu <lizhi.xu@windriver.com>,
 syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com, clm@fb.com,
 dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6719c407.050a0220.10f4f4.01dc.GAE@google.com>
 <20241025045553.2012160-1-lizhi.xu@windriver.com>
 <03bcaafe-4a15-487a-af2b-b23970162bbb@gmx.com>
 <20241025180315.GI31418@twin.jikos.cz>
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
In-Reply-To: <20241025180315.GI31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5SKQGQGus0ODslVp11cF3lEdunMDzTif1PxUptWtrc1tvm3hqDz
 YunZj0Iscr/3v7q/f367yf4CbWxVmvlHQ+mcH4Ib/VbCj/mpgXuQ90xbzn/VMP2BB9Dv4tz
 zasDCSPVfaWkqqNrP9Tc0/+gc2yWwvIOQdktx9/N7Ei4aXd+JUG2BzVKCi/xuQH8ZMIQDgT
 2nWUwm+vEf1ILjUvM/NUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ygiZmHliaN8=;7I6evqp2kZUcKH7fpTFs3EmwWOh
 uB08Fz7/PEJtK3QvQcOjQpKziNAdBdFjk3DBLbApxkS4pkValT4NnPfEVv0Cdli//LUfXiibM
 oHs0DwcjMiMigIWj682hqkDVMc/DhwQpsna/CXFLgqpQLx3kv8VCC4QMv09NionofJ3x+bGWU
 ZmxqPs4AepjuPmlEDb8GHSvvMmtyrZcWPrUCLc8GogQTLiemJhdiQHsDn2W52I6IRcITeZzhk
 mJIRZUERfJ9WnZzFq+Wt9A/jredC/VotGxw6oUS80pujiosBAT3v7l/oTpIJDegRTUC/Mj5vE
 5/uyZMUaQq2f8QoH82ot04WILqyeZJ3cTd0TJp2Dfj+p/uYx6ljyV6K9VZK/6k3nHDK5sIUON
 4SWu8tWAoQhpVu9aiqu4f+bJy+Lys0/4WE7FbP929enRtElVmiwYJlo2sxhxnTbTErCnfjund
 /2p2blGO7Csf4fyiPYIgv1TRGnDg4QuQ6xOmjkVDLeapdDBBK3NPlhCpYcBmwYek1upWC0eXO
 T+wQAfIUGJFMnjmFkN5w6OEXG+WNA8Tos6/pcscdaaAatq6aAUbk8zKdz5VevGKD7ue+tNMKB
 nj/vw7mDh7u8vLqTOHyUGU9wsGbJUIvvT0aP7dmpiKjLCJE78Bx2uDb5P1vPSJjFXKlpTEBOO
 7EvdJRDMyWletuIo6AfDJ1EsMwzoIlSiiJREbQSbAvbHbQqIDUsrVdTBLaOA4cgAeRAnnjf1N
 KQ/l9wcsPRmpznzhBJN0Qtu6ew211kj1tazgjKcnIE6TRv6rCYjAw6TCuRnYqgWGHjn1MS2Ol
 ThEW+huQt+kXO+SGtCQNSYFEqxX6bluH9E1kPbWHfMNkU=



=E5=9C=A8 2024/10/26 04:33, David Sterba =E5=86=99=E9=81=93:
> On Fri, Oct 25, 2024 at 08:23:07PM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/10/25 15:25, Lizhi Xu =E5=86=99=E9=81=93:
>>> Syzbot report a null-ptr-deref in btrfs_search_slot.
>>> It use the input logical can't find the extent root in extent_from_log=
ical,
>>> and triger the null-ptr-deref in btrfs_search_slot.
>>> Add sanity check for btrfs root before using it in btrfs_search_slot.
>>
>> Although I'd prefer to explain a little more about why the NULL root
>> pointer can happen (caused by the rescue=3Dall mount option), which can
>> cause NULL root pointer for non-critical tree roots, like
>> uuid/csum/extent or even device trees.
>>
>> You don't need to bother sending an update.
>> I can add such info when pushing to the maintainer's tree.
>>
>>>
>>> Reported-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=3D3030e17bd57a73d39bd7
>>> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
>>> @@ -2023,6 +2023,10 @@ int btrfs_search_slot(struct btrfs_trans_handle=
 *trans, struct btrfs_root *root,
>>>    	int min_write_lock_level;
>>>    	int prev_cmp;
>>>
>>> +	if (!root)
>>> +		return -EINVAL;
>
> The function returns errors indirectly so it's not clear which could be
> ultimately returned. I did a quick search over the calls starting in
> btrfs_search_slot() and it seems that EINVAL is not used so we'd know if
> it ends up in some error report. The ones I found: EAGAIN, EIO, EUCLEAN,
> ENOMEM.
>

If you want, I can add extra (ratelimited though) error/warning message
for such cases.

Considering this is only possible for rescue=3Dall cases, extra error
messages should be fine.

Or do you prefer some more rare return values?

Thanks,
Qu

