Return-Path: <linux-btrfs+bounces-10338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EC09F0569
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 08:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3677282906
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 07:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C3B18FC84;
	Fri, 13 Dec 2024 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="r0cHOnhq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB91552FC;
	Fri, 13 Dec 2024 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734074536; cv=none; b=C+OrtxfMYsrrhDd8TGm0gFzZ5ZCpa1KcVNIQp4pVhIQMgkXfqmAId369EJ8h9XP483zAW6z9KAQ++6QUmQ5PLG2tqPlgw+B7pp7+TW7Z24WScypetiY5T7YWDzSn5yZpNs9/icoyyt00OLXW2lE13yS6fwFELnbxjmy42J8s27M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734074536; c=relaxed/simple;
	bh=mJ1OiMwN2pzdmUnGBHBHWTomtgZRAWVK2IZLrfQzgk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRWvZom5XrZNsqb7Fr8ZFmzsZ/TWgooFpFCJlnnHBVewDOabcW0skclv6pst+vAJ7mBJKGIAmvYHxsrb1vXCWUSlQQBDl42PohGivfGhoasddeiQQ5zotqn4yoKEmadsYFfRbAaFTVIzcSH0pWjXKtORS+Oqw05DSfkYVDH6aCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=r0cHOnhq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734074509; x=1734679309; i=quwenruo.btrfs@gmx.com;
	bh=Hh2nJXKwAbSNc1ASwtm/H6f9Y0e51clqp0kjErAQ9Y0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r0cHOnhqmAMWMO57h46MHSsbs+xnYrxIz/cHNhn8ePx5Z3tueRmRY8/uiZBS7/ux
	 0Q/3mSk/Cs7UGid9Bj/7xJV8kAZdE5A/b46SE1Ibh27GCs3Ln/dAO046lrifMElJE
	 d+c6teazsgOfo8YfB9AY7YvLw84r5AG4f7ok7YpkaoAp0fm21Uf9bAUOfURUqNmfT
	 ZSwWmDtp0bMRERMB2/U58Q8WggXvkbRoba6v3USNqHFMhbDIhRSDnUwvMXhblDf9z
	 TFMCb1kopgurYn6oNV6+dJsF+3OZ+hG3/WfJT4sqnoykSLTK8SKwoQKzfigLOeW/a
	 oPy0UWPlz7EGKvjtuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO6C-1txFZ70h4K-00q7Gb; Fri, 13
 Dec 2024 08:21:49 +0100
Message-ID: <f4d62504-140b-4fde-9b52-65cf3a0ddd0a@gmx.com>
Date: Fri, 13 Dec 2024 17:51:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] rbtree: add rb_find_add_cached() to rbtree.h
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>, dsterba@suse.cz,
 peterz@infradead.org, oleg@redhat.com, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org
Cc: josef@toxicpanda.com, linux-btrfs@vger.kernel.org, lkp@intel.com
References: <cover.1733850317.git.beckerlee3@gmail.com>
 <4768e17a808c754748ac9264b5de9e8f00f22380.1733850317.git.beckerlee3@gmail.com>
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
In-Reply-To: <4768e17a808c754748ac9264b5de9e8f00f22380.1733850317.git.beckerlee3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ttZsohH/6G1P1aG583141dt6XkSP4gzDXSAPJLI6xq5jZXwpsR9
 K6N+3FVgsQEA/x/YmM2oMbJAb9Y2JDHdf/Qu6cYukhePrPumAE01EcAPmY0xjGIViTXWubD
 IZIxjo4Yc8FlZzyYQzkX28gFG7pjbeZvuVwPHmMkWy+TTaY3pqdhzKavSPSDQ3Bp2qMNBL1
 Er/IB1r5KtDWPKqaguRnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ho966R3LCLg=;+2y20v8esE6GnCooNsoV7Qi6kUr
 Nj84rqZx5J9yx8wwalIxril9a6E6OOW2amoTRMqPAgiSTDdFu4iviGcIf3LPyaFAnNuoD7CEg
 vlcmudrb2NLSAQjsB1ujSqT740wOqAsxMcwDdzs2D6Oya+pJSryDmDjMDl7VeUwfiZTyPOZjj
 X5GW2RfefRYt7g23bmtcVE0PG4Tr5nqMbxc39QGwA9mIN/3EfxAI6ftr4pJ42/ZpqCEiyKHZo
 L12s5k7WaOzEnmp1AjYaNxeap+mdN4MDpj+5zpEmmh9xc6k2aJugzEUJ8HqIQ57X3uircA4VR
 8t47a/KuFuVc0zfKJAH6IYzqKQZZ92hqwZzAm5h40s7idgWIklDfCJ0/YJT6sTFimhjXJ5u8Y
 w/fi2Bo02Zo2iJqZ9LclbZSfAY+cEUcyAuRJBhAaedNgaBDtNga6KcyokEFkZG5CaPJcJ5+iD
 pGjuPnux7fTlyPqUWI2CBg/KzmAy79rNylADCZmJnF8jlPt/trmCxSRKDiZf9xoq2vpx/83kL
 8hC672ArgWaInBAnrUablcTqFtINwhhimCOcmyEoiGOE9Ms32lnLSYzPElhj0k9bs29AZfp5V
 BeMH9Sy0yVegT8i9C3ggQY8e2ZYigYIO3y0+56cwCjg8MH0OwwvLaaSc0urukFrbl2+Y+o2F2
 bcet02JoHIUKeMfh1T4L8x5+eQOa2pKIJL6pdJD/o5QmrN4hq9uJOTwis+WhvXSL92QTFPiyC
 i1gBJ/51HZrGvUq5uzpNBMamkiIYtXU4EsfDxCa/zC6tfVxce28+bZkX47YKnwstH1IOZTHFH
 /o0OcoviJaFRVKRxyCK1i3/kIvkKE9GJt9RAOHBWCPIE1wHzlR3SLQmedwDkyuPec9a5Qarr0
 CklPIGxdg8KvNmh5TUgBZtJpaWduM3WTzmN9MW42f5t2hsVXDNY8Pk0nMeF3h38PGVcH9dy1L
 hUPIfR9W8lTf7AQalaOQdD7uEH7FOkis9bh6AXZe/ppdBVEWtfQJJfzp3/tIdzHculxxNSQv4
 Vr+s2XnOlRCNK5kK2TWXmHDNvm3FBApSmJDB4WGqyRU5ag4PypXQjInL2LcoGPm65zpkhXr0v
 I0/teSJw2JqoWLRceQAyfE6V921Y0f



=E5=9C=A8 2024/12/13 03:16, Roger L. Beckermeyer III =E5=86=99=E9=81=93:
> Adds rb_find_add_cached() as a helper function for use with
> red-black trees. Used in btrfs to reduce boilerplate code.

I won't call it boilerplate code though, it's just to utilize the cached
rb tree feature as an optimization.

And since rbtree is a tree-wide infrastructure, you need to be more
persuasive to add a new interface.

Yes, btrfs is utilizing this cached rb tree, but since you're adding a
new tree-wide interface, it will be much better to find another
driver/subsystem that can benefit from the new interface.

>
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> ---
>   include/linux/rbtree.h | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>
> diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
> index 7c173aa64e1e..0d4444c0cfb3 100644
> --- a/include/linux/rbtree.h
> +++ b/include/linux/rbtree.h
> @@ -210,6 +210,43 @@ rb_add(struct rb_node *node, struct rb_root *tree,
>   	rb_insert_color(node, tree);
>   }
>
> +/**
> + * rb_find_add_cached() - find equivalent @node in @tree, or add @node
> + * @node: node to look-for / insert
> + * @tree: tree to search / modify
> + * @cmp: operator defining the node order
> + *
> + * Returns the rb_node matching @node, or NULL when no match is found a=
nd @node
> + * is inserted.
> + */
> +static __always_inline struct rb_node *
> +rb_find_add_cached(struct rb_node *node, struct rb_root_cached *tree,
> +	    int (*cmp)(struct rb_node *, const struct rb_node *))

This function is almost the same as rb_add_cached(), the only difference
is the extra handling for the cmp function returning 0.

So I'm wondering if it's possible to enhance rb_add_cached(), or even
refactor it so there can be a shared core function and rb_add_cached()
and rb_find_add_cached() can reuse the same function.

Thanks,
Qu

> +{
> +	bool leftmost =3D true;
> +	struct rb_node **link =3D &tree->rb_root.rb_node;
> +	struct rb_node *parent =3D NULL;
> +	int c;
> +
> +	while (*link) {
> +		parent =3D *link;
> +		c =3D cmp(node, parent);
> +
> +		if (c < 0) {
> +			link =3D &parent->rb_left;
> +		} else if (c > 0) {
> +			link =3D &parent->rb_right;
> +			leftmost =3D false;
> +		} else {
> +			return parent;
> +		}
> +	}
> +
> +	rb_link_node(node, parent, link);
> +	rb_insert_color_cached(node, tree, leftmost);
> +	return NULL;
> +}
> +
>   /**
>    * rb_find_add() - find equivalent @node in @tree, or add @node
>    * @node: node to look-for / insert


