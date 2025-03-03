Return-Path: <linux-btrfs+bounces-11970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC2A4B9A5
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D861167A8C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AD01EE00D;
	Mon,  3 Mar 2025 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ae3YeI8t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fj5g/qws";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T8U52ims";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gnI571nu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8AA4A3C
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991432; cv=none; b=Zl2t2vYusSn/BHMna6vyy+i1QbOttMs3c2P33jHGIzCraR9POsdIjxGohqbfkhCMlHIT4k/NiCxaZDPGzJAKFgxNKOZ7Kbc44zZhvI8qV2oEaw+z547rAa5H5Y2T0rpWM1SPxjqNLwe7+DjBdhr6M9oubCCWqYG7zuHgEuALWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991432; c=relaxed/simple;
	bh=LBR4FeFjvdulbnfNzxNKxq5K54vD0QLmSHZEtm5QNCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO0wj/9P8CjScYI9Ha15a3yQA6TqjwzwtLKx3lVO4jT5h6ztHf0PvIR19zsqT99fo0yM4HrEey0O0buLvkS2hd9ys5ff8ak8eeOyuy42L6Xm1v0rXHOEmRlStOokMVuxOFVdZhtOVc38SmMc9druqMBSHRAzSluyGAshSyr64lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ae3YeI8t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fj5g/qws; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T8U52ims; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gnI571nu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9D1C1F399;
	Mon,  3 Mar 2025 08:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740991428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2lsVJsR5TIqVBzjSdAIpU/pCy0+qGhnqgHns8+2qv28=;
	b=ae3YeI8tNbAZ4Qsc4Qr1a8Lyf4UTfj4rhUAlKJe35ftG2vZpBNQUEQFJHki0dqfpfDWaet
	7Q+5r3axu8AKZxY5PO2aaVbbj310MXVldOKmgT47Xi73LOtiZDc/sBmn8NzozkKrUCcNk5
	QlU9vRdOYd7Y9L43lCO+AmJkMCTDWoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740991428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2lsVJsR5TIqVBzjSdAIpU/pCy0+qGhnqgHns8+2qv28=;
	b=fj5g/qws/5vbLlQu3bxYguNBRtMEgJxN7PDYZws5pwCzPRM/6MA983ZOk/qnvyh/TKWhNV
	FwEG3BpEgYQNE/AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740991426;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2lsVJsR5TIqVBzjSdAIpU/pCy0+qGhnqgHns8+2qv28=;
	b=T8U52imsP7heOUCkq/yAubX4tbgG9cjzBIHvXs1OSPVKkWeIqQCEV4XtFqJch+6yWu/5HF
	azM8Q5DTuMvXc1VV17TunE3t6bHjZURwczVJAnVFQv+N9qyFkLnMlCn1Ctaby1Ci3oEtBl
	F3/XOyxDBQSCzoRxF7toPPbT486MkoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740991426;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2lsVJsR5TIqVBzjSdAIpU/pCy0+qGhnqgHns8+2qv28=;
	b=gnI571nu87b9BrtK7zUeFG4q6O0wmEl75s/EGtye/0iRtDbfWTYmW+cSw2Z46YoNNgGh8p
	i6EXS0WgL5v3DxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9360C13939;
	Mon,  3 Mar 2025 08:43:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bGnFI8JrxWc3cgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 03 Mar 2025 08:43:46 +0000
Date: Mon, 3 Mar 2025 09:43:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs: add new ioctl CLEAR_FREE
Message-ID: <20250303084341.GR5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ecc43a72997ae7836c2d227b69924d364698e665.1740753608.git.dsterba@suse.com>
 <8510159.T7Z3S40VBb@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8510159.T7Z3S40VBb@saltykitkat>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, Mar 01, 2025 at 11:19:13AM +0800, Sun YangKai wrote:
> New to lkml, please correct me if I made any mistake :P
> 
> > +static int btrfs_ioctl_clear_free(struct file *file, void __user *arg)
> > +{
> > +	struct btrfs_fs_info *fs_info;
> > +	struct btrfs_ioctl_clear_free_args args;
> > +	u64 total_bytes;
> > +	int ret;
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +
> > +	if (copy_from_user(&args, arg, sizeof(args)))
> > +		return -EFAULT;
> > +
> > +	if (args.type >= BTRFS_NR_CLEAR_OP_TYPES)
> > +		return -EOPNOTSUPP;
> > +
> > +	ret = mnt_want_write_file(file);
> > +	if (ret)
> > +		return ret;
> > +
> > +	fs_info = inode_to_fs_info(file_inode(file));
> > +	total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
> > +	if (args.start > total_bytes) {
> > +		ret = -EINVAL;
> > +		goto out_drop_write;
> > +	}
> > +
> > +	ret = btrfs_clear_free_space(fs_info, &args);
> > +	if (ret < 0)
> > +		goto out_drop_write;
> > +
> > +	if (copy_to_user(arg, &args, sizeof(args)))
> > +		ret = -EFAULT;
> > +
> > +out_drop_write:
> > +	mnt_drop_write_file(file);
> > +
> > +	return 0;
> previous stored return value int `ret` is not used here.

Right, that's a mistake, it should have been. I'll fix it, thanks.

