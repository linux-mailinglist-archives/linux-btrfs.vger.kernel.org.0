Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427D13D4854
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 17:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhGXOpl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 10:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGXOpl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 10:45:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07769C061575
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 08:26:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u8so6736162plr.1
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GSAHH6OebYOk1kUZj+Dgq3URGoNbgRumMQ8aSP95pHg=;
        b=un18xzY3S4Zcwx+1g7d6wiCB/fzy6njN58orZqYc3MZLiokuIgMcpvWLHw32qsEeIp
         Vg6RC6j0EKpvBJk6XZMn4LHw+5TPJVMQkAEHjzeHg1z/FEb3y3tEI3DxcTfDqfgR9Aa4
         WR4n/13CiQcACq3FfhOUQo0T2b81vYE9BGyuIA2H/LRLnDMSMmjbAbsD6iMdMS+VG44Y
         f8sb9udJ1RQSIvoUzoPy1YXxr4PX9JWaJ2SNxKy3yxVSena2jNI18CYpwO6IXcFE/qfC
         Nz5HawpUtIkBGsktgGV4WBdlQboXZFqODZGaXXLWWod822fo2voDkmHb9bzunDwejoLx
         XHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GSAHH6OebYOk1kUZj+Dgq3URGoNbgRumMQ8aSP95pHg=;
        b=NTls+YbCZwMuZkcTdDiQTl15zl4fVGAg+1Yu8RbO05ap82RvkguUhEWKz6sLoPRBeB
         u/8ltEEaV8Ok63Pxc6eY95O+o51ewSVfJf4g8akNITlcO3RMzbp/Gh5acbuDyQDSrr2y
         sey9ESUi3+66HgEZRO0IDrFfbqrZuiiPRWvkNcGdKYtPGVC5MAHEHJh9HQcX43HTpo4y
         iOVw4AGNbyll+EtSz/nBZ4H9pyXAdoa2hIRd4D2Sa/tsEaNVPzHatYc3RtW5E516I1+E
         lmQUQTTLZ9aS28T6+CDGtJDj9ePZS0zgjDjI1znyMoQxqhb2t0DPkgM6jVSuvtQjblv7
         KCjQ==
X-Gm-Message-State: AOAM530PTPQT/FbrC86bL7kLea8MUWNqpD+iTGUFf8V08fOVDIEBna4P
        V/yJJcr3PKEPorQJo5t6FdU=
X-Google-Smtp-Source: ABdhPJzZKoDeq2S5wDEWt1PulwYx3dv1wOVm85YIFqdl7wAfSUkF/LSdF853AoZjiI8YYvblBSN0hQ==
X-Received: by 2002:a17:90a:a42:: with SMTP id o60mr9180562pjo.161.1627140371650;
        Sat, 24 Jul 2021 08:26:11 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id q4sm39078041pfn.23.2021.07.24.08.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 08:26:11 -0700 (PDT)
Date:   Sat, 24 Jul 2021 15:26:07 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: cmds: Fix build for using NAME_MAX
Message-ID: <20210724152607.GB68829@realwakka>
References: <20210724074642.68771-1-realwakka@gmail.com>
 <2305182b-1e12-df9c-320c-7a7eedba860d@gmx.com>
 <20210724082356.GA68829@realwakka>
 <49a0090d-7055-b07b-f677-2d6e9bc4cc00@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49a0090d-7055-b07b-f677-2d6e9bc4cc00@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 24, 2021 at 05:44:00PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/24 下午4:23, Sidong Yang wrote:
> > On Sat, Jul 24, 2021 at 03:50:25PM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2021/7/24 下午3:46, Sidong Yang wrote:
> > > > There is some code that using NAME_MAX but it doesn't include header
> > > > that is defined. This patch adds a line that includes linux/limits.h
> > > > which defines NAME_MAX.
> > > 
> > > I guess it's related to this issue?
> > > 
> > > https://github.com/kdave/btrfs-progs/issues/386
> > 
> > Yeah, It seems that there is no patch for this yet. So I sent this
> > patch. Is this too minor patch?
> 
> No, I just want to mention you could add tag like the below, so David
> can be more aware of the fix.
> As when it merged into devel branch, github will automatically mention
> it in the issue.
> 
> Issue: #386
> 
> And it looks good to me, so:

Thanks, I'll do it for next time.

Thanks,
Sidong
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks,
> Qu
> > 
> > Thanks,
> > Sidong
> > 
> > > 
> > > Thanks,
> > > Qu
> > > 
> > > > 
> > > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > > ---
> > > >    cmds/filesystem-usage.c | 1 +
> > > >    1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> > > > index 50d8995e..2a76e29c 100644
> > > > --- a/cmds/filesystem-usage.c
> > > > +++ b/cmds/filesystem-usage.c
> > > > @@ -24,6 +24,7 @@
> > > >    #include <stdarg.h>
> > > >    #include <getopt.h>
> > > >    #include <fcntl.h>
> > > > +#include <linux/limits.h>
> > > > 
> > > >    #include "common/utils.h"
> > > >    #include "kerncompat.h"
> > > > 
