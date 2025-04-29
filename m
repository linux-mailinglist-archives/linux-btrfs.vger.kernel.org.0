Return-Path: <linux-btrfs+bounces-13489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5237BAA042D
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 09:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97BE07A264F
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 07:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17452750F6;
	Tue, 29 Apr 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BcJpIs0w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4ad7O9nc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xa35RLPB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kyapaps8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D41D5ABF
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911032; cv=none; b=ZdcmFunlvh3CyEJHiOR2bx95Uahhlv0Ge5VvCKyZlpNTy6TGSqF9ovhsQSQap3YpfHTJq9jf/jBGF0fzu8E8EwAV+HSwIk+yTWcPjWCYLJYrIOuCSjFBYSXvxa+AVMhklMhv/FSBefdVPcqPqT3bVGT5/n6BPWmRR7etJAzSsIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911032; c=relaxed/simple;
	bh=HW6eWYlMNW+IBmHBzFseixExFl18C6pvvShlnSetdts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJNcMayO+hEX/HCFzY7ztsjpetNRrx7p43jt1qG03OOPVqJVyoy/7JyNdFNEquG4nDBsBdB9KsaCWpx2U5stx1Qlc6JApiCkisGJKiJDTUKFE7/Bm5SgNKr3awk4T0lF3e0n1VvaN1v82xtjkcWXzmk0Y23+tvwNYtYWE7HAhG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BcJpIs0w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4ad7O9nc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xa35RLPB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kyapaps8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD1401F7C0;
	Tue, 29 Apr 2025 07:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745911029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZA0v72PJAN91+9cA9aUErfA9rgA/ydzIkkI6QlthXvQ=;
	b=BcJpIs0wXRcHyYDzsx7HU5SDwkMbIyRNyPgTtn10SFVgUVSTvKCPF/kfh0O/pPmvE17Z8v
	tIzwnKQRk+EhXO5fevnahexoKmNO+MECjTX6KF/nFBkhMODX4Zg/6mtPR70/By5H2WhAPl
	bhbqt/C1vgki0NlJdR6CsQilGpXesuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745911029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZA0v72PJAN91+9cA9aUErfA9rgA/ydzIkkI6QlthXvQ=;
	b=4ad7O9ncAT0MfSn23L5sTNVIB6PSzDrAXL4gzDt5ct8Sx+mqzRlnifuzj7BS26+Fuvho1X
	GjbkDdmg4Oc1LQCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xa35RLPB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kyapaps8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745911028;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZA0v72PJAN91+9cA9aUErfA9rgA/ydzIkkI6QlthXvQ=;
	b=xa35RLPBQcvA/yyKMB5TGga289RysXBRSO3Usp6Dk+NPiW/qxPDL4GeG2LRtCokCGnTcpi
	FasgHjOa8icZeVUYXnY/8X53D62blWVOtDD15XjRquQ31sfqp+GEsVxsp/mCIXwLtOFy2l
	6k/3SJKnTxoDnrQdi8mCHI0HDBBCUi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745911028;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZA0v72PJAN91+9cA9aUErfA9rgA/ydzIkkI6QlthXvQ=;
	b=kyapaps8P5DsYu5oqzvf/u+nOxzZy/kIB6/CEwFg9NQyHEIdbw4Rr7etfaJAks8VZHJdi1
	SVuu2i5GM+fc1JAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACAE71340C;
	Tue, 29 Apr 2025 07:17:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rAfyKfR8EGjhbQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 29 Apr 2025 07:17:08 +0000
Date: Tue, 29 Apr 2025 09:17:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: get rid of btrfs_read_dev_super()
Message-ID: <20250429071707.GC18094@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1745802753.git.wqu@suse.com>
 <96a246471a1071b6cee00be2bcdbc7bc0e97787b.1745802753.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96a246471a1071b6cee00be2bcdbc7bc0e97787b.1745802753.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: BD1401F7C0
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Apr 28, 2025 at 10:45:52AM +0930, Qu Wenruo wrote:
> The function is introduced by commit a512bbf855ff ("Btrfs: superblock
> duplication") at the beginning of btrfs.
> 
> It leaves a comment saying we need a special mount option to read all
> super blocks, but it's never implemented.
> 
> This means btrfs_read_dev_super() is always reading the first super
> block, making all the code finding the latest super block unnecessary.
> 
> Just remove that function and replace all call sites with
> btrfs_read_disk_super(bdev, 0, false).

I think it's ok to remove it, overwriting the primary superblock is
pointing to a worse problem that may not be simply fixed by starting
from the copies. The rescue tools or check have the ability to use the
copy and start from there.

Reviewed-by: David Sterba <dsterba@suse.com>

