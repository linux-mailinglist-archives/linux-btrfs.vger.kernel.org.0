Return-Path: <linux-btrfs+bounces-4020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EB589B77D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 08:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF781C20FE0
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 06:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9018EDDBB;
	Mon,  8 Apr 2024 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wS+8MINz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZIeL07iO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tJcsiLM9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IgBSzHR8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F266279FE;
	Mon,  8 Apr 2024 06:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712556800; cv=none; b=BixXefMYTPyo7f9VSCEowXS1+/NtCckX9xp6JzKMdKbQfwMQxjXrUmZSTjDkp1fWPhZl4Xd45bus5WuKjhRFItkMdzyxPARzcmynZCoFmznZQfju3/qkAIDm+f9wZtX9wI+ptYmmSzYZ2XV6eKweJK3l1xxp+NwFxdIgMKDibzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712556800; c=relaxed/simple;
	bh=kX4iNy9g914TaLyb9xAbe6QbcMEgJZjylKM/gTSbUfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSZQMK22Elg1MGctmDzuSzJYPFTMjB9zrN95BfuqE1dWt/B9fZN8SFUvmNDN851rAc5Bl3opBb41YkN0s+5rozUq2s57rhQJmqIE6+Ry0mNvvb2YEZ1MHsCo9RgU4ptAeqCahfRJEqe7TUWF+1sTDS/OsIXk6wdNX1AvyY5/xRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wS+8MINz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZIeL07iO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tJcsiLM9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IgBSzHR8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C034B22571;
	Mon,  8 Apr 2024 06:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712556797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3QdgHrFG2EvzFMxlMGRINEqFWT3mWVirFWMqt1bjjQ=;
	b=wS+8MINzFwttOqfeJBwx2UfaOhCe62U9m/qScDwu2A7v3A9xqvt5Q9jP4122BHwEoMyckD
	dKfyhAFmRONC7+Os9mo0YRHpbRsuSDcvNyq6b6S/KF2IVnsMcLQmRzp3USaLlwFgymHX8/
	xK+kOctqK8iNxnOmtuWtEvVLVr0B8s8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712556797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3QdgHrFG2EvzFMxlMGRINEqFWT3mWVirFWMqt1bjjQ=;
	b=ZIeL07iO+Eyxn1lfMK2x+z9Jvjp9zsc8jBueOFrGjfIXqBPdcPtLbg4npvCZN+mmfNrf8Y
	RKYVZ6jp9KFXJUCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tJcsiLM9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IgBSzHR8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712556795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3QdgHrFG2EvzFMxlMGRINEqFWT3mWVirFWMqt1bjjQ=;
	b=tJcsiLM9PRNg91ugletEtWTZWwkKDTdYvK+4YpOpUMtqOYddG6FCg3KKJGKY22f2JIUD7a
	eZLvROu67UIg8Tia40yNAELu2mU/c9ukTSyQjw7/F77HCU+6KExaZbPvAe6kFayj7xOLya
	3SFSPrQGcRWKdifMGFA42/o6YrznvgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712556795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3QdgHrFG2EvzFMxlMGRINEqFWT3mWVirFWMqt1bjjQ=;
	b=IgBSzHR8+BcB61Nbq0Zg94AQM2gufClHFSD6N0EvePyUbIjIvjCFjnbLzX8rSw7S5LzFph
	D5y9CuRqEVu4jEAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 25A6C1332F;
	Mon,  8 Apr 2024 06:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WkrvMfmKE2ZsBAAAn2gu4w
	(envelope-from <ddiss@suse.de>); Mon, 08 Apr 2024 06:13:13 +0000
Date: Mon, 8 Apr 2024 16:12:51 +1000
From: David Disseldorp <ddiss@suse.de>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] common/filter.btrfs: introduce _filter_snapshot
Message-ID: <20240408161251.258471ef@echidna>
In-Reply-To: <bedb9edc01e8938544fa5c73f716f823764c3fd9.1712549642.git.anand.jain@oracle.com>
References: <cover.1712306454.git.anand.jain@oracle.com>
	<bedb9edc01e8938544fa5c73f716f823764c3fd9.1712549642.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.87 / 50.00];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.86)[85.50%];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,oracle.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C034B22571
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.87

On Mon,  8 Apr 2024 12:32:58 +0800, Anand Jain wrote:

> Btrfs-progs commit 5f87b467a9e7 ("subvolume: output the prompt line only
> when the ioctl succeeded") changed the output for snapshot command,
> updating the golden outputs.
> 
> Create a helper filter to ensure the test cases pass on older btrfs-progs.
> 
> Another option is to remove the 'btrfs subvolume snapshot' command output
> from the golden output and redirect it to /dev/null, but this strays from
> the bug-fix objective.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: The missed testcases included now.
>     Merged following two patches in v1:
> 	common/filter.btrfs: add a new _filter_snapshot
> 	btrfs: create snapshot fix golden output

Reviewed-by: David Disseldorp <ddiss@suse.de>

I think retaining the golden output makes sense for this.

