Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF308582563
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 13:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiG0L1d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 07:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiG0L1d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 07:27:33 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B23C42AD4
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 04:27:32 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u9so20425190oiv.12
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 04:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=m3csfU7DGyV83X6zJlkcQN6Z1nTINh3JYfhn02mQF6g=;
        b=SgdlbftESL9P6JhmyU504HHEGu5SgG6I/5N8TjrxIsNWpTjbPz0bvZ57Bou74Vc9qW
         NklSkgPLeqyVcaKNEJk1mY3FPZFBKmvs4vM+w/+5dagF/uk/Lp6s78iiDm6une/uYWHZ
         k6Y0z9g7AjiT1rSuo+TU+by8BJr+dq/6cIkIQzkbprI66yt9KOAsXv7GjnPVtKVh+1pU
         PEar6eMrhR1e42CMqhD1qhx57NFu1PNn23SyyFaP4iXLOdIoyLWmZCiT8eIOr2QxLV7H
         EbUgSDIzOpgkszivA2rUtk00zSZJ4ybRsJhDJeNGAT7IvBKdIQ4vyZMSTGi4Pwr3BAFe
         Uyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=m3csfU7DGyV83X6zJlkcQN6Z1nTINh3JYfhn02mQF6g=;
        b=BJO02p7szvInJf/qeoQliq2BEncsnoZhGKVOHrdJDbzdY0QDYptFJFeCA9Syv76I1m
         NSE/v6A1raI5/ayGm+VKRFFTxubKvtrpmA92Z9NhuMQbdUg+7q+EwiefEq0n2IR+QIbO
         We+PlXbH/SccCul9vgYZRiAwj5JESAj3rLLHtDbIC3mkAkJFw1pDJuv/82j1Lj6NNF0e
         pSWPMvvtsBnO2lHJrkU/xp7U/0kkHtNhajc+jJvLIVe7KFq8mUGBFKzy69CxjX+e2JjK
         Pvdm+fK9tKrQyPcPKZgQw+PfwdNI0VSIvJHrL36esmgJKIMmLcGpSLJtvgutdlK4E+Ov
         nyKA==
X-Gm-Message-State: AJIora8NR6IdndpsD8ANVQhtUQnu/cFaSVAA3zpVQQSKibjnzp5xQptn
        Va2moQ74zyPsT5rfPe3ftwaNsKJAWfF69tMEAcE=
X-Google-Smtp-Source: AGRyM1vs7j6tjrpbQOAW2FTZWKzVzaeGXDqAsgY2e1AzWZQRQV+OLt2Lf4yEr1bfhhYNoZbDcibOwhG23vZXVdSx+wU=
X-Received: by 2002:a05:6808:2121:b0:33a:5639:5bc6 with SMTP id
 r33-20020a056808212100b0033a56395bc6mr1493956oiw.160.1658921251486; Wed, 27
 Jul 2022 04:27:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:bac4:0:0:0:0 with HTTP; Wed, 27 Jul 2022 04:27:31
 -0700 (PDT)
Reply-To: fofoj6432@gmail.com
From:   john fofo <fabioverde047@gmail.com>
Date:   Wed, 27 Jul 2022 04:27:31 -0700
Message-ID: <CAMRdTVXFbGUFJsitWy7Uwd5xV4PdTyUuzsP_zY6AjEnXKCw=iw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:235 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5624]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [fabioverde047[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fabioverde047[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [fofoj6432[at]gmail.com]
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

Good Afternoon,

How are you? I guess you're well, i sent you a message last week, did
you read my previous email? get back to me upon the receipt of this
mail.

Thank You,
Mr.John Fofo
