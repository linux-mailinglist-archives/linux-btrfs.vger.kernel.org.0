Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A302B753C77
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 16:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbjGNOE1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 10:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjGNOE0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 10:04:26 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BBB1989
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 07:04:25 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so2740664276.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689343464; x=1691935464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y8+BhEL8RnkKw96YPHGDTH38KMuT8mzwPDPVUKwQ4A=;
        b=bIgU9Y+6IdkCiD2l2X0DmfrFypiOKUz/1SaVgeO+CcDjuBKrYLWgGFMmd9zbwHtBV4
         5/Bt7yXowAj7ZWPrk5tTfAU7CvGub+Wr96LsAfF+dLoUKIufISIqf8Ln1RzaBsqcXWz0
         QuTsC0JSLiB9NF0G1fgnUskpOE4bN4248QSy0WFPUwte0UVPTBBTG2V5BJ2rtchLF6rz
         bSoVdr9Fi+W+SYP3Xw8BBEAO+g1bE9LCAkeTbZgiVfi831dm1i+rEeW46vAxDTJkvkuc
         FIkVoVt1ptzSlR7QTlVoJNzrbIJ9azeqDggjyRur3QxzlslF4M8GvtGWxZbPJ9kHpJ+k
         f8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343464; x=1691935464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y8+BhEL8RnkKw96YPHGDTH38KMuT8mzwPDPVUKwQ4A=;
        b=VPEWX6OuQE7HXJdiEarvZanN7n2f40LeXmEF1La8A0EDG8lOaJ3P7IxeB1TC1OdJBT
         5bhwQ6zhYbh9fjpYXnrTeEB+uvTFfDqWvxSCqTlqM8jvs9OYh++SxZ0NuJrk5hBF2v0l
         B/kb5dLlKlgfofHfTPTDjA0nY2MyZOpTtXZi0vTBEj/1H/m7sZpe48nuJ304Ym3OMN6Z
         845yaiKTPK5jDbMlsrTbM8vp9+ieS5BosXG9cVodRwTdc0ngkXW3XAaZI7xsqrmtLZqA
         TQ6ENpnkJxkcHMV7aalGogGD86GdPmFXEP4Jy1Ek/76Nrk0DZ+aB9liXRpxaOELF7KNB
         XurA==
X-Gm-Message-State: ABy/qLZxv9/yDb6iwtDCFC1OOOMMu4BKSIYrE7TRoNTw89GYfUycQ9Qd
        /NTPb6EzjxB0LmjVGoOqP9IbQw==
X-Google-Smtp-Source: APBJJlFY34u4qQK9l1T4L6ZcNnpIw16AYn1D3YZMJsLisQ3tmqpCVTXdSo79cbDp/afdZBEP+Edyog==
X-Received: by 2002:a25:b098:0:b0:c5d:a805:eebd with SMTP id f24-20020a25b098000000b00c5da805eebdmr3196745ybj.7.1689343464285;
        Fri, 14 Jul 2023 07:04:24 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y18-20020a259292000000b00be45a29d440sm1772335ybl.12.2023.07.14.07.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:04:23 -0700 (PDT)
Date:   Fri, 14 Jul 2023 10:04:23 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        syzbot <syzbot+5b82f0e951f8c2bcdb8f@syzkaller.appspotmail.com>
Subject: Re: [PATCH] btrfs: fix ordered extent split error handling in
 btrfs_dio_submit_io
Message-ID: <20230714140423.GB466183@perftesting>
References: <20230714084241.548739-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714084241.548739-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 14, 2023 at 10:42:41AM +0200, Christoph Hellwig wrote:
> When the call to btrfs_extract_ordered_extent in btrfs_dio_submit_io
> fails to allocate memory for a new ordered_extent, it calls into the
> btrfs_dio_end_io for error handling.  btrfs_dio_end_io then assumes that
> bbio->ordered is set because it is supposed to be at this point, except
> for this error handling corner case.  Try to not overload the
> btrfs_dio_end_io with error handling of a bio in a non-canonical state,
> and instead call btrfs_finish_ordered_extent and iomap_dio_bio_end_io
> directly for this error case.
> 
> Fixes: b41b6f6937dc ("btrfs: use btrfs_finish_ordered_extent to complete direct writes")
> Reported-by: syzbot <syzbot+5b82f0e951f8c2bcdb8f@syzkaller.appspotmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: syzbot <syzbot+5b82f0e951f8c2bcdb8f@syzkaller.appspotmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
