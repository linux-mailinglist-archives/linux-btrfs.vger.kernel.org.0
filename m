Return-Path: <linux-btrfs+bounces-4534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084D88B1174
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F80B27B6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D7A16D4DD;
	Wed, 24 Apr 2024 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iaTMZXRp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mwxlxpjH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DKI0OE9o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/SOM4I7s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B1C16D4E2
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980911; cv=none; b=XJE7JhaYYDvBDW4zUN6fnDbJT1C+djjzlVi90O7LF4w4ZYkWe5heIKiGYdZXVN+4VGa+KPe/jjZO/tFXDl3fQHiXusV90Sux9CKBi9z+IsRxvKjLinQy7Vn/XJcQPyyNwbUNwrAnWsvB8kFoFQzVPoseqbAP3lSI7FQmV2PF+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980911; c=relaxed/simple;
	bh=vIZSivWIiOWYJXDiKbzzTC5rHmOkn5BVs3vSyABiL+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTS+ht+gtc+u10dmH5qxV95YIjUJa/MgD+HlolCKhnDuiOBebcAxtsYLKDMWe93pjZQ79ernQjI4WNlJDSVc5cZ6O4Sc/X4z4jB5VDIEPt8+0L5esXSM+w7vSX0Vf1yS8Ki4BDfUHcO/iqZfr+MX83Jrg5sIEQ0x3qNepGMbJXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iaTMZXRp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mwxlxpjH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DKI0OE9o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/SOM4I7s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC3A81FB4F;
	Wed, 24 Apr 2024 17:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713980908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VVz+qNEDs52szhwsIGzVrZr+eF5pBEB8LWJwmTYZ74=;
	b=iaTMZXRpnrZKa8IGG2gRoJj8vyqhjuFl4oivO3lMVqcqU3VNQNh/QCvUQD0gvyBmh+DIpJ
	wQZEWDLsOUQKeY4ivu7PWHtFmywomLKGdNVLLUj8uMzkKj/ou40u7P4UTPJv6PLIQJHHY3
	fjIjDIxq/r2hr3Ap56D0lxEBVrKAMLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713980908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VVz+qNEDs52szhwsIGzVrZr+eF5pBEB8LWJwmTYZ74=;
	b=mwxlxpjHTIALfeFrx4Ashy/2SKINrRMFSij+Dr9WiAUbVYO61tGOXkQ5qMfz8pPgiwHP51
	LCon1GWiRs5+MaDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DKI0OE9o;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/SOM4I7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713980907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VVz+qNEDs52szhwsIGzVrZr+eF5pBEB8LWJwmTYZ74=;
	b=DKI0OE9o8ZmiyIq8AZ10DT0GvGIBatTZVy+pWdNze9FPFnBvUDnXM88F/Se1hpBAV1cSFk
	3w76fJrsGjt5hSVPobrjcCeF2VccoDbCKxmBtTdkAliYjrBl5RA4iYLQdaEFNJQmqKEEgr
	YCylhCCWSfgy3Bituwqe3ehqaXE2jTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713980907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VVz+qNEDs52szhwsIGzVrZr+eF5pBEB8LWJwmTYZ74=;
	b=/SOM4I7sKJ+jLkRJtB7YcSLmaZDJfdUb3hyga9NuOFpwmx11/5RLIRe0dToZAiUIaaCsWW
	GRQ2LQbSSX5ukCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0C6D13690;
	Wed, 24 Apr 2024 17:48:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QCJwMutFKWacTgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 24 Apr 2024 17:48:27 +0000
Date: Wed, 24 Apr 2024 12:48:27 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 13/17] btrfs: push lock_extent into cow_file_range_inline
Message-ID: <q66jaryaxqxayu57swzozge6a24ofhsql7djeoe6q3ac7istp5@3kud4xskaug2>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <c55f19e4ce3d4c1890f80b2d665dc01fcd92ae51.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c55f19e4ce3d4c1890f80b2d665dc01fcd92ae51.1713363472.git.josef@toxicpanda.com>
X-Spam-Flag: NO
X-Spam-Score: -3.82
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DC3A81FB4F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.82 / 50.00];
	BAYES_HAM(-2.81)[99.20%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On 10:35 17/04, Josef Bacik wrote:
> Now that we've pushed the lock_extent() into cow_file_range() we can
> push the extent locking into cow_file_range_inline() and move the
> lock_extent in cow_file_range() to after we call
> cow_file_range_inline().
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

