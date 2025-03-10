Return-Path: <linux-btrfs+bounces-12163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAD8A5A4C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 21:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B040A171B4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5CD1DE4FF;
	Mon, 10 Mar 2025 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aRoiG45g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2Mgd8vo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aRoiG45g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2Mgd8vo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997421CAA6C
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637923; cv=none; b=VzIxRcsxKZ1l/nleVOAOjz/87uJnY/+Bw3uoI+ySCWv+uwO1Qs8Cb0mLoD9x69dguDK3bZmdyMjsOikWWhdXLm25u9Q4BLn9RZE1ZYQwgkB1F/dLVmnvnSKv3uA2sebiR79ghwzVfG5jNaytBf8dpcNvQreJmqsPSazqQN/C7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637923; c=relaxed/simple;
	bh=7OVRsJj3nVnk7IlvcHd7OcVdIxrgAOsNWkCyMgajBlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOobtx3E04beYdXlw+UnGGOOm6up0v+xUI7tqbCGPNmm/2KvZqH05DNttqvYuc34s9BwLGLxoeNr0rWutb1Gh/loTeMzXDJfzBchlwolPWJh5cLWi+kFSrjILegfco1fhrO6pYakCu+pfwlgpP1f2vWSyf548v8JPt4+9r4O7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aRoiG45g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2Mgd8vo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aRoiG45g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2Mgd8vo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 898682116A;
	Mon, 10 Mar 2025 20:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741637919;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Au9R/z/8XOH6sKPE5aYAd/YT5hkg1epSNqdEA914zI=;
	b=aRoiG45gZq0fr4Yc2YDusO/wr3/UUhrmoX3idxEmRziF8bNA87LrIDTyBy04Yq9k/DrCEu
	whmRDocQ024hOSI7Dl+NDDzptLo77TpjruZ86x+VdtbJ48JJumVWKzDiOh8hEtMVFua2kf
	HpkPU6yahi6xFhEVdTCVdjOyzrfOIFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741637919;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Au9R/z/8XOH6sKPE5aYAd/YT5hkg1epSNqdEA914zI=;
	b=B2Mgd8vo0PLm8ODym46Mw8gLdiL9y2qYI9GJuHPgjeGE/6ZRwvtE7G2Mslqul+DZBzwu9P
	IV5DI3IscSO3+4BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741637919;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Au9R/z/8XOH6sKPE5aYAd/YT5hkg1epSNqdEA914zI=;
	b=aRoiG45gZq0fr4Yc2YDusO/wr3/UUhrmoX3idxEmRziF8bNA87LrIDTyBy04Yq9k/DrCEu
	whmRDocQ024hOSI7Dl+NDDzptLo77TpjruZ86x+VdtbJ48JJumVWKzDiOh8hEtMVFua2kf
	HpkPU6yahi6xFhEVdTCVdjOyzrfOIFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741637919;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Au9R/z/8XOH6sKPE5aYAd/YT5hkg1epSNqdEA914zI=;
	b=B2Mgd8vo0PLm8ODym46Mw8gLdiL9y2qYI9GJuHPgjeGE/6ZRwvtE7G2Mslqul+DZBzwu9P
	IV5DI3IscSO3+4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 583011399F;
	Mon, 10 Mar 2025 20:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 25ulFB9Jz2cvIgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 10 Mar 2025 20:18:39 +0000
Date: Mon, 10 Mar 2025 21:18:34 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 2/5] btrfs: add new ioctl CLEAR_FREE
Message-ID: <20250310201834.GF32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740753608.git.dsterba@suse.com>
 <ecc43a72997ae7836c2d227b69924d364698e665.1740753608.git.dsterba@suse.com>
 <0cb33e7e-4390-4647-a277-221f9ddf3640@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cb33e7e-4390-4647-a277-221f9ddf3640@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Mar 10, 2025 at 04:38:25PM +0000, Johannes Thumshirn wrote:
> On 28.02.25 15:49, David Sterba wrote:
> > Add a new ioctl that is an extensible version of FITRIM. It currently
> > does only the trim/discard and will be extended by other modes like
> > zeroing or block unmapping.
> > 
> > We need a new ioctl for that because struct fstrim_range does not
> > provide any existing or reserved member for extensions. The new ioctl
> > also supports TRIM as the operation type.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> 
> [...]
> 
> I /think/ we need some extra checks for zoned here. blkdev_issue_zeroout 
> won't work on zoned devices IFF the 'start' range is not aligned to the 
> write pointer. Also blkdev_issue_discard() on 'unused space' of a zoned 
> filesystem won't do what a user is expecting.
> 
> I think this needs:
> 
> > +static int btrfs_ioctl_clear_free(struct file *file, void __user *arg)
> > +{
> > +	struct btrfs_fs_info *fs_info;
> > +	struct btrfs_ioctl_clear_free_args args;
> > +	u64 total_bytes;
> > +	int ret;
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> 
> 	if (btrfs_is_zoned(fs_info))
> 		return -EOPNOTSUPP;

Right, I'll add it, thanks. As the ioctl is extension of FITRIM, the
same checks should be done (btrfs_ioctl_fitrim).

