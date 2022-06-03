Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFCC53CDBE
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 19:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbiFCRFi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 13:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344269AbiFCRFc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 13:05:32 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E21527CF
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 10:05:28 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id u2so6643424iln.2
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jun 2022 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AOTquoFieaq76bnSJc3cxvqnrOzNYhG4jH6ZewmkfUE=;
        b=Rvi/5vXlJRVSerk6LjIkSFJyYzjRUZwWmPf2M72ls/Hjjq40tyxii4JX6BicBoKet8
         guJvqU8/Pw6Mmk2Gjb7Yi5F7phgusRcU3na2Ni6tRFkCZbjV56g3xbQ5mVeUCa2RuV63
         fl3ecEExbKv7qH5xC0cHIBF51y598E2nIxMzoRckRHXjZnq+cIR2qrSNDOm7jT6LqEQo
         Yhy/OiPBAn8yAKOFu48pO5u9KflKAV/o1JkMSgoo7u72chBBCR6yyIt6crJ6tY/ryrcx
         k54sDje66g5nb4hPNn0PjGXWZ7Eek3LEpwm7uopAGzucb85xkMi/9cYPXZibVcRR1per
         etSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AOTquoFieaq76bnSJc3cxvqnrOzNYhG4jH6ZewmkfUE=;
        b=eXcPkJ+fpgWuMSSk06weFCE8uQCIr7j4dx1irYtIF4fNJJiAGejj9hh78HtQ4zm8zD
         WEKWk8HFoatHbwDG086jO45oje2vQzyGAZZZKlvIODnM1rBBoJZwIJ1AiJeUK059pw4w
         iuoie1NsiIGuHcLwc/DZn59cxnXJ07HaNusMUuosJqofzKGSqHi4LSogwtZ62ITrfZWK
         fStodpsBVclW72lhYF4/jMSysAgHzsR/rFYXUClAELDGQeRNmwxLDULpJ6tZTBIVRrG2
         YvLYUOjxQ2YeC+CV6mg5O2w+lYmZKmvCNb81jVnHoTMP4q4OnNCiH0ij4hJDLyx5+W8G
         1uVA==
X-Gm-Message-State: AOAM530t8OIVDhRi866S/4T5JAEppV/Y/WECsGUpbQH+4o74R5dr9ECW
        6TaFe8SiDX8jc2RLbiVu68dwkpvbIOezWxzHtk2VSFklViI=
X-Google-Smtp-Source: ABdhPJyQZiTBFZMy1Q6y8PbMsFDgmaurAAMc/eKipS/b0jeDPu7YeyYPgCfPnkeoUaV4mM/bVhhq5QEZmrGzMu8MW7E=
X-Received: by 2002:a05:6638:d8a:b0:330:b3af:bfc2 with SMTP id
 l10-20020a0566380d8a00b00330b3afbfc2mr6489533jaj.11.1654275927565; Fri, 03
 Jun 2022 10:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+H1V9xQEDf0G-Nvcv3irtSPF+09dJ6VMs7F8LBLpUGEUSfxmg@mail.gmail.com>
 <7762988d-0a64-695a-4ccd-ba7b51c0754a@gmx.com> <CA+H1V9wSZXVrLdz9ZELx8gc3nOHOJz4b48DQMFcmc8cTEJgXAQ@mail.gmail.com>
 <760a98d8-3524-d24f-b5f9-3653ee46661d@gmx.com> <CA+H1V9wD0Ndrnt5bV85nJPd7Go3gbyTs0K5pZBCybvwbeB3z3w@mail.gmail.com>
In-Reply-To: <CA+H1V9wD0Ndrnt5bV85nJPd7Go3gbyTs0K5pZBCybvwbeB3z3w@mail.gmail.com>
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Fri, 3 Jun 2022 12:05:16 -0500
Message-ID: <CA+H1V9wbYyBLH550-kUNNzAYJ9QRfCjmdi6yFrhos=u7t8W8sg@mail.gmail.com>
Subject: Fwd: Manual intervention options for csum errors
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> >> This is not a good sign.
> >>
> >> Such bitflip can only happen in memory, as if it's a bitflip from disk,
> >> then it will cause the metadata csum mismatch.
> >>
> >> So this means, your memory is unreliable, and a memtest is strongly
> >> recommended before doing anything.
> >
> > I don't think that's the case. The files were last modified all the
> > way back in 2020, but there hasn't been any file modifications near
> > them since the end of April this year.
>
> Since the bitflip is in csum tree, it doesn't matter if that specific
> file get modified.
>
> Any other file modification can trigger CoW on that csum tree block.
>
> > There's also been 2 scrubs
> > before the last one where there were no issues at all. Does this mean
> > that at some point in the last half month (since that's the time
> > between the last successful scrub and the scrub which errored) BTRFS
> > read and re-wrote the file to disk?
>
> I'd say yes. And it doesn't even need to modify that specific file.
>
> That's why memory bitflip is so concerning.
>
> Thanks,
> Qu

Would using BTRFS raid 1 add resiliency to this particular issue?

Matthew Warren
