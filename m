Return-Path: <linux-btrfs+bounces-947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0A812202
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 23:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B864D1C21414
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 22:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B096E7FBBD;
	Wed, 13 Dec 2023 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IIXIrPzD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mElLMasg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IIXIrPzD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mElLMasg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD052DC
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 14:46:00 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 495BD223C5;
	Wed, 13 Dec 2023 22:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702507559;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=liqyxzfhOMu91jCJrDu0Z76hyQNy3qhPHO8Lgdvop4g=;
	b=IIXIrPzDysgzMJUQsm5C6Pw6y1EUMos5PyuRU7Io/vPlGCc4byU0aAikIsHoJMHggzcbYz
	hOTgHEJp9gcfi7GN8F/gPPNIT90gs1lC7TnZO+c3bioas3/6ImwIa2uEKbfEO699X3AOa0
	M8vVwAkmHh2Lcb8DN08c0sK7peZbWQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702507559;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=liqyxzfhOMu91jCJrDu0Z76hyQNy3qhPHO8Lgdvop4g=;
	b=mElLMasgRL4jo9/CheLFnCXt2Nmw4pDEJ46+u4c6BjbHy/dOp/kTT9mGYsgzbqGK8LOo49
	tVbMGGfsxdGwasDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702507559;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=liqyxzfhOMu91jCJrDu0Z76hyQNy3qhPHO8Lgdvop4g=;
	b=IIXIrPzDysgzMJUQsm5C6Pw6y1EUMos5PyuRU7Io/vPlGCc4byU0aAikIsHoJMHggzcbYz
	hOTgHEJp9gcfi7GN8F/gPPNIT90gs1lC7TnZO+c3bioas3/6ImwIa2uEKbfEO699X3AOa0
	M8vVwAkmHh2Lcb8DN08c0sK7peZbWQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702507559;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=liqyxzfhOMu91jCJrDu0Z76hyQNy3qhPHO8Lgdvop4g=;
	b=mElLMasgRL4jo9/CheLFnCXt2Nmw4pDEJ46+u4c6BjbHy/dOp/kTT9mGYsgzbqGK8LOo49
	tVbMGGfsxdGwasDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EAA21391D;
	Wed, 13 Dec 2023 22:45:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8ddoBic0emU3OAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 13 Dec 2023 22:45:59 +0000
Date: Wed, 13 Dec 2023 23:39:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: migrate the remaining functions exposed by a
 full fstests with larger metadata folios
Message-ID: <20231213223907.GH3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1702354716.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702354716.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Score: -1.02
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.10
X-Spamd-Result: default: False [-1.10 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.10)[65.76%]

On Tue, Dec 12, 2023 at 03:54:08PM +1030, Qu Wenruo wrote:
> [REPO]
> This patchset along with all the previous migrations (and the final
> enablement patch) can be found here:
> 
> https://github.com/adam900710/linux/tree/eb_memory
> 
> With all the previous migrations (although only tested without larger
> folios), we are finally just one step away from enabling larger folio
> support for btrfs metadata.
> 
> During my local full fstests runs with larger metadata folios, there are
> only two bugs hit, all related to some code path not yet handling folios
> correct:
> 
> - eb_bitmap_offset()
> - btrfs_repair_eb_io_failure()
> 
> Otherwise my local branch can already pass local fstests without new
> regressions.
> 
> So here is the final (and I hope is the last) migrations for involed
> metadata code path, before the final patch enabling larger folio
> support.

Great, thanks. We'll need to test the first batch of folio conversion
but so far it seems it's ok, enabling the higher order folios can be
done at rc3 time in case we want to target the next major release, or we
can postpone it to the following one if needed.

