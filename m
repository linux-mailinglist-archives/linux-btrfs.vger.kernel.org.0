Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597E11B39BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 10:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgDVINm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 04:13:42 -0400
Received: from mail.nic.cz ([217.31.204.67]:52098 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgDVINm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 04:13:42 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 2F2DF13FFC7;
        Wed, 22 Apr 2020 10:13:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587543218; bh=4INkE3lEbGim19iC6CUmUMxzSDaBvFzpYReIR167Lz8=;
        h=Date:From:To;
        b=k0clgnIE31kB0an+HO3FzLQCu8aMU7iJKeG/WvXPf3JG5KOCnIjJqplDz1dlKvcg3
         2gCxe2YE/8Bjv2Pqem3fD3aNSBSEII7RrEQ8hpHYjIAUzSvlUgmBcUR//Aodh8gdKi
         dwIkrPPgB7S0beuHUlSKlUVksza9C7hvKWwfWGMk=
Date:   Wed, 22 Apr 2020 10:13:37 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
Subject: Re: [PATCH U-BOOT 00/26] fs: btrfs: Re-implement btrfs support
 using the more widely used extent buffer base code
Message-ID: <20200422101337.6b7883b5@nic.cz>
In-Reply-To: <20200422065009.69392-1-wqu@suse.com>
References: <20200422065009.69392-1-wqu@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just for informational purposes for others:

I tested compiling with and without this patches to see how much it
increases binary size.

		Omnia (armv7a)		Mox (aarch64)
with old btrfs	52900 (51.7 KB)		55456 (54.2 KB)
with new btrfs	76176 (74.4 KB)		75480 (73.7 KB)
diff		23276 (22.7 KB)		20024 (19.5 KB)
increase driver	   44%			   36%
increase u-boot	    3.46%		    2.81%

(I don't actually care much, this is not too much, this is something
that can maybe be reduced by using some optimizations which u-boot does
not support yet and also there should be enough storage for u-boot on
Mox and Omnia. But maybe someone else will care enough.)
