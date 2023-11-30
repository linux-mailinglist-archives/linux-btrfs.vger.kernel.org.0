Return-Path: <linux-btrfs+bounces-454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B90B7FF3FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 16:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E66B20E5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 15:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6336E53806;
	Thu, 30 Nov 2023 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446CBD7F
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 07:53:20 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51A2321B2E;
	Thu, 30 Nov 2023 15:53:18 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EA76E13A5C;
	Thu, 30 Nov 2023 15:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id d1AANu2vaGWSCQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 30 Nov 2023 15:53:17 +0000
Date: Thu, 30 Nov 2023 16:46:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: cache that we don't have security.capability set
Message-ID: <20231130154603.GU18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8a8b4385143d66feec39e3925a399c118846a686.1701281422.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a8b4385143d66feec39e3925a399c118846a686.1701281422.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [4.32 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_LONG(-0.87)[-0.872];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 4.32
X-Rspamd-Queue-Id: 51A2321B2E

On Wed, Nov 29, 2023 at 01:10:31PM -0500, Josef Bacik wrote:
> When profiling a workload I noticed we were constantly calling getxattr.
> These were mostly coming from __remove_privs, which will lookup if
> security.capability exists to remove it.  However instrumenting getxattr
> showed we get called nearly constantly on an idle machine on a lot of
> accesses.
> 
> These are wasteful and not free.  Other security LSM's have a way to
> cache their results, but capability doesn't have this, so it's asking us
> all the time for the xattr.
> 
> Fix this by setting a flag in our inode that it doesn't have a
> security.capability xattr.  We set this on new inodes and after a failed
> lookup of security.capability.  If we set this xattr at all we'll clear
> the flag.
> 
> I haven't found a test in fsperf that this makes a visible difference
> on, but I assume fs_mark related tests would show it clearly.  This is a
> perf report output of the smallfiles100k run where it shows 20% of our
> time spent in __remove_privs because we're looking up the non-existent
> xattr.
> 
> --21.86%--btrfs_write_check.constprop.0
>   --21.62%--__file_remove_privs
>     --21.55%--security_inode_need_killpriv
>       --21.54%--cap_inode_need_killpriv
>         --21.53%--__vfs_getxattr
>           --20.89%--btrfs_getxattr
> 
> Obviously this is just CPU time in a mostly IO bound test, so the actual
> effect of removing this callchain is minimal.  However in just normal
> testing of an idle system tracing showed around 100 getxattr calls per
> minute, and with this patch there are 0.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/btrfs_inode.h |  1 +
>  fs/btrfs/inode.c       |  7 +++++
>  fs/btrfs/xattr.c       | 59 ++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 5572ae52444e..de9f71743b6b 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -69,6 +69,7 @@ enum {
>  	BTRFS_INODE_VERITY_IN_PROGRESS,
>  	/* Set when this inode is a free space inode. */
>  	BTRFS_INODE_FREE_SPACE_INODE,
> +	BTRFS_INODE_NO_CAP_XATTR,

I've added a comment

>  };
>  
>  /* in memory btrfs inode */
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 096b3004a19f..f8647d8271b7 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6225,6 +6225,13 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
>  	BTRFS_I(inode)->generation = trans->transid;
>  	inode->i_generation = BTRFS_I(inode)->generation;
>  
> +	/*
> +	 * We don't have any capability xattrs set here yet, shortcut any
> +	 * queries for the xattrs here.  If we add them later via the inode
> +	 * security init path or any other path this flag will be cleared.
> +	 */
> +	set_bit(BTRFS_INODE_NO_CAP_XATTR, &BTRFS_I(inode)->runtime_flags);
> +
>  	/*
>  	 * Subvolumes don't inherit flags from their parent directory.
>  	 * Originally this was probably by accident, but we probably can't
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 3cf236fb40a4..caf8de1158b9 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -382,6 +382,56 @@ static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
>  	return btrfs_setxattr_trans(inode, name, buffer, size, flags);
>  }
>  
> +static int btrfs_xattr_handler_get_security(const struct xattr_handler *handler,
> +					    struct dentry *unused,
> +					    struct inode *inode,
> +					    const char *name, void *buffer,
> +					    size_t size)
> +{
> +	int ret;
> +	bool is_cap = false;
> +
> +	name = xattr_full_name(handler, name);
> +
> +	/*
> +	 * security.capability doesn't cache the results, so calls into us
> +	 * constantly to see if there's a capability xattr.  Cache the result
> +	 * here in order to avoid wasting time doing lookups for xattrs we know
> +	 * don't exist.
> +	 */
> +	if (!strcmp(name, XATTR_NAME_CAPS)) {

Please use "strcmp(...) == 0" everywhere, that way it reads as that the
strings match and one does not flip the logic when there's
"!strcmp(...)".

