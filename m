Return-Path: <linux-btrfs+bounces-13100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA27A90BFE
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 21:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CC018860A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A441E9B04;
	Wed, 16 Apr 2025 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="SpO+/vZv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XXXCfbT/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7017A302
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830757; cv=none; b=eeocGOtEgbjFaDKbK7VxDWAJBuyGoXrCLK6g5cNBvkWs+b9BVEvk4q2GrUjEdHKk3nNnpe0EkeyOmn5mQ37CzTWQLqWeT+4vtJNKG937oE+01SibqrbSFvz9GkmwmKacvDwe2K0Wa+O/H4eVforQQbQ+GJNYnVo6tPe1fjLMsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830757; c=relaxed/simple;
	bh=Zi5Ps5s/CJDsPJnv5Rkp3ts317uZmMsCJlxf4rxPNrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH+bLf8vSimG+fcMUzQIYzP63ECaYCvca9UNXzSPlUGhZaYX/LDiRW906TxiGyIqV4rPZXjxgC3votMU2IYoeqp4l+EShoBX0XVPFSC5J7qu3fJKQ5T7paMY67rDtZuLM184Iuez9CweSUsIPzYBkKhtPB2M7avKw7nWhbwnjyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=SpO+/vZv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XXXCfbT/; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FC2D11400D9;
	Wed, 16 Apr 2025 15:12:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 16 Apr 2025 15:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1744830754; x=1744917154; bh=Tkdggcayjt
	9zu92LwU2vir7fkNLnbE7bPHSLDVIN8oM=; b=SpO+/vZv5Ab3/dPKGy6bdM7/6t
	We7/Vu0WabC0vPgwOYbkUZgMU51u1/8nJKbDEqEa7Bqf6W7nlUEcSUqwXIBq0U6+
	A0Q9AJHBhVykhS5+TdQvuUpEVNR8fxHKebeyn294W3CKE+Dn0AXZ8i1JkBGMsRVL
	wolMwoqsmly9yxpBJeaYDKDDTyC1O0eyOnyOqaKUBvWA/fSvGc8g5UbgRKLz4cXp
	6nnaH8rmPPzjWD22JKvV7V3Wq9GpTRL5vza2cQd0wGJe4tJowhU1IGeqg1G9V3NQ
	AxguUg1yYbt9qCXlKHKEc5TJosJ275YNbq5guv7DZ4A1CRg42AfB/PsbMGhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744830754; x=1744917154; bh=Tkdggcayjt9zu92LwU2vir7fkNLnbE7bPHS
	LDVIN8oM=; b=XXXCfbT/6WZKXGCkF6PzrZwexxZXZm7tJPr0jYvujV6zX8EgBQu
	vYW3RvmvCGa0+p1HvPau9MBirmMHTqHXJTWSz3jEmO76yyHp0wIXbTcBecpzQWQT
	i3DHdKepxO6y9DmZpq3e3w8bJABRB6yS/oYjSO3Tn0ILj/NXHEoQ4c8P/d5HmpwK
	KJ5xpdZLuJckuEe1j1sbdQeh7hQ+UcxLuClArDu+Gx4o/qiu1cHbwFS6njEg9U/6
	YTTOQkGjWW4jijoQi68kYH1Ar52gJdtnyIxaxVnT39su6CeQX+w61jpRDeXrCa4N
	5n7Is7Ixp6/gMg6wVa8eBWX8PTV7UaAT9Vw==
X-ME-Sender: <xms:IQEAaGHjHDpBo0ZdBeYy3u7Y-RHSsGslarHWHh2oA2aSW8u-euY8zQ>
    <xme:IQEAaHUS-LUHRsNACubnqwldIgbgpHGOw8P5C8dJMzQ6eo9pltDQW-WhxueiJKzWL
    CBWkBeDIhST25_8YEo>
X-ME-Received: <xmr:IQEAaAJSccxOS-0TgJFt32Tb_yM-rfFFLXxzqxKgLdOHH8QI16mXYtcFiEe5L3hfRilamlzqmqjlzLHeHjf06rQO4d8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeelffegveegteeugeeltdeuledutddukeehhfduueehgeef
    veeiheetveeijeeuteenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdr
    ihhopdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hmtghgrhhofheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghlmhesfhgsrdgtohhm
    pdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtoh
    epughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhf
    shesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuggvvhhophhssehlih
    hsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:IQEAaAEjqXZBuqPnm0fun2eO9fPQKEtG-1gG6xzb61yeN_4Z2AXXWA>
    <xmx:IQEAaMWRptpmWeKlUsVl-kVbJ93MGndkmvM6tqjAs6aPWv2BGsd-ig>
    <xmx:IQEAaDOrZXiTP0ptrgdtdmhemlTLwzQY7bYmkWsX1RA_hxcW940W0Q>
    <xmx:IQEAaD1IuxoHp_4_utY-wbC9isq3uLJdBR5JIJCVD4pq3oCConfFbg>
    <xmx:IgEAaFt_6VOPEOLrmZZ4MPPn3cT8WDx9fCamIOOafeYuKOr3fvdDLAD1>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 15:12:33 -0400 (EDT)
Date: Wed, 16 Apr 2025 12:12:53 -0700
From: Boris Burkov <boris@bur.io>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	kdevops@lists.linux.dev
Subject: Re: btrfs v6.15-rc2 baseline
Message-ID: <20250416191253.GA3231475@zen.localdomain>
References: <Z__4Fu6VsCVDFKkO@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z__4Fu6VsCVDFKkO@bombadil.infradead.org>

On Wed, Apr 16, 2025 at 11:33:58AM -0700, Luis Chamberlain wrote:
> btrfs developers,
> 
> kdevops has run fstests on v6.15-rc2 across the different btrfs profiles
> it currently defines, and the results are below.
> 
> The btrfs profiles which kdevops currently supports are:
> 
>   - btrfs_simple
>   - btrfs_nohofspace
>   - btrfs_noholes
>   - btrfs_holes
>   - btrfs_holes_zstd
>   - btrfs_noholes_lzo
>   - btrfs_fspace
>   - btrfs_noholes_zlib
>   - btrfs_noholes_zstd
> 
> These are defined in the btrfs jinja2 template on kdevops [0] and described
> on the ext4 kconfig [1]. Adding support for more profiles is just a matter
> of editing these two files, please feel free to send a patch if you'd like
> kdevops to test more profiles. A full tarball of the fstests results are
> available on kdevops-results-archive [2]. Since we leverage git-lfs, you can
> opt to only download this single tarball as follows:
> 
> GIT_LFS_SKIP_SMUDGE=1 git clone https://github.com/linux-kdevops/kdevops-results-archive.git
> cd kdevops-results-archive
> git lfs fetch --include "fstests/gh/linux-btrfs-kpd/20250416/0001/linux-6-15-rc2/8ffd015db85f.xz"
> git lfs checkout "fstests/gh/linux-btrfs-kpd/20250416/0001/linux-6-15-rc2/8ffd015db85f.xz"
> 
> Few questions:
> 
>  - Is this useful information?

I think this is very useful, thank you for building it and sharing it
with us!

>  - Do you want results for each rc release posted to the mailing list?

I am still getting a hang of how to get at the results, so in my
opinion, sharing an easily digestible update with releases would be
helpful.

> 
> [0] https://github.com/linux-kdevops/kdevops/blob/main/playbooks/roles/fstests/templates/btrfs/btrfs.config
> [1] https://github.com/linux-kdevops/kdevops/blob/main/workflows/fstests/btrfs/Kconfig
> [2] https://github.com/linux-kdevops/kdevops-results-archive/commit/2d206121ed5b5fb1556bbbf08d2d227bae18cbc7
> 
> Detailed test report:
> 
> KERNEL:    6.15.0-rc2-g8ffd015db85f
> CPUS:      8
> MEMORY:    4 GiB
> 
> btrfs_simple: 1064 tests, 24 failures, 244 skipped, 12131 seconds
>   Failures: btrfs/002 btrfs/170 btrfs/220 btrfs/226 btrfs/271
>     btrfs/300 btrfs/315 generic/015 generic/171 generic/172
>     generic/173 generic/174 generic/371 generic/511 generic/546
>     generic/633 generic/644 generic/645 generic/656 generic/679
>     generic/689 generic/696 generic/730 generic/747
> btrfs_nohofspace: 1064 tests, 14 failures, 235 skipped, 13468 seconds
>   Failures: btrfs/002 btrfs/192 btrfs/220 btrfs/226 btrfs/300
>     btrfs/315 generic/633 generic/644 generic/645 generic/656
>     generic/689 generic/696 generic/730 generic/747
> btrfs_noholes: 1064 tests, 193 failures, 235 skipped, 13744 seconds
>   Failures: btrfs/002 btrfs/028 btrfs/049 btrfs/121 btrfs/122
>     btrfs/123 btrfs/126 btrfs/149 btrfs/153 btrfs/156 btrfs/180
>     btrfs/181 btrfs/182 btrfs/183 btrfs/187 btrfs/189 btrfs/191
>     btrfs/193 btrfs/194 btrfs/199 btrfs/200 btrfs/203 btrfs/204
>     btrfs/205 btrfs/210 btrfs/212 btrfs/213 btrfs/214 btrfs/215
>     btrfs/217 btrfs/220 btrfs/223 btrfs/226 btrfs/228 btrfs/229
>     btrfs/242 btrfs/245 btrfs/246 btrfs/251 btrfs/258 btrfs/259
>     btrfs/263 btrfs/279 btrfs/281 btrfs/283 btrfs/285 btrfs/287
>     btrfs/295 btrfs/299 btrfs/300 btrfs/301 btrfs/310 btrfs/315
>     btrfs/316 btrfs/319 btrfs/322 btrfs/331 generic/102 generic/157
>     generic/158 generic/161 generic/162 generic/163 generic/164
>     generic/165 generic/166 generic/167 generic/168 generic/170
>     generic/171 generic/172 generic/173 generic/174 generic/176
>     generic/183 generic/185 generic/188 generic/189 generic/190
>     generic/191 generic/194 generic/195 generic/196 generic/197
>     generic/199 generic/200 generic/201 generic/202 generic/203
>     generic/242 generic/243 generic/253 generic/254 generic/259
>     generic/265 generic/266 generic/267 generic/268 generic/271
>     generic/272 generic/276 generic/278 generic/279 generic/281
>     generic/282 generic/283 generic/284 generic/287 generic/289
>     generic/290 generic/291 generic/292 generic/293 generic/295
>     generic/296 generic/297 generic/298 generic/301 generic/302
>     generic/329 generic/330 generic/331 generic/332 generic/333
>     generic/334 generic/353 generic/356 generic/357 generic/358
>     generic/359 generic/373 generic/374 generic/387 generic/414
>     generic/415 generic/447 generic/457 generic/493 generic/501
>     generic/513 generic/514 generic/515 generic/517 generic/518
>     generic/540 generic/541 generic/542 generic/543 generic/544
>     generic/546 generic/562 generic/588 generic/614 generic/628
>     generic/629 generic/630 generic/633 generic/634 generic/643
>     generic/644 generic/645 generic/648 generic/656 generic/657
>     generic/658 generic/659 generic/660 generic/661 generic/662
>     generic/663 generic/664 generic/665 generic/666 generic/667
>     generic/668 generic/669 generic/670 generic/671 generic/672
>     generic/673 generic/674 generic/675 generic/689 generic/696
>     generic/698 generic/702 generic/730 generic/732 generic/733
>     generic/738 generic/741 generic/747 generic/754
> btrfs_holes: 1064 tests, 192 failures, 235 skipped, 13880 seconds
>   Failures: btrfs/002 btrfs/028 btrfs/049 btrfs/121 btrfs/122
>     btrfs/123 btrfs/126 btrfs/149 btrfs/153 btrfs/156 btrfs/180
>     btrfs/181 btrfs/182 btrfs/183 btrfs/187 btrfs/189 btrfs/191
>     btrfs/193 btrfs/194 btrfs/199 btrfs/200 btrfs/203 btrfs/204
>     btrfs/205 btrfs/210 btrfs/212 btrfs/213 btrfs/214 btrfs/215
>     btrfs/217 btrfs/220 btrfs/223 btrfs/226 btrfs/228 btrfs/229
>     btrfs/242 btrfs/245 btrfs/246 btrfs/251 btrfs/258 btrfs/259
>     btrfs/263 btrfs/279 btrfs/281 btrfs/283 btrfs/285 btrfs/287
>     btrfs/295 btrfs/299 btrfs/300 btrfs/301 btrfs/310 btrfs/315
>     btrfs/316 btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158
>     generic/161 generic/162 generic/163 generic/164 generic/165
>     generic/166 generic/167 generic/168 generic/170 generic/171
>     generic/172 generic/173 generic/174 generic/176 generic/183
>     generic/185 generic/188 generic/189 generic/190 generic/191
>     generic/194 generic/195 generic/196 generic/197 generic/199
>     generic/200 generic/201 generic/202 generic/203 generic/242
>     generic/243 generic/253 generic/254 generic/259 generic/265
>     generic/266 generic/267 generic/268 generic/271 generic/272
>     generic/276 generic/278 generic/279 generic/281 generic/282
>     generic/283 generic/284 generic/287 generic/289 generic/290
>     generic/291 generic/292 generic/293 generic/295 generic/296
>     generic/297 generic/298 generic/301 generic/302 generic/329
>     generic/330 generic/331 generic/332 generic/333 generic/334
>     generic/353 generic/356 generic/357 generic/358 generic/359
>     generic/373 generic/374 generic/387 generic/414 generic/415
>     generic/447 generic/457 generic/493 generic/501 generic/513
>     generic/514 generic/515 generic/517 generic/518 generic/540
>     generic/541 generic/542 generic/543 generic/544 generic/546
>     generic/562 generic/588 generic/614 generic/628 generic/629
>     generic/630 generic/633 generic/634 generic/643 generic/644
>     generic/645 generic/648 generic/656 generic/657 generic/658
>     generic/659 generic/660 generic/661 generic/662 generic/663
>     generic/664 generic/665 generic/666 generic/667 generic/668
>     generic/669 generic/670 generic/671 generic/672 generic/673
>     generic/674 generic/675 generic/689 generic/696 generic/698
>     generic/702 generic/730 generic/732 generic/733 generic/738
>     generic/741 generic/747 generic/754
> btrfs_holes_zstd: 1064 tests, 196 failures, 256 skipped, 15608 seconds
>   Failures: btrfs/011 btrfs/028 btrfs/049 btrfs/121 btrfs/122
>     btrfs/123 btrfs/149 btrfs/153 btrfs/180 btrfs/181 btrfs/182
>     btrfs/183 btrfs/187 btrfs/189 btrfs/191 btrfs/193 btrfs/194
>     btrfs/199 btrfs/200 btrfs/203 btrfs/204 btrfs/205 btrfs/210
>     btrfs/212 btrfs/213 btrfs/214 btrfs/215 btrfs/217 btrfs/220
>     btrfs/223 btrfs/226 btrfs/228 btrfs/229 btrfs/242 btrfs/245
>     btrfs/246 btrfs/251 btrfs/258 btrfs/259 btrfs/263 btrfs/265
>     btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/279 btrfs/281
>     btrfs/283 btrfs/285 btrfs/287 btrfs/288 btrfs/289 btrfs/295
>     btrfs/297 btrfs/299 btrfs/300 btrfs/310 btrfs/315 btrfs/316
>     btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158 generic/161
>     generic/162 generic/163 generic/164 generic/165 generic/166
>     generic/167 generic/168 generic/170 generic/171 generic/172
>     generic/173 generic/174 generic/176 generic/183 generic/185
>     generic/188 generic/189 generic/190 generic/191 generic/194
>     generic/195 generic/196 generic/197 generic/199 generic/200
>     generic/201 generic/202 generic/203 generic/225 generic/242
>     generic/243 generic/253 generic/254 generic/259 generic/265
>     generic/266 generic/267 generic/268 generic/271 generic/272
>     generic/276 generic/278 generic/279 generic/281 generic/282
>     generic/283 generic/284 generic/287 generic/289 generic/290
>     generic/291 generic/292 generic/293 generic/295 generic/296
>     generic/297 generic/298 generic/301 generic/302 generic/329
>     generic/330 generic/331 generic/332 generic/333 generic/334
>     generic/353 generic/356 generic/357 generic/358 generic/359
>     generic/373 generic/374 generic/387 generic/414 generic/415
>     generic/447 generic/493 generic/501 generic/513 generic/514
>     generic/515 generic/517 generic/518 generic/540 generic/541
>     generic/542 generic/543 generic/544 generic/546 generic/562
>     generic/588 generic/614 generic/628 generic/629 generic/630
>     generic/633 generic/634 generic/643 generic/644 generic/645
>     generic/648 generic/656 generic/657 generic/658 generic/659
>     generic/660 generic/661 generic/662 generic/663 generic/664
>     generic/665 generic/666 generic/667 generic/668 generic/669
>     generic/670 generic/671 generic/672 generic/673 generic/674
>     generic/675 generic/689 generic/696 generic/698 generic/702
>     generic/730 generic/732 generic/733 generic/738 generic/741
>     generic/754
> btrfs_noholes_lzo: 1064 tests, 198 failures, 248 skipped, 15934 seconds
>   Failures: btrfs/011 btrfs/028 btrfs/049 btrfs/121 btrfs/122
>     btrfs/123 btrfs/149 btrfs/153 btrfs/180 btrfs/181 btrfs/182
>     btrfs/183 btrfs/187 btrfs/189 btrfs/191 btrfs/193 btrfs/194
>     btrfs/199 btrfs/200 btrfs/203 btrfs/204 btrfs/205 btrfs/210
>     btrfs/212 btrfs/213 btrfs/214 btrfs/215 btrfs/217 btrfs/220
>     btrfs/223 btrfs/226 btrfs/228 btrfs/229 btrfs/242 btrfs/245
>     btrfs/246 btrfs/251 btrfs/258 btrfs/259 btrfs/263 btrfs/265
>     btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/279 btrfs/281
>     btrfs/283 btrfs/285 btrfs/287 btrfs/288 btrfs/289 btrfs/294
>     btrfs/295 btrfs/297 btrfs/299 btrfs/300 btrfs/310 btrfs/315
>     btrfs/316 btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158
>     generic/161 generic/162 generic/163 generic/164 generic/165
>     generic/166 generic/167 generic/168 generic/170 generic/171
>     generic/172 generic/173 generic/174 generic/176 generic/183
>     generic/185 generic/188 generic/189 generic/190 generic/191
>     generic/194 generic/195 generic/196 generic/197 generic/199
>     generic/200 generic/201 generic/202 generic/203 generic/225
>     generic/242 generic/243 generic/253 generic/254 generic/259
>     generic/265 generic/266 generic/267 generic/268 generic/271
>     generic/272 generic/276 generic/278 generic/279 generic/281
>     generic/282 generic/283 generic/284 generic/287 generic/289
>     generic/290 generic/291 generic/292 generic/293 generic/295
>     generic/296 generic/297 generic/298 generic/301 generic/302
>     generic/329 generic/330 generic/331 generic/332 generic/333
>     generic/334 generic/353 generic/356 generic/357 generic/358
>     generic/359 generic/373 generic/374 generic/387 generic/414
>     generic/415 generic/447 generic/457 generic/493 generic/501
>     generic/513 generic/514 generic/515 generic/517 generic/518
>     generic/540 generic/541 generic/542 generic/543 generic/544
>     generic/546 generic/562 generic/588 generic/614 generic/628
>     generic/629 generic/630 generic/633 generic/634 generic/643
>     generic/644 generic/645 generic/648 generic/656 generic/657
>     generic/658 generic/659 generic/660 generic/661 generic/662
>     generic/663 generic/664 generic/665 generic/666 generic/667
>     generic/668 generic/669 generic/670 generic/671 generic/672
>     generic/673 generic/674 generic/675 generic/689 generic/696
>     generic/698 generic/702 generic/730 generic/732 generic/733
>     generic/738 generic/741 generic/754
> btrfs_fspace: 1064 tests, 14 failures, 235 skipped, 16601 seconds
>   Failures: btrfs/002 btrfs/192 btrfs/220 btrfs/226 btrfs/300
>     btrfs/315 generic/633 generic/644 generic/645 generic/656
>     generic/689 generic/696 generic/730 generic/747
> btrfs_noholes_zlib: 1064 tests, 197 failures, 248 skipped, 18301 seconds
>   Failures: btrfs/011 btrfs/028 btrfs/049 btrfs/121 btrfs/122
>     btrfs/123 btrfs/149 btrfs/153 btrfs/180 btrfs/181 btrfs/182
>     btrfs/183 btrfs/187 btrfs/189 btrfs/191 btrfs/193 btrfs/194
>     btrfs/199 btrfs/200 btrfs/203 btrfs/204 btrfs/205 btrfs/210
>     btrfs/212 btrfs/213 btrfs/214 btrfs/215 btrfs/217 btrfs/220
>     btrfs/223 btrfs/226 btrfs/228 btrfs/229 btrfs/242 btrfs/245
>     btrfs/246 btrfs/251 btrfs/258 btrfs/259 btrfs/263 btrfs/265
>     btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/279 btrfs/281
>     btrfs/283 btrfs/285 btrfs/287 btrfs/288 btrfs/289 btrfs/295
>     btrfs/297 btrfs/299 btrfs/300 btrfs/310 btrfs/315 btrfs/316
>     btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158 generic/161
>     generic/162 generic/163 generic/164 generic/165 generic/166
>     generic/167 generic/168 generic/170 generic/171 generic/172
>     generic/173 generic/174 generic/176 generic/183 generic/185
>     generic/188 generic/189 generic/190 generic/191 generic/194
>     generic/195 generic/196 generic/197 generic/199 generic/200
>     generic/201 generic/202 generic/203 generic/225 generic/242
>     generic/243 generic/253 generic/254 generic/259 generic/265
>     generic/266 generic/267 generic/268 generic/271 generic/272
>     generic/276 generic/278 generic/279 generic/281 generic/282
>     generic/283 generic/284 generic/287 generic/289 generic/290
>     generic/291 generic/292 generic/293 generic/295 generic/296
>     generic/297 generic/298 generic/301 generic/302 generic/329
>     generic/330 generic/331 generic/332 generic/333 generic/334
>     generic/353 generic/356 generic/357 generic/358 generic/359
>     generic/373 generic/374 generic/387 generic/414 generic/415
>     generic/447 generic/457 generic/493 generic/501 generic/513
>     generic/514 generic/515 generic/517 generic/518 generic/540
>     generic/541 generic/542 generic/543 generic/544 generic/546
>     generic/562 generic/588 generic/614 generic/628 generic/629
>     generic/630 generic/633 generic/634 generic/643 generic/644
>     generic/645 generic/648 generic/656 generic/657 generic/658
>     generic/659 generic/660 generic/661 generic/662 generic/663
>     generic/664 generic/665 generic/666 generic/667 generic/668
>     generic/669 generic/670 generic/671 generic/672 generic/673
>     generic/674 generic/675 generic/689 generic/696 generic/698
>     generic/702 generic/730 generic/732 generic/733 generic/738
>     generic/741 generic/754
> btrfs_noholes_zstd: 1064 tests, 197 failures, 248 skipped, 27142 seconds
>   Failures: btrfs/011 btrfs/028 btrfs/049 btrfs/121 btrfs/122
>     btrfs/123 btrfs/149 btrfs/153 btrfs/180 btrfs/181 btrfs/182
>     btrfs/183 btrfs/187 btrfs/189 btrfs/191 btrfs/193 btrfs/194
>     btrfs/199 btrfs/200 btrfs/203 btrfs/204 btrfs/205 btrfs/210
>     btrfs/212 btrfs/213 btrfs/214 btrfs/215 btrfs/217 btrfs/220
>     btrfs/223 btrfs/226 btrfs/228 btrfs/229 btrfs/242 btrfs/245
>     btrfs/246 btrfs/251 btrfs/258 btrfs/259 btrfs/263 btrfs/265
>     btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/279 btrfs/281
>     btrfs/283 btrfs/285 btrfs/287 btrfs/288 btrfs/289 btrfs/295
>     btrfs/297 btrfs/299 btrfs/300 btrfs/310 btrfs/315 btrfs/316
>     btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158 generic/161
>     generic/162 generic/163 generic/164 generic/165 generic/166
>     generic/167 generic/168 generic/170 generic/171 generic/172
>     generic/173 generic/174 generic/176 generic/183 generic/185
>     generic/188 generic/189 generic/190 generic/191 generic/194
>     generic/195 generic/196 generic/197 generic/199 generic/200
>     generic/201 generic/202 generic/203 generic/225 generic/242
>     generic/243 generic/253 generic/254 generic/259 generic/265
>     generic/266 generic/267 generic/268 generic/271 generic/272
>     generic/276 generic/278 generic/279 generic/281 generic/282
>     generic/283 generic/284 generic/287 generic/289 generic/290
>     generic/291 generic/292 generic/293 generic/295 generic/296
>     generic/297 generic/298 generic/301 generic/302 generic/329
>     generic/330 generic/331 generic/332 generic/333 generic/334
>     generic/353 generic/356 generic/357 generic/358 generic/359
>     generic/373 generic/374 generic/387 generic/414 generic/415
>     generic/447 generic/457 generic/493 generic/501 generic/513
>     generic/514 generic/515 generic/517 generic/518 generic/540
>     generic/541 generic/542 generic/543 generic/544 generic/546
>     generic/562 generic/588 generic/614 generic/628 generic/629
>     generic/630 generic/633 generic/634 generic/643 generic/644
>     generic/645 generic/648 generic/656 generic/657 generic/658
>     generic/659 generic/660 generic/661 generic/662 generic/663
>     generic/664 generic/665 generic/666 generic/667 generic/668
>     generic/669 generic/670 generic/671 generic/672 generic/673
>     generic/674 generic/675 generic/689 generic/696 generic/698
>     generic/702 generic/730 generic/732 generic/733 generic/738
>     generic/741 generic/754
> Totals: 9576 tests, 2184 skipped, 1225 failures, 0 errors, 137340s

I'm surprised to see every profile that mentions holes/noholes has
hundreds of matching errors, while others that don't explicitly
configure them are fine. There are only two options, so you would think
that either "holes" or "noholes" would behave the same as
simple/fspace/etc..

It could be a good exercise for me to learn about the tooling to look
into what's going on...

Thanks,
Boris

