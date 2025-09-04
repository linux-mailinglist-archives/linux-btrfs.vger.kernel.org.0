Return-Path: <linux-btrfs+bounces-16622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E0FB43F34
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 16:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3146C7C190A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8546E312821;
	Thu,  4 Sep 2025 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t41CnZ+6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="78jNdZHE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x7HUkFsQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R1k+xSkn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A880B
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Sep 2025 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996464; cv=none; b=FWCay+nCMVI60edbt8KZcIlA0eAeUuUDR7xpWCPNiTAMfmgrwL6n65CKT4Wgnq0lv1RvmyQ9SAF9SSt4FuJfTbSIDDCCdQclOuTTjGHq9PoVkzpabqq7H0dAXhtw5Rn2nx5DUX4I3m2bEsGjpwCAk3dRZcWh+pIfx6m7/3O9bP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996464; c=relaxed/simple;
	bh=KDrZGvUE/GIDfecxMJAVXTSqPDgoWbCvYdazZbdNuwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+KhZeVuUdmEZwYJbczlYd8wCfnUgeJ+BdnyBn66b8HlE2nkJ/dH8CVgsiIyCEFLSwuNp7yIQrb1sxFtDjo7tinT+4tHB2kvQV5S7CFXtJfrp49JnkW441HfwdXOhDuBxvTuiaULD8mQWzhh5LEqdNe2AM7LZGCjco3d0hQhvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t41CnZ+6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=78jNdZHE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x7HUkFsQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R1k+xSkn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F274C5FFDE;
	Thu,  4 Sep 2025 14:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756996461;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3NT6nzfup9RZ4zWSDLmIPu1HkVzpUlHaAUVTuWje9o=;
	b=t41CnZ+69vYsx4xJ+BNFrQ1qYCrPifDCTnf9gneosjAcDvsVNmO4HzyZZNlaoHAiEpx32Q
	w35ivhyp0Potgkt6Da1ySS8h5oKWaMU5Ld2gt+UEwkIW7tB/isv7wO8evzP1zQFqPbFKZ9
	X23A4FL5JhrRHkraZz00iLTqTuUawLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756996461;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3NT6nzfup9RZ4zWSDLmIPu1HkVzpUlHaAUVTuWje9o=;
	b=78jNdZHExAPFTEUV48ILa35KbSAQ7h6n4YQ65UgSOcbtisK+VQv5F5MBYDH+4jReAcEr4R
	ETHtKUGbTzz1eMBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756996460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3NT6nzfup9RZ4zWSDLmIPu1HkVzpUlHaAUVTuWje9o=;
	b=x7HUkFsQnSv0TwegdJSUvtZ0DllXit5MI/9hh35nfPzFIcM5ldBL4FUHlw/74onmST9T9t
	XqwIBUs41z5ASgmFqr3vPtCUVoRiKmwPixEuh9gzJnSf3H69r/fL3oLT6ZCE1MhKWAdZ8F
	06n9SAW1rsI7baCILxbOBbxAQBXLUFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756996460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3NT6nzfup9RZ4zWSDLmIPu1HkVzpUlHaAUVTuWje9o=;
	b=R1k+xSkn3DSxI203wW9hPUpGzS66R0NtPny7w5nvqJTjvo9g5abKNjLG6kBkW5z7C2jyzz
	cDRGIJYPWFUGk+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D946A13675;
	Thu,  4 Sep 2025 14:34:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o2TeNGyjuWj6egAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 04 Sep 2025 14:34:20 +0000
Date: Thu, 4 Sep 2025 16:34:15 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [linus:master] [btrfs] bddf57a707:
 stress-ng.sync-file.ops_per_sec 44.2% regression
Message-ID: <20250904143415.GL5333@suse.cz>
Reply-To: dsterba@suse.cz
References: <202509031643.303d114c-lkp@intel.com>
 <9d6db7e9-318f-4242-9883-9eee8ee20f5e@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d6db7e9-318f-4242-9883-9eee8ee20f5e@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,01.org:url];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Wed, Sep 03, 2025 at 06:18:01PM +0930, Qu Wenruo wrote:
> 在 2025/9/3 18:14, kernel test robot 写道:
> > 
> > Hello,
> > 
> > kernel test robot noticed a 44.2% regression of stress-ng.sync-file.ops_per_sec on:
> > 
> > 
> > commit: bddf57a70781ef8821d415200bdbcb71f443993a ("btrfs: delay btrfs_open_devices() until super block is created")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [still regression on      linus/master fb679c832b6497f19fffb8274c419783909c0912]
> > [still regression on linux-next/master 3cace99d63192a7250461b058279a42d91075d0c]
> > 
> > testcase: stress-ng
> > config: x86_64-rhel-9.4
> > compiler: gcc-12
> > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > parameters:
> > 
> > 	nr_threads: 100%
> > 	disk: 1HDD
> > 	testtime: 60s
> > 	fs: btrfs
> > 	test: sync-file
> > 	cpufreq_governor: performance
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202509031643.303d114c-lkp@intel.com
> > 
> > 
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250903/202509031643.303d114c-lkp@intel.com
> > 
> > =========================================================================================
> > compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
> >    gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/sync-file/stress-ng/60s
> > 
> > commit:
> >    de339cbfb4 ("btrfs: call bdev_fput() to reclaim the blk_holder immediately")
> >    bddf57a707 ("btrfs: delay btrfs_open_devices() until super block is created")
> 
> This doesn't sound sane to me.
> 
> The two commits are only affecting btrfs mounting/unmounting, I can not 
> make any sense on why they would affect performance.
> 
> Or does stress-ng doing a lot of mounting/unmounting?

Yeah, unless there's some indirect way how mount affects the tests the
numbers do not match the identified patches. The difference is roughly
consistent in all the stats to be about 40% less so it's like it's doing
half of the work. Delayed device opening does not explain that.

