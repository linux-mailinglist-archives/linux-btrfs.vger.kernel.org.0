Return-Path: <linux-btrfs+bounces-16192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1A6B2F834
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 14:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD101CC6CAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF132E2823;
	Thu, 21 Aug 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NXY0lepi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tuVx4oTQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NXY0lepi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tuVx4oTQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6A2E22B8
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779792; cv=none; b=n9y0M8xjcRS3EZXa8Ua9cxkwQY+2F5WnW+P3nIN5lkYPZcH922Rj49EIL44e6OHyMKizbEaBU8v7EJ8aTq65pLKzXj0odkt5vR99aWWbKB70N50hSl55a7uLI+Pq/0lNK8+nvw3hPkwAgg+RVWE1h5h1QhuBv3aa0pqO7gR+gh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779792; c=relaxed/simple;
	bh=IlJjbS6g+uDn/0qHjz3/1/FDnal8JD3FdrmYuRAEIv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmUr9gdai9IlnA9nQCJj026lYlL989wNV+0UgGIsnl6KyU98vzhwvQGwv2vpbSx1pPOk4toJE6eUlopsYP4p72STSD+PFrfEdy9vhR1Dk9tKXemiBS7OUmP3IwMXXGtgTM6nnKamv1hbbv0qEZJ/m0khGYtvuoBjePTHxIawl0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NXY0lepi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tuVx4oTQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NXY0lepi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tuVx4oTQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E9FB1F395;
	Thu, 21 Aug 2025 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755779789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUCrCBYoFPzT+yIhLhWwdmmRWq8iqpIh9Oko+SOczsI=;
	b=NXY0lepi1aLKCZmHgKlnrvQsJm1PsyYpmCnhNCnVPf4c3yB58RNUTKt+SU+cUubUpuP+nr
	5PrASC+6DSkmQV+yBO0mXrLeE1UjsQPB5Xgb7vHvkNd9AhoE+qT0sMh+5NZ1n1MxFyl7pv
	f1SB/T2blO1WBiWHNxX032KGZfY3AOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755779789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUCrCBYoFPzT+yIhLhWwdmmRWq8iqpIh9Oko+SOczsI=;
	b=tuVx4oTQC1q4voQ5bnfvfVl2wMW438cCbTYEjzyBDXfACSpX+JbykQdw0si2jxBfD42OG5
	pPeo1DfEcbS3xYCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755779789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUCrCBYoFPzT+yIhLhWwdmmRWq8iqpIh9Oko+SOczsI=;
	b=NXY0lepi1aLKCZmHgKlnrvQsJm1PsyYpmCnhNCnVPf4c3yB58RNUTKt+SU+cUubUpuP+nr
	5PrASC+6DSkmQV+yBO0mXrLeE1UjsQPB5Xgb7vHvkNd9AhoE+qT0sMh+5NZ1n1MxFyl7pv
	f1SB/T2blO1WBiWHNxX032KGZfY3AOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755779789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUCrCBYoFPzT+yIhLhWwdmmRWq8iqpIh9Oko+SOczsI=;
	b=tuVx4oTQC1q4voQ5bnfvfVl2wMW438cCbTYEjzyBDXfACSpX+JbykQdw0si2jxBfD42OG5
	pPeo1DfEcbS3xYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AFBF13867;
	Thu, 21 Aug 2025 12:36:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QplMCs0Sp2j+XAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 21 Aug 2025 12:36:29 +0000
Date: Thu, 21 Aug 2025 14:36:27 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Remaining BTRFS_PATH_AUTO_FREE work
Message-ID: <20250821123627.GS22430@suse.cz>
Reply-To: dsterba@suse.cz
References: <6181995.lOV4Wx5bFT@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6181995.lOV4Wx5bFT@saltykitkat>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Tue, Aug 19, 2025 at 10:03:45AM +0800, Sun YangKai wrote:
> There's no such pattern in files beginning with p, and files beginning with z 
> has been converted. So files beginning with [r-x] need this work. I'm doing 
> this on files beginning with r.
> 
> BTW, should we also do this for files in the test dir?

Yes, thanks.

