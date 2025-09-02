Return-Path: <linux-btrfs+bounces-16596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C268EB40AF6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 18:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3F74E22E5
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABEF338F4F;
	Tue,  2 Sep 2025 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="EoFaclLf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02431AF24
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831725; cv=none; b=m0/3DddcMJFTI8nkiMlfW26S754ys23RQFfWAlvES0qdYLWNQKmNVGC9EOfxLXG4pw47JLxmdEgUHBPUy2tK41sr+43JouDWOCJuOye7P8cxEyE14Qp9A9WAb09i3Q2lIowPCKt8XOnl17uEQld5mAhVaGING54myf2pGQUhqfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831725; c=relaxed/simple;
	bh=69dcZwO17cLA6EgoAUe5VYDABRbY7UrrT3nqvJ+Z/lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ite1mfnX3Oqimw1m6m5NV1hEvC8q94EacNpT3EaMKVB6O4vQMi/viOnskJm47W5laeGlU7VShfkN+GozYp98vkCtyljwpg+nzCGntTLAWwfhYenA6k68EsU28T1+b/sEIZSH+4cLDlZx6aZpdA6T2+M8uEWLZgtWMkivjFXyMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=EoFaclLf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-217.bstnma.fios.verizon.net [173.48.82.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 582GmWYr029864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Sep 2025 12:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1756831714; bh=TAAfaCs8utlzc2OUMwuLfN9TPE1SG2Y1TpCqENYMIGM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=EoFaclLfQ7Az1EbjsAWulUTEsGywZW92UMkr7cnQZ/gcPAQNJIAD/lKk+8+zW5ii2
	 QvnzMaAKuhfXjx4DmP/Du4DEACMnvcM+GFzv4qsHB6Ebrgp+D+XL6b6pITtzYnCghq
	 k/dRfex+J8V6v23BKUFXRceZ71xzHpgMbK854qL5nlVUdctnSE0Q5kuDRpaw5+nfSL
	 619xXjzh1ovOx14qXikrGUVdBorLAY93S7cMyTh4Bb3en9J2JGkeJwraNk/iOF6dGQ
	 WqUSG/hIBdMAVgEYu0VIfSxEBrSkBItw0XSjEgZmOMGoLHvMPVad0+8xObinyADzIG
	 Eu4tl85p0QvcQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C6E462E00D6; Tue, 02 Sep 2025 12:48:32 -0400 (EDT)
Date: Tue, 2 Sep 2025 12:48:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: Golden output mismatch from generic/228, fs independent
Message-ID: <20250902164832.GA2598713@mit.edu>
References: <60b73970-9cb6-49b1-ad5f-51ab02ef2c98@gmx.com>
 <20250902120932.GA2564374@mit.edu>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902120932.GA2564374@mit.edu>

On Tue, Sep 02, 2025 at 08:09:32AM -0400, Theodore Ts'o wrote:
> I haven't updated my arm64 image in a bit (this was from dated July 20th).
> I can try doing an arm64 rebuild and see if a newer version still
> works on arm64, but here's a data point....

And here's an update with the latest xfstests for-next branch, and
6.16 xfsprogs, etc.  Still no problems for me....

						- Ted

KERNEL:    kernel       6.17.0-rc3-xfstests #1 SMP Tue Sep  2 07:57:28 EDT 2025 aarch64
CMDLINE:   --arm64 -c ext4/4k generic/228
CPUS:      2
MEM:       1977.09

ext4/4k: 1 tests, 5 seconds
  generic/228  Pass     2s
Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 2s

FSTESTVER: blktests     8ac6c4f (Sun, 31 Aug 2025 18:34:41 +0900)
FSTESTVER: fio          fio-3.40 (Tue, 20 May 2025 12:23:01 -0600)
FSTESTVER: fsverity     v1.6-2-gee7d74d (Mon, 17 Feb 2025 11:41:58 -0800)
FSTESTVER: ima-evm-utils        v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
FSTESTVER: libaio       libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
FSTESTVER: ltp          20250530-178-g9691c4b2b (Mon, 1 Sep 2025 12:01:57 +0200)
FSTESTVER: quota                v4.05-77-g22ff3d9 (Tue, 2 Sep 2025 08:12:02 -0400)
FSTESTVER: util-linux   v2.41.1 (Tue, 24 Jun 2025 09:55:28 +0200)
FSTESTVER: xfsprogs     v6.16.0 (Tue, 26 Aug 2025 20:27:25 +0200)
FSTESTVER: xfstests     v2025.08.17-10-g057be3ead-dirty (Mon, 25 Aug 2025 11:59:43 -0400)
FSTESTVER: xfstests-bld gce-xfstests-202504292206-22-ge10dc029-dirty (Mon, 25 Aug 2025 12:33:01 -0400)
FSTESTVER: zz_build-distro      trixie
FSTESTCFG: ext4/4k
FSTESTSET: generic/228
FSTESTOPT: aex

