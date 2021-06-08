Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3739F97E
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 16:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhFHOsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Jun 2021 10:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbhFHOsj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Jun 2021 10:48:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E2C061574
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Jun 2021 07:46:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so2430862pjq.3
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Jun 2021 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BxDqlVzp1FvnEVPizWnFiCE3Knefp4VI2tzsVlemQWs=;
        b=UWVoVW+qKcfiO23S0sNvHwWjagbqluf3k8Ym2un0sBf0X1bJPfXkefvycf2Ssek/zV
         bZnM1rhI26RxXs5GGZR+2WfD80pC1Kmb+TPdanX7RbjeiM2N6/2jDacseZlYRFmEHl2e
         XIQ0KWaf7cex1Oxm2Xn693mxT1Tv9bp/FrIEK6M6Vh8az6T+VBkuRFAMcUPa6jlUONbM
         A4qVClvnklJ6Fv3AGfb2ImHpYyl7lJFoorTG0DCLCj0tEBd6L65MDX++OcSB56tYCnc8
         DFrVF/Q2cFnN1yAgmv7cKRbEi11elNKN5uYQGcc33azqAKnqlYJKNs5sqmZCFgSaUH5n
         sjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BxDqlVzp1FvnEVPizWnFiCE3Knefp4VI2tzsVlemQWs=;
        b=XHFqECXtXW+/Oz63JIvA73ViNMmgPJkPoeoqM19pV6Wfq9IINdMFxh5gknfwLV8xfI
         lXi73VoUBAhloNvz09H2fLjV4KW1Fn0U2eqnOhCnmwplo1mMKfMkdDOsR+It/M3NhspK
         4TXvEX6bMhh5IiGxySNP6pSovmC9uMkSxSFX4Filrw5j0+YJmtYQu+GVBjJ1fYFa8Q7P
         FDB/1assllMJMyd3jBvtyjFN3z8ucKBZpaiiVceTtiC6uCPIpnONnApXdTXyqMGY0HRz
         mfjHs0wxrL94HPT94o7iZTobTcQO4VuAwApUOzYISEUvgs3Ovq9adxlQEhK56BnvJps+
         kjUw==
X-Gm-Message-State: AOAM5339AMP2ZPQcP8JBYCh4HNHokO6O/7dS23qkIbb5oLMaQ4Suh5I9
        diM9hzKKVMXiXwUDa9ujK4+HUvbiRokUUHln
X-Google-Smtp-Source: ABdhPJwnJiuOpHhvlQ46+BzaLcdyPXwEBgHPiYR89xlgzpSJ077rL/AW4YWa1Fc0Pz+pCWxr/+HG9A==
X-Received: by 2002:a17:90b:124a:: with SMTP id gx10mr27299720pjb.214.1623163591528;
        Tue, 08 Jun 2021 07:46:31 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id s33sm10585255pfw.150.2021.06.08.07.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 07:46:31 -0700 (PDT)
Date:   Tue, 8 Jun 2021 14:46:24 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: device: print num_stripes in usage command
Message-ID: <20210608144624.GA818085@realwakka>
References: <20210530125636.791651-1-realwakka@gmail.com>
 <20210607192048.GM31483@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607192048.GM31483@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 07, 2021 at 09:20:49PM +0200, David Sterba wrote:
> On Sun, May 30, 2021 at 12:56:36PM +0000, Sidong Yang wrote:
> > This patch appends num_stripes for each chunks in device usage commands.
> > It helps to see profiles easily. The output is like below.
> > 
> > /dev/vdb, ID: 1
> >    Device size:             1.00GiB
> >    Device slack:              0.00B
> >    Data,single[1]:        120.00MiB
> >    Metadata,DUP[2]:       102.38MiB
> >    System,DUP[2]:          16.00MiB
> >    Unallocated:           785.62MiB
> 
Hi David. Thanks for review!

> This is example of single and dup, but the whole point was to print that
> for the striped profiles, like is shown in the issue
> https://github.com/kdave/btrfs-progs/issues/372 , so it needs to be
> conditional.

Okay, striped profiles need to be printed. I read some page from
wikipedia about raid. and I got that RAID 0,5,6,10 supports striping.
Those need to be printed and no printing for RAID 1, single, dup.

> 
> As the mirrored profiles have a fixed number of copies, there's no doubt
> on how many devices are printed, same for single and dup.
> 
> I'm more inclined to use the "/" as separator: 'RAID6/3' it's more like
> "raid6 on three devices", the "[]" looks like indexing. "," is used as
> separator of the type so it won't be as simple to parse that.

I agree. I'll use "/" for next version.
