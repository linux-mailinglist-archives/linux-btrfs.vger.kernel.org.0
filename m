Return-Path: <linux-btrfs+bounces-651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B9C805A8B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55D51C21169
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDA863DCE;
	Tue,  5 Dec 2023 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0t4A+k75";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pu7gHU+k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E1AD41
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 08:54:48 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A5F21FB9F;
	Tue,  5 Dec 2023 16:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701795286;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y7x0/Ex9Ue8+dyvKy/p6dNXPXp6Iurxce6vP5NyJrog=;
	b=0t4A+k75iN6oNBy1Rl+QmdQFZxvErQS2XbvdOsEtfcLQWdYOKwtuoB50fnOW0enWN3+7PA
	nMQ31Kg6mMXBi2s8Mhi1Vd/KUzP40zVcPCmUwZmqlMg+tsT0tn1gwJmMvVu4TyT58l6Pla
	jYVpqyS9LX/2MVI2SdJ1cISCv2V7FLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701795286;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y7x0/Ex9Ue8+dyvKy/p6dNXPXp6Iurxce6vP5NyJrog=;
	b=pu7gHU+kQJpeBSYJN8NiEKFgiM3awEXszXTWgGjMwr64YVECt5+AcaYwY7w4AK3H29zJT/
	0N/CZa9+gClbFLCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 10A8E138FF;
	Tue,  5 Dec 2023 16:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UbUUA9ZVb2WDNwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 16:54:46 +0000
Date: Tue, 5 Dec 2023 17:47:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: check: remove inode cache clearing
 functionality
Message-ID: <20231205164756.GM2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701672971.git.wqu@suse.com>
 <9ded4d71f4ab77ee4ed8d3ff31df839e85756def.1701672971.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ded4d71f4ab77ee4ed8d3ff31df839e85756def.1701672971.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 5.10
X-Spamd-Result: default: False [5.10 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

On Mon, Dec 04, 2023 at 05:26:27PM +1030, Qu Wenruo wrote:
> Since we're already directing the end user to use "btrfs rescue
> clear-ino-cache" command, there is not much need to support it in
> btrfs-check.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  check/main.c                                        |  12 ++----------
>  .../060-ino-cache-clean}/ino-cache-enabled.raw.xz   | Bin
>  .../060-ino-cache-clean}/test.sh                    |   2 +-
>  3 files changed, 3 insertions(+), 11 deletions(-)
>  rename tests/{fsck-tests/046-ino-cache-clean => misc-tests/060-ino-cache-clean}/ino-cache-enabled.raw.xz (100%)
>  rename tests/{fsck-tests/046-ino-cache-clean => misc-tests/060-ino-cache-clean}/test.sh (97%)
> 
> diff --git a/check/main.c b/check/main.c
> index 901a7ef5ebcb..30967fd426ca 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9994,7 +9994,6 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  	int init_csum_tree = 0;
>  	int readonly = 0;
>  	int clear_space_cache = 0;
> -	int clear_ino_cache = 0;
>  	int qgroup_report = 0;
>  	int qgroups_repaired = 0;
>  	int qgroup_verify_ret;
> @@ -10118,8 +10117,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  				ctree_flags |= OPEN_CTREE_WRITES;
>  				break;
>  			case GETOPT_VAL_CLEAR_INO_CACHE:
> -				clear_ino_cache = 1;
> -				ctree_flags |= OPEN_CTREE_WRITES;
> +				error("--clear-ino-cache option is deprecated, please use \"btrfs rescue clear-ino-cache\" instead");
> +				exit(1);

This can be added independent of the rest of the series, though this
kind of change is suitable for the major release. I'll add it to devel
now but it's targeting 6.7.

