Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5573142DEA4
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 17:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhJNPwP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 11:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhJNPwP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 11:52:15 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC7DC061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:50:10 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id bi9so5818084qkb.11
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L8rwOBg9pmzxh2GDnMLy4YwwEJ+DFMH6B8GUldYroCs=;
        b=if7HgjYfCXo51MvUcnvWi80iAc+JsKCKHtH6mfOuTi7xYrYLb0eriQ4kMjpiQZSgmP
         WiK7NGaAWWxrIiS5AMy6SnN8miWNTbc5HKl5nnB5q/nd86SbBIcoLuj154jzQ9SEJLIY
         l/i1w9gZceEF+9cBUkPEWGobhCDIpKWiswWWqACwbFVfn8oEKSHF2ZWBX5Vxm1OvbKUr
         7N1HemP0MUAmzcA0reluY4kzgqpxEuh8BbzstenHPxzuiQzFdxOJYd9+9tk7Xipx1qPr
         8foGTm0XEs6gagBSMAk4QjbYd2SpNCfNgUEPHTASGiGQG3eWPSicd678IBbpGjQIyQGj
         xvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L8rwOBg9pmzxh2GDnMLy4YwwEJ+DFMH6B8GUldYroCs=;
        b=DWZ5rqIEN48QL0dYDVKlkSEtTfUf5nhyjLCJRK9A6LySYQD9bws/45TNic4f2Kwsvh
         70tl83NohevhWki7OWrrNQOaPlfb51zto/0chIHEbbn5+touHWlP/mrCvvWYBYulO3jv
         ri2SwGe/OqN1aTFcLMYZAdK98cT89ToySy0yQVzLVGy4MVRoHFUKSpfrqZcUHpF+xJ3w
         d1YXv2/ZHflw2QeuTd6zQXw3GrNFRbCSHhAOC8nbbuO0e4lo4HJdbpdcBKyHy1ioz5/l
         QzVOyrGXb2MDumIIjeJKuFyg34sp6/U07tsTdUKv0JiBErQHifl/0ncGuIyr/a3gdSZC
         9M/Q==
X-Gm-Message-State: AOAM533XI6EV/cRzP1TGaF2xGzaMDv8371DBA9Rg8hEVa2K/OAXy3V73
        jJSzCcn1Nzuh93V1C6WEVnZAxrJ3uFq6fw==
X-Google-Smtp-Source: ABdhPJzSLf5BsoQFy0dLfvmpP00sJTqqRjsQKUV1mRaaEkaxXAE+mwgqq5PphnqR1eTgNKdOlrWTuA==
X-Received: by 2002:a37:b981:: with SMTP id j123mr5432584qkf.445.1634226609186;
        Thu, 14 Oct 2021 08:50:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 14sm1683753qtp.97.2021.10.14.08.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:50:08 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:50:07 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: update device path inode time instead of bd_inode
Message-ID: <YWhRr123vMRtiHF4@localhost.localdomain>
References: <00b8cf32502e30403b9849a73e62f4ad5175fded.1634224611.git.josef@toxicpanda.com>
 <20211014153347.GA30555@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014153347.GA30555@lst.de>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 05:33:47PM +0200, Christoph Hellwig wrote:
> On Thu, Oct 14, 2021 at 11:17:08AM -0400, Josef Bacik wrote:
> > +	now = current_time(d_inode(path.dentry));
> > +	generic_update_time(d_inode(path.dentry), &now, S_MTIME | S_CTIME);
> 
> This is still broken as it won't call into ->update_time.
> generic_update_time is a helper/default for ->update_time, not something
> for an external caller.

Then we probably need to fix all the people currently calling it.  In the
meantime I'll add a helper to use the thing that calls ->update_time instead.
Thanks,

Josef
