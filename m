Return-Path: <linux-btrfs+bounces-13556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172B8AA51D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 18:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374D37B6DEE
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFC5262800;
	Wed, 30 Apr 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VuM+sBcb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MTOzg6dk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qkZwy7LC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FSbo1xiX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE91714B7
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031251; cv=none; b=pY1SkrQNzIJf5HbTzXdzHObiyWF7tK6xODwooJItBLJXhZIRmbJmF0vEYdNnsUYxLFsjR8IWlk4CTEsPBFBV9tzcGGO1NNOmtNIKwQvL6uNIWTDxIarl2f36Il1HMSqYHIT3oGAKReKwfsW0Ips2ti+rDVubOkT0Nu+vOe2Haok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031251; c=relaxed/simple;
	bh=I8d9rQf0rDgRs6FOss4aqZenfeCTHZNA1O4FhKrl1p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMZaXMzFDV1fo3sjqETc0dzczZapqaQB5piD+BsnrO2bDIP5L9O6BHrnEn2wJkAyXXn9gUsvRf5NgbowNZKVREv0yaSmeB7beOtI/5lProPN0bjdNZ1u0jgPv3KOryaV+qPrqYyMYyAy78HatXlixY04o8bKFWYDqIZRZLetG3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VuM+sBcb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MTOzg6dk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qkZwy7LC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FSbo1xiX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DCEA321188;
	Wed, 30 Apr 2025 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746031248;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5LfTm190mWb1GM+2VH4VcdHjUTHfmPbgr6CCN0tqAk=;
	b=VuM+sBcbrrQexqvS62hfyjZCAKML/+WZQarr55FdUjg8+lkjCIjvBXdSVULOHYBtV2H9gl
	rj/SFIfIfOZdTdytDLZkl6xiKARb5Np+5YIwPgc/PclgElAQgeNAck1CTYkq92xviHJdMc
	FyI65M9VisxflFcBgG8JkrdPWLh4yEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746031248;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5LfTm190mWb1GM+2VH4VcdHjUTHfmPbgr6CCN0tqAk=;
	b=MTOzg6dkYMG8LGXOWRDbvrO1O5Ym521x34b7atmCsmqduDRm2tNwD52cjvomb5t2ZO0VvY
	9mdP5vGZto3k/UDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746031247;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5LfTm190mWb1GM+2VH4VcdHjUTHfmPbgr6CCN0tqAk=;
	b=qkZwy7LCoTtB+H91ATB086Biw3/0J3moElitiUexBx1ZZIpBZWov+FlHR9EdTT61sA1Y1S
	idkLjYoRj2z9TRiI3V14+H/Qa1HVMCi76dlSfn/swuq1W4a/cPhYqFOlG1un+v/fX/uxth
	Qjni20SzvvJ9ijJoh6YTK37D4trXAzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746031247;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5LfTm190mWb1GM+2VH4VcdHjUTHfmPbgr6CCN0tqAk=;
	b=FSbo1xiX0itTZ0hHWfZUz1/0efQUh2dUQXziV4qbL6nEA/QOAyXOAqj0pbEzcSkMAVZIMZ
	SsxxBSfjydbEFODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEF1F13ABF;
	Wed, 30 Apr 2025 16:40:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 829iLo9SEmiVMQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 30 Apr 2025 16:40:47 +0000
Date: Wed, 30 Apr 2025 18:40:46 +0200
From: David Sterba <dsterba@suse.cz>
To: =?utf-8?B?5bCP56yg5Y6fIOWFseW/lw==?= <sawara04.o@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Implement warning for commit values exceeding 300
Message-ID: <20250430164046.GK9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250428044626.2371987-1-sawara04.o@gmail.com>
 <a95364ca-7903-4cbf-9f75-417fc0d26bbc@gmx.com>
 <20250428151259.GE7139@twin.jikos.cz>
 <CAKNDObASvhXH3F4jRBHQ2EA6CN+-L-qgg92D2GKAorMu2g9Aig@mail.gmail.com>
 <d479b722-f3c9-4882-9aa0-eb7f7f7272df@gmx.com>
 <CAKNDObBnpNsyXr4bJeCOQX+d0qrpKMt-LqpE=PMRpyzn=-vtbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKNDObBnpNsyXr4bJeCOQX+d0qrpKMt-LqpE=PMRpyzn=-vtbg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,suse.cz,fb.com,toxicpanda.com,suse.com,vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -2.50
X-Spam-Flag: NO

On Thu, May 01, 2025 at 12:33:32AM +0900, 小笠原 共志 wrote:
> > Sure, that sounds good to me.
> 
> Thank you.
> 
> I would like to confirm whether the warning message
> "excessive commit interval %u, use with care" is acceptable.
> Please let me know if you have any concerns or suggestions
> for improvement.

Yes, this is OK, thanks.

