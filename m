Return-Path: <linux-btrfs+bounces-19883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0C2CCE588
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 04:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4D93063871
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 03:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15782C0291;
	Fri, 19 Dec 2025 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TF7lV46/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE81C8626;
	Fri, 19 Dec 2025 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766113913; cv=none; b=aKEtDu3mFIBZUuNCXMU42StUJuzLLDFjQ4NX/nx4+NevSyhAGj8ZCTYH1wgcUGlXtGco0Xh8e5mpNW0qGeP5C44Lfo8h8WJEBurTl3ZFdnlxC1VcrJjYMdsEZYzML3FTdtEP/pGs48scfxvvbJ6HK6wryxZdIJML60MEobH9hK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766113913; c=relaxed/simple;
	bh=MEQsly2cu18s4Ki76S+WVKoodGhzFm4h6If9x/o+dAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTAYtosC/eoWVLiKl1mQs083O10nvbuv5TuUyZPVojCifw7V9ovUemfrud+ihQdjJJj9EGwxiQRXeFsK4DcMpxtvMTxAVoWP5PdYwqnTy/9RRLwFS0qIOjD9nktEqLsI9yQl477WEOGzhG22iJ7Yq39dbRK8fJTXLoWv8Iq87Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TF7lV46/; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1766113870;
	bh=ZwdVqC9k+Aoo/qerX48MrSUXHssew9RgUratRxFKWDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=TF7lV46/E2NNAwKIprCthBBflOUGyh7Nryyr7a19mF6esCW9YpEbi7Ysx5QbvYiLz
	 UXklCLaiPzuZg4CxjfSV3ZoB7L0fRl0+wmkFQct+0OS0l9LIOGvcjEaXG0ubMD1fwN
	 tkArT9ODxPQ7qg34AG5vDLlr6cOGNB+JcxCbRBns=
X-QQ-mid: zesmtpgz8t1766113867t60ee65d5
X-QQ-Originating-IP: rsIbjM5h2eIPBEXu8RtFdpFllTR48Z2nzkrOwOxG5xw=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Dec 2025 11:11:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14539837168322263933
Message-ID: <FE5FE501300F03CD+be7ce18b-7ed9-4284-89af-33ee03272224@uniontech.com>
Date: Fri, 19 Dec 2025 11:11:05 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Fix -Wmaybe-uninitialized warning
To: dsterba@suse.cz
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251218081618.2038279-1-maqianga@uniontech.com>
 <20251218203743.GU3195@twin.jikos.cz>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <20251218203743.GU3195@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NyPaQtJYQgeodf7+yLlPzXbTARi+FjqDYEeXBb8Yi2dV1ID80DCCiaGB
	3G1bca3v5okGtljW3m/8Wgn8vFJFf4R1psaO6sq8CWAceHBAhEEMqEgbZbhwWOOj+mUIbvN
	cbRhKOlWDaI/Fy1LnOIAF66Mr5srVvENpAQeVXDe99K/GCP04iqVlbvEPvhdJGVuqrLcnAN
	3Maenw1ooPWmAPsGEj3+JG7N0u2vNdvkBD8PeBvEhxbvjjsceeFCta5GJnnK6CToPt08DpT
	CG4rIZUl6fpQP8PuoJlA/ewa9P90muCS8YxGgZvsjA065Wytpy0yw0UP772PVIgnflHuK9t
	Y767r+tp2ZHfy/VrJKd49BVwwnqtPmpNLOc225uhGQAzxd8UeMkBkQjiZ7LGvpjCILUx0x3
	FBnrskyAUgo6JPRRvAAmKv15oSRAj6im1ui9SsYZhBeE+bQCaTdwTDLvYVEu5grGKhdEUyZ
	V1lS3BjoqROvqGC4K9r88c4QMwxYODMdJ7fHVhZwrxM4MTKC0sjtwdWsCIPMeY3qgR3j1qq
	mgkFJV+oEUqTOMM2n3BHSi+DDz1phMQFoVyYo64UilRziROxXLdi2s5J3ue/W4Qj6rJMGgw
	ad3SIrSxYZx69ijJavjj4UgJ34GWOSiTHvWjaJpdW/0p2KKNllsuy3U0AKFvR7YGJT2eH0K
	lxZNzg+rkyHByUkB6YDOPuoj51u993pSxlOcmAGL/s2zZ9k6LUfwjXLEuPiDjfzwNhaVDHQ
	R8WVFXOqISEk1IvwJaMdvADkVLYqd2eAMWzwVnGIj+PmXEyEonmWIMYOXZDgcSyxGw7fTEQ
	NeDxUhZ5Tsjo7rIM9Nh7xD9PaoD+mXbbaKUsiITGtIKvnV4rd8a3NXf4w5f1R3EE3so4rzQ
	lglA0jmILpo0HnvktvrR4WihlgV2YbOKgp1LdBCoeV63x8m0fHuMYdjlncYFWA+7J0TNYxe
	ThDdY6kv5ntlmYR/s2I8S/DNSmbY9hZkPg+zuuLOUE2nvoM0h3XBjjc2EEgDbiJQcGiZ40p
	WYVKRc6w==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0


在 2025/12/19 04:37, David Sterba 写道:
> On Thu, Dec 18, 2025 at 04:16:18PM +0800, Qiang Ma wrote:
>> Fix a -Wmaybe-uninitialized warning by initializing
>> the variable to NULL.
>>
>> $ make CFLAGS_tree-log.o=-Wmaybe-uninitialized
>>
>> In file included from fs/btrfs/ctree.h:21,
>>                   from fs/btrfs/tree-log.c:12:
>> fs/btrfs/accessors.h: In function 'replay_one_buffer':
>> fs/btrfs/accessors.h:66:16: warning: 'inode_item' may be used uninitialized [-Wmaybe-uninitialized]
>>     66 |         return btrfs_get_##bits(eb, s, offsetof(type, member));         \
>>        |                ^~~~~~~~~~
>> fs/btrfs/tree-log.c:2803:42: note: 'inode_item' declared here
>>   2803 |                 struct btrfs_inode_item *inode_item;
>>        |                                          ^~~~~~~~~~
>>
>> Warning was found when compiling using loongarch64-gcc 12.3.1.
> We have the -Wmaybe-uninitialized warning enabled per fs/btrfs/
> directory, there are no other known reports fixing the uninitialized
> inode_item so this might be specific to loongarch gcc 12.x. I'll add the
Yes, x86 and arm64 did not report this warning issue.
> patch to for-next as we still want to get all the warnings fixed, thanks.
>


