Return-Path: <linux-btrfs+bounces-279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA61F7F47D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 14:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20341C209C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511865578E;
	Wed, 22 Nov 2023 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JsDGxhkv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6eJyKzo1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAAC19E
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 05:31:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF7061F8D6;
	Wed, 22 Nov 2023 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700659858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ud3YLbp9udgt/FINuB9cyyYRc5nKQ8PMdQkWs2CA9n4=;
	b=JsDGxhkv1drhK6i5t4GIemxip7FfHWc55QEQtSMYEfbJT8wXi2aBhKREbDkvlCwWXj+fHw
	QjTs/kqTc7crfKsyY7ABI7o4LHe8GexSGVt8kBiUVBfolpY5FD5UOMFaXLSf3F88+4wYWv
	xurJ2/vs1yEbmYENh8+h8nJzMaTbW/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700659858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ud3YLbp9udgt/FINuB9cyyYRc5nKQ8PMdQkWs2CA9n4=;
	b=6eJyKzo1g6sxXeF2h6C5eA9jTDvDZFVblFYZlkrPH/24RDp5/ePVw69VM1NQlbGLKNOuzS
	jmMh0dXphQ6RcnBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9788313467;
	Wed, 22 Nov 2023 13:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Xl1DJJICXmUTbAAAMHmgww
	(envelope-from <dsterba@suse.cz>); Wed, 22 Nov 2023 13:30:58 +0000
Date: Wed, 22 Nov 2023 14:23:48 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: allow extent buffer helpers to skip
 cross-page handling
Message-ID: <20231122132348.GZ11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
 <20231120170015.GM11264@twin.jikos.cz>
 <a73faeae-1925-4894-9512-7a049ff8353b@gmx.com>
 <20231121153529.GS11264@twin.jikos.cz>
 <1b63c587-c2c5-44d5-bbc3-5facc34f5361@gmx.com>
 <20231121211437.GX11264@twin.jikos.cz>
 <513bbc52-8f0b-4105-a079-a81f9b67fc55@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <513bbc52-8f0b-4105-a079-a81f9b67fc55@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.07
X-Spamd-Result: default: False [-3.07 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.07)[95.45%]

On Wed, Nov 22, 2023 at 08:00:53AM +1030, Qu Wenruo wrote:
> On 2023/11/22 07:44, David Sterba wrote:
> > On Wed, Nov 22, 2023 at 07:07:10AM +1030, Qu Wenruo wrote:
> >
> > So do you want this patch (adding the contig detection and eb::addr)
> > applied?
> 
> I still want this patch to get merged, as it's really the first step for
> the incoming higher order folio conversion.

Yeah, I understand the conversion will be incremental so no problem
adding the steps there.

