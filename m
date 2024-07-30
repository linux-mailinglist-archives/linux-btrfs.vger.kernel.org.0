Return-Path: <linux-btrfs+bounces-6881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE58A94145F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 16:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D241A1C23161
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A4A1A255F;
	Tue, 30 Jul 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oGUPIzVo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQCBrGY/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oGUPIzVo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQCBrGY/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CBC1A08AB;
	Tue, 30 Jul 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349716; cv=none; b=XJOEFgzVjJ5doAFBwSLzzE5l+EoHdTf3bPly2n3pMTwi2MGSlILM3Xu32AeiAQK1uSgsWGhmE9CkCb4dd5K8pUdryFDTA5mlhY3fhTWB4u2f/ahtzOiz+IEoOJWCLSQkQvTZgmvDTjL+r8RXQ9JLvLg5JkpqKLF2XKeOdic0bnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349716; c=relaxed/simple;
	bh=qx13nq3SEnPMDNr253sRMWKRBXPTmN/h9yjYqkOa/Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf8vpNzIMxRsw+Yx+oPkfQlBrHj+Y000DZZJuWieH0LHGJ7+cxVDoXF9UlNVTD38BqzYib5jAj61zlhY177uJiwGToUZkKMwgMu3LuX1qtRYMiuY+aH05V8ctmISXDfXW4bdOWpnj+JFbRn2CpQXDbaRT7OKAvTK+n3JxrFCMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oGUPIzVo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQCBrGY/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oGUPIzVo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQCBrGY/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 103CB1F806;
	Tue, 30 Jul 2024 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722349713;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kt23SUbWMMxeqhRF/o2EWrjBr5aT1WhWSxRDgIEDb9o=;
	b=oGUPIzVoD/kCh1hrlUVR0l2YYeoGSNrMGXty94eUli6LRXtTN1ZmLwU9nTsz9gkCN8dywC
	v5z+Rs4XUK/pqdQfIuUqeHeG1GWYGbcOXKhiYmQIbScYAxYIa7hjc3baVs253J1/jmH7oW
	08FNkBLWb+VwsFzWfxCaR+1KzkkF3v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722349713;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kt23SUbWMMxeqhRF/o2EWrjBr5aT1WhWSxRDgIEDb9o=;
	b=HQCBrGY/9I7SKbZWXeiXpaGKS2nsTXmpUSAW5IEs0LedQXP1RIdCIzxVDzpnO2L6Vn6ln0
	DKO1fey+RFVhlhDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oGUPIzVo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="HQCBrGY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722349713;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kt23SUbWMMxeqhRF/o2EWrjBr5aT1WhWSxRDgIEDb9o=;
	b=oGUPIzVoD/kCh1hrlUVR0l2YYeoGSNrMGXty94eUli6LRXtTN1ZmLwU9nTsz9gkCN8dywC
	v5z+Rs4XUK/pqdQfIuUqeHeG1GWYGbcOXKhiYmQIbScYAxYIa7hjc3baVs253J1/jmH7oW
	08FNkBLWb+VwsFzWfxCaR+1KzkkF3v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722349713;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kt23SUbWMMxeqhRF/o2EWrjBr5aT1WhWSxRDgIEDb9o=;
	b=HQCBrGY/9I7SKbZWXeiXpaGKS2nsTXmpUSAW5IEs0LedQXP1RIdCIzxVDzpnO2L6Vn6ln0
	DKO1fey+RFVhlhDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3BFD13297;
	Tue, 30 Jul 2024 14:28:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0F1jN5D4qGYWbQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 14:28:32 +0000
Date: Tue, 30 Jul 2024 16:28:31 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+1d896c57cf020d5e4151@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KMSAN: uninit-value in deflate_fast
Message-ID: <20240730142831.GE17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000cfe31a061a45a2cb@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000cfe31a061a45a2cb@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[1d896c57cf020d5e4151];
	DKIM_TRACE(0.00)[suse.cz:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 103CB1F806
X-Spam-Level: *
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 1.49

On Thu, Jun 06, 2024 at 09:57:26PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1736345a980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
> dashboard link: https://syzkaller.appspot.com/bug?extid=1d896c57cf020d5e4151
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Most likely this was a side effect of bug fixed by commit f3a5367c679d
("btrfs: protect folio::private when attaching extent buffer folios").
There are 3 reports by syzbot, timeframe corresponds with increased
number of bogus errors caused by use-after-free of a page, compression
is reuses pages quite often.

The fix is best guess.

#syz fix: btrfs: protect folio::private when attaching extent buffer folios

