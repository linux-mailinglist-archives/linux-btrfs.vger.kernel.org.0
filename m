Return-Path: <linux-btrfs+bounces-9157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E389AF8F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 06:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E501C217F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 04:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD09418CC01;
	Fri, 25 Oct 2024 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bd7AVjis"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B424317E;
	Fri, 25 Oct 2024 04:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729831483; cv=none; b=Ceex61Kd4X4Qa6LlnDAteaTttKVBIH96uRLD+AnWJ+lMlYoyKP/W4ty3R73FboJWAsZ1yIqtW7I+GjRksA8KyuNRLL+YpPAZAgzR6n2pqWUuk/822gvU4NFFg4SGhYSESDXWq1uKPUyhjns/nSs6nDqqzkI4UT+9vph8XGieTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729831483; c=relaxed/simple;
	bh=ko/QQNyXt0lgk4+WN3Wx4L9rR+9v8aIXAck0VFWMg7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpimI2SuICRCbDkiru351EAIT+nccGov+GwjswhoFEhl2aeFaQHnahyGSl0Bj1mYrLeGvFVmI6BdmzIS6I1amxrdFbcw5JxFLA9E8YLaqJUbdhvtcNrXQ6ePhUDqo1Zo1KPKLqDP1vS9AXuTz9sVD/D+jBICdmBJm7C3Ie5WQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bd7AVjis; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729831470; x=1730436270; i=quwenruo.btrfs@gmx.com;
	bh=8WzSSdJPv5UK/N4YQo603ZZ5rTj41qU95WdEYfZ/WFg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bd7AVjisBkqGkGP9n4BM5gAYbKjjrmZVUeKpm94MYFQV19zNh9zfrm5Uxspf3AEu
	 7iu1d95Q1eMuJBDwP4ogQKKSBlxqvlnQ5MlZjmXv0sv7T08PETVBOVTNQvJaEOgbd
	 JrHUx4GBghPrV9mLcZTJFnKaYHnFh7MZLawv1oKFvwX4FFaaGWhhJJPcU2Xvd0MMp
	 oAHkuAXbdPK5MY/cVNBO4o55jj23rPPIG2QncGC3rgtmQrReimoUncpfceMr2f4bO
	 tJUKIqdUtf7lppvwq06rIoRD/LFuRyPjAZB81PdEa97+r9A+/kTABpHX+nvoY1J0m
	 HE1/Wly4SyeK2d1Xgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7R1J-1tyDk83t9B-00zGFg; Fri, 25
 Oct 2024 06:44:30 +0200
Message-ID: <f5eb3203-62c1-4bdd-9607-122f13eacf70@gmx.com>
Date: Fri, 25 Oct 2024 15:14:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in
 bch2_reconstruct_alloc
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <7f0a7b2d-369c-42ae-9054-7436bc98f7c1@gmx.com>
 <20241025043848.1981317-1-lizhi.xu@windriver.com>
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
In-Reply-To: <20241025043848.1981317-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MiHqW0QHa6/nlA7CFHoFvWoAR7os9zPx6CB0iPB+tXZbotKwiim
 /jFwrBALO1L0gFXt/mM1Afjg8VVwQ4slG7KckF/r81KE+/RIbsPlVKGPHXB8iWdsvK8TnQz
 Vbimdnr/lRqfSzD5rCHZceCxZEPmf+96eCArDcL9gFR2oNPhtHGRkGzGFf3RepnK2wwhj1a
 /5nd/SiMAvokc8ac1C8yA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LkbnPFfbMiQ=;XHjX1fR7DGyKhCUhKrM4XXTmIxa
 JOiWEG7ng5CxIx+HzIPbWEqurtrj+jRdePFHq1VuZ0CFDAZ/MClF+PpFMOksKvpjcW/Y7d+I6
 nrhg4vV5PkiO4ReAfjToFPro0CO6fp+cLup74W9/LxD/8A5psdyLodfqUbf82tOPiTHsm871y
 GfWJFZxELanmKHxl/7vRGoBa55iefa9yk6Fq0WYu1/QDuVFdMmy0mR/zPFStID5zsOZJ/iY2n
 xLCuvihSgdDlfpc35ps+1ca2Wg92K0ZoVgNhcB7tsfDsjtl+a2Nlhd/WHtApXgT+rDuYHeNj0
 8trvrZkEndxeE+9yrfv4GBZODAQhMJ5GyPaChp4dy17+acWee/lNCgEjNsW+S7I0f7LCB5jQN
 wYIN05uGLHucvCBpb5X0i0wRfDzcgoVzs72TiVcQlkPrVV8mY/yKjh4PZ6GmubdTNnwGtvpdO
 zFr0N+li9ZmWYGlMNs13hX5xB5UcNnQXFl0kC9rh/D9Ap5KA6WAvvL/3HaIXgXbMVpTNHoBOo
 hm8d09sztvzNiQHY2Yrj1PaTGp1eXW0wpgyhFN010MZBFZQUSwn/vLlgatoeE9o4ZM96AgkXw
 T3KLSCwYIMEBWiTzhKY6uWD8M4CZlpXuuFhGRgp1/XQ4QinRU/P9t/Pz3AY+GngnoBnnAZzBq
 zDAXBn02uIo7hUwENxjJPkIBSyjgvN/fJUAtfhsY9wXOdV7/95Zh/NPHneRhUbirKddtndRWg
 6ijEYDO0gvxUySMFFQM9ol+W3QWJRH5ZYpQfU7oHLZYBqhPqqfE29G6fc0n/IR4J2Om8jhDNw
 uO3TRlu7ZjsxYjwfdnLpBRxw==



=E5=9C=A8 2024/10/25 15:08, Lizhi Xu =E5=86=99=E9=81=93:
> On Fri, 25 Oct 2024 14:49:48 +1030, Qu Wenruo wrote:
>>> use the input logical can't find the extent root, so add sanity check =
for
>>> extent root before search slot.
>>>
>>> #syz test
>>>
>>> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>>> index f8e1d5b2c512..87eaf5dd2d5d 100644
>>> --- a/fs/btrfs/backref.c
>>> +++ b/fs/btrfs/backref.c
>>> @@ -2213,6 +2213,9 @@ int extent_from_logical(struct btrfs_fs_info *fs=
_info, u64 logical,
>>>        key.objectid =3D logical;
>>>        key.offset =3D (u64)-1;
>>>
>>> +     if (!extent_root)
>>> +             return -ENOENT;
>>
>> Considering we have a lot of such btrfs_search_slot() without checking
>> if the csum/extent root is NULL, can we move the check into
>> btrfs_search_slot()?
> Yes, judging in btrfs_search_slot can fix the current issue while also
> avoiding similar problems.
>

Can't wait for your formal fix on this.

Thanks,
Qu

> #syz test
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 0cc919d15b14..9c05cab473f5 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2010,7 +2010,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *t=
rans, struct btrfs_root *root,
>   		      const struct btrfs_key *key, struct btrfs_path *p,
>   		      int ins_len, int cow)
>   {
> -	struct btrfs_fs_info *fs_info =3D root->fs_info;
> +	struct btrfs_fs_info *fs_info;
>   	struct extent_buffer *b;
>   	int slot;
>   	int ret;
> @@ -2023,6 +2023,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *=
trans, struct btrfs_root *root,
>   	int min_write_lock_level;
>   	int prev_cmp;
>
> +	if (!root)
> +		return -EINVAL;
> +
> +	fs_info =3D root->fs_info;
>   	might_sleep();
>
>   	lowest_level =3D p->lowest_level;


