Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9C672F43F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 07:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbjFNFob (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 01:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjFNFo3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 01:44:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3225619B5
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 22:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YHsXMm/dFei8UoTOkEraa2TV6hPowbwT02mR8Bc7T1Q=; b=Pq0EoWgUNLwag34S4DQ4DBNmw0
        40guG5tCbpBJIeGyo34fbvrOKMvvl+D98DivBD+tvzZeDVBhSwSBaBAulPKnJXlcezXtNI5ENQr2m
        /0tgV37l3PSx+ySjqdYgmEiGnboI5btQut9lrXE6uQhhudSqv8NrQh+s22sInM3ijuASFXSPC5GOP
        mEDk120+YSOGlsUnZP5l/DjKEj3GkgwAC5IAIayxmDy8oMdJIezslhB41EWsJvUKwb3E/uvM4lw2w
        FDms/CHKTs+ANFKnDtlDkSmQEZMMa2Hf6Q71yeuRF1O/+Dzlmb/I5RKICYip5a6U3qHfKmiBcRJf3
        KTTwDYSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9JIx-00AGgG-2R;
        Wed, 14 Jun 2023 05:44:27 +0000
Date:   Tue, 13 Jun 2023 22:44:27 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: do not limit delalloc size to
 fs_info->max_extent_size
Message-ID: <ZIlTu1GtnyDs/EPP@infradead.org>
References: <a2f4a2162fdc3457830fa997c70ffa7c231759ad.1686582572.git.naohiro.aota@wdc.com>
 <ZIf74wFg7NmvmQxn@infradead.org>
 <jmbvm4co36av23vly5e45hhyeth42ebl5ulqc7uw5cc6qdu6bf@x7i66logd62j>
 <bvtfl35llmzudy6lpiaqlw62n2wctgfy26ejwcqtnl3aoagisq@waq5rpmq7d6u>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bvtfl35llmzudy6lpiaqlw62n2wctgfy26ejwcqtnl3aoagisq@waq5rpmq7d6u>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 14, 2023 at 01:59:35AM +0000, Naohiro Aota wrote:
> On Tue, Jun 13, 2023 at 02:53:04PM +0900, Naohiro Aota wrote:
> > On Mon, Jun 12, 2023 at 10:17:23PM -0700, Christoph Hellwig wrote:
> > > On Tue, Jun 13, 2023 at 12:10:29AM +0900, Naohiro Aota wrote:
> > > > This patch reverts the delalloc size to BTRFS_MAX_EXTENT_SIZE, as it does
> > > > not directly corresponds to the size of one extent. Instead, this patch
> > > > will limit the allocation size at cow_file_range() for the zoned mode.
> > > 
> > > Maybe I'm missing something, but that limitation also seems wrong or at
> > > least suboptimal.  There is absolutely no problem in creating a large
> > > allocation in cow_file_range.  btrfs_submit_bio will split it into max
> > > appens size chunks for I/O, and depending on if they got reordered or
> > > not we might even be able to record the entire big allocation as a
> > > single extent on disk.
> > > 
> > 
> > The issue corresponds to per-inode metadata reservation pool. For each
> > outstanding extent, it reserves 16 * node_size to insert the extent item
> > considering the worst case.
> > 
> > If we allocate one large extent, it releases the unnecessary bytes from the
> > pool as it thinks it will only do only one insertion. Then, that extent is
> > split again, and it inserts several extents. For that insertion, btrfs
> > consumes the reserved bytes from the per-inode pool, which is now ready
> > only for one extent. So, with a big filesystem and a large extent write
> > out, we can exhaust that pool and hit a WARN.
> > 
> > And, re-charging the pool on split time is impossible, I think... But,
> > things might change as we moved the split time.
> 
> I'm considering this again. We need to take care of the reservation pool to
> ensure metadata insertion will succeed.
> 
> But, if we can keep the reservation pool for N (= delalloc size /
> fs_info->max_extent_size) extents even the allocation is done for single
> extent, the reservation should be OK and we can allocate one large extent.
> 
> So, I'm testing the patch below on top of current misc-next.

I like the idea, but we need to be very careful to not run into rounding
errors for the nr reserved extents calculation.  Maybe we should store
the number of reserved extents in the ordered_extent, and then steal
one for each split and justreturn the ones accounted for the
ordered_extent when removing it?
