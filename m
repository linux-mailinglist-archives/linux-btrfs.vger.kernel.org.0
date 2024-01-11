Return-Path: <linux-btrfs+bounces-1396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDED82B224
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 16:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5C71C243BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E294F882;
	Thu, 11 Jan 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NSkMrgsD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IHZZ3Adc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NSkMrgsD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IHZZ3Adc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E574EB45;
	Thu, 11 Jan 2024 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F6551FBAD;
	Thu, 11 Jan 2024 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704988272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vSehzTtKQsvkbUUPD8zzvmB+qLGM6QNeLjYsgnJ08M=;
	b=NSkMrgsDX7EFKr/+gIAf2t9qOk+4ZUhng52yeaAX718zL2LQLlDxVBH6w54QAD17KVWld5
	vntTVSXxWB+HS7W1ORztIiuYM03STgLc0+zF8ATIe+ZDMb2RFx4uaHKMDynYR1ANyKKTTZ
	FZTlpKzdMwqmjqIIkw8jdnEoXZDYIj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704988272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vSehzTtKQsvkbUUPD8zzvmB+qLGM6QNeLjYsgnJ08M=;
	b=IHZZ3AdcRHNQNoPDCZmlSTmGoul7uWFhhD8Sj1lLJmEwHs/fQeDk83h5xSVvNVgZj+xFgX
	E7At9SGs+IK8meAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704988272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vSehzTtKQsvkbUUPD8zzvmB+qLGM6QNeLjYsgnJ08M=;
	b=NSkMrgsDX7EFKr/+gIAf2t9qOk+4ZUhng52yeaAX718zL2LQLlDxVBH6w54QAD17KVWld5
	vntTVSXxWB+HS7W1ORztIiuYM03STgLc0+zF8ATIe+ZDMb2RFx4uaHKMDynYR1ANyKKTTZ
	FZTlpKzdMwqmjqIIkw8jdnEoXZDYIj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704988272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vSehzTtKQsvkbUUPD8zzvmB+qLGM6QNeLjYsgnJ08M=;
	b=IHZZ3AdcRHNQNoPDCZmlSTmGoul7uWFhhD8Sj1lLJmEwHs/fQeDk83h5xSVvNVgZj+xFgX
	E7At9SGs+IK8meAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DB9F5138E5;
	Thu, 11 Jan 2024 15:51:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 7f2qNG8OoGXZeQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jan 2024 15:51:11 +0000
Date: Thu, 11 Jan 2024 16:50:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Anand Jain <anand.jain@oracle.com>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-kernel@vger.kernel.org, Alex Romosan <aromosan@gmail.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [btrfs] commit bc27d6f0aa0e4de184b617aceeaf25818cc646de breaks
 update-grub
Message-ID: <20240111155056.GG31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
 <39e3a4fe-d456-4de4-b481-51aabfa02b8d@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e3a4fe-d456-4de4-b481-51aabfa02b8d@leemhuis.info>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[42.10%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lists.linux.dev,gmail.com,fb.com,toxicpanda.com,suse.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Thu, Jan 11, 2024 at 12:45:50PM +0100, Thorsten Leemhuis wrote:
> [Adding Anand Jain, the author of the culprit to the list of recipients;
> furthermore CCing the the Btrfs maintainers and the btrfs list; also
> CCing regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> 
> On 08.01.24 15:11, Alex Romosan wrote:
> > Please Cc me as I am not subscribed to the list.
> > 
> > Running my own compiled kernel without initramfs on a lenovo thinkpad
> > x1 carbon gen 7.
> > 
> > Since version 6.7-rc1 i haven't been able to to a grub-update,
> >
> > instead i get this error:
> > 
> > grub-probe: error: cannot find a device for / (is /dev mounted?) solid
> > state drive
> > 
> > 6.6 was the last version that worked.
> > 
> > Today I did a git-bisect between these two versions which identified
> > commit bc27d6f0aa0e4de184b617aceeaf25818cc646de btrfs: scan but don't
> > register device on single device filesystem as the culprit. reverting
> > this commit from 6.7 final allowed me to run update-grub again.
> > 
> > not sure if this is the intended behavior or if i'm missing some other
> > kernel options. any help/fixes would be appreciated.
> > 
> > thank you.
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced bc27d6f0aa0e4de184b617aceeaf25818cc646de
> #regzbot title btrfs: update-grub broken (cannot find a device for / (is
> /dev mounted?))
> #regzbot ignore-activity

The bug is also tracked at https://bugzilla.kernel.org/show_bug.cgi?id=218353 .

