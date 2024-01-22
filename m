Return-Path: <linux-btrfs+bounces-1619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E634383750C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 22:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541EDB241FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E8948791;
	Mon, 22 Jan 2024 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eyD+viaw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zRAv/w3z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eyD+viaw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zRAv/w3z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709448783
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957935; cv=none; b=peUN/4UpKWFVaUY1GRfZAyx3yNbRlMcKqKp8F6mYQhnro/lg1N3uazhMcouIsAmzaOfjITFnO/6bwyRtqawXRv/3DrUDjM0XtqsxCgfAQtTq+J9gju4HYZtoLIUHy7XH/Vy+SPtVI3mTvu0FYcJJLowEPfZIHm26dFMmJ1dsGf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957935; c=relaxed/simple;
	bh=sUcr5mg1Yn+KM58SOxXr2dwvkae92/Xe77/ZZ44Tjz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqXcR4fIiojz0CSLgbcNN41rn2lhHlEx0VqKZQja9DlpouV+vJGc45eYRvaMuou1WK4QdCQJ5D1uoCPCgSwPRdamTT0fNeAWgS831/Wjc1YrmVrhE6xEWFJhHOlWSG3mNVe7kxnZB8vWDvHieRU874Pws5VkLYe7677hAE5CCKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eyD+viaw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zRAv/w3z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eyD+viaw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zRAv/w3z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B913E21E3F;
	Mon, 22 Jan 2024 21:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705957931;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ls4wPdLbF4XsEOl3aOgUnA+EfFIKDyx8/U5DcRhsnc0=;
	b=eyD+viawA8U5d1BsQNUYYHTubCK/Mg4iGztxWmIdp+9A7ya4l+P90meUeoDEpt2/G2eBFK
	LJxbhFLDIBtMQbcC1MsAgKJ+fPZQzjeiCyHzdmnQ73HawKPiv8AFgWtYrJANHnNljZ8R09
	Wb7UK96qGdQd+wmtbt9t+ydmasM4f2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705957931;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ls4wPdLbF4XsEOl3aOgUnA+EfFIKDyx8/U5DcRhsnc0=;
	b=zRAv/w3z89dcD9iCZbgP4L9Tc4iVvrefZrgTFOEiJD4hdsWxFmYTVl3yd7wOfCqnhhv7/d
	N+ROKJAfb+rT0NDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705957931;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ls4wPdLbF4XsEOl3aOgUnA+EfFIKDyx8/U5DcRhsnc0=;
	b=eyD+viawA8U5d1BsQNUYYHTubCK/Mg4iGztxWmIdp+9A7ya4l+P90meUeoDEpt2/G2eBFK
	LJxbhFLDIBtMQbcC1MsAgKJ+fPZQzjeiCyHzdmnQ73HawKPiv8AFgWtYrJANHnNljZ8R09
	Wb7UK96qGdQd+wmtbt9t+ydmasM4f2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705957931;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ls4wPdLbF4XsEOl3aOgUnA+EfFIKDyx8/U5DcRhsnc0=;
	b=zRAv/w3z89dcD9iCZbgP4L9Tc4iVvrefZrgTFOEiJD4hdsWxFmYTVl3yd7wOfCqnhhv7/d
	N+ROKJAfb+rT0NDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C77A13310;
	Mon, 22 Jan 2024 21:12:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Nt6oISvarmVafgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 22 Jan 2024 21:12:11 +0000
Date: Mon, 22 Jan 2024 22:11:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"wangyugui@e16-tech.com" <wangyugui@e16-tech.com>
Subject: Re: [PATCH 2/2] btrfs: detect multi-dev stripe and disable automatic
 inline checksum
Message-ID: <20240122211150.GC31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705568050.git.naohiro.aota@wdc.com>
 <7ce85c808b96be3c8352ffa03fedbaacf0dc6d27.1705568050.git.naohiro.aota@wdc.com>
 <fb44aa48-fd5d-4b3b-ae87-2ad0d9648b44@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb44aa48-fd5d-4b3b-ae87-2ad0d9648b44@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eyD+viaw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="zRAv/w3z"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[30.83%]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: B913E21E3F
X-Spam-Flag: NO

On Fri, Jan 19, 2024 at 03:29:13PM +0000, Johannes Thumshirn wrote:
> On 18.01.24 09:55, Naohiro Aota wrote:
> > +static void check_striped_block_group(struct btrfs_fs_info *info, u64 type, int num_stripes)
> > +{
> > +	if (btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)].devs_max != 0 ||
> > +	    num_stripes <= BTRFS_INLINE_CSUM_MAX_DEVS)
> > +		return;
> > +
> > +	/*
> > +	 * Found a block group writing to multiple devices, disable
> > +	 * inline automatic checksum.
> > +	 */
> > +	info->fs_devices->striped_writing = true;
> > +}
> > +
> 
> This function adds some overly long lines.

The line length limits are not strict and checkpatch has been updated
from 80 to 100, so it's up to our taste. For the prototypes it's around
85-ish to be ok.

