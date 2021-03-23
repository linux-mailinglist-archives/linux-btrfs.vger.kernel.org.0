Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FC1346336
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 16:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhCWPn6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 11:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhCWPnn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 11:43:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CC5C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Mar 2021 08:43:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so10090606pjb.4
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Mar 2021 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=csNaPeK69Mldh17cXgEvQIP+wSOJR6sOOCrD3Sif/Go=;
        b=A0IPH5nMVYQwU6P3FyMEXWToTbCB63VrOJEzuSaPwjhOFCtGLWZy8QiL7CH97+RRWm
         gZSICwwlWaDPLekqu9s0cK388Rb/fOQM5zFw1GX/55ClsQsTxwrjtAJtFBWqs9TQt3XX
         8k3j5liv5cyzkuDi1WV4UBeotkDx6q0TqAiMGIrJfYTue0lKVn3HnUsXtE6HZ3M2GrcE
         RTL9gHSnR05zXLompI7xRA0fkjw94MQhV9Nc2kgPiWSrlK2M1C7DIO3x7VEZ4cVA1Kvr
         qneXBAwTUxrMXva6bmgQmSLwOwuZeO9StkTt5YxsDWiAR98JrMyi+WAQCIS0nFfw5lhC
         62Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=csNaPeK69Mldh17cXgEvQIP+wSOJR6sOOCrD3Sif/Go=;
        b=FBSYmyCbfQk+1SeBn/hC9HUB2Drru/Iqw1pVx+RRnuES41mghJOq2pJphAKvaqk2Yz
         ObfmDVxMJMiT3fvowrye28mprkEPtv8pz8G4PDt/Dt/h9qIYQeG+bAllyFEK0avYgAsQ
         hnB907lbWtcGzYWAIU2hEq/DYlL3/MewiIgCqeXI8idKNKeKQ5jJ5Ki+3FOBdHf4DckR
         hjmoNKrivfZSY0JAIuWkL1t3G77NeMflx/L8926eRdMX/ocwwGhgGAr/Pxp5EtSJZD8F
         B81LO2POgZFJebtZohmP3AD11xy6JH1mLyDideStKvFDeijKJBEsg4ER2G2FlzgfLSvU
         0p/A==
X-Gm-Message-State: AOAM530/H8FQc7csNG3zGRLWdy1ukcdiIQE7rBOXph4CNfJmr/tP+qJT
        hGquHCRIW7IJU5OUS379DxuIc5PaR4J70A==
X-Google-Smtp-Source: ABdhPJzLBhvJjyvQFVUv3SxvmSmFa0zBx6k90No7B2pMyfO50HzLeCWCd4W3rsFBcpqoo0uPCvbP2g==
X-Received: by 2002:a17:90b:f15:: with SMTP id br21mr5170839pjb.234.1616514222075;
        Tue, 23 Mar 2021 08:43:42 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id l22sm3474414pjl.14.2021.03.23.08.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:43:41 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:43:34 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: qgroup: remove outdated comment
Message-ID: <20210323154334.GA2652@realwakka>
References: <20210322140316.384012-1-realwakka@gmail.com>
 <20210323144816.GG7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323144816.GG7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 23, 2021 at 03:48:16PM +0100, David Sterba wrote:
> On Mon, Mar 22, 2021 at 02:03:16PM +0000, Sidong Yang wrote:
> > This comment is outdated and this patch remove
> > it to avoid confusion.
> 
> Even if it's just a comment removal, changelog should say why it's
> outated, I have no idea and would have to do the research myself.

Understood, Thanks for advice. I'll fix changelog for patch v2.

Thanks,
Sidong
