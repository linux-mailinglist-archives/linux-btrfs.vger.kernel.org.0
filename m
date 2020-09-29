Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C9727D36B
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgI2QNl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 12:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbgI2QN3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 12:13:29 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9883CC061755;
        Tue, 29 Sep 2020 09:13:27 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id db4so2536987qvb.4;
        Tue, 29 Sep 2020 09:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=btpfPwVtcyqT7g5D3/tUPELy91YqCPv77sfdQYQcUcY=;
        b=l/NNNCI5lhqHJTks7VM+1lO1Jfq/CLbv+GsekHg1yfXmUO/6mMymCESzyloo21dksN
         +ecSSgHBU4H9ZPVGRmBtaXh3ntFl0WuV4q2pbfXr8QAZ5nGPf3x2kphPnRxFEXpipiGk
         Y8hNuL5pY4CskYJGm1Z9Q3T9hKDpEBF8NPBngBk7XyfIQAxfube4EsIYkOQsjOSSzcx6
         syQpPVdihzUcYzBbErezdfAPb54hsSeaoxsC83dLe2WzYfuhnJNOxQiGrMgAwTUrOe8v
         C1VfH4TQhwOzLC6f/oVScbsBQMqSLOw2y/57GP/+hYkDtQwfwlKhW5SAhX24s8qqJbZd
         9BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=btpfPwVtcyqT7g5D3/tUPELy91YqCPv77sfdQYQcUcY=;
        b=e92dWZmDtboVDTcD7IkWuiHkUkQrjg4wTC+joja6Lc0ddhlZZSuH4NitOWEWmbQfbS
         Eot+7FMXjP+ApLsvzMEJUJN1rOqzpXH5TbW2F0d/8X4dYseZa+ABAXyflJv5jK5Lvv3X
         9GJ5wCilag7fKnlPuFJPRLUXtE7ukawIDlWlEdXtoEfhMNv4MTyvsDz7LO1XBMNBsvpa
         iyoWBmIFbucuK4wGyPWWYu86JsUM5S0hqjxKQgmFTXJwqKldul+fA6ip34qyQj3HpGGr
         6p6YFAy2jx0JZUrRnWjqPJUvZmc0hgpHrIsDCZDfckdGPuL5eulWoGX/H7YITbKE5vcL
         eGLA==
X-Gm-Message-State: AOAM530xejnAvEZtAu0Q+3byFnO640wAZN8c2PR1vpxbOFn4uIcL++37
        EJoc3P6hBjVrO9KcIM5DqsHITGr/5RsjF97Ga1o=
X-Google-Smtp-Source: ABdhPJxwvhAcbSrW/WsZXCnvzA8HrljiuB+ISLo0Gdd7l6uUr0p9T/uwU8tcOoonm/8mf/Nq76bX8FD9BdIXiQvs+zc=
X-Received: by 2002:a0c:8e0e:: with SMTP id v14mr4887636qvb.27.1601396006819;
 Tue, 29 Sep 2020 09:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <f36fdfad33395cbf99520479b162590935f3cfd1.1601394562.git.anand.jain@oracle.com>
 <CAL3q7H7QLe6EpK_g1S6MVhOPKaEsaYY9MeAHexdsEO=nz_qubQ@mail.gmail.com> <eba12792-b4b0-ca2e-3b78-7648ae60571c@toxicpanda.com>
In-Reply-To: <eba12792-b4b0-ca2e-3b78-7648ae60571c@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 29 Sep 2020 17:13:15 +0100
Message-ID: <CAL3q7H6qkVXMrJXeDnQWzVa95KS2QTEniKEEQbepEugPKMDrHQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: delete btrfs/064 it makes no sense
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 29, 2020 at 5:02 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 9/29/20 11:55 AM, Filipe Manana wrote:
> > On Tue, Sep 29, 2020 at 4:50 PM Anand Jain <anand.jain@oracle.com> wrot=
e:
> >>
> >> btrfs/064 aimed to test balance and replace concurrency while the stre=
ss
> >> test is running in the background.
> >>
> >> However, as the balance and the replace operation are mutually
> >> exclusive, so they can never run concurrently.
> >
> > And it's good to have a test that verifies that attempting to run them
> > concurrently doesn't cause any problems, like crashes, memory leaks or
> > some sort of filesystem corruption.
> >
> > For example btrfs/187, which I wrote sometime ago, tests that running
> > send, balance and deduplication in parallel doesn't result in crashes,
> > since in the past they were allowed to run concurrently.
> >
> > I see no point in removing the test, it's useful.
>
> My confusion was around whether this test was actually testing what we
> think it should be testing.  If this test was meant to make sure that
> replace works while we've got load on the fs, then clearly it's not
> doing what we think it's doing.

Given that neither the test's description nor the changelog mention
that it expects device replace and balance to be able to run
concurrently,
that errors are explicitly ignored and redirected to $seqres.full, and
we don't do any sort of validation after device replace operations, it
makes it clear to me it's a stress test.

>
> In this case if we're ok with it exercising the exclusion path then I
> think we at least need to update the comment at the beginning of the
> test so it's clear what the purpose of the test is.  And then we need to
> make sure we do actually have a test where device replace is properly
> exercised.  I _think_ it is with btrfs/065 and some others, so just
> updating the comment here would be enough.  Thanks,
>
> Josef



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
