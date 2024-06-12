Return-Path: <linux-btrfs+bounces-5677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026DB905D01
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 22:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C821C23205
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 20:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E073684E0D;
	Wed, 12 Jun 2024 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0+1DudiW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l+PYCS2x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZiXIKahf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GXu/HA1z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE684DF1
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225070; cv=none; b=MQIFBehJjmRJ+elq8nHZsFpESTruz1mko2SL5sToJWB3bePtJyWAAgHtNSPjoQoMgulkoYkoWzO523fBiSxvcK4rJiJxNI1uavSfGCIEt2yUKATfibpIUp2zP4MmMGD1rnAuWPikWuMdzq3vETyZfUso2Y0M50ydP/FrWdoqf/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225070; c=relaxed/simple;
	bh=GLO564d02VbAuCCZBCGkgu2lEjLBujnWEq20PCxWpo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asuVoAI4WuGTMp3TfM2dNnEgCXhj+EXox9NuHm+qVhjClnXrCrYX71kwpacuN/oUPJZkpef/wFP3JwQKFD1mZjWr/Gd8QV5Yz+ceyt+eduLwTI2Uu45GOrQuTuzVddi6q170W8KI9o9U+F58jDMvKfWt4VvPXTvcpMYSp/+Z65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0+1DudiW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l+PYCS2x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZiXIKahf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GXu/HA1z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6475D5C72A;
	Wed, 12 Jun 2024 20:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718225066;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWENkJctboslSizAjTO67YL0jO75pIK7C/cInGobCYg=;
	b=0+1DudiWihBqgLaij+rO1QfE4fO/g+R0q797v3s76DC44BU/aY87jMhdTPw9bCW1ihTnmc
	QT6/E02h93F8SpZKT9ghD5KXeyb97BpjA0UN0kQUs1avYb7mKZ2fvranQ9DuM1iqipm0V6
	EGz+AnmTUtNvx4bIDsLhUzaUYOTG0GE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718225066;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWENkJctboslSizAjTO67YL0jO75pIK7C/cInGobCYg=;
	b=l+PYCS2xmAtuTnj6UCF92wIbEnXvB9p+C/sDA0wuM8mgqpN+iMLEutT7JSDQwcD2pP7wd9
	6ZrYqqDApKhDnZCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZiXIKahf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="GXu/HA1z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718225065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWENkJctboslSizAjTO67YL0jO75pIK7C/cInGobCYg=;
	b=ZiXIKahflA8IV3LkdZRJ33lssNtLdnetIWR0tcqaU4d5UNnvk1E2UWvWxmnr+6WBHCTA3Y
	dRFx6PEF0Db64p26pvfnXTGoniDvxy9A+Tga47XJdKtu3QxQ17oKQ8S6QfUolPUcxcpgDh
	cj8JE0TAG8AVjF8hMdSaFyrVdtBXxb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718225065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWENkJctboslSizAjTO67YL0jO75pIK7C/cInGobCYg=;
	b=GXu/HA1z7bQ3LH8OLVIaA/vaBlNMa04RzFfUsVic9sDWLF/k+Jl/iWpIj38500+RooHmKr
	MCTd6tbPA6b6vEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E4E21372E;
	Wed, 12 Jun 2024 20:44:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AgerEqkIamZXLwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Jun 2024 20:44:25 +0000
Date: Wed, 12 Jun 2024 22:44:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: linux-btrfs@vger.kernel.org, rajesh.sivaramasubramaniom@oracle.com,
	junxiao.bi@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, wqu@suse.com
Subject: Re: [PATCH v2] btrfs-progs: tests: add convert test case for block
 number overflow
Message-ID: <20240612204416.GR18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240611073443.1207998-1-srivathsa.d.dara@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611073443.1207998-1-srivathsa.d.dara@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6475D5C72A
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Jun 11, 2024 at 07:34:43AM +0000, Srivathsa Dara wrote:
> This test case will test whether btrfs-convert can handle ext4
> filesystems that are largerthan or equal to 16TiB.
> 
> At 16TiB block numbers overflow 32 bits, btrfs-convert either fails or
> corrupts fs if 64 bit block numbers are not supported.
> 
> Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>

Added to devel, thanks.

