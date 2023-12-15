Return-Path: <linux-btrfs+bounces-982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080AF815063
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 20:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5EF1F25614
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FC45C09;
	Fri, 15 Dec 2023 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z/VZ045o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7o3Pcz24";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z/VZ045o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7o3Pcz24"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A65045BEE
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31C3722080;
	Fri, 15 Dec 2023 19:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702669808;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g3K3sOzJHpzfs+U9ASS0FiMCSKGRZMSbuSMpVw+AeTo=;
	b=z/VZ045odyB+5z2jngU1kmZIFnG4fH02PzkOym/JRMj4avauU6x/0Lc6DImCU8uI0+m4ef
	vlOSKrOSx4Gli0SWbg6ls5Mu1yL7lIKMH+LIVwSROQfjJwIB75AFg2IVLB1LO1lxOPRx2r
	94Jf9rC2Cv9zDuASLGj6Xa9BRgsFHpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702669808;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g3K3sOzJHpzfs+U9ASS0FiMCSKGRZMSbuSMpVw+AeTo=;
	b=7o3Pcz24aFRy0XLALJYoIXHPNdeUkszQCQ7IwUEauMjtwk8nKsaCkSe8rv3Mj7h4DlAvxc
	wTDfcKFMTypsZGBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702669808;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g3K3sOzJHpzfs+U9ASS0FiMCSKGRZMSbuSMpVw+AeTo=;
	b=z/VZ045odyB+5z2jngU1kmZIFnG4fH02PzkOym/JRMj4avauU6x/0Lc6DImCU8uI0+m4ef
	vlOSKrOSx4Gli0SWbg6ls5Mu1yL7lIKMH+LIVwSROQfjJwIB75AFg2IVLB1LO1lxOPRx2r
	94Jf9rC2Cv9zDuASLGj6Xa9BRgsFHpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702669808;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g3K3sOzJHpzfs+U9ASS0FiMCSKGRZMSbuSMpVw+AeTo=;
	b=7o3Pcz24aFRy0XLALJYoIXHPNdeUkszQCQ7IwUEauMjtwk8nKsaCkSe8rv3Mj7h4DlAvxc
	wTDfcKFMTypsZGBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1568613A08;
	Fri, 15 Dec 2023 19:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id fkvCBPCtfGWgQQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 15 Dec 2023 19:50:08 +0000
Date: Fri, 15 Dec 2023 20:50:06 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: handle existing eb in the radix tree properly
Message-ID: <20231215195006.GB9795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <93ba6929e6ce070bd27bd80220bff7112793a3ca.1702658189.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93ba6929e6ce070bd27bd80220bff7112793a3ca.1702658189.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: **
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.29)[74.62%]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="z/VZ045o";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7o3Pcz24
X-Spam-Score: -0.30
X-Rspamd-Queue-Id: 31C3722080

On Fri, Dec 15, 2023 at 11:36:59AM -0500, Josef Bacik wrote:
> This fix can be folded into "btrfs: refactor alloc_extent_buffer() to
> allocate-then-attach method".
> 
> My previous fix simply fixed the panic, this fixes the memory leak that
> I observed after fixing the panic.
> 
> When we have an existing extent buffer in the radix tree we'll goto out
> to clean everything up, but we have a
> 
> if (ret < 0)
> 	return ERR_PTR(ret);
> 
> Even though we have the existing extent buffer.  We've looked this thing
> up so have a reference on it so we leak that, but we're also returning
> an error when we shouldn't be.  Fix this up by setting ret to 0 if we
> get an error back from the radix tree insert.  With these two fixups I
> can now get through btrfs/187 on subpage without anything blowing up.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Folded to the patch, thanks. I did not update the changelog as the fix
is a pattern that we use elsewhere "reset error code when retrying".

