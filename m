Return-Path: <linux-btrfs+bounces-2327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB2085136E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 13:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7EFBB26AAE
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0871E3A1C9;
	Mon, 12 Feb 2024 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tkMV6+hJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UuVjamNU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tkMV6+hJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UuVjamNU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5583A1B2
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740266; cv=none; b=rljVDjVcJoWmxzsVuqs9QzEFYxccYA/UBhqlVEbIja/vTZzAX0Kqccbv/M6pkeCD26mxSDaIshC2aDJ1ZrOqSu4n9hMk7A6Hvvw8QlWR7GKiIUezdAGlJhh84pZ3xQ2FTOWy3r90f6sXbywJQ2Fq8oAB4NdwQv9RlUCQSlYK3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740266; c=relaxed/simple;
	bh=EGTfxxVpAVfSlQIP1HH6r/LEAGthCAF1f1q42pnyLT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPTZjgkDBt6rEeNivaFdM43KAdQTddcU/ZAjgDUvlztNQDiQxvrsAKmmpXeLmLcWbsaio2tyBNfI2wWiTq2WvH0qXFEaMsfEyXqSyFQm4mTwqcLQ1WplQ+HlQfmb0BvTCR0wd9uIKw/GSwiIT0LNHkV94/wiaLZ53+tgnj4Nm9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tkMV6+hJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UuVjamNU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tkMV6+hJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UuVjamNU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF4261F74D;
	Mon, 12 Feb 2024 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707740262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oYZrVBbjQSyZ9pccgesPl4nnO0c4e7h4yf1NwxVVJwo=;
	b=tkMV6+hJX/hysIgNVXvsR+XAIStreJn5GQPSP9RT3OJaqam4yq4amtY+zOOLmYlTHnE+4Y
	2NYtaGgXrPY9BIaWCIiSc7oe4HOv/233g8TxTtO1bQ7zK7Pef7nILUOYsN0Usa1+84OMOc
	TshKieUrNAKluNqcLd3crG8U8+l7bpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707740262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oYZrVBbjQSyZ9pccgesPl4nnO0c4e7h4yf1NwxVVJwo=;
	b=UuVjamNUk9R1HdZgJ7eV2bhA8xNdMnhm2IelfTU27V5mbG50Gg6oSw+1SWlWfL5Y0s1xyT
	aq2TxsyoneIGqAAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707740262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oYZrVBbjQSyZ9pccgesPl4nnO0c4e7h4yf1NwxVVJwo=;
	b=tkMV6+hJX/hysIgNVXvsR+XAIStreJn5GQPSP9RT3OJaqam4yq4amtY+zOOLmYlTHnE+4Y
	2NYtaGgXrPY9BIaWCIiSc7oe4HOv/233g8TxTtO1bQ7zK7Pef7nILUOYsN0Usa1+84OMOc
	TshKieUrNAKluNqcLd3crG8U8+l7bpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707740262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oYZrVBbjQSyZ9pccgesPl4nnO0c4e7h4yf1NwxVVJwo=;
	b=UuVjamNUk9R1HdZgJ7eV2bhA8xNdMnhm2IelfTU27V5mbG50Gg6oSw+1SWlWfL5Y0s1xyT
	aq2TxsyoneIGqAAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F9C713A3B;
	Mon, 12 Feb 2024 12:17:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2/iJJmYMymVRIwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 12 Feb 2024 12:17:42 +0000
Date: Mon, 12 Feb 2024 13:17:10 +0100
From: David Sterba <dsterba@suse.cz>
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: fstests btrfs/057 trigger a deadlock on 5.4.187
Message-ID: <20240212121710.GC355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220611142634.3F3C.409509F4@e16-tech.com>
 <20220611143547.3F40.409509F4@e16-tech.com>
 <20220718080300.A3BF.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718080300.A3BF.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.06 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.26)[73.74%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.06

On Mon, Jul 18, 2022 at 08:03:34AM +0800, Wang Yugui wrote:
> Hi,
> 
> Because process_srcu() is 100% busy, so this problem is srcu related.
> 
> the only srcu in btrfs is subvol_srcu, but it is dropped in 5.17
> 	c75e839414d3: Josef Bacik: btrfs: kill the subvol_srcu
> and this patch is difficult to backport to 5.4.x.

The whole SRCU use was replaced by root reference counting and spanning
many patches, backport would be really hard.

> so this problem maybe a little difficult to fix.  If we hit this problem
> in more frequency, we may upgrade to 5.10.x

This could still be affected though.

