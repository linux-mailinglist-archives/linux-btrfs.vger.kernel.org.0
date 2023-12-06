Return-Path: <linux-btrfs+bounces-720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C88A80784D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 20:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD3E1F2137F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1594E63D;
	Wed,  6 Dec 2023 19:00:42 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996D684
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 11:00:23 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F4E92207A;
	Wed,  6 Dec 2023 19:00:22 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DCA2713403;
	Wed,  6 Dec 2023 19:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yuHbM8XEcGUeWgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 06 Dec 2023 19:00:21 +0000
Date: Wed, 6 Dec 2023 19:53:31 +0100
From: David Sterba <dsterba@suse.cz>
To: David Disseldorp <ddiss@suse.de>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop unused memparse() parameter
Message-ID: <20231206185330.GS2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231205111329.6652-1-ddiss@suse.de>
 <20231205142253.GD2751@twin.jikos.cz>
 <20231206112143.7d1df045@echidna>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206112143.7d1df045@echidna>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 1F4E92207A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd1

On Wed, Dec 06, 2023 at 11:21:43AM +1100, David Disseldorp wrote:
> On Tue, 5 Dec 2023 15:22:53 +0100, David Sterba wrote:
> 
> > On Tue, Dec 05, 2023 at 10:13:29PM +1100, David Disseldorp wrote:
> > > The @retptr parameter for memparse() is optional.
> > > btrfs_devinfo_scrub_speed_max_store() doesn't use it for any input
> > > validation, so the parameter can be dropped.  
> > 
> > Or should it be used for validation? memparse is also used in
> > btrfs_chunk_size_store() that accepts whitespace as trailing characters
> > (namely '\n' if the value is from echo).
> 
> It probably should have been used for validation when originally added,
> but the current behaviour is now part of the sysfs scrub_speed_max API.
> Failing on invalid input would break scripts which do things like
>   echo clear > /sys/fs/btrfs/UUID/devinfo/1/scrub_speed_max

I'm not sure the 'part of the API' is a valid agrument here. It's
documented that the value is in bytes and that suffixes can be passed
for convenience. How come anybody would use 'clear' in the first place
and expect it to work with undefined meaning?

