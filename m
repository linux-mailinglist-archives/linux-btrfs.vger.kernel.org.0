Return-Path: <linux-btrfs+bounces-21934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OFyBe1an2lRagQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21934-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 21:26:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ECC19D2E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 21:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 713BF304FA75
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0237630F55B;
	Wed, 25 Feb 2026 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MlxOSbfA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3130F542
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051113; cv=none; b=mj5zrXXk8kc0u96ywQSMkPesj97HeKzUdKsVtDoAq2awUOhTMuk1F5kYcXz82peRhcOUbwIFabZr9Oy+I+SLJNQIqe9nAvKr3FZ7AZ4sdOc0jcPtvYo90d8m5fk/H2Pd9g3p0CEmmODBfnX2b5kzYp1ZnW4rJLvWdmTsniGhLSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051113; c=relaxed/simple;
	bh=VW8af6u5FBe4CZG8g1VGxu7mfZ0GAHR10NlBORStYIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WG9n7SZkksi5rV+kHeHViKy17GBsFD+Z0MZ6i2SbheEFxdFJZiE3V/LdvKqth5APcV4PQimkumNFGpomVVTG0Z0GxNdyd98iJ9TkW2IV7FW0mZDoZjx4LKDD8k3ciQ/udVKBd4gPcAgg4H+r0A4Iyecl/MRsWseTcvkl+1WjtbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MlxOSbfA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4837584120eso1219815e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 12:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772051110; x=1772655910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=okCMvfa5/1RLlve1s/ODa5Vk7OTV0ciZu0vH4+f8M3w=;
        b=MlxOSbfAybulQwOlE9E2wL1H/4wPVUAdhdb9SWIPBpPsW+XA+jsjkRYyyUB9OUxOcx
         velrsqtW2NCJLkE07FYkeMdneAanH7op6vB2R0rTQTja6ZRR2SlGvRSCRbjsW0sT9HEj
         p22DMLquBsFcyHIcwIwRX1ydF9I3/NyCxiOeMW6AQUwO17BKZsnRrNPSmmhJG6iQlrTo
         b+k2un0B3AB9rjNonHTiExMuNAHt4dLfkCZNmLcHLnE22gm2825XHlVAzB/18zAxUesE
         FpPrpiI8FOquyQBf6jTg5oT4YANyCT/cJLtAIkBNUd526wPCmIPBr/uRFIkMB34GMtBx
         XLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772051110; x=1772655910;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okCMvfa5/1RLlve1s/ODa5Vk7OTV0ciZu0vH4+f8M3w=;
        b=DCR0IvXWnA7Di0QN7DvBa/Vlb/PS+AU95UobyW4jtkxHFgtEVitltz2CyDvNN7sosL
         1iuiVrJ45v6OpeHZneagQzgi0vXnr0367K5lsWRfxa0C7yHd9p9Ou1lWJeFgEmhsv/lk
         E8iW8dpCXGTfressUVd8E7nO7UStCtNaDY1rQ+BHX2bov17hCPAKQ0hjDJs19OH1DZ80
         QJwG4nINcVvKOFJ7Bd2+8g51pvi2vydyVXsLNO7fZDBXmVJOIybMsRNcBgm5X++3fPeT
         z3kKmVhDHSCuKZlSzh44aeXIy5rVBx6DyxawQuOyKLZbrbVkeyYu9JG1XDEcnoaBEjJM
         VBzw==
X-Forwarded-Encrypted: i=1; AJvYcCW9azdo3QPYWQwjN/rSeZ9fLXetWXmA8UnklzW/L2PZBz/Zlr/olL8pSdAlHIucYXQ4FztxUTwjI4AxwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2qp7nQrR0oknPORF+nMw33u+8vvtkwSk8zhF68SxV5sv43fbU
	HdK0niLJVoOoE+2FvJ4eLynUPRi8J684kHzVW3KqPRGv8LjIGNBALONOFUhAPT/u2Xc=
X-Gm-Gg: ATEYQzw3ufkj3BeaTdJETs1h0+ZRBgF9WoV32Gs+jUTY1iYcVAc8LihodggMMXuwjm3
	YEiMoTDtFXO0LEaFBAMuFiuYOgIQCa8Q5euU+Omfqn5xEtnYD/8229+GlWsbcO92sWj0ArT7OrE
	9DXTwT7opZZUNpvFnCsm+Peuk0fmVachiWAi2S22vQyODtBpjz+odzisgcdPD8JExsmJcEkO2Ez
	eMK1a7O6uH74KP61aZR7D+KkxJwLwxm7Qbm2rftwNYuC9TdLVlw9kIASfEU5VdR2dMWgW51pf30
	uyeuQGhFqF+m3hExW2UzVQ4o4hus3aUkC4WbisnbvNlZwc2PBDYnQHAynW1ozQMT4LFv4Wlq8fq
	7d1ykk9G04C/l+yFmKLyy2XYJqTPSYDnLr8993aFe4vqLuxhP/APxCH2Z++phI/7EdHFvSnudir
	9A0HnuiyWX7MC02pGk2WdaTpUx+jRd62S8KLpnsSwHFtSqMPo6RB4=
X-Received: by 2002:a05:600c:8b30:b0:47e:e78a:c834 with SMTP id 5b1f17b1804b1-483c21b52ecmr26038995e9.34.1772051110041;
        Wed, 25 Feb 2026 12:25:10 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm686595ad.53.2026.02.25.12.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 12:25:09 -0800 (PST)
Message-ID: <ab72ce7a-b64c-4b6f-9100-ba18c6472324@suse.com>
Date: Thu, 26 Feb 2026 06:54:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Fix a bug in try_release_subpage_extent_buffer()
To: Bart Van Assche <bvanassche@acm.org>, Chris Mason <clm@fb.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Boris Burkov <boris@bur.io>, Leo Martins <loemra.dev@gmail.com>
References: <20260225195958.309047-1-bvanassche@acm.org>
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
In-Reply-To: <20260225195958.309047-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,bur.io,gmail.com];
	TAGGED_FROM(0.00)[bounces-21934-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bur.io:email]
X-Rspamd-Queue-Id: 36ECC19D2E6
X-Rspamd-Action: no action



在 2026/2/26 06:29, Bart Van Assche 写道:
> Call rcu_read_lock() before exiting the loop in
> try_release_subpage_extent_buffer() because there is a rcu_read_unlock()
> call past the loop. This has been detected by the Clang thread-safety
> analyzer. Compile-tested only.
> 
> Cc: Boris Burkov <boris@bur.io>
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Leo Martins <loemra.dev@gmail.com>
> Cc: Chris Mason <clm@fb.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Fixes: ad580dfa388f ("btrfs: fix subpage deadlock in try_release_subpage_extent_buffer()")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Minor modification to follow our standard (e.g. no upper case after 
"btrfs: ", remove overblown CCs), and pushed to for-next branch.

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 744a1fff6eef..5f97a3d2a8d7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4507,6 +4507,7 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>   		 */
>   		if (!test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
>   			spin_unlock(&eb->refs_lock);
> +			rcu_read_lock();
>   			break;
>   		}
>   


