Return-Path: <linux-btrfs+bounces-19578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A91CAE1F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 20:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5401D30573A6
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 19:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180662FB962;
	Mon,  8 Dec 2025 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ARuSp7jW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cvCAMudx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XbfRJOVa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5hrrrWTR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514E15624B
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765223653; cv=none; b=p0U8HLKKks69HMu6ZRjelXoraNDcIG8N6Eifs3+gTSZGILEDYxiR/gyspdTtyU9vdPq2juTjrS5543dVuMkD96NsT/huy+w48jbgVe+Z5NcR5CsKfkCkBLhnB23lxXT3BF51+bmwDhifq39fihH5n+kIem2bEN0F7ShxHQQcP1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765223653; c=relaxed/simple;
	bh=mgQaJil7zTWcf6GcSoQeHqOv+os/9xoXIWko4k1Ttc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3N9fTpTyCIaxJ3gN53uk1xsepopcZZW4l5J1Sr/cmbt08L9YMi51m+c6YiQ60tETC5fIdhSWIkTUWxxddeoN9x3dUaYsTVOuQEi0CkWy95y9vIYpLn2eMuptw23I3yo6i1gCv4hFcAi3/6bXCHPukaVfJcIoQ0Q2j277yG/7Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ARuSp7jW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cvCAMudx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XbfRJOVa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5hrrrWTR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99346336FD;
	Mon,  8 Dec 2025 19:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765223649;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vmQ9zqGFME2P38nVS0AMgHW5jmWzz7HB4Sy0cZkebHQ=;
	b=ARuSp7jWY5iG+XCZ9KAQrKQL5ofLy6Oahw1e0IcvJZBLqwiLgHV6pcaQawjiNVIUcbPurU
	G9AuzUxxIwgGA+re5fitoSa5PeE/7/JB6MEXlgboENR5u966fuPjhoMk2zS1mmZX2TN7fF
	80INyr3cbRt2F8dH+TWrF0fLy1oWii0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765223649;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vmQ9zqGFME2P38nVS0AMgHW5jmWzz7HB4Sy0cZkebHQ=;
	b=cvCAMudxhslmxe2duiU6eEKoao41jmf8bnKx96prCv8s5RaSotLJGL3WfezqD/mqxuIl/0
	1BNrbb6m1MqpehBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765223648;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vmQ9zqGFME2P38nVS0AMgHW5jmWzz7HB4Sy0cZkebHQ=;
	b=XbfRJOVaV0ITRoKAT2PYIedfKBsYUbp/D0OL2HzgmHlF3VAL9+q9cacN7lM8FW3ESfpY8O
	X4SXG2uT8rIdFdBCZZ+RxUgKAMsn5b+CE16vRB2f41BW+MlYMLlgzvtdOy+YDseK/bcKwo
	qIXzSuDiu/aCvoWY7ZYIWnfjH2yTfxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765223648;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vmQ9zqGFME2P38nVS0AMgHW5jmWzz7HB4Sy0cZkebHQ=;
	b=5hrrrWTRKf2teAfDr3DAiosXYGZKjUPh40A4TbjumrPJTM99IQiBPIxnAILBUB+s5AW5zx
	RBngDgMPpc7VnvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 874CC3EA63;
	Mon,  8 Dec 2025 19:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1XzYIOAsN2kbYgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Dec 2025 19:54:08 +0000
Date: Mon, 8 Dec 2025 20:54:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, mssola@mssola.com,
	syzbot+b44d4a4885bc82af2a06@syzkaller.appspotmail.com
Subject: Re: [PATCH] Revert "btrfs: add ASSERTs on prealloc in qgroup
 functions"
Message-ID: <20251208195407.GC4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <65fee7dc5c82e194d20be47bb3772949e4ec22c8.1765185918.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65fee7dc5c82e194d20be47bb3772949e4ec22c8.1765185918.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.990];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[b44d4a4885bc82af2a06];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:replyto,twin.jikos.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,appspotmail.com:email,twin.jikos.cz:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.50

On Mon, Dec 08, 2025 at 07:55:48PM +1030, Qu Wenruo wrote:
> This reverts commit 252877a8701530fde861a4f27710c1e718e97caa.
> 
> Commit 252877a87015 ("btrfs: add ASSERTs on prealloc in qgroup
> functions") tries to remove the kfree() on preallocated qgroup during
> several call sites, but it can not be more wrong:
> 
> - btrfs_quota_enable()
> - btrfs_create_qgroup()
>   If add_qgroup_item() failed, we go out_free_path() and at that time
>   @prealloc is not yet utilized and will trigger the new ASSERT().
> 
> - btrfs_qgroup_inherit()
>   If qgroup_auto_inherit() failed, @prealloc is not yet utilized and
>   will trigger the new ASSERT()
> 
> Reported-by: syzbot+b44d4a4885bc82af2a06@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/69369331.a70a0220.38f243.009e.GAE@google.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Right, this needs a full revert and it's a recent commit so the code has
not diverged yet.

Reviewed-by: David Sterba <dsterba@suse.com>

