Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223F16D741A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 08:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbjDEGEk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 02:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDEGEi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 02:04:38 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C82173A;
        Tue,  4 Apr 2023 23:04:36 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pjwFg-00CU7i-9v; Wed, 05 Apr 2023 14:04:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 05 Apr 2023 14:04:12 +0800
Date:   Wed, 5 Apr 2023 14:04:12 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 2/2] libcrc32c: remove crc32c_impl
Message-ID: <ZC0PXBnNulTC7Xqn@gondor.apana.org.au>
References: <20230405054905.94678-1-hch@lst.de>
 <20230405054905.94678-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405054905.94678-3-hch@lst.de>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 05, 2023 at 07:49:05AM +0200, Christoph Hellwig wrote:
> This was only ever used by btrfs, and the btrfs users just went away.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/crc32c.h | 1 -
>  lib/libcrc32c.c        | 6 ------
>  2 files changed, 7 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
