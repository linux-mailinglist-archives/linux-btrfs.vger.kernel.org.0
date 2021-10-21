Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C64D436903
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 19:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhJURai (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 13:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhJURaf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 13:30:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396EAC061348
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 10:28:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f5so920268pgc.12
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Jw6LKql3NUw2u4o7aWds/hZbQcszi/va4tTrQVLBaIU=;
        b=bNmvFWV5nHs3pTNQfhHOJwnSUoMmV05Q1cz49l+OtmuhM97PMyu8IrsNszYyD+2c8X
         75D7Q+71Apghaa5Stua51Xu7rDpPMVFZJLhMmuKvz70Zr8mEqY1pRRciJNASZTRkyLtQ
         AoyQ4hKI38HDcXlxv7mQcJ7/ZT6sqU10vfoy8J5YSLfOHeUZrOoKb158Tm+2m7zEPqf+
         NrJ3kQXpnXWZt/C2CfMOXt64Oz6A5EOIrZZKNd6hqpFmIGy5l7Q4F+kROOjdsU/ygUj0
         q2zvCwA1IFcyhXz11fxmCNEYWJ7TDEMdKjTTt4bX4yrjLkDIXKpYjjayfiTRiv/IMBd5
         mNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Jw6LKql3NUw2u4o7aWds/hZbQcszi/va4tTrQVLBaIU=;
        b=r5+KVVzXkVuUhSTkl8Y7suCCP9Ve4IY7RkE/qMSlgqdgOzdBbZHi/ZgjYfWlPxSCZc
         ZKPubB7IY53nKKjdUs6MPK5ychPVuzc45IRDdQDLFdrQLgyGKC+d4n+z3jaZw1cUu04v
         3wfTEbkjoFoPhmOXHfwuantHZoiVWSSI5fSd55XShqf5EIdiOTS2md7G6xcJpie+wcCW
         AxRAVRb3S2miIJ6gyYKz6jcK67LDVUAVDqaV1EUmEWQr4ngKL+bWXc4pLxIlr+jkaQzS
         Zzoti4FVOJb2cH3tIJh+pnojd3CjdqCfr/1HCyQCmUIrdTziyJYQpofNL53nmETjcsRe
         WAkQ==
X-Gm-Message-State: AOAM532zkMdh/mc9nqyHRjWP6J/weQAEmShV+70c59zdVx3JLjcphSVN
        KtNrXtrgvpVBKwPegd91wHUREw==
X-Google-Smtp-Source: ABdhPJzdDXbCsN0QEHOlVONvGsKGhyUoMLSrqbI2YB4z6t7D2h5QW4dG2n9pkYpggC6f6baMm65Lxw==
X-Received: by 2002:a63:8042:: with SMTP id j63mr5429283pgd.120.1634837298543;
        Thu, 21 Oct 2021 10:28:18 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::381])
        by smtp.gmail.com with ESMTPSA id s8sm6571398pfh.186.2021.10.21.10.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:28:18 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:28:16 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v11 07/10] btrfs-progs: receive: process fallocate
 commands
Message-ID: <YXGjMIcUyzzKtHBi@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <d37fc365eda31317abe6ef89be534d6b5effc0b7.1630515568.git.osandov@fb.com>
 <6f428f1f-a6da-1b82-a0ba-5ceb38b3b16a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f428f1f-a6da-1b82-a0ba-5ceb38b3b16a@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 05:21:00PM +0300, Nikolay Borisov wrote:
> 
> 
> On 1.09.21 г. 20:01, Omar Sandoval wrote:
> > From: Boris Burkov <boris@bur.io>
> > 
> > Send stream v2 can emit fallocate commands, so receive must support them
> > as well. The implementation simply passes along the arguments to the
> > syscall. Note that mode is encoded as a u32 in send stream but fallocate
> > takes an int, so there is a unsigned->signed conversion there.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> However, kernel support for this hasn't landed, the kernel counterpart
> patches add definitions but don't actually implement the code. BY the
> looks of it it would seem that the proper send stream versioning could
> be added first before any of this code lands. In this case we can simply
> have the encoded writes stuff as protocol version 2 and leave the rest
> of the commands for v3 for example.

The original idea for this was to minimize protocol revisions. This way,
when we get around to implementing fallocate on the send side, we
wouldn't need another update on the receive side. I still like that idea
since the receive side is so trivial.
