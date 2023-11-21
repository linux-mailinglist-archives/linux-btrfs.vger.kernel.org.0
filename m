Return-Path: <linux-btrfs+bounces-231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079E87F2E05
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DF9282A66
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCAF495EA;
	Tue, 21 Nov 2023 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="acPws2Qr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MQsTNeSX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55629BD
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 05:12:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF8C3218FA;
	Tue, 21 Nov 2023 13:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700572342;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kikeMXILyTQb3ckOU8wdNsqxmvcCmcdHyC0wxEC3Kqw=;
	b=acPws2QrALmqaMVK6TraLdRVTegzt5b2dKCzlGUbmgqV1wXDPzVftyATZXKWmDxPM6qlKv
	UabqbJSztFJgyzBf23bKABcix9a7qRvr16bXVK6JPdxUWxqrS38skfGm7V/oMKZNkui5cy
	acF7noVgJOqSbJLXDe/mBCnhSPJ9v7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700572342;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kikeMXILyTQb3ckOU8wdNsqxmvcCmcdHyC0wxEC3Kqw=;
	b=MQsTNeSXMB8VaJ5/hjnYilQ0mZKr2/ZSe/wNZo7MQqarNu1yptu1YccoQkPRtMMj4zecWx
	rsnT6QLGk4ZNTfAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC0C6139FD;
	Tue, 21 Nov 2023 13:12:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NG8UMbasXGXbKAAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 21 Nov 2023 13:12:22 +0000
Date: Tue, 21 Nov 2023 14:05:13 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, jirislaby@kernel.org
Subject: Re: [PATCH 0/5] Remove some unused struct members
Message-ID: <20231121130513.GQ11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1700531088.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700531088.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 1.74
X-Spamd-Result: default: False [1.74 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.46)[79.18%]

On Tue, Nov 21, 2023 at 02:50:10AM +0100, David Sterba wrote:
> Jiri Slaby wrote a tool to find unused struct members [1]. There are
> some interesting fossils. Comparing that to my hacky coccinelle scripts,
> it did a much better job.
> 
> [1] https://github.com/jirislaby/clang-struct
> 
> David Sterba (5):
>   btrfs: scrub: remove unused scrub_ctx::sectors_per_bio
>   btrfs: remove unused btrfs_ordered_extent::outstanding_isize
>   btrfs: raid56: remove unused btrfs_plug_cb::work
>   btrfs: remove unused definition of tree_entry in extent-io-tree.c
>   btrfs: remove unused btrfs_root::type

Added to misc-next.

