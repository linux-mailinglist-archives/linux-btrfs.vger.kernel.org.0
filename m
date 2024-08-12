Return-Path: <linux-btrfs+bounces-7129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 699BC94EFB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 16:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3971F231CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 14:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E828A183092;
	Mon, 12 Aug 2024 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ySQlSLIi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yDDBZ2MR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ySQlSLIi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yDDBZ2MR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0AC17E44F;
	Mon, 12 Aug 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473421; cv=none; b=pif9vhwj6toUyqjpiIEzSH/zbXbjvTxOxKfcwozhvvyRdMu3tIOv6OU6//RmzNPau+umW19icgihshUJsjYK6P0I2YCBD1naIUu+SlBCPZ+lLOsjSys3O7+DMivnBPbFz6/cnR5B2IjxX5ld2/EjP5S2pbRs/l4fNlA4w9fbNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473421; c=relaxed/simple;
	bh=S8hCmQAO9OS5+WRquuV3ir9+fqiHJ+W9afXQlxVoQKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYGhyM7GDcSPGzr+Dpcvs3X083fvlq5HStloR21n60Fve4mNLr53ANrPVcFMnSzkig74DObvSrx6LSF4feo506g5Jm6Gws/yoBiV/D0axWuvQlDFh32Q5yTLVAA8MWskcVZlt1iCtUIRiE1KDScBpSjDqKcwXquC3K7CEwROgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ySQlSLIi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yDDBZ2MR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ySQlSLIi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yDDBZ2MR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB4AD20289;
	Mon, 12 Aug 2024 14:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723473417;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwyzWivMVi2/w3/8MOOzsxt/HDCoxgp/Z7fKLbMHTUE=;
	b=ySQlSLIi09Jb0XkwWqdzXrwd9qdZ8uR/vVWoj5m9AP4M9Tiw7teo4nOKBSPYoAw3IOTy0h
	G6MiqD6actA7zhu2xcDw1JUvyK4WWUq6XPqVr0mVqyoetJDL8khMAn9bk6W0JbyPfP4t+I
	ult1a+kgZMDGYp4kcCWnI0AqztJxHGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723473417;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwyzWivMVi2/w3/8MOOzsxt/HDCoxgp/Z7fKLbMHTUE=;
	b=yDDBZ2MRtiPSzgj1ssJ8YjLfmPDwGwf42o1Y52Nat6lPsDHxbI9wjnbLisa2CMLAUbkCWT
	xtHcytKF+OBoyjDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723473417;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwyzWivMVi2/w3/8MOOzsxt/HDCoxgp/Z7fKLbMHTUE=;
	b=ySQlSLIi09Jb0XkwWqdzXrwd9qdZ8uR/vVWoj5m9AP4M9Tiw7teo4nOKBSPYoAw3IOTy0h
	G6MiqD6actA7zhu2xcDw1JUvyK4WWUq6XPqVr0mVqyoetJDL8khMAn9bk6W0JbyPfP4t+I
	ult1a+kgZMDGYp4kcCWnI0AqztJxHGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723473417;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwyzWivMVi2/w3/8MOOzsxt/HDCoxgp/Z7fKLbMHTUE=;
	b=yDDBZ2MRtiPSzgj1ssJ8YjLfmPDwGwf42o1Y52Nat6lPsDHxbI9wjnbLisa2CMLAUbkCWT
	xtHcytKF+OBoyjDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 905F313A23;
	Mon, 12 Aug 2024 14:36:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id So0HIwkeumbdEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 Aug 2024 14:36:57 +0000
Date: Mon, 12 Aug 2024 16:36:56 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test send clones extents with unaligned end
 offset ending at i_size
Message-ID: <20240812143656.GJ25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <177f429d65afb5cc99a7f950779ba15b130cd581.1723470203.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177f429d65afb5cc99a7f950779ba15b130cd581.1723470203.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 12, 2024 at 02:51:09PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that a send operation will issue a clone operation for a shared
> extent of a file if the extent ends at the i_size of the file and the
> i_size is not sector size aligned.
> 
> This verifies an improvement to the btrfs send feature implemented by
> the following kernel patch:
> 
>   "btrfs: send: allow cloning non-aligned extent if it ends at i_size"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

