Return-Path: <linux-btrfs+bounces-2858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35A686B1D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 15:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741F31F26426
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EA215A488;
	Wed, 28 Feb 2024 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bpx0DvyB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W2VnTRbl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bpx0DvyB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W2VnTRbl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D28159574;
	Wed, 28 Feb 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130765; cv=none; b=lRYybPBOG4DeYkyjzdllscj9cNEOJLolQkk4z+1poO/jCsN1MOz55QqXjtvZdgIVjoiGnIijDYNSSNWcW9MnAe0xODIki3HcrlO+usXOJBr8LHrhQro0wd7PQXx0/tYbyOLXw6JTu2NwXMsiTsKeHn06FhSF/7GMU78AKKgVL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130765; c=relaxed/simple;
	bh=V9xCmIa6+ktbdxuv0pzexA3rpP6Ec7GNOfYNx5QCXnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFFu4InrM5mhLvWaOOH5SlCx7+dnWUK2DId5wtuPnIfVns0WVlGu7afgOkP7PIVXxQdua9qcZt6rzustNK82Dl1hmT/IwvjY8xx1GXPHuAhzf6H31q5/m/CyU3sgEbWxLx44fvhjVXJcfCQ6RCN6VbQ2+Revkmae05/aY9PqK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bpx0DvyB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W2VnTRbl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bpx0DvyB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W2VnTRbl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C07422501;
	Wed, 28 Feb 2024 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709130761;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NYae/Whr9QvEpUrCqVSM/Jhun3OoCsXnrZsdgqnIIBI=;
	b=Bpx0DvyBYwUL13zSoTsup+Eof4WDYvE6+Zs34RsLcPwz77PwsZVrseYrq5ClGUTA0FevgV
	+5ngz9GT/Whym9qFhmkM2ylMDVYXe0N1BK2IHu8qpUU57HG+3+j6U//6vgjuji32Gj8vW3
	bLOxVzGH1GjwSeBlT3rE1I2MjFUlgho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709130761;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NYae/Whr9QvEpUrCqVSM/Jhun3OoCsXnrZsdgqnIIBI=;
	b=W2VnTRblcbh6msol7Ep6v9bbOcUIvyyV7JIljVhZkv7iciKsp+O/TAfWff8gj4mzPShmMg
	LeexC5TcY/LfZQDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709130761;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NYae/Whr9QvEpUrCqVSM/Jhun3OoCsXnrZsdgqnIIBI=;
	b=Bpx0DvyBYwUL13zSoTsup+Eof4WDYvE6+Zs34RsLcPwz77PwsZVrseYrq5ClGUTA0FevgV
	+5ngz9GT/Whym9qFhmkM2ylMDVYXe0N1BK2IHu8qpUU57HG+3+j6U//6vgjuji32Gj8vW3
	bLOxVzGH1GjwSeBlT3rE1I2MjFUlgho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709130761;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NYae/Whr9QvEpUrCqVSM/Jhun3OoCsXnrZsdgqnIIBI=;
	b=W2VnTRblcbh6msol7Ep6v9bbOcUIvyyV7JIljVhZkv7iciKsp+O/TAfWff8gj4mzPShmMg
	LeexC5TcY/LfZQDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C4D513A42;
	Wed, 28 Feb 2024 14:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id RQeXCglE32WLGAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 28 Feb 2024 14:32:41 +0000
Date: Wed, 28 Feb 2024 15:32:00 +0100
From: David Sterba <dsterba@suse.cz>
To: chengming.zhou@linux.dev
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, vbabka@suse.cz, roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] btrfs: remove SLAB_MEM_SPREAD flag usage
Message-ID: <20240228143200.GN17966@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240224134709.829191-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224134709.829191-1-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.98%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Sat, Feb 24, 2024 at 01:47:09PM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

With updated changelog and some formatting adjustments added to
for-next, thanks.

