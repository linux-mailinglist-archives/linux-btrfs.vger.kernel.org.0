Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DB83F3267
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 19:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhHTRoN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhHTRoM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 13:44:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD66BC061757
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 10:43:34 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u15so6321306plg.13
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 10:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+OMkppyO10RWiVITfSAmBv3WtKVw7UBzn3++q2JErfo=;
        b=NW519XGtPidmztIDgyMVyxUL9TPekrw7sceMLJIcIsIv061nsw/L/RFl6ELcOfb1ch
         7l5vP6dFrlEpPp0oOKVKgSKSF973VwdWmLzAT/Vncn/UG7aYikoLb+GcvmEjGxkNMDod
         EHIrAeSgBx8xPVhf+p6ocpD/akLvqJWiMaAhv/KbzV3h1qbmtK5y1RdEGti4khhzdM7j
         6kS5ivt3Ub7eEDDvgFpRvjDDoVvGRMLwCJIEca8KeXKjRSmL+LOYTNO5v8zyaYIX1nq2
         ote5rjQO7XtzIgaEyLdeRMNYJq5u1RxRBwBRlIovGGV4r1JJ523a8Um7swVWjTVFIu+u
         fFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+OMkppyO10RWiVITfSAmBv3WtKVw7UBzn3++q2JErfo=;
        b=mpQ2M0tC+L4rwDSPnLC3dJy5TbezG1ZiHa0Sx/kzVlbRNH+n59P/8rY5bTd8Ai3DAC
         ESupAkTo8AxzaOrYCvE3UtPUDlBB5hxYE+WNk58JwBxzNkO/tjrpKAQwKDh8OO6QnxlR
         ANihpBR51zZM1YcO9iJG5WDNY1OvBqshSWlM9HvNG2KzDh4Q+r8+AW15gGcwPm7/GwRg
         5tRJ5XsBj1UaRF4BLmqK4hj8K2DtpTMlZxBLjFuHj50+/XWbr/CCx9ay0k2pJ8anYavp
         1Dhw156Q4g6spjX33UZEucR8flibPyObNCwcibQO3Hc0gP+Q8UYaDrjbRLzQpUhYxl5x
         HqrA==
X-Gm-Message-State: AOAM533swWUlnJL02hcH5aCJkuG8dIR9iRtg/WnW+aMZ5iBgwwLOzLiz
        MGNdEJ0211S0tJFP5c2ylZX9mA==
X-Google-Smtp-Source: ABdhPJwoJ7V6vEL7T/VdWx8k6Is5UyozJjtmPXylzNZCn+bA/qrCUCdBUSjJMBzXs/GbVVbYzTagug==
X-Received: by 2002:a17:902:a986:b029:12d:21a9:74e5 with SMTP id bh6-20020a170902a986b029012d21a974e5mr17493100plb.1.1629481414218;
        Fri, 20 Aug 2021 10:43:34 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:4387])
        by smtp.gmail.com with ESMTPSA id t10sm11873830pji.30.2021.08.20.10.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:43:33 -0700 (PDT)
Date:   Fri, 20 Aug 2021 10:43:32 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v10 04/14] btrfs: add ram_bytes and offset to
 btrfs_ordered_extent
Message-ID: <YR/pxN3HTs36wmfD@relinquished.localdomain>
References: <cover.1629234193.git.osandov@fb.com>
 <463897807ed0366188b9966ae5b722daaf299ec0.1629234193.git.osandov@fb.com>
 <e69e1e3c-6338-d0e4-626a-a2fa9886de7a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e69e1e3c-6338-d0e4-626a-a2fa9886de7a@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 20, 2021 at 11:34:17AM +0300, Nikolay Borisov wrote:
> 
> 
> On 18.08.21 г. 0:06, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Currently, we only create ordered extents when ram_bytes == num_bytes
> > and offset == 0. However, RWF_ENCODED writes may create extents which
> > only refer to a subset of the full unencoded extent, so we need to plumb
> 
> Can you give an example of such a case?

It happens whenever we have bookend extents. Here's an easy example:

$ dd if=/dev/zero of=file bs=12k count=1
1+0 records in
1+0 records out
12288 bytes (12 kB, 12 KiB) copied, 0.000202106 s, 60.8 MB/s
$ sync
$ truncate -s 8k file
$ sync
$ sudo ~/repos/osandov-linux/scripts/btrfs_map_physical ./file | column -ts$'\t'
FILE OFFSET  FILE SIZE  EXTENT OFFSET  EXTENT TYPE               LOGICAL SIZE  LOGICAL OFFSET  PHYSICAL SIZE  DEVID  PHYSICAL OFFSET
0            8192       0              regular,compression=zstd  12288         217173213184    4096           1      217173213184

The decompressed data is 12k, but we only use 8k for the file.
