Return-Path: <linux-btrfs+bounces-22089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK0JO5Aoomn60QQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22089-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 00:28:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5679A1BEFE9
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 00:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBFD130E6C8B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 23:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B303ECBD1;
	Fri, 27 Feb 2026 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cnn64kn8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F236D507
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772234881; cv=none; b=soeGVcWpELn3ro4UgN4G4JyrxkcU/DljdBPXlcr12g8RYe2Him/tVYi3tJEg33YpbGQYUjFDwP9KyIPexiuGCH1fEbE3Wx1SoRNjboF1ZGfA23ZPogFwjSD5b00/b7wi2V04l4EMHaqlvmzIimlIw/HCoKuYH+phVGe3SsVNnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772234881; c=relaxed/simple;
	bh=x6a9/T/8KUsonOtUFp4gCTDN5STRZkJWj7O158p6guA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuO5HEBDKhLZh3bZXNGn5bp+VGonfCF2fR2+jKGzvQRumRC4Uaf5db59B0TlYa49GwrDYwj3s7YOuaqtRTjMCPgYXFBZNFtyiiHxS03hDAhoNopKF/cK1N9FjkLN6vL7/UWHxn5dM8ZNBj6qbbK0QZ1UkaoQ2S+nVW/fs+MSbw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cnn64kn8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3591cc98871so1117735a91.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 15:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772234880; x=1772839680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6a9/T/8KUsonOtUFp4gCTDN5STRZkJWj7O158p6guA=;
        b=Cnn64kn8qtTxu+QLGBBBIJKEZljbDN39CK5X50p9+tsK3iYoEgMxQ+2kv79ZIQpJIT
         cuvowZaxkOOKAPF7omfNqaIL78pCo9bcrZLNfat1x+rCl+2nCxKnQ9jUK93zPguxYJVc
         FnqoXP6sRNsysdM1HNbIY9QMAF3eiXwB55xhCcowWvciBocrYhAL/EmsK31IvIayM9r2
         NqhvDnYMzoJ0oMXersJNNd30jUqwp01VMOfhnggfY3jiyp32lbR5jk+ObF5S4dGdBRhD
         G5RLEI4GGFVQBaiVVd4deHxQq4F25fAERbchG+DLghq78g02GWOpvSZoECsjebNQMO/J
         3Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772234880; x=1772839680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6a9/T/8KUsonOtUFp4gCTDN5STRZkJWj7O158p6guA=;
        b=lIeMEGPZBoby0rVUef9m2WADHMsqaIBJCYmHOrv7fsIjGtVoCaWsuVkUoZHmMl+QkP
         1wjXsJ6wHiw+KKFxETOq9v+/xQUK/qiWtlpTUbbnVq9dbWIy61a5xCuxZKHbFVZrB7Qw
         qzsMKBpwSuMKF3iC9IP+wN9kNArzWudfZXtZMnKxSKiXEEE8YnudpGeOq8RHAFTrXUwH
         yzCYeQkrWwy6Hoeae0hbqgxm6l44bRXVgv/bKluohHvnw+0Ra8zPwDk7IEYT1C0ePsR3
         xQeJ1BmrvWOVtUvq9NEABkNfEDK81jhq2Mj86AhZIVYGl8O8P63z2tpBH5aoSsOH7C3h
         mKsA==
X-Gm-Message-State: AOJu0YyXtPxctk7IOkmZmSiny1UvRL9JwLBhlacJVsEoIm+/tcPqaicr
	YoIF0l7x+c6gNXtFA8XhPm1YT+Bu0xkYox5g3QEHBHC+C14/4zk7kDj7
X-Gm-Gg: ATEYQzzZGlv+1a0sYEu/yoblZPSJpwjPlxoXYU/sbjITc6qOGuMx69WerTVKVHJqw3M
	AmocDfCofrsiVLGy4HDrM5ZoSKaHK/pI7/vFP4C/YbLIF+/H7Ip0E25wfkf9DifOgPasoAQPGqB
	UFuIsRBNudMX2zkdSqKPS+rIfGASLMxMc3vIKlOxAWCNEzQMV2d+l/xf8189OMYoYiqxXOk7BYH
	OZC3P2UCu3gkwHEgCVZbrAZet/VaQd7OcINFuP8GSOXsF/PJOvvUwfbzgOyIGR2fzsrT9kC1fz0
	AJADYTbftR5F9cGgkpBn8FRyjllNj0rD4CqB+Kq312Khjbj4mS7E7ocWbBYClLIEFFarmy8/+Bh
	fVAOP+TzxsWm9023+C8rtY8dNvt4eQ4lKVTU3RZBBlAZzbhLHu6WrSB/DGs6E3puVk1yg12eZ3x
	neOKPvgJ1JhrLkTAU1ArxCyfw3AJY=
X-Received: by 2002:a17:90b:524b:b0:354:999f:1b22 with SMTP id 98e67ed59e1d1-35965cf519bmr3283898a91.32.1772234879963;
        Fri, 27 Feb 2026 15:27:59 -0800 (PST)
Received: from [192.168.50.89] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa8016f9sm5453294a12.17.2026.02.27.15.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 15:27:59 -0800 (PST)
Message-ID: <1843362c-1b5c-4b65-a7b9-1f489e6844a2@gmail.com>
Date: Sat, 28 Feb 2026 07:27:56 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: test setting the same received UUID to a lot of
 subvolumes
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <6f697483d00fc7a001f2ce752a545d525cf2929c.1772151075.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <6f697483d00fc7a001f2ce752a545d525cf2929c.1772151075.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8
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
	TAGGED_FROM(0.00)[bounces-22089-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anajainsg@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5679A1BEFE9
X-Rspamd-Action: no action



Looks good to me.

Reviewed-by: Anand Jain <asj@kernel.org>

Anand

