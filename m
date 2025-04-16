Return-Path: <linux-btrfs+bounces-13069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434C6A8B735
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 12:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B423AA87F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA64D23642E;
	Wed, 16 Apr 2025 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QP+qhsIW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F31221FDC
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744800965; cv=none; b=RKKtbpxowwtW37o9qMT/3KHUzymONOFC5M6AjiY0SSkWRMD2oLRDvufHM3MUOGdaLRF/V4XhSSOD0AdnJBKHr7cxoBXGixsn6fkh54S2/sQHUI4RhmN/bE/jFGT6Kum+Xo+IwvUOu6eAsjYOrr3HGWbkrefXtPbQBGKDlhFuG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744800965; c=relaxed/simple;
	bh=Kz+31mxX+b7PGcw1/XqDtSGOgHY0SD+iD2XMrhVNTKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=juEFZ2mcd6tSADu5kuHXWtOkIJcj2xbgqUpnLK5RA0Gu8f0FE5zgLSvPusaTDAYDedGw/7VHSjo/cIwYuEHsiTkXElNUhwYpUBJ7jglsEE4pkm6sndRhgmzW23SSLGql9sJr+L5M3agIjJsD+V4k8E05O3ApPwLwLewmg/QgsBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QP+qhsIW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39129fc51f8so5759292f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 03:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744800961; x=1745405761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9zhrDZJ9fNwJ8Q1g6P8l1EmtIjcyFlg4YES/eIElpmo=;
        b=QP+qhsIWQmvvTVy4bGSYkWUGCJhEBggdMo4eCK87SLlrssw2XrtNA2EilTtvAXX9BW
         Tz1O36yxofbvbeBi9al+scWC745pg3O6ysl+7Qi16S8quw8M0R1IEfHNmY4WOqW4on0R
         PGoSF0Qj6HTH3kTbKBUP8Hy0hYbm3Y+lWcWgXsMBPY4D1oB1NNXKNQVIufoLtI4ytDxx
         8Qv4Fdu6kpyHR2FECwiICSI4LxzgNRpGf8DpYr37o3pGKLf+VhW4CzB8VG3sJO5oNDSp
         bzpPRdYYGDoLrs+x/UYlhEDb8ASg64lTtUicQCJex0vaWg8YYUE4AUSVkpUE2OXC+fvg
         mp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744800961; x=1745405761;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zhrDZJ9fNwJ8Q1g6P8l1EmtIjcyFlg4YES/eIElpmo=;
        b=K8VcjcZL0cIXU/XZtEkWcIC29UUqfZh/v/hP4ZKd6Pc7aWGoJZMe4OYxAHW2+hIQXE
         DpcLxo3/b/HQnU5fCW00H4S5o9NkVvHB4d+lUSjXWCRP7nVnujkiGlRAd7BQKVPujj2l
         UaDBj9KV+p2Vh6Twv5Tkw965shbCLVTqcv9HJR4Y7UHpatrWa4TWOsDuUnv5BSZBDys5
         yZUL4huokBbjjbOGMi3x5Q8ZwjCMqExmj7rqFa0Nkkk9x/G0nnv3niiNIlfKfAAL6AZd
         QGxn3qgrP57lvcIF6gymIU2eamNlxsnW8+hSV+aI9ClDceXdXQNsG/UtQxLFhYhgRnZM
         KJbA==
X-Forwarded-Encrypted: i=1; AJvYcCWuPF6eyhX8hcc2kyxGoiWFeiPVi/jhDtP3O5AcFZ8mUrrZgIIEFA1uzPlg4u5LuyD9LbAOOn7Kq3xBzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyA15fnIIy1IKDvTU0TexXSJiVu498M/EWFux3kHtxfNnAsRBA
	IjfwbBCN/uPLnvS28Yl0k+AOBQDwfLCGjnEuOLlIa+bOni85XdIo0A381v48wOe58PR1UaISnBS
	d
X-Gm-Gg: ASbGncvCKCdhNSu48EDiXaV7J85z0Prh+m/FOGBjekg9ONmQYceOkw++tSs6IvYiEtN
	g3vrkDR4yrPUifsi13XsCk2D3wUQstPTfX5B8/5UEhV6xHMZ4XY4XzK6ckqAv/hU0dnX+bGqZ82
	5MikeJjCm4XMq4A5AtLG9etT3lSKP0JcaWSVpvWrIXsimjb49j9BurFVLOF/cm3uzHinu0UxzE+
	5IIfQ5b1M3gzKNOUJ3HkCQmUTw72FuoQUfAB0kJGmz8Tp9zVTuN97Zw3w+USjPKWu+R/ibtON+F
	z+qijJj/ApdFbYsQlxIl1RI/6cRchtDP+prNCDiPSOcAjQ/0LtR6F3U5XrzWLpARJ5Ms
X-Google-Smtp-Source: AGHT+IEcelnXBupxRpa0plTp1l7zCFQfmv6pTgCxoWC5NOJ8xHBSTncUhZMn1m7pEPH//+XmKplNng==
X-Received: by 2002:a05:6000:40dc:b0:39c:1f10:d294 with SMTP id ffacd0b85a97d-39ee5b1cb7emr1191718f8f.26.1744800960660;
        Wed, 16 Apr 2025 03:56:00 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b220f4b0csm982384a12.39.2025.04.16.03.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 03:56:00 -0700 (PDT)
Message-ID: <dbdf0811-6359-428b-bf23-79e793973c12@suse.com>
Date: Wed, 16 Apr 2025 20:25:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Assertion and debugging helpers
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1744794336.git.dsterba@suse.com>
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
In-Reply-To: <cover.1744794336.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/16 18:38, David Sterba 写道:
> Hi,
> 
> this is a RFC series. We need to improve debugging and logging helpers
> so there's no ASSERT(0) or the convoluted
> WARN_ON(IS_DEFINED(CONFIG_BTRFS_DEBUG)). This was mentioned in past
> discussions so here's my proposal.
> 
> The series is only build tested, I'd like to hear some feedback if this
> is going the right direction or if there are suggestions for fine
> tuning.
> 
> 1) Add verbose ASSERT macro, so we can print additional information when
> it triggers, namely printing the values of the assertion expression.
> More details in the first patch, basic pattern is something like
> 
>      VASSERT(value > limit, "value=%llu limit=%llu", value, limit);

I think the idea is pretty good for debug.

I have hit too many cases where outputting the values will immediately 
help me pinning down the cause, other than adding extra outputs and then 
curse myself being too stupid.


But the concern is, we already have too many different debugging tools 
just inside btrfs:

- btrfs_warn()/btrfs_err()/btrfs_crit()
   These are the most sane ones so far, and they saves us a lot of time
   debugging things like memory bitflip in tree-checkers.

- btrfs_debug()
   Looks like the least used ones, if someone is actively utilizing it,
   please let me know.

- WARN_ON()

- ASSERT()
   I'm definitely the abuser, almost all my patches have utilized one at
   least.

Now we will have another one, and we will need another set of rules for 
the newer one.

I know everyone loves new things, but I think we should sometimes to get 
it more consistent.

So, if we're pushing towards VASSERT(), then it should replace all 
ASSERT() eventually. At least mark the ASSERT() macro deprecated and 
stop new usages.

> 
> The second patch shows it's application in volumes.c, converting about
> half where it's relevant. There are about 800 assertions in fs/btrfs/
> and we don't need to convert them all. This can be done incrementally
> and as needed.
> 
> The verbose version is another macro, although with some preprocessor
> magic it should be possible to make ASSERT take variable number of
> arguments. Does not seem worth though.
> 
> 2) Wrap WARN_ON(IS_DEFINED(CONFIG_BTRFS_DEBUG)) to DEBUG_WARN() with
> optional message with printk format. This is used to replace the
> WARN_ON(...) above and also the ASSERT(0).

This looks very fine to me, independent from the VASSERT() part.

Thanks,
Qu>
> The ultimate goal for me is to get rid of all ASSERT(0), it's not used
> consistently and looks like it's a note to the code author. There may be
> several reasons for it's use and although I've converted almost all to
> DEBUG_WARN it may miss the intentions.
> 
> In some cases it may be better to add proper error handling, print a
> message or warn and exit with error. Possibly the are cases where the
> code cannot continue, meaning it should be a BUG_ON but this is also
> something we want to convert to proper error handling.
> 
> David Sterba (5):
>    btrfs: add verbose version of ASSERT
>    btrfs: example use of VASSERT() in volumes.c
>    btrfs: add debug build only WARN
>    btrfs: convert WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG)) to DEBUG_WARN
>    btrfs: convert ASSERT(0) to DEBUG_WARN()
> 
>   fs/btrfs/backref.c         |  4 +--
>   fs/btrfs/delayed-ref.c     |  2 +-
>   fs/btrfs/dev-replace.c     |  2 +-
>   fs/btrfs/disk-io.c         |  2 +-
>   fs/btrfs/extent-tree.c     |  2 +-
>   fs/btrfs/extent_io.c       |  4 +--
>   fs/btrfs/extent_map.c      |  2 +-
>   fs/btrfs/free-space-tree.c | 27 +++++++++-------
>   fs/btrfs/inode.c           |  6 ++--
>   fs/btrfs/messages.h        | 30 ++++++++++++++++++
>   fs/btrfs/qgroup.c          |  6 ++--
>   fs/btrfs/relocation.c      |  4 +--
>   fs/btrfs/send.c            |  4 +--
>   fs/btrfs/space-info.c      |  2 +-
>   fs/btrfs/tree-checker.c    |  8 ++---
>   fs/btrfs/volumes.c         | 64 ++++++++++++++++++++++++--------------
>   fs/btrfs/zoned.c           |  2 +-
>   17 files changed, 109 insertions(+), 62 deletions(-)
> 


