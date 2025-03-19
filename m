Return-Path: <linux-btrfs+bounces-12434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC9EA69BA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 22:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CABA19C154F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 21:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A12215171;
	Wed, 19 Mar 2025 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KMATEVyn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lxf7IMwb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="20ha8KDl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ES9FaSq3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC3D1CAA81
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421370; cv=none; b=Prb6QRxwbseglPeO0V9TNHWasIDN3/rig21nkYIFKoCbUrlKYS2z7zraN2rZJzifLLBDKvOGYTrA6dWAa5dpOTSXnfjeSgbo3VTffVWXg0RNtdZDdLGA3ZFs6fydN/3z+HksQv3Lgepb4hYkJhQSl0m7K2mcUdF3IcWKMMNz0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421370; c=relaxed/simple;
	bh=5WFBe0cxggvNhG1Z46a0U/WA/UW9yNIg0Q6qNGvfktY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jo3SyQFtxPoVnvdHU6IA3a2BA7HO/vA5BsGru4C1BQqVgWg0KxkQTGYVV1MeAfRVy9mA0ANaIwvN0adQB5Cii3ogCHhlv1sH7z/RiEGbcM55S9wyTVTxSOPfeIzoJuax+M//78p0ISBMTu2pyy1YB+4aYe0cLeN5kJgY7whV6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KMATEVyn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lxf7IMwb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=20ha8KDl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ES9FaSq3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE4731FD01;
	Wed, 19 Mar 2025 21:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742421367;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JuW16hmnwLbIn7eZeGRV3NP88WiWjYeZzulDnRkLqNw=;
	b=KMATEVynqm4ggp/ha0A/zIFuf8AdTiBPhOkR/qEFTxAx8TRg05ojp/S7pq9VjsMQSCMFWF
	hDrLgl6QRvBmt3qaYpDUfrdbf/f3hxZPOEuDkNp/tA9+s3GueeTefqNXWhlMYIOvPUYl9k
	OzXXWl3LtzF+CPUNlaOIlwM+MXLjFP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742421367;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JuW16hmnwLbIn7eZeGRV3NP88WiWjYeZzulDnRkLqNw=;
	b=lxf7IMwbQZZhsADfLcwgr+ge/TcudTUxyz+rBwfj10clWNPWHlDg1vK7tdXme+4qWam/+l
	UeYxQOeyRzES8PBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742421366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JuW16hmnwLbIn7eZeGRV3NP88WiWjYeZzulDnRkLqNw=;
	b=20ha8KDlIxvi0N6CmRpnxfFtbAfW1LjCW+9MNQBPstqk3r2elfkcUOaAHqjSmQNFl3mZ/X
	vKwpwRp/KS04JqYBuKz3meZrskTsi+Xxf3UmLAIluMwQIkbCInvgM/HGu5wAMi5K5KIdsM
	1Tc9hRhFVKT/EDUftNU0efbji5sATos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742421366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JuW16hmnwLbIn7eZeGRV3NP88WiWjYeZzulDnRkLqNw=;
	b=ES9FaSq3iEtk7bhZwOeqGRKtsmilqbhGeD6J7gduS+EvEYLeRrcN4QYTyzqucPRNZuW/i2
	DuDiKOuY/Gh+tgBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D44E913726;
	Wed, 19 Mar 2025 21:56:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zYOXM3Y922flPAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Mar 2025 21:56:06 +0000
Date: Wed, 19 Mar 2025 22:56:01 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: cmds/qgroup: use sysfs to detect
 inconsistent status early
Message-ID: <20250319215601.GN32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7171b8a518e70a5b2e8e791dd078d7cc4f643b83.1739420945.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7171b8a518e70a5b2e8e791dd078d7cc4f643b83.1739420945.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Feb 13, 2025 at 02:59:17PM +1030, Qu Wenruo wrote:
> Currently if "btrfs qgroup show" detects the qgroup is in an inconsistent,
> it will output a warning:
> 
>   WARNING: qgroup data inconsistent, rescan recommended
> 
> But the detection is based on the tree search ioctl, and qgroup tree is
> only updated at transaction commit time.
> 
> This means if qgroup is marked inconsistent, and the transaction is not
> commit, there can be a huge window as long as 30s before "btrfs qgroup
> show" to give a proper warning about inconsistent qgroup numbers.
> 
> To address this window, use the
> '/sys/fs/btrfs/<fsid>/qgroup/inconsistent' file to do extra check.
> 
> That file is updated at real time, thus there is no delay, and can give
> an early warning about inconsistent qgroup numbers.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1235765
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

