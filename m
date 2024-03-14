Return-Path: <linux-btrfs+bounces-3290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D3987BF98
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 16:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36CD2852E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3DA71744;
	Thu, 14 Mar 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YfN3+ZUu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="08K/3zed";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YfN3+ZUu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="08K/3zed"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F3DDD9;
	Thu, 14 Mar 2024 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428915; cv=none; b=RCv8HfvKr7TuIIFHceLeHR0QWbIWXFb0c/Oa7HRXSjbt2RNnrw7K8q7ntvsSFh4rtiGZ61AuQ0fr8MSeRQsRVBw7kQYFqRN0weD0P9CkNdX6Z6gckmdBD4dphG69LWxByRH5Kkm01IKcgFRtv4Jg6Zv9zJ0gpo5rOlb/ZHZvTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428915; c=relaxed/simple;
	bh=xgGLzU9DgnWEO5WX/NbAMgoIxA7kxWV95DhLkJfsD94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eztosWl5TSzzFigCotn0+Q8ke7kITC7Jz4xncWUoTNuyk/T3AjQvur6zh8hrDNtTU1AB5rM8jAfyOb/QVMjYirIUUxG/y52SEBIDBSN/WdB4j+XN6Qu11Fr9SwCQjcSy61U+mp8lFs7qt1g4qbgHlSvot7TdwnuvNs/7D/8dvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YfN3+ZUu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=08K/3zed; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YfN3+ZUu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=08K/3zed; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from ds.suse.cz (unknown [10.100.12.205])
	by smtp-out1.suse.de (Postfix) with ESMTP id 4BE8021D18;
	Thu, 14 Mar 2024 15:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710428912;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgGLzU9DgnWEO5WX/NbAMgoIxA7kxWV95DhLkJfsD94=;
	b=YfN3+ZUuAnFIFa4iltcWiv+0Dp2gJg7n5tuR8y4bECs4t/XoYdPtjlPvvFFfH9HodRCc2c
	efEvIYpJvpTF5RVQ0CuUY3ZGYgXV8LuqLzSnZb88yOE0W/p46O+w/NrBUt7d4nV2oAt9kU
	yCgyh5uQeJoqrNRJOtHLL2C8Yj01xQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710428912;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgGLzU9DgnWEO5WX/NbAMgoIxA7kxWV95DhLkJfsD94=;
	b=08K/3zedJT8IOqTWCVC9aqe3UHHqgmg2VqsWwXDVzlCzHG4QVCAuiDN4mqiqPLwkGDFktj
	c5XbbXUDbZDW8CDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710428912;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgGLzU9DgnWEO5WX/NbAMgoIxA7kxWV95DhLkJfsD94=;
	b=YfN3+ZUuAnFIFa4iltcWiv+0Dp2gJg7n5tuR8y4bECs4t/XoYdPtjlPvvFFfH9HodRCc2c
	efEvIYpJvpTF5RVQ0CuUY3ZGYgXV8LuqLzSnZb88yOE0W/p46O+w/NrBUt7d4nV2oAt9kU
	yCgyh5uQeJoqrNRJOtHLL2C8Yj01xQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710428912;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgGLzU9DgnWEO5WX/NbAMgoIxA7kxWV95DhLkJfsD94=;
	b=08K/3zedJT8IOqTWCVC9aqe3UHHqgmg2VqsWwXDVzlCzHG4QVCAuiDN4mqiqPLwkGDFktj
	c5XbbXUDbZDW8CDw==
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 7C00FDA893; Thu, 14 Mar 2024 16:01:22 +0100 (CET)
Date: Thu, 14 Mar 2024 16:01:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/277: specify protocol version 3 for verity send
Message-ID: <20240314150122.GA20751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: 3.05
X-Spamd-Result: default: False [3.05 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_SPAM_SHORT(2.87)[0.956];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.02)[53.36%]
X-Spam-Level: ***
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Wed, Mar 13, 2024 at 04:46:29PM -0700, Boris Burkov wrote:
> This test uses btrfs send with fs-verity which relies on protocol
> version 3. The default in progs is version 2, so we need to explicitly
> specify the protocol version. Note that the max protocol version in
> progs is also currently broken (not properly gated by EXPERIMENTAL) so
> that needs fixing as well.

What do you mean? Progs are ready for protocol 3 as its availability
depends on kernel and if it's enabled then it's assumed that progs match
the protocol specification.

