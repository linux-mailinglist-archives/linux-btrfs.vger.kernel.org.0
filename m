Return-Path: <linux-btrfs+bounces-10225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AB39ECBC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 13:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B53285E2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D12210E7;
	Wed, 11 Dec 2024 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lovTyUHw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mbid0TwV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lovTyUHw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mbid0TwV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32975209660
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918926; cv=none; b=LXfyuAY/5FpzydftHSi9DzUBqUwQghT0g8dagJCvriKErHDUJgGx8St+BEqvtA6tPvCli9noXqgJl/YKKPtfvsfsJZzR7Wl3yhe0JHAZQGqeIrxQz1oV7MdFAXasjrU9HN/a69uGdwi7Lr9LUAXvt7Ug72ZVPzo6TchkknmDAW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918926; c=relaxed/simple;
	bh=ZhrD5OtPEF6zm16mY0KaHgUFuRDvk9vNTTqQ0kYojco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmeJJdHdoQ7zyoI8Xvxxv5OfiJXzoF4sK1h9aJHOxMssFL8Da3ZIzjJ3EYY5ApuDK2LokvJRopOyjrQU+wkbcAam2PKvEKjLwZLWj+wU1OwaDrapyu5oabX/B8oTY6smBuogqgxqlDl+1d+Lo2C82VUZQ6+xSLZpRu9Zrkdfp9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lovTyUHw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mbid0TwV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lovTyUHw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mbid0TwV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E0E61F6E6;
	Wed, 11 Dec 2024 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733918923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqNX3hmDuY8IGlrx++1ldT+5gpRYdx8mQ4jCJ38mzRg=;
	b=lovTyUHw0ZP2dEeO3kZq9cBwYpXbMXnQGV8vhWmmuDJG2H208AH0JpxB7Q/5wzGIsRq8sg
	dOr9Br/7P8idN9tH/y/Iweu5E4R+6tCAL2b7gBpRUJUPUp+27tGHXX6+8nzCtfswathjCp
	wgnJwq6Wr35YY7eW8h/hYF7bY9KxK04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733918923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqNX3hmDuY8IGlrx++1ldT+5gpRYdx8mQ4jCJ38mzRg=;
	b=Mbid0TwViZtUi6nJMzzFy/bhi+UEzqgHEzfF5pDvaimSuLVTGdFAzEb7h624GNlyMojJ3e
	bhqZNJqo1nLxs+BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lovTyUHw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Mbid0TwV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733918923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqNX3hmDuY8IGlrx++1ldT+5gpRYdx8mQ4jCJ38mzRg=;
	b=lovTyUHw0ZP2dEeO3kZq9cBwYpXbMXnQGV8vhWmmuDJG2H208AH0JpxB7Q/5wzGIsRq8sg
	dOr9Br/7P8idN9tH/y/Iweu5E4R+6tCAL2b7gBpRUJUPUp+27tGHXX6+8nzCtfswathjCp
	wgnJwq6Wr35YY7eW8h/hYF7bY9KxK04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733918923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqNX3hmDuY8IGlrx++1ldT+5gpRYdx8mQ4jCJ38mzRg=;
	b=Mbid0TwViZtUi6nJMzzFy/bhi+UEzqgHEzfF5pDvaimSuLVTGdFAzEb7h624GNlyMojJ3e
	bhqZNJqo1nLxs+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D5D11344A;
	Wed, 11 Dec 2024 12:08:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OJSZDcuAWWc4fgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 11 Dec 2024 12:08:43 +0000
Date: Wed, 11 Dec 2024 13:08:59 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: Zorro Lang <zlang@kernel.org>, linux-btrfs@vger.kernel.org,
	ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
Message-ID: <Z1mA2wzjW0hpQxUH@yuki.lan>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan>
 <Z029S0wgjrsv9qHL@yuki.lan>
 <20241202144208.GB321427@pevik>
 <20241209055309.54x5ngu3nikr3tce@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241209061416.GB180329@pevik>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209061416.GB180329@pevik>
X-Rspamd-Queue-Id: 4E0E61F6E6
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi!
> Well, "Testing only" in the help (-h) was added there to suggest it's for
> testing/debugging LTP, not a production testing. But newer mind, I'll implement
> Cyril's suggestion, real usage justify it. + I'll add LTP_FORCE_SINGLE_FS_TYPE.
> 
> We could allow more filesystems, e.g.  instead of running LTP few times with
> different LTP_SINGLE_FS_TYPE value: e.g.
> 
> for fs in ext4 xfs btrfs; do LTP_SINGLE_FS_TYPE=fs ioctl_ficlone02; done
> 
> we could introduce support for particular filesystems
> LTP_FILESYSTEMS="ext4,xfs,btrfs" ioctl_ficlone02

That is stil not equivalent if you run it with a whole LTP. We would
have to run each test that uses device for all LTP_FILESYSTEMS, since
many of the testcases does use device but does not use .all_filesystems.

So all in all I think that LTP_SINGLE_FS_TYPE is good enough solution.

Or we can try to rething the whole thing, but it's getting quite
complicated with all the options we have.

-- 
Cyril Hrubis
chrubis@suse.cz

