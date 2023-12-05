Return-Path: <linux-btrfs+bounces-650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC421805A85
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E2F281237
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 16:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC361FA8;
	Tue,  5 Dec 2023 16:53:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463531BDB
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 08:53:28 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BCED21EA5;
	Tue,  5 Dec 2023 16:53:26 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CA02138FF;
	Tue,  5 Dec 2023 16:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AwbyE4ZVb2X+NgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 16:53:26 +0000
Date: Tue, 5 Dec 2023 17:46:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: l@damenly.org, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: tune: add fsck runs before and after a
 full conversion
Message-ID: <20231205164636.GL2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701672971.git.wqu@suse.com>
 <f919ead47c266bbb4c24ba873e565e4c36b9377a.1701672971.git.wqu@suse.com>
 <a5qqguz5.fsf@damenly.org>
 <455ec3c5adf1dbb10f5ee00bf3a6c955@damenly.org>
 <e051f2dd-dbd6-4e3f-b828-a66a991ed4c2@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e051f2dd-dbd6-4e3f-b828-a66a991ed4c2@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-0.05 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(0.00)[suse.cz];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(0.00)[~all];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.17)[-0.845];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.07)[62.71%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spamd-Bar: /
X-Spam-Score: -0.05
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Queue-Id: 9BCED21EA5

On Mon, Dec 04, 2023 at 08:52:15PM +1030, Qu Wenruo wrote:
> > And maybe an option to skip check? People who want to convert to BG tree
> > usually have large filesystems, then the original check can be killed
> > because of OOM...
> 
> I don't want to allow it to be skipped. Maybe I can add some logic to go
> lowmem mode depending on the filesystem size.

We have power users who know what they're doing and no way to skip the
check is considered a usability bug. The check can fail for reasons that
may not be due to detected problems but due to lack of memory. The
heuristic regarding lowmem or original mode does not sound like a good
idea to me, it seems too unreliable.

> Just don't want to risk any possible corruption.

Instead of forcing the check in all cases, by default it can skip the
conversion and print a warning with and recommendation to run check.
With an option to override it it would start right away.

