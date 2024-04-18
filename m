Return-Path: <linux-btrfs+bounces-4389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC5E8A9010
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 02:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96357B22287
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 00:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E82C1755B;
	Thu, 18 Apr 2024 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uKzwE2Ej";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xwGnAP/j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uKzwE2Ej";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xwGnAP/j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0BFA936;
	Thu, 18 Apr 2024 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713400399; cv=none; b=MpXoor9x2a1DhGrG2R8FsuWS607XRoFEmcBV8GXpm4flL88T2aRAU6F4v+uETF/1aBG+NZDef9fF5Jw9NDtW7FqDKTOA3MsvxI22HFLie3xbr+I+81A/UgiVS5bmqPQGcK9LEca79lPB0q0dbhON92h6kiSRd0GTLk2mopCrfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713400399; c=relaxed/simple;
	bh=jFiigb+sZssgyg+HX5GBIUCxkF3g929FjlUMnRbUchw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQCnY+Lp2e1gl06YDFfQs/ApoSE9BlOj+ps7fAE76/TvOeyMTv/MRP4uQSOHiN1eyQHu2zpTRMbdLtRa8idyN2ocAwpAOG531CGxQkm76MnuvwgD0GJA2MfxVMq9AHlWyI715nSGWKdhvoVtPl+PN/aq5juKKPW9BZs4tHCnMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uKzwE2Ej; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xwGnAP/j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uKzwE2Ej; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xwGnAP/j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10C285BF8E;
	Thu, 18 Apr 2024 00:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713400396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C11E3n+/YpebzhlOLZhtCcc0QwKMH9acS3KY8tOoofY=;
	b=uKzwE2Ej3WSRitcTO1FW62nDkeN5YSHxeDNUAnU1Wsx2kalQ8gwLByxQ+/QiqkSfDywiS6
	+MtDUlGOMYe39386f/iK/6dJrgmo7J4wkIw2xSbF6JlOAMQoYO6FL2yMrmWA8GumTUM68j
	kqgeK6AbXM9SmtwqhbtLR+zhsH2Be/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713400396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C11E3n+/YpebzhlOLZhtCcc0QwKMH9acS3KY8tOoofY=;
	b=xwGnAP/jYQ5aXd4B5m4WXqL8qA4GTzc9IZ9byBxY9Tkanjc+8T6T/v7bdREPPkAqf+A8MZ
	EiN0QZtGz7lsFmBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713400396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C11E3n+/YpebzhlOLZhtCcc0QwKMH9acS3KY8tOoofY=;
	b=uKzwE2Ej3WSRitcTO1FW62nDkeN5YSHxeDNUAnU1Wsx2kalQ8gwLByxQ+/QiqkSfDywiS6
	+MtDUlGOMYe39386f/iK/6dJrgmo7J4wkIw2xSbF6JlOAMQoYO6FL2yMrmWA8GumTUM68j
	kqgeK6AbXM9SmtwqhbtLR+zhsH2Be/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713400396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C11E3n+/YpebzhlOLZhtCcc0QwKMH9acS3KY8tOoofY=;
	b=xwGnAP/jYQ5aXd4B5m4WXqL8qA4GTzc9IZ9byBxY9Tkanjc+8T6T/v7bdREPPkAqf+A8MZ
	EiN0QZtGz7lsFmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0381C133A7;
	Thu, 18 Apr 2024 00:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3RGoAExqIGaAEQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 18 Apr 2024 00:33:16 +0000
Date: Thu, 18 Apr 2024 02:25:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 6.9-rc5
Message-ID: <20240418002542.GW3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713396900.git.dsterba@suse.com>
 <CAHk-=wirVv7e6r+UOe5Svjrkx-Cy_=1bNSigdYrWWwzfv_-4gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wirVv7e6r+UOe5Svjrkx-Cy_=1bNSigdYrWWwzfv_-4gA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.94
X-Spam-Level: 
X-Spamd-Result: default: False [-3.94 / 50.00];
	BAYES_HAM(-2.94)[99.76%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]

On Wed, Apr 17, 2024 at 05:14:56PM -0700, Linus Torvalds wrote:
> On Wed, 17 Apr 2024 at 16:53, David Sterba <dsterba@suse.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc4-tag
> 
> Nol such tag. I see the branch 'for-6.9-rc4' with the right commit,
> but not the signed tag. Forgot to push out?

Yes, sorry, now pushed.

