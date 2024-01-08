Return-Path: <linux-btrfs+bounces-1315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFBE8278AC
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 20:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA541282F1B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E601653810;
	Mon,  8 Jan 2024 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XEfKAkzy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LkvsPni5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XEfKAkzy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LkvsPni5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E232537E3
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FB1E1F7BE;
	Mon,  8 Jan 2024 19:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704742789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYKbup8BaWvnj8IZMGK12jSyAp5xGXckK8t2w23zkto=;
	b=XEfKAkzyIKYupDquoiaVwB1bpPcIEATolFHZkYaAQEZBrFz8Ia/mUS8O3Iz7nVPqD3t50X
	emJU0C7zX1BuUrFyfvlDO7lGfcKAOA0M12NFr/DvQwPgM53TpcMnhmll2tCH1RqTTG9uPG
	EC125rfZUfsoM6KUrXHVkzJLC2i0brg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704742789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYKbup8BaWvnj8IZMGK12jSyAp5xGXckK8t2w23zkto=;
	b=LkvsPni525iR8kYCLFvilA5Uyl+huz6/sNgkGuLIrHJs6QTsRJlRrPajZYagi3YmqcPc/s
	HWq8Btaap8v1fsBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704742789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYKbup8BaWvnj8IZMGK12jSyAp5xGXckK8t2w23zkto=;
	b=XEfKAkzyIKYupDquoiaVwB1bpPcIEATolFHZkYaAQEZBrFz8Ia/mUS8O3Iz7nVPqD3t50X
	emJU0C7zX1BuUrFyfvlDO7lGfcKAOA0M12NFr/DvQwPgM53TpcMnhmll2tCH1RqTTG9uPG
	EC125rfZUfsoM6KUrXHVkzJLC2i0brg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704742789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYKbup8BaWvnj8IZMGK12jSyAp5xGXckK8t2w23zkto=;
	b=LkvsPni525iR8kYCLFvilA5Uyl+huz6/sNgkGuLIrHJs6QTsRJlRrPajZYagi3YmqcPc/s
	HWq8Btaap8v1fsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39B3313686;
	Mon,  8 Jan 2024 19:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e47+DIVPnGWkHwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Jan 2024 19:39:49 +0000
Date: Mon, 8 Jan 2024 20:39:35 +0100
From: David Sterba <dsterba@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] btrfs: subvolume deletion vs. snapshot fixes
Message-ID: <20240108193935.GH28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1704397423.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1704397423.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.23 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.23)[72.61%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.23

On Thu, Jan 04, 2024 at 11:48:45AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hi,
> 
> This small series fixes a couple of bugs that can happen when trying to
> snapshot a deleted subvolume. Patch 1 fixes a filesystem abort that we
> hit in production. Patch 2 fixes another issue that Sweet Tea spotted
> when reviewing patch 1.
> 
> An fstest was sent previously [1].
> 
> Thanks!
> 
> Changes from v1 [2]:
> 
> - Rebased on latest misc-next.
> - Added patch 2.
> 
> 1: https://lore.kernel.org/linux-btrfs/62415ffc97ff2db4fa65cdd6f9db6ddead8105cd.1703010806.git.osandov@osandov.com/
> 2: https://lore.kernel.org/linux-btrfs/068014bd3e90668525c295660862db2932e25087.1703010314.git.osandov@fb.com/
> 
> Omar Sandoval (2):
>   btrfs: don't abort filesystem when attempting to snapshot deleted
>     subvolume
>   btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of
>     subvolume being deleted

Added to misc-next, thanks.

