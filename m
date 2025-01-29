Return-Path: <linux-btrfs+bounces-11165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04621A2265F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 23:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D9247A10AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 22:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09221F78E4;
	Wed, 29 Jan 2025 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uXCLJCd2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ja2SkTb0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uXCLJCd2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ja2SkTb0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8844E1F7088;
	Wed, 29 Jan 2025 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738190580; cv=none; b=Av4k/nQo7ieO8kYZFxtXoTztTJ6SXFXnRPMQGS+m/+I+kufLJuUqeS88R8jFP8sr6s2bL2stpYSfLefS7tPCydgYB1J0OmJf1bagfnYqPdpQNFTJUalJjDk1BinlNtD6mbaR8G5k72bM3ezKgWvRKPteuLsMPl+d1ihN/Pw6D20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738190580; c=relaxed/simple;
	bh=9k7CpatZHQAtGF81mFp/ZuhDK/xk0udCWxYysKgOlZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+r0u6Llqu1uI8ICcKbwyoBIr5BZDA4MhW+9DZopSrDRrrEebZ9+J/AGygmqAEjEb8A0reo+cS0FH21DLzSbFxE9NsDQyGIkA9WU+zqWCl65TIwDnR04GieMyMGBSirrDnr6qYAwW6HgBk1+x09AVnAhCUoRFJhUm7mrP9Mt6Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uXCLJCd2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ja2SkTb0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uXCLJCd2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ja2SkTb0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6323E21102;
	Wed, 29 Jan 2025 22:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738190575;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BpouNam46v7SyDt/FAxA0nTyQYCCapr77+W+KP2OBu4=;
	b=uXCLJCd2lZ01i9zJbB1BmYpqx3oeCwW6DGyWYaMKvsSAMHUPnm3dr/4/UkbXzxAKq9zWPe
	fbsCOSZFUJKO/AtosvFkGsA32kQ0DrNOLuc6vHC1G3rQH6QhLCyUyiZZPk2MTZ3OTjnLVK
	kb3OxohAa3BsboaeKBxmp6b3Lv0Ou4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738190575;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BpouNam46v7SyDt/FAxA0nTyQYCCapr77+W+KP2OBu4=;
	b=ja2SkTb0c0QHxie+6O/GeHmgy0qytujCd5BOnvsfIkGaNa7maANdA0X+0RLHfEhM3BIp5/
	2+pUDu53PEjHj+CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738190575;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BpouNam46v7SyDt/FAxA0nTyQYCCapr77+W+KP2OBu4=;
	b=uXCLJCd2lZ01i9zJbB1BmYpqx3oeCwW6DGyWYaMKvsSAMHUPnm3dr/4/UkbXzxAKq9zWPe
	fbsCOSZFUJKO/AtosvFkGsA32kQ0DrNOLuc6vHC1G3rQH6QhLCyUyiZZPk2MTZ3OTjnLVK
	kb3OxohAa3BsboaeKBxmp6b3Lv0Ou4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738190575;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BpouNam46v7SyDt/FAxA0nTyQYCCapr77+W+KP2OBu4=;
	b=ja2SkTb0c0QHxie+6O/GeHmgy0qytujCd5BOnvsfIkGaNa7maANdA0X+0RLHfEhM3BIp5/
	2+pUDu53PEjHj+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35620132FD;
	Wed, 29 Jan 2025 22:42:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U8rGDO+ummcdFgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 29 Jan 2025 22:42:55 +0000
Date: Wed, 29 Jan 2025 23:42:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: dsterba@suse.cz, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs/zstd: enable negative compression levels mount
 option
Message-ID: <20250129224253.GF5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250124075558.530088-1-neelx@suse.com>
 <20250127180250.GQ5777@twin.jikos.cz>
 <CAPjX3FdaxfzULnRjN7TqyS9uK_ZJSk2PRzLgQCLVGBrR0yKLGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FdaxfzULnRjN7TqyS9uK_ZJSk2PRzLgQCLVGBrR0yKLGw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Jan 28, 2025 at 09:46:02AM +0100, Daniel Vacek wrote:
> > > ==============================================================+===============================================
> > > level -15     0m0,261s        0m0,329s        141M    100%  | 0m2,511s        0m2,794s        598M    40%  |
> > > level -14     0m0,145s        0m0,291s        141M    100%  | 0m1,829s        0m2,443s        581M    39%  |
> > > level -13     0m0,141s        0m0,289s        141M    100%  | 0m1,832s        0m2,347s        566M    38%  |
> > > level -12     0m0,140s        0m0,291s        141M    100%  | 0m1,879s        0m2,246s        548M    37%  |
> > > level -11     0m0,133s        0m0,271s        141M    100%  | 0m1,789s        0m2,257s        530M    35%  |
> >
> > I found an old mail asking ZSTD people which realtime levels are
> > meaningful, the -10 was mentioned as a good cut-off. The numbers above
> > confirm that although this is on a small sample.
> 
> The limit is really arbitrary. We may as well not even set one and
> leave it to the user. It's not like we allocate additional memory or
> any other resources.

Yes, it is arbitrary, the criteria is what are the practical benefits of
keeping the levels, what is the trade off compression/speed. It does not
matter much if the realtime level is ultra fast when it is not able to
reduce the size, given the constraints.

I agree that we should leave it up to user but I'd say it may be unclear
which level select. The level number is translated to some internal
compression logic so even very high numbers are allowed.

The testing file I've used is output of 'find -ls', so mostly textual
data, high level of redundancy.

Generated by a series of "zstd -b$i --fast=$i zstd-test"

-1#zstd-test         :   6126812 ->   1017901 (x6.019), 1055.7 MB/s, 2826.0 MB/s
-2#zstd-test         :   6126812 ->   1065645 (x5.749), 1143.0 MB/s, 3005.8 MB/s
-3#zstd-test         :   6126812 ->   1128314 (x5.430), 1204.2 MB/s, 3153.6 MB/s
-4#zstd-test         :   6126812 ->   1210669 (x5.061), 1220.5 MB/s, 3172.8 MB/s
-5#zstd-test         :   6126812 ->   1280004 (x4.787), 1242.7 MB/s, 3221.3 MB/s
-6#zstd-test         :   6126812 ->   1371974 (x4.466), 1259.8 MB/s  3277.1 MB/s
-7#zstd-test         :   6126812 ->   1440333 (x4.254), 1304.4 MB/s, 3293.0 MB/s
-8#zstd-test         :   6126812 ->   1496071 (x4.095), 1356.9 MB/s, 3391.2 MB/s
-9#zstd-test         :   6126812 ->   1566788 (x3.910), 1452.9 MB/s, 3613.6 MB/s
-10#std-test         :   6126812 ->   1613304 (x3.798), 1497.1 MB/s, 3738.7 MB/s

-11#std-test         :   6126812 ->   1685217 (x3.636), 1541.4 MB/s, 3829.2 MB/s
-12#std-test         :   6126812 ->   1766056 (x3.469), 1556.0 MB/s, 3875.6 MB/s
-13#std-test         :   6126812 ->   1826338 (x3.355), 1563.3 MB/s, 3886.6 MB/s
-14#std-test         :   6126812 ->   1899464 (x3.226), 1623.8 MB/s, 3963.5 MB/s
-15#std-test         :   6126812 ->   1989219 (x3.080), 1641.9 MB/s, 3901.3 MB/s
-16#std-test         :   6126812 ->   2057101 (x2.978), 1646.0 MB/s, 3781.2 MB/s
-17#std-test         :   6126812 ->   2101038 (x2.916), 1639.9 MB/s, 3809.8 MB/s
-18#std-test         :   6126812 ->   2151170 (x2.848), 1667.4 MB/s, 3887.3 MB/s
-19#std-test         :   6126812 ->   2185255 (x2.804), 1675.8 MB/s, 3932.5 MB/s
-20#std-test         :   6126812 ->   2228180 (x2.750), 1655.2 MB/s, 3983.3 MB/s

-21#std-test         :   6126812 ->   2275855 (x2.692), 1748.4 MB/s, 4188.4 MB/s
-22#std-test         :   6126812 ->   2324370 (x2.636), 1758.7 MB/s, 4245.0 MB/s
-23#std-test         :   6126812 ->   2373789 (x2.581), 1810.8 MB/s, 4345.4 MB/s
-24#std-test         :   6126812 ->   2423045 (x2.529), 1856.4 MB/s, 4326.7 MB/s
-25#std-test         :   6126812 ->   2470722 (x2.480), 1860.7 MB/s, 4425.6 MB/s
-26#std-test         :   6126812 ->   2519621 (x2.432), 1872.8 MB/s, 4447.8 MB/s
-27#std-test         :   6126812 ->   2571890 (x2.382), 1865.0 MB/s, 4432.7 MB/s
-28#std-test         :   6126812 ->   2630088 (x2.330), 1892.7 MB/s, 4480.3 MB/s
-29#std-test         :   6126812 ->   2678598 (x2.287), 1892.3 MB/s, 4458.1 MB/s
-30#std-test         :   6126812 ->   2730233 (x2.244), 1886.9 MB/s, 4415.0 MB/s

-100#td-test         :   6126812 ->   3878531 (x1.580), 2546.7 MB/s, 7076.8 MB/s
-101#td-test         :   6126812 ->   3873153 (x1.582), 2549.6 MB/s, 7053.4 MB/s
-102#td-test         :   6126812 ->   3878200 (x1.580), 2572.9 MB/s  7173.3 MB/s
-103#td-test         :   6126812 ->   3900441 (x1.571), 2581.2 MB/s  7164.9 MB/s
-104#td-test         :   6126812 ->   3902470 (x1.570), 2559.0 MB/s, 7133.3 MB/s
-105#td-test         :   6126812 ->   3912874 (x1.566), 2596.4 MB/s, 7150.9 MB/s
-106#td-test         :   6126812 ->   3917867 (x1.564), 2553.8 MB/s, 7260.1 MB/s
-107#td-test         :   6126812 ->   3930050 (x1.559), 2599.6 MB/s, 7284.5 MB/s
-108#td-test         :   6126812 ->   3946701 (x1.552), 2622.5 MB/s, 7288.1 MB/s
-109#td-test         :   6126812 ->   3954437 (x1.549), 2605.8 MB/s, 7334.4 MB/s
-110#td-test         :   6126812 ->   3955273 (x1.549), 2601.0 MB/s, 7389.1 MB/s

-1000#d-test         :   6126812 ->   5982024 (x1.024), 9253.0 MB/s, 22210.0 MB/s
-1001#d-test         :   6126812 ->   5986021 (x1.024), 9120.1 MB/s, 23034.3 MB/s
-1002#d-test         :   6126812 ->   5984005 (x1.024), 9086.7 MB/s, 22827.0 MB/s
-1003#d-test         :   6126812 ->   5978004 (x1.025), 9199.4 MB/s, 21718.3 MB/s
-1004#d-test         :   6126812 ->   5977133 (x1.025), 9120.3 MB/s, 21995.3 MB/s
-1005#d-test         :   6126812 ->   5979294 (x1.025), 9231.6 MB/s, 22204.5 MB/s
-1006#d-test         :   6126812 ->   5981595 (x1.024), 9175.6 MB/s, 21794.4 MB/s
-1007#d-test         :   6126812 ->   5989283 (x1.023), 9298.9 MB/s, 24239.1 MB/s
-1008#d-test         :   6126812 ->   5986954 (x1.023), 9242.1 MB/s, 23809.4 MB/s
-1009#d-test         :   6126812 ->   5988383 (x1.023), 9199.3 MB/s, 24322.1 MB/s
-1010#d-test         :   6126812 ->   5985304 (x1.024), 9221.2 MB/s, 23711.9 MB/s

Up to -15 it's 3x improvement which translates to about 33% of the
original size. And this is only for rough estimate, kernel compression
could be slightly worse due to slightly different parameters.

We can let it to -15, so it's same number as the upper limit.

