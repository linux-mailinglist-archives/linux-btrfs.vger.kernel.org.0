Return-Path: <linux-btrfs+bounces-5424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 665248D8B0F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 22:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A59B27B34
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 20:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DE713B58C;
	Mon,  3 Jun 2024 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yt0IeJeT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JK8bzyD4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yt0IeJeT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JK8bzyD4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A295B651
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447848; cv=none; b=aNI+Wehhqq5iPQ1Bj3cI97ffMI07qqeZdQQiUSIi7b+AnyvhTuuIQkWHtza+ChmfaWw2WIvdL82gHuC0POkTJ8ENSwrAsGXps+KNmtnTMS/WOGhcPhaL7L1eTR2600SBUd7g8L7c0OiswWSfOmWhm4hoDjlX5+16KY7lBOj9hvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447848; c=relaxed/simple;
	bh=S/WUCVjTtr8vW4ff2PkXBJzzJObp/YFSNfIWCkBEkXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZH5QeHI5XOJoYn/8Z9gEpKynZRWUvux0PZY3xZEHBIycjgjoLqUHF6NplPO7FsJadM29u4e/KX/Z56qqH3xBmyI5mMjSBCZXnM4UTcA0HK/mYjm8UQProJECzdhGvVDZdXlQkpvDk9TsgvXxi1khHgKRO3uYfV+J2NJi5/sJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yt0IeJeT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JK8bzyD4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yt0IeJeT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JK8bzyD4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8930D1F770;
	Mon,  3 Jun 2024 20:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717447844;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/WUCVjTtr8vW4ff2PkXBJzzJObp/YFSNfIWCkBEkXw=;
	b=Yt0IeJeTXujkCwNnhmwRK1YnExiY46+1y3oQJnSP+DN2G2OA0yxQgPx1NilQfMZ2YwJoSo
	tBAKMn8V9B3Vm967/L0nujYpjadBxWwI8Bl8W1DPnjZIRf2/Iw11ZMLSqlyaWutsLtftxU
	b8dpuY67AznPOdp2LRFSYYOFi9TsJOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717447844;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/WUCVjTtr8vW4ff2PkXBJzzJObp/YFSNfIWCkBEkXw=;
	b=JK8bzyD4C3NKmVvRxSiC8qkXM8goDzQFgxQKMvW3EZ8EBXfm0pmDXiXh7s4MYWJC98joZQ
	bDXbjafyplzsemCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717447844;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/WUCVjTtr8vW4ff2PkXBJzzJObp/YFSNfIWCkBEkXw=;
	b=Yt0IeJeTXujkCwNnhmwRK1YnExiY46+1y3oQJnSP+DN2G2OA0yxQgPx1NilQfMZ2YwJoSo
	tBAKMn8V9B3Vm967/L0nujYpjadBxWwI8Bl8W1DPnjZIRf2/Iw11ZMLSqlyaWutsLtftxU
	b8dpuY67AznPOdp2LRFSYYOFi9TsJOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717447844;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/WUCVjTtr8vW4ff2PkXBJzzJObp/YFSNfIWCkBEkXw=;
	b=JK8bzyD4C3NKmVvRxSiC8qkXM8goDzQFgxQKMvW3EZ8EBXfm0pmDXiXh7s4MYWJC98joZQ
	bDXbjafyplzsemCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65CF413A93;
	Mon,  3 Jun 2024 20:50:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oXWtGKQsXmYDWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 03 Jun 2024 20:50:44 +0000
Date: Mon, 3 Jun 2024 22:50:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: doc: btrfs device assembly and verification
Message-ID: <20240603205043.GE12376@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <792a9315d9f68d4222aad02a3f245a0f4b63c96b.1716446880.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792a9315d9f68d4222aad02a3f245a0f4b63c96b.1716446880.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]

On Thu, May 23, 2024 at 03:10:32PM +0530, Anand Jain wrote:
> Create a document on how devices are assembled and their verification
> steps.

Thanks. This seems to be a developer documentation, for which you should
put it to dev/ and link it from the respective section in index.rst.

There's some information about the device assembly from user perspective
too, that should go to the user documentation.

