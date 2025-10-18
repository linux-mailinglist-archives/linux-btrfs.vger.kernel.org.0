Return-Path: <linux-btrfs+bounces-17980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD33BEC72C
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 06:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9806C5E8519
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 04:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4789C286D40;
	Sat, 18 Oct 2025 04:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IfeOMgEU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544CD2512DE
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 04:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760761573; cv=none; b=rbFt3HWPhAUWFsz0fqHjYvIEFufyVilXmsOfws6wEZTlFufc26n9XuilOQ3T1jGZd8kNyDuRSZwAOYHKpyiPcC2PMyUr2wbRxt492wmlKgvb8qf3TJQf7VEWrwRHzYQcOdB7Gv44keJ7mF11gyeJUMWdrE6l7lBUMAD9Apb2lNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760761573; c=relaxed/simple;
	bh=qtlpkOzRHsSePh7RpXllJklT1/L4xKNHiqXvBxvsmr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STgxIUIWFM3pa2hQVAk+KHk67AaQmoKdcnDxGdWtu4jYHMf7YVtR9oacN9i1OLvZ+LnwQ3cmqaiwWOJi6Iypb7oTNaveZW+zDveS8XVJl/oT+MwDI1s93Xsq7qwCkKl1hucBcNyn9qMrRQ8soEKp2DaBXuIlnUdzI/ANVcQJoIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IfeOMgEU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso1978770f8f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 21:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760761566; x=1761366366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=drEKLb2YfU8MSPhfkY4ZnWTlLkXiL6+6ak4JCTAdibw=;
        b=IfeOMgEU8V5h8QIQGc8hOaP+AXN3vZunjQYyMVWpg9ez9GueDfqgzz1K5kURQaKy2z
         AApZ/C41t6cib0B841LXomqGtZNrKM3ZnjdMrtS0VXqaNFPMDSsPcEUcd92LKYG98Hoj
         Qx8Zs9bA/i3FiALQxaS7AXoIx5NcqxPlPX73cjYlDgCEAXILbMRDS3hcRKHCK6xgLXwc
         4hpnfnuI4m2kIqeyg5ljblcsb38XnKbsWW9IOyM0XpXCASziLqWE+CX51z5nSW4jNhr1
         C6xSZUsWLn2AYYwxKWSEqCJA6YncVaxXOjbEr24boSnR1+HXIHi5EAzsjzvbWBmSZX0L
         jZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760761566; x=1761366366;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drEKLb2YfU8MSPhfkY4ZnWTlLkXiL6+6ak4JCTAdibw=;
        b=uPc1Jkedn1YBcaK8kHlhkeqiPFAX9tRIZqXsQoQdcFFsPpI1ODmdF5KRs9x6Q6ccze
         UhcFcHWGdfk3jQTDPdCbSFKKOfCYZTGnXPUTivEoIJbxdul/eFcGvT5lbyG2WOGNNMiT
         c0US69Wh+InlNEv9Jl02PKSp0KfJrgoF+Kl4BFUv+UiHt8TS9vDhJYgfCOFtdtnHhUZf
         EVWucxLHPI2siwzAR3pu/zOfjsKuU4DMrrG8JqBQEa1kELP2/nQ6YKD/551eae1aoRE0
         qBhqfIUPi4dez3RAjnpTvvQTVrUWsBJUqrldn1F8Yz4ys4ISHBeMmcFPM7Q1drd1Mt+g
         lpAw==
X-Gm-Message-State: AOJu0YyJ4MAMx2KPmCYVzvbUUgMeCqtrunRYNc7SeILEKeeJglcPe7iq
	NLKC01dOpjX4x4occsd0GbqSjIOoryzZziUEIECCAMaFkN+7mOnFaTO22jLdAGgMhN8=
X-Gm-Gg: ASbGncs7jHQn5iNB4LSQQ23wYfduFiek63jL1nwIizQCrgjC1ryIUEp7A3B0ifODUSh
	S9xRa+WOskhqy+fxX7vOpvsu1Yz4GptTZEr+XAhro//nATfZok5joYQH2gkn5r/BseUHpiCDdPK
	QwAg/yppS9Zq/NQX9FvbABRLTFrMjbkRO4tqSMBQNMKCw2P1Rx6y+Z26kplWY83Ww7b9k4zs2IW
	3bmG+77Qs9ZUpt/sFoZq+AxNIbL7TCPV1fYGYhTXVJRycBZqXG4eHTd8PYFlrra/Lw4NES/6zeA
	oT85Dhelx1bQThaPm51yeNu6thzitxp1S2frJa80FUI/Da2oaKcyOIP92+jozsXUDDp3ydWALe2
	9E/kB4kkqlO3hTnk5Bv1uiE3cmJvuKe3NkLnzFRXVO2P/NHlZbVrS3rtUUlYj0rUIV2LePRnZ/N
	N5UERk9TmP95chLUwNJfqorYwCmoTiMH1TIysxsV4=
X-Google-Smtp-Source: AGHT+IHiAgL+85bQrbLUWP6kRl3QLnHWtfvpTTIhJ9wZpykN8vvdTTtWA6XQwY9854VckvY3UZzFDA==
X-Received: by 2002:a05:6000:1a8d:b0:428:3be9:b465 with SMTP id ffacd0b85a97d-4283be9b5bbmr643706f8f.51.1760761566514;
        Fri, 17 Oct 2025 21:26:06 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff39437sm1297678b3a.27.2025.10.17.21.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 21:26:05 -0700 (PDT)
Message-ID: <edfa6dd0-5cd5-4763-8be5-ffbd855a0ee3@suse.com>
Date: Sat, 18 Oct 2025 14:56:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] btrfs: scrub: enhance freezing and signal handling
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1760607566.git.wqu@suse.com>
 <20251018041654.1144286-1-safinaskar@gmail.com>
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
In-Reply-To: <20251018041654.1144286-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/18 14:46, Askar Safin 写道:
> Also, please, add "Fixes" and cc stable to these patches. They should be
> backported to stable.
> 

Unfortunately it's not a fix, but a behavior change.
Previously we put priority beyond pm, but not anymore.

So no backport to stable.

