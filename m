Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB8C4976ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 02:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbiAXBuS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jan 2022 20:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbiAXBuR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jan 2022 20:50:17 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA6CC06173B
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jan 2022 17:50:17 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id m1so46333580ybo.5
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jan 2022 17:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIn8IOT1Oof/bXKckR2WeAVXI0TeYvSPnZpXcMqKPp0=;
        b=k2MrkqP/hjjpZA496SDHqbNwWn0Vz3dm6/k+Us2Xt9VdRXJ+kcC+E+qqzx+O/3r1f8
         f15vYQSJdWTD9CEAzmnAxKwWPoyZuG55J4E69+yz9jmgnzPec/jt5UCXL2rThqPA+a8k
         NObRBYq5A7ocFvh7LF0iJm4SzLcSnzK7BV7y0Rq/49F1TadfZXNIoVSDAd67RFoD11Uh
         +35Q23Xvt6oOu3R9xulqYIGJdunnSiDoc9vvwbVZAFoMqpZwfWz75ILXreyJXKocqRRY
         cYbQ/uCZc3ffWW7JJ2ON6/T3GIsVUxMrWxVNPtFGepkadhWiwGj7rsXfKidHqFz43GPn
         02mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIn8IOT1Oof/bXKckR2WeAVXI0TeYvSPnZpXcMqKPp0=;
        b=WMHpcpXyCW9j00gl4NJJpKqT/mYaBZTrmAwwLt4iWq/sjtU1nM9rNT1aLrrP6DizP6
         IIEWhV72iFg6W2XGZaryRcpx6leziVSYXYEBVEvZeYYTw63A2GlwStKDut6cbDbtA+mc
         eyh3UEhVuvsCgv7DA/cbIviAR/YZR9GhNLGckqxdK6iJ3YJrMT8fM/90DfEOCf73jBnx
         R/HlBsh9duRks/9xFdiLQX6/amv3OttHpHD73Gn9LC+WKgvENFE4gb2pxrD3YfN+7ECe
         r1AOQQ0+CSfvQD8rGADUQpSC0HaVn+mJx7TJm5wLt0cC+jX018CoRtADdOUML6qam1wz
         vFsg==
X-Gm-Message-State: AOAM531DyWUGZtTKKePcVfVINc6Xpm0As8ATMojakl+40Lvaj1xrZ8fa
        ofp8NOx9UKhvrgX9xmpqPKK/YiLmcCKYPMjgCzB9DQ==
X-Google-Smtp-Source: ABdhPJzGM97pTxJOIUm7sKCluXMV8phUDYmkXzCsTNjvHvHNc7CqqdqteI8U3kdWrQFkRZNOQsuf+AnWjDvFvcRlASU=
X-Received: by 2002:a25:cf53:: with SMTP id f80mr20025277ybg.400.1642989016526;
 Sun, 23 Jan 2022 17:50:16 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtQFpM8SLZf54zx1AAp0D1+FKC3MSitQ7pbT144+4jEWCQ@mail.gmail.com>
In-Reply-To: <CAJCQCtQFpM8SLZf54zx1AAp0D1+FKC3MSitQ7pbT144+4jEWCQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 23 Jan 2022 18:50:00 -0700
Message-ID: <CAJCQCtQJsersXAxPqLLL3+k-SG9srWXqt2p_S37MmTUCBjQ4CA@mail.gmail.com>
Subject: Re: btrfs-debugfs in master produces a syntax error 'maxu32'
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 23, 2022 at 6:18 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> Running into this today
> https://github.com/kdave/btrfs-progs/issues/440
>
> But btrfs-debugfs hasn't changed in 2 years so I'm not sure why...
> python3-3.10.2-1.fc35.x86_64

Sorry, discovered this is a copy paste related bug. (Not user error though!)


-- 
Chris Murphy
