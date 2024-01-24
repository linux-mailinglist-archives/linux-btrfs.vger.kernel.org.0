Return-Path: <linux-btrfs+bounces-1681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA5C83AE75
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DD81F2669D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 16:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6667CF39;
	Wed, 24 Jan 2024 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bkcsIqJK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BiqD0VNA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bkcsIqJK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BiqD0VNA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5CC7CF16
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114235; cv=none; b=Z66YWtvFvlDZMYQt2xrnyIUYG1Xh0YULuAx6mvFrmUCLwrHbBoGTFe5JTo9/Di7q0LHLK7R5a491Bu8BYERvIIuBbS0WecNcuM58x4Qb2urHp2PYdrU/9leZJKSP0nSJvNO2oQvHJhiO7M7cqRhlCVS0V5OIu5vVBe5cN23BZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114235; c=relaxed/simple;
	bh=ST6dAkk8l1QO/OSWo94IDiei8x32WSPd80HU3ZhaJnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY6Yk0lIj2zp2o3OvWRLx8jSrHsZDgArcZgkDicfkMl4jksdqp1G3vnqQBGKuvt0I5YJDzOnDuWnzXUmvDHAQz++0P1EcrwUdQuc+ndmHPio1i8hO+sHo+t0rWgYs99nl5Ysw2cwP3NeKRkDlxBtdsOgWww7W9qPlHtQh58QChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bkcsIqJK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BiqD0VNA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bkcsIqJK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BiqD0VNA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5B3221F5A;
	Wed, 24 Jan 2024 16:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706114231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8r/xEcaAWQgeHCx8Ik+BQxagwl/J5PANnM2gRYnAVU=;
	b=bkcsIqJKIOdTwHdInaIQ69CFxCA1ja0njI6Lxqe/rASEsk3xI4od1sGVayZY6GInB3NNx5
	uUs5oFuJAgKQ4jdMzagAwm+Art0nuXn9HQhfC9qdkuSU7+3GDnTCxD5M8VREZQC4y/osDZ
	/PDQXaueTXhe8Okfk6c9uqCwR+ew3vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706114231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8r/xEcaAWQgeHCx8Ik+BQxagwl/J5PANnM2gRYnAVU=;
	b=BiqD0VNAFjEAabXfi38pTCEfWqdqYD7vWA5lrCI809JyFh/MGvppMyPDGryDjYJtdTgy55
	asRoQ0pn0hHvEaAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706114231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8r/xEcaAWQgeHCx8Ik+BQxagwl/J5PANnM2gRYnAVU=;
	b=bkcsIqJKIOdTwHdInaIQ69CFxCA1ja0njI6Lxqe/rASEsk3xI4od1sGVayZY6GInB3NNx5
	uUs5oFuJAgKQ4jdMzagAwm+Art0nuXn9HQhfC9qdkuSU7+3GDnTCxD5M8VREZQC4y/osDZ
	/PDQXaueTXhe8Okfk6c9uqCwR+ew3vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706114231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8r/xEcaAWQgeHCx8Ik+BQxagwl/J5PANnM2gRYnAVU=;
	b=BiqD0VNAFjEAabXfi38pTCEfWqdqYD7vWA5lrCI809JyFh/MGvppMyPDGryDjYJtdTgy55
	asRoQ0pn0hHvEaAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5E8B1333E;
	Wed, 24 Jan 2024 16:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zoY5LLc8sWXLJgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 24 Jan 2024 16:37:11 +0000
Date: Wed, 24 Jan 2024 17:36:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Neal Gompa <neal@gompa.dev>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: forbid creating subvol qgroups
Message-ID: <20240124163649.GL31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705711967.git.boris@bur.io>
 <eb79dcbe0cbfa7459b249f76818a5e5a08a42ea4.1705711967.git.boris@bur.io>
 <CAEg-Je_6RNUoFg-+btbBtrCZRE1uZ77g_1mdbCqtyGiSZ0vhMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je_6RNUoFg-+btbBtrCZRE1uZ77g_1mdbCqtyGiSZ0vhMw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.18 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[52.56%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.18

On Wed, Jan 24, 2024 at 07:52:28AM -0500, Neal Gompa wrote:
> On Fri, Jan 19, 2024 at 7:55 PM Boris Burkov <boris@bur.io> wrote:
> >
> > This leads to various races and it isn't helpful, because you can't
> > specify a subvol id when creating a subvol, so you can't be sure it
> > will be the right one. Any requirements on the automatic subvol can
> > be gratified by using a higher level qgroup and the inheritance
> > parameters of subvol creation.
> 
> Hold up, does this mean that qgroups can't be used *at all* on Fedora,
> where we use subvolumes for both the root and user home directory
> hierarchies?

How do you imply that from the patch? This is about preventing creating
the subvolume qgroups, i.e. with the level 0 and referred to as 0/1234
where 1234 is a subvolume id. Such qgroups are supposed to be created
only at the time the subvolume is created.

