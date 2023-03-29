Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF64E6CF747
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjC2Xd2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjC2XdZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:33:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7C15FFB
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h8vrIX07Nxyh5sihB/byOpKAC7dPJg8B5qTKtk36rL0=; b=1ZekmuRheMuZO709FNR35pq3lT
        T2l1N5Yfs/DDYB2RMKVcmF47Ym9pHaP3QUuL66ccwM3DdZL1xE1NJHgJfq2kmQWf1KUh+CoKgo95Z
        2hLadeS25yIwnwnmj9Q2bTiRhUoe5jZb0GaRLsbyDlkfznA4lP5TGRieLU6H++2xDLjxbbUXPaHY3
        jmKEyZ5vjd6CzBE8g3bGYWVF+OWLXn9OxF/VqnKMSwJE34IFVkSBN8wV2fpZNYsrvuEyj4VCdGS4d
        uAf5e/Cike23UuVSmSen7wlPAh9fb+ikX7KLq1XUb7rTj3DcpZWVtwFBTohMFJfBkdmZl3LgWn2OP
        wVmfxyYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phfI5-0024KT-1t;
        Wed, 29 Mar 2023 23:33:17 +0000
Date:   Wed, 29 Mar 2023 16:33:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v7 03/13] btrfs: introduce a new helper to submit read
 bio for scrub
Message-ID: <ZCTKvcEccAreV+6g@infradead.org>
References: <cover.1680047473.git.wqu@suse.com>
 <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1680047473.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1680047473.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 29, 2023 at 07:56:10AM +0800, Qu Wenruo wrote:
> The new helper, btrfs_submit_scrub_read(), would be mostly a subset of
> btrfs_submit_bio(), with the following limitations:
> 
> - Only supports read
> - @mirror_num must be > 0
> - No read-time repair nor checksum verification
> - The @bbio must not cross stripe boundary
> 
> This would provide the basis for unified read repair for scrub, as we no
> longer needs to handle RAID56 recovery all by scrub, and RAID56 data
> stripes scrub can share the same code of read and repair.
> 
> The repair part would be the same as non-RAID56, as we only need to try
> the next mirror.

Didn't we just agree that we do not need another magic helper?
