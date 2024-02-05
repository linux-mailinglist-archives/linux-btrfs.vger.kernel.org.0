Return-Path: <linux-btrfs+bounces-2104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802228498CA
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 12:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363A5284D07
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BBC18EB1;
	Mon,  5 Feb 2024 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Ahb1pxm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/Ejd9csA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Ahb1pxm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/Ejd9csA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CED18E17;
	Mon,  5 Feb 2024 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132412; cv=none; b=u4BU0m0ZVF8Pozt6rZ0Oh38/A+clF58XEoxD+pIosQl3srUBhPNLM7Mh0jdH6OxzU328rVf67+Xgg8M6dTDayf6RQzV5UyWqJdyzWnJrvJil9zsjfIpybYmVcm7VEJjUsflpUpwwTQ/OmUk8bAcFD9Y6lzoMLyTak5Z3TQGbv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132412; c=relaxed/simple;
	bh=ybivmONZX65EOsfSi7RsxbgZyaxo2g1bO2vvi/l94VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGmm4ig73IoBzVr1kaboGnCHUE5dN3r5q+n3t8e9d+i1VzWgDwMzls5ObplYyp8ar9Foz80Wd2bSRVj/5kwyK2rn7s2Mi0pAvYrRhccXDb/p+tz5SSmLB+IdDDvCTou/JBc3drOOLSI5Na8FQ4ffWvT25nQXs8/PEHRGkTT1UlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Ahb1pxm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/Ejd9csA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Ahb1pxm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/Ejd9csA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 789D522277;
	Mon,  5 Feb 2024 11:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707132408;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ybivmONZX65EOsfSi7RsxbgZyaxo2g1bO2vvi/l94VE=;
	b=1Ahb1pxmTN+R6L8y/ozKrZ4/vT7kT3QMrc+r/M/l0WIQADO9GMV01yVUxdYTfKBL1pnAwr
	7rTVLQwYzIixhTS+30z/knNCgwOhudufEDdwLXBIZ7beJaYSBmChvbiy6FP86u9CYRiGon
	wHV2EHNlnxLwcSlou+gHtPhadHaq/fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707132408;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ybivmONZX65EOsfSi7RsxbgZyaxo2g1bO2vvi/l94VE=;
	b=/Ejd9csA5Z0I93oCa7LPkd3i8ZicW6zmBssTB+tupksD9ZBkslYCdW6TDCVvHrOzVxZBjO
	pIXh3u/qMvBHXcCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707132408;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ybivmONZX65EOsfSi7RsxbgZyaxo2g1bO2vvi/l94VE=;
	b=1Ahb1pxmTN+R6L8y/ozKrZ4/vT7kT3QMrc+r/M/l0WIQADO9GMV01yVUxdYTfKBL1pnAwr
	7rTVLQwYzIixhTS+30z/knNCgwOhudufEDdwLXBIZ7beJaYSBmChvbiy6FP86u9CYRiGon
	wHV2EHNlnxLwcSlou+gHtPhadHaq/fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707132408;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ybivmONZX65EOsfSi7RsxbgZyaxo2g1bO2vvi/l94VE=;
	b=/Ejd9csA5Z0I93oCa7LPkd3i8ZicW6zmBssTB+tupksD9ZBkslYCdW6TDCVvHrOzVxZBjO
	pIXh3u/qMvBHXcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58BAE136F5;
	Mon,  5 Feb 2024 11:26:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 295mFfjFwGV0QAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 Feb 2024 11:26:48 +0000
Date: Mon, 5 Feb 2024 12:26:19 +0100
From: David Sterba <dsterba@suse.cz>
To: Alex Romosan <aromosan@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Anand Jain <anand.jain@oracle.com>,
	CHECK_1234543212345@protonmail.com, brauner@kernel.org,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	dsterba@suse.cz
Subject: Re: [btrfs] commit bc27d6f0aa0e4de184b617aceeaf25818cc646de breaks
 update-grub
Message-ID: <20240205112619.GC355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
 <39e3a4fe-d456-4de4-b481-51aabfa02b8d@leemhuis.info>
 <20240111155056.GG31555@twin.jikos.cz>
 <20240111170644.GK31555@twin.jikos.cz>
 <f45e5b7c-4354-87d3-c7f1-d8dd5f4d2abd@oracle.com>
 <7d3cee75-ee74-4348-947a-7e4bce5484b2@leemhuis.info>
 <CAKLYgeLhcE5+Td9eGKAi0xeXSsom381RxuJgKiQ0+oHDNS_DJA@mail.gmail.com>
 <CAKLYgeKCuDmnuGHuQYPdZZA1_H3s9_9oh+vT_FMpFZqxKSvjzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKLYgeKCuDmnuGHuQYPdZZA1_H3s9_9oh+vT_FMpFZqxKSvjzw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1Ahb1pxm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/Ejd9csA"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,protonmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[lists.linux.dev,oracle.com,protonmail.com,kernel.org,vger.kernel.org,fb.com,toxicpanda.com,suse.com,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.99%]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: 789D522277
X-Spam-Flag: NO

On Sun, Feb 04, 2024 at 07:29:29PM +0100, Alex Romosan wrote:
> sorry about the html post (in case somebody actually got it). as i was
> saying, just for the record it's still not fixed in 6.8-rc3. thanks.

I've updated the bug with link to fix

https://github.com/kdave/btrfs-devel/commit/b80f3ec6592c69f88ebc74a4e16676af161e2759

but would like to ask for testing.

