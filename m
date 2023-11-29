Return-Path: <linux-btrfs+bounces-439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA36C7FDC0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4350A282909
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9D139863;
	Wed, 29 Nov 2023 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A35D46
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 07:57:31 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94A1B219BA;
	Wed, 29 Nov 2023 15:57:28 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 76F0913B49;
	Wed, 29 Nov 2023 15:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8sVyHGhfZ2VWWwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 29 Nov 2023 15:57:28 +0000
Date: Wed, 29 Nov 2023 16:50:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v3 00/19] btrfs: convert to the new mount API
Message-ID: <20231129155011.GS18929@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1700673401.git.josef@toxicpanda.com>
 <20231128211504.GN18929@twin.jikos.cz>
 <3e4cd111-e5a8-6ffd-eb82-0312b6ae739c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e4cd111-e5a8-6ffd-eb82-0312b6ae739c@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: +++++++++++++
X-Spam-Score: 13.97
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz;
	dmarc=none
X-Rspamd-Queue-Id: 94A1B219BA
X-Spamd-Result: default: False [13.97 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 BAYES_HAM(-0.00)[24.91%];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.28)[0.938];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]

On Wed, Nov 29, 2023 at 08:59:57PM +0800, Anand Jain wrote:
> On 29/11/2023 05:15, David Sterba wrote:
> > On Wed, Nov 22, 2023 at 12:17:36PM -0500, Josef Bacik wrote:
> >> v2->v3:
> >> - Fixed up the various review comments from Dave and Anand.
> >> - Added a patch to drop the deprecated mount options we currently have.
> > 
> > I finished review of v3, there were some changes missing from my v2
> > comments, I also did some renames and comment updates. Patches moved
> > from topic branch to misc-next, thanks.
> Apologies for the delayed review.
> 
> The renaming of check_options() should have been in patch 2/19
> instead of patch 14/19, avoids confusion in the function stack.

Yeah it could have been renamed in patch 2, though I hope it's not a big
deal. The final name is with the btrfs_ prefix so the stack name
confusion would happen only when debugging something between patches 2
and 14.

> For now, except for the patches listed here [1],
> the remaining ones have been reviewed.

Thanks. In case you'd continue with the remaining patches feel free to
send rev-by later.

