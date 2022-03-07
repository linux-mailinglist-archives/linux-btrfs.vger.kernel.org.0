Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D214CF18A
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 07:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiCGGGS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 01:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiCGGGR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 01:06:17 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE75E140
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 22:05:23 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id x200so28819575ybe.6
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Mar 2022 22:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=7Im1JG6q3q15hqSa7NWQHVGGERLfnPf1iBbuaSTqgJQ=;
        b=TQ0BwsYstfqOsn49zv+NzmJtUmHkotHjPr1nCjW7gKsUhf8LUkRHUE2KoeruZIS9zF
         yV8BaseJkjREWWuJwQIA7RzGFa/lIRLSdFmSlP+TTz/i1/6QfmS28iUBYaSRwm8DR6Ic
         /KudIiahdzxJaZ30UNRGyOH1W9+0D6V7dLO8Y/BpUiqbFa59UnO22f+graMEDVnbaGQk
         yeRGlmVNNv9LHA017IGiqyhtrnFNp2L+A548+6+3XHBXB2fSkz4LszUFFXpJNVvEgof5
         DBP3HcI9J4I9i0QhdeSDCzB7l9UytUe39Iib1ABlgRgtvNKVT/Gv6Pq3jxbs1mhCr/xP
         qQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=7Im1JG6q3q15hqSa7NWQHVGGERLfnPf1iBbuaSTqgJQ=;
        b=DsLtXPnTpzvInyyw2PyRkiciCBX9QPitnrfORQcmlG06NST+d3vqgJpMGtGBaUiye0
         m9mleafYY6PaCYDLr3ST6HdWzkshXPKwGp+SeiS5NUCOl/QBYGxgNUyLHWuAF3zvKW5N
         0/INl4jWY3tCMxntB7fw9lUa5Uo9JOye3n8YsacuoVEhFBDyNmH5Mu/5dPf8t/sRARtY
         e2KO4yc/GpeZ1FFJNVEZwK1dCbxHjgCw4uSo6et0OUTmFrH3Sj2fdSMRJnFVLPMjyP1p
         YgmOjFD+w1koHi5491VQjqOGPReGYCnGppqk7neJnkmfxFZ5iK0xKgGk/uEbCV4oLzF5
         Nd7A==
X-Gm-Message-State: AOAM532oG2iksJjOObzzwAzNze2Qazro8ucjnWuqc/nDXctes21zhgQV
        gfAzKc8P0pJ9quulVGOHZIHvusYOsfjfcWJpXFg=
X-Google-Smtp-Source: ABdhPJwNN8VsxFBd3fGmY2V1Ba2dmEy7DwhqqwVafZ58ryrOJ/a9TzGG2y6VdYUNFnEHLhJ5/dAGDSdDFlOH18v/LMI=
X-Received: by 2002:a25:d505:0:b0:627:f53a:ae02 with SMTP id
 r5-20020a25d505000000b00627f53aae02mr6941115ybe.256.1646633122048; Sun, 06
 Mar 2022 22:05:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6918:b986:b0:a4:b698:78d9 with HTTP; Sun, 6 Mar 2022
 22:05:21 -0800 (PST)
Reply-To: markwillima00@gmail.com
From:   Mark <markpeterdavid@gmail.com>
Date:   Sun, 6 Mar 2022 22:05:21 -0800
Message-ID: <CAC_St29M9Q_eyjomu9grtQmnr044nc50oU73JgTFiQXB2E6bjw@mail.gmail.com>
Subject: Re: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [markwillima00[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [markpeterdavid[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
Good day,

The HSBC Bank is a financial institution in United Kingdom. We
promotes long-term,sustainable and broad-based economic growth in
developing and emerging countries by providing financial support like
loans and investment to large, small and
medium-sized companies (SMEs) as well as fast-growing enterprises
which in turn helps to create secure and permanent jobs and reduce
poverty.

If you need fund to promotes your business, project(Project Funding),
Loan, planning, budgeting and expansion of your business(s) , do not
hesitate to indicate your interest as we are here to serve you better
by granting your request.


Thank you
Mr:Mark
