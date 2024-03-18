Return-Path: <linux-btrfs+bounces-3376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D5887F314
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 23:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0D81C215DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 22:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8835B1EE;
	Mon, 18 Mar 2024 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i8RZyXz0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+8NvPnhg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i8RZyXz0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+8NvPnhg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8825A7BE
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800686; cv=none; b=Vg9Vst8VE9dDylzhJVzjX3nMwQeV0orcBUs2Lu3Gz1228RSq2/S7ObuJLvHyRJAFjeCRCZPMpuW6Yzbx1yjWpo9DKGD5capVb92SnxOo1qVIpZz2vDi26elADOJgBeu9G+XDVAk5u7lphhggHC8hNuSoIud8zIZOzmW8nHhJkoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800686; c=relaxed/simple;
	bh=Hn/IoF5AdAD+urZuW6ZwD+Rwyx70UxwnqdLTKjH51+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecmHuV2PNpWjyKhNUKOzmNPMpHqipizxR6e7hzlrGCVZIywp55Je14qAJlTfolwQZK8CVuFp5VEGFcIiXw3VjD68WdEIUTH/QmAN16r/O7unNoHGZ+P6z++qnsSDQ6c6lv0P2hd1c9jn/0tCP++eO6L0fkz0+D8CM7Dzcc7lRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i8RZyXz0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+8NvPnhg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i8RZyXz0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+8NvPnhg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 990FB5CBDD;
	Mon, 18 Mar 2024 22:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710800682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OGXNpt4CDrzA2VIgetpFxPuZYTBRONUhHJvbUVUiNM=;
	b=i8RZyXz0Eyz0b3d3Odiu+l3pchPd9i69IHHHnsx/RONmfS159vp037eXZHyUqtMIbXxFta
	Ayzpjoli/rwB6LuAObRcjhroXJsBirClGn0LGmvrtIBauHn2gggNlpRIvwf1TSrSrfpzpy
	JlLLtgy83q4t0xQVX5Nn5YwHsyO72nU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710800682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OGXNpt4CDrzA2VIgetpFxPuZYTBRONUhHJvbUVUiNM=;
	b=+8NvPnhg2zGziwd6+ywey1QjEP0Cd1sXiL2iIVQCNpponeseB2nr4OB5CfLlTulEuQbbVX
	z+KqmscedCM7NTAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710800682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OGXNpt4CDrzA2VIgetpFxPuZYTBRONUhHJvbUVUiNM=;
	b=i8RZyXz0Eyz0b3d3Odiu+l3pchPd9i69IHHHnsx/RONmfS159vp037eXZHyUqtMIbXxFta
	Ayzpjoli/rwB6LuAObRcjhroXJsBirClGn0LGmvrtIBauHn2gggNlpRIvwf1TSrSrfpzpy
	JlLLtgy83q4t0xQVX5Nn5YwHsyO72nU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710800682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OGXNpt4CDrzA2VIgetpFxPuZYTBRONUhHJvbUVUiNM=;
	b=+8NvPnhg2zGziwd6+ywey1QjEP0Cd1sXiL2iIVQCNpponeseB2nr4OB5CfLlTulEuQbbVX
	z+KqmscedCM7NTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8158F1349D;
	Mon, 18 Mar 2024 22:24:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i+xgHyq/+GWcVAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Mar 2024 22:24:42 +0000
Date: Mon, 18 Mar 2024 23:17:29 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: use EXPERIMENTAL instead of
 CONFIG_BTRFS_DEBUG
Message-ID: <20240318221729.GK16737@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a3d01ef26525e9730f1d94de3d7c8e57f3c73fc7.1710458248.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3d01ef26525e9730f1d94de3d7c8e57f3c73fc7.1710458248.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -1.35
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.35 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.14)[68.20%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i8RZyXz0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+8NvPnhg
X-Rspamd-Queue-Id: 990FB5CBDD

On Thu, Mar 14, 2024 at 04:19:00PM -0700, Boris Burkov wrote:
> not sure exactly how this ifdef was supposed to work originally, but it
> currently doesn't and I don't see other use cases of this pattern.
> 
> Use EXPERIMENTAL which does work after:

Ok, makes sense. I missed that because I searched for EXPERIMENTAL and
did not find anything relevant but CONFIG_BTRFS_DEBUG has an effect.
I'll add a comment so it does not get accidentally changed back when
syncin the kernel code. Thanks.

