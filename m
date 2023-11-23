Return-Path: <linux-btrfs+bounces-331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBABB7F671E
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 20:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1928D1C204BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 19:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AE34C3CA;
	Thu, 23 Nov 2023 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KmKaxPPE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j5D5fes1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E413C11F
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Nov 2023 11:29:45 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 9CDE021994;
	Thu, 23 Nov 2023 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700767784;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HyVUsOHsK9pc93O15gMwhFmtijHgDvoZpvFJJ67na4k=;
	b=KmKaxPPEGP5yDgV2agxYW93lw2KMN7fRUYHiB9zHlFZWXj+NVACRlUHB5DCSz5c/T0LQG9
	S+dTA3DI+zMnzODcZpCq+CeC8xZW0FIaZ2wHoZ65mBue5Su7WUhJLn1I8cBakj4tX69+e/
	RUTKO+Px6CQ/wgqq27UuXc5Xqt9KB5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700767784;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HyVUsOHsK9pc93O15gMwhFmtijHgDvoZpvFJJ67na4k=;
	b=j5D5fes166MBJqsQwD+HY8WxYNvvgbf/3xg8Otb+JfLhaA0ew4Z/FIA0+TaRtEpshiHeoT
	9IQ132l8FR5KN4CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 907BE2C15F;
	Thu, 23 Nov 2023 19:29:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 5CCF6DA86C; Thu, 23 Nov 2023 20:22:35 +0100 (CET)
Date: Thu, 23 Nov 2023 20:22:35 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: subvolume create: accept multiple
 arguments
Message-ID: <20231123192235.GE31451@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1698903010.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698903010.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: ++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [16.42 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(1.20)[suse.cz];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-0.87)[85.70%]
X-Spam-Score: 16.42
X-Rspamd-Queue-Id: 9CDE021994

On Thu, Nov 02, 2023 at 04:03:47PM +1030, Qu Wenruo wrote:
> This patchset adds the ability to accept multiple arguments for "btrfs
> subvolume create" command, just like "mkdir".
> 
> And also we follow the error reporting part of "mkdir", any failure
> would make the command to return 1 for error.
> 
> [PATCHSET STRUCTURE]
> During the development, I found two missing error handling for strdup(),
> thus here comes the first patch to fix them.
> 
> Then the 2nd patch implements the main part.
> 
> Finally the last patch is add the new test case for the error handling
> part.
> 
> Qu Wenruo (3):
>   btrfs-progs: subvolume create: handle failure for strdup()
>   btrfs-progs: subvolume create: accept multiple arguments
>   btrfs-progs: cli-tests: add test case for subvolume create multiple
>     arguments

Added to devel, thanks.

