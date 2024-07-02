Return-Path: <linux-btrfs+bounces-6149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44090924374
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 18:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D8A1C2243A
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 16:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6D71BD038;
	Tue,  2 Jul 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tpl1EOku";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ZmWyYa+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tpl1EOku";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ZmWyYa+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E2C1BD009
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937161; cv=none; b=WsCzwMSR83NgRvtS963a/FIjE9+Tnw7RtjDGtg9s6KLACj9lB5rpz7ZfHe5PDN5MoRhc/IjmLs5WmEjUZz4o7tptQVmxUqcE48KtyTF2x5ytN8jCRmZ/chgafwDxF0+Bs6L2u2xO+/k3MJa0vx6ie3C+XqmBZge6BLdq6vmo1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937161; c=relaxed/simple;
	bh=L8y9exe+4WjhhPXrEkpQb0o+pm5XPqvJKEL6wpY4hiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7XriPv/6iAHvrKEGm3P7JTf4lKLhLy5YgZhGXT3fek1cs7G3ldefY/i8LuUZrLBy6g1W05NLlEyJ8NxoZtrwuzw36Kn9MmkX0r1JN9ZejacU9MXmVBioWTEeU0TwjKmFQGkYvQn80nO4myx8uiQ+mKvaLD9L2tya6Tib2KRLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tpl1EOku; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ZmWyYa+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tpl1EOku; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ZmWyYa+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 71D381FBAE;
	Tue,  2 Jul 2024 16:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719937157;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uxsWOdsvnPLQUHJg0m6upmdDVYCZU4T3Ht8N+WC4Yww=;
	b=Tpl1EOkuG+VZKH22UTmpe4GUwU3Oil9rZFxCrpgOvV8edgDUE7UwtMDt9T2Kx6RXVP4EpM
	30r9SLKBYAgNQD37XDYM/wc1yxnOJeCFhAfl33JZQnQ4Qft12nH23Ej8cvqBE9OO0dn+eR
	B5krTbK+1QCiYC6MEo3m4ZirfTB1GyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719937157;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uxsWOdsvnPLQUHJg0m6upmdDVYCZU4T3Ht8N+WC4Yww=;
	b=1ZmWyYa+D1BIzVPSRWVArXuvLkLYYcp3xN4nB63RQN8oR3WeRHVGRr6Rbp5IohmCOs9fMp
	yibCVptmX6bYTECQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Tpl1EOku;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1ZmWyYa+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719937157;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uxsWOdsvnPLQUHJg0m6upmdDVYCZU4T3Ht8N+WC4Yww=;
	b=Tpl1EOkuG+VZKH22UTmpe4GUwU3Oil9rZFxCrpgOvV8edgDUE7UwtMDt9T2Kx6RXVP4EpM
	30r9SLKBYAgNQD37XDYM/wc1yxnOJeCFhAfl33JZQnQ4Qft12nH23Ej8cvqBE9OO0dn+eR
	B5krTbK+1QCiYC6MEo3m4ZirfTB1GyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719937157;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uxsWOdsvnPLQUHJg0m6upmdDVYCZU4T3Ht8N+WC4Yww=;
	b=1ZmWyYa+D1BIzVPSRWVArXuvLkLYYcp3xN4nB63RQN8oR3WeRHVGRr6Rbp5IohmCOs9fMp
	yibCVptmX6bYTECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56FDE13A9A;
	Tue,  2 Jul 2024 16:19:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QuvBFIUohGZqOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Jul 2024 16:19:17 +0000
Date: Tue, 2 Jul 2024 18:19:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] btrfs: fix __folio_put refcount in
 btrfs_do_encoded_write
Message-ID: <20240702161916.GI21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1719930430.git.boris@bur.io>
 <9e23e32fb945c3e1c43f8c0f8ca20552c48d5b65.1719930430.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e23e32fb945c3e1c43f8c0f8ca20552c48d5b65.1719930430.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 71D381FBAE
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Jul 02, 2024 at 07:31:13AM -0700, Boris Burkov wrote:
> The conversion to folios switched __free_page to __folio_put in the
> error path in btrfs_do_encoded_write.
> 
> However, this gets the page refcounting wrong. If we do hit that error
> path (I reproduced by modifying btrfs_do_encoded_write to pretend to
> always fail in a way that jumps to out_folios and running the xfstest
> btrfs/281), then we always hit the following BUG freeing the folio:
> 
> BUG: Bad page state in process btrfs  pfn:40ab0b
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x61be5 pfn:0x40ab0b
>  flags: 0x5ffff0000000000(node=0|zone=2|lastcpupid=0x1ffff)
> raw: 05ffff0000000000 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000061be5 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: nonzero _refcount
> Call Trace:
> <TASK>
> dump_stack_lvl+0x3d/0xe0
> bad_page+0xea/0xf0
> free_unref_page+0x8e1/0x900
> ? __mem_cgroup_uncharge+0x69/0x90
> __folio_put+0xe6/0x190
> btrfs_do_encoded_write+0x445/0x780
> ? current_time+0x25/0xd0
> btrfs_do_write_iter+0x2cc/0x4b0
> btrfs_ioctl_encoded_write+0x2b6/0x340
> 
> It turns out __free_page dereferenced the page while __folio_put does
> not. Switch __folio_put to folio_put which does dereference the folio
> first.

By 'dereferenced' you mean to decrease the reference count? Because
dereference is usually said about pointers, it's confusing in this
context.

