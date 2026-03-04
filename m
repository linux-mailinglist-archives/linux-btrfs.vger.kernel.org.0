Return-Path: <linux-btrfs+bounces-22222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDCXEWJBqGn8rgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22222-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 15:27:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2822016E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 15:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4F1324F9F1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 14:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599DD3A875B;
	Wed,  4 Mar 2026 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsZASIBT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794D3A5E67
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633752; cv=none; b=WZCLFBBmHhZYTyIswtfbOrZ5MOPtRVer4/t1YF91J4za2IWpSkgqM+6U0gfMrgraqwEFnvXq67hgGOxmdO1DpR1heWMlCPcTFJaBumHTYaa6OnDLnt/+7/rXoqiLsumgrdn0RDpE0QbNTK2fGwAIeLlhRFQnXfHiKAB8DdU8eZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633752; c=relaxed/simple;
	bh=wnReTIbGoBNjVOFyvAk3qw6qq+Q7yDnBKy75UH83jho=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mVTxy7zHP4gYfhHPaFSXEFNQUFU8uqs++mEqWoGIKFZj40AGstSDtbspwWUexYJw0LjVUeZ9G6DC01pZIZTCKao+d/fvJylafBb1YyXPVfzhpopUyK8U48rmf66X3Ze37OFFjABLAPp7TnZcVZoBmqHKbQzbNU94kLyPxUPMfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsZASIBT; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-40eed9b9737so84539fac.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2026 06:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633750; x=1773238550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZtiOowYUkDPB/UaApFrZZ2mgwfTv25eQUAy9Go/j8Dc=;
        b=RsZASIBTU9r1jkx0mc5WhDcjTScHhePf+VzXAxuzkh4cVQfyOfuZiutRpXwTKsNZAl
         nvcbFGwO0s0Ds1XdDNxvFUC8mpC6skLapdNCKosRYmFc9sX7kpgq7qHKp0KRJ4pGIAS8
         Nmt/KUNICb5eFxlbP4mhz/Jnz1PWgbgkQiBLZXiiwFx5VPE8U/PPupmCmdoPQq10wnZt
         g3VUXiy3LJPK/KBHPhBCxdHzXuzw4Ep4qHjMmJqR8oWwHNbcEthDZw88+7xQgfCQahEP
         plrY0+JEG81/4Z4rgIkliNhZa1cOsl2mYXlmiBdlzqZcBsG7SZRatiZdyfHT29itwNhA
         u54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633750; x=1773238550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtiOowYUkDPB/UaApFrZZ2mgwfTv25eQUAy9Go/j8Dc=;
        b=IzgT0nzUk48RvCKXhaNDJ/sJU1027B2ltdKe7LNU9LR+reNsqaK+zdX6vLikPGcnhu
         TVAEblFsOa60iRJIF6HNhxML9OxretC5ELbsldbxToS+Wpp8T/DtGJeIQY0j9m1zdy9E
         WeBovu5NEhFdu8MH03oxJwKcFHuTS98QZrhvwrKx0OuRTMM6EkROml9RIB/HHFDkko4S
         d1i88/P+3vZlZFgSZfWBhyh5J9xYQcsHNCEQ+D8dPJgyETV3XEDYOSfUcHEvAc/laSj6
         PXtmUWI6Dp7H54XPCI6iKhDY9VqAe/VGJFQtBW/OKjz/PLkwk2Lec3nshkdtpS6LRpIZ
         32dw==
X-Forwarded-Encrypted: i=1; AJvYcCX9s+d7mpUb3Ie/pq6WM1MllpBmnVQQ2P9GAU6Vnsf/GL/npveWqcXk4200U+MuSeJb0g/0A1OGkRRKlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvQbkR7KavvgmGpsskZxQiDUnQsa+75N0Pdm7VfZAeESLwH7ga
	VuYThJShY5iusM+CwCPv1EP1hquoZLc9KOlDPWYSXRmyz996bUM4DRpg
X-Gm-Gg: ATEYQzyaGFTNCCEYipYSSzz+VXkq00MvbtMJJ4Orf/55rnA5cUeHcPE2R5rVmD8IWsq
	FDQ/zgCTp1a6Hmf6PTttgQ2YW4/4Wbm1EpVz3Mu/lEaJIORJCYMD3RtVXPTm5e4iv6oUzqUAMCh
	scJp1g80Cq+oVgB9OBWaBmWCc6yxGNbLjOQbtrPuwdU1rL1ShtGpjuepcrquccErqf9YTnLrM9i
	U+9Uyc4DZ0ntQ4HUl4aAZ5iPkskEnXdnfVT87BbJAo15f2g9XhRGnDBF0QI68VMVYYoLg4Fy6aQ
	rKk9eesu/pyNqkcZO0gt+kP7d2VRmIY3ohH5giR9Q7+T/mOAxSV1XMtm6ZV7uqDk4gPN92Ugv09
	3KVEzDz6viYY+J6sf30tHefgbknPtjRrzAj7p6foyN7ULMde2CZ7PybgDA0ZQUee5dIoiQqIylK
	8yrW8LrHLhN62ocMjv7t4nHL4ivNGeefjsWT4QNw==
X-Received: by 2002:a05:6870:9e99:b0:3e0:de76:31da with SMTP id 586e51a60fabf-416abafb611mr929021fac.4.1772633750225;
        Wed, 04 Mar 2026 06:15:50 -0800 (PST)
Received: from [192.168.1.13] ([103.173.155.177])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf239e0sm18601281fac.1.2026.03.04.06.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 06:15:49 -0800 (PST)
Message-ID: <8738c4c9-d8e2-4085-b68c-fc1adc49dd59@gmail.com>
Date: Wed, 4 Mar 2026 22:15:43 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs: fix periodic reclaim condition - missing patch in stable?
To: torvic9@mailbox.org, "clm@meta.com" <clm@meta.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "dsterba@suse.com" <dsterba@suse.com>
References: <1333479338.178488.1772632448830@app.mailbox.org>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <1333479338.178488.1772632448830@app.mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DB2822016E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-22222-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 2026/3/4 21:54, torvic9@mailbox.org wrote:
> Hello,
> 
> Commit "btrfs: fix periodic reclaim condition" (25ecb24405928d3f5db48029c2237b2c7cefb479) was added to stable,
> however it seems that a subsequent locking fix [1] to that patch was not added, possibly due to a missing stable tag.
> Shouldn't that fix also be included in stable?

Yes, I think that fix should also be included in stable.

Thanks,
Sun YangKai

> Cheers,
> Tor
> 
> [1] https://lore.kernel.org/linux-btrfs/20260209130248.29418-1-sunk67188@gmail.com/


