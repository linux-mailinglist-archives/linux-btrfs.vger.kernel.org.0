Return-Path: <linux-btrfs+bounces-16590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E5B4000C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 14:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C806545814
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1201308F34;
	Tue,  2 Sep 2025 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PPkL9AVq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED993081A2
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814988; cv=none; b=E1KBSq0/EHiaA5F4MCRGQ/YqntYxhcdtSl5Wq7OUVAAFEQaYkC223c5jCm6dj7upNZJEPLsI++GpNOdlvwcbT2f4A0PnzzKGvClnx1M/ArtJpLC3LSTAHNOJBtVK40pju3tpOw1GuveE+xI40mvOsmYWWqZyPvCLdbcxA77siMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814988; c=relaxed/simple;
	bh=umubb5ja5btA3FbvGDpT5snjrja/6XWb0oS/xFx1UIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU/X0cw0yHVk6UgRuMkjk/MXu27pAZz8tsaDAk2aIVAdxCoy6upZMsohWn3mfoPJ2XgQHyLzwaE+vE4GrNxiXJcemeyUk62Ja4vBbsK5+Brk6dO5B4rbdIzf15FjZ9NZawviI72/EuuCptCzqcKkEn+gr42CPhspVBL66gSBKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PPkL9AVq; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-217.bstnma.fios.verizon.net [173.48.82.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 582C9W11030330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Sep 2025 08:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1756814974; bh=3hW8MI6wgp2erDa+pJ+0tZiB1LWGKb5iv9yqhJYhwrw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PPkL9AVqYZIPNZypDXFeUkzC+MEPjbfdo6d2hcFndA6O3PzjFhRcyhsh0WOczMSAw
	 /zw7509uJjhGPQnqh1PeFQUOcB6L7DbwHwfa1pAjkP+uSYa65up6193429f4oYNn5o
	 z9nVWOamCfN8JyylBpGwdPSKHbhb8pNhjYavHiTdxwWpm0Mcxp3JMNrBywFghuChJf
	 jHmIM3jysoBx1OIiZXPFIy9/34mKqAZlwSXgNfZ9+VT90+awOqpMnMslx+p4imkhj6
	 HUrM4ZDZGGdP7aEUc7ncNLwu+nv4eESo6XKkU2OdmJaTXjnqgpcmx5KAHps2rSNpvq
	 oP8epkAWd5z2g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 82E452E00D6; Tue, 02 Sep 2025 08:09:32 -0400 (EDT)
Date: Tue, 2 Sep 2025 08:09:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: Golden output mismatch from generic/228, fs independent
Message-ID: <20250902120932.GA2564374@mit.edu>
References: <60b73970-9cb6-49b1-ad5f-51ab02ef2c98@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60b73970-9cb6-49b1-ad5f-51ab02ef2c98@gmx.com>

On Tue, Sep 02, 2025 at 08:00:32PM +0930, Qu Wenruo wrote:
> Hi,
> 
> Recently I updated my arm64 VM, and now several test cases are failing due
> to golden output mismatch.
> 
> This time it's fs independent, and I haven't yet updated fstests itself, so
> it looks like some updates in my environment is breaking the test.
> 
> E.g, generic/228 on ext4 (the same on btrfs)
> 
> I checked my log, bash/xfsprogs and a lot of other packages are all updated,
> and unfortunately my distro doesn't provide older packages for me to
> bisect...

I don't know if this helps, but here's a kvm-xfstests using Debian
Trixie and certain updated critical packages (fio, quota, xfsprogs,
util-linux, etc.) overriden.  How does that differ from your distro
package versions?

I haven't updated my arm64 image in a bit (this was from dated July 20th).
I can try doing an arm64 rebuild and see if a newer version still
works on arm64, but here's a data point....

						- TEd


KERNEL:    kernel       6.17.0-rc3-xfstests #1 SMP Tue Sep  2 07:57:28 EDT 2025 aarch64
CMDLINE:   --arm64 -c ext4/4k generic/228
CPUS:      2
MEM:       1977.09

ext4/4k: 1 tests, 5 seconds
  generic/228  Pass     2s
Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 2s

FSTESTVER: blktests     401420a (Fri, 6 Jun 2025 22:12:43 +0900)
FSTESTVER: fio          fio-3.40 (Tue, 20 May 2025 12:23:01 -0600)
FSTESTVER: fsverity     v1.6-2-gee7d74d (Mon, 17 Feb 2025 11:41:58 -0800)
FSTESTVER: ima-evm-utils        v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
FSTESTVER: libaio       libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
FSTESTVER: ltp          20250130-280-g60656cbbb (Wed, 28 May 2025 15:04:44 +0200)
FSTESTVER: quota                v4.05-71-g4cd93fc (Sun, 27 Apr 2025 08:24:24 -0400)
FSTESTVER: util-linux   v2.41-40-g22b91501d (Mon, 26 May 2025 11:27:31 +0200)
FSTESTVER: xfsprogs     v6.15.0 (Mon, 23 Jun 2025 13:56:41 +0200)
FSTESTVER: xfstests     v2025.07.13-12-gef63d1368 (Sat, 19 Jul 2025 18:14:29 -0400)
FSTESTVER: xfstests-bld gce-xfstests-202504292206-20-g905451c1 (Sun, 20 Jul 2025 03:04:27 +0000)
FSTESTVER: zz_build-distro      trixie
FSTESTCFG: ext4/4k
FSTESTSET: generic/228
FSTESTOPT: aex
Truncating test artifacts in /results to 31k

