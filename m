Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F05B5FB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiILSBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 14:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiILSBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 14:01:10 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDB9205C9
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 11:01:05 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id m9so7332714qvv.7
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 11:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9NDLgJv81qDlmsbCqx0zaBw+dTw0IfMxx+BzSwncN4U=;
        b=XNXa2dw02L9YHbweIccMWix2OA/noxvHr6/50a/GgzjKrUmgCjOXfJQ+IHme1Lt3L+
         BlcMAoTF3VvUU8z7sodYbG5PxWcR8bxdvzmbI93CFKrvWOBnNZNjeAi+Snyvye0Lfq0q
         YIpwRxfQLMjtJw5UixOmSar9auRhLLLB3IgRd1To+P/6ZQqoeiJWbGqoq6I7eEFHJr+1
         6kR4mRC/b48HyGzhsWl24HTmuY8MB5aUitm+GzY8wpd7yGYu3+mxwsxuMm5P1PXwpSfj
         XEqo48JtsTGhOlxx/Kz13+hdDAyJSVfZsuAvTujIcT/xVbX7IkXPsG3vYisw38eyi9uO
         8AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9NDLgJv81qDlmsbCqx0zaBw+dTw0IfMxx+BzSwncN4U=;
        b=I5EJ316ZXK1qV41uW/hN4s1rpDkvakYRXHc1iBALmrJu/eltjw2+ddKlM8cVe28Pm5
         42JCzR0R0nrHNec1dwioNLba5o1coyeE3TXc9ippWbfVdIOAbxd4CUc4ltVHDkJAG6im
         3Kwz0RSYfWt0F1wBlEYXaNxKE5/BFPJ1lafxV4sxO7tmD+K7LXDD5hMAaclK9z8b6KAP
         Ci4lSb1Qbm0xzm1M58QMDnMHq+x+beQ370VycBxZHkH3I6Mx9jdjOMpEskDv1CDZueaB
         IvsD4NF/lLzrkJBz35gzcAVGrqCQxcxiRbHBLrpJjjihoDp/taXuzM+JE/97JxxoQ0UK
         cflw==
X-Gm-Message-State: ACgBeo2geGrtNgMLiDdswQP5olIFDKlI52PyitNbcjo8knsIJVtimBzW
        L0rgHmfO1NZskP+k/GBudonbQg==
X-Google-Smtp-Source: AA6agR5Y+0ImGJsE0Xx2C5HvKYuWUUDFWOeMLkcoKzJuf9B8u2w5d7CJrCPvx6e7yZ0m1q72w5LhJw==
X-Received: by 2002:a0c:914e:0:b0:479:58a9:d4c1 with SMTP id q72-20020a0c914e000000b0047958a9d4c1mr24654127qvq.86.1663005664196;
        Mon, 12 Sep 2022 11:01:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 16-20020a370a10000000b006b949afa980sm7369343qkk.56.2022.09.12.11.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:01:03 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:01:01 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 01/36] btrfs: rename clean_io_failure and remove
 extraneous args
Message-ID: <Yx9z3bAkEanf1D5e@localhost.localdomain>
References: <cover.1662760286.git.josef@toxicpanda.com>
 <f09c896c9cf29af6c9aab11a760fec372f77551e.1662760286.git.josef@toxicpanda.com>
 <Yx89bhyk7wrrmWox@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx89bhyk7wrrmWox@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 12, 2022 at 07:08:46AM -0700, Christoph Hellwig wrote:
> On Fri, Sep 09, 2022 at 05:53:14PM -0400, Josef Bacik wrote:
> > This is exported, so rename it to btrfs_clean_io_failure.  Additionally
> > we are passing in the io tree's and such from the inode, so instead of
> > doing all that simply pass in the inode itself and get all the
> > components we need directly inside of btrfs_clean_io_failure.
> 
> So this goes away entirely in my "consolidate btrfs checksumming, repair
> and bio splitting", not sure if there is much point in renaming it in
> the meantime.

Yeah I meant to put a note about this in the cover letter.  I'm leaving these
initial patches so Dave has options, he can take mine and then take yours at a
later date which will remove the functionality, otherwise he can take yours and
just drop my patches related to this code.  I obviously prefer your patches to
remove the code altogether, but if those don't get merged before mine then this
is a reasonable thing to bridge the gap.  Thanks,

Josef
