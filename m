Return-Path: <linux-btrfs+bounces-4235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 784F68A40CC
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 09:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86569B2112A
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1691CFB2;
	Sun, 14 Apr 2024 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rU8wBHUm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A317993;
	Sun, 14 Apr 2024 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713078533; cv=none; b=mZJRzwDdihvuMLItevOCphsZt00nd8hBP7ZqYCXiCCTZ84G7jLqiosSkrF91T8v9+NVx50qj6FvXyuvWGKHNme5ZULrTnjAoTdQPkgcAw9p4ECPHFPVhIucDvm7LE+2Otnw0jnsMRJhy4Kc5Ku2jsA0JDk+p6zbJxlghzoVv/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713078533; c=relaxed/simple;
	bh=N3Nya+tvso6CKI4ALDzKMfaWynHcIK4227O3j2Akc+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMo3PnQnZpGr4ChyJX/sawACfT/TBKa7XpFOlcu48czF8HfEBN+pJp3V7AAjzCUh+7PYLMXPHj5jCBfEEj1tDJNIyEM3jp4PQa1rbUkk/zUnsfCDrZvffwAT4f7WrVFk0p17puB0L03fsU359cU5O/Wf04Dt6P3mTj2GM36cU30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rU8wBHUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4043C072AA;
	Sun, 14 Apr 2024 07:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713078532;
	bh=N3Nya+tvso6CKI4ALDzKMfaWynHcIK4227O3j2Akc+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rU8wBHUmyFRUEZtDYsJOHT+BJc6FdkottwQeGOcR306tLhi+6ZAqMYGYvw02/VfEI
	 V/But10QLtJpxwOA95NAwM7FYGrQMkN61tfT7npbdOpqd+9RWF9Hg6gPfCZ2I79Et6
	 GLtCy90PbnFgafdcGBBMG0zJ8nYHzNka1j11nnE32ryH2VqbeyqUp5q0F0ujyM+1UV
	 TjL1ZLXdz/gTuOv4yEYPSTWwOzxOj4DBtcEJ3mK5ddVx2dtwtZyUoY+y/a5APlBKI8
	 2KukD1YWItIEfGOLBqHxM8u9ng30+9B3ZjlXpTiDGzj1BtgzfFyjdfj1l+zOC2Q6Cm
	 TmtszShv4jsIw==
Date: Sun, 14 Apr 2024 15:08:48 +0800
From: Zorro Lang <zlang@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes staged-20240414
Message-ID: <20240414070848.cpr4micelcs24qsw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240414011212.1297-1-anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414011212.1297-1-anand.jain@oracle.com>

On Sun, Apr 14, 2024 at 09:12:02AM +0800, Anand Jain wrote:
> Please pull this branch containing changes as below.
> These patches are on top of my last PR branch staged-20240403.
> 
> Thank you.
> 
> The following changes since commit 8aab1f1663031cccb326ffbcb087b81bfb629df8:
> 
>   common/btrfs: lookup running processes using pgrep (2024-04-03 15:09:01 +0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/asj/fstests.git staged-20240414

Hi Anand,

I've nearly done the upcoming fstests release of this weekend, I generally start
my testing jobs on Friday night, and done on Sunday. So, sorry, this PR missed
this merge window, I'll push them in next release if you don't mind. Or if some
patches are hurry to be merged, I can increase an extra release in the middle of
next week.

Thanks,
Zorro

> 
> for you to fetch changes up to 943bbbc1ce0a3f8af862a7f9f11ecec00146edfe:
> 
>   btrfs: remove useless comments (2024-04-14 08:38:14 +0800)
> 
> ----------------------------------------------------------------
> Anand Jain (5):
>       generic: move btrfs clone device testcase to the generic group
>       common/btrfs: refactor _require_btrfs_corrupt_block to check option
>       btrfs/290: fix btrfs_corrupt_block options
>       common/verity: fix btrfs-corrupt-block -v option
>       btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME
> 
> Boris Burkov (1):
>       btrfs: new test for devt change between mounts
> 
> David Sterba (1):
>       btrfs: remove useless comments
> 
> Josef Bacik (3):
>       fstests: change btrfs/197 and btrfs/198 golden output
>       fstests: change how we test for supported raid configs
>       fstests: update tests to skip unsupported raid profile types
> 
>  common/btrfs          |  45 +++++++++++++--
>  common/config         |   1 +
>  common/rc             |  14 +++++
>  common/verity         |   5 +-
>  tests/btrfs/001       |   2 -
>  tests/btrfs/002       |   2 -
>  tests/btrfs/003       |   1 -
>  tests/btrfs/004       |   2 -
>  tests/btrfs/005       |   2 -
>  tests/btrfs/006       |   4 --
>  tests/btrfs/007       |   2 -
>  tests/btrfs/008       |   2 -
>  tests/btrfs/009       |   2 -
>  tests/btrfs/011       |   2 -
>  tests/btrfs/012       |   4 --
>  tests/btrfs/013       |   2 -
>  tests/btrfs/014       |   2 -
>  tests/btrfs/015       |   2 -
>  tests/btrfs/016       |   2 -
>  tests/btrfs/017       |   3 -
>  tests/btrfs/018       |   2 -
>  tests/btrfs/019       |   2 -
>  tests/btrfs/020       |   2 -
>  tests/btrfs/021       |   2 -
>  tests/btrfs/022       |   1 -
>  tests/btrfs/023       |   2 -
>  tests/btrfs/024       |   2 -
>  tests/btrfs/025       |   2 -
>  tests/btrfs/026       |   2 -
>  tests/btrfs/027       |   3 -
>  tests/btrfs/028       |   2 -
>  tests/btrfs/029       |   2 -
>  tests/btrfs/030       |   2 -
>  tests/btrfs/031       |   2 -
>  tests/btrfs/032       |   2 -
>  tests/btrfs/033       |   2 -
>  tests/btrfs/034       |   2 -
>  tests/btrfs/035       |   2 -
>  tests/btrfs/036       |   2 -
>  tests/btrfs/037       |   2 -
>  tests/btrfs/038       |   2 -
>  tests/btrfs/039       |   2 -
>  tests/btrfs/040       |   2 -
>  tests/btrfs/041       |   2 -
>  tests/btrfs/042       |   1 -
>  tests/btrfs/043       |   2 -
>  tests/btrfs/044       |   2 -
>  tests/btrfs/045       |   2 -
>  tests/btrfs/046       |   2 -
>  tests/btrfs/047       |   3 -
>  tests/btrfs/048       |   2 -
>  tests/btrfs/049       |   2 -
>  tests/btrfs/050       |   2 -
>  tests/btrfs/051       |   2 -
>  tests/btrfs/052       |   2 -
>  tests/btrfs/053       |   2 -
>  tests/btrfs/054       |   2 -
>  tests/btrfs/055       |   2 -
>  tests/btrfs/056       |   2 -
>  tests/btrfs/057       |   2 -
>  tests/btrfs/058       |   2 -
>  tests/btrfs/059       |   2 -
>  tests/btrfs/060       |   2 -
>  tests/btrfs/061       |   2 -
>  tests/btrfs/062       |   2 -
>  tests/btrfs/063       |   2 -
>  tests/btrfs/064       |   2 -
>  tests/btrfs/065       |   2 -
>  tests/btrfs/066       |   2 -
>  tests/btrfs/067       |   2 -
>  tests/btrfs/068       |   2 -
>  tests/btrfs/069       |   2 -
>  tests/btrfs/070       |   2 -
>  tests/btrfs/071       |   2 -
>  tests/btrfs/072       |   2 -
>  tests/btrfs/073       |   2 -
>  tests/btrfs/074       |   2 -
>  tests/btrfs/075       |   2 -
>  tests/btrfs/076       |   2 -
>  tests/btrfs/077       |   2 -
>  tests/btrfs/078       |   2 -
>  tests/btrfs/079       |   2 -
>  tests/btrfs/080       |   2 -
>  tests/btrfs/081       |   2 -
>  tests/btrfs/082       |   2 -
>  tests/btrfs/083       |   2 -
>  tests/btrfs/084       |   2 -
>  tests/btrfs/085       |   2 -
>  tests/btrfs/086       |   2 -
>  tests/btrfs/087       |   2 -
>  tests/btrfs/088       |   2 -
>  tests/btrfs/089       |   4 --
>  tests/btrfs/090       |   4 --
>  tests/btrfs/091       |   3 -
>  tests/btrfs/092       |   2 -
>  tests/btrfs/093       |   2 -
>  tests/btrfs/094       |   2 -
>  tests/btrfs/095       |   2 -
>  tests/btrfs/096       |   2 -
>  tests/btrfs/097       |   2 -
>  tests/btrfs/098       |   2 -
>  tests/btrfs/099       |   3 -
>  tests/btrfs/100       |   1 -
>  tests/btrfs/101       |   1 -
>  tests/btrfs/102       |   2 -
>  tests/btrfs/103       |   2 -
>  tests/btrfs/104       |   2 -
>  tests/btrfs/105       |   2 -
>  tests/btrfs/106       |   2 -
>  tests/btrfs/107       |   3 -
>  tests/btrfs/108       |   2 -
>  tests/btrfs/109       |   2 -
>  tests/btrfs/110       |   2 -
>  tests/btrfs/111       |   2 -
>  tests/btrfs/112       |   2 -
>  tests/btrfs/113       |   2 -
>  tests/btrfs/114       |   2 -
>  tests/btrfs/115       |   2 -
>  tests/btrfs/116       |   2 -
>  tests/btrfs/117       |   2 -
>  tests/btrfs/118       |   2 -
>  tests/btrfs/119       |   2 -
>  tests/btrfs/120       |   2 -
>  tests/btrfs/121       |   2 -
>  tests/btrfs/122       |   2 -
>  tests/btrfs/123       |   4 --
>  tests/btrfs/124       |   3 -
>  tests/btrfs/125       |  11 ++--
>  tests/btrfs/126       |   4 --
>  tests/btrfs/127       |   2 -
>  tests/btrfs/128       |   2 -
>  tests/btrfs/129       |   2 -
>  tests/btrfs/130       |   4 --
>  tests/btrfs/131       |   3 -
>  tests/btrfs/132       |   4 --
>  tests/btrfs/133       |   2 -
>  tests/btrfs/134       |   2 -
>  tests/btrfs/135       |   2 -
>  tests/btrfs/136       |   4 --
>  tests/btrfs/137       |   2 -
>  tests/btrfs/138       |   3 -
>  tests/btrfs/139       |   1 -
>  tests/btrfs/140       |   4 --
>  tests/btrfs/141       |   4 --
>  tests/btrfs/142       |   4 --
>  tests/btrfs/143       |   4 --
>  tests/btrfs/144       |   2 -
>  tests/btrfs/145       |   2 -
>  tests/btrfs/146       |   2 -
>  tests/btrfs/147       |   2 -
>  tests/btrfs/148       |   5 +-
>  tests/btrfs/149       |   2 -
>  tests/btrfs/150       |   4 --
>  tests/btrfs/151       |   4 --
>  tests/btrfs/152       |   2 -
>  tests/btrfs/153       |   4 --
>  tests/btrfs/154       |   3 -
>  tests/btrfs/155       |   2 -
>  tests/btrfs/156       |   4 --
>  tests/btrfs/157       |   6 +-
>  tests/btrfs/158       |   6 +-
>  tests/btrfs/159       |   2 -
>  tests/btrfs/160       |   2 -
>  tests/btrfs/161       |   4 --
>  tests/btrfs/162       |   4 --
>  tests/btrfs/163       |   4 --
>  tests/btrfs/164       |   3 -
>  tests/btrfs/165       |   2 -
>  tests/btrfs/166       |   2 -
>  tests/btrfs/167       |   4 --
>  tests/btrfs/168       |   2 -
>  tests/btrfs/169       |   2 -
>  tests/btrfs/170       |   2 -
>  tests/btrfs/171       |   2 -
>  tests/btrfs/172       |   4 --
>  tests/btrfs/176       |   4 --
>  tests/btrfs/177       |   1 -
>  tests/btrfs/178       |   2 -
>  tests/btrfs/179       |   4 --
>  tests/btrfs/180       |   4 --
>  tests/btrfs/181       |   4 --
>  tests/btrfs/182       |   4 --
>  tests/btrfs/183       |   2 -
>  tests/btrfs/184       |   2 -
>  tests/btrfs/185       |   2 -
>  tests/btrfs/186       |   2 -
>  tests/btrfs/187       |   2 -
>  tests/btrfs/188       |   2 -
>  tests/btrfs/189       |   2 -
>  tests/btrfs/190       |   4 --
>  tests/btrfs/191       |   2 -
>  tests/btrfs/192       |   4 --
>  tests/btrfs/193       |   4 --
>  tests/btrfs/194       |   4 --
>  tests/btrfs/195       |   4 --
>  tests/btrfs/196       |   4 --
>  tests/btrfs/197       |  30 +++++-----
>  tests/btrfs/197.out   |  25 +--------
>  tests/btrfs/198       |  29 ++++++----
>  tests/btrfs/198.out   |  25 +--------
>  tests/btrfs/199       |   4 --
>  tests/btrfs/200       |   2 -
>  tests/btrfs/201       |   2 -
>  tests/btrfs/203       |   2 -
>  tests/btrfs/204       |   4 --
>  tests/btrfs/205       |   2 -
>  tests/btrfs/206       |   2 -
>  tests/btrfs/207       |   1 -
>  tests/btrfs/208       |   2 -
>  tests/btrfs/209       |   2 -
>  tests/btrfs/210       |   4 --
>  tests/btrfs/211       |   2 -
>  tests/btrfs/212       |   4 --
>  tests/btrfs/213       |   2 -
>  tests/btrfs/214       |   3 -
>  tests/btrfs/215       |   3 -
>  tests/btrfs/216       |   2 -
>  tests/btrfs/217       |   4 --
>  tests/btrfs/218       |   4 --
>  tests/btrfs/219       |   3 -
>  tests/btrfs/220       |   2 -
>  tests/btrfs/221       |   2 -
>  tests/btrfs/222       |   2 -
>  tests/btrfs/223       |   2 -
>  tests/btrfs/224       |   4 --
>  tests/btrfs/225       |   4 --
>  tests/btrfs/226       |   2 -
>  tests/btrfs/227       |   2 -
>  tests/btrfs/228       |   4 --
>  tests/btrfs/229       |   2 -
>  tests/btrfs/230       |   3 -
>  tests/btrfs/231       |   2 -
>  tests/btrfs/232       |   3 -
>  tests/btrfs/233       |   2 -
>  tests/btrfs/234       |   2 -
>  tests/btrfs/235       |   2 -
>  tests/btrfs/236       |   2 -
>  tests/btrfs/237       |   3 -
>  tests/btrfs/238       |   4 --
>  tests/btrfs/239       |   2 -
>  tests/btrfs/240       |   2 -
>  tests/btrfs/241       |   2 -
>  tests/btrfs/242       |   2 -
>  tests/btrfs/243       |   2 -
>  tests/btrfs/244       |   6 --
>  tests/btrfs/245       |   3 -
>  tests/btrfs/246       |   2 -
>  tests/btrfs/247       |   4 --
>  tests/btrfs/248       |   6 --
>  tests/btrfs/249       |   6 --
>  tests/btrfs/250       |   3 -
>  tests/btrfs/251       |   4 --
>  tests/btrfs/252       |   2 -
>  tests/btrfs/254       |   2 -
>  tests/btrfs/255       |   1 -
>  tests/btrfs/256       |   3 -
>  tests/btrfs/257       |   4 --
>  tests/btrfs/258       |   3 -
>  tests/btrfs/259       |   4 --
>  tests/btrfs/260       |   4 --
>  tests/btrfs/262       |   3 -
>  tests/btrfs/263       |   4 --
>  tests/btrfs/264       |   3 -
>  tests/btrfs/265       |   3 -
>  tests/btrfs/266       |   3 -
>  tests/btrfs/267       |   3 -
>  tests/btrfs/272       |   1 -
>  tests/btrfs/273       |   3 -
>  tests/btrfs/275       |   2 -
>  tests/btrfs/277       |   4 --
>  tests/btrfs/278       |   1 -
>  tests/btrfs/282       |   1 -
>  tests/btrfs/284       |   1 -
>  tests/btrfs/286       |   4 --
>  tests/btrfs/288       |   4 --
>  tests/btrfs/289       |   3 -
>  tests/btrfs/290       |  27 +++++----
>  tests/btrfs/291       |   2 -
>  tests/btrfs/292       |   4 --
>  tests/btrfs/294       |   4 --
>  tests/btrfs/296       |   1 -
>  tests/btrfs/297       |  10 ++++
>  tests/btrfs/299       |   2 -
>  tests/btrfs/301       |   4 --
>  tests/btrfs/310       |   6 --
>  tests/btrfs/311       |   1 -
>  tests/btrfs/312       | 153 ++++++++++++++++++++++++++++++--------------------
>  tests/btrfs/312.out   |  19 +------
>  tests/btrfs/320       |   1 -
>  tests/generic/744     |  87 ++++++++++++++++++++++++++++
>  tests/generic/744.out |   4 ++
>  291 files changed, 310 insertions(+), 876 deletions(-)
>  create mode 100755 tests/generic/744
>  create mode 100644 tests/generic/744.out
> 

