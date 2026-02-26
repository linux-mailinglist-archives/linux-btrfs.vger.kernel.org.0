Return-Path: <linux-btrfs+bounces-21950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFCmAnD/n2n3fAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21950-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 09:08:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EACE1A2497
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 09:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ED1130B078C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A553939BA;
	Thu, 26 Feb 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlOisk2F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA6E3939D9
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772093025; cv=none; b=g8nHa+RhhhTGXkZ560g0t4c86/b/RAAuNtnOGpqsYl6pcG91MjjEYTS9pITZUBBZc29OENPEhF+Tic94LAv/LAM8VArIpXmC7rRwnnZ2lejkFYnB7KZZf22lc2U0F5vxlsTUmRVWghiUl7eHUH6jrPjK3jT5XUiKpFjo332/GLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772093025; c=relaxed/simple;
	bh=in6bjF0gy9Uiywrn9jC8PiToPtCQCXe6d6Pt9RXYNzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMB8OunuC7rN0/m4Ip3fW2mi3Hz3IX8DZu1c5gaU98v71nJpKCv6dAvpLR/FNiXVYVsopthqOXha3XoqQxcRCtxY2dJax7IcNcTjLLFqbca6/c/y1P1DS8kfSu6rRVVP+Edhr78U5yebz1DKjji5DlVmwmSSbNcpMvycge9ayT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlOisk2F; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2ab1c8fdc40so440445ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 00:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772093024; x=1772697824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0rhPXuKM7CNi0BURp/kAFDDGuS6zd4p22LHyRh3E/A=;
        b=JlOisk2FWmqA9H25PmUcrteBCq+xCW5A1rN3ZM3V4UCMshfN1XV2HPjy+J3Oj/dkWj
         AuxJfPqZJ4PDv3jZEVoUAtg6V6iRY6KOU7PIpi7UrGbpGWqdpnfJqm6xNikn3YDdOUEX
         sDydW8UnQpF4pZCWfLRKpxpz//5UvLLLTLiAVUA1yDoYnaHEgVVFyW5/27WVJ88lgjK9
         SYg9gNfGRca2fJqOj2w2uZRTz5QfcvZjesFCeALK3yXytkVgcGJmkpQFXm1pKLzvlrFL
         M3r6/YphTHIq7FQ+b8Bx/KnUxG5viAuxzE7RS+GzYlZ4/Q1mMhpCDw89zLyXUQp54tAH
         1A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772093024; x=1772697824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0rhPXuKM7CNi0BURp/kAFDDGuS6zd4p22LHyRh3E/A=;
        b=qr9Na/TS53ZhlTamoj7Ff7K6FshvvWL+Zhu+JV/vqgrTB0j3aRfqAFw/OQiJ0Nvh+y
         TYqtsflVuPYa8UgH2wQY6fLqH+TKV32b7a3l+YrA1ajbKGRBpSLYw81VYOPYjST2Vg29
         /rzjNxFZTd1/Se6vw2UDtsJv0ANFFxe30eyhcH82GMECLGuhj4AFwFaGEqX0Km0j8Pmc
         Zn16GY7As4qyk0J1G50JojWT5mt2WKZ52LCe1iboyj9TZSGoOWBk7bi9nMhvlOUpfMMA
         RpPYf9+6UTmjlarWpTpyqFsUEn7iy+OpkVK8BRsXSW+/n8ef2Hi3z7I1k0AV0DKQNJF/
         dhsQ==
X-Gm-Message-State: AOJu0YyUdFX/4NiWFBzw4l1Y0VBPHl4wyjKn9a7TBnzZ6b5rjr9a86Dl
	vSceFa26kjyDxkqESKc6Cb+dOXs1cwsKU3wrmDT5YcZr8QERFBQGO63b
X-Gm-Gg: ATEYQzy0GIgplXaMcW6u/SI2C1TEldQLKVoSUcJxwPvf6xryBOiJUEQP9hrz5aIimz8
	SGTHc4PrH1EXsybRxtEAUfLyLrK/mjaUpV1l7lr/VXc/bvC5Bl4nof3p8JZvqk+/3Q6KKPpLy2I
	45EjAmZ4TKXGPdZaCRlbsVV2Mfw2r29h2+lDjk1rR127QE7KbyzmZadMwLvp+lUlkBzviWrFcza
	KZv+/q+by81AooP7PLe8X9cfWtJEckC8eS4sMwjK3PDuYR17r0IFvdTgq9yZa+geWl5DbyWQDSc
	J9FtIGZCyiMiMpM2D7LL0OG2JP3ro3YxX5+HlcxK6g37zVQ0Lx22tPv7k2myum6b2DX7pDbPa+P
	SpgIRZ/uMzMF3Fs8VylHhG8eiqD5JXZYjOd4uMxanIgqcmebVPD+lLNyRbxEpARhLzDpzChRrOa
	VL6BVjkMaC0rDNnuGXzZ9RPEfqih0rubUmDC0Ab7HAIw==
X-Received: by 2002:a17:903:2ac5:b0:2aa:d04b:73ac with SMTP id d9443c01a7336-2ad743d07f6mr143105975ad.1.1772093023592;
        Thu, 26 Feb 2026 00:03:43 -0800 (PST)
Received: from [192.168.110.223] ([103.173.155.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f277sm21176805ad.55.2026.02.26.00.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 00:03:43 -0800 (PST)
Message-ID: <a03f92b4-354a-4225-835f-124d34e75900@gmail.com>
Date: Thu, 26 Feb 2026 16:03:35 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: hold space_info->lock when clearing periodic
 reclaim ready
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@meta.com>
References: <20260209130248.29418-1-sunk67188@gmail.com>
 <20260224170653.GZ26902@twin.jikos.cz>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <20260224170653.GZ26902@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21950-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 7EACE1A2497
X-Rspamd-Action: no action



On 2026/2/25 01:06, David Sterba wrote:
> On Mon, Feb 09, 2026 at 08:53:39PM +0800, Sun YangKai wrote:
>> btrfs_set_periodic_reclaim_ready() requires space_info->lock to be held,
>> as enforced by lockdep_assert_held(). However, btrfs_reclaim_sweep() was
>> calling it after do_reclaim_sweep() returns, at which point
>> space_info->lock is no longer held.
>>
>> Fix this by explicitly acquiring space_info->lock before clearing the
>> periodic reclaim ready flag in btrfs_reclaim_sweep().
>>
>> Fixes: 19eff93dc738 ("btrfs: fix periodic reclaim condition")
>> Reported-by: Chris Mason <clm@meta.com>
>> Closes: https://lore.kernel.org/linux-btrfs/20260208182556.891815-1-clm@meta.com/
> 
> Please use Link: for the original report unless the tag is known to be
> used for some sort of automation, e.g. what syzbot does.

Got it. Thanks a lot :)
> 
>> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> 
> Added to for-next, thanks.

