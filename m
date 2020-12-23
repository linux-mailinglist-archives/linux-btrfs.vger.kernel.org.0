Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0925D2E21C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Dec 2020 21:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgLWU6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Dec 2020 15:58:03 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:39024 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbgLWU6C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Dec 2020 15:58:02 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1ksBBa-0002fP-D7; Thu, 24 Dec 2020 07:56:43 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 24 Dec 2020 07:56:42 +1100
Date:   Thu, 24 Dec 2020 07:56:42 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Ignat Korchagin <ignat@cloudflare.com>, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, dm-crypt@saout.de,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org,
        Damien.LeMoal@wdc.com, mpatocka@redhat.com,
        kernel-team@cloudflare.com, nobuto.murata@canonical.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-crypto <linux-crypto@vger.kernel.org>
Subject: Re: dm-crypt with no_read_workqueue and no_write_workqueue + btrfs
 scrub = BUG()
Message-ID: <20201223205642.GA19817@gondor.apana.org.au>
References: <16ffadab-42ba-f9c7-8203-87fda3dc9b44@maciej.szmigiero.name>
 <74c7129b-a437-ebc4-1466-7fb9f034e006@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74c7129b-a437-ebc4-1466-7fb9f034e006@maciej.szmigiero.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 23, 2020 at 04:37:34PM +0100, Maciej S. Szmigiero wrote:
> 
> It looks like to me that the skcipher API might not be safe to
> call from a softirq context, after all.

skcipher is safe to use in a softirq.  The problem is only in
dm-crypt where it tries to allocate memory with GFP_NOIO.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
