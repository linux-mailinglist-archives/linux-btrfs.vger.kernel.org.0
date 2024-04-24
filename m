Return-Path: <linux-btrfs+bounces-4528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5FC8B10E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9CAB2B8F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 17:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6C616D4F4;
	Wed, 24 Apr 2024 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XgulTLNv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TEqCwjHR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XgulTLNv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TEqCwjHR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E39165FA8
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979419; cv=none; b=GPpoDFuj8JsAJDPiNFvvd+C7HR6l2CjKHLa0tARnngwhS9ye6+5TqBVlIqd82Jk5wzxAG7KvG9xfrtxXvAnyf2NM62456m2x4C2QryvyVwDyV3PK8Brz9WFcPd4Q/XL+7Iw80MbNWrQk5peuHo95XQPmtUyOlV/yhelbahZVuzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979419; c=relaxed/simple;
	bh=8aYcZix3LBkrjJF6ChElzCTyN7nwlnVy+8BeE2r8664=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS95ktSHAn4hHLlhtXRV2f2auuFaYD7lYlw1jO0QlelJqcNCnkKveNJI2C+Xyple/AP2RxuWtnClXYp0TYGBvHvim5vbFzDRzX0SWQSAZN7Qy1q4ncuYsJtcGSRgkI0FKBuMD8F1mCzSWp1sONlGfJjlsse1fMWH5E3eJ1Hmq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XgulTLNv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TEqCwjHR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XgulTLNv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TEqCwjHR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BBDE21B31;
	Wed, 24 Apr 2024 17:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713979416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TijVEnPmtYS98UkIYoscddPP4byS8T1j46Cl5U5f5c8=;
	b=XgulTLNvoV8d0XJbALAa/AgO94tLyP5/86NF+iHqO5FnWl/PlSo/J1aF6jhcM4eVLihUhS
	Oi7HeQvAaaRUuHK9Hm+lhvRR5Sv2pv7C20LdO158rARSF3GgwGklrT+sPjR1n4J8u9PjSe
	822PVhxGpyuIRWSzfz0EwlFCXedFvLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713979416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TijVEnPmtYS98UkIYoscddPP4byS8T1j46Cl5U5f5c8=;
	b=TEqCwjHRANEyy5nFjsfcN3jTTPxTTret7NbSS/f1I1CEyaXEXGn66E80Lu+STEYBj2Wdbv
	nk76pWlUjyGbmiAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XgulTLNv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TEqCwjHR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713979416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TijVEnPmtYS98UkIYoscddPP4byS8T1j46Cl5U5f5c8=;
	b=XgulTLNvoV8d0XJbALAa/AgO94tLyP5/86NF+iHqO5FnWl/PlSo/J1aF6jhcM4eVLihUhS
	Oi7HeQvAaaRUuHK9Hm+lhvRR5Sv2pv7C20LdO158rARSF3GgwGklrT+sPjR1n4J8u9PjSe
	822PVhxGpyuIRWSzfz0EwlFCXedFvLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713979416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TijVEnPmtYS98UkIYoscddPP4byS8T1j46Cl5U5f5c8=;
	b=TEqCwjHRANEyy5nFjsfcN3jTTPxTTret7NbSS/f1I1CEyaXEXGn66E80Lu+STEYBj2Wdbv
	nk76pWlUjyGbmiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 262B813690;
	Wed, 24 Apr 2024 17:23:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QTeSCBhAKWb6RwAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 24 Apr 2024 17:23:36 +0000
Date: Wed, 24 Apr 2024 12:23:31 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 02/17] btrfs: push all inline logic into cow_file_range
Message-ID: <7hluf74kfy2ffaax7w6avwljauysxquaf5bphmjtq656ewnhpi@6inplrng5k4j>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <2796fb5d2b04c3ff87c2ab5b285fd7e072a8e4a2.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2796fb5d2b04c3ff87c2ab5b285fd7e072a8e4a2.1713363472.git.josef@toxicpanda.com>
X-Spam-Flag: NO
X-Spam-Score: -2.93
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3BBDE21B31
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.93 / 50.00];
	BAYES_HAM(-1.92)[94.55%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,suse.de:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]

On 10:35 17/04, Josef Bacik wrote:
> Currently we have a lot of duplicated checks of
> 
> if (start == 0 && fs_info->sectorsize == PAGE_SIZE)
> 	cow_file_range_inline();
> 
> Instead of duplicating this check everywhere, consolidate all of the
> inline extent logic into a helper which documents all of the checks and
> then use that helper inside of cow_file_range_inline().  With this we
> can clean up all of the calls to either unconditionally call
> cow_file_range_inline(), or at least reduce the checks we're doing
> before we call cow_file_range_inline();
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>


