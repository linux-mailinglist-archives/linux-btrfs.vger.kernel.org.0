Return-Path: <linux-btrfs+bounces-1573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD6832C84
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 16:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A2D285BB0
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DC954BE0;
	Fri, 19 Jan 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IIrjaBtr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8RcWgEzE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ddMCu5u3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oz95iH8q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32454BCF
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jan 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679393; cv=none; b=jmDlY6Gt8nMO7S3uc1towg8OSEaXxyvtqFL/Lbbm31/bcOfklCauF+kLvvdl+x9w+jT06YZQ2c+QyvO1PypoPPntL7Q0oGe1U2ABNgb3L1TOP4KSoipE2PmPx8me3hFrYSc5Bo7plibfu/TkCxkl0yFFi5INU82hT5ThDaQEWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679393; c=relaxed/simple;
	bh=XAiXFZo5CVbfqzm2XbEcIHEC5zOg+nXkSS/zn6MkKwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+/KfLnLy2+8YC2S7sve61rUPAouKSfKyQqn4b7mhHHTuDCrBLSK7euFVflmLYHUB4GIasqYxiOsU9Qa0v8BN7dYjIDQw7q+WxNTHEQjuzKjYoBCQOGPWZiQaqkRLpse6RMRCVDLDzBXsZUFqLOMFQDLD6dQRyQQeBQZiYSBV/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IIrjaBtr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8RcWgEzE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ddMCu5u3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oz95iH8q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88C1F21F6C;
	Fri, 19 Jan 2024 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705679388;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p8g/iCX1J0nqy690IG6JrNsXsiw3PY1R5xkuY4e993o=;
	b=IIrjaBtretT4zVjtDkv552X2JDQ6hxs057kukQhehQvjm/wO6CAmZeQBDFrRh8kdnup8nH
	OHe+UVZjMS+oVQM3eqJWp6v4MfCA+sgrsZu2z6lguVIsWnybovo9T5Q5jPPTV3n8rP28AS
	O8TpOLyjwWqKKjDL1nvJLCUy+K9Qk3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705679388;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p8g/iCX1J0nqy690IG6JrNsXsiw3PY1R5xkuY4e993o=;
	b=8RcWgEzEBjxsohwgZH+DeTIC3XkQDL0vyXEe//tuQYHBtZU3b/wqwKf3I98MFWU+0Xa/1w
	+Xx2mhDdwOQqG2DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705679387;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p8g/iCX1J0nqy690IG6JrNsXsiw3PY1R5xkuY4e993o=;
	b=ddMCu5u3ualqh2DZLRTRSzPmhUMq2HYN8HqelOr9yhSh6IVSBcm+RIAJPCAmL1ix2TVaNR
	a5gr5WypaiUpxWErDaDmM6NU5vfJNJfw0qfxjfGIhN+aqFs1ytsBbB07ILv5TnL8ZjFu4B
	H4u6WxMiKhRXt3eqAOC+eD+qd1YaugQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705679387;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p8g/iCX1J0nqy690IG6JrNsXsiw3PY1R5xkuY4e993o=;
	b=Oz95iH8qgALhP/PKy80C9cEu7idUF1MecY5g+zqv5PrT2aUcSmxs5GN8qGIoptT62YCgYY
	apJ1J3ObUjLshXDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 716D31343E;
	Fri, 19 Jan 2024 15:49:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aukuGxuaqmVSCQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 19 Jan 2024 15:49:47 +0000
Date: Fri, 19 Jan 2024 16:49:27 +0100
From: David Sterba <dsterba@suse.cz>
To: Roman Mamedov <rm@romanrm.net>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	wangyugui@e16-tech.com
Subject: Re: [PATCH 0/2] btrfs: disable inline checksum for multi-dev striped
 FS
Message-ID: <20240119154927.GS31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705568050.git.naohiro.aota@wdc.com>
 <20240118141231.5166cdd7@nvm>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118141231.5166cdd7@nvm>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ddMCu5u3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Oz95iH8q
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 88C1F21F6C
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu, Jan 18, 2024 at 02:12:31PM +0500, Roman Mamedov wrote:
> On Thu, 18 Jan 2024 17:54:49 +0900
> Naohiro Aota <naohiro.aota@wdc.com> wrote:
> 
> > There was a report of write performance regression on 6.5-rc4 on RAID0
> > (4 devices) btrfs [1]. Then, I reported that BTRFS_FS_CSUM_IMPL_FAST
> > and doing the checksum inline can be bad for performance on RAID0
> > setup [2]. 
> > 
> > [1] https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
> > [2] https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> > 
> > While inlining the fast checksum is good for single (or two) device,
> > but it is not fast enough for multi-device striped writing.
> 
> Personal opinion, it is a very awkward criteria to enable or disable the
> inline mode. There can be a RAID0 of SATA HDDs/SSDs that will be slower than a
> single PCI-E 4.0 NVMe SSD. In [1] the inline mode slashes the performance from
> 4 GB/sec to 1.5 GB/sec. A single modern SSD is capable of up to 6 GB/sec.
> 
> Secondly, less often, there can be a hardware RAID which presents itself to the
> OS as a single device, but is also very fast.

Yeah I find the decision logic not adapting well to various types of
underlying hardware. While the multi-device and striped sounds like a
good heuristic it can still lead to worse performance.

> Sure, basing such decision on anything else, such as benchmark of the
> actual block device may not be as feasible.

In an ideal case it adapts to current load or device capabilities, which
needs a feedback loop and tracking the status for the offloading
decision.

