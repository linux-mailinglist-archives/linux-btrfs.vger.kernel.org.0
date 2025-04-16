Return-Path: <linux-btrfs+bounces-13098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1DAA90B5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 20:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12B43BEB4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 18:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B4F2222B0;
	Wed, 16 Apr 2025 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROhJ+boW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3011FF1B0;
	Wed, 16 Apr 2025 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828442; cv=none; b=dexFhjnEcuQpjJYvAzIRReZw3TurlusomhCt3O7IZsvBamOYZV2Ca4tXWSP9tOmppQGvLQsM/PrbpB8oVnA+F6CyVM5f8GFpi0ONxIpLl4+wVRb7SkLSuZzsSk1CHDe/ppVfJjtRCoPuSgmPKtBvmMWJCNQKTzs55wRcqlECM2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828442; c=relaxed/simple;
	bh=BWuOJQMeHSFiznPdOZGOPnhZsUG2DL4galQMKawYWWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jqtjL8KTFRheMD0vpx9g0J8E9nnoKTKIw/LbUKutPRil9E04GljAImvmgtdzCiFs9Eu7qgO1jzaaWdMqcIDxtq78LWkwQSEwU4rJ5xChOiMpLqHKLR5yb1+T61i8HAivmCvoVf34gm9rTnUcUrq3ck36T7vj2gX+oEXa5ApBmMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROhJ+boW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E6EC4CEE4;
	Wed, 16 Apr 2025 18:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744828440;
	bh=BWuOJQMeHSFiznPdOZGOPnhZsUG2DL4galQMKawYWWg=;
	h=Date:From:To:Cc:Subject:From;
	b=ROhJ+boWjvGP51bEOvmn01koFYD5GgbSTCqOm5z6de29xbUG8CGzdL2OpsOnbcDay
	 uYNU/OTHgpI17ddmUWWJdFn7pS1a6M/2UmffTeOj//WDMYfjkWj/ROY0EHJSr8fUdJ
	 MKTSKxXge/en+lGmr+nZt1jlesu9OO6sg9S9kAvMoPpBSSoPHrV67Pz1I1rQy9UF2o
	 JMVHL1m36408r1UmUaKje8gHCffqIt2V1Wvu+mshkoIxqnWYlOIk64+pZ2ZI9oaPaQ
	 O6na7QqFTGpwztlPUv/sYuOoIjSngBCu0c9T9Z5Xlnd7nm6mbUr+gj4etWCklQuZGW
	 5IaJS+zWRh5hA==
Date: Wed, 16 Apr 2025 11:33:58 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc: kdevops@lists.linux.dev, mcgrof@kernel.org
Subject: btrfs v6.15-rc2 baseline
Message-ID: <Z__4Fu6VsCVDFKkO@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

btrfs developers,

kdevops has run fstests on v6.15-rc2 across the different btrfs profiles
it currently defines, and the results are below.

The btrfs profiles which kdevops currently supports are:

  - btrfs_simple
  - btrfs_nohofspace
  - btrfs_noholes
  - btrfs_holes
  - btrfs_holes_zstd
  - btrfs_noholes_lzo
  - btrfs_fspace
  - btrfs_noholes_zlib
  - btrfs_noholes_zstd

These are defined in the btrfs jinja2 template on kdevops [0] and described
on the ext4 kconfig [1]. Adding support for more profiles is just a matter
of editing these two files, please feel free to send a patch if you'd like
kdevops to test more profiles. A full tarball of the fstests results are
available on kdevops-results-archive [2]. Since we leverage git-lfs, you can
opt to only download this single tarball as follows:

GIT_LFS_SKIP_SMUDGE=1 git clone https://github.com/linux-kdevops/kdevops-results-archive.git
cd kdevops-results-archive
git lfs fetch --include "fstests/gh/linux-btrfs-kpd/20250416/0001/linux-6-15-rc2/8ffd015db85f.xz"
git lfs checkout "fstests/gh/linux-btrfs-kpd/20250416/0001/linux-6-15-rc2/8ffd015db85f.xz"

Few questions:

 - Is this useful information?
 - Do you want results for each rc release posted to the mailing list?

[0] https://github.com/linux-kdevops/kdevops/blob/main/playbooks/roles/fstests/templates/btrfs/btrfs.config
[1] https://github.com/linux-kdevops/kdevops/blob/main/workflows/fstests/btrfs/Kconfig
[2] https://github.com/linux-kdevops/kdevops-results-archive/commit/2d206121ed5b5fb1556bbbf08d2d227bae18cbc7

Detailed test report:

KERNEL:    6.15.0-rc2-g8ffd015db85f
CPUS:      8
MEMORY:    4 GiB

btrfs_simple: 1064 tests, 24 failures, 244 skipped, 12131 seconds
  Failures: btrfs/002 btrfs/170 btrfs/220 btrfs/226 btrfs/271
    btrfs/300 btrfs/315 generic/015 generic/171 generic/172
    generic/173 generic/174 generic/371 generic/511 generic/546
    generic/633 generic/644 generic/645 generic/656 generic/679
    generic/689 generic/696 generic/730 generic/747
btrfs_nohofspace: 1064 tests, 14 failures, 235 skipped, 13468 seconds
  Failures: btrfs/002 btrfs/192 btrfs/220 btrfs/226 btrfs/300
    btrfs/315 generic/633 generic/644 generic/645 generic/656
    generic/689 generic/696 generic/730 generic/747
btrfs_noholes: 1064 tests, 193 failures, 235 skipped, 13744 seconds
  Failures: btrfs/002 btrfs/028 btrfs/049 btrfs/121 btrfs/122
    btrfs/123 btrfs/126 btrfs/149 btrfs/153 btrfs/156 btrfs/180
    btrfs/181 btrfs/182 btrfs/183 btrfs/187 btrfs/189 btrfs/191
    btrfs/193 btrfs/194 btrfs/199 btrfs/200 btrfs/203 btrfs/204
    btrfs/205 btrfs/210 btrfs/212 btrfs/213 btrfs/214 btrfs/215
    btrfs/217 btrfs/220 btrfs/223 btrfs/226 btrfs/228 btrfs/229
    btrfs/242 btrfs/245 btrfs/246 btrfs/251 btrfs/258 btrfs/259
    btrfs/263 btrfs/279 btrfs/281 btrfs/283 btrfs/285 btrfs/287
    btrfs/295 btrfs/299 btrfs/300 btrfs/301 btrfs/310 btrfs/315
    btrfs/316 btrfs/319 btrfs/322 btrfs/331 generic/102 generic/157
    generic/158 generic/161 generic/162 generic/163 generic/164
    generic/165 generic/166 generic/167 generic/168 generic/170
    generic/171 generic/172 generic/173 generic/174 generic/176
    generic/183 generic/185 generic/188 generic/189 generic/190
    generic/191 generic/194 generic/195 generic/196 generic/197
    generic/199 generic/200 generic/201 generic/202 generic/203
    generic/242 generic/243 generic/253 generic/254 generic/259
    generic/265 generic/266 generic/267 generic/268 generic/271
    generic/272 generic/276 generic/278 generic/279 generic/281
    generic/282 generic/283 generic/284 generic/287 generic/289
    generic/290 generic/291 generic/292 generic/293 generic/295
    generic/296 generic/297 generic/298 generic/301 generic/302
    generic/329 generic/330 generic/331 generic/332 generic/333
    generic/334 generic/353 generic/356 generic/357 generic/358
    generic/359 generic/373 generic/374 generic/387 generic/414
    generic/415 generic/447 generic/457 generic/493 generic/501
    generic/513 generic/514 generic/515 generic/517 generic/518
    generic/540 generic/541 generic/542 generic/543 generic/544
    generic/546 generic/562 generic/588 generic/614 generic/628
    generic/629 generic/630 generic/633 generic/634 generic/643
    generic/644 generic/645 generic/648 generic/656 generic/657
    generic/658 generic/659 generic/660 generic/661 generic/662
    generic/663 generic/664 generic/665 generic/666 generic/667
    generic/668 generic/669 generic/670 generic/671 generic/672
    generic/673 generic/674 generic/675 generic/689 generic/696
    generic/698 generic/702 generic/730 generic/732 generic/733
    generic/738 generic/741 generic/747 generic/754
btrfs_holes: 1064 tests, 192 failures, 235 skipped, 13880 seconds
  Failures: btrfs/002 btrfs/028 btrfs/049 btrfs/121 btrfs/122
    btrfs/123 btrfs/126 btrfs/149 btrfs/153 btrfs/156 btrfs/180
    btrfs/181 btrfs/182 btrfs/183 btrfs/187 btrfs/189 btrfs/191
    btrfs/193 btrfs/194 btrfs/199 btrfs/200 btrfs/203 btrfs/204
    btrfs/205 btrfs/210 btrfs/212 btrfs/213 btrfs/214 btrfs/215
    btrfs/217 btrfs/220 btrfs/223 btrfs/226 btrfs/228 btrfs/229
    btrfs/242 btrfs/245 btrfs/246 btrfs/251 btrfs/258 btrfs/259
    btrfs/263 btrfs/279 btrfs/281 btrfs/283 btrfs/285 btrfs/287
    btrfs/295 btrfs/299 btrfs/300 btrfs/301 btrfs/310 btrfs/315
    btrfs/316 btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158
    generic/161 generic/162 generic/163 generic/164 generic/165
    generic/166 generic/167 generic/168 generic/170 generic/171
    generic/172 generic/173 generic/174 generic/176 generic/183
    generic/185 generic/188 generic/189 generic/190 generic/191
    generic/194 generic/195 generic/196 generic/197 generic/199
    generic/200 generic/201 generic/202 generic/203 generic/242
    generic/243 generic/253 generic/254 generic/259 generic/265
    generic/266 generic/267 generic/268 generic/271 generic/272
    generic/276 generic/278 generic/279 generic/281 generic/282
    generic/283 generic/284 generic/287 generic/289 generic/290
    generic/291 generic/292 generic/293 generic/295 generic/296
    generic/297 generic/298 generic/301 generic/302 generic/329
    generic/330 generic/331 generic/332 generic/333 generic/334
    generic/353 generic/356 generic/357 generic/358 generic/359
    generic/373 generic/374 generic/387 generic/414 generic/415
    generic/447 generic/457 generic/493 generic/501 generic/513
    generic/514 generic/515 generic/517 generic/518 generic/540
    generic/541 generic/542 generic/543 generic/544 generic/546
    generic/562 generic/588 generic/614 generic/628 generic/629
    generic/630 generic/633 generic/634 generic/643 generic/644
    generic/645 generic/648 generic/656 generic/657 generic/658
    generic/659 generic/660 generic/661 generic/662 generic/663
    generic/664 generic/665 generic/666 generic/667 generic/668
    generic/669 generic/670 generic/671 generic/672 generic/673
    generic/674 generic/675 generic/689 generic/696 generic/698
    generic/702 generic/730 generic/732 generic/733 generic/738
    generic/741 generic/747 generic/754
btrfs_holes_zstd: 1064 tests, 196 failures, 256 skipped, 15608 seconds
  Failures: btrfs/011 btrfs/028 btrfs/049 btrfs/121 btrfs/122
    btrfs/123 btrfs/149 btrfs/153 btrfs/180 btrfs/181 btrfs/182
    btrfs/183 btrfs/187 btrfs/189 btrfs/191 btrfs/193 btrfs/194
    btrfs/199 btrfs/200 btrfs/203 btrfs/204 btrfs/205 btrfs/210
    btrfs/212 btrfs/213 btrfs/214 btrfs/215 btrfs/217 btrfs/220
    btrfs/223 btrfs/226 btrfs/228 btrfs/229 btrfs/242 btrfs/245
    btrfs/246 btrfs/251 btrfs/258 btrfs/259 btrfs/263 btrfs/265
    btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/279 btrfs/281
    btrfs/283 btrfs/285 btrfs/287 btrfs/288 btrfs/289 btrfs/295
    btrfs/297 btrfs/299 btrfs/300 btrfs/310 btrfs/315 btrfs/316
    btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158 generic/161
    generic/162 generic/163 generic/164 generic/165 generic/166
    generic/167 generic/168 generic/170 generic/171 generic/172
    generic/173 generic/174 generic/176 generic/183 generic/185
    generic/188 generic/189 generic/190 generic/191 generic/194
    generic/195 generic/196 generic/197 generic/199 generic/200
    generic/201 generic/202 generic/203 generic/225 generic/242
    generic/243 generic/253 generic/254 generic/259 generic/265
    generic/266 generic/267 generic/268 generic/271 generic/272
    generic/276 generic/278 generic/279 generic/281 generic/282
    generic/283 generic/284 generic/287 generic/289 generic/290
    generic/291 generic/292 generic/293 generic/295 generic/296
    generic/297 generic/298 generic/301 generic/302 generic/329
    generic/330 generic/331 generic/332 generic/333 generic/334
    generic/353 generic/356 generic/357 generic/358 generic/359
    generic/373 generic/374 generic/387 generic/414 generic/415
    generic/447 generic/493 generic/501 generic/513 generic/514
    generic/515 generic/517 generic/518 generic/540 generic/541
    generic/542 generic/543 generic/544 generic/546 generic/562
    generic/588 generic/614 generic/628 generic/629 generic/630
    generic/633 generic/634 generic/643 generic/644 generic/645
    generic/648 generic/656 generic/657 generic/658 generic/659
    generic/660 generic/661 generic/662 generic/663 generic/664
    generic/665 generic/666 generic/667 generic/668 generic/669
    generic/670 generic/671 generic/672 generic/673 generic/674
    generic/675 generic/689 generic/696 generic/698 generic/702
    generic/730 generic/732 generic/733 generic/738 generic/741
    generic/754
btrfs_noholes_lzo: 1064 tests, 198 failures, 248 skipped, 15934 seconds
  Failures: btrfs/011 btrfs/028 btrfs/049 btrfs/121 btrfs/122
    btrfs/123 btrfs/149 btrfs/153 btrfs/180 btrfs/181 btrfs/182
    btrfs/183 btrfs/187 btrfs/189 btrfs/191 btrfs/193 btrfs/194
    btrfs/199 btrfs/200 btrfs/203 btrfs/204 btrfs/205 btrfs/210
    btrfs/212 btrfs/213 btrfs/214 btrfs/215 btrfs/217 btrfs/220
    btrfs/223 btrfs/226 btrfs/228 btrfs/229 btrfs/242 btrfs/245
    btrfs/246 btrfs/251 btrfs/258 btrfs/259 btrfs/263 btrfs/265
    btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/279 btrfs/281
    btrfs/283 btrfs/285 btrfs/287 btrfs/288 btrfs/289 btrfs/294
    btrfs/295 btrfs/297 btrfs/299 btrfs/300 btrfs/310 btrfs/315
    btrfs/316 btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158
    generic/161 generic/162 generic/163 generic/164 generic/165
    generic/166 generic/167 generic/168 generic/170 generic/171
    generic/172 generic/173 generic/174 generic/176 generic/183
    generic/185 generic/188 generic/189 generic/190 generic/191
    generic/194 generic/195 generic/196 generic/197 generic/199
    generic/200 generic/201 generic/202 generic/203 generic/225
    generic/242 generic/243 generic/253 generic/254 generic/259
    generic/265 generic/266 generic/267 generic/268 generic/271
    generic/272 generic/276 generic/278 generic/279 generic/281
    generic/282 generic/283 generic/284 generic/287 generic/289
    generic/290 generic/291 generic/292 generic/293 generic/295
    generic/296 generic/297 generic/298 generic/301 generic/302
    generic/329 generic/330 generic/331 generic/332 generic/333
    generic/334 generic/353 generic/356 generic/357 generic/358
    generic/359 generic/373 generic/374 generic/387 generic/414
    generic/415 generic/447 generic/457 generic/493 generic/501
    generic/513 generic/514 generic/515 generic/517 generic/518
    generic/540 generic/541 generic/542 generic/543 generic/544
    generic/546 generic/562 generic/588 generic/614 generic/628
    generic/629 generic/630 generic/633 generic/634 generic/643
    generic/644 generic/645 generic/648 generic/656 generic/657
    generic/658 generic/659 generic/660 generic/661 generic/662
    generic/663 generic/664 generic/665 generic/666 generic/667
    generic/668 generic/669 generic/670 generic/671 generic/672
    generic/673 generic/674 generic/675 generic/689 generic/696
    generic/698 generic/702 generic/730 generic/732 generic/733
    generic/738 generic/741 generic/754
btrfs_fspace: 1064 tests, 14 failures, 235 skipped, 16601 seconds
  Failures: btrfs/002 btrfs/192 btrfs/220 btrfs/226 btrfs/300
    btrfs/315 generic/633 generic/644 generic/645 generic/656
    generic/689 generic/696 generic/730 generic/747
btrfs_noholes_zlib: 1064 tests, 197 failures, 248 skipped, 18301 seconds
  Failures: btrfs/011 btrfs/028 btrfs/049 btrfs/121 btrfs/122
    btrfs/123 btrfs/149 btrfs/153 btrfs/180 btrfs/181 btrfs/182
    btrfs/183 btrfs/187 btrfs/189 btrfs/191 btrfs/193 btrfs/194
    btrfs/199 btrfs/200 btrfs/203 btrfs/204 btrfs/205 btrfs/210
    btrfs/212 btrfs/213 btrfs/214 btrfs/215 btrfs/217 btrfs/220
    btrfs/223 btrfs/226 btrfs/228 btrfs/229 btrfs/242 btrfs/245
    btrfs/246 btrfs/251 btrfs/258 btrfs/259 btrfs/263 btrfs/265
    btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/279 btrfs/281
    btrfs/283 btrfs/285 btrfs/287 btrfs/288 btrfs/289 btrfs/295
    btrfs/297 btrfs/299 btrfs/300 btrfs/310 btrfs/315 btrfs/316
    btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158 generic/161
    generic/162 generic/163 generic/164 generic/165 generic/166
    generic/167 generic/168 generic/170 generic/171 generic/172
    generic/173 generic/174 generic/176 generic/183 generic/185
    generic/188 generic/189 generic/190 generic/191 generic/194
    generic/195 generic/196 generic/197 generic/199 generic/200
    generic/201 generic/202 generic/203 generic/225 generic/242
    generic/243 generic/253 generic/254 generic/259 generic/265
    generic/266 generic/267 generic/268 generic/271 generic/272
    generic/276 generic/278 generic/279 generic/281 generic/282
    generic/283 generic/284 generic/287 generic/289 generic/290
    generic/291 generic/292 generic/293 generic/295 generic/296
    generic/297 generic/298 generic/301 generic/302 generic/329
    generic/330 generic/331 generic/332 generic/333 generic/334
    generic/353 generic/356 generic/357 generic/358 generic/359
    generic/373 generic/374 generic/387 generic/414 generic/415
    generic/447 generic/457 generic/493 generic/501 generic/513
    generic/514 generic/515 generic/517 generic/518 generic/540
    generic/541 generic/542 generic/543 generic/544 generic/546
    generic/562 generic/588 generic/614 generic/628 generic/629
    generic/630 generic/633 generic/634 generic/643 generic/644
    generic/645 generic/648 generic/656 generic/657 generic/658
    generic/659 generic/660 generic/661 generic/662 generic/663
    generic/664 generic/665 generic/666 generic/667 generic/668
    generic/669 generic/670 generic/671 generic/672 generic/673
    generic/674 generic/675 generic/689 generic/696 generic/698
    generic/702 generic/730 generic/732 generic/733 generic/738
    generic/741 generic/754
btrfs_noholes_zstd: 1064 tests, 197 failures, 248 skipped, 27142 seconds
  Failures: btrfs/011 btrfs/028 btrfs/049 btrfs/121 btrfs/122
    btrfs/123 btrfs/149 btrfs/153 btrfs/180 btrfs/181 btrfs/182
    btrfs/183 btrfs/187 btrfs/189 btrfs/191 btrfs/193 btrfs/194
    btrfs/199 btrfs/200 btrfs/203 btrfs/204 btrfs/205 btrfs/210
    btrfs/212 btrfs/213 btrfs/214 btrfs/215 btrfs/217 btrfs/220
    btrfs/223 btrfs/226 btrfs/228 btrfs/229 btrfs/242 btrfs/245
    btrfs/246 btrfs/251 btrfs/258 btrfs/259 btrfs/263 btrfs/265
    btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/279 btrfs/281
    btrfs/283 btrfs/285 btrfs/287 btrfs/288 btrfs/289 btrfs/295
    btrfs/297 btrfs/299 btrfs/300 btrfs/310 btrfs/315 btrfs/316
    btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158 generic/161
    generic/162 generic/163 generic/164 generic/165 generic/166
    generic/167 generic/168 generic/170 generic/171 generic/172
    generic/173 generic/174 generic/176 generic/183 generic/185
    generic/188 generic/189 generic/190 generic/191 generic/194
    generic/195 generic/196 generic/197 generic/199 generic/200
    generic/201 generic/202 generic/203 generic/225 generic/242
    generic/243 generic/253 generic/254 generic/259 generic/265
    generic/266 generic/267 generic/268 generic/271 generic/272
    generic/276 generic/278 generic/279 generic/281 generic/282
    generic/283 generic/284 generic/287 generic/289 generic/290
    generic/291 generic/292 generic/293 generic/295 generic/296
    generic/297 generic/298 generic/301 generic/302 generic/329
    generic/330 generic/331 generic/332 generic/333 generic/334
    generic/353 generic/356 generic/357 generic/358 generic/359
    generic/373 generic/374 generic/387 generic/414 generic/415
    generic/447 generic/457 generic/493 generic/501 generic/513
    generic/514 generic/515 generic/517 generic/518 generic/540
    generic/541 generic/542 generic/543 generic/544 generic/546
    generic/562 generic/588 generic/614 generic/628 generic/629
    generic/630 generic/633 generic/634 generic/643 generic/644
    generic/645 generic/648 generic/656 generic/657 generic/658
    generic/659 generic/660 generic/661 generic/662 generic/663
    generic/664 generic/665 generic/666 generic/667 generic/668
    generic/669 generic/670 generic/671 generic/672 generic/673
    generic/674 generic/675 generic/689 generic/696 generic/698
    generic/702 generic/730 generic/732 generic/733 generic/738
    generic/741 generic/754
Totals: 9576 tests, 2184 skipped, 1225 failures, 0 errors, 137340s

