Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25160720C33
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jun 2023 01:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbjFBXKx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 19:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjFBXKw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 19:10:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1E51B9
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jun 2023 16:10:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30af20f5f67so2616480f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Jun 2023 16:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685747449; x=1688339449;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nRQM9cjrzNSQPNM0dnQtpJMkxv6mz1U+Ixv4UXAl70w=;
        b=HkrZ0AbJ17cVShCnF05KdvKugFeAc3EYbtQdcu+zVzV1hthXcFAgOF6tDXRg/1H5JL
         8BqgQqNczkmtGCQbid1sc2P/iPEEKhuMn79zZFU0dIf6x6sNxI1d0cZSMtsB1AYac0en
         yJX2aHrKLYc69OS/u3AVvwu55cC1a/9JZSuHtbVjJY8AFD2nwbi5jFn1Z6tFNykK4KLw
         0+9Jx5d1X+jolYtUCd3Onqgv4HO6BAbpPymz2Buh2Y0ij4gU7UCTVL9pNu/rs2NDrp3l
         2lNKxP68QezGM3gta12bIY0U7Xbi40z74kIkG11T4dOlcGnPQ9QNj5uJC1KAbMeIZbSF
         VHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685747449; x=1688339449;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRQM9cjrzNSQPNM0dnQtpJMkxv6mz1U+Ixv4UXAl70w=;
        b=UEENtwV3Y3AhYdd5lB3KXuTZptc02yZ/sbSR/E1+pwy9FVirdrP65ryzSfv6kNJOQ1
         0FP7650io8DvJKmkUB7ulBHqWWxdN39bCtkzMfzwRrQwuW5JomdVRAoEiXNrBVXHqv50
         t/wo0H2H4Bg55Uzs4cPrlCwlMioHJeNWUsoOXwNhm7ENZ7YjubHTC0HfNfuPPQUN25Hn
         uEbaVtz01dVPlYYI9GAQvniNWzL/Op6vWodH1MQ62SvIbrcHW5BottQxnzy+yQlfnYrO
         PMBeLowx8Z4VOBKlTWuuZJt4DW8cNEC+CPUQKCnjt/5flhDbsxiUgSKTQptbfWY1/0+T
         mq8w==
X-Gm-Message-State: AC+VfDyMJr23K8pfVYF+8/ZCgUjM+VoBjUWqHqY1WfAWVcapz6XwcRw1
        Cw67Si/1V1c3S59QgiF25/kLAHsD/KF7bW6F1P0=
X-Google-Smtp-Source: ACHHUZ4swAD6mKilF6lhrA6VDpx8Y2fqljNZk4vU1hTUkDS0xOvEIeFpqOalGutEHVR+fWkzkXxAyXOMdcfDfhnBY08=
X-Received: by 2002:a5d:4d90:0:b0:30a:e65a:1b14 with SMTP id
 b16-20020a5d4d90000000b0030ae65a1b14mr998795wru.28.1685747449527; Fri, 02 Jun
 2023 16:10:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:de8d:0:b0:30a:e642:e738 with HTTP; Fri, 2 Jun 2023
 16:10:49 -0700 (PDT)
From:   DAVID GABRIEL CRNDDG80M31G113I CORONA <cliquesuportecn@gmail.com>
Date:   Fri, 2 Jun 2023 23:10:49 +0000
Message-ID: <CANmzWWtdF6FzzwuEfsmcsOMGh8p9cz0h_8AdUh4xpma0prgcPQ@mail.gmail.com>
Subject: Franz Schrober
To:     Jonathan Nieder <jrnieder@gmail.com>, jw <jw@jameswestby.net>,
        kim phillips <kim.phillips@freescale.com>,
        kovarththanan rajaratnam <kovarththanan.rajaratnam@gmail.com>,
        linux btrfs <linux-btrfs@vger.kernel.org>,
        Lars Wirzenius <liw@liw.fi>, lool <lool@debian.org>,
        Pierre Habouzit <madcoder@debian.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_20,BODY_SINGLE_URI,
        BODY_SINGLE_WORD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SCC_BODY_SINGLE_WORD,
        SCC_BODY_URI_ONLY,SHORT_SHORTNER,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1817]
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: bit.ly]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:429 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.5 SORTED_RECIPS Recipient list is sorted by address
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cliquesuportecn[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 TVD_SPACE_RATIO No description available.
        *  0.7 SCC_BODY_URI_ONLY No description available.
        *  0.0 SCC_BODY_SINGLE_WORD No description available.
        *  1.8 SHORT_SHORTNER Short body with little more than a link to a
        *      shortener
        *  0.0 BODY_SINGLE_WORD Message body is only one word (no spaces)
        *  2.1 BODY_SINGLE_URI Message body is only a URI
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://bit.ly/3OUU5wt
