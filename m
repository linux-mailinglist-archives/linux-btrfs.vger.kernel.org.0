Return-Path: <linux-btrfs+bounces-7697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D795966947
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 21:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C31E284F89
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B7D1BD4F7;
	Fri, 30 Aug 2024 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LAeqnfXG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/IUTB+7L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MVTdgMHe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rvOcFIzk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0695B1BA281
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725044697; cv=none; b=gHDFZbTJYP7TF8eY+5iomm0lNSjxf+aHA0ZXacUtHbaR854C09SCRmCJfAzsIdLHLTW2JdCmUTsQ5C8vLNm4mT6u5bMFDzTNcGKlbT8aReO0JGLtl1H+WDUlV/njJv5TS5qWbfZpYdZYM6iwx6Dpz+aUthlmfDYhXgaVX4iZUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725044697; c=relaxed/simple;
	bh=XXeFzFjFDshUQVP/x1R2xAH+R3MBWS5A0PsIE9H3mn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drk03c17THFHgRhSZ55gXBn9u3GAtrZWOSYk/ZV/9CqDTVPlc6tA3y/70Mo0+cI1T2lxSESaCgD6EZlPaWDJzFZP7Zsbv9ALsMGJH8cowwKvWJKUO+Fzvmv2FmqU+XOB3YcHdE/qbq65892v3yy0BDveU32MkTRgP22zCwlDybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LAeqnfXG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/IUTB+7L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MVTdgMHe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rvOcFIzk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 038AA1F7EB;
	Fri, 30 Aug 2024 19:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725044692;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkmhtExkaz4MAM4T2LkWCUM6+hC6bVGFHzX+BSJMAXU=;
	b=LAeqnfXG3/Hv4y9mtojYse+wwrTHBD/CyP+KhfChgrATTZERmJvmtDlOnpjwx7lsC3D+OG
	nDOzAQSXVxkGcjYjnJoNhcLm1vc+m7wrpFoiGUZB5Gr2oOIBSxfw8Wbic9HTpD+uXapVev
	ANah9KBzruCEcVyPEYMnbXp4fBr6T5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725044692;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkmhtExkaz4MAM4T2LkWCUM6+hC6bVGFHzX+BSJMAXU=;
	b=/IUTB+7LS74aInfPaNi2M+4Ef/2qsH3yNmw2s4szMwKxGS+95u0Sj2P72ndRUiY0DYoMHL
	4Z0tSQadl9avnZAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MVTdgMHe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rvOcFIzk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725044691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkmhtExkaz4MAM4T2LkWCUM6+hC6bVGFHzX+BSJMAXU=;
	b=MVTdgMHeFdvk5NDGzBdaPJKARj6O/pDUGuo/WalraShHJYCipnqOz053Ier5cvCXrdE2UY
	KIfhx27HXHEodwsSD924bOt5cU5/v3Gb9TL0rIAfHTaLb0G9IVoROu2u4oRnLt++XKh0i/
	q72iCdC7BRwWGgf4uo2Mo1SvMEa6JKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725044691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkmhtExkaz4MAM4T2LkWCUM6+hC6bVGFHzX+BSJMAXU=;
	b=rvOcFIzk4WP1qIkTCl8Uuqy3s85AvUzbCUe5J2Vct8Wb1bvQ4ip0c3+Vg8R90mq8wxPXNp
	lycRRcEY6XPqn2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4BE7139D3;
	Fri, 30 Aug 2024 19:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id je5eN9IX0mbhOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 Aug 2024 19:04:50 +0000
Date: Fri, 30 Aug 2024 21:04:45 +0200
From: David Sterba <dsterba@suse.cz>
To: kernel test robot <lkp@intel.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] btrfs: constify more pointer parameters
Message-ID: <20240830190445.GX25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e163012ed80a4f55ce17641586681c6ac4ff9018.1724859620.git.dsterba@suse.com>
 <202408302358.rW7e7sjz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408302358.rW7e7sjz-lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 038AA1F7EB
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,intel.com:email,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,git-scm.com:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Fri, Aug 30, 2024 at 11:47:05PM +0800, kernel test robot wrote:
> Hi David,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on kdave/for-next]
> [also build test WARNING on linus/master next-20240830]
> [cannot apply to v6.11-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Sterba/btrfs-rework-BTRFS_I-as-macro-to-preserve-parameter-const/20240828-234222
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> patch link:    https://lore.kernel.org/r/e163012ed80a4f55ce17641586681c6ac4ff9018.1724859620.git.dsterba%40suse.com
> patch subject: [PATCH 2/2] btrfs: constify more pointer parameters
> config: i386-buildonly-randconfig-001-20240830 (https://download.01.org/0day-ci/archive/20240830/202408302358.rW7e7sjz-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408302358.rW7e7sjz-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408302358.rW7e7sjz-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    fs/btrfs/block-group.c: In function 'btrfs_should_reclaim':
> >> fs/btrfs/block-group.c:1762:51: warning: passing argument 1 of 'btrfs_zoned_should_reclaim' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>     1762 |                 return btrfs_zoned_should_reclaim(fs_info);
>          |                                                   ^~~~~~~
>    In file included from fs/btrfs/block-group.c:20:
>    fs/btrfs/zoned.h:245:69: note: expected 'struct btrfs_fs_info *' but argument is of type 'const struct btrfs_fs_info *'
>      245 | static inline bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
>          |                                               ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~

Valid report, this is the case with zoned mode disabled and the stub
function does not match the real one.

