Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B02130B25D
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 22:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBAVyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 16:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBAVy2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Feb 2021 16:54:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454F7C061786
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Feb 2021 13:53:41 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c12so18265171wrc.7
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Feb 2021 13:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=bF/86nuwv7Wr1FW3hUdiDxTdRZNoyVLQ5WZTWVugamc=;
        b=jydfRr0O/pQIeeaCbPR4p5c3UZdNHCEJn1jVkl+CbPoyi9+++ut/eDbjkI2y7/pBd2
         VWRVzZh33pqbvuOK4DVRK6W7qmBlFUcwxY8ktoNSIAHBUkPXQ4aAliRiLzIV86Rd3SlP
         sDRq4k08FCnLfzeObtZ3tlgY7NtWXtbWQ5NpaO4ZDhrEV++6DAETRR7SV9qMIt65Qvto
         14CRvo1RX9oMvwBEczkn2eGuW07A7YpgWGgJd24/F3EDaLXEfvz1dEa2IdA+pBH/P9fk
         JqpD5EdQcN/pwjHI8qJCInkJ1Hori8Jjx5Z2okqpU0zps+S641md13Wyh8UmPEE9U+m2
         534g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=bF/86nuwv7Wr1FW3hUdiDxTdRZNoyVLQ5WZTWVugamc=;
        b=WmF7FBDf98I+ldLwONffLKz1L0hnHCGukPCmLSZUlUPpZBkRnQ//KN+aWMuIhUBRm5
         Ivas4ex7/R9vwM7kRu7kAf5vrQS469ptXZbYRmS2bFoH80+2uKKsN1jGXsVqgmlYZTAo
         6Xg12SyQk4AE7KzJw9H/i2Cv1ekjXOILa01hjF9BUsIBYMAkTEraOZCunPlAZHOun2/F
         qy6R6N2jQnFeeC6DoZ5Md9n+b+88wBBQBFqk06LCfVHf4eozG/e9KIe+Y8M/PZdjm4UU
         CgxEbvcNOf5tB2cW0P7CIYmV7LwyOC5usPy1kjJK48BS/QLWWK08N1+wnDCSr908CDYT
         IJCA==
X-Gm-Message-State: AOAM530bvMSpSVYXGO+lUqaYtxDXH8KMp+qTouIclIqW4BoHcUtgIk3X
        PiCHRdqKz9lYcux3MyPvPFAg+u7YLERDg8m9UcBSFR2H1ZFILw==
X-Google-Smtp-Source: ABdhPJzBUuMWTOzaxLEvnKqX8uWy4p6Dn394Q26ygGCWG0VmyVIqp2yXlS6h0f+rvu9flrerB9DgmoJMBKYJ7MWCyHg=
X-Received: by 2002:a5d:6a45:: with SMTP id t5mr20103615wrw.252.1612216420007;
 Mon, 01 Feb 2021 13:53:40 -0800 (PST)
MIME-Version: 1.0
References: <157ed91bb66820d1fef89eb05d00e65c25607938.camel@scientia.net>
 <20210129192058.GN4090@savella.carfax.org.uk> <956e08b1aed7805f7ee387cc4994702c02b61560.camel@scientia.net>
 <20210201104609.GO4090@savella.carfax.org.uk>
In-Reply-To: <20210201104609.GO4090@savella.carfax.org.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 1 Feb 2021 14:53:24 -0700
Message-ID: <CAJCQCtTVLcYAwDUTeJTP2TWTzdCTbqnnNmNDrz78_Wse-dMFHw@mail.gmail.com>
Subject: Re: is back and forth incremental send/receive supported/stable?
To:     Hugo Mills <hugo@carfax.org.uk>,
        Christoph Anton Mitterer <calestyo@scientia.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It needs testing but I think -c option can work for this case, because
the parent on both source and destination are identical, even if the
new destination (the old source) has an unexpected received subvolume
uuid.

At least for me, it worked once and I didn't explore it further. I
also don't know if it'll set received uuid, such that subsequent send
can use -p instead of -c.

-c generally still confuses me... in particular multiple instances of -c

--
Chris Murphy
