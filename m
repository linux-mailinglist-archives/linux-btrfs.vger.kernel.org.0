Return-Path: <linux-btrfs+bounces-21256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OAhFqBbfWm/RgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21256-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 02:32:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF55EC003F
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 02:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A104302DB6A
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 01:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEF7325713;
	Sat, 31 Jan 2026 01:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5v7s4RF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18D1F8AC5
	for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823109; cv=none; b=kszLRqpL0wo0/5LQVz0oXyRjFRLHSW0KRk9VdI4nBGBquRzQHW8IvfdUt/KB6MbwHU1x2Yn4UADimV8FuXgbgtN2TGFvbJM6RZC+zjt5IAo8G4UkiKmTP9YdzNxsiBjJ7GRe1dTFDR/HM9whqVollcsZNvg/PDp9O2Y4jRpxafQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823109; c=relaxed/simple;
	bh=uxSptuxlUKEWbRT4Igc31bABpRpRKBUi1VOuQjhIz3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLy9NO+rbmDqfHY9Hbq50GHwacciQtrB/s35aym3huz/ytvo+MjNd2sqCHKyKqGIKUT2jOu7FymvKuV8X4QLnvKj57vAm7Pk709MXCTI9mCmOC7ZcLac3GodwWpz8SYgvDuHsikRrvuYIvd/Rhlb+hF1I4AI3AbzCFU6ENvPdFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5v7s4RF; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1248d27f293so4210400c88.0
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 17:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769823107; x=1770427907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MjS5gUmrvNUnt6r0vg+c+3hL04GhprNpFcL6xVhUsws=;
        b=F5v7s4RFW8lc3h8rSc+Bm/hPByCo6FLA6lqBA7e0dL1XIoMeUd5xAbOyKHx2jXvLF1
         07x0uluV1v0S+wDlNCeJ+HoQz9ah9w+a0XJx5O78NraA8zl8CCjU/vWGPaEF01WCU2nq
         2Qlj7CSr8MRKsRKgoqX892Yz1DPTPVNHumprNcNWbLFXSZRhCYl09ChC7qDy8ASOnblG
         SXvEDeG5isOd97Adi1SH2ybSB/OKzEHEgW35tOoOQazufr26M31q8cVaquZryaJAyaW0
         +UgFrzrn+v232nbYUqGTaAbbkyjjKZkr/RuOUPmOLzBzBD8vexfbPSV+upYuXj0DSGis
         mONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769823107; x=1770427907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjS5gUmrvNUnt6r0vg+c+3hL04GhprNpFcL6xVhUsws=;
        b=aSme8ujmywgfYXxLVSDht3FT21yLgUH33UZ8KsCMzhq8lRSWWQz+XCbqa1G2naSb4S
         NJyRXi3ZLIvyd/KBhREUUkGqmGxEwpBPtCiYnB9s8FLjuZtOrsyKR5qcZIi7kkTkTcyo
         nNuDII1hsb9uXr6ZIXQgpAjbbn3IK4mW/XQt5lq8bJnI04IIlGESRsCB7YYB+chXg7/d
         HjN/jvkpNKhnYIhB1Wfit/GP005iFNYXc3ZnMh/oMugO5kPA/ZjhtY0EhE0Jrv3Y5Qz1
         wDIe9lQ1Fueg0h+RYvZx2E+Ti2u33lHIcCGbmByXUfLEpJUexLjRTEfyLraFB0mVQyLQ
         Ebfg==
X-Forwarded-Encrypted: i=1; AJvYcCWuFMakkscxMXUUg0lnd2hY2NE50LxkkNDFSGdzp6QW+y5+yPhTD/QO2V2IKZsIy2cPy00JiEreTB40Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YysmUxEBU6k4qMODUKc3SKhpa+G0D7vTPICKxhJCJAvHgc2jsIS
	nWoWzecpK1VObCrdv/vLO+2jk2JmLhb9TubFf620Ev/0yCwQrbiJPZmQ
X-Gm-Gg: AZuq6aKw+F0UvgUlJN22WRkZoS4I2n2YyHLto7siiD3B1TOl14vrKKJNhCpgtcX52F8
	neCkxyAo2rRW2B+Ht/ZubT5nUeefnutrsXuAfhIIFZt6y7xItOfGBtBgr0sXjNOYpHLujL6jo6t
	wDsFKLZBCS6LXsCD5H7SoWWj611x0VD9mZUkpLqywoGkRFJ4lE3ZTWMNZ6RV/zkud4wjy0xuhk0
	zv0on6Hn+9EvAR0i0vp8i3//NUd0qY3iiWM/KhsmO8m4KniUONkUjxryzUdhKncXBuGEsigQXRT
	qGAqT4t3jtdov3WGHAmexqIqKYlKDoV5HDmRGDSM0srCjBYHXTQfjbyhftnkyLG3kP91Dc3qiYA
	s3AwYrYfT2FI3Tt0SAXt551Up8bZHxl2/6scdWp9TdZpaMli5slH3c4L65A1NquGaJn3574iPzF
	nzf4c6s/ehYSWfP8r+pyLiwqw=
X-Received: by 2002:a05:7022:2488:b0:119:e56b:c762 with SMTP id a92af1059eb24-125c1014ed5mr2266211c88.39.1769823106769;
        Fri, 30 Jan 2026 17:31:46 -0800 (PST)
Received: from [172.25.67.25] ([172.59.130.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9e0304bsm12535789c88.14.2026.01.30.17.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 17:31:46 -0800 (PST)
Message-ID: <96d01e75-337b-45cf-9950-e5d4a2981921@gmail.com>
Date: Fri, 30 Jan 2026 17:31:39 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] btrfs: defer freeing of subpage private state to
 free_folio
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Matthew Wilcox <willy@infradead.org>
Cc: boris@bur.io, clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260129230822.168034-1-inwardvessel@gmail.com>
 <776e54f6-c9b7-4b22-bde5-561dc65c9be7@gmx.com>
 <aXw-MiQWyYtZ3brh@casper.infradead.org>
 <00d098da-0d01-43f9-9efb-c18b6e8a771e@gmail.com>
 <ee4898be-b0e0-4163-b734-c2891239dce6@gmx.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <ee4898be-b0e0-4163-b734-c2891239dce6@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21256-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmx.com,infradead.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF55EC003F
X-Rspamd-Action: no action

On 1/30/26 12:36 PM, Qu Wenruo wrote:
> 
> 
> 在 2026/1/31 03:40, JP Kobryn 写道:
>> On 1/29/26 9:14 PM, Matthew Wilcox wrote:
>>> On Fri, Jan 30, 2026 at 01:46:59PM +1030, Qu Wenruo wrote:
>>>> Another question is, why only two fses (nfs for dir inode, and 
>>>> orangefs) are
>>>> utilizing the free_folio() callback.
>>>
>>> Alas, secretmem and guest_memfd are also using it.  Nevertheless, I'm
>>> not a fan of this interface existing, and would prefer to not introduce
>>> new users.  Like launder_folio, which btrfs has also mistakenly used.
>>>
>>
>> The part that felt concerning is how the private state is lost. If
>> release_folio() frees this state but the folio persists in the cache,
>> users of the folio afterward have to recreate the state. Is that the
>> expectation on how filesystems should handle this situation?
> 
> I believe that's the case.
> 
> Just like what we did in btrfs_do_readpage() and prepare_one_folio().
> 
> There is no difference between getting a new page and a page that is 
> released but not removed from the filemap.
> 
>>
>> In the case of the existing btrfs code, when the state is recreated (in
>> subpage mode), the bitmap data and lock states are all zeroed.
> 
> That's expected.
> 

Thanks all for the feedback. I get it now that we should treat it like a
fresh folio where applicable. With that said, I may have found a path
where unguarded access to the private field is happening. I'll send a
patch shortly and you can let me know your thoughts.


