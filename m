Return-Path: <linux-btrfs+bounces-1378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2582A34B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 22:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CFC287E81
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 21:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DFA4F5F9;
	Wed, 10 Jan 2024 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p2j4DlDB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LhzIRjEY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p2j4DlDB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LhzIRjEY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD94F5E8
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8CF411F8CD;
	Wed, 10 Jan 2024 21:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704922175;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFswnCv0ahjW4FJBYk/HwAS63qYQqr3HIbryE4G6rMs=;
	b=p2j4DlDB1Oa6MvUi+GYiG0lIkNH9uPJw70f35NIDRgCAwCGZw5dZqRuVzys/LTSEsb9qqN
	OwtZFMKApt+8Mu7K73KbD/K2BGZyr4P3DF4iIGjTVfyNAD+oIHMIajDBVRG077mU9zBm/A
	GlzxxJGAcRLHUezn549Dq16MVSdmd5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704922175;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFswnCv0ahjW4FJBYk/HwAS63qYQqr3HIbryE4G6rMs=;
	b=LhzIRjEYyeTkTFagYA2XkMfzq0DXMxj1e6CuK5ELZe1IVw6Mbjp+/6VNnzON2Cax2QgHld
	dC4NqmyuAgU0urCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704922175;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFswnCv0ahjW4FJBYk/HwAS63qYQqr3HIbryE4G6rMs=;
	b=p2j4DlDB1Oa6MvUi+GYiG0lIkNH9uPJw70f35NIDRgCAwCGZw5dZqRuVzys/LTSEsb9qqN
	OwtZFMKApt+8Mu7K73KbD/K2BGZyr4P3DF4iIGjTVfyNAD+oIHMIajDBVRG077mU9zBm/A
	GlzxxJGAcRLHUezn549Dq16MVSdmd5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704922175;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFswnCv0ahjW4FJBYk/HwAS63qYQqr3HIbryE4G6rMs=;
	b=LhzIRjEYyeTkTFagYA2XkMfzq0DXMxj1e6CuK5ELZe1IVw6Mbjp+/6VNnzON2Cax2QgHld
	dC4NqmyuAgU0urCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 58B64139C6;
	Wed, 10 Jan 2024 21:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id imQkFT8Mn2X7NwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 21:29:35 +0000
Date: Wed, 10 Jan 2024 22:30:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not restrict writes to devices
Message-ID: <20240110213046.GB31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2fe68e18d89abb7313392c8da61aaa9881bbe945.1704917721.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe68e18d89abb7313392c8da61aaa9881bbe945.1704917721.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=p2j4DlDB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LhzIRjEY
X-Spamd-Result: default: False [-0.18 / 50.00];
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
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.17)[69.60%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.18
X-Rspamd-Queue-Id: 8CF411F8CD
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Wed, Jan 10, 2024 at 03:16:35PM -0500, Josef Bacik wrote:
> This is a version of ead622674df5 ("btrfs: Do not restrict writes to
> btrfs devices"), which pushes this restriction closer to where we use
> bdev_open_by_path.  This was in the mount path, and changed when we
> switched to the new mount api, and with that loss we suddenly weren't
> able to mount.  Move this closer to where we use bdev_open_by_path so
> changes on the upper layers don't mess anything up, and then we can
> remove this when we merge the bdev holder patches.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> - This needs to go in before the new mount API patches when we rebase onto
>   linus/master for the merge request, otherwise we won't be able to mount file
>   systems.  I've put this at the beginning of the for-next branch in the github
>   linux tree, which is rebased onto recent linus.

But the new mount API has been just merged to master, no way we could
reorder the patches. There are like 18 new patches atop the 6.8 pull
request branch so that's the next base.

