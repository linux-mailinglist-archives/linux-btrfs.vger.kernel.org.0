Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F853DE6E
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jun 2022 23:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347537AbiFEVn5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jun 2022 17:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345809AbiFEVn4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jun 2022 17:43:56 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3716393C1
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Jun 2022 14:43:53 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id v7so10855581ilo.3
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jun 2022 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpeOPBzEFa5hd5IQvatXT+gL9XA3ztfpiJdtc7W9MsI=;
        b=ScdOY3btUbVRSEv+Opwi35Y1G/gupjaWmrgrfIPrIoxHXz3F6XkmvZ3zziew2qMSDd
         vcCrcJcoI9fH6l8s/sFW5D+JwZMh+RCr7MIsw7LSMIiJ3xz/aia7i08psMWbcYRv+GtT
         KCAbKwMKV3JUKVuT6ljZZ5UZ3ch9HraFn/n5hxGDW7RjFgLyZwMp1yBvbaDtzCMi6Mm6
         6g+Ga6aYnRYX3mLqWAUDD6yKTCVYFg3wHTn59kudm+rUTrQRhRhmAUrgQx7C+xZQr8+f
         pPuql26QyLawHPswmxpmgwH2eybzHnol73qQwnB0enBWrckCy7FYVQa1yODW2bd9J15V
         dZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpeOPBzEFa5hd5IQvatXT+gL9XA3ztfpiJdtc7W9MsI=;
        b=si/pzYGd8xMtaYJuW763d40xit8rvpDOpY3cKc9KKSriXj6nksiODlRvYkWq/XMY0W
         3Qt8svZPoT7bjMTwqUauv9l8a7s0N/ATiVSgQr6rDIAkYkYew1ffGj7YDYJREqwbaKtr
         Fss/uKENutRr6lYPuDAa0fGu8xXUBFQP2johod/ANiIO/TA3PusgziaXw5h4zfevFZdF
         ToVijz8Fq9EbpjkpbHcpjIMEVbNYmzIWTUPiJop6cFxn9DISacD9wgjQfAf+9fJwDW0o
         x63XlVQ0zfQFEnI02qVe/6pvU2RutVz/B0u+QWsO8vXI8rinVVSqOuX6HrQS5Vpmwi8D
         bhNg==
X-Gm-Message-State: AOAM530b3XsL/D1bO5HGLrY/pCF4J/81QGe3nNaUkjVBnqndcPBd6Bc+
        V868idIjxnHYX3wV7k4tkkuFj9FJTV8IjtUyLQmIC+ACwBs=
X-Google-Smtp-Source: ABdhPJzacRk2/Ebv8n4BN+EqeUo/Z45FGwE1ma2uOVhHWgfK+RQQn9DArau+Zc//7sJ4VTGqdtreyPyBT/9EyOmF5Rg=
X-Received: by 2002:a92:ca49:0:b0:2d3:9e94:1af8 with SMTP id
 q9-20020a92ca49000000b002d39e941af8mr12056606ilo.127.1654465432045; Sun, 05
 Jun 2022 14:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220603170700.GX22722@merlins.org> <CAEzrpqf122toMdEAx2audiusW3kKM6d36df13ARJ+SjbVf7TFw@mail.gmail.com>
 <20220603183927.GZ22722@merlins.org> <CAEzrpqdzU7nugcLoTzKy-=tsikX=dUx5xMb2iKe+wR=69=H4yA@mail.gmail.com>
 <20220604134823.GB22722@merlins.org> <CAEzrpqetLawF0wdYkz02nGQct63Yae_-ALF=ZUw3hVe=AH4wKg@mail.gmail.com>
 <20220605001349.GJ1745079@merlins.org> <CAEzrpqfjDL=GtAn9cHQ2cOPMVZeNnuaQBLq6K-X-tGaipaAouA@mail.gmail.com>
 <20220605201112.GN1745079@merlins.org> <CAEzrpqeW_-BJGwJLL+Rj_Eb7ht-A_5o-Lg+Y-MYWhgn0BqKHEQ@mail.gmail.com>
 <20220605212637.GO1745079@merlins.org>
In-Reply-To: <20220605212637.GO1745079@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 5 Jun 2022 17:43:41 -0400
Message-ID: <CAEzrpqdFEsTNPAqqrALcMLpeMUbc+H4WJZ9buSZMKSQ-YS1PVA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 5, 2022 at 5:26 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Jun 05, 2022 at 04:58:15PM -0400, Josef Bacik wrote:
> >
> > Sigh try again please.  Thanks,
>
> Same
>

Sorry, this one should work.  Thanks,

Josef
