Return-Path: <linux-btrfs+bounces-21265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIpPNOSOfmm4agIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21265-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 00:23:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E3C4534
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 00:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55E4C30193B3
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 23:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24A938B7CE;
	Sat, 31 Jan 2026 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBrgdyiE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073992F3624
	for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769901791; cv=none; b=mi1I30+zHDhJCCPgUQObsXwDfAcgOVLKd1Htmu105LWrPkcLntRSnpeC11JBM27sRMMCyw7harSoMds8uOSGrSJcD8fMiC/SS5MxNp1xpzjtUuTbdkpjZDci0xZnGLsHYiW2hT8fK9V+9DC+U/wHAHRIrZQHxBC+IENnjIWYz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769901791; c=relaxed/simple;
	bh=vDsnU2x0CZEhfPxslXsANrVY4khVb45H4Spc+iE5rqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReUZZN+Akc+MvVQTPlhcg6D7rXeFLwMJMyZYze8wjkgt9fQhTIy8ylpbkm3oSWjqspr/pkO8lwV/N4ka2gRvYGtrBGq004nNey8SYsJ0vKSvgaWrfRCuvyZSAKJz61ICgi5Pj5XlEJWJObsM+B8R7gZ+F+Mr/hJlyTtvxSLpmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBrgdyiE; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b70abe3417so7555430eec.0
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 15:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769901788; x=1770506588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odLopdMOFuzazlxMO/Jvqpu3SpD1lqSt4vEe+VI2wxE=;
        b=hBrgdyiEo1bR0a+j3rJEkbY4wgKrWbkB1duJAopz9OGB1abf3DkekGuy8a2BQDQZCV
         MvVUe2jNjzFK67C1E+FmpJTVNJaql7mrznXLhvZO7YKLGnfKEp6QLUJpW/z/p/hWv1CN
         z9AbNm56Vn/nEU8H6tfqnKiO9dBuW9ItOLxlb8s5+5TPynwEzCs9UzQAiT/RPO5ABLka
         k7b+hB1T+WsTryoqJft8xfniMLZZ69jaZoKAEX+92p5NaenJNT2etT0OUiIn0xOPDTVW
         lbH8nW059chm7JZHME39FQoJogweePGlAnhE5coyWs5NgAnf+Kr4rSIp2FMRBizCH0/I
         2ekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769901788; x=1770506588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odLopdMOFuzazlxMO/Jvqpu3SpD1lqSt4vEe+VI2wxE=;
        b=NeEy99yl2E07ZRBzq1WRQQ/7Z8DPURKv1tl+iU7PeRYqVswP8RfSZU4kkkRfJMCp1c
         cOla4jnCcaJyE/Nl/11FGQ5WUMO2R2WtQR8DZNIB1iTlI9D6B+OdTttLchLKBTxrk18w
         Iih/jjMY+3BaZtE2T0DIfnJZevJffwRH+wP6sLQZCMNBmj+D9fKjOCYku1rcFhAnlr8r
         r6w/k8VJYTGAcKofZqOWUc5QOHcs0Jo85l0K+EPxgu3dmpIv9uoCL3DS/dmkfOXY61BX
         SBftxDI67AlzaMgJjnJaMlwtRz21IQ/C6PKMi5tjJpy0f1PSvDdS5dt8o6jt0Prb3T6j
         Xqmw==
X-Gm-Message-State: AOJu0YxSW+sLdZkXn37/n0fQYqfOecTsvcXFcw1U9J9xWmj7BrlCGUfl
	VwvRDUHjU5cbqwqh7zViopazGD/I8pS4Ut43xGxubl5maRkutbuJHXVQ
X-Gm-Gg: AZuq6aIpRtPTXOsTymyO+qgrTDPt7EmsnmOLbQ4QJ4lBVLlqzcPQJD+TGkAD1QzYZJo
	z2nXnYsIzBo4jOUMKUgeP1+PHc2TcBxeScwy2LQvD3qqnj/2I3mlnUKtQDPBLwLwIGGbHOSKIyX
	q/SC2gKslxZplHKvgXuLUjoHjcJbfXVY5uf4OPATz7xrRG272e9yWdtghDHmR+b6YBMptIDrHH1
	QT5yngR+UqQXYYBMM2YcCqZv1kCftS6APkTTqBiSjIwuFkZEEhpC9cmwvwFNGflb69tdBtaTz9t
	W/Dl1t868iNdppI67DnTWCVYcoRjgCnaXtN4oMmGTiH7lssqmgv9K2N2/w+OlMxlHgiK4WHTRwn
	tUh4DwFPdGBwZKIMZdkGSdEgtAK2n9fzBEkZyg1Z8fVXX1N8gh0IjFVCeXyMIZpwP6/V3ja+cJp
	K5RH5aVpR24T17ZS/GObP1
X-Received: by 2002:a05:7300:cd8d:b0:2b7:f7f:6ad with SMTP id 5a478bee46e88-2b7c88e2b66mr3514159eec.26.1769901787970;
        Sat, 31 Jan 2026 15:23:07 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16d01c4sm16774899eec.2.2026.01.31.15.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 15:23:07 -0800 (PST)
Message-ID: <fe31cf8b-ac19-4bb4-9cce-d6f2b2996246@gmail.com>
Date: Sat, 31 Jan 2026 15:23:06 -0800
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
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <4c37d4e1-e656-48e3-ac80-83c09fe92625@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-21265-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 519E3C4534
X-Rspamd-Action: no action

On 1/31/26 1:08 PM, Qu Wenruo wrote:
> 
> 
> 在 2026/2/1 05:23, JP Kobryn 写道:
>> Users of filemap_lock_folio() need to guard against the situation where
>> release_folio() has been invoked during reclaim but the folio was
>> ultimately not removed from the page cache. This patch covers one 
>> location
>> that was overlooked. Affected code has changed as of 6.17, so this 
>> patch is
>> only targeting stable trees prior.
>>
>> After acquiring the folio, use set_folio_extent_mapped() to ensure the
>> folio private state is valid. This is especially important in the subpage
>> case, where the private field is an allocated struct containing bitmap 
>> and
>> lock data.
>>
>> Without this protection, the race below is possible:
>>
>> [mm] page cache reclaim path        [fs] relocation in subpage mode
>> shrink_folio_list()
>>    folio_trylock() /* lock acquired */
>>    filemap_release_folio()
>>      mapping->a_ops->release_folio()
>>        btrfs_release_folio()
>>          __btrfs_release_folio()
>>            clear_folio_extent_mapped()
>>              btrfs_detach_folio_state()
>>                bfs = folio_detach_private(folio)
>>                btrfs_free_folio_state(folio)
>>                  kfree(bfs) /* point A */
>>
>>                                     prealloc_file_extent_cluster()
>>                                       filemap_lock_folio()
>>                                         folio_try_get() /* inc 
>> refcount */
>>                                         folio_lock() /* wait for lock */
>>
>>    if (...)
>>      ...
>>    else if (!mapping || !__remove_mapping(..))
>>      /*
>>       * __remove_mapping() returns zero when
>>       * folio_ref_freeze(folio, refcount) fails /* point B */
>>       */
>>      goto keep_locked /* folio remains in cache */
>>
>> keep_locked:
>>    folio_unlock(folio) /* lock released */
>>
>>                                     /* lock acquired */
>>                                     btrfs_subpage_clear_updodate()
>>                                       bfs = folio->priv /* use-after- 
>> free */
> 
> This patch itself and the root cause look good to me.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 

Much appreciated :)

>>
>> This patch is intended as a minimal fix for backporting to affected
>> kernels. As of 6.17, a commit [0] replaced the vulnerable
>> filemap_lock_folio() + btrfs_subpage_clear_uptodate() sequence with
>> filemap_invalidate_inode() avoiding the race entirely. That commit was 
>> part
>> of a series with a different goal of preparing for large folio support so
>> backporting may not be straight forward.
> 
> However I'm not sure if stable tree even accepts non-upstreamed patches.
> 
> Thus the stable maintainer may ask you the same question as I did 
> before, why not backport the upstream commit 4e346baee95f?

That commit relies on filemap_invalidate_folio() which was introduced in
6.10 so it would not apply to earlier stable branches.

We need to fix as far back as 5.15 so I can send one additional patch to
cover stable trees 5.15 to 6.6. The patch would be almost identical,
with the only change being using the page API instead of the folio API
(set_folio_extent_mapped() -> set_page_extent_mapped()). Let me know if
you're in agreement and I can send the extra patch.

> 
> If it's lacking the reason why it's a bug fix, I believe you can modify 
> the commit message to include the analyze and the fixes tag.
> 
> 
> I'm also curious to learn the proper way for such situation.

It's new to me as well. For reference, there are some commits on the
list that have language like this: "This is a stable-only fix".

