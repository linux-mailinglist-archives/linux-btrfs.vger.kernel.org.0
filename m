Return-Path: <linux-btrfs+bounces-8938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169EB99F2DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 18:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA43C282873
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0841F76AF;
	Tue, 15 Oct 2024 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k0fop7F1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ygGbMIW2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k0fop7F1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ygGbMIW2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BF1B3931;
	Tue, 15 Oct 2024 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010314; cv=none; b=RCiGkBu1fEQQvhz8RNiBC99fp3gTuUC8m0S1l82X5KJ5YcfYLoE18uhDR7WZ4nwzl9rdn8k93f8n9F/xs3zUMpXZhzwzVMpRKNUcvHeIvlPiKI3ILezbJ02Ip1WSn+Cux0xmPgPegVmBb1FoiEtZ9jjt3U2XTaY2cqfPS31f+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010314; c=relaxed/simple;
	bh=omlxbmmtioNhdQ3VwlSpAcKaeEqxLCQPnPaHV9+mNFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AC28svJ/WD2E9jwN/SFcY5rCmf9tHzSzFe/I8IfdK6Tch6x8hmBH1ViFmKjTpEEui4mNteBnZEe+wG2ramjpNEUr0bF8y30y56TJVifVFlAwT7Kg8O2EpH/Byam5ysUK9mR0fnNDLV4eamQqu6Kg2RAW1Jd0KbBssYaPihaGDc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k0fop7F1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ygGbMIW2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k0fop7F1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ygGbMIW2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B5091FB68;
	Tue, 15 Oct 2024 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729010310;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIapUbLotbk7oUHP/sPsaiUYDVgCyzXY2OqcXT9c0Ck=;
	b=k0fop7F1cvyV3VUD2Ud6corCVQWyzQVFz0tIfqzUlrmmjceNquj6Mty9bhLyWMyYaatBFO
	e5f4bQEB9fi8F1pgpJgk20jeth38NeXc5ZmheEJuYRJwFnr7PNMey2HQGYZr3UUstME592
	munJrVSLJieMa559Zqzn/2w3Pxmfrtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729010310;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIapUbLotbk7oUHP/sPsaiUYDVgCyzXY2OqcXT9c0Ck=;
	b=ygGbMIW2FYDckXSLS9pjjCjUXNBs2gonHAM40+kO+QZwhYM4lLy4g4gUFMlNp5n5ye0nZO
	OfsKo8ViCMHrFvCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=k0fop7F1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ygGbMIW2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729010310;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIapUbLotbk7oUHP/sPsaiUYDVgCyzXY2OqcXT9c0Ck=;
	b=k0fop7F1cvyV3VUD2Ud6corCVQWyzQVFz0tIfqzUlrmmjceNquj6Mty9bhLyWMyYaatBFO
	e5f4bQEB9fi8F1pgpJgk20jeth38NeXc5ZmheEJuYRJwFnr7PNMey2HQGYZr3UUstME592
	munJrVSLJieMa559Zqzn/2w3Pxmfrtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729010310;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIapUbLotbk7oUHP/sPsaiUYDVgCyzXY2OqcXT9c0Ck=;
	b=ygGbMIW2FYDckXSLS9pjjCjUXNBs2gonHAM40+kO+QZwhYM4lLy4g4gUFMlNp5n5ye0nZO
	OfsKo8ViCMHrFvCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2798213A53;
	Tue, 15 Oct 2024 16:38:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 83gnCYaaDmdGLgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 15 Oct 2024 16:38:30 +0000
Date: Tue, 15 Oct 2024 18:38:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com, clm@fb.com,
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH next] btrfs: Accessing head_ref within delayed_refs lock
Message-ID: <20241015163828.GK1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <670d3f2c.050a0220.3e960.0066.GAE@google.com>
 <tencent_0EBF9E731B704B091B022578BA9EBB8E3308@qq.com>
 <CAL3q7H7D=uNsvgKwBcK+jtNXayDYPLO=ZowWyjjaeYK27ZgirQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7D=uNsvgKwBcK+jtNXayDYPLO=ZowWyjjaeYK27ZgirQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4B5091FB68
X-Spam-Score: -2.71
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[qq.com,syzkaller.appspotmail.com,fb.com,suse.com,toxicpanda.com,vger.kernel.org,googlegroups.com];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[c3a3a153f0190dca5be9];
	RCPT_COUNT_SEVEN(0.00)[9];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[qq.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Oct 15, 2024 at 01:49:04PM +0100, Filipe Manana wrote:
> On Tue, Oct 15, 2024 at 1:40 PM Edward Adam Davis <eadavis@qq.com> wrote:
> >
> > This is because the thread routine btrfs_work_helper released head_def after
> > exiting delayed_refs->lock in add_delayed_ref.
> 
> This should be explained a lot better. Starting the changelog with
> "This is because..." is odd. It should explain why the head reference
> was freed (because delayed references were run).
> 
> > Causing add_delayed_ref to encounter uaf when accessing head_def->bytenr
> > outside the delayed_refs->lock.
> >
> > Move head_ref->bytenr into the protection range of delayed_refs->lock
> > to avoid uaf in add_delayed_ref.
> 
> 
> This was already fixed yesterday, in a simpler way and with an
> explanation of what's going on to trigger the use-after-free:
> 
> https://lore.kernel.org/linux-btrfs/02fc507b62b19be2348fc08de8b13bd7af1a440e.1728922973.git.fdmanana@suse.com/

This will be in the upcoming linux-next, so we'll not get the syzbot and
build reports anymore.

