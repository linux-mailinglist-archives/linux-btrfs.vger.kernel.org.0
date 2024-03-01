Return-Path: <linux-btrfs+bounces-2965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132CC86E178
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 14:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A521F22BAA
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 13:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3405E42AB5;
	Fri,  1 Mar 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GkDAYaGB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uO1kbmm7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GkDAYaGB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uO1kbmm7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2FB38FBE
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298218; cv=none; b=XzwElt5FwwZLEi7+OafOhv/GMwKsjpHFjnm096LuAK26bVg/8APUQiHJMleGaJ68uWBOFCx6oC13LUbpBNonp7iUaCVZyWGsEJiJuOB1CFjfXTODQcOQL7lBVkNQnPop6Ydk8r/hFIdRghjq4AOvUYBHLg4v3jDLR1ek/516bEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298218; c=relaxed/simple;
	bh=dNcuFzw4S+9iTdB1NzA98Jln9wJ0aYdhBR0VsyDde+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7KtTPmLunhoqQPDY84WyEHRqUxmgFsx3ETmG1z1K1q+g3Q385I8BbfRKCNVlzh08/5ElJaUTTFKAZ/6uI7VFMXcrcpqIf73kuHoP7/p7dsnF+Pb+lq876khDugS7DPQNrmL1lO4rsvVxPrauZvmEBQfI0zJAj8lohZcX1pUuGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GkDAYaGB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uO1kbmm7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GkDAYaGB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uO1kbmm7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1B94339A5;
	Fri,  1 Mar 2024 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709298214;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmdhMrrrxXVzz7lo9ZSGA/+Ix2ND79m7gQZNuYiZMsQ=;
	b=GkDAYaGB+Dd4a0rz950HqiVITCXqp6l6WSOBv6hSRb1jWE7LrxU90d36kceXO1IeX6YBF2
	uaZl67wXqIajigFXs1NSbCQVj69ANCsmH9TeIIuTO+mazyhQPi4qxKhKu/Tr7oWfJGdp+s
	Oyi54Rlji/1i+82JGLt1K84Bqh/EbKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709298214;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmdhMrrrxXVzz7lo9ZSGA/+Ix2ND79m7gQZNuYiZMsQ=;
	b=uO1kbmm7hkb/s0e6dXbaH/czcvrYewkyvv5J+RTXN73lZHWioa6joS6VxEhgJjhozKGLGQ
	uZJYxPHvbVa5mhCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709298214;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmdhMrrrxXVzz7lo9ZSGA/+Ix2ND79m7gQZNuYiZMsQ=;
	b=GkDAYaGB+Dd4a0rz950HqiVITCXqp6l6WSOBv6hSRb1jWE7LrxU90d36kceXO1IeX6YBF2
	uaZl67wXqIajigFXs1NSbCQVj69ANCsmH9TeIIuTO+mazyhQPi4qxKhKu/Tr7oWfJGdp+s
	Oyi54Rlji/1i+82JGLt1K84Bqh/EbKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709298214;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmdhMrrrxXVzz7lo9ZSGA/+Ix2ND79m7gQZNuYiZMsQ=;
	b=uO1kbmm7hkb/s0e6dXbaH/czcvrYewkyvv5J+RTXN73lZHWioa6joS6VxEhgJjhozKGLGQ
	uZJYxPHvbVa5mhCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9408313A39;
	Fri,  1 Mar 2024 13:03:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ptf1IybS4WUUTgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 01 Mar 2024 13:03:34 +0000
Date: Fri, 1 Mar 2024 13:56:31 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: subvolume: output the prompt line only when
 the ioctl succeeded
Message-ID: <20240301125631.GK2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.15
X-Spamd-Result: default: False [-3.15 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.15)[95.92%]
X-Spam-Flag: NO

On Tue, Feb 27, 2024 at 02:41:16PM +1030, Qu Wenruo wrote:
> [BUG]
> With the latest kernel patch to reject invalid qgroupids in
> btrfs_qgroup_inherit structure, "btrfs subvolume create" or "btrfs
> subvolume snapshot" can lead to the following output:
> 
>  # mkfs.btrfs -O quota -f $dev
>  # mount $dev $mnt
>  # btrfs subvolume create -i 2/0 $mnt/subv1
>  Create subvolume '/mnt/btrfs/subv1'
>  ERROR: cannot create subvolume: No such file or directory
> 
> The "btrfs subvolume" command output the first line, seemingly to
> indicate a successful subvolume creation, then followed by an error
> message.
> 
> This can be a little confusing on whether if the subvolume is created or
> not.
> 
> [FIX]
> Fix the output by only outputting the regular line if the ioctl
> succeeded.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

