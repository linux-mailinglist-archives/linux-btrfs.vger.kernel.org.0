Return-Path: <linux-btrfs+bounces-13527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34117AA1BAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 21:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8BE17B1E57
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83625FA1F;
	Tue, 29 Apr 2025 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToC3kV+Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B8251793;
	Tue, 29 Apr 2025 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956683; cv=none; b=st6vO2eux2ZSk2PojH51h1QC6aaQvARc51j7WAweAUHxnAi7eqzsLSnz19MZ2TC+7tM/5fV0oYGCW66+RnBM0FxhQSNYmnNtYkCvP/TrP9UwD5+jnV5Eq+5rLlyt+JnjEgDtn4US8ahF/naWjehEPPm0SS2ieHP0fN9roLDcv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956683; c=relaxed/simple;
	bh=98VBwKkahr1dgJnHaJYiAcTar8Tj6P5pB89tLHT/uM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhMf4TD6uC3hsPqwuhT091l6YELqq9Gpph2/pNn/uneSuzGNR4/BfzDLB7eyCV33cP/8OjGV+fk2xvYbm2nzfBXdP66TubRkESAs+DS2ZoFB1XskRBU7MBNSj6zQDLLpblMpgA16XdT9NShmEM9zvp5J1PZBW5Ka+oACcra+JNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToC3kV+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3925C4CEE3;
	Tue, 29 Apr 2025 19:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745956683;
	bh=98VBwKkahr1dgJnHaJYiAcTar8Tj6P5pB89tLHT/uM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToC3kV+QsE85Lc+xIpTvq/5CWdelXipjIBRJ4PArLXuuCsUbxBnDSIDyemWFisutW
	 OJe0DQ9hGd9t+MBa5YtfeSxNWL7DZ3lxEX4JQLlZaixWakCayeBTBwwJwOBT4CaZLJ
	 0VNmlHIOwJI2ST4d2PhvErsAaqI3/74PnOQjkgJJ9LgI6ObiSFcSwhOt88FgXlcpQJ
	 vVC4N+AK+uyQ9zTHYAXgUYwpHTvCQ+67DM+KIm6vkwDFtvyTeLxsofwRs1KKSiiZfL
	 iSFyojb/ZUJyRd2DXjq3RJ/EsG4OGqY0fjpRq7HXAv6HUTBVkwc7vu7uzCoKgSOuPh
	 E4EiiqBtCCb7Q==
Date: Tue, 29 Apr 2025 12:58:01 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	kdevops@lists.linux.dev
Subject: Re: btrfs v6.15-rc2 baseline
Message-ID: <aBEvSWjHs1T9jUfe@bombadil.infradead.org>
References: <Z__4Fu6VsCVDFKkO@bombadil.infradead.org>
 <20250424101736.GL3659@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424101736.GL3659@suse.cz>

On Thu, Apr 24, 2025 at 12:17:36PM +0200, David Sterba wrote:
> On Wed, Apr 16, 2025 at 11:33:58AM -0700, Luis Chamberlain wrote:
> > btrfs developers,
> > 
> > kdevops has run fstests on v6.15-rc2 across the different btrfs profiles
> > it currently defines, and the results are below.
> > 
> > The btrfs profiles which kdevops currently supports are:
> > 
> >   - btrfs_simple
> >   - btrfs_nohofspace
> >   - btrfs_noholes
> >   - btrfs_holes
> >   - btrfs_holes_zstd
> >   - btrfs_noholes_lzo
> >   - btrfs_fspace
> >   - btrfs_noholes_zlib
> >   - btrfs_noholes_zstd
> 
> I don't know how much VM power you have to run all the setups,

I'm of the opinion that there are enough interested parties in btrfs
that we should be able to scope out a dedicated VM to teste daily
regardless of needs. For now Samsung is helping with this, but certainly
we can scale better longer term with more folks who wish to volunteer
hardware.

> some of
> thhem can be removed as they are duplicating the defaults. We've
> switched to 'noholes' by default, so anything with 'holes' can be
> removed. Same with free space tree (space_cache=v2).

OK how about this:

From a7e822d87d6a9fe918d011a0b7057d4a015809fe Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 29 Apr 2025 12:03:20 -0700
Subject: [PATCH] btrfs: remove nospace and fspace from the default profile

We have a defconfig for btrfs on kdevops which provides the default
configuration of how we want to test btrfs on kdevops. Update it
so that CI trees which rely on it only test the profiles which
btrfs developers wish to dedicate attention towards as suggested
by the community [0].

Link: https://lkml.kernel.org/r/20250424101736.GL3659@suse.cz # [0]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 defconfigs/btrfs | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/defconfigs/btrfs b/defconfigs/btrfs
index e69bf91e8a19..979d1a2b1115 100644
--- a/defconfigs/btrfs
+++ b/defconfigs/btrfs
@@ -20,23 +20,12 @@ CONFIG_FSTESTS_BTRFS_ENABLES_COMPRESSION=y
 CONFIG_FSTESTS_BTRFS_ENABLES_COMPRESSION_ZLIB=y
 CONFIG_FSTESTS_BTRFS_ENABLES_COMPRESSION_LZO=y
 CONFIG_FSTESTS_BTRFS_ENABLES_COMPRESSION_ZSTD=y
-CONFIG_FSTESTS_BTRFS_ENABLES_HOLES=y
 CONFIG_FSTESTS_BTRFS_ENABLES_NOHOLES=y
-CONFIG_FSTESTS_BTRFS_ENABLES_FSPACE=y
 CONFIG_FSTESTS_BTRFS_ENABLES_NOHOFSPACE=y
-CONFIG_FSTESTS_BTRFS_SECTION_HOLES=y
-CONFIG_FSTESTS_BTRFS_SECTION_HOLES_ZLIB=y
-CONFIG_FSTESTS_BTRFS_SECTION_HOLES_LZO=y
-CONFIG_FSTESTS_BTRFS_SECTION_HOLES_ZSTD=y
 CONFIG_FSTESTS_BTRFS_SECTION_NOHOLES=y
 CONFIG_FSTESTS_BTRFS_SECTION_NOHOLES_ZLIB=y
 CONFIG_FSTESTS_BTRFS_SECTION_NOHOLES_LZO=y
 CONFIG_FSTESTS_BTRFS_SECTION_NOHOLES_ZSTD=y
-CONFIG_FSTESTS_BTRFS_SECTION_FSPACE=y
-CONFIG_FSTESTS_BTRFS_SECTION_FSPACE_DSYNC=y
-CONFIG_FSTESTS_BTRFS_SECTION_FSPACE_ZLIB=y
-CONFIG_FSTESTS_BTRFS_SECTION_FSPACE_LZO=y
-CONFIG_FSTESTS_BTRFS_SECTION_FSPACE_ZSTD=y
 CONFIG_FSTESTS_BTRFS_SECTION_NOHOFSPACE=y
 CONFIG_FSTESTS_BTRFS_SECTION_NOHOFSPACE_ZLIB=y
 CONFIG_FSTESTS_BTRFS_SECTION_NOHOFSPACE_LZO=y
-- 
2.47.2


And so with just:

make defconfig-btrfs KDEVOPS_HOSTS_PREFIX="yay" -j 128
make -j128
cat hosts we nd up with a shorter list now, 10 guests:

yay-btrfs-noholes
yay-btrfs-noholes-zlib
yay-btrfs-noholes-lzo
yay-btrfs-noholes-zstd
yay-btrfs-nohofspace
yay-btrfs-nohofspace-zlib
yay-btrfs-nohofspace-lzo
yay-btrfs-nohofspace-zstd
yay-btrfs-simple
yay-btrfs-simple-zns

Does this seem right? I realize the compression ones may test the same thing,
so its not clear if we want to run the default btrfs defconfig without
compression more regularly and just add a new defconfig with compression to
just run that maybe once a month?

If we remove compression we have:

btrfs-noholes
btrfs-nohofspace
btrfs-simple
btrfs-simple-zns

Having the compression profiles *in* for now just means a bit more redudant
testing.

> > These are defined in the btrfs jinja2 template on kdevops [0] and described
> > on the ext4 kconfig [1]. Adding support for more profiles is just a matter
> > of editing these two files, please feel free to send a patch if you'd like
> > kdevops to test more profiles. A full tarball of the fstests results are
> > available on kdevops-results-archive [2]. Since we leverage git-lfs, you can
> > opt to only download this single tarball as follows:
> > 
> > GIT_LFS_SKIP_SMUDGE=1 git clone https://github.com/linux-kdevops/kdevops-results-archive.git
> > cd kdevops-results-archive
> > git lfs fetch --include "fstests/gh/linux-btrfs-kpd/20250416/0001/linux-6-15-rc2/8ffd015db85f.xz"
> > git lfs checkout "fstests/gh/linux-btrfs-kpd/20250416/0001/linux-6-15-rc2/8ffd015db85f.xz"
> > 
> > Few questions:
> > 
> >  - Is this useful information?
> 
> Yes.

Fantastico.

> >  - Do you want results for each rc release posted to the mailing list?
> 
> Yes, ideally in some terse form with the summary lines only, the full
> list of Failures seems too much.

We gotta start somewhere!

> Tuning fstests to run with 0 failures
> involves adding expunges/excludes or other workarounds.

Indeed. There is support for that. So we can just expunge them, do we
want a first report to be the lore URL as a comment for the commit log? For
example. Anyone can generate the expunge files that can be used by
kdevops by untarring the results archive into kdevops and using the
commands specified in the commit logs below. First we itemize all
failures per section:

From 7a963f5f020cf113288ce99ad51d836e2b9b5c18 Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 29 Apr 2025 12:49:46 -0700
Subject: [PATCH 1/2] btrfs: add expunges for 6.15.0-rc2-g8ffd015db85f

This adds expunges for btrfs for 6.15.0-rc2-g8ffd015db85f.
This was generated with:

./playbooks/python/workflows/fstests/augment_expunge_list.py btrfs workflows/fstests/results/6.15.0-rc2-g8ffd015db85f workflows/fstests/expunges

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 .../btrfs/unassigned/btrfs_fspace.txt         |  14 ++
 .../btrfs/unassigned/btrfs_holes.txt          | 192 +++++++++++++++++
 .../btrfs/unassigned/btrfs_holes_zstd.txt     | 196 +++++++++++++++++
 .../btrfs/unassigned/btrfs_nohofspace.txt     |  14 ++
 .../btrfs/unassigned/btrfs_noholes.txt        | 193 +++++++++++++++++
 .../btrfs/unassigned/btrfs_noholes_lzo.txt    | 198 ++++++++++++++++++
 .../btrfs/unassigned/btrfs_noholes_zlib.txt   | 197 +++++++++++++++++
 .../btrfs/unassigned/btrfs_noholes_zstd.txt   | 197 +++++++++++++++++
 .../btrfs/unassigned/btrfs_simple.txt         |  24 +++
 9 files changed, 1225 insertions(+)
 create mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_fspace.txt
 create mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes.txt
 create mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes_zstd.txt
 create mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_nohofspace.txt
 create mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes.txt
 create mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_lzo.txt
 create mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zlib.txt
 create mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zstd.txt
 create mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_simple.txt

diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_fspace.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_fspace.txt
new file mode 100644
index 000000000000..59c89701dd96
--- /dev/null
+++ b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_fspace.txt
@@ -0,0 +1,14 @@
+btrfs/002
+btrfs/192
+btrfs/220
+btrfs/226
+btrfs/300
+btrfs/315
+generic/633
+generic/644
+generic/645
+generic/656
+generic/689
+generic/696
+generic/730
+generic/747
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes.txt
new file mode 100644
index 000000000000..17099db84acf
--- /dev/null
+++ b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes.txt
@@ -0,0 +1,192 @@
+btrfs/002
+btrfs/028
+btrfs/049
+btrfs/121
+btrfs/122
+btrfs/123
+btrfs/126
+btrfs/149
+btrfs/153
+btrfs/156
+btrfs/180
+btrfs/181
+btrfs/182
+btrfs/183
+btrfs/187
+btrfs/189
+btrfs/191
+btrfs/193
+btrfs/194
+btrfs/199
+btrfs/200
+btrfs/203
+btrfs/204
+btrfs/205
+btrfs/210
+btrfs/212
+btrfs/213
+btrfs/214
+btrfs/215
+btrfs/217
+btrfs/220
+btrfs/223
+btrfs/226
+btrfs/228
+btrfs/229
+btrfs/242
+btrfs/245
+btrfs/246
+btrfs/251
+btrfs/258
+btrfs/259
+btrfs/263
+btrfs/279
+btrfs/281
+btrfs/283
+btrfs/285
+btrfs/287
+btrfs/295
+btrfs/299
+btrfs/300
+btrfs/301
+btrfs/310
+btrfs/315
+btrfs/316
+btrfs/319
+btrfs/322
+btrfs/331
+generic/157
+generic/158
+generic/161
+generic/162
+generic/163
+generic/164
+generic/165
+generic/166
+generic/167
+generic/168
+generic/170
+generic/171
+generic/172
+generic/173
+generic/174
+generic/176
+generic/183
+generic/185
+generic/188
+generic/189
+generic/190
+generic/191
+generic/194
+generic/195
+generic/196
+generic/197
+generic/199
+generic/200
+generic/201
+generic/202
+generic/203
+generic/242
+generic/243
+generic/253
+generic/254
+generic/259
+generic/265
+generic/266
+generic/267
+generic/268
+generic/271
+generic/272
+generic/276
+generic/278
+generic/279
+generic/281
+generic/282
+generic/283
+generic/284
+generic/287
+generic/289
+generic/290
+generic/291
+generic/292
+generic/293
+generic/295
+generic/296
+generic/297
+generic/298
+generic/301
+generic/302
+generic/329
+generic/330
+generic/331
+generic/332
+generic/333
+generic/334
+generic/353
+generic/356
+generic/357
+generic/358
+generic/359
+generic/373
+generic/374
+generic/387
+generic/414
+generic/415
+generic/447
+generic/457
+generic/493
+generic/501
+generic/513
+generic/514
+generic/515
+generic/517
+generic/518
+generic/540
+generic/541
+generic/542
+generic/543
+generic/544
+generic/546
+generic/562
+generic/588
+generic/614
+generic/628
+generic/629
+generic/630
+generic/633
+generic/634
+generic/643
+generic/644
+generic/645
+generic/648
+generic/656
+generic/657
+generic/658
+generic/659
+generic/660
+generic/661
+generic/662
+generic/663
+generic/664
+generic/665
+generic/666
+generic/667
+generic/668
+generic/669
+generic/670
+generic/671
+generic/672
+generic/673
+generic/674
+generic/675
+generic/689
+generic/696
+generic/698
+generic/702
+generic/730
+generic/732
+generic/733
+generic/738
+generic/741
+generic/747
+generic/754
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes_zstd.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes_zstd.txt
new file mode 100644
index 000000000000..897f9cad537a
--- /dev/null
+++ b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes_zstd.txt
@@ -0,0 +1,196 @@
+btrfs/011
+btrfs/028
+btrfs/049
+btrfs/121
+btrfs/122
+btrfs/123
+btrfs/149
+btrfs/153
+btrfs/180
+btrfs/181
+btrfs/182
+btrfs/183
+btrfs/187
+btrfs/189
+btrfs/191
+btrfs/193
+btrfs/194
+btrfs/199
+btrfs/200
+btrfs/203
+btrfs/204
+btrfs/205
+btrfs/210
+btrfs/212
+btrfs/213
+btrfs/214
+btrfs/215
+btrfs/217
+btrfs/220
+btrfs/223
+btrfs/226
+btrfs/228
+btrfs/229
+btrfs/242
+btrfs/245
+btrfs/246
+btrfs/251
+btrfs/258
+btrfs/259
+btrfs/263
+btrfs/265
+btrfs/266
+btrfs/267
+btrfs/268
+btrfs/269
+btrfs/279
+btrfs/281
+btrfs/283
+btrfs/285
+btrfs/287
+btrfs/288
+btrfs/289
+btrfs/295
+btrfs/297
+btrfs/299
+btrfs/300
+btrfs/310
+btrfs/315
+btrfs/316
+btrfs/319
+btrfs/322
+btrfs/331
+generic/157
+generic/158
+generic/161
+generic/162
+generic/163
+generic/164
+generic/165
+generic/166
+generic/167
+generic/168
+generic/170
+generic/171
+generic/172
+generic/173
+generic/174
+generic/176
+generic/183
+generic/185
+generic/188
+generic/189
+generic/190
+generic/191
+generic/194
+generic/195
+generic/196
+generic/197
+generic/199
+generic/200
+generic/201
+generic/202
+generic/203
+generic/225
+generic/242
+generic/243
+generic/253
+generic/254
+generic/259
+generic/265
+generic/266
+generic/267
+generic/268
+generic/271
+generic/272
+generic/276
+generic/278
+generic/279
+generic/281
+generic/282
+generic/283
+generic/284
+generic/287
+generic/289
+generic/290
+generic/291
+generic/292
+generic/293
+generic/295
+generic/296
+generic/297
+generic/298
+generic/301
+generic/302
+generic/329
+generic/330
+generic/331
+generic/332
+generic/333
+generic/334
+generic/353
+generic/356
+generic/357
+generic/358
+generic/359
+generic/373
+generic/374
+generic/387
+generic/414
+generic/415
+generic/447
+generic/493
+generic/501
+generic/513
+generic/514
+generic/515
+generic/517
+generic/518
+generic/540
+generic/541
+generic/542
+generic/543
+generic/544
+generic/546
+generic/562
+generic/588
+generic/614
+generic/628
+generic/629
+generic/630
+generic/633
+generic/634
+generic/643
+generic/644
+generic/645
+generic/648
+generic/656
+generic/657
+generic/658
+generic/659
+generic/660
+generic/661
+generic/662
+generic/663
+generic/664
+generic/665
+generic/666
+generic/667
+generic/668
+generic/669
+generic/670
+generic/671
+generic/672
+generic/673
+generic/674
+generic/675
+generic/689
+generic/696
+generic/698
+generic/702
+generic/730
+generic/732
+generic/733
+generic/738
+generic/741
+generic/754
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_nohofspace.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_nohofspace.txt
new file mode 100644
index 000000000000..59c89701dd96
--- /dev/null
+++ b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_nohofspace.txt
@@ -0,0 +1,14 @@
+btrfs/002
+btrfs/192
+btrfs/220
+btrfs/226
+btrfs/300
+btrfs/315
+generic/633
+generic/644
+generic/645
+generic/656
+generic/689
+generic/696
+generic/730
+generic/747
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes.txt
new file mode 100644
index 000000000000..6ff8f21a1d4c
--- /dev/null
+++ b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes.txt
@@ -0,0 +1,193 @@
+btrfs/002
+btrfs/028
+btrfs/049
+btrfs/121
+btrfs/122
+btrfs/123
+btrfs/126
+btrfs/149
+btrfs/153
+btrfs/156
+btrfs/180
+btrfs/181
+btrfs/182
+btrfs/183
+btrfs/187
+btrfs/189
+btrfs/191
+btrfs/193
+btrfs/194
+btrfs/199
+btrfs/200
+btrfs/203
+btrfs/204
+btrfs/205
+btrfs/210
+btrfs/212
+btrfs/213
+btrfs/214
+btrfs/215
+btrfs/217
+btrfs/220
+btrfs/223
+btrfs/226
+btrfs/228
+btrfs/229
+btrfs/242
+btrfs/245
+btrfs/246
+btrfs/251
+btrfs/258
+btrfs/259
+btrfs/263
+btrfs/279
+btrfs/281
+btrfs/283
+btrfs/285
+btrfs/287
+btrfs/295
+btrfs/299
+btrfs/300
+btrfs/301
+btrfs/310
+btrfs/315
+btrfs/316
+btrfs/319
+btrfs/322
+btrfs/331
+generic/102
+generic/157
+generic/158
+generic/161
+generic/162
+generic/163
+generic/164
+generic/165
+generic/166
+generic/167
+generic/168
+generic/170
+generic/171
+generic/172
+generic/173
+generic/174
+generic/176
+generic/183
+generic/185
+generic/188
+generic/189
+generic/190
+generic/191
+generic/194
+generic/195
+generic/196
+generic/197
+generic/199
+generic/200
+generic/201
+generic/202
+generic/203
+generic/242
+generic/243
+generic/253
+generic/254
+generic/259
+generic/265
+generic/266
+generic/267
+generic/268
+generic/271
+generic/272
+generic/276
+generic/278
+generic/279
+generic/281
+generic/282
+generic/283
+generic/284
+generic/287
+generic/289
+generic/290
+generic/291
+generic/292
+generic/293
+generic/295
+generic/296
+generic/297
+generic/298
+generic/301
+generic/302
+generic/329
+generic/330
+generic/331
+generic/332
+generic/333
+generic/334
+generic/353
+generic/356
+generic/357
+generic/358
+generic/359
+generic/373
+generic/374
+generic/387
+generic/414
+generic/415
+generic/447
+generic/457
+generic/493
+generic/501
+generic/513
+generic/514
+generic/515
+generic/517
+generic/518
+generic/540
+generic/541
+generic/542
+generic/543
+generic/544
+generic/546
+generic/562
+generic/588
+generic/614
+generic/628
+generic/629
+generic/630
+generic/633
+generic/634
+generic/643
+generic/644
+generic/645
+generic/648
+generic/656
+generic/657
+generic/658
+generic/659
+generic/660
+generic/661
+generic/662
+generic/663
+generic/664
+generic/665
+generic/666
+generic/667
+generic/668
+generic/669
+generic/670
+generic/671
+generic/672
+generic/673
+generic/674
+generic/675
+generic/689
+generic/696
+generic/698
+generic/702
+generic/730
+generic/732
+generic/733
+generic/738
+generic/741
+generic/747
+generic/754
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_lzo.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_lzo.txt
new file mode 100644
index 000000000000..d13fd089dd70
--- /dev/null
+++ b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_lzo.txt
@@ -0,0 +1,198 @@
+btrfs/011
+btrfs/028
+btrfs/049
+btrfs/121
+btrfs/122
+btrfs/123
+btrfs/149
+btrfs/153
+btrfs/180
+btrfs/181
+btrfs/182
+btrfs/183
+btrfs/187
+btrfs/189
+btrfs/191
+btrfs/193
+btrfs/194
+btrfs/199
+btrfs/200
+btrfs/203
+btrfs/204
+btrfs/205
+btrfs/210
+btrfs/212
+btrfs/213
+btrfs/214
+btrfs/215
+btrfs/217
+btrfs/220
+btrfs/223
+btrfs/226
+btrfs/228
+btrfs/229
+btrfs/242
+btrfs/245
+btrfs/246
+btrfs/251
+btrfs/258
+btrfs/259
+btrfs/263
+btrfs/265
+btrfs/266
+btrfs/267
+btrfs/268
+btrfs/269
+btrfs/279
+btrfs/281
+btrfs/283
+btrfs/285
+btrfs/287
+btrfs/288
+btrfs/289
+btrfs/294
+btrfs/295
+btrfs/297
+btrfs/299
+btrfs/300
+btrfs/310
+btrfs/315
+btrfs/316
+btrfs/319
+btrfs/322
+btrfs/331
+generic/157
+generic/158
+generic/161
+generic/162
+generic/163
+generic/164
+generic/165
+generic/166
+generic/167
+generic/168
+generic/170
+generic/171
+generic/172
+generic/173
+generic/174
+generic/176
+generic/183
+generic/185
+generic/188
+generic/189
+generic/190
+generic/191
+generic/194
+generic/195
+generic/196
+generic/197
+generic/199
+generic/200
+generic/201
+generic/202
+generic/203
+generic/225
+generic/242
+generic/243
+generic/253
+generic/254
+generic/259
+generic/265
+generic/266
+generic/267
+generic/268
+generic/271
+generic/272
+generic/276
+generic/278
+generic/279
+generic/281
+generic/282
+generic/283
+generic/284
+generic/287
+generic/289
+generic/290
+generic/291
+generic/292
+generic/293
+generic/295
+generic/296
+generic/297
+generic/298
+generic/301
+generic/302
+generic/329
+generic/330
+generic/331
+generic/332
+generic/333
+generic/334
+generic/353
+generic/356
+generic/357
+generic/358
+generic/359
+generic/373
+generic/374
+generic/387
+generic/414
+generic/415
+generic/447
+generic/457
+generic/493
+generic/501
+generic/513
+generic/514
+generic/515
+generic/517
+generic/518
+generic/540
+generic/541
+generic/542
+generic/543
+generic/544
+generic/546
+generic/562
+generic/588
+generic/614
+generic/628
+generic/629
+generic/630
+generic/633
+generic/634
+generic/643
+generic/644
+generic/645
+generic/648
+generic/656
+generic/657
+generic/658
+generic/659
+generic/660
+generic/661
+generic/662
+generic/663
+generic/664
+generic/665
+generic/666
+generic/667
+generic/668
+generic/669
+generic/670
+generic/671
+generic/672
+generic/673
+generic/674
+generic/675
+generic/689
+generic/696
+generic/698
+generic/702
+generic/730
+generic/732
+generic/733
+generic/738
+generic/741
+generic/754
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zlib.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zlib.txt
new file mode 100644
index 000000000000..783b30cf033e
--- /dev/null
+++ b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zlib.txt
@@ -0,0 +1,197 @@
+btrfs/011
+btrfs/028
+btrfs/049
+btrfs/121
+btrfs/122
+btrfs/123
+btrfs/149
+btrfs/153
+btrfs/180
+btrfs/181
+btrfs/182
+btrfs/183
+btrfs/187
+btrfs/189
+btrfs/191
+btrfs/193
+btrfs/194
+btrfs/199
+btrfs/200
+btrfs/203
+btrfs/204
+btrfs/205
+btrfs/210
+btrfs/212
+btrfs/213
+btrfs/214
+btrfs/215
+btrfs/217
+btrfs/220
+btrfs/223
+btrfs/226
+btrfs/228
+btrfs/229
+btrfs/242
+btrfs/245
+btrfs/246
+btrfs/251
+btrfs/258
+btrfs/259
+btrfs/263
+btrfs/265
+btrfs/266
+btrfs/267
+btrfs/268
+btrfs/269
+btrfs/279
+btrfs/281
+btrfs/283
+btrfs/285
+btrfs/287
+btrfs/288
+btrfs/289
+btrfs/295
+btrfs/297
+btrfs/299
+btrfs/300
+btrfs/310
+btrfs/315
+btrfs/316
+btrfs/319
+btrfs/322
+btrfs/331
+generic/157
+generic/158
+generic/161
+generic/162
+generic/163
+generic/164
+generic/165
+generic/166
+generic/167
+generic/168
+generic/170
+generic/171
+generic/172
+generic/173
+generic/174
+generic/176
+generic/183
+generic/185
+generic/188
+generic/189
+generic/190
+generic/191
+generic/194
+generic/195
+generic/196
+generic/197
+generic/199
+generic/200
+generic/201
+generic/202
+generic/203
+generic/225
+generic/242
+generic/243
+generic/253
+generic/254
+generic/259
+generic/265
+generic/266
+generic/267
+generic/268
+generic/271
+generic/272
+generic/276
+generic/278
+generic/279
+generic/281
+generic/282
+generic/283
+generic/284
+generic/287
+generic/289
+generic/290
+generic/291
+generic/292
+generic/293
+generic/295
+generic/296
+generic/297
+generic/298
+generic/301
+generic/302
+generic/329
+generic/330
+generic/331
+generic/332
+generic/333
+generic/334
+generic/353
+generic/356
+generic/357
+generic/358
+generic/359
+generic/373
+generic/374
+generic/387
+generic/414
+generic/415
+generic/447
+generic/457
+generic/493
+generic/501
+generic/513
+generic/514
+generic/515
+generic/517
+generic/518
+generic/540
+generic/541
+generic/542
+generic/543
+generic/544
+generic/546
+generic/562
+generic/588
+generic/614
+generic/628
+generic/629
+generic/630
+generic/633
+generic/634
+generic/643
+generic/644
+generic/645
+generic/648
+generic/656
+generic/657
+generic/658
+generic/659
+generic/660
+generic/661
+generic/662
+generic/663
+generic/664
+generic/665
+generic/666
+generic/667
+generic/668
+generic/669
+generic/670
+generic/671
+generic/672
+generic/673
+generic/674
+generic/675
+generic/689
+generic/696
+generic/698
+generic/702
+generic/730
+generic/732
+generic/733
+generic/738
+generic/741
+generic/754
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zstd.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zstd.txt
new file mode 100644
index 000000000000..783b30cf033e
--- /dev/null
+++ b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zstd.txt
@@ -0,0 +1,197 @@
+btrfs/011
+btrfs/028
+btrfs/049
+btrfs/121
+btrfs/122
+btrfs/123
+btrfs/149
+btrfs/153
+btrfs/180
+btrfs/181
+btrfs/182
+btrfs/183
+btrfs/187
+btrfs/189
+btrfs/191
+btrfs/193
+btrfs/194
+btrfs/199
+btrfs/200
+btrfs/203
+btrfs/204
+btrfs/205
+btrfs/210
+btrfs/212
+btrfs/213
+btrfs/214
+btrfs/215
+btrfs/217
+btrfs/220
+btrfs/223
+btrfs/226
+btrfs/228
+btrfs/229
+btrfs/242
+btrfs/245
+btrfs/246
+btrfs/251
+btrfs/258
+btrfs/259
+btrfs/263
+btrfs/265
+btrfs/266
+btrfs/267
+btrfs/268
+btrfs/269
+btrfs/279
+btrfs/281
+btrfs/283
+btrfs/285
+btrfs/287
+btrfs/288
+btrfs/289
+btrfs/295
+btrfs/297
+btrfs/299
+btrfs/300
+btrfs/310
+btrfs/315
+btrfs/316
+btrfs/319
+btrfs/322
+btrfs/331
+generic/157
+generic/158
+generic/161
+generic/162
+generic/163
+generic/164
+generic/165
+generic/166
+generic/167
+generic/168
+generic/170
+generic/171
+generic/172
+generic/173
+generic/174
+generic/176
+generic/183
+generic/185
+generic/188
+generic/189
+generic/190
+generic/191
+generic/194
+generic/195
+generic/196
+generic/197
+generic/199
+generic/200
+generic/201
+generic/202
+generic/203
+generic/225
+generic/242
+generic/243
+generic/253
+generic/254
+generic/259
+generic/265
+generic/266
+generic/267
+generic/268
+generic/271
+generic/272
+generic/276
+generic/278
+generic/279
+generic/281
+generic/282
+generic/283
+generic/284
+generic/287
+generic/289
+generic/290
+generic/291
+generic/292
+generic/293
+generic/295
+generic/296
+generic/297
+generic/298
+generic/301
+generic/302
+generic/329
+generic/330
+generic/331
+generic/332
+generic/333
+generic/334
+generic/353
+generic/356
+generic/357
+generic/358
+generic/359
+generic/373
+generic/374
+generic/387
+generic/414
+generic/415
+generic/447
+generic/457
+generic/493
+generic/501
+generic/513
+generic/514
+generic/515
+generic/517
+generic/518
+generic/540
+generic/541
+generic/542
+generic/543
+generic/544
+generic/546
+generic/562
+generic/588
+generic/614
+generic/628
+generic/629
+generic/630
+generic/633
+generic/634
+generic/643
+generic/644
+generic/645
+generic/648
+generic/656
+generic/657
+generic/658
+generic/659
+generic/660
+generic/661
+generic/662
+generic/663
+generic/664
+generic/665
+generic/666
+generic/667
+generic/668
+generic/669
+generic/670
+generic/671
+generic/672
+generic/673
+generic/674
+generic/675
+generic/689
+generic/696
+generic/698
+generic/702
+generic/730
+generic/732
+generic/733
+generic/738
+generic/741
+generic/754
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_simple.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_simple.txt
new file mode 100644
index 000000000000..6c7d462916d8
--- /dev/null
+++ b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_simple.txt
@@ -0,0 +1,24 @@
+btrfs/002
+btrfs/170
+btrfs/220
+btrfs/226
+btrfs/271
+btrfs/300
+btrfs/315
+generic/015
+generic/171
+generic/172
+generic/173
+generic/174
+generic/371
+generic/511
+generic/546
+generic/633
+generic/644
+generic/645
+generic/656
+generic/679
+generic/689
+generic/696
+generic/730
+generic/747
-- 
2.47.2



Then if you rather treat a failure found on more than two sections to be
generic expunges we can use the ./scripts/workflows/fstests/lazy-baseline.sh
as follows, this generates an all.txt section which will be shared for
all profiles:

From c9d3c9bf7ab456f190457a8c3bd044288cc6750d Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 29 Apr 2025 12:52:02 -0700
Subject: [PATCH 2/2] btrfs: use lazy baseline

Use a lazy baseline for btrfs. This consolidates a failure found on more
than two profiles to all profiles.

./scripts/workflows/fstests/lazy-baseline.sh
Filesystem:     btrfs
Kernel tested:  6.15.0-rc2-g8ffd015db85f

Running:

./scripts/workflows/fstests/find-common-failures.sh -l workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/
./scripts/workflows/fstests/remove-common-failures.sh workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/
rm 'workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_nohofspace.txt'
rm 'workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zstd.txt'
rm 'workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_fspace.txt'
rm 'workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes.txt'
rm 'workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes_zstd.txt'
rm 'workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zlib.txt'

git add workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/all.txt

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 .../btrfs/unassigned/all.txt                  | 203 ++++++++++++++++++
 .../btrfs/unassigned/btrfs_fspace.txt         |  14 --
 .../btrfs/unassigned/btrfs_holes.txt          | 192 -----------------
 .../btrfs/unassigned/btrfs_holes_zstd.txt     | 196 -----------------
 .../btrfs/unassigned/btrfs_nohofspace.txt     |  14 --
 .../btrfs/unassigned/btrfs_noholes.txt        | 192 -----------------
 .../btrfs/unassigned/btrfs_noholes_lzo.txt    | 197 -----------------
 .../btrfs/unassigned/btrfs_noholes_zlib.txt   | 197 -----------------
 .../btrfs/unassigned/btrfs_noholes_zstd.txt   | 197 -----------------
 .../btrfs/unassigned/btrfs_simple.txt         |  18 --
 10 files changed, 203 insertions(+), 1217 deletions(-)
 create mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/all.txt
 delete mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_fspace.txt
 delete mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes.txt
 delete mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes_zstd.txt
 delete mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_nohofspace.txt
 delete mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zlib.txt
 delete mode 100644 workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zstd.txt

diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/all.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/all.txt
new file mode 100644
index 000000000000..f8d6013a0808
--- /dev/null
+++ b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/all.txt
@@ -0,0 +1,203 @@
+btrfs/002 # lazy baseline - failure found in at least two sections
+btrfs/011 # lazy baseline - failure found in at least two sections
+btrfs/028 # lazy baseline - failure found in at least two sections
+btrfs/049 # lazy baseline - failure found in at least two sections
+btrfs/121 # lazy baseline - failure found in at least two sections
+btrfs/122 # lazy baseline - failure found in at least two sections
+btrfs/123 # lazy baseline - failure found in at least two sections
+btrfs/126 # lazy baseline - failure found in at least two sections
+btrfs/149 # lazy baseline - failure found in at least two sections
+btrfs/153 # lazy baseline - failure found in at least two sections
+btrfs/156 # lazy baseline - failure found in at least two sections
+btrfs/180 # lazy baseline - failure found in at least two sections
+btrfs/181 # lazy baseline - failure found in at least two sections
+btrfs/182 # lazy baseline - failure found in at least two sections
+btrfs/183 # lazy baseline - failure found in at least two sections
+btrfs/187 # lazy baseline - failure found in at least two sections
+btrfs/189 # lazy baseline - failure found in at least two sections
+btrfs/191 # lazy baseline - failure found in at least two sections
+btrfs/192 # lazy baseline - failure found in at least two sections
+btrfs/193 # lazy baseline - failure found in at least two sections
+btrfs/194 # lazy baseline - failure found in at least two sections
+btrfs/199 # lazy baseline - failure found in at least two sections
+btrfs/200 # lazy baseline - failure found in at least two sections
+btrfs/203 # lazy baseline - failure found in at least two sections
+btrfs/204 # lazy baseline - failure found in at least two sections
+btrfs/205 # lazy baseline - failure found in at least two sections
+btrfs/210 # lazy baseline - failure found in at least two sections
+btrfs/212 # lazy baseline - failure found in at least two sections
+btrfs/213 # lazy baseline - failure found in at least two sections
+btrfs/214 # lazy baseline - failure found in at least two sections
+btrfs/215 # lazy baseline - failure found in at least two sections
+btrfs/217 # lazy baseline - failure found in at least two sections
+btrfs/220 # lazy baseline - failure found in at least two sections
+btrfs/223 # lazy baseline - failure found in at least two sections
+btrfs/226 # lazy baseline - failure found in at least two sections
+btrfs/228 # lazy baseline - failure found in at least two sections
+btrfs/229 # lazy baseline - failure found in at least two sections
+btrfs/242 # lazy baseline - failure found in at least two sections
+btrfs/245 # lazy baseline - failure found in at least two sections
+btrfs/246 # lazy baseline - failure found in at least two sections
+btrfs/251 # lazy baseline - failure found in at least two sections
+btrfs/258 # lazy baseline - failure found in at least two sections
+btrfs/259 # lazy baseline - failure found in at least two sections
+btrfs/263 # lazy baseline - failure found in at least two sections
+btrfs/265 # lazy baseline - failure found in at least two sections
+btrfs/266 # lazy baseline - failure found in at least two sections
+btrfs/267 # lazy baseline - failure found in at least two sections
+btrfs/268 # lazy baseline - failure found in at least two sections
+btrfs/269 # lazy baseline - failure found in at least two sections
+btrfs/279 # lazy baseline - failure found in at least two sections
+btrfs/281 # lazy baseline - failure found in at least two sections
+btrfs/283 # lazy baseline - failure found in at least two sections
+btrfs/285 # lazy baseline - failure found in at least two sections
+btrfs/287 # lazy baseline - failure found in at least two sections
+btrfs/288 # lazy baseline - failure found in at least two sections
+btrfs/289 # lazy baseline - failure found in at least two sections
+btrfs/295 # lazy baseline - failure found in at least two sections
+btrfs/297 # lazy baseline - failure found in at least two sections
+btrfs/299 # lazy baseline - failure found in at least two sections
+btrfs/300 # lazy baseline - failure found in at least two sections
+btrfs/301 # lazy baseline - failure found in at least two sections
+btrfs/310 # lazy baseline - failure found in at least two sections
+btrfs/315 # lazy baseline - failure found in at least two sections
+btrfs/316 # lazy baseline - failure found in at least two sections
+btrfs/319 # lazy baseline - failure found in at least two sections
+btrfs/322 # lazy baseline - failure found in at least two sections
+btrfs/331 # lazy baseline - failure found in at least two sections
+generic/157 # lazy baseline - failure found in at least two sections
+generic/158 # lazy baseline - failure found in at least two sections
+generic/161 # lazy baseline - failure found in at least two sections
+generic/162 # lazy baseline - failure found in at least two sections
+generic/163 # lazy baseline - failure found in at least two sections
+generic/164 # lazy baseline - failure found in at least two sections
+generic/165 # lazy baseline - failure found in at least two sections
+generic/166 # lazy baseline - failure found in at least two sections
+generic/167 # lazy baseline - failure found in at least two sections
+generic/168 # lazy baseline - failure found in at least two sections
+generic/170 # lazy baseline - failure found in at least two sections
+generic/171 # lazy baseline - failure found in at least two sections
+generic/172 # lazy baseline - failure found in at least two sections
+generic/173 # lazy baseline - failure found in at least two sections
+generic/174 # lazy baseline - failure found in at least two sections
+generic/176 # lazy baseline - failure found in at least two sections
+generic/183 # lazy baseline - failure found in at least two sections
+generic/185 # lazy baseline - failure found in at least two sections
+generic/188 # lazy baseline - failure found in at least two sections
+generic/189 # lazy baseline - failure found in at least two sections
+generic/190 # lazy baseline - failure found in at least two sections
+generic/191 # lazy baseline - failure found in at least two sections
+generic/194 # lazy baseline - failure found in at least two sections
+generic/195 # lazy baseline - failure found in at least two sections
+generic/196 # lazy baseline - failure found in at least two sections
+generic/197 # lazy baseline - failure found in at least two sections
+generic/199 # lazy baseline - failure found in at least two sections
+generic/200 # lazy baseline - failure found in at least two sections
+generic/201 # lazy baseline - failure found in at least two sections
+generic/202 # lazy baseline - failure found in at least two sections
+generic/203 # lazy baseline - failure found in at least two sections
+generic/225 # lazy baseline - failure found in at least two sections
+generic/242 # lazy baseline - failure found in at least two sections
+generic/243 # lazy baseline - failure found in at least two sections
+generic/253 # lazy baseline - failure found in at least two sections
+generic/254 # lazy baseline - failure found in at least two sections
+generic/259 # lazy baseline - failure found in at least two sections
+generic/265 # lazy baseline - failure found in at least two sections
+generic/266 # lazy baseline - failure found in at least two sections
+generic/267 # lazy baseline - failure found in at least two sections
+generic/268 # lazy baseline - failure found in at least two sections
+generic/271 # lazy baseline - failure found in at least two sections
+generic/272 # lazy baseline - failure found in at least two sections
+generic/276 # lazy baseline - failure found in at least two sections
+generic/278 # lazy baseline - failure found in at least two sections
+generic/279 # lazy baseline - failure found in at least two sections
+generic/281 # lazy baseline - failure found in at least two sections
+generic/282 # lazy baseline - failure found in at least two sections
+generic/283 # lazy baseline - failure found in at least two sections
+generic/284 # lazy baseline - failure found in at least two sections
+generic/287 # lazy baseline - failure found in at least two sections
+generic/289 # lazy baseline - failure found in at least two sections
+generic/290 # lazy baseline - failure found in at least two sections
+generic/291 # lazy baseline - failure found in at least two sections
+generic/292 # lazy baseline - failure found in at least two sections
+generic/293 # lazy baseline - failure found in at least two sections
+generic/295 # lazy baseline - failure found in at least two sections
+generic/296 # lazy baseline - failure found in at least two sections
+generic/297 # lazy baseline - failure found in at least two sections
+generic/298 # lazy baseline - failure found in at least two sections
+generic/301 # lazy baseline - failure found in at least two sections
+generic/302 # lazy baseline - failure found in at least two sections
+generic/329 # lazy baseline - failure found in at least two sections
+generic/330 # lazy baseline - failure found in at least two sections
+generic/331 # lazy baseline - failure found in at least two sections
+generic/332 # lazy baseline - failure found in at least two sections
+generic/333 # lazy baseline - failure found in at least two sections
+generic/334 # lazy baseline - failure found in at least two sections
+generic/353 # lazy baseline - failure found in at least two sections
+generic/356 # lazy baseline - failure found in at least two sections
+generic/357 # lazy baseline - failure found in at least two sections
+generic/358 # lazy baseline - failure found in at least two sections
+generic/359 # lazy baseline - failure found in at least two sections
+generic/373 # lazy baseline - failure found in at least two sections
+generic/374 # lazy baseline - failure found in at least two sections
+generic/387 # lazy baseline - failure found in at least two sections
+generic/414 # lazy baseline - failure found in at least two sections
+generic/415 # lazy baseline - failure found in at least two sections
+generic/447 # lazy baseline - failure found in at least two sections
+generic/457 # lazy baseline - failure found in at least two sections
+generic/493 # lazy baseline - failure found in at least two sections
+generic/501 # lazy baseline - failure found in at least two sections
+generic/513 # lazy baseline - failure found in at least two sections
+generic/514 # lazy baseline - failure found in at least two sections
+generic/515 # lazy baseline - failure found in at least two sections
+generic/517 # lazy baseline - failure found in at least two sections
+generic/518 # lazy baseline - failure found in at least two sections
+generic/540 # lazy baseline - failure found in at least two sections
+generic/541 # lazy baseline - failure found in at least two sections
+generic/542 # lazy baseline - failure found in at least two sections
+generic/543 # lazy baseline - failure found in at least two sections
+generic/544 # lazy baseline - failure found in at least two sections
+generic/546 # lazy baseline - failure found in at least two sections
+generic/562 # lazy baseline - failure found in at least two sections
+generic/588 # lazy baseline - failure found in at least two sections
+generic/614 # lazy baseline - failure found in at least two sections
+generic/628 # lazy baseline - failure found in at least two sections
+generic/629 # lazy baseline - failure found in at least two sections
+generic/630 # lazy baseline - failure found in at least two sections
+generic/633 # lazy baseline - failure found in at least two sections
+generic/634 # lazy baseline - failure found in at least two sections
+generic/643 # lazy baseline - failure found in at least two sections
+generic/644 # lazy baseline - failure found in at least two sections
+generic/645 # lazy baseline - failure found in at least two sections
+generic/648 # lazy baseline - failure found in at least two sections
+generic/656 # lazy baseline - failure found in at least two sections
+generic/657 # lazy baseline - failure found in at least two sections
+generic/658 # lazy baseline - failure found in at least two sections
+generic/659 # lazy baseline - failure found in at least two sections
+generic/660 # lazy baseline - failure found in at least two sections
+generic/661 # lazy baseline - failure found in at least two sections
+generic/662 # lazy baseline - failure found in at least two sections
+generic/663 # lazy baseline - failure found in at least two sections
+generic/664 # lazy baseline - failure found in at least two sections
+generic/665 # lazy baseline - failure found in at least two sections
+generic/666 # lazy baseline - failure found in at least two sections
+generic/667 # lazy baseline - failure found in at least two sections
+generic/668 # lazy baseline - failure found in at least two sections
+generic/669 # lazy baseline - failure found in at least two sections
+generic/670 # lazy baseline - failure found in at least two sections
+generic/671 # lazy baseline - failure found in at least two sections
+generic/672 # lazy baseline - failure found in at least two sections
+generic/673 # lazy baseline - failure found in at least two sections
+generic/674 # lazy baseline - failure found in at least two sections
+generic/675 # lazy baseline - failure found in at least two sections
+generic/689 # lazy baseline - failure found in at least two sections
+generic/696 # lazy baseline - failure found in at least two sections
+generic/698 # lazy baseline - failure found in at least two sections
+generic/702 # lazy baseline - failure found in at least two sections
+generic/730 # lazy baseline - failure found in at least two sections
+generic/732 # lazy baseline - failure found in at least two sections
+generic/733 # lazy baseline - failure found in at least two sections
+generic/738 # lazy baseline - failure found in at least two sections
+generic/741 # lazy baseline - failure found in at least two sections
+generic/747 # lazy baseline - failure found in at least two sections
+generic/754 # lazy baseline - failure found in at least two sections
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_fspace.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_fspace.txt
deleted file mode 100644
index 59c89701dd96..000000000000
--- a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_fspace.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-btrfs/002
-btrfs/192
-btrfs/220
-btrfs/226
-btrfs/300
-btrfs/315
-generic/633
-generic/644
-generic/645
-generic/656
-generic/689
-generic/696
-generic/730
-generic/747
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes.txt
deleted file mode 100644
index 17099db84acf..000000000000
--- a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes.txt
+++ /dev/null
@@ -1,192 +0,0 @@
-btrfs/002
-btrfs/028
-btrfs/049
-btrfs/121
-btrfs/122
-btrfs/123
-btrfs/126
-btrfs/149
-btrfs/153
-btrfs/156
-btrfs/180
-btrfs/181
-btrfs/182
-btrfs/183
-btrfs/187
-btrfs/189
-btrfs/191
-btrfs/193
-btrfs/194
-btrfs/199
-btrfs/200
-btrfs/203
-btrfs/204
-btrfs/205
-btrfs/210
-btrfs/212
-btrfs/213
-btrfs/214
-btrfs/215
-btrfs/217
-btrfs/220
-btrfs/223
-btrfs/226
-btrfs/228
-btrfs/229
-btrfs/242
-btrfs/245
-btrfs/246
-btrfs/251
-btrfs/258
-btrfs/259
-btrfs/263
-btrfs/279
-btrfs/281
-btrfs/283
-btrfs/285
-btrfs/287
-btrfs/295
-btrfs/299
-btrfs/300
-btrfs/301
-btrfs/310
-btrfs/315
-btrfs/316
-btrfs/319
-btrfs/322
-btrfs/331
-generic/157
-generic/158
-generic/161
-generic/162
-generic/163
-generic/164
-generic/165
-generic/166
-generic/167
-generic/168
-generic/170
-generic/171
-generic/172
-generic/173
-generic/174
-generic/176
-generic/183
-generic/185
-generic/188
-generic/189
-generic/190
-generic/191
-generic/194
-generic/195
-generic/196
-generic/197
-generic/199
-generic/200
-generic/201
-generic/202
-generic/203
-generic/242
-generic/243
-generic/253
-generic/254
-generic/259
-generic/265
-generic/266
-generic/267
-generic/268
-generic/271
-generic/272
-generic/276
-generic/278
-generic/279
-generic/281
-generic/282
-generic/283
-generic/284
-generic/287
-generic/289
-generic/290
-generic/291
-generic/292
-generic/293
-generic/295
-generic/296
-generic/297
-generic/298
-generic/301
-generic/302
-generic/329
-generic/330
-generic/331
-generic/332
-generic/333
-generic/334
-generic/353
-generic/356
-generic/357
-generic/358
-generic/359
-generic/373
-generic/374
-generic/387
-generic/414
-generic/415
-generic/447
-generic/457
-generic/493
-generic/501
-generic/513
-generic/514
-generic/515
-generic/517
-generic/518
-generic/540
-generic/541
-generic/542
-generic/543
-generic/544
-generic/546
-generic/562
-generic/588
-generic/614
-generic/628
-generic/629
-generic/630
-generic/633
-generic/634
-generic/643
-generic/644
-generic/645
-generic/648
-generic/656
-generic/657
-generic/658
-generic/659
-generic/660
-generic/661
-generic/662
-generic/663
-generic/664
-generic/665
-generic/666
-generic/667
-generic/668
-generic/669
-generic/670
-generic/671
-generic/672
-generic/673
-generic/674
-generic/675
-generic/689
-generic/696
-generic/698
-generic/702
-generic/730
-generic/732
-generic/733
-generic/738
-generic/741
-generic/747
-generic/754
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes_zstd.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes_zstd.txt
deleted file mode 100644
index 897f9cad537a..000000000000
--- a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_holes_zstd.txt
+++ /dev/null
@@ -1,196 +0,0 @@
-btrfs/011
-btrfs/028
-btrfs/049
-btrfs/121
-btrfs/122
-btrfs/123
-btrfs/149
-btrfs/153
-btrfs/180
-btrfs/181
-btrfs/182
-btrfs/183
-btrfs/187
-btrfs/189
-btrfs/191
-btrfs/193
-btrfs/194
-btrfs/199
-btrfs/200
-btrfs/203
-btrfs/204
-btrfs/205
-btrfs/210
-btrfs/212
-btrfs/213
-btrfs/214
-btrfs/215
-btrfs/217
-btrfs/220
-btrfs/223
-btrfs/226
-btrfs/228
-btrfs/229
-btrfs/242
-btrfs/245
-btrfs/246
-btrfs/251
-btrfs/258
-btrfs/259
-btrfs/263
-btrfs/265
-btrfs/266
-btrfs/267
-btrfs/268
-btrfs/269
-btrfs/279
-btrfs/281
-btrfs/283
-btrfs/285
-btrfs/287
-btrfs/288
-btrfs/289
-btrfs/295
-btrfs/297
-btrfs/299
-btrfs/300
-btrfs/310
-btrfs/315
-btrfs/316
-btrfs/319
-btrfs/322
-btrfs/331
-generic/157
-generic/158
-generic/161
-generic/162
-generic/163
-generic/164
-generic/165
-generic/166
-generic/167
-generic/168
-generic/170
-generic/171
-generic/172
-generic/173
-generic/174
-generic/176
-generic/183
-generic/185
-generic/188
-generic/189
-generic/190
-generic/191
-generic/194
-generic/195
-generic/196
-generic/197
-generic/199
-generic/200
-generic/201
-generic/202
-generic/203
-generic/225
-generic/242
-generic/243
-generic/253
-generic/254
-generic/259
-generic/265
-generic/266
-generic/267
-generic/268
-generic/271
-generic/272
-generic/276
-generic/278
-generic/279
-generic/281
-generic/282
-generic/283
-generic/284
-generic/287
-generic/289
-generic/290
-generic/291
-generic/292
-generic/293
-generic/295
-generic/296
-generic/297
-generic/298
-generic/301
-generic/302
-generic/329
-generic/330
-generic/331
-generic/332
-generic/333
-generic/334
-generic/353
-generic/356
-generic/357
-generic/358
-generic/359
-generic/373
-generic/374
-generic/387
-generic/414
-generic/415
-generic/447
-generic/493
-generic/501
-generic/513
-generic/514
-generic/515
-generic/517
-generic/518
-generic/540
-generic/541
-generic/542
-generic/543
-generic/544
-generic/546
-generic/562
-generic/588
-generic/614
-generic/628
-generic/629
-generic/630
-generic/633
-generic/634
-generic/643
-generic/644
-generic/645
-generic/648
-generic/656
-generic/657
-generic/658
-generic/659
-generic/660
-generic/661
-generic/662
-generic/663
-generic/664
-generic/665
-generic/666
-generic/667
-generic/668
-generic/669
-generic/670
-generic/671
-generic/672
-generic/673
-generic/674
-generic/675
-generic/689
-generic/696
-generic/698
-generic/702
-generic/730
-generic/732
-generic/733
-generic/738
-generic/741
-generic/754
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_nohofspace.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_nohofspace.txt
deleted file mode 100644
index 59c89701dd96..000000000000
--- a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_nohofspace.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-btrfs/002
-btrfs/192
-btrfs/220
-btrfs/226
-btrfs/300
-btrfs/315
-generic/633
-generic/644
-generic/645
-generic/656
-generic/689
-generic/696
-generic/730
-generic/747
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes.txt
index 6ff8f21a1d4c..d63f30f64469 100644
--- a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes.txt
+++ b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes.txt
@@ -1,193 +1 @@
-btrfs/002
-btrfs/028
-btrfs/049
-btrfs/121
-btrfs/122
-btrfs/123
-btrfs/126
-btrfs/149
-btrfs/153
-btrfs/156
-btrfs/180
-btrfs/181
-btrfs/182
-btrfs/183
-btrfs/187
-btrfs/189
-btrfs/191
-btrfs/193
-btrfs/194
-btrfs/199
-btrfs/200
-btrfs/203
-btrfs/204
-btrfs/205
-btrfs/210
-btrfs/212
-btrfs/213
-btrfs/214
-btrfs/215
-btrfs/217
-btrfs/220
-btrfs/223
-btrfs/226
-btrfs/228
-btrfs/229
-btrfs/242
-btrfs/245
-btrfs/246
-btrfs/251
-btrfs/258
-btrfs/259
-btrfs/263
-btrfs/279
-btrfs/281
-btrfs/283
-btrfs/285
-btrfs/287
-btrfs/295
-btrfs/299
-btrfs/300
-btrfs/301
-btrfs/310
-btrfs/315
-btrfs/316
-btrfs/319
-btrfs/322
-btrfs/331
 generic/102
-generic/157
-generic/158
-generic/161
-generic/162
-generic/163
-generic/164
-generic/165
-generic/166
-generic/167
-generic/168
-generic/170
-generic/171
-generic/172
-generic/173
-generic/174
-generic/176
-generic/183
-generic/185
-generic/188
-generic/189
-generic/190
-generic/191
-generic/194
-generic/195
-generic/196
-generic/197
-generic/199
-generic/200
-generic/201
-generic/202
-generic/203
-generic/242
-generic/243
-generic/253
-generic/254
-generic/259
-generic/265
-generic/266
-generic/267
-generic/268
-generic/271
-generic/272
-generic/276
-generic/278
-generic/279
-generic/281
-generic/282
-generic/283
-generic/284
-generic/287
-generic/289
-generic/290
-generic/291
-generic/292
-generic/293
-generic/295
-generic/296
-generic/297
-generic/298
-generic/301
-generic/302
-generic/329
-generic/330
-generic/331
-generic/332
-generic/333
-generic/334
-generic/353
-generic/356
-generic/357
-generic/358
-generic/359
-generic/373
-generic/374
-generic/387
-generic/414
-generic/415
-generic/447
-generic/457
-generic/493
-generic/501
-generic/513
-generic/514
-generic/515
-generic/517
-generic/518
-generic/540
-generic/541
-generic/542
-generic/543
-generic/544
-generic/546
-generic/562
-generic/588
-generic/614
-generic/628
-generic/629
-generic/630
-generic/633
-generic/634
-generic/643
-generic/644
-generic/645
-generic/648
-generic/656
-generic/657
-generic/658
-generic/659
-generic/660
-generic/661
-generic/662
-generic/663
-generic/664
-generic/665
-generic/666
-generic/667
-generic/668
-generic/669
-generic/670
-generic/671
-generic/672
-generic/673
-generic/674
-generic/675
-generic/689
-generic/696
-generic/698
-generic/702
-generic/730
-generic/732
-generic/733
-generic/738
-generic/741
-generic/747
-generic/754
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_lzo.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_lzo.txt
index d13fd089dd70..10f65eeba9ac 100644
--- a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_lzo.txt
+++ b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_lzo.txt
@@ -1,198 +1 @@
-btrfs/011
-btrfs/028
-btrfs/049
-btrfs/121
-btrfs/122
-btrfs/123
-btrfs/149
-btrfs/153
-btrfs/180
-btrfs/181
-btrfs/182
-btrfs/183
-btrfs/187
-btrfs/189
-btrfs/191
-btrfs/193
-btrfs/194
-btrfs/199
-btrfs/200
-btrfs/203
-btrfs/204
-btrfs/205
-btrfs/210
-btrfs/212
-btrfs/213
-btrfs/214
-btrfs/215
-btrfs/217
-btrfs/220
-btrfs/223
-btrfs/226
-btrfs/228
-btrfs/229
-btrfs/242
-btrfs/245
-btrfs/246
-btrfs/251
-btrfs/258
-btrfs/259
-btrfs/263
-btrfs/265
-btrfs/266
-btrfs/267
-btrfs/268
-btrfs/269
-btrfs/279
-btrfs/281
-btrfs/283
-btrfs/285
-btrfs/287
-btrfs/288
-btrfs/289
 btrfs/294
-btrfs/295
-btrfs/297
-btrfs/299
-btrfs/300
-btrfs/310
-btrfs/315
-btrfs/316
-btrfs/319
-btrfs/322
-btrfs/331
-generic/157
-generic/158
-generic/161
-generic/162
-generic/163
-generic/164
-generic/165
-generic/166
-generic/167
-generic/168
-generic/170
-generic/171
-generic/172
-generic/173
-generic/174
-generic/176
-generic/183
-generic/185
-generic/188
-generic/189
-generic/190
-generic/191
-generic/194
-generic/195
-generic/196
-generic/197
-generic/199
-generic/200
-generic/201
-generic/202
-generic/203
-generic/225
-generic/242
-generic/243
-generic/253
-generic/254
-generic/259
-generic/265
-generic/266
-generic/267
-generic/268
-generic/271
-generic/272
-generic/276
-generic/278
-generic/279
-generic/281
-generic/282
-generic/283
-generic/284
-generic/287
-generic/289
-generic/290
-generic/291
-generic/292
-generic/293
-generic/295
-generic/296
-generic/297
-generic/298
-generic/301
-generic/302
-generic/329
-generic/330
-generic/331
-generic/332
-generic/333
-generic/334
-generic/353
-generic/356
-generic/357
-generic/358
-generic/359
-generic/373
-generic/374
-generic/387
-generic/414
-generic/415
-generic/447
-generic/457
-generic/493
-generic/501
-generic/513
-generic/514
-generic/515
-generic/517
-generic/518
-generic/540
-generic/541
-generic/542
-generic/543
-generic/544
-generic/546
-generic/562
-generic/588
-generic/614
-generic/628
-generic/629
-generic/630
-generic/633
-generic/634
-generic/643
-generic/644
-generic/645
-generic/648
-generic/656
-generic/657
-generic/658
-generic/659
-generic/660
-generic/661
-generic/662
-generic/663
-generic/664
-generic/665
-generic/666
-generic/667
-generic/668
-generic/669
-generic/670
-generic/671
-generic/672
-generic/673
-generic/674
-generic/675
-generic/689
-generic/696
-generic/698
-generic/702
-generic/730
-generic/732
-generic/733
-generic/738
-generic/741
-generic/754
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zlib.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zlib.txt
deleted file mode 100644
index 783b30cf033e..000000000000
--- a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zlib.txt
+++ /dev/null
@@ -1,197 +0,0 @@
-btrfs/011
-btrfs/028
-btrfs/049
-btrfs/121
-btrfs/122
-btrfs/123
-btrfs/149
-btrfs/153
-btrfs/180
-btrfs/181
-btrfs/182
-btrfs/183
-btrfs/187
-btrfs/189
-btrfs/191
-btrfs/193
-btrfs/194
-btrfs/199
-btrfs/200
-btrfs/203
-btrfs/204
-btrfs/205
-btrfs/210
-btrfs/212
-btrfs/213
-btrfs/214
-btrfs/215
-btrfs/217
-btrfs/220
-btrfs/223
-btrfs/226
-btrfs/228
-btrfs/229
-btrfs/242
-btrfs/245
-btrfs/246
-btrfs/251
-btrfs/258
-btrfs/259
-btrfs/263
-btrfs/265
-btrfs/266
-btrfs/267
-btrfs/268
-btrfs/269
-btrfs/279
-btrfs/281
-btrfs/283
-btrfs/285
-btrfs/287
-btrfs/288
-btrfs/289
-btrfs/295
-btrfs/297
-btrfs/299
-btrfs/300
-btrfs/310
-btrfs/315
-btrfs/316
-btrfs/319
-btrfs/322
-btrfs/331
-generic/157
-generic/158
-generic/161
-generic/162
-generic/163
-generic/164
-generic/165
-generic/166
-generic/167
-generic/168
-generic/170
-generic/171
-generic/172
-generic/173
-generic/174
-generic/176
-generic/183
-generic/185
-generic/188
-generic/189
-generic/190
-generic/191
-generic/194
-generic/195
-generic/196
-generic/197
-generic/199
-generic/200
-generic/201
-generic/202
-generic/203
-generic/225
-generic/242
-generic/243
-generic/253
-generic/254
-generic/259
-generic/265
-generic/266
-generic/267
-generic/268
-generic/271
-generic/272
-generic/276
-generic/278
-generic/279
-generic/281
-generic/282
-generic/283
-generic/284
-generic/287
-generic/289
-generic/290
-generic/291
-generic/292
-generic/293
-generic/295
-generic/296
-generic/297
-generic/298
-generic/301
-generic/302
-generic/329
-generic/330
-generic/331
-generic/332
-generic/333
-generic/334
-generic/353
-generic/356
-generic/357
-generic/358
-generic/359
-generic/373
-generic/374
-generic/387
-generic/414
-generic/415
-generic/447
-generic/457
-generic/493
-generic/501
-generic/513
-generic/514
-generic/515
-generic/517
-generic/518
-generic/540
-generic/541
-generic/542
-generic/543
-generic/544
-generic/546
-generic/562
-generic/588
-generic/614
-generic/628
-generic/629
-generic/630
-generic/633
-generic/634
-generic/643
-generic/644
-generic/645
-generic/648
-generic/656
-generic/657
-generic/658
-generic/659
-generic/660
-generic/661
-generic/662
-generic/663
-generic/664
-generic/665
-generic/666
-generic/667
-generic/668
-generic/669
-generic/670
-generic/671
-generic/672
-generic/673
-generic/674
-generic/675
-generic/689
-generic/696
-generic/698
-generic/702
-generic/730
-generic/732
-generic/733
-generic/738
-generic/741
-generic/754
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zstd.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zstd.txt
deleted file mode 100644
index 783b30cf033e..000000000000
--- a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_noholes_zstd.txt
+++ /dev/null
@@ -1,197 +0,0 @@
-btrfs/011
-btrfs/028
-btrfs/049
-btrfs/121
-btrfs/122
-btrfs/123
-btrfs/149
-btrfs/153
-btrfs/180
-btrfs/181
-btrfs/182
-btrfs/183
-btrfs/187
-btrfs/189
-btrfs/191
-btrfs/193
-btrfs/194
-btrfs/199
-btrfs/200
-btrfs/203
-btrfs/204
-btrfs/205
-btrfs/210
-btrfs/212
-btrfs/213
-btrfs/214
-btrfs/215
-btrfs/217
-btrfs/220
-btrfs/223
-btrfs/226
-btrfs/228
-btrfs/229
-btrfs/242
-btrfs/245
-btrfs/246
-btrfs/251
-btrfs/258
-btrfs/259
-btrfs/263
-btrfs/265
-btrfs/266
-btrfs/267
-btrfs/268
-btrfs/269
-btrfs/279
-btrfs/281
-btrfs/283
-btrfs/285
-btrfs/287
-btrfs/288
-btrfs/289
-btrfs/295
-btrfs/297
-btrfs/299
-btrfs/300
-btrfs/310
-btrfs/315
-btrfs/316
-btrfs/319
-btrfs/322
-btrfs/331
-generic/157
-generic/158
-generic/161
-generic/162
-generic/163
-generic/164
-generic/165
-generic/166
-generic/167
-generic/168
-generic/170
-generic/171
-generic/172
-generic/173
-generic/174
-generic/176
-generic/183
-generic/185
-generic/188
-generic/189
-generic/190
-generic/191
-generic/194
-generic/195
-generic/196
-generic/197
-generic/199
-generic/200
-generic/201
-generic/202
-generic/203
-generic/225
-generic/242
-generic/243
-generic/253
-generic/254
-generic/259
-generic/265
-generic/266
-generic/267
-generic/268
-generic/271
-generic/272
-generic/276
-generic/278
-generic/279
-generic/281
-generic/282
-generic/283
-generic/284
-generic/287
-generic/289
-generic/290
-generic/291
-generic/292
-generic/293
-generic/295
-generic/296
-generic/297
-generic/298
-generic/301
-generic/302
-generic/329
-generic/330
-generic/331
-generic/332
-generic/333
-generic/334
-generic/353
-generic/356
-generic/357
-generic/358
-generic/359
-generic/373
-generic/374
-generic/387
-generic/414
-generic/415
-generic/447
-generic/457
-generic/493
-generic/501
-generic/513
-generic/514
-generic/515
-generic/517
-generic/518
-generic/540
-generic/541
-generic/542
-generic/543
-generic/544
-generic/546
-generic/562
-generic/588
-generic/614
-generic/628
-generic/629
-generic/630
-generic/633
-generic/634
-generic/643
-generic/644
-generic/645
-generic/648
-generic/656
-generic/657
-generic/658
-generic/659
-generic/660
-generic/661
-generic/662
-generic/663
-generic/664
-generic/665
-generic/666
-generic/667
-generic/668
-generic/669
-generic/670
-generic/671
-generic/672
-generic/673
-generic/674
-generic/675
-generic/689
-generic/696
-generic/698
-generic/702
-generic/730
-generic/732
-generic/733
-generic/738
-generic/741
-generic/754
diff --git a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_simple.txt b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_simple.txt
index 6c7d462916d8..e069a730ae71 100644
--- a/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_simple.txt
+++ b/workflows/fstests/expunges/6.15.0-rc2-g8ffd015db85f/btrfs/unassigned/btrfs_simple.txt
@@ -1,24 +1,6 @@
-btrfs/002
 btrfs/170
-btrfs/220
-btrfs/226
 btrfs/271
-btrfs/300
-btrfs/315
 generic/015
-generic/171
-generic/172
-generic/173
-generic/174
 generic/371
 generic/511
-generic/546
-generic/633
-generic/644
-generic/645
-generic/656
 generic/679
-generic/689
-generic/696
-generic/730
-generic/747
-- 
2.47.2

Obviously we can just use this baseline for future kernels too.

> Another idea is to post only the diff from one week to another, once
> some baseline is established.

Sure, we have support for that. So a git diff after a run would show
only new failures.

> > [0] https://github.com/linux-kdevops/kdevops/blob/main/playbooks/roles/fstests/templates/btrfs/btrfs.config
> > [1] https://github.com/linux-kdevops/kdevops/blob/main/workflows/fstests/btrfs/Kconfig
> 
> There are some configured options that are default, like the
> discard=async, so they can be removed for the configs related to
> mainline.

Your patch has been applied. Let us know how you'd like to proceed with
the expunges.

  Luis

