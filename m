Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868632DCA80
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 02:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbgLQBYP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 20:24:15 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:47793 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbgLQBYP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 20:24:15 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CxDlk0Rxjz63;
        Thu, 17 Dec 2020 02:23:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1608168212; bh=xW9ibLoV5/qLNGN3Busmpz2Fsg3WeYdpFtrM6aESBL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0QsVj+LedvuKyx7KZpPQpw/FaclNAFrecY5kvlTJPqc3hYXnLY7op+/R4JKKwzDF
         ecWxaZk85UXkipmWiu3WwIoa/34ijll1c4Ngi+s3cv69sH0T1McNVJBKLGObCRXzpH
         Jc5sXYV/LlIoS8hF/K6iOIvo6Ao6HNI661kpnm0A7SSzIMH6G+R8ZIfES4MKDY1r9m
         YTolpcJL32aBuI62lC7xiIntdYzi+kFihpB5y/tgq/67LV/cyol3x5aVHUxOh+cqLo
         HQDZEaBtrtIWxCvaz1hyzR5Xvs2NUwWZTjiZDF4cPyy0vuCpkz+K+Qj4lm/PcwXW3R
         6vAZMtyNYVphQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Thu, 17 Dec 2020 02:23:38 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Nick Terrell <terrelln@fb.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        Christoph Hellwig <hch@infradead.org>,
        Yann Collet <cyan@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Petr Malat <oss@malat.biz>, Chris Mason <clm@fb.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Niket Agarwal <niketa@fb.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [f2fs-dev] [PATCH v7 0/3] Update to zstd-1.4.6
Message-ID: <20201217012337.GA24705@qmqm.qmqm.pl>
References: <20201203205114.1395668-1-nickrterrell@gmail.com>
 <DF6B2E26-2D6E-44FF-89DB-93A37E2EA268@fb.com>
 <X9lOHkAE67EP/sXo@sol.localdomain>
 <B3F00261-E977-4B85-84CD-66B07DA79D9D@fb.com>
 <20201216005806.GA26841@gondor.apana.org.au>
 <20201216185052.GL6430@twin.jikos.cz>
 <6C449BCE-E7DB-4EE6-B4F5-FED3977BD8F0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6C449BCE-E7DB-4EE6-B4F5-FED3977BD8F0@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 10:07:38PM +0000, Nick Terrell wrote:
[...]
> It is very large. If it helps, in the commit message I’ve provided this link [0],
> which provides the diff between upstream zstd as-is and the imported zstd,
> which has been modified by the automated tooling to work in the kernel.
> [0] https://github.com/terrelln/linux/commit/ac2ee65dcb7318afe426ad08f6a844faf3aebb41

I looks like you could remove a bit more dead code by noting __GNUC__ >= 4
(gcc-4.9 is currently the oldest supported [1]).

[1] Documentation/process/changes.rst

Best Regards
Michał Mirosław
