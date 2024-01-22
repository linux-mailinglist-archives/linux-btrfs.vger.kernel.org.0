Return-Path: <linux-btrfs+bounces-1612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23504837444
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 21:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C6D1C2930C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 20:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9724878C;
	Mon, 22 Jan 2024 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rbKjPuFJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6vilI+CZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rbKjPuFJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6vilI+CZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF769482D3
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956268; cv=none; b=XlESaKrLYoZuK/T2CW3TOpkzRsvdpuvM+5StsC+i8MWXcVN0pFONtBpLd/s5yuG6trAwdc+snQyUFUtlvyGc/lExYItii6gbY0uWMzAsQw7DXidlAPtSQriT58V1S1p0KH+49Gw+S0ltfxWHvVEla4SBvRK5GKu8Wk2AotVn4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956268; c=relaxed/simple;
	bh=ePbNDjPnj8/k7AKk2BjMb831rzkcl5OdDps4YvLHHMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2iuPmlHTVbekGWjgMPxGOXZATdOQDl3mw0SAoNLJfqMCk04a2dKpGtO53iKzeJzN9izfbhCF+h2w0t5OeZQnPBz7ichidpYKy0H7UvLMDWmFPkV2G05fpM6EbgwJibxEzaibhwMguT+/l8EyfzDVTWiIUZoOS+V05MyBJetqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rbKjPuFJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6vilI+CZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rbKjPuFJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6vilI+CZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0DEFE1F392;
	Mon, 22 Jan 2024 20:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705956265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEe+Jp4bbkRkJnciXOjFndEckybX7mCHPrZgw9Oq1hg=;
	b=rbKjPuFJwsPsC4hxm3Aq78gFvaFF8l9nPX2LGv+Fk+i6vVxwVBcqoGPRsPF9XkppgegX3q
	sXVy+XlpU61kxAvi9DHjmehEesmkeisScyr9pEeAGqQ6iToim7FlFMpWB1PUzLmufk27q5
	zGrks8aBKTh3b6l9/t+y7Unx6fr5KRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705956265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEe+Jp4bbkRkJnciXOjFndEckybX7mCHPrZgw9Oq1hg=;
	b=6vilI+CZ/namIKjwbVXy83RGXQcXhKmo0TEU+AlHvclrjJO5hF9nxyapE7rBaeK6ztLIyc
	zJVkcnCdYf50hMDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705956265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEe+Jp4bbkRkJnciXOjFndEckybX7mCHPrZgw9Oq1hg=;
	b=rbKjPuFJwsPsC4hxm3Aq78gFvaFF8l9nPX2LGv+Fk+i6vVxwVBcqoGPRsPF9XkppgegX3q
	sXVy+XlpU61kxAvi9DHjmehEesmkeisScyr9pEeAGqQ6iToim7FlFMpWB1PUzLmufk27q5
	zGrks8aBKTh3b6l9/t+y7Unx6fr5KRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705956265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEe+Jp4bbkRkJnciXOjFndEckybX7mCHPrZgw9Oq1hg=;
	b=6vilI+CZ/namIKjwbVXy83RGXQcXhKmo0TEU+AlHvclrjJO5hF9nxyapE7rBaeK6ztLIyc
	zJVkcnCdYf50hMDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 00C1813310;
	Mon, 22 Jan 2024 20:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AgaSO6jTrmVHewAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 22 Jan 2024 20:44:24 +0000
Date: Mon, 22 Jan 2024 21:43:59 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: forbid deleting live subvol qgroup
Message-ID: <20240122204359.GW31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705711967.git.boris@bur.io>
 <8ef9980c0621c82737b646b2bcf9df7b5a6dc216.1705711967.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef9980c0621c82737b646b2bcf9df7b5a6dc216.1705711967.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.18 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.04%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.18

On Fri, Jan 19, 2024 at 04:55:59PM -0800, Boris Burkov wrote:
> If a subvolume still exists, forbid deleting its qgroup.
> This behavior generally leads to incorrect behavior in squotas and
> doesn't have a legitimate purpose.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: David Sterba <dsterba@suse.com>

