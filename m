Return-Path: <linux-btrfs+bounces-6874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A31794135C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 15:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426FF1C233D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A8A1A01BC;
	Tue, 30 Jul 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="il70tu7n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Je0ZELP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="il70tu7n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Je0ZELP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E119FA98
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346881; cv=none; b=NN5e4I4GAVOp3NaIB5eHPxOkANnSphSFGJMDj1qDjUr57oaoLkpWlO5R6V4ZSdqJuEtt1WdC/LeLeXaoUNgZ1WjCFwd6WMWsrN6uKf6LbvHHaLU7vRonPLFJWvTUoy4QREKTD/g1FEphodp01OuWnkylWLZ2pCtSsIpUgb+EBC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346881; c=relaxed/simple;
	bh=jXHGqSNpHrziIpbK4dJZTigS6MBpTm+AzPhZg37ruxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcT3SmRF/M88AX2/SWlgXS6E4aD0lZozudzgHRpmIQCj2o1nIuhBLAQEboQUyJitANVYK0W+avZDYgUCCzJfn2jKSBhN12TvnRLWtSZ/cqm660dF5XPQRYS8KFFTFA/YUsjnjaHlysy6LJUgTSUcCEX6UfLbjQFFNU+sAf/F1qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=il70tu7n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Je0ZELP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=il70tu7n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Je0ZELP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A25621A79;
	Tue, 30 Jul 2024 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722346878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/hpdOpfNH54nniXHMxyU0kl9gEl9LUW+ATIY/evaRY=;
	b=il70tu7nt5gi7D2vzqwAbWTnGurhJit5coBFdNfz6WWRGBR54RtLpAIHlmxqVEyIIKiwvU
	o95qnRm++3UFaPWzQYoOQlfXiYxYBVFkXHnNNRotmOF7S0BPjA98CrQk1p1VIG3ojd+2uH
	rATC3jqdvFwlmOto1hgI54saY40Wnz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722346878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/hpdOpfNH54nniXHMxyU0kl9gEl9LUW+ATIY/evaRY=;
	b=5Je0ZELPjlhhp/coDrEtbVR21sRsAoXH+HCD5y3AhEQvr4Um5noiTPlG4WCPQ7LAH7lQ96
	ClWQ1W30TdFUBrBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722346878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/hpdOpfNH54nniXHMxyU0kl9gEl9LUW+ATIY/evaRY=;
	b=il70tu7nt5gi7D2vzqwAbWTnGurhJit5coBFdNfz6WWRGBR54RtLpAIHlmxqVEyIIKiwvU
	o95qnRm++3UFaPWzQYoOQlfXiYxYBVFkXHnNNRotmOF7S0BPjA98CrQk1p1VIG3ojd+2uH
	rATC3jqdvFwlmOto1hgI54saY40Wnz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722346878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/hpdOpfNH54nniXHMxyU0kl9gEl9LUW+ATIY/evaRY=;
	b=5Je0ZELPjlhhp/coDrEtbVR21sRsAoXH+HCD5y3AhEQvr4Um5noiTPlG4WCPQ7LAH7lQ96
	ClWQ1W30TdFUBrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8707213983;
	Tue, 30 Jul 2024 13:41:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TpuyIH7tqGZ3XgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 13:41:18 +0000
Date: Tue, 30 Jul 2024 15:41:17 +0200
From: David Sterba <dsterba@suse.cz>
To: Li Zhang <zhanglikernel@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH V3] btrfs: print error message if bdev_file_open_by_path
 function fails during mount.
Message-ID: <20240730134117.GZ17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1721235534-2755-1-git-send-email-zhanglikernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721235534-2755-1-git-send-email-zhanglikernel@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu, Jul 18, 2024 at 12:58:54AM +0800, Li Zhang wrote:
> [ENHANCEMENT]
> When mounting a btrfs filesystem, the filesystem opens the
> block device, and if this fails, there is no message about
> it. print a message about it to help debugging.
> 
> [TEST]
> I have a btrfs filesystem on three block devices,
> one of which is write-protected, so regular mounts fail,
> but there is no message in dmesg.
> 
> /dev/vdb normal
> /dev/vdc write protected
> /dev/vdd normal
> 
> Before patch:
> $ sudo mount /dev/vdb /mnt/
> mount: mount(2) failed: no such file or directory
> $ sudo dmesg # Show only messages about missing block devices
> ....
> [ 352.947196] BTRFS error (device vdb): devid 2 uuid 4ee2c625-a3b2-4fe0-b411-756b23e08533 missing
> ....
> 
> After patch:
> $ sudo mount /dev/vdb /mnt/
> mount: mount(2) failed: no such file or directory
> $ sudo dmesg # Show bdev_file_open_by_path failed.
> ....
> [ 352.944328] BTRFS error: failed to open device for path /dev/vdc with flags 0x3: -13
> [ 352.947196] BTRFS error (device vdb): missing devid 2 uuid 4ee2c625-a3b2-4fe0-b411-756b23e08533
> ....
> 
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>

Added to for-next, thanks.

