Return-Path: <linux-btrfs+bounces-14635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FA4AD82D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 07:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6C9169EF2
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 05:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FCA2561B9;
	Fri, 13 Jun 2025 05:59:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3824DCE8
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749794367; cv=none; b=N36Uh5zKKjIao/wqGqTBoZx7CCBwg2V9Ic5mA37X7oFKYQUasd0s9qIBfmIecyqWzMt6gAu83DeoMxv+uz+RsXwoHRbB0kH7gisOdaSnh7cAMqu2YP/easuoqQfvC1UeQhU2xRkQlBRWa8E9LVUPFJPx6u1THEn9i2AMxO6z86U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749794367; c=relaxed/simple;
	bh=F+04syWIBXejxze+yeh1OWgUtuMFJPkBU3M42Uxaakk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnrxDJDcVq47PmnzWxn/iTEUuhKoDT56mq5MoClRalYPWUPmt4acuAGowRWWkQT9tRwYNoLzNsBnLdiCJj8V1B8C66D879KbieWk3lJ4yB7/TsjnjM3elV+FRgSVlaU8sw77nQzEX2NHORFpDH0I+0T3nAyLeyTEADoXKRBvbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A5F6C68CFE; Fri, 13 Jun 2025 07:59:20 +0200 (CEST)
Date: Fri, 13 Jun 2025 07:59:20 +0200
From: hch <hch@lst.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	WenRuo Qu <wqu@suse.com>, Johannes Thumshirn <jth@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Boris Burkov <boris@bur.io>, hch <hch@lst.de>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 0/5] btrfs: use the super_block as bdev holder
Message-ID: <20250613055920.GA9176@lst.de>
References: <20250611100303.110311-1-jth@kernel.org> <9093e0d6-d33e-4c4b-814f-9134d568f395@suse.com> <69982e5e-96d3-4e60-891c-ade4474253cc@suse.com> <1618ecb3-2bc5-4c48-89d5-ba1c9ec788b3@wdc.com> <01b0f70f-c131-4b79-a997-7317176d6269@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b0f70f-c131-4b79-a997-7317176d6269@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 13, 2025 at 07:51:25AM +0930, Qu Wenruo wrote:
>> -       if (fs_info->fs_devices) {
>> +       if (fs_info && fs_info->fs_devices) {
>> +               ASSERT(fs_info->fs_devices->is_open);
>>                   btrfs_close_devices(fs_info->fs_devices);
>>                   fs_info->fs_devices = NULL;
>>           }
>>
>> So if we end up in btrfs_reconfigure_for_mount() and fs_info and
>> fs_info->fs_devices are set, I see the is_open flag being set as
>> well. But the fstests run isn't 100% finished yet (and it's only
>> been a -g quick run anyways).
>
> Since I'm also working on cleaning up the mount process, I'm getting a 
> little familiar with this part, but if HCH can comment on this, it will be 
> a great help.

I wish I could.  A lot of this mount stuff has been entirely paged out
of my memory, I'm sorry.  Note that Christian did some fairly big rework
in this area, and now the new mount API came in as well.  So things
around it looks pretty different.

I think the parts of the series that are valueable as is are the
"open read-only for scanning" and split the inuse counter bits,
which are pretty obvious.  Everything else might need a more or less
big redo with all the surrounding changes.


