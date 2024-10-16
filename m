Return-Path: <linux-btrfs+bounces-8957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0C09A0BE1
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 15:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6784E1F24865
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136F9209F29;
	Wed, 16 Oct 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YlWWN8i6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/XdrUWvi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YlWWN8i6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/XdrUWvi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2582071FF;
	Wed, 16 Oct 2024 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086569; cv=none; b=thSr/BQS/cZtpUNV0wPxR63nICAz+Y5geB5wjoTosErw5Ic85u4k8BGMP/R8nta0RgRpirqN8Hr3T+cMC4vWU1xLetKiWk4XPtZqi2+CJd/wJTzZfJpOp/QokxZpokMvvoqGW1hCDr7EDyGaN3cRwAIQqDF4mZi/wP/Sq0NSoHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086569; c=relaxed/simple;
	bh=T6S8MHzsWbbhpYc744BPFdnVgsatESf28s6fE5cIgzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPRPb3oNQhKjrI96z4lcIfzcdb0sjtRBRF32Tg2INxQkB5rk4iWltQV3IoK2A0mEcLh5k+v7+4iEysSiImzFNEVeGrJfONci86G7H5aMQhukJ+fPNnNoHNdcU9ByL3QBAuNIM6xFvZjb7jJLgbQ6ehdSPssmpY6k9EbRF0fNFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YlWWN8i6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/XdrUWvi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YlWWN8i6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/XdrUWvi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FBC91F7BF;
	Wed, 16 Oct 2024 13:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729086564;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48OaqHqP6b/X39O0Tmy1hbH3rm7+b4nKvK9d8AlpvyA=;
	b=YlWWN8i6PN4mmfXfbNRlHh9xevZm279VV9a6dbcmhGzSCWhpJ9Sj1DJungPUP1Rvkz6ZmL
	3m4CBGyai3yymS++ZhGaj4jwLJUojxpaMcXKDXrw52LJhR64suGV67Ls5yg9qeovqg2RJH
	nif7cjUZxKQZNpweS6vhF2meDxhAk8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729086564;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48OaqHqP6b/X39O0Tmy1hbH3rm7+b4nKvK9d8AlpvyA=;
	b=/XdrUWvi05UtXOFTd6Vnn2eoBrIACZIqGuEhu6TT1iT8ODQ22CuarPB172F/ScFcx+Hy2q
	PbSie0zOl7TBCKBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YlWWN8i6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/XdrUWvi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729086564;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48OaqHqP6b/X39O0Tmy1hbH3rm7+b4nKvK9d8AlpvyA=;
	b=YlWWN8i6PN4mmfXfbNRlHh9xevZm279VV9a6dbcmhGzSCWhpJ9Sj1DJungPUP1Rvkz6ZmL
	3m4CBGyai3yymS++ZhGaj4jwLJUojxpaMcXKDXrw52LJhR64suGV67Ls5yg9qeovqg2RJH
	nif7cjUZxKQZNpweS6vhF2meDxhAk8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729086564;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48OaqHqP6b/X39O0Tmy1hbH3rm7+b4nKvK9d8AlpvyA=;
	b=/XdrUWvi05UtXOFTd6Vnn2eoBrIACZIqGuEhu6TT1iT8ODQ22CuarPB172F/ScFcx+Hy2q
	PbSie0zOl7TBCKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F6341376C;
	Wed, 16 Oct 2024 13:49:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BkneHmTED2cdEQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Oct 2024 13:49:24 +0000
Date: Wed, 16 Oct 2024 15:49:19 +0200
From: David Sterba <dsterba@suse.cz>
To: kernel test robot <lkp@intel.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, oe-kbuild-all@lists.linux.dev,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-btrfs@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [linux-next:master 4584/4954] ERROR: modpost: "__cmpxchg_small"
 [fs/btrfs/btrfs.ko] undefined!
Message-ID: <20241016134919.GO1609@suse.cz>
Reply-To: dsterba@suse.cz
References: <202410161911.LbOFjfPQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410161911.LbOFjfPQ-lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 9FBC91F7BF
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	SUBJECT_ENDS_EXCLAIM(0.20)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:mid,intel.com:email];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed, Oct 16, 2024 at 07:10:49PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   15e7d45e786a62a211dd0098fee7c57f84f8c681
> commit: c87222d18145c93b0ebd860ae9166afb1457129c [4584/4954] btrfs: fix error propagation of split bios
> config: mips-ip30_defconfig (https://download.01.org/0day-ci/archive/20241016/202410161911.LbOFjfPQ-lkp@intel.com/config)
> compiler: mips64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410161911.LbOFjfPQ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410161911.LbOFjfPQ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/zlib_inflate/zlib_inflate.o
> >> ERROR: modpost: "__cmpxchg_small" [fs/btrfs/btrfs.ko] undefined!

On mips64-linux-gcc (mips-ip30_defconfig), arch/mips/kernel/cmpxchg.c:__cmpxchg_small()
is not exported for modules.

