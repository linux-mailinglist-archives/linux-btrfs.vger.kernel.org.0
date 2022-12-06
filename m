Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658AE643EF5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiLFIpQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiLFIpO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:45:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E5A1277E
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zpnWCBOJEs8on2WpsCOYW4qfQNBmMQIb7442xJbV1W0=; b=EY8MqMpVbirGilkRwNLHcvZ+gt
        Cp5eA5N6UN1mprR+U4l9VEATENUBcyxWBWEPdEMt72MKdBzCi7Ucy0v4DIfGpO63KbbX7fuwUXG25
        Voe4diyS3yaS6j61KW3+wlDBW2zrvPhrI3lGPsxzHovGQIgVp4URGvka66doJ3LIKqRePONCTIRuI
        rikP/qmvLE2u+5LUpeMmSNiSAb4o9uRZxVZNU+00EMl98teaL3WPI6BmXdyg5HH7l4WJ9ezL/eux6
        jPtLomVq6rScCLYPUb2XM5Y+uwiexS83j7lRKJhr9fap4UTJsKw5VEN1+YpQnfuuNNMfhNK/xm0vk
        LfXAoOfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2TZg-0057aw-Tu; Tue, 06 Dec 2022 08:45:12 +0000
Date:   Tue, 6 Dec 2022 00:45:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PoC PATCH 05/11] btrfs: scrub: add a writeback helper for
 scrub2_stripe
Message-ID: <Y48BGK3BDxSvsqiV@infradead.org>
References: <cover.1670314744.git.wqu@suse.com>
 <1e92cdad3b60464ed6f1cf4c0a24cac7d270e3ef.1670314744.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e92cdad3b60464ed6f1cf4c0a24cac7d270e3ef.1670314744.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> +static void scrub2_write_endio(struct btrfs_bio *bbio)
> +{
> +	struct scrub2_stripe *stripe = bbio->private;
> +	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
> +	struct bio_vec *first_bvec = bio_first_bvec_all(&bbio->bio);
> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +	unsigned long flags;
> +	int bio_size = 0;
> +	int first_sector_nr;
> +	int i;
> +
> +	bio_for_each_segment_all(bvec, &bbio->bio, iter_all)
> +		bio_size += bvec->bv_len;

If you use bio_for_each_bvec_all instead the loop will be significantly
cheaper.
