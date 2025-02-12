Return-Path: <linux-btrfs+bounces-11423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8890A33346
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 00:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4C53A4894
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 23:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76682512EE;
	Wed, 12 Feb 2025 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i7vTfgav";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DrzWNduS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ugrfm7JU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="isU0EQE/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E1820011F;
	Wed, 12 Feb 2025 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402431; cv=none; b=ME9kTjozkTK5y6fIswvfUpAh5r41BLtE3X/vxWOe8YP+u+YygxAACSsGmkGvx9ZpHEj/cHogh6dZspcwuk95BFT46VdzpHHB9dDe/wtRjSvafy7ul9yAs/cnEQIB5Wyvq9A8eX0fhkrAKPE0Z6aH03atuasAHEilh+IQYmLc41E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402431; c=relaxed/simple;
	bh=Hp32G66eOzbBYkIom6LLGCrJIO+bd2f95/T2HGcwL1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UI8tjRqIeiO/M2RJkY3fZdsAwt1NkThITs3w4JRaY7CIMfVzFp998MiO2ZPNkf73RCkSoEI3YXcrdagKiMTA9284DH9gzKlt3Z/aqd8Qc4NGcdiUXyISzsH3MWXCrn4KzVHBV+mgDTPbo0d+KVxYJrHpXS4fcrQxiG+g0/CfpOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i7vTfgav; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DrzWNduS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ugrfm7JU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=isU0EQE/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6E1B22C4A;
	Wed, 12 Feb 2025 23:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739402427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzbc4l2QG3WnT5AiyTiIb2o9Tkzui/W5ICMUCzaZ4P0=;
	b=i7vTfgavaFZ2/ZfR3vFWVzo9FwaHzlLoTQakyhcW8F9sJIqYGV0dndicLmp3b/c6PBe9Ml
	VTaUmkgglefcG0QSpCyUH9gT+R0DA38dQMy9cTj16mW5xtMN4asSqk/izGEe6rKSjhfweG
	Suvns8uJUtjoJz00wQYaXOKPV6N8R0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739402427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzbc4l2QG3WnT5AiyTiIb2o9Tkzui/W5ICMUCzaZ4P0=;
	b=DrzWNduSgnlzC7wE1quAzDxDkBhtN+PxN6eguWTkf+QNUadMznutI2/i0JFj2yszVlc07j
	MrFnyKCHBYm21iBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ugrfm7JU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="isU0EQE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739402426;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzbc4l2QG3WnT5AiyTiIb2o9Tkzui/W5ICMUCzaZ4P0=;
	b=ugrfm7JU+/rnR+jXyNBLC/Ju7oIjuBPLJmY94zounXOD3Bwm8krWfhNC4TjWI/FJTRd9aM
	l4Qp/Bpy89L5O7IezCqWYFOdqDNi2dgGGyf9fIWslK5o+OG4PYOq6NVVmcTWRC8kIsaueF
	xKR0aAPSiEMF3LSRsQEuXfVrAe+KDso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739402426;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzbc4l2QG3WnT5AiyTiIb2o9Tkzui/W5ICMUCzaZ4P0=;
	b=isU0EQE/JbehGjMKp0YUTH7+foME4pID6HFCuIR3F8h2f9SmlfZ5Or0JFAYu6KW+mrhY3x
	kkHlUlg+0iE5GsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C46D513874;
	Wed, 12 Feb 2025 23:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A168L7osrWfpVwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Feb 2025 23:20:26 +0000
Date: Thu, 13 Feb 2025 00:20:25 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 5/8] btrfs/205: avoid test failure when running with
 nodatasum mount option
Message-ID: <20250212232025.GX5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1739379182.git.fdmanana@suse.com>
 <d30273c05a30b3d177277a05e82c52a998779907.1739379185.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d30273c05a30b3d177277a05e82c52a998779907.1739379185.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: D6E1B22C4A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Feb 12, 2025 at 05:01:53PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently the test fails when we pass "-o nodatasum" in MOUNT_OPTIONS and
> the reason is because we enable compression, with "chattr +c", on a file
> and then try to clone from it to a file with nodatasum inherited from the
> mount options, which results in the clone ioctl to fail with -EINVAL since
> it's not possible to clone from datasum to nodatasum and vice-versa.
> 
> Fix this by removing the "chattr +c", as it's not needed and we already
> exercise the compression scenario by explicitly cycle mounting the scratch
> device with "-o compress". This also allows us to exercise cloning the
> "foo1" file without compression. I originally added the "chattr +c" call
> but this was probably an oversight while debugging something.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

