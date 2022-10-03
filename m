Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559975F33E6
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Oct 2022 18:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJCQuJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Oct 2022 12:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJCQuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Oct 2022 12:50:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415CE13E80
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Oct 2022 09:50:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 70so10372763pjo.4
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Oct 2022 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=cubVFP7zDImmpnED/dw6Kl2vj4f5AKwZtJ2VEStPEhs=;
        b=ltgSFZeIyFA4YXp5CZOv4aqZ6uxT3nmEVtPxsGhDDS0myS17FjSxeETG90U+NnN4SS
         kTXLFWWyVobJg9+xz5jDMoP1gnqi5zatNd9DzjDvFzbQ3/SbO/K9zW3zCZkncZKKnfhy
         JxqFH15dS80pE5h3X83bYOsknIwS2+gge4XHVyBPSCkot50Dkk1YLBVv0n8/TuAt/doR
         bBZ6gps4Iu+T5FGz5lfImyZOwxBZ3awFCZ6i+n9jAO4AHVg4lacA5VeQl/MbSX7x98zs
         S4MTqX2ltyoEGZNgnX70IVOhZKKa2hKmuOjRcCsYp4t+kXHVtKyDVbapM3fEFymHjBiR
         Yz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=cubVFP7zDImmpnED/dw6Kl2vj4f5AKwZtJ2VEStPEhs=;
        b=mFaPs5CdD8kyzD/UTqpDZcAChdubrT7ix6nDSOIk0iMiEV5CZDJSUQvVnjIhnC2c9N
         fRjM9jmlbONQNcA+EFbUVdwwhEBoBXN/VIZnFS5UnegQtD1nF7KhKtpMExPMSnWaKHCR
         y+Uu3tvG5jHgBSApDfl0kgpKt9B2tZdLCi9Eb12k7WPzzyuG6Dn2UJDbLJlPJ9OG3aqh
         XQf8A+n2ZVJvdBSEC+U4u+t+JMjrxh1cShqy2nA8pwvMm7Hw0wa5ursuSC90Dw4Iagh+
         0jSb1ihMr3T7rk6i5z8SXXZ4fot3h6wkP3m8Q476lc0AZ5hjmKOdgtdZjScbkoLET4RE
         Rt0Q==
X-Gm-Message-State: ACrzQf3b1yNKQAdsinTUijWGlUwX4Hsnup+LOhOYaOJdSyEZNQztaF8u
        eWywHVR7EtEOisNFGuqkwEbPT0eLN6QLQIqMKuQ=
X-Google-Smtp-Source: AMsMyM4qGlsIRa1HQWyx6UyrooYxzd9pwD96W32Q0+gph+gIe+GrHiKPSsjEc8m+ZbDKCLS1cxC6eNzMc88KGqQNAtY=
X-Received: by 2002:a17:902:dac4:b0:178:42d4:dcc9 with SMTP id
 q4-20020a170902dac400b0017842d4dcc9mr22537178plx.167.1664815803801; Mon, 03
 Oct 2022 09:50:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:d144:b0:2f4:d1b6:a0c5 with HTTP; Mon, 3 Oct 2022
 09:50:03 -0700 (PDT)
From:   Redwanul Numan <redwanulnuman43@gmail.com>
Date:   Mon, 3 Oct 2022 22:50:03 +0600
Message-ID: <CADuPiO-t4hbFqR6XchiuKh_1hvGwvB0hcstBpcGeW_No73Z10g@mail.gmail.com>
Subject: Fw: Franz Schrober
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Jesper Juhl <jj@chaosbits.net>,
        Jean Marc Valin <jmvalin@jmvalin.ca>,
        Jonathan Nieder <jrnieder@gmail.com>, jw <jw@jameswestby.net>,
        kim phillips <kim.phillips@freescale.com>,
        kovarththanan rajaratnam <kovarththanan.rajaratnam@gmail.com>,
        linux btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,GB_FAKE_RF_SHORT,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_PDS_SHORTFWD_URISHRT_FP,T_SHORT_SHORTNER
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1033 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [redwanulnuman43[at]gmail.com]
        *  2.5 SORTED_RECIPS Recipient list is sorted by address
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [redwanulnuman43[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_PDS_SHORTFWD_URISHRT_FP Apparently a short fwd/re with URI
        *      shortener
        *  0.0 T_SHORT_SHORTNER Short body with little more than a link to a
        *      shortener
        *  2.0 GB_FAKE_RF_SHORT Fake reply or forward with url shortener
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://bit.ly/3rJsy4l
