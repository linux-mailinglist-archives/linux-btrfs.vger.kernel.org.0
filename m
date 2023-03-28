Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D146CC60F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 17:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjC1PWf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 11:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjC1PWN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 11:22:13 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B5D11643
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 08:20:36 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t19so12194256qta.12
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1680016815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OwYaK7xQ7pR1Cg1PzL6s/d3J3VeD38Qnk/9V7k2HWY0=;
        b=DA61vqGt9FwaA/lvPQdYWODe+k+rKkLPIabdlPoqVgcwfBYw1jJ55/cLWlm7Ls+/+S
         c0rcED/gnzwMtIx2igi70DolSDIv9zYMYb88FHGX2ucV0HrVvIN625ATfmBD3Dv4o3bk
         Wa9MTfjX0gTJJPCjhQKPS5eRvWU9sUdyZTtqse7kjWw3sCJD7SQ19wUNz6TByJoyOVvJ
         2qOlhD4j/gQ926Gayvf5Okt8QU+P1tyzXtGbT95v2Pz/jJjd4M20CJQPtlsVLrd6HrKc
         UUg8kIYOuHUiZTgcXc/pBr4I8/j3CknUA//lG7Cc7+JoyTXdXoujZXePG5WMlY5Wu+Rg
         xcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwYaK7xQ7pR1Cg1PzL6s/d3J3VeD38Qnk/9V7k2HWY0=;
        b=nY46DGuHPZ4brG3oTrq6LcHEisjEpXFvEgSvLzQCMLq8l9FVX9p8CJYEfo239tul6O
         MG3vlkifc045ENOr0yiG52aQw4pZ1YYrvSkOUbjjuLxFsYnSQKAzf+xlOEX29qWUjCyD
         zYITS5SvCgcDEmKyALWluj1ctR8TF1kfovRRYFua8xUC+MTUHgP+mkP8VDQFbXcoCBYA
         VfznMt9cAlhDKPvafhMnNwmT9qJAl+cxv9J07dES+AT12PeETE0SdP6O6cCQRqyFYuMS
         fbF0bO5+4+oGQfTB9QAEKFgcg5R8ingyTp/wclz23z0UAKNQ5rZPkmlwsOjKq4ORCgPU
         oEsQ==
X-Gm-Message-State: AO0yUKWW3+6oY+BbCNpgxCIzQtkqm24SZ/CI3aeqFGXfOAYklUbMP2f1
        +FbAhCaXG3cjciqWDrcsltrHwg==
X-Google-Smtp-Source: AK7set8XRPtV8qkIkmRkdgjKNCuIlZ+magwwHFaMjWEENrqeh++vQ4Uvn5uerkc1VP/bjHktaND5uw==
X-Received: by 2002:a05:622a:199a:b0:3bf:da1b:8023 with SMTP id u26-20020a05622a199a00b003bfda1b8023mr25421482qtc.38.1680016815140;
        Tue, 28 Mar 2023 08:20:15 -0700 (PDT)
Received: from localhost (hs-nc-a03feba254-450087-1.tingfiber.com. [64.98.124.17])
        by smtp.gmail.com with ESMTPSA id g1-20020a37b601000000b00743592b4745sm17654459qkf.109.2023.03.28.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 08:20:14 -0700 (PDT)
Date:   Tue, 28 Mar 2023 11:20:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: btrfs: fix corruption caused by partial dio writes v7
Message-ID: <20230328152014.GA11390@localhost.localdomain>
References: <20230328051957.1161316-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328051957.1161316-1-hch@lst.de>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 28, 2023 at 02:19:46PM +0900, Christoph Hellwig wrote:
> [this is a resend of the series from Boris, with my changes to avoid
>  the three-way split in btrfs_extract_ordered_extent inserted in the
>  middle]
> 
> The final patch in this series ensures that bios submitted by btrfs dio
> match the corresponding ordered_extent and extent_map exactly. As a
> result, there is no hole or deadlock as a result of partial writes, even
> if the write buffer is a partly overlapping mapping of the range being
> written to.
> 
> This required a bit of refactoring and setup. Specifically, the zoned
> device code for "extracting" an ordered extent matching a bio could be
> reused with some refactoring to return the new ordered extents after the
> split.
> 
> 
> Changes since v6:
>  - use ERR_CAST
>  - clarify a commit log
> 
> Changes since v5:
>  - avoid three-way splits in btrfs_extract_ordered_extent

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series.  Thanks,

Josef
