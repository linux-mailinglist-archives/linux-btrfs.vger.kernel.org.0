Return-Path: <linux-btrfs+bounces-15618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B52B0CEA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 02:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20006545B59
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 00:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AE1F9D6;
	Tue, 22 Jul 2025 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K9ytZuOQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44C195
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 00:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753143361; cv=none; b=ZJxdtgL9qk/6R8mPnVpeqqhO21KWgUq40vvRmD9TNYdb4BdJsT8eRy7Li3rA1j3LlNT7WMOyo2u8WSeOMWD/rFOaz6T91EAj36/mowOa78iEvEu9UmZPhBPwxzFKUbLz2qO6RGT4VnBXqCqyQJnq/h0ToTzdRQbNL0eUZOl80Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753143361; c=relaxed/simple;
	bh=+31d6OqhEP+wNLI+3UXAT6PckLVfXLhB5J5/t2T33yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gBtSm0ANNyE1/Ga8m6oNFsGc5Zdq1/Q9sSd6kj1J1w0C1SCyYCiNvaTEvqKV23GvAYNmVoNHWOilAu5VXznPsmEjyFNifoaFFwZOCenAv2O2K1eFdVEHqjnL0uadIAfxUJMaNx2/5jQcWlpCJ22abeU52S9QbxA3ust3m2K7ON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K9ytZuOQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so2804644f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753143357; x=1753748157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RL0H9abn4jlmsdrPCj85ahc3VaqqYPZxYXLMQNFjxAA=;
        b=K9ytZuOQjuVdRao+vG2+VLvehejOYO6dlI351LtlIbTLZPGXkOEKZe4gJGlYMiR/AO
         URctVETbk8Nw1ntTj3/6j8lTE5CqtPdsYy3pwaoOdq6gOGLNMgr4PWXSGc9HwWm+rb1A
         qm/8li1hbaYeAhzt9NBtqlK1FfxtVNjusn4/Uvk/VJ6fHvcwwPwqCagmQtynq59z36N7
         tXWrNetQgaW12mvU4OZPlI90w6GNFNFw6V7pcc46v3MK6oHw3bSzrgBkQOgOASUqbIzB
         jI6guRxu0BB8lSXPefDazuBjhj6ReyWEumYHL5V7m9bvW0ll7rf640xhiBInAS+fqYEC
         BeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753143357; x=1753748157;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RL0H9abn4jlmsdrPCj85ahc3VaqqYPZxYXLMQNFjxAA=;
        b=SMQOtyOo6scYFylMu1B4wUhijWbFTpbl8LhK0z5LcPI97DZmr2MoRqJkktvCwzBj0C
         TTmwAXT6hpp0La3BJOcIstsGtwDLBTaAHL68mygbW9AavKnEvVPi/3MzPgojNugz1/Nx
         mGfYbu6kaW5jswJCh3zZmhJalONX6Q/1WsN5cjrNMrCkB2f/duMdVOAiCsyAjan+LSNo
         zEDYDCaMrWqybhsFrJge1MxttUz3PlgGhTluAGCtj6jUQDx37wOH7aUqG5J+Xq7P9lXl
         i/2vnJ/iECtavCdLEDcksKuZ4SeNS12mKupG+T+9eCU1F2uiTg0KUeS5u7aX4vAUsO18
         PK+A==
X-Forwarded-Encrypted: i=1; AJvYcCVRSQ6sDM7nrU8gYlBy1pP+OyoiGAoXQV8T3rGVvvdZTEyz2NBwVe3ROo/UVzXPNc6HA7ZDDu5nYOJ/YA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmAwZsINj//z3DuUDbCwGvN3WAcVt+C/iG7sPYdBoR7lQRX1SN
	sU314y4zY165fw8+Ao0dbAO5/Wxm0J20udEJ9XRx8iRI5m5fiCi/LINe8ry8z72zLino/BN/7Gh
	7QNyA
X-Gm-Gg: ASbGncvDXQ7VTAWRAcdhxvkwIpafbeNX5iGYjna8O5ruKavyYwgMi48slTjF1Oywag3
	eHuY68ASbesFGZDPYfabbl9mOCYiC5ZE70ZeQisSWEJKOtImhWjpH8LM27toPsrJ3EGJzrX6piQ
	iD7vKxtfwP8z9yMMiJ4PrBRBlTPMXWfpBBNDctxjHpi+nY98mR8lMVZxF1U6BWJ+8BK+DElAE3Q
	qvIX4vzSuzi5900JTgUUf9pnLL+CtRbm/SqfAyNjDXDSMMZia+11hkxWJ5WVG0y9lWRez+1jOy6
	voypGmafaDR8hA1KlDhbJEEaSiDXWtOo0zNox+62cST/1AqCH7H8UqSSSWRMB+dUKEjGlQL388H
	pMQtqA9H/KuLIQ0qNsDcTBZHOVRvd3ovzM/XnpSx1iLK8J0pmTbA+sYJ7bWwe
X-Google-Smtp-Source: AGHT+IFj0zSgTEK84E8cZFSTdswTaDHe/FmqlGsfmH8POdYIeBbkRXUL97II0Lw7LDG7RANaN+glJg==
X-Received: by 2002:a5d:64cd:0:b0:3a4:f7e6:284b with SMTP id ffacd0b85a97d-3b61b0ec05bmr12050803f8f.10.1753143356602;
        Mon, 21 Jul 2025 17:15:56 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b708273sm63960565ad.228.2025.07.21.17.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 17:15:56 -0700 (PDT)
Message-ID: <63f83bf0-e5d0-44a6-8a7b-0ab32b2c64ee@suse.com>
Date: Tue, 22 Jul 2025 09:45:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] btrfs: improve error reporting for log tree replay
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1753117707.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1753117707.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/22 02:46, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Most errors that happen during log replay or destroying a log tree are hard
> to figure out where they come from, since typically deep in the call chain
> of log tree walking we return errors and propagate them up to the caller of
> the main log tree walk function, which then aborts the transaction or turns
> the filesystem into error state (btrfs_handle_fs_error()). This means any
> stack trace and message provided by a transaction abort or turning fs into
> error state, doesn't provide information where exactly in the deep call
> chain the error comes from.
> 
> These changes mostly make transacton aborts and btrfs_handle_fs_error()
> calls where errors happen, so that we get much more useful information
> which sometimes is enough to understand issues. The rest are just some
> cleanups.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although I believe we may further enhance the output by dumping the log 
tree when replay_one_buffer() function failed.

Especially considering we don't have a simple way to dump the log tree 
for a subvolume (always needs to go through the log tree root, then into 
the log tree of a subvolume).

Thanks,
Qu


> 
> Filipe Manana (10):
>    btrfs: error on missing block group when unaccounting log tree extent buffers
>    btrfs: abort transaction on specific error places when walking log tree
>    btrfs: abort transaction in the process_one_buffer() log tree walk callback
>    btrfs: use local variable for the transaction handle in replay_one_buffer()
>    btrfs: return real error from read_alloc_one_name() in drop_one_dir_item()
>    btrfs: abort transaction where errors happen during log tree replay
>    btrfs: exit early when replaying hole file extent item from a log tree
>    btrfs: process inline extent earlier in replay_one_extent()
>    btrfs: use local key variable to pass arguments in replay_one_extent()
>    btrfs: collapse unaccount_log_buffer() into clean_log_buffer()
> 
>   fs/btrfs/tree-log.c | 659 +++++++++++++++++++++++++++-----------------
>   1 file changed, 401 insertions(+), 258 deletions(-)
> 



