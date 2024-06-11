Return-Path: <linux-btrfs+bounces-5656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F59E903EEF
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 16:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B143828911C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2E717D8B7;
	Tue, 11 Jun 2024 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c5/xd8vN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zlVkt2Si";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c5/xd8vN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zlVkt2Si"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD2A28E37;
	Tue, 11 Jun 2024 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116616; cv=none; b=B90GGvdwBc9EELWel4saBKRu5x28yAV0vFeN8TNkJodAKxym1d5g1G1BWy2rf0gGen1tZ0YoiIYcmTlSojAaVLBfZ08MqAyT9XLvNdluSf/YC9zfYagFh2Nqj3o4tIRkGmw3V8wzVYSqN94YGYW0KR6qiZ5GqQL+Os89ZfgpFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116616; c=relaxed/simple;
	bh=tWcDkq4uWRdUF6EuhEA2zFi4IWIjqvVCt7HqoOzeRZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8vlFgA7GFWsx/zbFHEr9yO+FkfEA5yN5HrfSSl/KHPiwfOHI7rNNvs2TVqb+aoy/ijWK5c2AXgAQlnjN9zCzkulAPEZKxO4EMSX0eBKnGoa8kzsfBKqvxVs7SYiPPDQKOLUYlKOQofjmbyGAiZfMPtNfxtYWWGb9/x+hLIHekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c5/xd8vN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zlVkt2Si; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c5/xd8vN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zlVkt2Si; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 942B933827;
	Tue, 11 Jun 2024 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718116612;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DowVRu9TFhrP0/nfeu3duZvffZXs5zr4XS8fPsedEvo=;
	b=c5/xd8vNp8MVzFxcfmqufezFuaJY5T5e32YjnvVsHMD6fOyV0vdlHK/d5qWWQWlLUE+CFD
	gXYVz982X9KPm2Wcx366kWnOfY66KuHvmw3zF1NqBAn2r3JBYfMZ3VcP9g+/F37YrM2e0o
	eSayR5syyjybxPQ5H/01Uod48UDnjUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718116612;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DowVRu9TFhrP0/nfeu3duZvffZXs5zr4XS8fPsedEvo=;
	b=zlVkt2SiawzLhwW0p+dUkhnFAzMr8r4LpJ+RgwdIwlcNUorPSFcvRJ4YqpLopgwc2+nCkn
	xKcmngYLFjxSWUDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718116612;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DowVRu9TFhrP0/nfeu3duZvffZXs5zr4XS8fPsedEvo=;
	b=c5/xd8vNp8MVzFxcfmqufezFuaJY5T5e32YjnvVsHMD6fOyV0vdlHK/d5qWWQWlLUE+CFD
	gXYVz982X9KPm2Wcx366kWnOfY66KuHvmw3zF1NqBAn2r3JBYfMZ3VcP9g+/F37YrM2e0o
	eSayR5syyjybxPQ5H/01Uod48UDnjUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718116612;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DowVRu9TFhrP0/nfeu3duZvffZXs5zr4XS8fPsedEvo=;
	b=zlVkt2SiawzLhwW0p+dUkhnFAzMr8r4LpJ+RgwdIwlcNUorPSFcvRJ4YqpLopgwc2+nCkn
	xKcmngYLFjxSWUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A05E137DF;
	Tue, 11 Jun 2024 14:36:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sy6lHQRhaGaKUgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 11 Jun 2024 14:36:52 +0000
Date: Tue, 11 Jun 2024 16:36:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 1/3] btrfs: rst: remove encoding field from stripe_extent
Message-ID: <20240611143651.GH18508@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
 <20240610-b4-rst-updates-v1-1-179c1eec08f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610-b4-rst-updates-v1-1-179c1eec08f2@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Mon, Jun 10, 2024 at 10:40:25AM +0200, Johannes Thumshirn wrote:
> -#define BTRFS_STRIPE_RAID5	5
> -#define BTRFS_STRIPE_RAID6	6
> -#define BTRFS_STRIPE_RAID1C3	7
> -#define BTRFS_STRIPE_RAID1C4	8
> -
>  struct btrfs_stripe_extent {
> -	__u8 encoding;
> -	__u8 reserved[7];
>  	/* An array of raid strides this stripe is composed of. */
> -	struct btrfs_raid_stride strides[];
> +	__DECLARE_FLEX_ARRAY(struct btrfs_raid_stride, strides);

Is there a reason to use the __ underscore macro? I see no difference
between that and DECLARE_FLEX_ARRAY and underscore usually means that
it's special in some way.

