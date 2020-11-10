Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8C32ADA68
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 16:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgKJP1Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 10:27:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:60552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730231AbgKJP1Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 10:27:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DBFC2ABD1;
        Tue, 10 Nov 2020 15:27:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7255CDA7D7; Tue, 10 Nov 2020 16:25:41 +0100 (CET)
Date:   Tue, 10 Nov 2020 16:25:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Chris Mason <clm@fb.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Petr Malat <oss@malat.biz>,
        Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/9] lib: zstd: Add zstd compatibility wrapper
Message-ID: <20201110152541.GK6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Petr Malat <oss@malat.biz>,
        Johannes Weiner <jweiner@fb.com>, Niket Agarwal <niketa@fb.com>,
        Yann Collet <cyan@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
 <20201103060535.8460-2-nickrterrell@gmail.com>
 <20201106183846.GA28005@infradead.org>
 <D9338FE4-1518-4C7B-8C23-DBDC542DAC35@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9338FE4-1518-4C7B-8C23-DBDC542DAC35@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 09, 2020 at 02:01:41PM -0500, Chris Mason wrote:
> On 6 Nov 2020, at 13:38, Christoph Hellwig wrote:
> > You just keep resedning this crap, don't you?  Haven't you been told
> > multiple times to provide a proper kernel API by now?
> 
> You do consistently ask for a shim layer, but you haven’t explained 
> what we gain by diverging from the documented and tested API of the 
> upstream zstd project.  It’s an important discussion given that we 
> hope to regularly update the kernel side as they make improvements in 
> zstd.
> 
> The only benefit described so far seems to be camelcase related, but if 
> there are problems in the API beyond that, I haven’t seen you describe 
> them.  I don’t think the camelcase alone justifies the added costs of 
> the shim.

The API change in this patchset is adding churn that wouldn't be
necessary if there were an upstream<->kernel API from the beginning.

The patch 5/9 is almost entirely renaming just some internal identifiers

-			      ZSTD_CStreamWorkspaceBound(params.cParams),
-			      ZSTD_DStreamWorkspaceBound(ZSTD_BTRFS_MAX_INPUT));
+			      ZSTD_estimateCStreamSize_usingCParams(params.cParams),
+			      ZSTD_estimateDStreamSize(ZSTD_BTRFS_MAX_INPUT));

plus updating the names in the error strings. The compression API that
filesystems need is simple:

- set up workspace and parameters
- compress buffer
- decompress buffer

We really should not care if upstream has 3 functions for initializing
stream (ZSTD_initCStream/ZSTD_initStaticCStream/ZSTD_initCStream_advanced),
or if the name changes again in the future.

This should not require explicit explanation, this should be a natural
requirement especially for separate projects that don't share the same
coding style but have to be integrated in some way.
