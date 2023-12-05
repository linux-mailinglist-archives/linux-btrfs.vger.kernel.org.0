Return-Path: <linux-btrfs+bounces-654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3483F805AFD
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 18:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6BF1F21838
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629E4692B5;
	Tue,  5 Dec 2023 17:16:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028D7A1
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 09:16:12 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A29611FBA2;
	Tue,  5 Dec 2023 17:16:10 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DE66138FF;
	Tue,  5 Dec 2023 17:16:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id k9mRGNpab2VcPwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 17:16:10 +0000
Date: Tue, 5 Dec 2023 18:09:20 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/5] btrfs: qgroups rsv fixes
Message-ID: <20231205170920.GN2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701464169.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701464169.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: ++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [10.03 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 DMARC_NA(1.20)[suse.cz];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_SPAM_SHORT(1.84)[0.614];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[11.42%]
X-Spam-Score: 10.03
X-Rspamd-Queue-Id: A29611FBA2

On Fri, Dec 01, 2023 at 01:00:08PM -0800, Boris Burkov wrote:
> This series contains a number of related but relatively orthogonal fixes
> for various bugs in qgroup/squota reservation accounting. Most of these
> manifest as either rsv underflow WARNINGs (in qgroup_rsv_release) or as
> WARNINGs at umount for unreleased space.
> 
> With these fixes, I am able to get a fully clean '-g auto' fstests run
> on my setup and with -O squota in MKFS_OPTIONS.
> 
> Boris Burkov (5):
>   btrfs: free qgroup rsv on ioerr ordered_extent
>   btrfs: fix qgroup_free_reserved_data int overflow
>   btrfs: free qgroup pertrans rsv on trans abort
>   btrfs: dont clear qgroup rsv bit in release_folio
>   btrfs: ensure releasing squota rsv on head refs

I've added it to misc-next for testing, some of the patches seem to be
an rc pull material. There are some comments too.

