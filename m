Return-Path: <linux-btrfs+bounces-228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85DE7F2D7F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046A41C217EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A7A1D687;
	Tue, 21 Nov 2023 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DlUghEDd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G++nxeT5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66338138
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 04:45:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17D6E1F8B8;
	Tue, 21 Nov 2023 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700570750;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iM6dl+v0TYLAuqASKyMnzmPhu26Rw2VzNMx/GhL/WnY=;
	b=DlUghEDdqEzijMS/InZJZyheEXA21bHg3qiKbze8Z2FLhlIzchmFphtGCi2oqJEXANZFSC
	IVinCm/NP+Ln+VfQETVMqLLkb3RWhip96AYZxOE6XNtK6jzIrhu1Sm6gLzNvu8NeT3l+5p
	ZvexDVSfeWLK6Ez2aUsrtf5HalJDyPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700570750;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iM6dl+v0TYLAuqASKyMnzmPhu26Rw2VzNMx/GhL/WnY=;
	b=G++nxeT50IijN2ncosT/gPMMKAHFrZxA9f0+cYb6iNlNx2hJbRdcPdoanleV7FDqZCUsM2
	5ro3ddhz1RvQAPAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8F4B139FD;
	Tue, 21 Nov 2023 12:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id lNe+N32mXGXUGQAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 21 Nov 2023 12:45:49 +0000
Date: Tue, 21 Nov 2023 13:38:40 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add dmesg output when mounting and unmounting
Message-ID: <20231121123840.GN11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
 <794136af-bb59-42f4-a5b2-8c760c4abd88@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794136af-bb59-42f4-a5b2-8c760c4abd88@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.98
X-Spamd-Result: default: False [-2.98 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.98)[94.91%]

On Tue, Nov 21, 2023 at 01:18:23PM +0800, Anand Jain wrote:
> Also, is it possible to CC the stable kernel? It's not a bug fix but a 
> debug essential patch.

Yes we can do that, it's a usability improvement.

