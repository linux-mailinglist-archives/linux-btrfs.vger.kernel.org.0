Return-Path: <linux-btrfs+bounces-461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8B97FFEC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 23:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9831C20D48
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 22:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FDB61FB7;
	Thu, 30 Nov 2023 22:57:56 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C4E194;
	Thu, 30 Nov 2023 14:57:52 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 767661FD11;
	Thu, 30 Nov 2023 22:57:51 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FDDE138E5;
	Thu, 30 Nov 2023 22:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id O5H+Em8TaWXDYAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 30 Nov 2023 22:57:51 +0000
Date: Thu, 30 Nov 2023 23:50:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: remove shadowed declaration of variable i
 in for-loops
Message-ID: <20231130225033.GV18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231130150811.2208562-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130150811.2208562-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: +++++++++++++
X-Spam-Score: 13.01
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz;
	dmarc=none
X-Rspamd-Queue-Id: 767661FD11
X-Spamd-Result: default: False [13.01 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 DMARC_NA(1.20)[suse.cz];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.18)[-0.920];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Thu, Nov 30, 2023 at 03:08:11PM +0000, Colin Ian King wrote:
> The variable i is declared at the start of function btrfs_qgroup_inherit
> however there are two for-loops that redeclare the variable using a C99
> declaration, causes name shadowing. I believe there is no need for this
> local scoping of i in the loop, so replace the declaration in the loops
> with assignments.
> 
> Cleans up clang scan build warnings:
> 
> fs/btrfs/qgroup.c:3194:12: warning: declaration shadows a local variable [-Wshadow]
>  3194 |                 for (int i = 0; i < inherit->num_qgroups; i++) {
>       |                          ^
> fs/btrfs/qgroup.c:3089:6: note: previous declaration is here
>  3089 |         int i;
>       |             ^
> fs/btrfs/qgroup.c:3321:12: warning: declaration shadows a local variable [-Wshadow]
>  3321 |                 for (int i = 0; i < inherit->num_qgroups; i++)
>       |                          ^
> fs/btrfs/qgroup.c:3089:6: note: previous declaration is here
>  3089 |         int i;
>       |             ^
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/btrfs/qgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index ce446d9d7f23..b1f93dbf468c 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3191,7 +3191,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -		for (int i = 0; i < inherit->num_qgroups; i++) {
> +		for (i = 0; i < inherit->num_qgroups; i++) {

We want to use the for(...) local definitions, so this should change the
function scope 'i'.

