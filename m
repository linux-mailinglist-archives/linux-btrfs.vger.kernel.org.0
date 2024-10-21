Return-Path: <linux-btrfs+bounces-9034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1788E9A728E
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 20:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375621C213CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 18:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C331FAC39;
	Mon, 21 Oct 2024 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZzgEH10h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TgTLCFzt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZzgEH10h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TgTLCFzt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836B78C76
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536183; cv=none; b=OFErNz7ETQ4CaR2ajKUHiZo11zoOckkbk7Y2MF9y/C1HBuiuV9Jcvb7a3ggVtx4B2+7uoekCaK+4u6te5SNvuN4LcaUvGPEA7FUFGkfOqQsw4NodTv+VeGrcE03Da2IeVVGPwzN26dxRLfDGwx/XtyTldccz2Sug+IJCK0c0ILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536183; c=relaxed/simple;
	bh=wkA6hBZqXi5vganp408CEgwMpxQyyCNkoxQmtZDw6jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5sV8L4GOO2nTkaWm2ilEoqjpbS8wgCN+iU5O4tQomanyLfsuhPT80WwZRiB+ib8/f0VJQ9rb1rMfPrinpiXCVHi9VFBcpRuicH17FiVTIL9r8jI4GK0R0R8zoFsEnr5FEKJCchloqFyxHlnWWk/b5U2SoUD7LUrWAoeTzCoukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZzgEH10h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TgTLCFzt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZzgEH10h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TgTLCFzt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08E3321C22;
	Mon, 21 Oct 2024 18:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729536179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+ntZO3PFbKFJlpSOHDTHDftnQbVH6sa+tnFkQBqSKU=;
	b=ZzgEH10hmDxq/QfG22Cj0KrLMFGFOdgt6Sb/YCMMRVV7uKYmToBXjZhPHd5kpwc71oVdko
	NaTlDu4ouWh7BY62fe64PGNXjmS2Uo/Q4HacrwI3bo8g4aSVQ+D7w4hcU5wLNnSzGHqgax
	dBjuqGKE6nTfy461yoP+Rwltd0sfnLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729536179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+ntZO3PFbKFJlpSOHDTHDftnQbVH6sa+tnFkQBqSKU=;
	b=TgTLCFzt/0iMSIv/aOJIbXjv1gXwOuX+GwdZfDOINdjU/tYu4/hnbXPQk8u4+jT4W6libN
	1/sKIA17h5U4SlCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729536179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+ntZO3PFbKFJlpSOHDTHDftnQbVH6sa+tnFkQBqSKU=;
	b=ZzgEH10hmDxq/QfG22Cj0KrLMFGFOdgt6Sb/YCMMRVV7uKYmToBXjZhPHd5kpwc71oVdko
	NaTlDu4ouWh7BY62fe64PGNXjmS2Uo/Q4HacrwI3bo8g4aSVQ+D7w4hcU5wLNnSzGHqgax
	dBjuqGKE6nTfy461yoP+Rwltd0sfnLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729536179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+ntZO3PFbKFJlpSOHDTHDftnQbVH6sa+tnFkQBqSKU=;
	b=TgTLCFzt/0iMSIv/aOJIbXjv1gXwOuX+GwdZfDOINdjU/tYu4/hnbXPQk8u4+jT4W6libN
	1/sKIA17h5U4SlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC6A2136DC;
	Mon, 21 Oct 2024 18:42:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V1ySNbKgFmdJJQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 21 Oct 2024 18:42:58 +0000
Date: Mon, 21 Oct 2024 20:42:53 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com,
	hrx@bupt.moe, waxhead@dirtcellar.net
Subject: Re: [PATCH v2 0/3] raid1 balancing methods
Message-ID: <20241021184253.GB24631@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1728608421.git.anand.jain@oracle.com>
 <20241021140518.GD17835@twin.jikos.cz>
 <788e9d8f-df2e-4d54-b60c-dddbc47fd701@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <788e9d8f-df2e-4d54-b60c-dddbc47fd701@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Oct 21, 2024 at 11:36:10PM +0800, Anand Jain wrote:
> > I think it's safe to start with the round-round robin policy, but the
> > syntax is strange, why the [ ] are mandatory? Also please call it
> > round-robin, or 'rr' for short.
> 
> I'm fine with round-robin. The [ ] part is not mandatory; if the
> min_contiguous_read value is not specified, it will default to a
> predefined value.
> 
> > The default of sector size is IMHO a wrong value, switching devices so
> > often will drop the performance just because of the io request overhead.
> 
> >  From what I rememer values around 200k were reasonable, so either 192k
> > or 256k should be the default. We may also drop the configurable value
> > at all and provide a few hard coded sizes like rr-256k, rr-512k, rr-1m,
> > if not only to drop parsing of user strings.
> 
> I'm okay with a default value of 256k. For the experimental feature,
> we can keep it configurable, allowing the opportunity to experiment
> with other values as well

Yeah, for experimenting it makes sense to make it flexible, no need to
patch and reboot the kernel. For final we should settle on some
reasonable values.

> >> 5. Tested FIO random read/write and defrag compression workloads with
> >>     min_contiguous_read set to sector size, 192k, and 256k.
> >>
> >>     RAID1 balancing method rotation is better for multi-process workloads
> >>     such as fio and also single-process workload such as defragmentation.
> >>
> >>       $ fio --filename=/btrfs/foo --size=5Gi --direct=1 --rw=randrw --bs=4k \
> >>          --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 \
> >>          --time_based --group_reporting --name=iops-test-job --eta-newline=1
> >>
> >>
> >> |         |            |            | Read I/O count  |
> >> |         | Read       | Write      | devid1 | devid2 |
> >> |---------|------------|------------|--------|--------|
> >> | pid     | 20.3MiB/s  | 20.5MiB/s  | 313895 | 313895 |
> >> | rotation|            |            |        |        |
> >> |     4096| 20.4MiB/s  | 20.5MiB/s  | 313895 | 313895 |
> >> |   196608| 20.2MiB/s  | 20.2MiB/s  | 310152 | 310175 |
> >> |   262144| 20.3MiB/s  | 20.4MiB/s  | 312180 | 312191 |
> >> |  latency| 18.4MiB/s  | 18.4MiB/s  | 272980 | 291683 |
> >> | devid:1 | 14.8MiB/s  | 14.9MiB/s  | 456376 | 0      |
> >>
> >>     rotation RAID1 balancing technique performs more than 2x better for
> >>     single-process defrag.
> >>
> >>        $ time -p btrfs filesystem defrag -r -f -c /btrfs
> >>
> >>
> >> |         | Time  | Read I/O Count  |
> >> |         | Real  | devid1 | devid2 |
> >> |---------|-------|--------|--------|
> >> | pid     | 18.00s| 3800   | 0      |
> >> | rotation|       |        |        |
> >> |     4096|  8.95s| 1900   | 1901   |
> >> |   196608|  8.50s| 1881   | 1919   |
> >> |   262144|  8.80s| 1881   | 1919   |
> >> | latency | 17.18s| 3800   | 0      |
> >> | devid:2 | 17.48s| 0      | 3800   |
> >>
> >> Rotation keeps all devices active, and for now, the Rotation RAID1
> >> balancing method is preferable as default. More workload testing is
> >> needed while the code is EXPERIMENTAL.
> > 
> > Yeah round-robin will be a good defalt, we only need to verify the chunk
> > size and then do the switch in the next release.
> > 
> 
> Yes..
> 
> >> While Latency is better during the failing/unstable block layer transport.
> >> As of now these two techniques, are needed to be further independently
> >> tested with different worloads, and in the long term we should be merge
> >> these technique to a unified heuristic.
> > 
> > This sounds like he latency is good for a specific case and maybe a
> > fallback if the device becomes faulty, but once the layer below becomes
> > unstable we may need to skip reading from the device. This is also a
> > different mode of operation than balancing reads.
> > 
> 
> If the latency on the faulty path is so high that it shouldn't pick that
> path at all, so it works. However, the round-robin balancing is unaware
> of dynamic faults on the device path. IMO, a round-robin method that is
> latency aware (with ~20% variance) would be better.

We should not mix the faulty device handling mode to the read balancing,
at least for now. A back off algorithm that checks number of failed io
requests should precede the balancing.

> >> Rotation keeps all devices active, and for now, the Rotation RAID1
> >> balancing method should be the default. More workload testing is needed
> >> while the code is EXPERIMENTAL.
> >>
> >> Latency is smarter with unstable block layer transport.
> >>
> >> Both techniques need independent testing across workloads, with the goal of
> >> eventually merging them into a unified approach? for the long term.
> >>
> >> Devid is a hands-on approach, provides manual or user-space script control.
> >>
> >> These RAID1 balancing methods are tunable via the sysfs knob.
> >> The mount -o option and btrfs properties are under consideration.
> > 
> > To move forward with the feature I think the round robin and preferred
> > device id can be merged. I'm not sure about the latency but if it's
> > under experimental we can take it as is and tune later.
> 
> I hope the experimental feature also means we can change the name of the
> balancing method at any time. Once we have tested a fair combination of
> block device types, we'll definitely need a method that can
> automatically tune based on the device type, which will require adding
> or dropping balancing methods accordingly.

Yes we can change the names. The automatic tuning would need some
feedback that measures the load and tries to improve the throughput,
this is where we got stuck last time. So for now let's do some
starightforward policy that on average works better than the current pid
policy. I hope that tha round-robin-256k can be a good default, but of
course we need more data for that.

