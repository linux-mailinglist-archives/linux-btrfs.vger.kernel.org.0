Return-Path: <linux-btrfs+bounces-15279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C404AFAAD4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 07:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5740170292
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 05:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FAB262FED;
	Mon,  7 Jul 2025 05:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eaqnvdeQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CD82A1BA
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 05:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751865846; cv=none; b=AI+OO4Kdx9eFIY1HBiKkLbHnz38iitxgCy8et7+HSbH+u5ymeYwAuHgQ9mTZrazsOD104YPk4siJiIwEgiHUsBW4x9ztvV+zuLvgoxq35ABEJvBHNvTbKXHr+mcodmEs55tzausRu+9RK5odqyskZZNYQTbnwdRLiAxN2iLunEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751865846; c=relaxed/simple;
	bh=Z5aKuIE7+wK24+MIDy4K2dzv6yjAgb8SNRCm//XAiwE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=HkSw9Ut9jbr7RP484kdfpeJTA9V4CR+y3S7IfjsZ+sKaH9s67dQGx+GYdlJN8jFuCi7YH6sx7p3t7lI1Hyql5JXJE+PzgURc+FDGKIQxRdwfANb4dfMaG5CspEQZLJg5eFmivqS9IBt6zIlL5jc5v9Lva992ACur9YBPTZfpgoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eaqnvdeQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-453066fad06so17818365e9.2
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Jul 2025 22:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751865842; x=1752470642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQdqzVts8jklb4nP/qUb+826N25lQvPz37VI7R4DMtA=;
        b=eaqnvdeQ0D6NDZbMHsyLEHsRLNobggZAgl+HSiRr8HUyIpTbKGveaOVze7E/kgHP/i
         Wjg57xFgeYrAkCS5riqUbdq7FvvXM/3bDv0SRKuw+E/Q2Gg5I9Cq2b+1bV4242ly4pzn
         M8pJqL1HWX5NT0gZaekx2mCjknOYyUPlq8+x2dmRRcrzJlKFLbdk9INzdYk6sel6MD4j
         6zHsa2rL4tOlUgmKDAaDnXYNpAa3Z0wyNG4DrhE+kPbUB/W6txO5cmIg0cDl1RRO2PO1
         yuPuDRlo6RodPxnaQbX3h3fCdbxQGoRYzGSIoA6sNtFz6sEnzneytRUxH+IlEou+oPQV
         0eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751865842; x=1752470642;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQdqzVts8jklb4nP/qUb+826N25lQvPz37VI7R4DMtA=;
        b=GUOvrdiggJ2kdaeYFNpywIuSe6Us/G12hrCivvFTiDZKDjbLq5ebHSTYbHxBZi6pB4
         ZwtKgVLlCHOQtXstVs0E5zv91TWaG2dmNNoeNggzid9v9n3/45QsmmQq/jvwJLIJxjGs
         ZA+Smwe0hP7bAspTdWxJ0cVpx7aI5A/aWd5qd32LbRlp368UK9ku/twhxlKEgNNHQVNP
         zxktS/hHJYBfZsEN9dHQLRgAKpdpGPe0LHqiCa2KfVieDeRfN5lqNiRtMMKnJEemsssK
         hmw2VIoHgDy/wTSiPQy5YuTLDA8BWpdslMaH9Jg2aMjLe/CPDpm4qqRNijbeA7UflC2U
         1rcA==
X-Gm-Message-State: AOJu0YyBpI8eNUbjzZHWHyqpLHRVpGUPbhTDJxyDSOsVh7wYuGSaeirJ
	aeLsuRvSkq96lmeAO9upNTb5fSWD19k1QASNV3vsrOkfwodz41TNtldgBDVnMf6zEePv02hrFon
	n17BT
X-Gm-Gg: ASbGnct/NC6fVfGj6vx+OtQ0sfluN95RY+E+Xa0f+adzQuJHvn3rDu/Obr8qCFIga6W
	pi0F1bKIxmGzmESxxmo5GouSe3pm7GDuV8HXN8zqspff2XqCMulUtZWsaO10tN+GGsga4oLICZp
	CkV6s86NbdiikzS9PaCXey8UGpwqqrI9/7LSSqkOcUzHGBzJ2mg6KR0DitwcsF4n7l8q0nWfeSn
	wgoB2F+yYJxwAq/hYtwpTBwd6o+N80djwjw4QSobRfjjdXPVOvakWE0G9xVRXQpNLjFE4gZLlgF
	Nezdohih/BKJlXfXpUfmg/Q6AbkxwEJTdsAHHSeKf+qcFRnkk89YhMXuMKf7FV98l7SEvW2HoiP
	wAQv4yRNYs8/aoQ==
X-Google-Smtp-Source: AGHT+IGNm5UgUk3N1qne4n87Et3ne9S+YVfOfVx6lUtCTc1EAL0oQP+B5ICj16xSukSHp7rYN7vkWg==
X-Received: by 2002:a05:6000:471d:b0:3b2:ef53:5818 with SMTP id ffacd0b85a97d-3b49aa09964mr4558064f8f.5.1751865841931;
        Sun, 06 Jul 2025 22:24:01 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42be9c7sm8473870b3a.146.2025.07.06.22.24.00
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jul 2025 22:24:01 -0700 (PDT)
Message-ID: <8abcc475-98c8-4bb7-add7-c4fa40065add@suse.com>
Date: Mon, 7 Jul 2025 14:53:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is
 being frozen
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/7 09:55, Qu Wenruo 写道:
> [PROBLEM]
> There are some reports that btrfs is unable to be frozen if there is a
> running scrub.
> 
> [CAUSE]
> If there is a running scrub, freeze_super() will wait for the running
> scrub as read-write scrub is holding sb_start_write():
> 
>             Scrub process             |         Freeze process
> -------------------------------------+--------------------------------
> btrfs_ioctl_scrub()                  |
> |- mnt_want_write_file()             |
> |  |- sb_start_write()               |
> |     This will block freezing       |
> |                                    | freeze_super()
> |- mnt_drop_write_file()             | |
>                                       | |- sb_wait_write()
>                                       | |  This will wait for any
>                                       | |  sb_start_write() to finish
> 
> This means freeze_super() will wait for any running scrub to finish.
> The same applies to all ioctls that requires mnt_want_write_file().
> 
> The most common long running ones are scrub and balance.
> 
> Since scrub and balance can be very long running operations, this will
> cause freezing to timeout.
> And since freezing the fs is required before suspension/hibernation,
> this means those two operations will fail too.
> 
> [FIX]
> Check if the fs is being frozen, and if so cancel the current running
> scrub or balance.
> 
> So far I didn't find a better way to solve the problem, the only way to
> drop the mnt_want_write_file() is to finish or cancel the scrub/balance.
> 
> There is no way to drop the mnt_want_write_file() meanwhile just pausing
> scrub/balance, at least not for now.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> I'm not sure if cancelling is the best solution, but it is the easiest
> one to implementation.
> 
> Pause the scrub/balance is not really feasible yet, as it will still hold the
> mnt_want_write_file(), thus blocking freezing.
> 
> Meanwhile for end users, pausing scrub/balance when freezing, and resume
> when thawing should be the best outcome.

I have explored some other solutions, like dropping and grabbing the 
s_writers.rw_sem during the balance/scrub.

The problem of that solution is the reserved lock sequence, thus it will 
be deadlock prune.


Currently I guess the best solution would be introducing a special error 
code (maybe >0? -EGAIN may be a little too generic in this case) so that 
if we hit that specific error code, we error out as usual.

But at the top level where we call mnt_want_write*() function, we drop 
the rw_sem, and retry other than exit.

By this, we split the original long-running ioctl into several different 
smaller sections (the split only happens after the fs being frozen), so 
that they can properly follow the fs freeze behavior.

The challenge is how to resume from such interruption.
Currently neither scrub nor balance can properly handle such resume and 
will restart from the beginning.

And even with that resume implementation, the checks in this patch will 
still be needed.

Thanks,
Qu

> ---
>   fs/btrfs/relocation.c | 3 ++-
>   fs/btrfs/scrub.c      | 6 ++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 175fc3acc38b..f173e36a69f8 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2797,7 +2797,8 @@ noinline int btrfs_should_cancel_balance(const struct btrfs_fs_info *fs_info)
>   {
>   	return atomic_read(&fs_info->balance_cancel_req) ||
>   		atomic_read(&fs_info->reloc_cancel_req) ||
> -		fatal_signal_pending(current);
> +		fatal_signal_pending(current) ||
> +		fs_info->sb->s_writers.frozen > SB_UNFROZEN;
>   }
>   ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TRUE);
>   
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 6776e6ab8d10..bf8e4c411b60 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2244,6 +2244,12 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
>   		u64 found_logical = U64_MAX;
>   		u64 cur_physical = physical + cur_logical - logical_start;
>   
> +		/* Fs being frozen, need to exit early or freezing will timeout. */
> +		if (fs_info->sb->s_writers.frozen > SB_UNFROZEN) {
> +			ret = -ECANCELED;
> +			break;
> +		}
> +
>   		/* Canceled? */
>   		if (atomic_read(&fs_info->scrub_cancel_req) ||
>   		    atomic_read(&sctx->cancel_req)) {


