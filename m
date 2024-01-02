Return-Path: <linux-btrfs+bounces-1193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B78028220D7
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 19:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7151C22921
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 18:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF8D156E4;
	Tue,  2 Jan 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1xre6aSK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="etq5xy10";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sz6oBr74";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MGPPpzPY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CE8156DD
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jan 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCDCC1F399;
	Tue,  2 Jan 2024 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704219440;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1Xi3Od2enTTifyTHHlVGYwFF4uwY6bXbRy5hj5S/aA=;
	b=1xre6aSKJt6wKQqoxBW37M0vxu5jn2mO1ASYmyZX+JVgMaZvLSFMqmT0ztLDxAxou7WJb7
	qrPuilztbziIqKRNAr3lPETcsuiMkV3esRW6PMM4ENt36Ysm/FLtWN0hQ8UGbsy6JEv2mD
	7UPWfhA8mNXt1rK9nNUBtOrs6hWuk5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704219440;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1Xi3Od2enTTifyTHHlVGYwFF4uwY6bXbRy5hj5S/aA=;
	b=etq5xy10f7MCIWa/aJj3wvKHxQdEgsvzSQFFXZ/4+k8mp2gfVQrVw3egGNRpnJ9ci4x7FW
	/KuWs446JaTX4MAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704219439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1Xi3Od2enTTifyTHHlVGYwFF4uwY6bXbRy5hj5S/aA=;
	b=sz6oBr74mJnUiEkCkIXxYeBRPRTsTQWUhYPhsnbMJcz1LV8syDGuaF73jzvFs9JQjWxCyH
	e1gS846PRgQTH3pxs8kvS2kLRIGm4HMV0nR96rjhe9SMxOCXaxf0yiquUyffe7olHH5Jn1
	N3AG9Do/hs+5rJ5IpIT1VyF36rD2rI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704219439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1Xi3Od2enTTifyTHHlVGYwFF4uwY6bXbRy5hj5S/aA=;
	b=MGPPpzPYNFQopeWlmIpOibcwMs+t8rxAcg/ClA7dJ+QXXmbgsDOOMiQOV6aHc0nSCvvnx2
	+eNxhScN4iVMteDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9ECC71340C;
	Tue,  2 Jan 2024 18:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OpssJi9TlGVuHAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Jan 2024 18:17:19 +0000
Date: Tue, 2 Jan 2024 19:17:08 +0100
From: David Sterba <dsterba@suse.cz>
To: kreijack@inwind.it
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9][btrfs-progs] Remove unused dirstream variable
Message-ID: <20240102181708.GC15380@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1702148009.git.kreijack@inwind.it>
 <20231214161749.GA9795@twin.jikos.cz>
 <6e4b2c09-b820-4ba8-8117-d13f3556e426@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e4b2c09-b820-4ba8-8117-d13f3556e426@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: *
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sz6oBr74;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MGPPpzPY
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[inwind.it];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FREEMAIL_TO(0.00)[inwind.it];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: BCDCC1F399
X-Spam-Flag: NO

On Sat, Dec 30, 2023 at 12:20:54PM +0100, Goffredo Baroncelli wrote:
> On 14/12/2023 17.17, David Sterba wrote:
> > On Sat, Dec 09, 2023 at 07:53:20PM +0100, Goffredo Baroncelli wrote:
> >> From: Goffredo Baroncelli <kreijack@inwind.it>
> >>
> >> For historical reason, the helpers [btrfs_]open_[file_or_]dir() work with
> >> directory returning the 'fd' and a 'dirstream' variable returned by
> >> opendir(3).
> >>
> >> If the path is a file, the 'fd' is computed from open(2) and
> >> dirstream is set to NULL.
> >> If the path is a directory, first the directory is opened by opendir(3), then
> >> the 'fd' is computed using dirfd(3).
> >> However the 'dirstream' returned by opendir(3) is left open until 'fd'
> >> is not needed anymore.
> >>
> >> In near every case the 'dirstream' variable is not used. Only 'fd' is
> >> used.
> > 
> > As I'm reading dirfd manual page, dirfd returns the internal file
> > descriptor of the dirstream and it gets closed after call to closedir().
> > This means if we pass a directory and want a file descriptor then its
> > lifetime matches the correspoinding DIR.
> > 
> >> A call to close_file_or_dir() freed both 'fd' and 'dirstream'.
> >>
> >> Aim of this patch set is to getrid of this complexity; when the path of
> >> a directory is passed, the fd is get directly using open(path, O_RDONLY):
> >> so we don't need to use readdir(3) and to maintain the not used variable
> >> 'dirstream'.
> > 
> > Does this work the same way as with the dirstream?
> > 
> 
> Hi David, are you interested in this patch ? I think that it is a
> great simplification.

Yes, it's a good cleanup, I'll get to that after 6.7 is released.

