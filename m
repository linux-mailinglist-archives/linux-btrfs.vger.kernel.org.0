Return-Path: <linux-btrfs+bounces-7072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D96C194D64D
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 20:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0276DB2139A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 18:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3E114B96C;
	Fri,  9 Aug 2024 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hLpPnime";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3OBDKqWB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0dlEvo2k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7fU3By5E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462BE2F41
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228465; cv=none; b=a8S/loV7Jf0UmPWMYjTkUsYkbCjmI7QqiGZ00wsH/QtFcWkKNyh4k8QTc/lRi8HQrA1LziBAHBxn1eMlhMkJXurT3HU8kQEbFvUHMmVtfZ/0Z2kwlPyiat3BL+tYuHqWpWHltr6YIsx4Po0HuL1NI7mxP70qn1y0RvN1uWoEiig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228465; c=relaxed/simple;
	bh=Jgx3CAfEbxiPj8cHNgs1umNgpLvJO/F3FK9n+CxDsYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyoibPYUuxQ4naFh7taqvhtlpSVyGfOOqcznLDPKDnDFOSuEYzqIR7SHGQt7FVzybWq6zVOtIlMSoDb6nEcqky4g9HbV5c3tJuFW+hsMkBK8V2yRz93vCUPZL1lh/cTpgDPaTZmBwgX6twshh+4AIh3ZVju786JpYE7VR8nm3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hLpPnime; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3OBDKqWB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0dlEvo2k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7fU3By5E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 133E01FFC3;
	Fri,  9 Aug 2024 18:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723228461;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jgx3CAfEbxiPj8cHNgs1umNgpLvJO/F3FK9n+CxDsYU=;
	b=hLpPnime/3uvD8s1xMStr8vrHLDQ+vVJYEV0kMujKrpMF+yAsUmVLF4AgPa24cXWy6w11v
	m0gI3HD+1RyBzl4RU8I3jYZsmHaH724o+CYNqMgp/cP2rc1VqOZyaYrjHGQB7bsFLmYnSg
	8XqCriB5G+IVDi2Gj2Z5U7XKgFqyPN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723228461;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jgx3CAfEbxiPj8cHNgs1umNgpLvJO/F3FK9n+CxDsYU=;
	b=3OBDKqWB2QMl2tnH19lRKEoamVvFIwPGvJFU7yGuWr+vl7A13CBH0BQsXWb2v3bD0BpITt
	XwMJxu0Al2sojNAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0dlEvo2k;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7fU3By5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723228460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jgx3CAfEbxiPj8cHNgs1umNgpLvJO/F3FK9n+CxDsYU=;
	b=0dlEvo2kSDdd0iyLe4af1M1OBxObWIYKNt/BKraZKwdOuzey/5N/3d82eQWVSOS6NlAEwY
	MB650fzSF+eHaVNBOHGHcMLkyTahLgROKQSbONdQgtnUNBtEmt4AWgmQo409kWU+v6PQCk
	dbCNo8nrIYUmdWZgJFzuSoEv4D51A7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723228460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jgx3CAfEbxiPj8cHNgs1umNgpLvJO/F3FK9n+CxDsYU=;
	b=7fU3By5EuZLT8Jf/ZlYbfgr1cBGGOOmStLwo/Posob0hs4yA87MmELn6kJ/0BPNRNH2MbD
	Ko9G1WZk8TvC39BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 003A51398D;
	Fri,  9 Aug 2024 18:34:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UwQnOythtmZoVQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 09 Aug 2024 18:34:19 +0000
Date: Fri, 9 Aug 2024 20:34:18 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add io_uring interface for encoded reads
Message-ID: <20240809183418.GC25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240809173552.929988-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809173552.929988-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 133E01FFC3
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Fri, Aug 09, 2024 at 06:35:27PM +0100, Mark Harmstone wrote:
> Adds an io_uring interface for asynchronous encoded reads, using the
> same interface as for the ioctl. To use this you would use an SQE opcode
> of IORING_OP_URING_CMD, the cmd_op would be BTRFS_IOC_ENCODED_READ, and
> addr would point to the userspace address of the
> btrfs_ioctl_encoded_io_args struct. As with the ioctl, you need to have
> CAP_SYS_ADMIN for this to work.

Where is the CAP_SYS_ADMIN check done? It's not in this patch so I
assume it's somewhere in io_uring but I don't see it. Thanks.

