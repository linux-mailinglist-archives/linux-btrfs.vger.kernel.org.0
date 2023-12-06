Return-Path: <linux-btrfs+bounces-731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CB5807C90
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 00:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53179282549
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 23:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5013328C5;
	Wed,  6 Dec 2023 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DkIr6Y4L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AyTldEHo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15611A5
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 15:53:07 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D867921CF9;
	Wed,  6 Dec 2023 23:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701906785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7WYoNSygAwQ65Pg7JMvPA85r4yV9FAkAyDwTaZLjRY=;
	b=DkIr6Y4Lsn4Xnrf4gqdaqXv7IcNd7C5CjL3wz1cnfPb6fNtuqYnhmwxhO1Pm2goBDkMUro
	fQIoFrrZdBLCl5yBo3dEyoyosbQuKu9aIUMQUTGRGAK4Jso9NAguA0yb8zY4HlEtkNZS4j
	BHsnpGXAa4sIwtsIr8texAFHV2ECvNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701906785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7WYoNSygAwQ65Pg7JMvPA85r4yV9FAkAyDwTaZLjRY=;
	b=AyTldEHoJSol8HCsKbXlR1ypHQJSXnFQHwDlwSE+zpkDil8lqbk2A3ltbfkwbF/ZfoV7Lw
	SDZbk24k4hMYDpBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 43CA4133DD;
	Wed,  6 Dec 2023 23:53:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wLziM18JcWWRGQAAn2gu4w
	(envelope-from <ddiss@suse.de>); Wed, 06 Dec 2023 23:53:03 +0000
Date: Thu, 7 Dec 2023 10:52:55 +1100
From: David Disseldorp <ddiss@suse.de>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop unused memparse() parameter
Message-ID: <20231207105255.5cbd892a@echidna>
In-Reply-To: <20231206185330.GS2751@twin.jikos.cz>
References: <20231205111329.6652-1-ddiss@suse.de>
	<20231205142253.GD2751@twin.jikos.cz>
	<20231206112143.7d1df045@echidna>
	<20231206185330.GS2751@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.988];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[32.18%]

On Wed, 6 Dec 2023 19:53:31 +0100, David Sterba wrote:

> On Wed, Dec 06, 2023 at 11:21:43AM +1100, David Disseldorp wrote:
> > On Tue, 5 Dec 2023 15:22:53 +0100, David Sterba wrote:
> >   
> > > On Tue, Dec 05, 2023 at 10:13:29PM +1100, David Disseldorp wrote:  
> > > > The @retptr parameter for memparse() is optional.
> > > > btrfs_devinfo_scrub_speed_max_store() doesn't use it for any input
> > > > validation, so the parameter can be dropped.    
> > > 
> > > Or should it be used for validation? memparse is also used in
> > > btrfs_chunk_size_store() that accepts whitespace as trailing characters
> > > (namely '\n' if the value is from echo).  
> > 
> > It probably should have been used for validation when originally added,
> > but the current behaviour is now part of the sysfs scrub_speed_max API.
> > Failing on invalid input would break scripts which do things like
> >   echo clear > /sys/fs/btrfs/UUID/devinfo/1/scrub_speed_max  
> 
> I'm not sure the 'part of the API' is a valid agrument here. It's
> documented that the value is in bytes and that suffixes can be passed
> for convenience. How come anybody would use 'clear' in the first place
> and expect it to work with undefined meaning?

Most people don't read documentation :). If there's a willingness to
accept any fallout from adding the validation then I'm happy to do that.
Will send a v2.

Cheers, David


