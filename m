Return-Path: <linux-btrfs+bounces-1898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC758840738
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 14:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D361F28AB4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E88A657A9;
	Mon, 29 Jan 2024 13:39:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC0651B3;
	Mon, 29 Jan 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535588; cv=none; b=nSG4J+yua9z+rVB1veTQ7Z35HxyHWKQt2YjfMtppz5mQF2rChX6dvF6n/3rA0A4lY2qVtrVDd2/1FC+qcOHxiPpDfABYbVTZzapOn4wIqTxSezidcn8m2+jqYk+zL9vX21rNRYxQT67PumbIwVoDtYathanNEz9aU2xwYzYhDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535588; c=relaxed/simple;
	bh=7GgA4QJ/YqPaqH3ccxIUzVWWETUQQYIXImwrDLEaRlU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2OAmfkhK49jQ58p4ZAFDhHBGCVAXuUM+xyZWDvjU/mH0NrajPPmPK6ua9ftfvnLXJQ0Yn/jeGkvKRMttGb+20X31DL0CX56UV9tT+/uiKONusb9dEep8Ak1cmS7/VldN+AFKJ3I2pfRa5h/HTee5o5Qb5cRqf5d3Inw273vGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 291C1520165;
	Mon, 29 Jan 2024 14:39:36 +0100 (CET)
Received: from lxhi-087 (10.72.93.211) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Jan
 2024 14:39:35 +0100
Date: Mon, 29 Jan 2024 14:39:31 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: Eugeniu Rosca <erosca@de.adit-jv.com>, <linux-btrfs@vger.kernel.org>,
	<Maksim.Paimushkin@se.bosch.com>, <Matthias.Thomae@de.bosch.com>,
	<Sebastian.Unger@bosch.com>, <Dirk.Behme@de.bosch.com>,
	<Eugeniu.Rosca@bosch.com>, <wqu@suse.com>, <dsterba@suse.com>,
	<stable@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>, Eugeniu Rosca
	<roscaeugeniu@gmail.com>
Subject: Re: [PATCH 0/4 for 5.15 stable] btrfs: some directory fixes for
 stable 5.15
Message-ID: <20240129133931.GA2758728@lxhi-087>
References: <cover.1706183427.git.fdmanana@suse.com>
 <20240126185534.GA2668448@lxhi-087>
 <CAL3q7H5obj92hJ3qc8qUw_9aiMAwiF+RMZhu0M4dGT+hhp6Qsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5obj92hJ3qc8qUw_9aiMAwiF+RMZhu0M4dGT+hhp6Qsg@mail.gmail.com>
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

Hello Filipe,

On Sat, Jan 27, 2024 at 06:02:55PM +0000, Filipe Manana wrote:
> On Fri, Jan 26, 2024 at 6:55 PM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:

[..]

> > PS: Could you help me out how (and if at all possible) to preserve the
> > Author date of the original patch when downloading and applying the
> > 'raw' file provided by https:// lore.kernel.org/
> 
> If I understand you correctly, you applied the diff of patches
> directly with the "patch" command.

Nope. I download the 'raw' patch [0] (assumed to be in mbox format?),
then apply it via 'git am'. This workflow should preserve such patch
metadata like commit description, Author's name/date, etc.

> To get kernel patches and apply them easily, use the b4 tool available at:
> 
> git://git.kernel.org/pub/scm/utils/b4/b4.git

Thanks for sharing. This reminds me of patchwork/pwclient.

I've reapplied the patches using 'b4' and Author's Date of the stable
commits is still altered compared to the vanilla/mainline commits.

For example:
 - Author's date of vanilla [2]: 2023-08-13 12:34:08 +0100 
 - Author's date of stable [1]:  2024-01-25 11:59:35 +0000 

This likely means that the Author's date is amended during
porting/cherry-picking. Of course, this is not a major issue,
but some of us may assume that most of patch metadata (including
Author's date) is preserved on backporting (as best practice).

PS: We can likely skip it, since a number of other patches seem to
alter the Author's date on 5.15 stable tree (~600 out of 21k+ commits).

[1] https:// lore.kernel.org/stable/f1e33797054fcea8b61d88878e67b8c007b5d5f5.1706183427.git.fdmanana@suse.com/raw
[2] https:// git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9b378f6ad48cfa

Thanks,
Eugeniu

