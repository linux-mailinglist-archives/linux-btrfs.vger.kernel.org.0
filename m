Return-Path: <linux-btrfs+bounces-21585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHYRLGbsimlEOwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21585-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 09:29:26 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC1F118419
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 09:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ADF73045C24
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767B433D4FB;
	Tue, 10 Feb 2026 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BLN6tB+I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11622E282B
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770712076; cv=none; b=CbKXrkM9TLq5UzSUnPVXZa7y+jaZnbJPC8iw03bh09hoUBMJDl0ltRDe/y2p+v0ihYVSFfLzrJgcQmv83j3kPXN0eA+EEQ3oE3/u6iErRHdVFViiRkWlFYB0R1fqKB+1DMsEDfZiqU4BbVz8cFgtp0wv6KuM2feCAV4jdtaNLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770712076; c=relaxed/simple;
	bh=tDObQRkrRNegaUnC5Zh2i/QLG1UPkEFhmBTrWsBQ7As=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pnmrbIpskbvvZ6EYUbwXHG3/YqqJ+QKXYW8sXli4/rWYIwIfDz9CjzUaz1T/aD775lvZ5Aw0AaReXEW8Zce+fz9FyXg7SsfWI9d3JAlVo+xLSw4rvYais3ez7jwEmvv9bcosgF4reW4bZdGmK6RnQS4X0gT6FDOe/0pLAbiUAQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BLN6tB+I; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483337aa225so11164985e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 00:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770712072; x=1771316872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NelcbkkvY5qyrx4mFB8zHbFVfKgWpC78/Ntm3uPvzi0=;
        b=BLN6tB+IJ/X9Z1IFbcOOu1m0pqQdOkunXzg05nQdWWh+/vqZ/IqxT0N9hLYwLdbzYe
         i+wqSOusod/Fs+sqIIS1HeParhaepexpcb3/nIJQZXmwkKVAqL6AoKhyHwAwhuJg6ap5
         xP1xMhNYwFHjuU1f9XCdyxvzGUMk0cyZg8ISuaTXpz2WGXU6bJR7woqWJiXhXnnlVoBz
         VPtw+ievt8teslt46qE9Dx9Mg4c2Fwl4wYKU0a6L0VSmUH/+ZUpRGDMNKtcE9R2OS7Dq
         ik+u8P+WROdt6CWuckICPD5EieDnGG6SQljGyyBX3/VfnxyONpgHK1sMdVc9g7/ltk7F
         4flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770712072; x=1771316872;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NelcbkkvY5qyrx4mFB8zHbFVfKgWpC78/Ntm3uPvzi0=;
        b=SnvHGNI9kL+7ttgVlSOTrAvBxnzaBSLc6dk9/KisQj3HzQY1Ym5IT4k0ayQ1hkxP/x
         ImozyegogTFsCn/RFkCOrES/i2D7nNK1NEMxgiOwk7jgxY2aOw0sxZNByy01P+s6MkWd
         LpcaHuHfDt5cX8ZVw+tHqTAYqGZbrXjdqUk6U0L/TnqP/X0HdJD7rPkSux8rKLqibwTE
         UPeeLrOX8HzshaXJnfkm3cwkYgYEEr/P8QFjYtD2BGFqDzNdtiC/YtjCDaFt2PE9lvwu
         aCGQWuxqdOicNLC2Z+w4qFT8NRSNjw6hyOMkdnMWki0rjNK8nKru3ExjDopdNUYQRheK
         Z7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUDZTY7p4w+meIcwCpLQkc/V8a+4NNOi6UZmpIpI7CwNWJ67jLAfKWkWrQeYpoawItWx5nEnsTiiv9+3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaRSvudi/HWuRPd78bFgjXLsI8jDBhSBhm1XAxG82DAfy9ohWy
	HfV7I/A7FhcUZBBBPKWd64w5oRl5XXFfhfR8rMWLrIGZ+lWIh9hTtO/K3Vvy508Bgd0=
X-Gm-Gg: AZuq6aKur8QCgYGyEI7pRRFR7fNBdP8o4ljJdg80SoPWaZPU+9BkLzsEWeb6mU+7Shc
	BzJgbbQo083guYxr7Vr324Kwqb4f1JrqWJDKZWu+vCEPlfSmdBlECSPLK4Lv8m+xNUrCo0uxWrj
	TdCF77Bv5ViiyhnLerq8aGf7oJiz9hKQAN1yoJvhyxnb3rU8XJ/wmJSilmq4d9VWavHJzXvfrkV
	VPkpqNefNe4mItzGUO68EtMevIBh1i6JZ7bDEKKf8a9VvEaLI1PoBvKknL53FJneQNRaG53sWFu
	lOwrIIu4ecaMrmRDjOe/y2hoXQQxiK2RsjiFNYfaNAV3gTbKwhX3JIKvpBgHDAxZme1idDdqZls
	E3uTLYthFqN6a+77v/cS3QsJx3obo0cffrdO42yg/LNtu0IkrdHquJJXfcOENl1KyrxAsaxWk4V
	nRiVmbcLEpqKG3YYyEcvUZbEXKoqq0H3VTniEtGETy3Gu8/a4sAHQ=
X-Received: by 2002:a05:600c:a08c:b0:482:e5d4:b7ca with SMTP id 5b1f17b1804b1-483201da29fmr199974765e9.8.1770712072005;
        Tue, 10 Feb 2026 00:27:52 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418a8139sm12192765b3a.46.2026.02.10.00.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 00:27:51 -0800 (PST)
Message-ID: <5c601bd4-5cf5-452e-95da-a7ca389b3101@suse.com>
Date: Tue, 10 Feb 2026 18:57:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add remap tree definitions for print-tree
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org
References: <20260209181043.27364-1-mark@harmstone.com>
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
In-Reply-To: <20260209181043.27364-1-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21585-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,harmstone.com:email,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 5DC1F118419
X-Rspamd-Action: no action



在 2026/2/10 04:40, Mark Harmstone 写道:
> Add the definitions for the remap tree to print-tree.c, so that we get
> more useful information if a tree is dumped to dmesg.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/print-tree.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index f189bf09ce6a..b7dfe877cf8d 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -38,6 +38,7 @@ static const struct root_name_map root_map[] = {
>   	{ BTRFS_BLOCK_GROUP_TREE_OBJECTID,	"BLOCK_GROUP_TREE"	},
>   	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
>   	{ BTRFS_RAID_STRIPE_TREE_OBJECTID,	"RAID_STRIPE_TREE"	},
> +	{ BTRFS_REMAP_TREE_OBJECTID,		"REMAP_TREE"		},
>   };
>   
>   const char *btrfs_root_name(const struct btrfs_key *key, char *buf)
> @@ -415,6 +416,9 @@ static void key_type_string(const struct btrfs_key *key, char *buf, int buf_size
>   		[BTRFS_UUID_KEY_SUBVOL]			= "UUID_KEY_SUBVOL",
>   		[BTRFS_UUID_KEY_RECEIVED_SUBVOL]	= "UUID_KEY_RECEIVED_SUBVOL",
>   		[BTRFS_RAID_STRIPE_KEY]			= "RAID_STRIPE",
> +		[BTRFS_IDENTITY_REMAP_KEY]		= "IDENTITY_REMAP",
> +		[BTRFS_REMAP_KEY]			= "REMAP",
> +		[BTRFS_REMAP_BACKREF_KEY]		= "REMAP_BACKREF",
>   	};
>   
>   	if (key->type == 0 && key->objectid == BTRFS_FREE_SPACE_OBJECTID)
> @@ -435,6 +439,7 @@ void btrfs_print_leaf(const struct extent_buffer *l)
>   	struct btrfs_extent_data_ref *dref;
>   	struct btrfs_shared_data_ref *sref;
>   	struct btrfs_dev_extent *dev_extent;
> +	struct btrfs_remap_item *remap;
>   	struct btrfs_key key;
>   
>   	if (!l)
> @@ -569,6 +574,11 @@ void btrfs_print_leaf(const struct extent_buffer *l)
>   			print_raid_stripe_key(l, btrfs_item_size(l, i),
>   				btrfs_item_ptr(l, i, struct btrfs_stripe_extent));
>   			break;
> +		case BTRFS_REMAP_KEY:
> +		case BTRFS_REMAP_BACKREF_KEY:
> +			remap = btrfs_item_ptr(l, i, struct btrfs_remap_item);
> +			pr_info("\t\taddress %llu\n", btrfs_remap_address(l, remap));
> +			break;
>   		}
>   	}
>   }


