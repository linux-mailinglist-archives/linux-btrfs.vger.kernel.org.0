Return-Path: <linux-btrfs+bounces-1417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAE982C2FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 16:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97EC1C21C7A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1816EB67;
	Fri, 12 Jan 2024 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TnRWkakl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VtOlVrbS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TnRWkakl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VtOlVrbS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5773160
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF6E81FD6C;
	Fri, 12 Jan 2024 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705074230;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfGbwggLWvqipck0JaxvLb8HxuOZ47dVuqMENaFjQjw=;
	b=TnRWkaklfZFVZ6PEXqokxnq5YgB5BFPDy/g3Ywaccgz3KQqq7rAPZl3yBov6DTW+ky4eHT
	aFjvG9/wCdl6oPVfIxTVxGfZY0rxmZFYfe1oCSuoIS7TkX5SIWzS1axj3KKc0M51bK4nYA
	oSDJ5+EgCCrgtuDCafcCuVMOwoke/9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705074230;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfGbwggLWvqipck0JaxvLb8HxuOZ47dVuqMENaFjQjw=;
	b=VtOlVrbSJ7T3wpJiVRXjU5sxWcGqWCWzVB54Z6KuEBDt9NvTN7fXo1pNR8rBs0we+dpYWT
	n+6CaJsPCWXiQVCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705074230;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfGbwggLWvqipck0JaxvLb8HxuOZ47dVuqMENaFjQjw=;
	b=TnRWkaklfZFVZ6PEXqokxnq5YgB5BFPDy/g3Ywaccgz3KQqq7rAPZl3yBov6DTW+ky4eHT
	aFjvG9/wCdl6oPVfIxTVxGfZY0rxmZFYfe1oCSuoIS7TkX5SIWzS1axj3KKc0M51bK4nYA
	oSDJ5+EgCCrgtuDCafcCuVMOwoke/9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705074230;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfGbwggLWvqipck0JaxvLb8HxuOZ47dVuqMENaFjQjw=;
	b=VtOlVrbSJ7T3wpJiVRXjU5sxWcGqWCWzVB54Z6KuEBDt9NvTN7fXo1pNR8rBs0we+dpYWT
	n+6CaJsPCWXiQVCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A4D1E139D7;
	Fri, 12 Jan 2024 15:43:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +k/DJzZeoWX4HwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 12 Jan 2024 15:43:50 +0000
Date: Fri, 12 Jan 2024 16:43:34 +0100
From: David Sterba <dsterba@suse.cz>
To: Chung-Chiang Cheng <cccheng@synology.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, shepjeng@gmail.com,
	kernel@cccheng.net
Subject: Re: [PATCH] btrfs: tree-checker: fix iref size in error messages
Message-ID: <20240112154334.GR31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a2c72015288d70b870ded1d6f8aaba1c2cf63f97.1705045187.git.cccheng@synology.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2c72015288d70b870ded1d6f8aaba1c2cf63f97.1705045187.git.cccheng@synology.com>
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
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.991];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,gmail.com,cccheng.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.30)[75.04%]
X-Spam-Flag: NO

On Fri, Jan 12, 2024 at 03:41:05PM +0800, Chung-Chiang Cheng wrote:
> The error message should accurately reflect the size rather than the
> size.
> 
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>

Applied, thanks.

