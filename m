Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1941D86256
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbfHHMyc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 08:54:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3935 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732643AbfHHMyb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Aug 2019 08:54:31 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 09FD6F34FF96F504C555;
        Thu,  8 Aug 2019 20:54:28 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 8 Aug 2019 20:54:27 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 8
 Aug 2019 20:54:27 +0800
Date:   Thu, 8 Aug 2019 21:11:39 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Eric Biggers <ebiggers@kernel.org>,
        Goldwyn Rodrigues <RGoldwyn@suse.com>,
        "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <miaoxie@huawei.com>
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190808131139.GH28630@138>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-11-rgoldwyn@suse.de>
 <20190804234321.GC7689@dread.disaster.area>
 <1565021323.13240.14.camel@suse.com>
 <20190805215458.GH7689@dread.disaster.area>
 <20190808042640.GA28630@138>
 <20190808054936.GA5319@sol.localdomain>
 <20190808081647.GI7689@dread.disaster.area>
 <20190808091632.GF28630@138>
 <20190808112139.GG28630@138>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190808112139.GG28630@138>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 08, 2019 at 07:21:39PM +0800, Gao Xiang wrote:
> On Thu, Aug 08, 2019 at 05:29:47PM +0800, Gao Xiang wrote:
> > On Thu, Aug 08, 2019 at 06:16:47PM +1000, Dave Chinner wrote:
> > > On Wed, Aug 07, 2019 at 10:49:36PM -0700, Eric Biggers wrote:
> > > > FWIW, the only order that actually makes sense is decrypt->decompress->verity.
> > > 
> > > *nod*
> > > 
> > > Especially once we get the inline encryption support for fscrypt so
> > > the storage layer can offload the encrypt/decrypt to hardware via
> > > the bio containing plaintext. That pretty much forces fscrypt to be
> > > the lowest layer of the filesystem transformation stack.  This
> > > hardware offload capability also places lots of limits on what you
> > > can do with block-based verity layers below the filesystem. e.g.
> > > using dm-verity when you don't know if there's hardware encryption
> > > below or software encryption on top becomes problematic...
> 
> ...and I'm not talking of fs-verity, I personally think fs-verity
> is great. I am only talking about a generic stuff.
> 
> In order to know which level becomes problematic, there even could
> be another choice "decrypt->verity1->decompress->verity2" for such
> requirement (assuming verity1/2 themselves are absolutely bug-free),
> verity1 can be a strong merkle tree and verity2 is a weak form (just
> like a simple Adler-32/crc32 in compressed block), thus we can locate
> whether it's a decrypt or decompress bug.
> 
> Many compression algorithm containers already have such a weak
> form such as gzip algorithm, so there is no need to add such
> an extra step to postprocess.
> 
> and I have no idea which (decrypt->verity1->decompress->verity2 or
> decrypt->decompress->verity) is faster since verity2 is rather simple.
> However, if we use the only strong form in the end, there could be
> a lot of extra IO and expensive multiple-level computations if files
> are highly compressible.
> 
> On the other hand, such verity2 can be computed offline / avoided
> by fuzzer tools for read-only scenerios (for example, after building
> these images and do a full image verification with the given kernel)
> in order to make sure its stability (In any case, I'm talking about
> how to make those algorithms bug-free).
> 
> All I want to say is I think "decrypt->verity->decompress" is
> reasonable as well.

... And another fundamental concern is that if we don't verify earlier
(I mean on-disk data), then untrusted data will be transformed
(decompressed and even decrypted if no inline encryption) with risk,
and it seems _vulnerable_ if such decrypt / decompress algorithms have
_security issues_ (such as Buffer Overflow). It seems that it's less
security than do verity earlier.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Add a word, I was just talking benefits between "decrypt->decompress->
> > verity" and "decrypt->verity->decompress", I think both forms are
> > compatible with inline en/decryption. I don't care which level
> > "decrypt" is at... But maybe some user cares. Am I missing something?
> > 
> > Thanks,
> > Gao Xiang
> > 
