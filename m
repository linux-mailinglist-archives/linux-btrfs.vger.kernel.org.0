Return-Path: <linux-btrfs+bounces-3933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC4898F2C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 21:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011E21F258CC
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 19:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0466C1353E0;
	Thu,  4 Apr 2024 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QHYAQErq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ampcvn6r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QHYAQErq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ampcvn6r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA20134743;
	Thu,  4 Apr 2024 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259807; cv=none; b=PN0sg3Rs1QzyMaaO4e6ULmE3Dcwy5HTwpCoPZ+W2Vxn+TenC4nLvGmIJi2lYqRsZH22dox1KrCiAy5b+/kljVTg/qAEjVWxn/D+P1iMlpOYeL5Jh9R2cqerhjtIK4aNJ23mHi2Un5pPDHq6nZCpRZy5NNZ/use3DQwzkN/dHJ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259807; c=relaxed/simple;
	bh=ssFyVGe6la71DQpqy8kwW+lUpLEMRvFgNVGNpKsWvPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+8NmfdiXoutxKa3+rvpVZox+1VTsB3gl2izcYV1225AhMlhN4eRsHlrvP2cdrA3U2+QLegT+0dZQ/muy/jzY0uOuJAM0IjtHxBTTCFsAW8Qsq4XioWCmjBUjOiXYQUBV9x0K1JzSal98J4C2/V8RnWMNt7KoBT6ejT2Pi2X9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QHYAQErq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ampcvn6r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QHYAQErq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ampcvn6r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8063B1F444;
	Thu,  4 Apr 2024 19:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712259802;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gIJTzIQcbHebBkVn3DulvZH4vVRHwONfG5Hh7aP6lMU=;
	b=QHYAQErqSuSs0NOzd6WUQt/L3K8BPbjXUwGrtgV5aj02jddC3+MdaAlllIodH4PR4MLlz2
	6eEgQtqZofBccIawjK+EEtzdG1T/1ls+dglmaS1UJrS+qSQUOtneYzWRC4a0c7ABYGwzOO
	4O1Tuf2todQyr02ZURef/6q9qWlCOQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712259802;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gIJTzIQcbHebBkVn3DulvZH4vVRHwONfG5Hh7aP6lMU=;
	b=Ampcvn6rx+dhtUCHrq7ys/KECzq8yl4np4RgM1DZD7CinKw1X24tJwUge7MUx+908BGYCy
	CNoPd6VF3McUmhAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712259802;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gIJTzIQcbHebBkVn3DulvZH4vVRHwONfG5Hh7aP6lMU=;
	b=QHYAQErqSuSs0NOzd6WUQt/L3K8BPbjXUwGrtgV5aj02jddC3+MdaAlllIodH4PR4MLlz2
	6eEgQtqZofBccIawjK+EEtzdG1T/1ls+dglmaS1UJrS+qSQUOtneYzWRC4a0c7ABYGwzOO
	4O1Tuf2todQyr02ZURef/6q9qWlCOQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712259802;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gIJTzIQcbHebBkVn3DulvZH4vVRHwONfG5Hh7aP6lMU=;
	b=Ampcvn6rx+dhtUCHrq7ys/KECzq8yl4np4RgM1DZD7CinKw1X24tJwUge7MUx+908BGYCy
	CNoPd6VF3McUmhAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A8CE139E8;
	Thu,  4 Apr 2024 19:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id I3TdGdoCD2ZtaQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 04 Apr 2024 19:43:22 +0000
Date: Thu, 4 Apr 2024 21:35:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>, hch@lst.de,
	Damien LeMoal <dlemoal@kernel.org>, Boris Burkov <boris@bur.io>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH RFC PATCH 1/3] btrfs: zoned: traverse device list in
 should reclaim under rcu_read_lock
Message-ID: <20240404193556.GJ14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240328-hans-v1-0-4cd558959407@kernel.org>
 <20240328-hans-v1-1-4cd558959407@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-hans-v1-1-4cd558959407@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -1.02
X-Spam-Level: 
X-Spamd-Result: default: False [-1.02 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.02)[53.79%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]

Subject: btrfs: zoned: traverse device list in should reclaim under rcu_read_lock

Please use the function name in the subject instead of the description,
so like

btrfs: zoned: traverse device list under RCU lock in btrfs_zoned_should_reclaim()

On Thu, Mar 28, 2024 at 02:56:31PM +0100, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> As btrfs_zoned_should_reclaim() traverses the device list with the
> device_list_mutex held. But we're never changing the device list. All we
> do is gathering the used and total bytes.
> 
> So change the list traversal from the holding the device_list_mutex to
> rcu_read_lock(). This also opens up the possibilities to call
> btrfs_zoned_should_reclaim() with the chunk_mutex held.

You can add this patch independently, the device_list_mutex does not
seem to be needed for strong consistency of the values you read.

There are several other places where devices are under RCU only, like
btrfs_commit_device_sizes (though this is also in the transaction
context), various ioctls and btrfs_calc_avail_data_space().

