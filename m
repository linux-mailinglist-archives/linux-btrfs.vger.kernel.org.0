Return-Path: <linux-btrfs+bounces-21246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDpKJxTmfGlDPQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21246-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 18:10:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E4CBCDC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 18:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8392E3035013
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A496F3587D7;
	Fri, 30 Jan 2026 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTCgV0dt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CE352958
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793016; cv=none; b=O+kNu3BiElqUyaTLNV8/rLlB+jtKD6IVWj2QBRltEAWuJKo42ogYb9JTq6v0j1sFpNVpP0xtV8o10DT811YYQBJcFQeLyVrKqjyWZePXMsyYhtANCLSlpxEKAYXXxBcgotXeG62/35q8Dq5edp5+cw1pEswkSyrTtJ9brJzVtoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793016; c=relaxed/simple;
	bh=9Qg6KVzRn8ED/ksxd36hCTObnVpqpAHvaJHihhA84FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krM1A7O4HDqpkf6jWcvLrASN4WpsygDqEk29IMbxxE2pYEAueSG2ja9cLAFRzIR5+TiAPzqILo8qB8KVlOnzKihPnnEbynWhu/mEgkZFrFJiLBPjQR+L1sFHj97EXi7FuuXJ7CQNSEhYc9m2KuNV7cvldaBKWyFyLgYSbX2RAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTCgV0dt; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b70abe3417so5393748eec.0
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 09:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769793014; x=1770397814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEv+1jOdrtgo6ukKhRIPZ07AVihRt5jwSiOESTmd48o=;
        b=eTCgV0dtRtkD4RVHSg87HSyE7M+9hT4PD8hwJ5C76vHkUlRYTJVuvYslwR7jm3Tky9
         XMKoFK+VYeyQnVZGwwnG3GVPjnAaB9XXt7ThMRFavcx92odSCDlMEao3FAtwOlfOQzl/
         9zwcPK2qt4tWvHbGuc1hCOILRKm0l4S25IqoaYEdOI0waJCLVGRCLxk94EpJB1tGx91d
         rkVgZGqg6kRjNguqxCcllOSb7IfEP27n/+YA/aLUlmgqCxnyGgn1boQVR8NoGMpe02PC
         VFWiyHpa1UXh7jePLhmNhHuf03aomfQBxYldc3W0vKuUL8v1z5oB+MdMCM3CvlN5EPx1
         9VYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769793014; x=1770397814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEv+1jOdrtgo6ukKhRIPZ07AVihRt5jwSiOESTmd48o=;
        b=Tzok37g8+j0luzmhqnmz3EsuznB0yfOf2dqFGsQWzfeDEp9PoMNK3FDO9PDE2KjL9+
         VUqJmyImm1kaJGVFGLvGTBydz4O9LonlVYmS9aRCMoqT32sGmwK6LdPFOwcMx+mgWLoA
         NyBXv8pfMNj2czGkzfq0GvIIYgoSgeYXbZz4Ikar1p1U97XlKEI2bx9db5OG7Q1XS1M8
         AjzJCiYDHgkVKnO7PfNkgKcd1PzxgP2DKBJVf3CxnlyaDQOZu3tLOL/vLu282A31fV5H
         kozgxzNT4n4IhOw3b04qaw7FMXjDDIqfns6YGEuqIvSJjfnJXPas8yL+b/7HBWYSlFtI
         31Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVmGxQ97MnT6xMwq22JexPFn3NdSV/SXN7DQ0Wb0RpzOUkUZZoi0TfSYYX9qaNdvm5K+B6i+UHFVUf1jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQvArqmfGFpizTU/VE4QxfjW0wYNEE7DZjZwDCoxdkjnpCFvO
	lrW7CPIV5DhqeusZAmrwBjDBPzBfV3appnkrgKYTHoIMnRJB5zXdxVEw
X-Gm-Gg: AZuq6aIs5AR3UevGqXLnw1J1ZhOScFldEvJ+sUTiBgq/lbiYx4NtJl/XYOQJgbpmGrA
	wdlibnLFeAfRi5vFEkEmZntS2Ho47N8wKla0bzQUgvkmc8vH9lwJSAOGbKdsg1NcIoDEzgI94BR
	6Z+GZvQI9KAwqHmomWkGiWnwuDiBCOCW+OfmXnRy2N5qiP0/JMWqK5zNjkFT4e6rUcPddI/Xh+H
	Ddab/Qn97/pCC/abd+d1O64mGTIvJ67dGtBNlsSgkT6Udl6k0oSpNfk33/LUBviBHxXjsRIbAuk
	JnJdXlhjXDI5rvFRluNba9hFw1HrPh0OqU1UgsrGWHb+NhTxB8tuXOMLLp5jH1JEAbUbuZNwI9P
	U5zTmyOS57pJagbpblZpC0jiaUgAg5qOzSFYQguaaZmj0V8J9nASnLxeJ888p3MawRouhfhgk0s
	qiT2thwXxwlTxEe0zoHYEZlDN+PgzNdA8p/YEbHks0
X-Received: by 2002:a05:7300:434f:b0:2b7:1746:c947 with SMTP id 5a478bee46e88-2b7c86268ebmr1882058eec.6.1769793013515;
        Fri, 30 Jan 2026 09:10:13 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:f2f0:9d80:548:2415? ([2620:10d:c090:500::797a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16eab80sm11714614eec.9.2026.01.30.09.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 09:10:13 -0800 (PST)
Message-ID: <00d098da-0d01-43f9-9efb-c18b6e8a771e@gmail.com>
Date: Fri, 30 Jan 2026 09:10:11 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] btrfs: defer freeing of subpage private state to
 free_folio
To: Matthew Wilcox <willy@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: boris@bur.io, clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260129230822.168034-1-inwardvessel@gmail.com>
 <776e54f6-c9b7-4b22-bde5-561dc65c9be7@gmx.com>
 <aXw-MiQWyYtZ3brh@casper.infradead.org>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <aXw-MiQWyYtZ3brh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21246-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[infradead.org,gmx.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61E4CBCDC4
X-Rspamd-Action: no action

On 1/29/26 9:14 PM, Matthew Wilcox wrote:
> On Fri, Jan 30, 2026 at 01:46:59PM +1030, Qu Wenruo wrote:
>> Another question is, why only two fses (nfs for dir inode, and orangefs) are
>> utilizing the free_folio() callback.
> 
> Alas, secretmem and guest_memfd are also using it.  Nevertheless, I'm
> not a fan of this interface existing, and would prefer to not introduce
> new users.  Like launder_folio, which btrfs has also mistakenly used.
> 

The part that felt concerning is how the private state is lost. If
release_folio() frees this state but the folio persists in the cache,
users of the folio afterward have to recreate the state. Is that the
expectation on how filesystems should handle this situation?

In the case of the existing btrfs code, when the state is recreated (in
subpage mode), the bitmap data and lock states are all zeroed.

