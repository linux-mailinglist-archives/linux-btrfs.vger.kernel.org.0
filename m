Return-Path: <linux-btrfs+bounces-4047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B02C89D185
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 06:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEB82866DC
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 04:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0052E416;
	Tue,  9 Apr 2024 04:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RjCh7yie";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xmuwGbxO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XTvKrtN7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8sUeGj0x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DAB138E;
	Tue,  9 Apr 2024 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712637072; cv=none; b=SNFtGO+gEhmrgseGqu5iOA849GnMUwoHtg1ofpLAgDYxZzKGU7n0k4Fa2il0e2QrTvM+CIvcp8mAz96T7IaHKUn2/Y6USRSQL+HZuDzMcF3aVcUuFhovjE0OMivOayzSJ8d3edusvnyp9SK2RpImyV92xkhsp1ml1R68z0osIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712637072; c=relaxed/simple;
	bh=rr3Z+k6XjwGf383IjVbF76l/PIZeLvi0f/VVMJVC0fg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGMVF0DGgmHRG6zd3nd1EQ37/JG2bXxa5mBjp7pJVAyStrIlZRh1zNgsrQPjrPrUBcxiDl6zfs/8v2jVZ1yH+8gv0YL8GYavWGzBF000yXMeD1UI13k7trKg1lXgQz+wyY7/brXMq8nDirClKCQAzkwvcAzDAZoExfQDloqBFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RjCh7yie; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xmuwGbxO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XTvKrtN7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8sUeGj0x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 282782079A;
	Tue,  9 Apr 2024 04:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712637060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Uw+MA8cZWaKQE8L1hsoc1njPW28uLAe5ZCvB8QlHvc=;
	b=RjCh7yieO4MQNiIBmkmxdLKMzMH2YSkcXKQ5YmisYJNj1J7LncEtscYS5LiIjY3ftTNvYg
	ObBcxY6R3FOnOXRyS2QEDfgiYOhm5VHcD9PM/mp5AjageN5Rs+VODAlg08ukHp7AWa7q56
	Hm4bjL7srD1ogFtn+va6lXDopH8oOe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712637060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Uw+MA8cZWaKQE8L1hsoc1njPW28uLAe5ZCvB8QlHvc=;
	b=xmuwGbxOYxelHoO8F2Np+3MecLG1fHDVcRaF48csBcU0sBECQKxuxLthkBXJYVYpeZCUMp
	ssopi1ykHyiKj3CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XTvKrtN7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8sUeGj0x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712637059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Uw+MA8cZWaKQE8L1hsoc1njPW28uLAe5ZCvB8QlHvc=;
	b=XTvKrtN7TfTfK0trg36/sxWBlHHDnDlJEpKI3sDDhfdz5zvNRXXxckAKtWtMzR9KVeZA6W
	r86O+OM0Ycd8kItMwg5V3TmSRUxECJWwEkG/ZEZv5jyoyeJOUINjb+Ytw8EwjMt6uSuzRP
	FrGb3MnL2v7NKFgEZ/DBNPUtkNcl1ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712637059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Uw+MA8cZWaKQE8L1hsoc1njPW28uLAe5ZCvB8QlHvc=;
	b=8sUeGj0xOGyTaXAGqMZXe0nWNXAeEKDULN7JgEJcmWja6XD8vDh7w2SilVW/E47pzGWz+a
	/L9xv0L8vbd2hSBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EFAB13586;
	Tue,  9 Apr 2024 04:30:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GJbIC4HEFGYvDQAAn2gu4w
	(envelope-from <ddiss@suse.de>); Tue, 09 Apr 2024 04:30:57 +0000
Date: Tue, 9 Apr 2024 14:30:41 +1000
From: David Disseldorp <ddiss@suse.de>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME
Message-ID: <20240409143041.0d09a45a@echidna>
In-Reply-To: <703aa9f2e34bf4dcc1fc5eec7ef4f65a6705ff14.1712634550.git.anand.jain@oracle.com>
References: <703aa9f2e34bf4dcc1fc5eec7ef4f65a6705ff14.1712634550.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.29 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	BAYES_HAM(-0.28)[74.41%];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 282782079A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.29

On Tue,  9 Apr 2024 11:51:11 +0800, Anand Jain wrote:

> Use SCRATCH_DEV_NAME[n] to provide the device path for each device from
> the scratch device pool. Also, in btrfs/197, remove common/filter since
> it calls common/filter.btrfs.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Looks good.
Reviewed-by: David Disseldorp <ddiss@suse.de>

