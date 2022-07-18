Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB7D578B42
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 21:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiGRTvM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 15:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiGRTu7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 15:50:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD614305
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 12:50:58 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id r22-20020a056830419600b0061c6edc5dcfso10047087otu.12
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 12:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPV0kA7TRl1uBedL0vmhtumNfaD83UB/vHWzacnCYNI=;
        b=5ZB8IhM+brajx7tQ7DtBc+frfib0NkGOlgkyWML2TSt/bBr7dVkB+pIigiZoJ/9vhj
         qqz6SVzDYPYjl83YmKiRWbbgKhYpn6HAv2NidZ7T+p7INfiIzmHtIDaMzwLtdRH5yjB5
         BT+/mdB2cCOSc83P6qZU+uAQ9ZTBApPwEmBtrBH+N5bpC7TqbL/4wP3/Jv+3EA13L31+
         ERMNg/6shZ3TOYxsl7WAM+k1fB/C3sjI25xV84o5gV2panmQEKQyLdBZMkHO+4LvHUCw
         PLYDYJ2ZgEywOcKhdj32bo3bsCKZZ+3neLSxLV/ly1+ELHYfvy4Y6S/Tqm54ha7Y9uIT
         cxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPV0kA7TRl1uBedL0vmhtumNfaD83UB/vHWzacnCYNI=;
        b=ojUdQU9QUFGWkAnkpmGJDgfuwSVp9DOoEDU3VzWvnT52ipTuh+KYQ+pIUkbmjc9dVs
         1TnVFyqimRpGWfpsDk6jo/TmiVpKRcYISBxVoRWNMJXi4Nyu+9zK+FHwPHk4T3jyrzg/
         n9jnH3zkwgmeodNkTDFvLfUBUKSCpAqRoipWVBfPcCReGboiMr1geWQ9W8meVJQWmOj7
         LMV6Ptm2ABRIni5G+6KLUGoYaK+2hv23KmMDJDGJLRzzN315eAJuRyrrWcG0z9gAxLM5
         6r9uxJ0rMfSJEOM3rKLH+YNtrUD5V+4kurYj3C6auFShmWk4JjUVGrxwVrLIXhDQ3ZuB
         fAiQ==
X-Gm-Message-State: AJIora85fWvgzSiK5dK/8uQK+YSQYaz+WzjCnDCZwXnf4ZIbczqXnAwD
        kQzlRsBR+4FFxHdK79dVmhtEvKzHT5GEb7ZLy+4wBqoWx67tmrOp
X-Google-Smtp-Source: AGRyM1ufq/Oa7utN+2OzdSptc83g+VOEmW1HNPAv12S2DfduYMaHe5drCrGyXCrifhfOcsOjCRYZTgOXGP83gm1bo7E=
X-Received: by 2002:a9d:61d7:0:b0:61c:7bed:ce14 with SMTP id
 h23-20020a9d61d7000000b0061c7bedce14mr9210946otk.366.1658173858146; Mon, 18
 Jul 2022 12:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <000001d899d0$57fb6490$07f22db0$@perdrix.co.uk>
In-Reply-To: <000001d899d0$57fb6490$07f22db0$@perdrix.co.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 18 Jul 2022 15:50:41 -0400
Message-ID: <CAJCQCtTAx=82boq175vtAu1Z_S9D1tcNSErir1wTK8MbtMfsvw@mail.gmail.com>
Subject: Re: Odd output from scrub status
To:     "David C. Partridge" <david.partridge@perdrix.co.uk>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 17, 2022 at 7:28 AM David C. Partridge
<david.partridge@perdrix.co.uk> wrote:
>
> root@charon:~/bin# btrfs scrub status /dev/sdb1
> UUID:             f9655777-8c81-4d5e-8f14-c1906b7b27a3
> Scrub started:    Sun Jul 17 10:27:39 2022
> Status:           running
> Duration:         1:59:29
> Time left:        6095267:46:37
> ETA:              Tue Nov 20 23:13:45 2717
> Total to scrub:   4.99TiB
> Bytes scrubbed:   5.48TiB
> Rate:             801.72MiB/s
> Error summary:    no errors found
> root@charon:~/bin#


What version of btrfs-progs? Looks like 96ed8e801 fixed an issue with
ETA reporting, which I'm guessing made it into btrfs-progs 5.2 or
5.2.1?


-- 
Chris Murphy
