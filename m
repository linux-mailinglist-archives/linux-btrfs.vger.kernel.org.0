Return-Path: <linux-btrfs+bounces-10437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F69F3D48
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 23:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9961188DAF6
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 22:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB9C1D618E;
	Mon, 16 Dec 2024 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="chRZGcC+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B8C61FDF;
	Mon, 16 Dec 2024 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734387236; cv=none; b=Mogp0e3u+sZRyuN92ZOZ6u72yxQT1uJnCFC/fHSIvdoslfbRwNO/WRTuD92oc8PphtNhXmbHCPL2mDadG5DNV27L+AqJUQyzaLOtGkTOCbT/++x8Bbe1H9IhW4c+wla//cNxrxL245W9G1mCkcdjIKxarovwoEWmBvDJZNSbmrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734387236; c=relaxed/simple;
	bh=U7Zs1tfL3qHJFtFwZD2Kn2V1Xh5kprvb/hFc84VKq8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGN73qVHLWNV/3qH8G2IAe720rZG5DqyS6St1ZJ8O3pZoz4Ywxa/E/7t4XfUY26P0lXDlogqA+/LlPjEO1O6q5J9f/lKCoktasaGENUay64cGfebKFnUXLDEQUEaqy6PEQ2FdSZ6ZfwdKPSCkHbmBMO3Ccc36gDCX68rrgLsfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=chRZGcC+; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734387212; x=1734992012; i=quwenruo.btrfs@gmx.com;
	bh=7XMFZuPrjR0+F819BQfm0M7POXBQwnDJgjZjfrXyANQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=chRZGcC+6g+1opEPjF0E4/t2hbuZZrU+7RpNPeBoWIaXzZ3UIWJevz7KhBRYLVks
	 5zHUspG4Yj49UIcokMUpoIKjj1Ewtm8eG7jSzSQlI568FM+3b8gK0rZPuVgGaKF89
	 TP8R+VqtPyd/4RmND+QXMBj6idOFsflZHuEGlCwmlaXlI1AH6YIBpLjIqB1ukBSox
	 yC4YYzkjBMbt5hqGE/kGk9ySH4fQBynk90819ur6BqRWbat5EeWob2w+a+PLDKY+W
	 8tDwIypJ2txlqU1eAL+n2tJBGC7ZSopejrvCRyRl12wUC/Z0VCihSX7/6itLRJy4W
	 fF2ejBiart4Dz1Ayiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbVu-1tMkK53LfK-00GEEv; Mon, 16
 Dec 2024 23:13:32 +0100
Message-ID: <ad36347a-14a5-41d4-82d5-f557a0a7f08c@gmx.com>
Date: Tue, 17 Dec 2024 08:43:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] rbtree: add rb_find_add_cached() to rbtree.h
To: Peter Zijlstra <peterz@infradead.org>,
 "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Cc: dsterba@suse.cz, oleg@redhat.com, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, lkp@intel.com
References: <cover.1733850317.git.beckerlee3@gmail.com>
 <4768e17a808c754748ac9264b5de9e8f00f22380.1733850317.git.beckerlee3@gmail.com>
 <20241213090613.GC21636@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20241213090613.GC21636@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3YaT21dXqZGqnExSnKsDufjhq4CDLCGpmePYCIhfqUlyCOqSkVw
 aRrXmLwJcflzoK+wDo8/b85nm19T3rPJ7h7GaGdOkf2crVGaTedHpB9k2QohTqGHIBnYjdB
 /vsr8b2OrzCRio/uba30GxWUD/Yim6SOBXjMl0dyDkMwQ0SAmXe5h3zCDiiK05A6xwvvQFX
 8fQv8jen0tzwF6flHQiRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XBA7H1iW58g=;FpLe6v391k65iwAbNYe/y0rpkpY
 Zga6MZvz7h9uBG8EddUy5ZmO7452iAani4jI58LaKE6HiPWoe2espXG/zSOb0E0/4C1ivkZPu
 NuToCAaFE0OnAV5p9OdXLWzMUBk/9qnLAwy/It/no7PEKoTKkuyi8Omme7xR/8rRTYuPKmkki
 9MzvdB1HqeBQqPVS9dmETg7dZo6EEu9EwNZz7BKJJzklrqUk1xoNQwuwOVHgcr1OeuwhFeY4b
 qnWIkPRDlphqJhsLQcLwVJiFNijMlmeRHvXl5/l4tP2palgBqnQOJc3jMd06ILr1n2rDaEI/c
 t06fyIPeETFlHkJs2ZL0vUZn9Q+4up96g6UGfrRs4WiBfV5BtD/mpmMYcZV6vDECBoQeJUX/C
 XRKtOvPzEVJCin9DE5sfXNtCzpKAtQBjtKwyAVWuV+ZBeJXP7mC1iuLF8dymXVTXrveK+/8n7
 468Po6/FngNpUVGzF9aFwgNCh5Rr1jeDvmc8bwRRLFi1+/LlmXPbk2psvBvaiQqRShx/gpFIN
 8FdkSg0ZCUIe0aZNN+heB2YbY3nsnRHoLIB2Ciu7lTC4VYuL9GcGPxAw4Mcz3yEk+m4y7wjYP
 u0IhjlQkt0Ddnw1PvdA6qQuq07enqvZbdL0qxaYs1ApxJxpJTpbGsAzETgsHBCWy+PsZN3iqB
 TC5U6stGDvjGVB41F43guaxRE0zd9cFlATxVVgrbXfEMwsoURSxTI6TAHNKezMredIdt4etlm
 2EOGP7Md/xmeKwYUtXrRT920VXzYFA8TYPDw1BP+frvhnNJdtbFjto8G6ogQiOqnaYogSs/L5
 IsNOtZmKtI+nRQ8na9eisA69tF7aKFQtFPC+T6ni9BlGVeKgfx7EkJ6/qtnc4EXfys2LtmVCR
 rIIYtS9T227uARNbCBLtVXWZmbsgI9xE+dIKrLINe2ooik8h2zeewvnxA4XeGLDx73A7swE4k
 x6YhXOZ6pQySGDX9sfQj6EN5nY6EkdBe1GFjqHd7KIp+w324WklIjBh+GFLVudjvsotWJniJl
 A1au5KkQtU5W/88PdZWU+6mTIcmFUt5zbNPAwRFs5wIMZrxMkvbKDtpqnPcEx4BiaCFXO3b+f
 QTTTtfPX0DZwSeY5GdouXaV/f6Iizf



=E5=9C=A8 2024/12/13 19:36, Peter Zijlstra =E5=86=99=E9=81=93:
> On Thu, Dec 12, 2024 at 10:46:18AM -0600, Roger L. Beckermeyer III wrote=
:
>> Adds rb_find_add_cached() as a helper function for use with
>> red-black trees. Used in btrfs to reduce boilerplate code.
>>
>> Suggested-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I guess it's fine to merge this change through btrfs tree?


Just curious about the existing cmp() and less() functions, as they only
accept the exist node as const.

I'm wondering if this is intentional to allow the less/cmp() functions
to modify the new node if needed.
As I normally assume such cmp()/less() should never touch any node nor
its entries.

Thanks,
Qu

>
>> ---
>>   include/linux/rbtree.h | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
>> index 7c173aa64e1e..0d4444c0cfb3 100644
>> --- a/include/linux/rbtree.h
>> +++ b/include/linux/rbtree.h
>> @@ -210,6 +210,43 @@ rb_add(struct rb_node *node, struct rb_root *tree,
>>   	rb_insert_color(node, tree);
>>   }
>>
>> +/**
>> + * rb_find_add_cached() - find equivalent @node in @tree, or add @node
>> + * @node: node to look-for / insert
>> + * @tree: tree to search / modify
>> + * @cmp: operator defining the node order
>> + *
>> + * Returns the rb_node matching @node, or NULL when no match is found =
and @node
>> + * is inserted.
>> + */
>> +static __always_inline struct rb_node *
>> +rb_find_add_cached(struct rb_node *node, struct rb_root_cached *tree,
>> +	    int (*cmp)(struct rb_node *, const struct rb_node *))
>> +{
>> +	bool leftmost =3D true;
>> +	struct rb_node **link =3D &tree->rb_root.rb_node;
>> +	struct rb_node *parent =3D NULL;
>> +	int c;
>> +
>> +	while (*link) {
>> +		parent =3D *link;
>> +		c =3D cmp(node, parent);
>> +
>> +		if (c < 0) {
>> +			link =3D &parent->rb_left;
>> +		} else if (c > 0) {
>> +			link =3D &parent->rb_right;
>> +			leftmost =3D false;
>> +		} else {
>> +			return parent;
>> +		}
>> +	}
>> +
>> +	rb_link_node(node, parent, link);
>> +	rb_insert_color_cached(node, tree, leftmost);
>> +	return NULL;
>> +}
>> +
>>   /**
>>    * rb_find_add() - find equivalent @node in @tree, or add @node
>>    * @node: node to look-for / insert
>> --
>> 2.45.2
>>
>


