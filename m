Return-Path: <linux-btrfs+bounces-21849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMKZHRmknGnqJgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21849-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 20:01:45 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA3C17BF64
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 20:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D27A63139763
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1B4369986;
	Mon, 23 Feb 2026 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Muv8O1Hc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l/PkGmwH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YqKq8fbY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dZ4vvn+v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898034029C
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873154; cv=none; b=S426bIxNtURh9DqgTRiR4zjk1Dd1HyNXg8WfmG74GZgi+n/FIVZX+n17Kv4d7KPaTpiHgohrcV8Lml5c72NlKtu7A4GN3a3N5XFa52bYiO0MzfHgEn4yTRdp/b/DkXCaPOR4Y4QKId0ScA68XlKNkHFwfIIxA05lbfc1Wu9Z9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873154; c=relaxed/simple;
	bh=dzcoLPEkhAhaIbQYfb77237fplddM2dDJUSk25thWuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDHkuPQfTXEJMcOv+E7BDSj2HEFffj7a3lhwZ5SJ/NhV6ols6KPhp9s6zFYjqs27WZbZ3U/3LEmZOd+if0wObHptrtZvo0T15P+oqDY+r+lB/N+ibJSkYbIfmim38F9CvL7ffpnzsFwJQ4KbgmuXLhdLdu8SNuoY5gdlT5S2suE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Muv8O1Hc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l/PkGmwH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YqKq8fbY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dZ4vvn+v; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E0C965BD27;
	Mon, 23 Feb 2026 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771873150;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzcoLPEkhAhaIbQYfb77237fplddM2dDJUSk25thWuA=;
	b=Muv8O1HcvRjy8nPMlLiXaaltYx2h7xgTPplaWqUKgSspU8Bhamt4Kg3Pv2qLNEHGvvmqDa
	VSvvAIa6drw2Nlv5V6x/ZY+0FYh2NRSTJ8HZuA/npI5D+ciFQXMujHv6E9QSYWgTtxVZRe
	xbtgMUIV6Rq99E2qQpn3qStu1iZJi3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771873150;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzcoLPEkhAhaIbQYfb77237fplddM2dDJUSk25thWuA=;
	b=l/PkGmwHPGGiJ8ZkYtLI0sXvPfA1e8OwqIFS5ISskGRU3UW4chavmD2umNWcW9i0dwoppe
	UgybX3rOHvnGo+AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YqKq8fbY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dZ4vvn+v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771873149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzcoLPEkhAhaIbQYfb77237fplddM2dDJUSk25thWuA=;
	b=YqKq8fbYD/foRJ+TyxpW+LvJe1gbJWaqPmX2+PhEgqP3ZZdrn+kC9YjhXtkUThQpHptJgm
	FKRyq2p2l6b7NyddC3+Nm5rjCwJEQ+37yfxjRjjR1n/fPlKoMWAs0JGtKU1kBIBhX7WN+F
	FbP7G1vsM0M91Uh6n6cKw+dWVcE7KVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771873149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzcoLPEkhAhaIbQYfb77237fplddM2dDJUSk25thWuA=;
	b=dZ4vvn+vyNn7fNOweei/wpwEIqkW4iYoMJrn00V+EvYqmaG7cM4gJxMeriBS6v+hDFbLnx
	sbXX9BOu/gXLGGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9AA53EA68;
	Mon, 23 Feb 2026 18:59:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rfEQMX2jnGmUEQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 23 Feb 2026 18:59:09 +0000
Date: Mon, 23 Feb 2026 19:59:00 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] btrfs: fix error messages in btrfs_check_features()
Message-ID: <20260223185900.GO26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260218111346.31243-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218111346.31243-1-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21849-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Queue-Id: CBA3C17BF64
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:13:40AM +0000, Mark Harmstone wrote:
> Commit d7f67ac9

Also please configure your git so the hashes are at least 12 characters,
I've been using 14 and I think others do too. This is 'core.abbrev'
config.

