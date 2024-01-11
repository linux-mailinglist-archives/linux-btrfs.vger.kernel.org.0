Return-Path: <linux-btrfs+bounces-1399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8F582B32E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 17:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F33282344
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE22351C33;
	Thu, 11 Jan 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pydF/W6y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RLq4Vyk/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bgwGr4pH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9efgKx2E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2856351C20
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44B991F896;
	Thu, 11 Jan 2024 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704991428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2bv2RmlnlcC9JFn97UaCcT583QBoLGeLFK2HWQfeIQ=;
	b=pydF/W6y9IZTrYWqAq3sth08cevOi3MO9XJngm5M0z4PhSHNekCvnN4P2XATbTfvANQP8g
	sgzE+/s1uvs0EQWeRu1sBfds6BsAUpkXlRp3xMBczvAEGDtaRo5WWVAQC/zq4H7RW9vUeA
	zMLYucnAKXHRSUlpSuqW/wHYWw7H530=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704991428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2bv2RmlnlcC9JFn97UaCcT583QBoLGeLFK2HWQfeIQ=;
	b=RLq4Vyk/Am36XGNjk2kKL6Z+05rvHmTPVD9g92/YXPI5f/LThBStaJ4BTVD7PYBs91fq0g
	09HriPMnHHvWylBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704991427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2bv2RmlnlcC9JFn97UaCcT583QBoLGeLFK2HWQfeIQ=;
	b=bgwGr4pHexfdmNNFwqC1OVovKTu5n7Jdh5O7SRCs1OwR7VwzP6RluI0lxGiJF0829gwSZK
	hJsy2QsKx9oCW48skc3DGyCYQdxNL6h+KcXPwtCLzy8U154kGFoQH/EyIfxQ7JaU1S8nf9
	4u5NczhZghkNv9GpVzvILRRmAwDEezQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704991427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2bv2RmlnlcC9JFn97UaCcT583QBoLGeLFK2HWQfeIQ=;
	b=9efgKx2E6i+i0QEMtjdUbf24UqdxZ2Vl3ebzEtmyhvhcnJfkhvic4B84RKEA+TTsmib/uq
	iupZi1xt7pAk17Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 259BB132FA;
	Thu, 11 Jan 2024 16:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /2bfCMMaoGUtBQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jan 2024 16:43:47 +0000
Date: Thu, 11 Jan 2024 17:43:27 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: use the original mount's mount options for the
 legacy reconfigure
Message-ID: <20240111164327.GJ31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <18faaced53d356f66b4b1f0f118d15e37e3c8a2c.1704909267.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18faaced53d356f66b4b1f0f118d15e37e3c8a2c.1704909267.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.30)[74.87%]
X-Spam-Flag: NO

On Wed, Jan 10, 2024 at 12:54:41PM -0500, Josef Bacik wrote:
> btrfs/330, which tests our old trick to allow
> 
> mount -o ro,subvol=/x /dev/sda1 /foo
> mount -o rw,subvol=/y /dev/sda1 /bar
> 
> fails on the block group tree.  This is because we aren't preserving the
> mount options for what is essentially a remount, and thus we're ending
> up without the FREE_SPACE_TREE mount option, which triggers our free
> space tree delete codepath.  This isn't possible with the block group
> tree and thus it falls over.
> 
> Fix this by making sure we copy the existing mount options for the
> existing fs mount over in this case.

Fixes: f044b318675f ("btrfs: handle the ro->rw transition for mounting different subvolumes")

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: David Sterba <dsterba@suse.com>

