Return-Path: <linux-btrfs+bounces-21307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJnRCKiegWlwHwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21307-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 08:07:20 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7525ED58BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 08:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31E733043D17
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 07:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A338F956;
	Tue,  3 Feb 2026 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="eWV9Ze1l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0F2FB997
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102430; cv=none; b=GmJPe95uEqlcQf8CGlKOP28F4ZBxcskZntVGW5yrK1d7qpC0qtwVpvd/q8ufJVyFt5UDeDRI/+D+En7gSTAGTQbLsO9hQrpx6BnY99VNa03E5LTua/NWxTFa7XQK/AUMHVf5hVEKEw3QecymNQNhwnjtLEH0eqS3hga81PgNhdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102430; c=relaxed/simple;
	bh=+8onjeqxbUNpqLiR3U7Lpe3EOip5nv/XShMw5Yo6yQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3dJC3JvlGY3arAibGV4Fgy3juvb2eE5UVxuew1/rf6mzeLWGqN6mFmAcs6VOJlbKVSZeZ9pdFRCN0mhY/MCOcKYnnfL3RCMr2pTW6xHLnXXAt0O+PqvPIGxAgmHUzFjS7Mp04F5LE19xjY71XXyZF1oh3xF8+f1i8fgNFZuAHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=eWV9Ze1l; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D5B9D14C2D6;
	Tue,  3 Feb 2026 08:06:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1770102420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OkU/P7xKqr3jhYD8+CzMsDsQQ4nZwwzsOY5rQK9+kDM=;
	b=eWV9Ze1lLsi/+l7BDJFgz8WaxFkXaT7zPOn80dqSwcCq5Ck8RklI4PH8/6wbdt5YO9xADm
	I6gxkfa0uRh3pKeXut+s7Aer6d1AFEOe+gHrh5VrlXWLMvjMubtLR52QHa2qxXQePVx0so
	pesbmkNHWlS4CFyNkjkAhtwlJ8FvhdaeNUIKrgJu21savsQP4Dz6sxt5qwjEUWWrlbl5J9
	0ZqZD8i0SF5HrD5Lecn95aVLG9Kp9qQAHW/qZpsCfMAsUvMYM+QVulSoiqYVg7lrTfTTNy
	Wg6lizNsopd/O5eqse3USrX52EG/jIUTSZ9cesRZWVmf+Bej7cSK1vaLO/gu3A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f7d6d662;
	Tue, 3 Feb 2026 07:06:57 +0000 (UTC)
Date: Tue, 3 Feb 2026 16:06:42 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Anton Mitterer <calestyo@scientia.org>,
	Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: We have a space info key for a block group that doesn't exist
Message-ID: <aYGeghb0lkhZhDcV@codewreck.org>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
 <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
 <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21307-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	DKIM_TRACE(0.00)[codewreck.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codewreck.org:mid,codewreck.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7525ED58BC
X-Rspamd-Action: no action

Hi Qu,

Qu Wenruo wrote on Wed, Nov 19, 2025 at 09:59:55AM +1030:
>>> We have a space info key for a block group that doesn't exist
>>
>> So even without clearing the cache as you've proposed below, it
>> couldn't have caused any post or future corruption, right?!
> 
> Yep. Allocation is always happening based on a block group, such
> orphan space info/bitmap keys won't cause the allocator to use it
> anyway.
> 
> So no corruption or whatever.

We're running rountine btrfsck before copying the filesystem for cloning
in one of our tools, and I'm starting to get user reports of errors due
to this error (we run an ancient 5.10 kernel but there hadn't been any
such report, and now we just got two in a couple of weeks so something
must have been backported to the stable tree...)

Anyway, I agree with your answer that it's safe to ignore, but it's not
obvious for users to decide that, so I'd like to address this somehow.

If it's really harmless, could it be printed as info message but not
change the btrfsck return code? (e.g. if that's the only error, return
success)

If you think it's worth keeping as an error, would you (or someone else)
happen to have any idea where I should start looking?


(Alternatively since we're not copying at the block level I guess there's
no real need for this check in the first place, as any real corruption
would cause IO error, and I could just forget about this... The check
was just ported e2fsck from back when the fs was ext4...)

Thanks,
-- 
Dominique Martinet | Asmadeus

