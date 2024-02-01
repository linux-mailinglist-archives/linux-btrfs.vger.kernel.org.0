Return-Path: <linux-btrfs+bounces-1986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4538844F0C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 03:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D3F1F27F05
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 02:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875D9210F6;
	Thu,  1 Feb 2024 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHKQkbmH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jlVNqFnd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHKQkbmH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jlVNqFnd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A81A27C
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706753696; cv=none; b=YZXFG63v/3KRBX3YR/ov0B0KpLsXtaBFU1fKxq/G35a0ZNZT8iate7emlL28JAeWdz0xMrEW7JWOOlsS5FPtvnJYVLIuu7X8m4BDzKzhN55wKpNCDZ9oNDR6byBAW7gJk1w74orOnR49dIjorpemdaMQWeEYHvMaSxWtMx4kOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706753696; c=relaxed/simple;
	bh=5Pg8DjKHNkyzgZl3+kIv1giWWlLYTe5wH6+uBDbDKSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLq29IeApn6iy087Jqx4yOeeo8E0uBxl7hD6nO3fFVuuBNov8GtgFphVfmBJb/YOLxlEX2M0Oab1ZOKg/pco8kYDpS5rbWEZHwT/KNH2+4GfRDgHmvE4J7LTP3KKjF2qTAzT02ejUsrIMXjljviGArnPiLRBxzyCHFDNAidiJLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHKQkbmH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jlVNqFnd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHKQkbmH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jlVNqFnd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A55C210F0;
	Thu,  1 Feb 2024 02:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706753693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYhW3OZU25iyUjSA0aJ6wrB8SPbfgL++mGMpQa+RPu0=;
	b=rHKQkbmHLuVifQPF3mT/K4az5M7zGkGXqs7rx5opOQOcEDBEeYg21Tvs6/3PvwtLuPN9Gu
	RZnwPy1DG0zm9GsyxDJRXc7zGsZgV7noPCryqgkGdBPB3YBvGLskNv89zSX0oWUJS/5fwJ
	VpCBT5+fG4RKCEKx3aNpoiZmRhfpwu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706753693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYhW3OZU25iyUjSA0aJ6wrB8SPbfgL++mGMpQa+RPu0=;
	b=jlVNqFnddjLeGY93lpNX8Up4nWvhR06DNml6lLw+XTVHANsTZow1kSVPlUPjXElF9aDj4R
	Qzbr/Mv5Loxd1vCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706753693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYhW3OZU25iyUjSA0aJ6wrB8SPbfgL++mGMpQa+RPu0=;
	b=rHKQkbmHLuVifQPF3mT/K4az5M7zGkGXqs7rx5opOQOcEDBEeYg21Tvs6/3PvwtLuPN9Gu
	RZnwPy1DG0zm9GsyxDJRXc7zGsZgV7noPCryqgkGdBPB3YBvGLskNv89zSX0oWUJS/5fwJ
	VpCBT5+fG4RKCEKx3aNpoiZmRhfpwu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706753693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYhW3OZU25iyUjSA0aJ6wrB8SPbfgL++mGMpQa+RPu0=;
	b=jlVNqFnddjLeGY93lpNX8Up4nWvhR06DNml6lLw+XTVHANsTZow1kSVPlUPjXElF9aDj4R
	Qzbr/Mv5Loxd1vCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 11FCC138FB;
	Thu,  1 Feb 2024 02:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nnhABJ3+umV1fQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 01 Feb 2024 02:14:53 +0000
Date: Thu, 1 Feb 2024 03:14:27 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"wangyugui@e16-tech.com" <wangyugui@e16-tech.com>,
	"clm@meta.com" <clm@meta.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: Re: [PATCH v2] btrfs: introduce sync_csum_mode to tweak sync
 checksum behavior
Message-ID: <20240201021427.GV31555@suse.cz>
Reply-To: dsterba@suse.cz
References: <75b81282919c566735f80f71c57343e282c40bed.1706685025.git.naohiro.aota@wdc.com>
 <20240131190459.GS31555@twin.jikos.cz>
 <lti7awd56rvcvlmviq327ueqjleeo5cvmx3w74bulka5btvfoj@u6zmx3xrbybg>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lti7awd56rvcvlmviq327ueqjleeo5cvmx3w74bulka5btvfoj@u6zmx3xrbybg>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.30)[75.01%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.10

On Thu, Feb 01, 2024 at 01:28:49AM +0000, Naohiro Aota wrote:
> On Wed, Jan 31, 2024 at 08:04:59PM +0100, David Sterba wrote:
> > On Wed, Jan 31, 2024 at 04:13:45PM +0900, Naohiro Aota wrote:
> > > +#ifdef CONFIG_BTRFS_DEBUG
> > > +static ssize_t btrfs_sync_csum_show(struct kobject *kobj,
> > > +				    struct kobj_attribute *a, char *buf)
> > > +{
> > > +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
> > > +
> > > +	switch (fs_devices->sync_csum_mode) {
> > > +	case BTRFS_SYNC_CSUM_AUTO:
> > > +		return sysfs_emit(buf, "auto\n");
> > > +	case BTRFS_SYNC_CSUM_FORCE_ON:
> > > +		return sysfs_emit(buf, "on\n");
> > > +	case BTRFS_SYNC_CSUM_FORCE_OFF:
> > > +		return sysfs_emit(buf, "off\n");
> > 
> > We're using numeric indicators for on/off in other sysfs files, though
> > here it's a bit more readable.
> 
> But, numeric indicators (0/1) cannot indicate tripe values well. Should I
> represent it as e.g, "auto" => 0, "on" => 1, "off" => -1?

We can do 0, 1, auto, the same values should work as the input. The
parsing will do a special case for auto.

