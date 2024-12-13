Return-Path: <linux-btrfs+bounces-10335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B80F9F04B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 07:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4976216A210
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 06:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F98018DF7C;
	Fri, 13 Dec 2024 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IyMMHl43"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292F518C93C
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734070767; cv=none; b=EMfolHYCPLwot6I43MohrwFAjJrV+4nHTZkcQF9WQMF8J7+cAXoIqZXOyQ6tZJCMum3CCAFbaUuLTdP5XbdjOXKkiQ0RjFkhTaO1xW/IEK7XKKKkshz77URumIHVV8TgeJVJS0rOGenPfR5dY/4W8XcDuePwB4elZ4Foo97s32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734070767; c=relaxed/simple;
	bh=QAzjzBxv1DrzjW312TmZy8P+piFcZfWhKSZcZ8+9Fbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZB/yXzRAfKn+oVZiVbeqzlK/jPbTjq31B2hV3oU0gfeVu2HIJ+AYCUnU3DnkjfeLpyzet0kFFP6MwuNfl0ZvV91xfGIS2eaddjv1tu2B+7dBWntMHBlhadFw4CFoF1RsuNY21HoLhZqb5uQLp5Hc7/flxkSLO5rp8Ibpljd4Q8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IyMMHl43; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38632b8ae71so979406f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 22:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734070763; x=1734675563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=joKCasEhorg/qCb56lGLiD8+LE5RKPLbSMB323P6COE=;
        b=IyMMHl43I0fcwLlAE4/dd7eHyYo+XK5Q91x59d3QRPI83//TK0lzOmCDKXQANRziUD
         HaZyeUg7QGbsAzqlvr742tTox3lqicyNKZRIv1FORaESfqLi8XZFYT8A5Eo8u6dQwRZ4
         91OjC1ClegSqKOGN0SQ5OQbAGeDd+gyuf7s1BRDUJIK250HfMvKPR7Pvsu3M2VdsnVpC
         DRbx36oCE8hJOTwXViY1aTVmrawYSvjeYCJPr5SLn2jbj5LS1Sw2ro++/4EPi7VNibl1
         YkgR49LM2dXq1ixLAF7uQHx+LEFIR5KRHlPoFCPWjvRvngxklaoIjwHRb0o8uGvg59Ql
         tofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734070763; x=1734675563;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joKCasEhorg/qCb56lGLiD8+LE5RKPLbSMB323P6COE=;
        b=ei3m5pGIT1uJ6veOntyy3S5e5X2zD9ZqwoNFYczu7OlGPHtMFKi/0CLofqBMqOCxcx
         MzE86LTBHXGIuPvfSjLF2/Heylf+oYD/9z+Cb/r+RASQ6bxTsuyDWqX2aTDnkUSPFG1n
         AekYP7tbt4Bh2WgrskcCPuoAduxSEIoyHcPYoFTbUDB0O2MLgwDmSbkyuCHlKRjuyVJd
         sueEF+KhUbhoHxmB1JDFrPIh9ET1IYY+1UXA8Ew8yI50u/uwrqISKEgAvldC2JHgZke1
         iN6xZ/gJV4MhZZxQ9M35EslHUFNzkoijTZKjdDkXNuKMrtG0Xpu5zYeboUFFWUQ4nQZz
         N5SA==
X-Gm-Message-State: AOJu0YyCI6bGh6Z7cJfEl/wpxI2vSdiU68M5r7KTpGL851dLNaZuDng3
	oox7C060QQMc5RaBmBmU7xsBimM2IEesMF2het64/oXLKVxS1z9tNs9Dih2FGREYqcxyxnaWhpQ
	r
X-Gm-Gg: ASbGncuoXP2L6qWcfcyjVNUE5cshBHLGKhD++BL+TDDQQegWsdjKP7z5HObz25xugPQ
	PWy2WVRONxTdjOb7yis7NmobYK1eJamVz1t9cfeEFtmWG4toSaXOpTh/kC5FX+qXLUF7syOuelG
	wUYXIz7cB1XAzGvgu6j0AdAdr+s9oLMmvwOgnZgsbTvBXm/3FaL8clmiGEbOx0rlspU3CdY6tIX
	JsIg8OGuXL5RCiaGaDeBgZzkAcpe0EQ0G2zsapGOOJX52yt4AHF55hQ6G6uuyyqNKIViVDf2ZhR
	79A45yfc
X-Google-Smtp-Source: AGHT+IHcTzy5WsNiwfHM1AejwZU2hw5SYM3hEAL4aUeRwXLRwZnssM7CRjB+BBxrb9yhmZOzUvzdug==
X-Received: by 2002:a05:6000:784:b0:385:faaa:9d1d with SMTP id ffacd0b85a97d-38880adb18cmr715739f8f.35.1734070763141;
        Thu, 12 Dec 2024 22:19:23 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162bd745b4sm100684235ad.73.2024.12.12.22.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 22:19:22 -0800 (PST)
Message-ID: <6c633f79-9808-4537-be9f-fc201c032a6b@suse.com>
Date: Fri, 13 Dec 2024 16:49:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] btrfs: update tree_insert() to use rb helpers
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1734033142.git.beckerlee3@gmail.com>
 <c80d0f92b73983e7454291154b3fb6ae555f6053.1734033142.git.beckerlee3@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <c80d0f92b73983e7454291154b3fb6ae555f6053.1734033142.git.beckerlee3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/13 06:59, Roger L. Beckermeyer III 写道:
> update tree_insert() to use rb_find_add_cached().
> add cmp_refs_node in rb_find_add_cached() to compare.
> 
> note: I think some of comparison functions could be further refined.
> 
> V2: incorporated changes from Filipe Manana

Firstly changelog should not be part of the commit message. It should be 
after the "---" line so that git-am will drop it when applying.

Secondly if you're updating a series of patches, please resend the whole 
series and put the change log into the cover letter to explain all the 
changes.
Updating one patch of a series is only going to make it much harder to 
follow/apply.

And put a version number for the whole series. It can be done by 
git-formatpatch with `--subject="PATCH v2"` option.

Lastly, please do not split your patches and send differently, the last 
send attempt split the first and the remaining patches, just do not do that.
Always send the whole series with "git send-email *.patch", that will 
easily mess up the Message-Id (which is already messed up as you put two 
message ids for your new series, meanwhile you should use a new 
message-id for each updated series)

If you want separate Cc, you can put it into the commit message and 
git-sendemail will pick it up.

Thanks,
Qu

> 
> Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> ---
>   fs/btrfs/delayed-ref.c | 39 ++++++++++++++++-----------------------
>   1 file changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 30f7079fa28e..3cd122c899cc 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -317,34 +317,27 @@ static int comp_refs(struct btrfs_delayed_ref_node *ref1,
>   	return 0;
>   }
>   
> +static int cmp_refs_node(struct rb_node *node, const struct rb_node *node2)
> +{
> +	struct btrfs_delayed_ref_node *ref1;
> +	const struct btrfs_delayed_ref_node *ref2;
> +	bool check_seq = true;
> +
> +	ref1 = rb_entry(node, struct btrfs_delayed_ref_node, ref_node);
> +	ref2 = rb_entry(node2, struct btrfs_delayed_ref_node, ref_node);
> +
> +	return comp_refs(ref1, ref2, check_seq);
> +}
> +
>   static struct btrfs_delayed_ref_node* tree_insert(struct rb_root_cached *root,
>   		struct btrfs_delayed_ref_node *ins)
>   {
> -	struct rb_node **p = &root->rb_root.rb_node;
>   	struct rb_node *node = &ins->ref_node;
> -	struct rb_node *parent_node = NULL;
> -	struct btrfs_delayed_ref_node *entry;
> -	bool leftmost = true;
> -
> -	while (*p) {
> -		int comp;
> -
> -		parent_node = *p;
> -		entry = rb_entry(parent_node, struct btrfs_delayed_ref_node,
> -				 ref_node);
> -		comp = comp_refs(ins, entry, true);
> -		if (comp < 0) {
> -			p = &(*p)->rb_left;
> -		} else if (comp > 0) {
> -			p = &(*p)->rb_right;
> -			leftmost = false;
> -		} else {
> -			return entry;
> -		}
> -	}
> +	struct rb_node *exist;
>   
> -	rb_link_node(node, parent_node, p);
> -	rb_insert_color_cached(node, root, leftmost);
> +	exist = rb_find_add_cached(node, root, cmp_refs_node);
> +	if (exist != NULL)
> +		return rb_entry(exist, struct btrfs_delayed_ref_node, ref_node);
>   	return NULL;
>   }
>   


