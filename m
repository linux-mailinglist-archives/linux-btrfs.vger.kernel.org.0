Return-Path: <linux-btrfs+bounces-4533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA6F8B116B
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BB01C24B4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947E16D4E7;
	Wed, 24 Apr 2024 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vFONUfvv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+zrIo7/x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vFONUfvv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+zrIo7/x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5D143894
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980809; cv=none; b=hqaoCPAQzkWowRp9uUe52p53ux3nxvLArLf3t8zyXGvaCk8PWVilgLvjs8/gmwzVaNRX4SBVFFtKxtsE/GAGvYaXCwRVrpP8M49gaRn5W3Q8P3NNKWuJEqZBcO+BtmJHXxOCwLoF+yJGEihzw5cMuDTR24XX6VR0WZ5bR4gui9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980809; c=relaxed/simple;
	bh=Qqr7F8HWNOrF7JLHzfCxSmhdzExT7PFzUGRmsLNK/WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAmNMN0kfWmKIPkJ/7nGXLrNVR66cjboIZu8CZrQhxoSJ6YvnwpfoEa78BDu8PHCKoj0kcdy5nHEcu885uugyglSEs8gqiocQS9itSS4VkM1ITdQ5esAYYF7lvSyaFsYiPfVtyECbYjM/X+JdA0TuN/c+cpavw1PlgCZNdpKhHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vFONUfvv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+zrIo7/x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vFONUfvv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+zrIo7/x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E2061FB45;
	Wed, 24 Apr 2024 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713980806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AVen5QQuAthR/NA3s5Je+HjJKdFLA2qC8hfdlRnQzRI=;
	b=vFONUfvvzQUxu1mdzNHLBnr4MsbDl1roYA9UlYyVtNMAYyRquCE3zAVdOqeFjyfInPwOL/
	TmCbDRMIW4+VR2CHvSfMEYmLCU4mFz1FOfEfgzgiaVLDhMilZ/nXVTtGnYz6+ueXDv89tg
	45bX1cvYirfn8wCsFuzyuZkfy9f3zC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713980806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AVen5QQuAthR/NA3s5Je+HjJKdFLA2qC8hfdlRnQzRI=;
	b=+zrIo7/xaFreO090g3ZXpPKubOutTreASOQzhEnFyqQVBy4QKs7v6TnUWvZ/GzupYsk5JT
	PLHVuzRFu+hEDkCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713980806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AVen5QQuAthR/NA3s5Je+HjJKdFLA2qC8hfdlRnQzRI=;
	b=vFONUfvvzQUxu1mdzNHLBnr4MsbDl1roYA9UlYyVtNMAYyRquCE3zAVdOqeFjyfInPwOL/
	TmCbDRMIW4+VR2CHvSfMEYmLCU4mFz1FOfEfgzgiaVLDhMilZ/nXVTtGnYz6+ueXDv89tg
	45bX1cvYirfn8wCsFuzyuZkfy9f3zC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713980806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AVen5QQuAthR/NA3s5Je+HjJKdFLA2qC8hfdlRnQzRI=;
	b=+zrIo7/xaFreO090g3ZXpPKubOutTreASOQzhEnFyqQVBy4QKs7v6TnUWvZ/GzupYsk5JT
	PLHVuzRFu+hEDkCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 674E813690;
	Wed, 24 Apr 2024 17:46:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K3LHGIZFKWY9TgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 24 Apr 2024 17:46:46 +0000
Date: Wed, 24 Apr 2024 12:46:41 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 12/17] btrfs: push extent lock into cow_file_range
Message-ID: <6tzeani276rrefqjpq5ntsdiisrz37vpbd7vdjmrdeefc7p4qr@7tbz33dp27wy>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <2b350d711be80e83e961082d1e119813e2c7bde0.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b350d711be80e83e961082d1e119813e2c7bde0.1713363472.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-2.99)[99.94%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.79
X-Spam-Flag: NO

On 10:35 17/04, Josef Bacik wrote:
> Now that cow_file_range is the only function that is called with the
> range locked, push this call into cow_file_range so we can further
> narrow the scope.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

