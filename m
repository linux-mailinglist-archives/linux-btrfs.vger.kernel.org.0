Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A273F21AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 22:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhHSUgQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 16:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhHSUgQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 16:36:16 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE17AC061575
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Aug 2021 13:35:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so12247121pjr.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Aug 2021 13:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lq1/9dzMwse8hgj+nLsRtNNVHy5Ra8cI/pFGIqflik=;
        b=2RKmo3Q2iKNSxDasfmEsswnoQ8z3YAyLtAaZ/HjlU037dI8WGM89auY+HT0DGdfQG5
         U/MVHxJdBMIcF+Bd+xSvtL95UEX2dwFl/L/z3oPUnO/aigHxiu57hkL3swk7sYKK8eoK
         OPWWqbTNA4eO3pFQE3oPGvv1E3fjsnrOGOVy65plV9Zqf0TYsbeSGghf1ADPutP9iZR1
         5qcOPhlcQ0vwLOx7+tVxh274/kANbc4PzXIIj1zUrQt/iw6E5iILNWMZccVLZCykIsql
         szt7T9dgmeVXyvOI4dVbuIMMnv9/0iFbmrxmbHF8Fdu9z40bAQVIYwD2gzFvHS2c+7l1
         Qchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lq1/9dzMwse8hgj+nLsRtNNVHy5Ra8cI/pFGIqflik=;
        b=MGV+S1l+6JW2/KWp1T1F1IEgZoWr9N90S1SXrCQ7eRvRln2H03Ax0gJdyRIK+7XYZq
         W2ZoFgsiKkvloMHoJxWzkX/db84CZSVAiOvjp+0uW+zUi9EYY0Ncpm6C6/7t6ksCmiqp
         i8lI2pUXHogc/8Wp4XnEuzEkLndyy7dDDNSCWDZPSqx9VUCKrrI3JXgpJD5xyt352Nm/
         FtBZovQLthh5UNTlFYs0AXw1cJI7MarFjYunMs0L3avF7qSuwikkHsWZtUako2Ih3UpQ
         P9XjfH45/4XyVqr0v7pmx73wGeAW8eW8dtNPXHzUG3nhQnKnhtLBlq9J5v7PUI5OSm/v
         SwBw==
X-Gm-Message-State: AOAM53126XgwxaPlK6cICbmw7Y0xsLHk7um/cpg8oDqQvtHa+v5S9qgv
        xvQSAsQgXyvbN2oXpDB63/VG4+I/v5biV4W+8ArNEA==
X-Google-Smtp-Source: ABdhPJxSp6xtccEDJJJY44GOHyKJniTxZ6vHD+7V+PQJrY3uECT6oRKOpiFktsbnpDGqKIO/PuciS0G+rhFl437R2uk=
X-Received: by 2002:a17:90a:708c:: with SMTP id g12mr628765pjk.13.1629405339323;
 Thu, 19 Aug 2021 13:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210809061244.1196573-1-hch@lst.de> <20210809061244.1196573-8-hch@lst.de>
In-Reply-To: <20210809061244.1196573-8-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 19 Aug 2021 13:35:28 -0700
Message-ID: <CAPcyv4iRUYcZAMgiDLXDW-bRZxeRzAnWOgNJ4UL==CQX83_jxQ@mail.gmail.com>
Subject: Re: [PATCH 07/30] fsdax: mark the iomap argument to dax_iomap_sector
 as const
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 8, 2021 at 11:19 PM Christoph Hellwig <hch@lst.de> wrote:

I'd prefer a non-empty changelog that said something like:

"In preparation for iomap_iter() update iomap helpers to treat the
iomap argument as read-only."

Just to leave a breadcrumb for the motivation for this change, but no
major worry if you don't respin for that.

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Otherwise, LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
