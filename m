Return-Path: <linux-btrfs+bounces-19756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBC3CBF7A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 20:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D38A1300DC80
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ED6242D8E;
	Mon, 15 Dec 2025 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eezeGVID";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1sRT1+ge";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Zm7KfiF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gF98kaaa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0472B12DDA1
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825291; cv=none; b=ZtZE5Gba/w5Gso0pFOrYHjIJMi0kwIq06WbZmZFsnE8xlSPZ6KTjSOL1lK1MdJ4G9pCjBpgyy1WxUEcz8aRZ91unezTpvr7Iv5zT8shTof98oDYOQqBYXUdOOcx+x4GmHy87Zb13Gcyvzs1QwEmBHHSwJN3Tpm9Amh4/Xi4dcTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825291; c=relaxed/simple;
	bh=Ehmio5gH07tmjOTRgbO1CRCuZ2CZrIg/xDgoYI/hpIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uykB2PgKiSuKbEd8X5zkaSL8oTaLPG1ndRMGQXBhYEVwytl42m37ArHl4M59KfI3ctHArNAsnO/z9KhyrWwh/ZRA1WQV6TYpDbL83yhgCcQXK0bFJhcRLKPkKnRcyk2aw4vWM/4BsYXQibr8yfQbWXu3S271V+JKpIK3spc8RHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eezeGVID; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1sRT1+ge; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Zm7KfiF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gF98kaaa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F34A336F9;
	Mon, 15 Dec 2025 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765825286;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWD4biMDJf4ohuee2mYiRR95FEBGCVC9rhB3pV46MKs=;
	b=eezeGVIDW+7iWiKBz6q+3WQrjzK4YxrbmHkv8D/St8M8ajqCRKEJ6P4AJhwRKxhFotqd2l
	VFQjMZYaqnTomTDU1fnohSBQ05Hz0rbyOCToVBwt8dnxNKq07JI3/9OPh/d6WR0VY8GVcJ
	DP1iYx+IP13GXeghwbwJB82uiqM3aWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765825286;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWD4biMDJf4ohuee2mYiRR95FEBGCVC9rhB3pV46MKs=;
	b=1sRT1+ge+KYgJlKj9fROgTsTrtOW1zcXML8ou6ctaaCoW75LQwgofUQEl2CojmXnhJm2YD
	RReix7MPgZ9i6eAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1Zm7KfiF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gF98kaaa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765825285;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWD4biMDJf4ohuee2mYiRR95FEBGCVC9rhB3pV46MKs=;
	b=1Zm7KfiFH4vF6XxtQMwa3q1FKRgUoRJUrbhj76D6ob/PR9Z5syzQXfyEXSWQwZWmXhloQR
	ZrkKUbQl/Nfng/WShqetlmRsliQwHNFbkCZzNSKfn+qmImTzO8XysVg4Axee2oFOmiafIS
	ckjgyfRoUO19ZiMW+o3yXkIhiFoYEx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765825285;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWD4biMDJf4ohuee2mYiRR95FEBGCVC9rhB3pV46MKs=;
	b=gF98kaaaqACVpjb7Vtf0n45Wf+H9UTlieHIFAAREYExoSZblZdEQ2wf1P6eXHnJIQv7r9L
	VK1zgJYhUsn0H9BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F33713EA63;
	Mon, 15 Dec 2025 19:01:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2oc2OwRbQGlqFQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 15 Dec 2025 19:01:24 +0000
Date: Mon, 15 Dec 2025 20:01:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v4 1/3] btrfs: zoned: move zoned stats to mountstats
Message-ID: <20251215190108.GF3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251215162420.238275-1-johannes.thumshirn@wdc.com>
 <20251215162420.238275-2-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215162420.238275-2-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,wdc.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 1F34A336F9
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Mon, Dec 15, 2025 at 05:24:18PM +0100, Johannes Thumshirn wrote:
> Move zoned statistics to /proc/<pid>/mountstats just like it is for XFS,
> because sysfs is limited to a single page, which causes the output to be
> truncated.

As we've discussed on slack, mountstats is probably a good place for
that although it's yet another place for fs related information. The
format of the file is not that convenient as it lists all filesystems
and the command 'mountstats' does not want to print anything bug NFS.

Alternatively we add an ioctl for that but this is still not convenient
for scripting and splitting the information to multiple files in sysfs
makes reading the stats at one time also less appealing.

> 
> The output for /proc/<pid>/mountstats on an example filesystem will be as
> follows:
> 
>   device /dev/vda mounted on /mnt with fstype btrfs

Maybe add section label abore the zoned-related stats, we may want to add
more filesystem stats in the future so it would help parsing.

>           active block-groups: 7
>             reclaimable: 0
>             unused: 5
>             need reclaim: false
>           data relocation block-group: 1342177280
>           active zones:
>             start: 1073741824, wp: 268419072 used: 0, reserved: 268419072, unusable: 0
>             start: 1342177280, wp: 0 used: 0, reserved: 0, unusable: 0
>             start: 1610612736, wp: 49152 used: 16384, reserved: 16384, unusable: 16384
>             start: 1879048192, wp: 950272 used: 131072, reserved: 622592, unusable: 196608
>             start: 2147483648, wp: 212238336 used: 0, reserved: 212238336, unusable: 0
>             start: 2415919104, wp: 0 used: 0, reserved: 0, unusable: 0
>             start: 2684354560, wp: 0 used: 0, reserved: 0, unusable: 0
> 
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

>  static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
>  				struct kobj_attribute *a, char *buf)
>  {
> @@ -1649,7 +1598,6 @@ static const struct attribute *btrfs_attrs[] = {
>  	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
>  	BTRFS_ATTR_PTR(, commit_stats),
>  	BTRFS_ATTR_PTR(, temp_fsid),
> -	BTRFS_ATTR_PTR(, zoned_stats),

The file is only present in 6.19 so we'll need to remove it separately
before release, the rest of the zoned stats is development so it's for
6.20.

