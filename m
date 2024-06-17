Return-Path: <linux-btrfs+bounces-5758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB35390B203
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 16:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E70296032
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 14:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CC1ABCA0;
	Mon, 17 Jun 2024 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OFmSDDIf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3CYH0H85";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OFmSDDIf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3CYH0H85"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CAC19B3E1
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632002; cv=none; b=c0fQon1/Ef8tduJ3O2c+SELqPZnhNXWZuKawH5TC09lxP2UfJBcWX2WmLG++yjgKNb7ysywzSOxNwE74+5TKuitXKOOnEcjHioBGGlYidwNNFgVAmE9c2T4ahhMKvSFgDCl8wti15PbtAnjQcDV2udboNJQI/sztm3kZHhYAPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632002; c=relaxed/simple;
	bh=Y8zrtXop9qlIIJKU8Fs1bOgu+GcVnU+oRyAz6Zkz/Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS4kJC4xfxIKLlAfKSMiOTaeD9A6JwqeOSNkohjsH6dYuqDMQyVWcDpqK7VH8WKM+r/PN+IvsonPEcjgUBFC0GvsR8SSMb0yCCOXK7cMOSKbaWHyp+Z3pyDL4tDaQR+s6MwvmnL32ADIGn/KsGsrtzqelHD/4BQyyjmmgSBylBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OFmSDDIf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3CYH0H85; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OFmSDDIf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3CYH0H85; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6FA1560187;
	Mon, 17 Jun 2024 13:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718631998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YwDn+ALYScRZged3Jz9L26H1pu7KAq3NtPYl9fQOKlA=;
	b=OFmSDDIfUAc8DMPYmitgCUSxKiWJMzgh/7rpBV+86F4a2RbwN4iYa8HwqUZyTYysGxikva
	DULCwzCeVU6XAubRtvjnUPgOlcCMSzHME2bpJeOKlJwX/uCPYCRhBAOo3yvthFMWMGwitW
	Vc/Dto2+VGLiaUoxzeGHVRmh2lpnLJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718631998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YwDn+ALYScRZged3Jz9L26H1pu7KAq3NtPYl9fQOKlA=;
	b=3CYH0H85DA/C3TkXLI/vmJDAR6W1x8yMoPspSliboeV0zcOI+N7JNedFqmCjewXVw99puk
	nOlQGMJmVDzbm/CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OFmSDDIf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3CYH0H85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718631998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YwDn+ALYScRZged3Jz9L26H1pu7KAq3NtPYl9fQOKlA=;
	b=OFmSDDIfUAc8DMPYmitgCUSxKiWJMzgh/7rpBV+86F4a2RbwN4iYa8HwqUZyTYysGxikva
	DULCwzCeVU6XAubRtvjnUPgOlcCMSzHME2bpJeOKlJwX/uCPYCRhBAOo3yvthFMWMGwitW
	Vc/Dto2+VGLiaUoxzeGHVRmh2lpnLJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718631998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YwDn+ALYScRZged3Jz9L26H1pu7KAq3NtPYl9fQOKlA=;
	b=3CYH0H85DA/C3TkXLI/vmJDAR6W1x8yMoPspSliboeV0zcOI+N7JNedFqmCjewXVw99puk
	nOlQGMJmVDzbm/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57B7813AAA;
	Mon, 17 Jun 2024 13:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UHQ9FT4+cGZWSgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 17 Jun 2024 13:46:38 +0000
Date: Mon, 17 Jun 2024 15:46:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: linux-btrfs@vger.kernel.org, Igor Raits <igor@gooddata.com>,
	Jan Cipa <jan.cipa@gooddata.com>,
	Zdenek Pesek <zdenek.pesek@gooddata.com>,
	Daniel Secik <daniel.secik@gooddata.com>
Subject: Re: Linux 6.9.y btrfs: "NULL pointer dereference in
 attach_eb_folio_to_filemap" and "BUG: soft lockup" issues
Message-ID: <20240617134637.GG25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAK8fFZ5KVjrg0OO1eEXyC85Eg=97oP_CWvOdQ=1ZFKLKLOojyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8fFZ5KVjrg0OO1eEXyC85Eg=97oP_CWvOdQ=1ZFKLKLOojyw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6FA1560187
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi,

On Mon, Jun 17, 2024 at 01:33:59PM +0200, Jaroslav Pulchart wrote:
> Hello,
> 
> We recently upgraded part of our production environment to kernel
> 6.9.y. Since then, we've been encountering random kernel "NULL pointer
> dereference" and "soft lockup" errors when using BTRFS. These issues
> occur sporadically, sometimes after several days, and I haven't been
> able to reproduce them consistently. Due to this unpredictability,
> bisecting is not a feasible option.
> 
> Attached are console logs from some instances of these issues:
> * "NULL pointer dereference" in "btrfs.issue.1.log"
> * "soft lockup" in "btrfs.issue.1.log"
> Any assistance with investigating and resolving these problems would
> be greatly appreciated.

thanks for the report, the symptoms match the problem that was fixed
recently by commit f3a5367c679d ("btrfs: protect folio::private when
attaching extent buffer folios").

> [1072053.328255] CPU: 15 PID: 2354438 Comm: kworker/u195:18 Tainted: G            E      6.9.3-1.gdc.el9.x86_64 #1

6.9.3 does not have the fix yet (unless you're using a manually patched
kernel), it's in 6.9.5.

