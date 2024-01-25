Return-Path: <linux-btrfs+bounces-1786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AAC83C105
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 12:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B043528B250
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A534E1D8;
	Thu, 25 Jan 2024 11:34:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE951017;
	Thu, 25 Jan 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182444; cv=none; b=ZMVPd09dyY1i1nwgCGptz5gZRKDUUf+ZIwqAZStSiSDriAWmAKoleukHK+mqTJyyHFqmmQNmCpUn6QecjQwq0jjg8u/uJ59bWeU3YAmeg5ihgMqifwtaCfATYbszgWYNm/P4UhmrN/yG6fll3ykAtLH7/O+OmXF9bnA4LNrXrpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182444; c=relaxed/simple;
	bh=9Osbi+VQBj6QAYWxlXkNyCZikozOnWLhTODvYvHK42g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8c1FHaEaC2xyaqMvB0cYqkKrUEBBH36QikNeBAfXFtg4opnSDspkmIv+kB4t4QvvxnbNOWIllZZp/gOuaWyYJ3mj1ikhRBF1wCQ96qRUKmMktwZpDH+rLV4j9Nb20fp50DdhQvgMwoqJR5GxnaBRpKo9IzLRTirkU4oie11czU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 912E15200F2;
	Thu, 25 Jan 2024 12:33:58 +0100 (CET)
Received: from lxhi-087 (10.72.93.211) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Jan
 2024 12:33:58 +0100
Date: Thu, 25 Jan 2024 12:33:54 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
CC: <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>, Rob
 Landley <rob@landley.net>, <stable@vger.kernel.org>, David Sterba
	<dsterba@suse.com>, <Maksim.Paimushkin@se.bosch.com>,
	<Eugeniu.Rosca@bosch.com>, <erosca@de.adit-jv.com>, Eugeniu Rosca
	<roscaeugeniu@gmail.com>
Subject: Re: [PATCH v2] btrfs: fix infinite directory reads
Message-ID: <20240125113354.GA2629056@lxhi-087>
References: <1ae6e30a71112e07c727f9e93ff32032051bbce7.1706176168.git.wqu@suse.com>
 <CAL3q7H77i3kv7C352k2R6nr-m-cgh_cdCCeTkXna+v1yjpMuoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H77i3kv7C352k2R6nr-m-cgh_cdCCeTkXna+v1yjpMuoA@mail.gmail.com>
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

Hi Filipe and Qu,

On Thu, Jan 25, 2024 at 10:02:01AM +0000, Filipe Manana wrote:
> On Thu, Jan 25, 2024 at 9:51 AM Qu Wenruo <wqu@suse.com> wrote:
> >
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > [ Upstream commit 9b378f6ad48cfa195ed868db9123c09ee7ec5ea2 ]
> >
> > The readdir implementation currently processes always up to the last index
> > it finds. This however can result in an infinite loop if the directory has

[..]

> Thanks for the backport, and running the corresponding test case from
> fstests to verify it's working.
> 
> However when backporting a commit, one should also check if there are
> fixes for that commit, as they
> often introduce regressions or have some other bug - 

+1. Good to see this best practice applied here.

> and that's the
> case here. We also need to backport
> the following 3 commits:
> 
> https:// git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=357950361cbc6d54fb68ed878265c647384684ae
> https:// git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e60aa5da14d01fed8411202dbe4adf6c44bd2a57
> https:// git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e7f82deb0c0386a03b62e30082574347f8b57d5

Good catch. I get the same list thanks to the reference of the culprit:

$ git log --oneline --grep 9b378f6ad linux/master
8e7f82deb0c038 btrfs: fix race between reading a directory and adding entries to it
e60aa5da14d01f btrfs: refresh dir last index during a rewinddir(3) call
357950361cbc6d btrfs: set last dir index to the current last index when opening dir

> One regression, the one regarding rewinddir(3), even has a test case
> in fstests too (generic/471) and would have been caught
> when running the "dir" group tests in fstests:
> 
> https:// git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=68b958f5dc4ab13cfd86f7fb82621f9f022b7626
> 
> I'll work on making backports of those 3 other patches on top of your
> backport, and then send all of them in a series,
> including your patch, to make it easier to follow and apply all at once.

Thanks for your support. Looking forward.

BR, Eugeniu

