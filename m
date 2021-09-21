Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589C4413B0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 21:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhIUT6s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 15:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhIUT6s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 15:58:48 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE32C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 12:57:19 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 138so1099536qko.10
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 12:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpZL2lp2U+RN0qHlc4wAb6SNXALs5Esp+zmoBgSVbF8=;
        b=y1zfwlxIXoEBkd+XElQAF0gzjm4JQCneQ0E0qg9mlYmIXl/mO+6AWF4YJ3zyh9YY9v
         m+mawvcw2o998I9ODXX3iXZghyzsYO9c7M5oK7o6BqZ6+/sS6cXFuD8xOXSoRkKzwH5R
         IEK+DVOzBjdit9Y2tlHOPAD33FfClgS6zHZc0oJpQgTQ4YK/5rlNZAbmZnRUPh0XtkOa
         gmVa/eytvKERr91VOI2py7t4/G1QiJgTGSnR6TbIBkHSrWQI7B9J0sAUuN84mZly0EJO
         TGo2iwL4FFTe4TzFTLYI4K/gbB34/LgbOIpCNAzvz9R+11H+nlB1WduV4MVmbJPkQBna
         TRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpZL2lp2U+RN0qHlc4wAb6SNXALs5Esp+zmoBgSVbF8=;
        b=HbhFE/Dn2igPQa/h/RqeONSVQmEwmZ4ljDpu5jOiYY5GML7NH39d765I7A7rdyR0B7
         s0zJW/DGxTzTk7j4yUSZXLqjnNIvg73bkTKtuWdsc4nyHqpYZXwJvKtho/pJ7tzDEl0p
         31fG/ftdptFZ10sspFAHgqZjleHiQ4IwPm6plcOB0HuqEUUXdRpql1Oh5Yvbxe6b1JWm
         sYJp9ReJNyqj7nQzOVoCgRcrYiD89JfLEjdNclF17vIUadFtDG1jLeOFqHqS2Bfu72ci
         /HXdHKJ8U2uAsetdVr6ByhQx7Z6LdaopbQSZ98fVMaNNoeqSnAESBYxszaeznLueU5AL
         0h1g==
X-Gm-Message-State: AOAM532d+SMjeYHUWoyATu1v5JzBcIAE/u1p/4fn0CNcLehidnFpl54o
        4zrg9q13J5qB3swDA9y3DKcqqCXbpn5fPf6/Oiywkw==
X-Google-Smtp-Source: ABdhPJyJ//mNF/mG1NLD4AD+Ft64p61iIQ++RIMTrfY6YaR1bKcm/qq+EYxkZEASq38Nyjn5kW3+RSFHwDLwQPP1Kgo=
X-Received: by 2002:a25:f806:: with SMTP id u6mr37373456ybd.341.1632254238374;
 Tue, 21 Sep 2021 12:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRbktnZ5NxRTZL9UKvTr1TaFtkCbeCS2pVnf2SPg8O3-w@mail.gmail.com>
In-Reply-To: <CAJCQCtRbktnZ5NxRTZL9UKvTr1TaFtkCbeCS2pVnf2SPg8O3-w@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 21 Sep 2021 13:57:02 -0600
Message-ID: <CAJCQCtTtkNoVKSPdEfwByrpCP7iKoocNcrd0vT64Z-OjuQdgaw@mail.gmail.com>
Subject: Re: bug: btrfs device stats not showing raid1 errors
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 20, 2021 at 10:37 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=2005987

The downstream bug has been updated. The problem does seem to be with
the drive itself failing reads.

[2634355.708201] sd 2:0:0:0: [sda] tag#0 FAILED Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=30s
[2634355.708209] sd 2:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
[2634355.708214] sd 2:0:0:0: [sda] tag#0 Add. Sense: Unaligned write command

I think it's fair to say, readahead or no, it's a read io error that
Btrfs probably ought to track even though there's also some pretty
obvious hardware issues occurring with the drive too.


-- 
Chris Murphy
