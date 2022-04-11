Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02004FBF9E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 16:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347354AbiDKOzI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 10:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347487AbiDKOzG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 10:55:06 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D1139B81
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 07:52:52 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so17444548fac.11
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=n1xsHII+fJ6VpoiXpHNhz7wBViHFn56CyGZ2aQJLjKdBFBOYndlF4puueyNaaKz793
         5HNG0iWhGk8lpvQYKCHUdVrBaKhmhz3+r50yqPkV2errAvfaSf0GtHgkF92SQ3kI6crU
         2c85l8hWzpbk1WR0DfKXr6fga7gzJfb6M/OjJGShpOxxTFubLrt/Ii3YadmruWdYcHP9
         iDVsbQFXKDJwHiheMUSjDYALiSxpdyjspr496+ZszITOliCO2v7/MCG5CA9ujgCsyjYP
         FWCX9HD+TaQ0CAgjrNNDHa5pnspT2lLdfLZImyT0SNAKts80oHhZDq3JQJnhSN63bvCg
         GUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=oIZ2ggWD6Z9ndqPirQ5/DUYCE2aR5iu38NlRazx5P0zyJHodc3RBx6UNPB6Clv5m5W
         2fmzHJT9scbUFEgdWj3ndOsB9j9DqwOdBTn8gyrX32n7RM4MP5dDdH98t47JbfMThaR6
         NZGB357Dr6Tjvo2oFhOGuGWmsYruQePn93xJ9TuWiRR/LnyUpHrmJE/2OKW2OAooZyCs
         XpEOnyEk1yvoioUWOwMGzDYA0ZxVPh3vsqjZDUXg4bCXcJJ9oXJUdEjiCxp4VGa7ReRS
         Na5r30P9rdddG8ttQ7DR5fjiIaou1VkC99rgBb7Eyln21MEIoLx1w1u4crZso5s7cpCz
         RTWA==
X-Gm-Message-State: AOAM5332nJtrlCS4wWd3bDUuVX6sih8+yHyt8wtC/kaEIu2czSKQZIE8
        Ktelol8aaHKHW4RvTT0rqEt/zji/eHPSLNuNRzc=
X-Google-Smtp-Source: ABdhPJy+xt/k4MS5VxWiKx2SV/XYjoJX3L0LlKwe4QPJ45hZOEdPuI9sxQXyCINW+qOwcImHo1+Tfj0XldfMUunCU0s=
X-Received: by 2002:a05:6870:d355:b0:e2:6def:5892 with SMTP id
 h21-20020a056870d35500b000e26def5892mr8943323oag.50.1649688771649; Mon, 11
 Apr 2022 07:52:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3bc9:0:0:0:0:0 with HTTP; Mon, 11 Apr 2022 07:52:51
 -0700 (PDT)
Reply-To: davidnelson7702626@gmail.com
From:   Tibike Amah <amah.tibike@gmail.com>
Date:   Mon, 11 Apr 2022 16:52:51 +0200
Message-ID: <CA+Yd2rCUAZb1gK-Adye1amV3Te1riV=sqzhJaxc42zmMHaH9FQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4555]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [amah.tibike[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [davidnelson7702626[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested.
