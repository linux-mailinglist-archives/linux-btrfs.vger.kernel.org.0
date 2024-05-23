Return-Path: <linux-btrfs+bounces-5259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEC48CD918
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 19:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A4A283597
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 17:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A06A502BB;
	Thu, 23 May 2024 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0cO4Ff7Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZjHTVAM9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0cO4Ff7Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZjHTVAM9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD97F496
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484710; cv=none; b=PRmwqaMkpxbdZS71DUHRBJC6rWjbjSZQn8Qi4iAecsxkoVmiTq6J3HD4AbQcC4unw+660pCjOsgQ3khEMmO6Ke5WtM+fOcecoJ1/o9RTxrhZ2MzPyELsqEk5uNdesR0hEiNU+9pRI/Q4PNjVPRXWq2wb68PrvgHTt8wPwn53ZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484710; c=relaxed/simple;
	bh=yb9n17i02ySnIj1ee3owVbYw34FAOzm9zBWpHhCh7Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag6O7G+uywO9DgRqBFzmhx6JSfWI/LuYwjQES5Ov16jLSYDKVz8NvkfUKoBcRam+QOy+p4sFcJ2fBm99UBQl7mpnDPdS5MN+YJFUPBz2k7DH4WFGzVRq/v3i1yDVvggUzQ09jUKloOAevUEkkSSAdSrDmpD9XU4jMUuP9Qtmdcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0cO4Ff7Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZjHTVAM9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0cO4Ff7Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZjHTVAM9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C617A2037B;
	Thu, 23 May 2024 17:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716484706;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZA+irl37sU63rpGQb3q8L7/J+9dnZhH3fi93NY3848=;
	b=0cO4Ff7ZJfvMQvncLddHAfJcfkiQVfYu6HJY6OBfLvlYml21/2uZzc5Wp6Gix1SI4Y0+88
	nonKg+tuQpe2tcIWWbpFndgQuAB1FPphMU6hEYPVoOo8oH+3ECsamvgVeZw6IyqcMUbae8
	hWE1C6DyMqZLA0FIHIkD+L1313z6KaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716484706;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZA+irl37sU63rpGQb3q8L7/J+9dnZhH3fi93NY3848=;
	b=ZjHTVAM9M9S3sdvnepLCxcCgSB0qTvaeRikfOx8mJ3ksNRZ9y8SEGtr8/8E92HvW/Xny7x
	qu56Eau/AQFSKJBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716484706;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZA+irl37sU63rpGQb3q8L7/J+9dnZhH3fi93NY3848=;
	b=0cO4Ff7ZJfvMQvncLddHAfJcfkiQVfYu6HJY6OBfLvlYml21/2uZzc5Wp6Gix1SI4Y0+88
	nonKg+tuQpe2tcIWWbpFndgQuAB1FPphMU6hEYPVoOo8oH+3ECsamvgVeZw6IyqcMUbae8
	hWE1C6DyMqZLA0FIHIkD+L1313z6KaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716484706;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZA+irl37sU63rpGQb3q8L7/J+9dnZhH3fi93NY3848=;
	b=ZjHTVAM9M9S3sdvnepLCxcCgSB0qTvaeRikfOx8mJ3ksNRZ9y8SEGtr8/8E92HvW/Xny7x
	qu56Eau/AQFSKJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3DEF13A6B;
	Thu, 23 May 2024 17:18:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M1+OJ2J6T2a4NwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 23 May 2024 17:18:26 +0000
Date: Thu, 23 May 2024 19:18:25 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/6] part3 trivial adjustments for return variable
 coding style
Message-ID: <20240523171825.GF17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1716310365.git.anand.jain@oracle.com>
 <20240521181003.GT17126@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521181003.GT17126@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, May 21, 2024 at 08:10:03PM +0200, David Sterba wrote:
> On Wed, May 22, 2024 at 01:11:06AM +0800, Anand Jain wrote:
> > This is v4 of part 3 of the series, containing renaming with optimization of the
> > return variable.
> > 
> > v3 part3:
> >   https://lore.kernel.org/linux-btrfs/cover.1715783315.git.anand.jain@oracle.com/
> > v2 part2:
> >   https://lore.kernel.org/linux-btrfs/cover.1713370756.git.anand.jain@oracle.com/
> > v1:
> >   https://lore.kernel.org/linux-btrfs/cover.1710857863.git.anand.jain@oracle.com/
> > 
> > Anand Jain (6):
> >   btrfs: rename err to ret in btrfs_cleanup_fs_roots()
> >   btrfs: rename ret to err in btrfs_recover_relocation()
> >   btrfs: rename ret to ret2 in btrfs_recover_relocation()
> >   btrfs: rename err to ret in btrfs_recover_relocation()
> >   btrfs: rename err to ret in btrfs_drop_snapshot()
> >   btrfs: rename err to ret in btrfs_find_orphan_roots()
> 
> 1-5 look ok to me, for patch 6 there's the ret = 0 reset question sent
> to v3.

You can add 1-5 to for-next with

Reviewed-by: David Sterba <dsterba@suse.com>

and only resend 6.

