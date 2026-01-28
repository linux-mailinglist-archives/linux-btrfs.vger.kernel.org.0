Return-Path: <linux-btrfs+bounces-21158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFnDKELGeWl0zAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21158-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 09:18:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9409E21F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 09:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D3C8300B8EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317BA2F1FEF;
	Wed, 28 Jan 2026 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f2aETdn7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5DF2206A7
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769587762; cv=none; b=Y2hIzAMYJhS8wjGmXaxCIsspGMh437eZ3VWH7yP2vCjpyFf4yk1VutpbY7yMhbs/rKv/rdmVq7BPo/W5vD5+gjt6dXdBn5m5m0h7UhzfbeYTUhHb8ZzppmqHgncToqv24m0gbM8bPuVh7b940VHSE8PWAui3JMnNpEWg3tFE7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769587762; c=relaxed/simple;
	bh=vjyJuZIGyn47ThzJ2WzPDFQxEkOcewvR5/D1lZDmqdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MsGD8S5Ru/v3eQNS974w7VlImyvQaL3d6Lc44QTjD663x2maL90UFaIOXWgOzdMturxcPVMOBsQkVai87DQiUCyt5L74y3+ha7lVjApbMWOemaRtjAV684YZjJNemwIZGIa6gTdVNkZjDLhJfGCw1qbe/yITow3VxiJuMqfLF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f2aETdn7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fed090e5fso4024590f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 00:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769587759; x=1770192559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg10CQJEoHTu1ZnrAzROsoFPzgXDWODbNA2mztHGp+g=;
        b=f2aETdn7Y9YOR4g2/5L8xx0mMVJVHL+Py7DC1qDIywyC7lvlV/+1dy1tyglcJ3iDb6
         7T31V6CXa15G2LEXNzybmV1xSIisMms/UN6Puj1ubB7iD0Gci8W2FvrrQefwq+nwiwFm
         exK82c8DYrQjXXsGk3VozJ2rDHprNyOTY+lAf3p+ZcfooAnE0Sw9WWOmKBB804kGcV9E
         EwgO6UgWGhh8F5TrjZLPF8sVi4C1R20oESZbX9dbeBBplcePkGkphSITp8n5J/2xM7ng
         k9WfveZ8U7WFxbctI2yUfE3IuC18hwgq8pdKJX+BduDG+WdVqFp8jUE5RrReQqGMuI7D
         vo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769587759; x=1770192559;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg10CQJEoHTu1ZnrAzROsoFPzgXDWODbNA2mztHGp+g=;
        b=l2OFkW7wgpo4seYSmwNw/RcWVs9in5OUKecKLxPIwSQ32idmqm/6ZzNOSh9YXncnRR
         YnLTe8pYvdRMZz/UsACLfekawD4TjQfvAZQMCEYJKjF7tov+3FXbJOpSzdGcRx6gnT/w
         DrwXbL5XH5AcWK5QtzRsJ2jf4G2yjbWqsDgKb/ZcFS2nvVVydwhMaJD+yRXUAxdVM7rh
         ImeIKFH/gwNVvRSVXRSNIrkyk/gqICUcfR4CR4AnazDvh/vnkqTV4MaUAgiFitXamuYy
         nlbrkcMfjfsVJEqHVMcOqbmL5VPniRrPpOqW15yoNEisjfmUA6af7ylc4ESgJian2q5F
         KPnA==
X-Forwarded-Encrypted: i=1; AJvYcCVa/0b21wDId0w1mF4eFVomvS7VIGsuwiwqbrjPKuzg0RKjaHlCN0DVXCuIE9SiUoIzxekNktho8Z5Bag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOiTOUzI8akaZ2vk8w5XQC7+tCuk1ilDIzr/ppVju+DVjFuoyv
	udI/GkZ21lPj4c2tRMMg8rXZ18e/Hb4ac6a5MG5gKMTSb97d6Y/OMJTwl+XX9oAbCQw=
X-Gm-Gg: AZuq6aI5fJZPR5Md2wlOTM56mXUdf0Rpkq2ZO6yoX8NgkwbSV6jA8GyCD09/LAitSKR
	ha9f87IwR/LUBF9eg17nyLv3p1KBc9n/YSDnnXh4Ffoi5NDXdmU2oWea1o6EQv5imrhCGcrScOc
	Qs1gxBPpqElL5rwygALearEmkzlIfz1WoKXo1UxZr26gHdNeTVOUl3PPddJSDn9pK9t5riCTC9i
	KqGjw2w2Gal+6sCnc2Vgp12CfOsoQGW7+57ZmkZmmCY85dJPkHT6JBdbmhZIvdqIpJ1M4h7UKWf
	6m+NCvtZ/zwKJm+Qi+MtyWFQjbe4n4D49ABzcIzmTWsL7Zhmlqpm6UMC181c7P/HOVtqOAhBQdO
	rU3ETgjNXawNbK97xnysqASSOdlCdLN5o7uweSxlcvr1EtW2oniNT41wcXk+a5Ia6MvNEhOY3XR
	cwXh8TSof8s8CDvPIzezR3CXwMdgXOawAozkGnoUAzp9TjdTN57g==
X-Received: by 2002:a05:6000:1883:b0:435:af89:11be with SMTP id ffacd0b85a97d-435dd02f6e4mr6983325f8f.15.1769587759288;
        Wed, 28 Jan 2026 00:09:19 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c56e20sm1777278b3a.65.2026.01.28.00.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 00:09:18 -0800 (PST)
Message-ID: <afb60de0-8d6d-411a-a0b5-f6d24bf7ceb8@suse.com>
Date: Wed, 28 Jan 2026 18:39:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] btrfs: continue trimming remaining devices on
 failure
To: jinbaohong <jinbaohong@synology.com>, linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org, dsterba@suse.com, Robbie Ko <robbieko@synology.com>
References: <20260128070641.826722-1-jinbaohong@synology.com>
 <20260128070641.826722-2-jinbaohong@synology.com>
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
In-Reply-To: <20260128070641.826722-2-jinbaohong@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21158-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: CA9409E21F
X-Rspamd-Action: no action



在 2026/1/28 17:36, jinbaohong 写道:
> Commit 93bba24d4b5a ("btrfs: Enhance btrfs_trim_fs function to handle
> error better") intended to make device trimming continue even if one
> device fails, tracking failures and reporting them at the end. However,
> it used 'break' instead of 'continue', causing the loop to exit on the
> first device failure.
> 
> Fix this by replacing 'break' with 'continue'.
> 
> Fixes: 93bba24d4b5a ("btrfs: Enhance btrfs_trim_fs function to handle error better")
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: jinbaohong <jinbaohong@synology.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent-tree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 0ce2a7def0f3..bd167466b770 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6688,7 +6688,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   		if (ret) {
>   			dev_failed++;
>   			dev_ret = ret;
> -			break;
> +			continue;
>   		}
>   	}
>   	mutex_unlock(&fs_devices->device_list_mutex);


