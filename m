Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2202D5BE91A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Sep 2022 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiITOdV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Sep 2022 10:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiITOdT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 10:33:19 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196043ED60
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 07:33:17 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-127dca21a7dso4411316fac.12
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=mPcUwETCcz/kwC7feIDvw0Zba3K6sFyvY8HeiPzBoUyMkI7CUHI4KJoLXtc5+9KJmb
         jMGi0vqC26v0O6GTZ2gcquBKP19V3EWGtE3C3MyBgQuDK8V0fKONgEOuC8VdosisDwjH
         qN/8NMT2HZgCcaK/V6L1U8UuNCDUo5Db4KqtcJqijj4dOw7b+PUXk0OXVCOmAzHZAMs3
         8Vq8g98tT69TKEoV34ySK7ELYQoaZEONQmX4Xh6a/gwYhLhGuGBjb6gCronQ/douw+ho
         smHdZs2+fLuUITXklMH9DIJw0EO1NssJxTXOAiJ054L8ygNpJnngCHwT35T3vv39PdrM
         jKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=G/1iQ0Gfo+iNitQt3KyEsd83LxMLA8qTDh3IP6Ye1mKPDBWuUJUoME6MHYP5RDZiSI
         0vTmTyScPHQ4VSIS7HbPNQ7btlS9R7DfmyABFkPAFHE1aHdQ/ksQnGaT+Br6ohaF0XCk
         4QPeZgVWYmdK0XMWzUwnuLTqbzOwVZ+/FRBD/XLUcvUel7jlKLJEs1j+3OCXS5DcVaOd
         qDAcv9G6t2L/IGdnZ6JtscbA8FQ6EnYjUT2nSlzsVwYoUB01zxDW+7jSXnAN5z7tzSC1
         OpOH5ft5Iqw2M2FmWL3emn0n7JITCsZCk9vATWHVmpIqoBwNBClPkDY3qVZZzDYvmPUC
         aO3g==
X-Gm-Message-State: ACrzQf3Rq34UzZGmBj14EKXmyI4U02dUJDOpgWPeEw4NzzWi40LETXGo
        LjUrbEWjkBlIS/2N/iZxsGp+8SCZ+9gIyInMdRU=
X-Google-Smtp-Source: AMsMyM4h/OoaeEP/f7hs9gobrBCgnoNGAzqBZ5bd8G6gT6l2Qq2HTKi4C9mF6UhyZNlYXgWeS9LD96UENa2WbPr6QQ4=
X-Received: by 2002:a05:6870:46a6:b0:12d:130c:2fd5 with SMTP id
 a38-20020a05687046a600b0012d130c2fd5mr2175748oap.92.1663684396231; Tue, 20
 Sep 2022 07:33:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:7e8a:b0:a1:ada:7451 with HTTP; Tue, 20 Sep 2022
 07:33:15 -0700 (PDT)
Reply-To: linadavid0089@gmail.com
From:   Lina David <desouzabayi7@gmail.com>
Date:   Tue, 20 Sep 2022 15:33:15 +0100
Message-ID: <CADVjuPpOvzXnnSNjO3CWfP_EKB0yaDjKLVLz0mEvEe_dphe4kg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4993]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [desouzabayi7[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [desouzabayi7[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [linadavid0089[at]gmail.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2b listed in]
        [list.dnswl.org]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello,
how are you?
