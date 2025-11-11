Return-Path: <linux-btrfs+bounces-18865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B3AC4E10C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 14:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502CD3A74B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD12E33ADB8;
	Tue, 11 Nov 2025 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PW9SZMXq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rqZ6EXbi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PW9SZMXq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rqZ6EXbi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25184331233
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866707; cv=none; b=oeqpNwgl833iNsLvHUND5jbJJ53gAmrGFyb00tqNgDEO1fhgkkQe4BdEWqX0PqMIrgFqM0Mv4z6q/XFqYxSs5autvuSR7CLW7oju1Cx1W2OPLvXWUL+aRXXxKyytOtVxBB1wqoNyN1bwZN8CcihQXacRyoBEPmK/MHP15Cr/4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866707; c=relaxed/simple;
	bh=jCw+LruxW3PqP1/DbWszJTgwBrscusGar9f+B1ebof4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJf/g2GmUaIqD72elQVZ56vL7JSSs5LdmECUVUXti5yHxNNK3obfQCp9BG4IFWeiPocbZX5XqONNIzKHvF2tkafRbcyTuUXHtxkGc+yg5gPwK9yvODLsGz5uWHz3/e/QhxE4daH2Yp4MvncgiGJ2qNkipvRUugSBPGdEU3vA1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PW9SZMXq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rqZ6EXbi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PW9SZMXq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rqZ6EXbi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0ACBB1F7A9;
	Tue, 11 Nov 2025 13:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762866704;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlzybCnUxe5WcYuPSZNH+Pzx46jYjvdKB9JfUhuHIk0=;
	b=PW9SZMXqxpdim2wPIspBnqhdx7nVBx0dEgsPOhdAuHqF/z4J8VIyCue8ZFcYDIToeVQuDD
	eeM/voxXQ8ldoq1SLrzkT2M//kkX+4nXsNTK2EI5ZkUh09KJIPlCJYjCVZYovSPvTavor4
	0O6s8PioNnXiRuEnLMkOmVFBZgSpcg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762866704;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlzybCnUxe5WcYuPSZNH+Pzx46jYjvdKB9JfUhuHIk0=;
	b=rqZ6EXbiiMeeqFsTZkWZy+8lX6fZUKsTplNM1tnR6ul9BxAFaX8YgSLtlD3l/+wUU+aYlV
	exWNx0K3A6Sq7dAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762866704;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlzybCnUxe5WcYuPSZNH+Pzx46jYjvdKB9JfUhuHIk0=;
	b=PW9SZMXqxpdim2wPIspBnqhdx7nVBx0dEgsPOhdAuHqF/z4J8VIyCue8ZFcYDIToeVQuDD
	eeM/voxXQ8ldoq1SLrzkT2M//kkX+4nXsNTK2EI5ZkUh09KJIPlCJYjCVZYovSPvTavor4
	0O6s8PioNnXiRuEnLMkOmVFBZgSpcg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762866704;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlzybCnUxe5WcYuPSZNH+Pzx46jYjvdKB9JfUhuHIk0=;
	b=rqZ6EXbiiMeeqFsTZkWZy+8lX6fZUKsTplNM1tnR6ul9BxAFaX8YgSLtlD3l/+wUU+aYlV
	exWNx0K3A6Sq7dAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3ED21498B;
	Tue, 11 Nov 2025 13:11:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1ZFhNw82E2krUAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 11 Nov 2025 13:11:43 +0000
Date: Tue, 11 Nov 2025 14:11:38 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: reduce memory usage for btrfs_raid_bio
 structure
Message-ID: <20251111131138.GZ13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1759984060.git.wqu@suse.com>
 <7970eef9-0771-4634-bb9c-412c5a21879b@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7970eef9-0771-4634-bb9c-412c5a21879b@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Tue, Nov 11, 2025 at 09:28:18AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/10/9 15:09, Qu Wenruo 写道:
> > This series replace the following members of btrfs_raid_bio:
> > 
> > 	struct sector_ptr bio_sectors[nr_sectors]
> > 	struct sector_ptr stripe_sectors[nr_sectors]
> > 
> > To the following ones:
> > 
> > 	phys_addr_t bio_sectors[nr_sectors]
> > 	phys_addr_t stripe_sectors[nr_sectors]
> > 	unsigned long uptodate_bitmap[nr_sectors]
> > 
> > For x86_64 (4K page size) with the fixed 64K stripe size and 3 disks, the
> > memory usage of those members (not the full structure) will be reduced from:
> > 
> > 	8 * 2 + 48 * 16 * 2 = 1552
> > 
> > To
> > 	8 * 3 + 48 * 8 * 2 + 8 * 2 = 808
> > 
> > Almost halved the memory usage.
> 
> A gentle ping.
> 
> Any feedback? Further bs > ps enablement relies on this as the first step.

Sorry I missed this series, please add it to for-next.

