Return-Path: <linux-btrfs+bounces-434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19ED7FD62F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 13:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC022283498
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 12:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E41DA2A;
	Wed, 29 Nov 2023 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4C310C9;
	Wed, 29 Nov 2023 04:02:25 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B8A621AD1;
	Wed, 29 Nov 2023 12:02:24 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C4761376F;
	Wed, 29 Nov 2023 12:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uAubClAoZ2XfAgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 29 Nov 2023 12:02:24 +0000
Date: Wed, 29 Nov 2023 12:55:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	regressions@lists.linux.dev, linux-btrfs@vger.kernel.org,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Chris Mason <clm@fb.com>, Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: btrfs: super.c:416:25: error: 'ret' undeclared (first use in
 this function); did you mean 'net'?
Message-ID: <20231129115511.GP18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CA+G9fYvbCBUCkt-NdJ7HCETCFrzMWGnjnRBjCsw39Z_aUOaTDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvbCBUCkt-NdJ7HCETCFrzMWGnjnRBjCsw39Z_aUOaTDQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Queue-Id: 4B8A621AD1
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]

On Tue, Nov 28, 2023 at 05:55:51PM +0530, Naresh Kamboju wrote:
> Following x86 and i386 build regressions noticed on Linux next-20231128 tag.
> 
> Build log:
> -----------
> fs/btrfs/super.c: In function 'btrfs_parse_param':
> fs/btrfs/super.c:416:25: error: 'ret' undeclared (first use in this
> function); did you mean 'net'?
>   416 |                         ret = -EINVAL;
>       |                         ^~~
>       |                         net
> fs/btrfs/super.c:416:25: note: each undeclared identifier is reported
> only once for each function it appears in
> fs/btrfs/super.c:417:25: error: label 'out' used but not defined
>   417 |                         goto out;
>       |                         ^~~~
> make[5]: *** [scripts/Makefile.build:243: fs/btrfs/super.o] Error 1

Fixed in today's for-next snapshot, thanks.

