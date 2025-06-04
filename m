Return-Path: <linux-btrfs+bounces-14468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9E5ACE64F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 23:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B5A188F863
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 21:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF6122156D;
	Wed,  4 Jun 2025 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b="VcEf4M6G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EAD19F422
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749074090; cv=none; b=cXDk/DCfhW1C6WEaDkbcZ3d/EG/p7OtxsAornU/K2UcnMX6sDq3vds+Ck4cwezKNVMzKgXSrUHcQt4zV1jpf3gtoaN1AsxppC+5Yb997IDLbyES6mD3NzpUedcI4Ft1d+2Zs/UXVNHi+j4j/bdSUBRT/oCOrDiCflYX21kIh8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749074090; c=relaxed/simple;
	bh=NqusDj+UkN34FoYl6p/7dsTE43zbDDAniA/dy4LEh5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ie4wS+GUIUyslrTWktxYISl+ToZ/srGAyvQriWZS66nFrdoe/NIJ2TPwijlNsJXvAo35Vl010yrJ1mrPZwFHVi0BCkMvwBS8JK6CGEEBmpGWD5B6bz/JpTURStslJIfvc+mvb+JJQviaui4kKfuz7TH3W5Gg5o3CtAGjHckKMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com; spf=pass smtp.mailfrom=velocifyer.com; dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b=VcEf4M6G; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=velocifyer.com
Message-ID: <1d6ac208-a08a-47e4-8c9f-9f99bd244146@velocifyer.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velocifyer.com;
	s=key1; t=1749074085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/M8MGbA4akWtThNfJxRXzdjbB0D7gQ9IP/JTJ2CPgro=;
	b=VcEf4M6GU5eW4bSlf2GWMy00oOHrq+23L8EgywRZ0qqagJYVQKIlQmo3r5+FMZQKZwrykS
	VgoSGnl+U9BSusRH/DJcLC/6pBQ0/NR5aCbWtRlwOOINfTFBSJ+Mzz2fVOr3KlmY+7sBbz
	yiupDjD19Lm4KH10DmifZvdJA0r1iZwlkBrVpgPdJp4H22pvUPsTQFkPrac+PWteJXVbT2
	DFzWkh1jJjDAwpimQxwW2LSppEoSovRoKsnu31ptw3W0/aCPUGF3GJQuSwZjq+NmPwXA64
	7LqrtFGXhFxZUTxfhIHg+nM7xEZQjAjzPEGc2gb5HZq7N77L2De9/yLiZAIt8g==
Date: Wed, 4 Jun 2025 17:54:42 -0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Why does defragmenting break reflinks?
To: Ferry Toth <fntoth@gmail.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <9d74d71f-b65d-4f06-adb3-18f7698edb8a@velocifyer.com>
 <b407459f-5c9b-49e8-ab77-07768cb30783@suse.com>
 <3fea5116-8532-4076-a824-620dc4c5a627@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
Autocrypt: addr=velocifyer@velocifyer.com; keydata=
 xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mxaYk/dyrN
 JlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8EExYIADcWIQQboPxL
 gODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEGNO
 v4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78ZqEwGegVCRerWry8RAQC3MJUOiyQ062Ol
 /3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/y
 Xp135G4fhWjJH7VQkPIFo8/MsZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dA
 x0i+BQJoKkSFBQkFo5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9Spvhl
 veEFpUMPaQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ==
Disposition-Notification-To: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa?=
 =?UTF-8?B?8J2Vl/CdlarwnZWW8J2Vow==?= <velocifyer@velocifyer.com>
In-Reply-To: <3fea5116-8532-4076-a824-620dc4c5a627@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/4/25 17:36, Ferry Toth wrote:
> Actually this makes defrag a very dangerous operation on disks with 
> many snapshots (> 20). When you would defrag each snapshot suddenly 
> your 5% full disk would be 100%.

This actualy happend to me once because i forgot i had snapshots.

-- 
George truly, 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣
This email does not constitute a legally binding contract

