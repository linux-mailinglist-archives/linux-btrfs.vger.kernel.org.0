Return-Path: <linux-btrfs+bounces-21267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMlsB5jXfmklfgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21267-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 05:33:28 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C7DC4E91
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 05:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB9363015D11
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Feb 2026 04:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE52D8376;
	Sun,  1 Feb 2026 04:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCTVKglk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB725748F
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Feb 2026 04:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769920403; cv=none; b=hRm3jmuvsjXHTHWvB+8DnKkuoMNt1F5Nm8c5DqiXZl2EcPdQb+JqUGueKe79+RsLKhtiC5acn90LluNfoGt0zZU8d/FGbhEz1TzuT0mRMGRQaaR113FT2GRkZuzr/NztCqPGtnm/hXn8Mop5hk1bsp0g4PGH/xsU6l1optuTOf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769920403; c=relaxed/simple;
	bh=pYJ9S4ouEUfVExjHTvplH+HhBz4WHsyWZE2qN94CK/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xp0JQbcmExHqhikIomqNpxaPF80w4i8ijqU9rhocdecUro4hEKxG/31hK6WxGrYmmMIF41gjOVh/GjSFxB18PWgEf4Aru6bNGyeCzkNlkdbAq5wC5avusL6h16Gw3/mYgdwgeYElio9KlNPmxa5i6ZZkfLyBxop0htVffOkxczM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCTVKglk; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1248d27f2b9so4503643c88.0
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 20:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769920401; x=1770525201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4FGWPb9KM6ysaOCeh4W7k0WYOCfJBxvkmeobjGRz7Wk=;
        b=kCTVKglktvhmza32A1ROVrPPRBDGQrNZsc1QLgtVlM1JTcHe0YVqRCA9DXoRVZItOt
         KQ8qIBRRLZNUvm/LuzSXLRY/M08SqlWCbdge+EYtCu8sep13Md5AnOeTJ1231gZxik/v
         Wuv7+dpB4SJVMFkf2TN14Rgd12qO1QOyP3jcR9eycHQyPGOLXrjC5AHK8HIUWfREhYQ7
         5lA2MfaFtKp1ruZQX0jkXAno4OAJCUPLGCPKwNdCxFQTQGjqXnm500HRzWtFlbV2MtW6
         mYBBKq4aNb6nxdxPd/UKDMxOS2Xe6taK+n/kSz5O47ybd7rqNhy1FJyUWFRp7BOBXdxH
         uUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769920401; x=1770525201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FGWPb9KM6ysaOCeh4W7k0WYOCfJBxvkmeobjGRz7Wk=;
        b=xA5U2EZpmQDkWM4Pl6GIfQ73sja5pLVOqdJOyePioNAD9N/PDyIcAwq3kU0zqQ4UjV
         1X1GxQGx2jFf3hcgVJRc8Hbj06MpkSzFFFPQ8tbwmr0nvBdcn7tyQ39ManvfPUjPDJ/v
         K/M4La91H0kdbT5AIAwc/yV9ak7ElyAhbgurSYyQAXO93kVkQQOy/qaOmPKu3h1yP7oY
         opOyN0gw0xzUFslVaK8VuQb2wngsizMPxj8efL3K5WZCDCR+RdjO4KFg9uOWLPCzlnqQ
         MpqnvJEXCDzB8ZXqNbcu/FGpyHSTU5nrP9XicAwsPcuUfIRqIXuBWv76NDTea3pRZMQq
         YXaQ==
X-Gm-Message-State: AOJu0Yzq4PANIfpYjPzZiBv72ZRtogwcogU4UCZiK2ZvX2nFjMlJRnZ3
	rLzN/JGlZhiEssf69A6odIaptg13e6/3m02VZja3XOOribzMhT55SYuG
X-Gm-Gg: AZuq6aIN2Qzy8QxWBCROkMsjoWCaQdgE7ENNWMXSSvILlWIukbRAWxv+7o74IPejEB6
	pYR96eKtq0jzNUUH1AvG/yqJAJuZVRdmpy5OlUq5qwCvTxhrgJRyRIkEane2bYwb1yIriGEZ/v8
	CdMH8B/Nq0bx2Wt4Br6N6LkM+JwhBxNiUGvptrVMTWOU6ZNnl5g/aRAOvnLAZLG3ORf/XRHOJmj
	1LKvptnL62nZJk/Ig5o6L9Ix2uJUmT6sDAKLqCHBm05wFJ/s0TuEPiNvnMUO0OC+24ec2ipiKy6
	xemDPfi673h8TDfQ7FqlR+SOaAgyuMUntGIwLwm6MDShzgwUrsscqWp/UevQ12kFGXrKYqYvTVe
	asxCjujctsKQYyHrqdcsF2uSn3r/iMSYaw1sg6q+hvsUNOC6Y5hkmwJ9r8+t3G2tW7+Wzoaa6CM
	LsKtFXvigvTrfhAF2yFxbPgcnM1j3N4y8=
X-Received: by 2002:a05:7022:128c:b0:124:65f7:2c2e with SMTP id a92af1059eb24-125c1019b4fmr3272381c88.43.1769920400849;
        Sat, 31 Jan 2026 20:33:20 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d6b663sm15306235c88.1.2026.01.31.20.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 20:33:20 -0800 (PST)
Message-ID: <61b5f5fd-ed50-40b3-af32-159106f0af7c@gmail.com>
Date: Sat, 31 Jan 2026 20:33:18 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12] btrfs: prevent use-after-free
 prealloc_file_extent_cluster()
To: Qu Wenruo <wqu@suse.com>, boris@bur.io, clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260131185335.72204-1-inwardvessel@gmail.com>
 <4c37d4e1-e656-48e3-ac80-83c09fe92625@suse.com>
 <fe31cf8b-ac19-4bb4-9cce-d6f2b2996246@gmail.com>
 <0932845c-0ece-4d48-a0d5-4b8de7c301a6@suse.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <0932845c-0ece-4d48-a0d5-4b8de7c301a6@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-21267-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87C7DC4E91
X-Rspamd-Action: no action

On 1/31/26 3:32 PM, Qu Wenruo wrote:
> 
> 
> 在 2026/2/1 09:53, JP Kobryn 写道:
>> On 1/31/26 1:08 PM, Qu Wenruo wrote:
>>>
>>>
>>> 在 2026/2/1 05:23, JP Kobryn 写道:
>>>> Users of filemap_lock_folio() need to guard against the situation where
>>>> release_folio() has been invoked during reclaim but the folio was
>>>> ultimately not removed from the page cache. This patch covers one 
>>>> location
>>>> that was overlooked. Affected code has changed as of 6.17, so this 
>>>> patch is
>>>> only targeting stable trees prior.
>>>>
>>>> After acquiring the folio, use set_folio_extent_mapped() to ensure the
>>>> folio private state is valid. This is especially important in the 
>>>> subpage
>>>> case, where the private field is an allocated struct containing 
>>>> bitmap and
>>>> lock data.
>>>>
>>>> Without this protection, the race below is possible:
>>>>
>>>> [mm] page cache reclaim path        [fs] relocation in subpage mode
>>>> shrink_folio_list()
>>>>    folio_trylock() /* lock acquired */
>>>>    filemap_release_folio()
>>>>      mapping->a_ops->release_folio()
>>>>        btrfs_release_folio()
>>>>          __btrfs_release_folio()
>>>>            clear_folio_extent_mapped()
>>>>              btrfs_detach_folio_state()
>>>>                bfs = folio_detach_private(folio)
>>>>                btrfs_free_folio_state(folio)
>>>>                  kfree(bfs) /* point A */
>>>>
>>>>                                     prealloc_file_extent_cluster()
>>>>                                       filemap_lock_folio()
>>>>                                         folio_try_get() /* inc 
>>>> refcount */
>>>>                                         folio_lock() /* wait for 
>>>> lock */
>>>>
>>>>    if (...)
>>>>      ...
>>>>    else if (!mapping || !__remove_mapping(..))
>>>>      /*
>>>>       * __remove_mapping() returns zero when
>>>>       * folio_ref_freeze(folio, refcount) fails /* point B */
>>>>       */
>>>>      goto keep_locked /* folio remains in cache */
>>>>
>>>> keep_locked:
>>>>    folio_unlock(folio) /* lock released */
>>>>
>>>>                                     /* lock acquired */
>>>>                                     btrfs_subpage_clear_updodate()
>>>>                                       bfs = folio->priv /* use- 
>>>> after- free */
>>>
>>> This patch itself and the root cause look good to me.
>>>
>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>>
>>
>> Much appreciated :)
>>
>>>>
>>>> This patch is intended as a minimal fix for backporting to affected
>>>> kernels. As of 6.17, a commit [0] replaced the vulnerable
>>>> filemap_lock_folio() + btrfs_subpage_clear_uptodate() sequence with
>>>> filemap_invalidate_inode() avoiding the race entirely. That commit 
>>>> was part
>>>> of a series with a different goal of preparing for large folio 
>>>> support so
>>>> backporting may not be straight forward.
>>>
>>> However I'm not sure if stable tree even accepts non-upstreamed patches.
>>>
>>> Thus the stable maintainer may ask you the same question as I did 
>>> before, why not backport the upstream commit 4e346baee95f?
>>
>> That commit relies on filemap_invalidate_folio() which was introduced in
>> 6.10 so it would not apply to earlier stable branches.
>>
>> We need to fix as far back as 5.15 so I can send one additional patch to
>> cover stable trees 5.15 to 6.6. The patch would be almost identical,
>> with the only change being using the page API instead of the folio API
>> (set_folio_extent_mapped() -> set_page_extent_mapped()). Let me know if
>> you're in agreement and I can send the extra patch.
> 
> If stable chooses to go this path, I'm totally fine with similar backports.
> 

Great. Let me resend this patch and the additional one with the proper
stable tags showing the specific kernel versions each apply to.

