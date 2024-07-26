Return-Path: <linux-btrfs+bounces-6734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B3B93D785
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A851C23127
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 17:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D64517C7D7;
	Fri, 26 Jul 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S3TsJ/AG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kGtSJ7pY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S3TsJ/AG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kGtSJ7pY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FA3101F7
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014396; cv=none; b=Wqhet8DIcQHIL4eWl7Ed+NdlPGo5d9XWhbSs+yg+K961XjmfxjffGJ7w5byg+06xdA+RhTEdByKNxVGop0vUNh1GszwDY7XaY0HWyO7Bdu2i4u7jPxaY5ucMfFnDQTXkdgtMyv0jAC0t+qiwSfmIJbAtOqQa65bVke7Ki63oCXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014396; c=relaxed/simple;
	bh=k/PYtgRjxHwmI+6SdknERBvMrkLZ1Ox+mzMLI1+HwyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pooUVR44zBEF8YvR9H5xLOwldfhOHnRZ8hNKrQ+Yd+DzPPW0a6254etqe4bYySMYjDWWWqI0xYpkxS86TH0sl6NHmVpDplirr5zU5W3N1Aa7lwa7SoyU2LU7MtgnHKvQ6CeX4u/hQRCY3uOxAuP+hdS7Fmzhzp4ubhGd8ZCa/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S3TsJ/AG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kGtSJ7pY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S3TsJ/AG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kGtSJ7pY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49F2821C0E;
	Fri, 26 Jul 2024 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722014392;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NatbBiAFmqqK7xUCY6dgulnI/c2bTkqdTtDj7v4pxig=;
	b=S3TsJ/AGGFPh7cT+ROu0MUcHijPMerF61ayJ9VDr7/vJaWGNXnX1sB5PIlGWTubRqW2kOr
	Tjmi0k2sG8A69lpBBq0YquNIGlXsze2F9IObRGJcrkUTFEWr8Gv2DWva0G84UCqc4IIh4v
	c6s8bCpDlfmEneRDLgsgHLaCZUBX5jU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722014392;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NatbBiAFmqqK7xUCY6dgulnI/c2bTkqdTtDj7v4pxig=;
	b=kGtSJ7pY0c7m2I32Mcrlmc57Gvc7K3/vXocvh+l2565rXH5VcViyfaBqNfB+28ZOsa3wh6
	1Rg+H6M2tibhJ6Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="S3TsJ/AG";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kGtSJ7pY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722014392;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NatbBiAFmqqK7xUCY6dgulnI/c2bTkqdTtDj7v4pxig=;
	b=S3TsJ/AGGFPh7cT+ROu0MUcHijPMerF61ayJ9VDr7/vJaWGNXnX1sB5PIlGWTubRqW2kOr
	Tjmi0k2sG8A69lpBBq0YquNIGlXsze2F9IObRGJcrkUTFEWr8Gv2DWva0G84UCqc4IIh4v
	c6s8bCpDlfmEneRDLgsgHLaCZUBX5jU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722014392;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NatbBiAFmqqK7xUCY6dgulnI/c2bTkqdTtDj7v4pxig=;
	b=kGtSJ7pY0c7m2I32Mcrlmc57Gvc7K3/vXocvh+l2565rXH5VcViyfaBqNfB+28ZOsa3wh6
	1Rg+H6M2tibhJ6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FEBC138A7;
	Fri, 26 Jul 2024 17:19:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P2cTC7jao2aqTgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jul 2024 17:19:52 +0000
Date: Fri, 26 Jul 2024 19:19:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
	Mark Harmstone <maharmstone@meta.com>
Subject: Re: [PATCH 1/3] btrfs-progs: use libbtrfsutil for btrfs subvolume
 create
Message-ID: <20240726171946.GM17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240628145807.1800474-1-maharmstone@fb.com>
 <20240628145807.1800474-2-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628145807.1800474-2-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 49F2821C0E
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]

On Fri, Jun 28, 2024 at 03:56:47PM +0100, Mark Harmstone wrote:
> +	err = btrfs_util_create_subvolume(dst, 0, NULL, inherit);

Please use functions with the new naming scheme,
btrfs_util_subvolume_create()

> +
> +static int qgroup_inherit_add_group(struct btrfs_util_qgroup_inherit **inherit,
> +				    const char *arg)
> +{
> +	enum btrfs_util_error err;
> +	u64 qgroupid;
>  
> -		memset(&args, 0, sizeof(args));
> -		strncpy_null(args.name, newname, sizeof(args.name));
> -		ret = ioctl(fddst, BTRFS_IOC_SUBVOL_CREATE, &args);
> +	if (!*inherit) {
> +		err = btrfs_util_create_qgroup_inherit(0, inherit);

btrfs_util_qgroup_inherit_create()

> +		if (err) {
> +			error_btrfs_util(err);
> +			return -1;
> +		}
>  	}

