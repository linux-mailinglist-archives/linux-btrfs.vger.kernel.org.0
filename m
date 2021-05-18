Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB392387D12
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 18:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350358AbhERQHv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 12:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344604AbhERQHu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 12:07:50 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE42FC061573
        for <linux-btrfs@vger.kernel.org>; Tue, 18 May 2021 09:06:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b13so3999139pfv.4
        for <linux-btrfs@vger.kernel.org>; Tue, 18 May 2021 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EuPIOHm+1cWFBkPIAjVxQAum14ReBAV1lb0b6GLsfuU=;
        b=sFmhNGupg2+eJA43jPonYhMmIcNhJxUCmgodjPoWN7ZvlCfKT4/4Q6dtE0c62Zumye
         G4dgtwRsnZB0MK7pH+20JUebfTpBi8eW0ItAu/AADwNjIx48RnLYE4zJE7abOWhFR1Yt
         WuCCkGol2rlBcnzY3CKuD3kRoWkXLmMRsQeOgvi2h1iqeEMJUxHiPK0LEj5deMOpcpdK
         brTgWQJ1av5gxjlLutZlp3RprzNW7GE22eGNABJZiXdMgMiEOxI+hAF9E6C4nFdInP1+
         JYKe/0RqQ7jCs6OipCcNyuLt6Zu7rl3sxdJTAx/fXUaZJkT6529WqLnCt9XFCIoRPI5C
         n6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EuPIOHm+1cWFBkPIAjVxQAum14ReBAV1lb0b6GLsfuU=;
        b=JHBjI7EE6cDGliGyM/AKVAcu9TXQ8E3coQkmcfZV7FiNUuoN1GSjqDfaI5q1qOTm/p
         7f/y8kVctWlE+7YC9ATeDjWvcxjjiVmSgfe7Cd3SrgRmoT44g6N/2syTw3BrmcP0g4hq
         qU96QvLybRBIQ8EkYdxNi7L7OYTri0k7e+KgasBFD8Ckm0pISJwOB4c4Hlz4QEWl63mY
         mwUN9219/gtOvHFV2pZxdMjF5S+Ijkbhm6zhBJb1pOFjf36ItSXWOj5JdrYKeEMVfkT5
         XFiyLedBhdD1g89War7qc791XqzqSbAlS2rf0QLLKhWfJ9FNgsWmD9xzfey+kZvxUtBx
         M59w==
X-Gm-Message-State: AOAM532wGIqymFvZ9swpIjXXzEe6sJyGlseyuthU4DwnOy+PfUIQEVWK
        K1bBJ1StJZcAqaSvi1xaDhY=
X-Google-Smtp-Source: ABdhPJyFyQiiZnFVfb/BI0TRuj0syCilhbQpHY8gy2pA5pzzAf5L+baCdSysJu9iE8hU/Bzyzei1zQ==
X-Received: by 2002:a05:6a00:8c7:b029:20f:1cf4:d02 with SMTP id s7-20020a056a0008c7b029020f1cf40d02mr5750699pfu.49.1621353992407;
        Tue, 18 May 2021 09:06:32 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id l18sm2189141pjq.33.2021.05.18.09.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 09:06:32 -0700 (PDT)
Date:   Tue, 18 May 2021 16:06:23 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: subvolume: destroy associated qgroup when
 delete subvolume
Message-ID: <20210518160623.GA38825@realwakka>
References: <20210515023624.8065-1-realwakka@gmail.com>
 <7702abe4-f150-44c0-8328-f62d68f5a56c@gmx.com>
 <20210515133523.GC7604@twin.jikos.cz>
 <f52f74ad-d0e9-babe-b555-455fc185dbd7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f52f74ad-d0e9-babe-b555-455fc185dbd7@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 16, 2021 at 07:55:25AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/5/15 下午9:35, David Sterba wrote:
> > On Sat, May 15, 2021 at 10:42:15AM +0800, Qu Wenruo wrote:
> > > On 2021/5/15 上午10:36, Sidong Yang wrote:
> > > > This patch adds the options --delete-qgroup and --no-delete-qgroup. When
> > > > the option is enabled, delete subvolume command destroies associated
> > > > qgroup together. This patch make it as default option. Even though quota
> > > > is disabled, it enables quota temporary and restore it after.
> > > 
> > > No, this is not a good idea at all.
> > > 
> > > First thing first, if quota is disabled, all qgroup info including the
> > > level 0 qgroups will also be deleted, thus no need to enable in the
> > > first place.
> > > 
> > > Secondly, there is already a patch in the past to delete level 0 qgroups
> > > in kernel space, which should be a much better solution.
> > 
> > I've filed the issue to do it in the userspace because it gives user
> > more control whether to do the deletion or not and to also cover all
> > kernels that won't get the patch (ie. old stable kernels).
> > 
> > Changing the default behaviour is always risky and has a potential to
> > break user scripts. IMO adding the option to progs and changing the
> > default there is safer in this case.
> > 
> Then shouldn't it still go through ioctl options?
> 
> Doing it completely in user space doesn't seem correct to me.

Yes, It still use ioctl calls for destroying qgroup.
I think this code has pros and cons.
IMHO, as david said, It also has some benefits when doing it in userspace for
old kernel versions. and give a chance to change softly their codes
which use btrfs-progs with options. 

But when kernel supports this operation, maybe this code will always failed.
because the qgroup was already destroyed with it's subvolume in kernel.
and the code will be meaningless.

So in long run, I think it's better way to doing this in kernel. 

> 
> Thanks,
> Qu
