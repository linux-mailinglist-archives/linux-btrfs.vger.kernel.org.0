Return-Path: <linux-btrfs+bounces-791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD71E80C02B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 04:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D931F20FB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 03:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B38F18655;
	Mon, 11 Dec 2023 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sPz/H6vB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GnVv95Wb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yNxkUPsl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IXlFvbcD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631B9F1
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Dec 2023 19:57:06 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA7C61FB54;
	Mon, 11 Dec 2023 03:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702267024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CARWL4cn0CITFUlzTKOYb6PNPgyAHapTxq1q3Yn/M8U=;
	b=sPz/H6vBhkmT2LU09pt9jBnDXQ0I5SKF40sUpRBpSpmkW3SsdQQjn+bD72EORfVX+VTE46
	c64qvRqg0OISg5nvtyEbHARZZIrKONjLiJlr1ahNXYO9WJKNmd9pjSvCE2dHcVtrqZFZUZ
	AbEwH2sYgtPMNGP6bDrBnSvVIgmyW7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702267024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CARWL4cn0CITFUlzTKOYb6PNPgyAHapTxq1q3Yn/M8U=;
	b=GnVv95Wbjkp1CDUMHAeLf4Whj6RwM+6zVAXWXBP95TLpS4kBbsUoApxYydv1lExVY28C9J
	wqDaxbQ+P45Pg9Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702267023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CARWL4cn0CITFUlzTKOYb6PNPgyAHapTxq1q3Yn/M8U=;
	b=yNxkUPsldN4cmDhEbItjeHJxd1VTZPWcoJmffUtknq31r2ISdRzO7IsfdcUr+zFEJr89OU
	rmkPa3ZBO0cEk2/Q0y64RifXErzInNnROr3LE1r9Avsl1EmKK+cXI3G4HiH6TVq1xRSPl3
	QwGlJUCvLUKut9x+ZAJidDg7+Av89ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702267023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CARWL4cn0CITFUlzTKOYb6PNPgyAHapTxq1q3Yn/M8U=;
	b=IXlFvbcDdzDxzCk6ChQgzIImDEItfiI2DIvJ8Cx8jWlCcbqIPzYNiywm7BgzFRHVEmE9Q4
	NNTPMXthYyvj8GAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C1DA1341F;
	Mon, 11 Dec 2023 03:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GD3vBY2IdmXxXAAAn2gu4w
	(envelope-from <ddiss@suse.de>); Mon, 11 Dec 2023 03:57:01 +0000
Date: Mon, 11 Dec 2023 14:56:51 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org, Qu Wenruo
 <wqu@suse.com>
Subject: Re: [PATCH] btrfs: validate scrub_speed_max sysfs string
Message-ID: <20231211145651.57802c5d@echidna>
In-Reply-To: <7d72dca9-d995-40b8-a2f1-97f5526bccc4@gmx.com>
References: <20231207135522.GX2751@twin.jikos.cz>
	<20231208004156.9612-1-ddiss@suse.de>
	<7d72dca9-d995-40b8-a2f1-97f5526bccc4@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Score: -2.57
X-Spamd-Result: default: False [-2.55 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.988];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.76)[93.52%]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.55
Authentication-Results: smtp-out2.suse.de;
	none

On Mon, 11 Dec 2023 13:48:15 +1030, Qu Wenruo wrote:

> On 2023/12/8 11:11, David Disseldorp wrote:
> > Fail the sysfs I/O on any trailing non-space characters.
> >
> > Signed-off-by: David Disseldorp <ddiss@suse.de>  
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks.

> Although I have an unrelated idea.
> 
> Since memparse() provides the @endptr, can we rewind the @endptr, so
> that we can check if the last valid charactor is suffix 'e'.
> Then reject it from btrfs size.

Hmm we could do that, but then we'd also break hex parsing. Rejecting
'e' in the absence of a leading '0x' or '0X' would work, but it's a bit
ugly.

Cheers, David

