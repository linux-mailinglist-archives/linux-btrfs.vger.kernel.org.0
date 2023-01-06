Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DF665FE42
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jan 2023 10:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjAFJqq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Jan 2023 04:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjAFJqQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Jan 2023 04:46:16 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC0A69B15
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Jan 2023 01:44:47 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id jo4so2335441ejb.7
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Jan 2023 01:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlVDLzJGanbto4J5WaQuahd4zx7ayW+h2jsNvaLoGX4=;
        b=LrmHRdr1Wt7PGtlF6VHxLO6aD5MuDP9YwOwtZvJcaX/CKj7S+83D4YnFQCwLCyvoKc
         Bw0a0zlEJzUHjqeXZbmxrsgJZ7AHbVnQU3FvJ279rhrLvmUfqwF12diK3NFVCFV2bPG5
         cTorqrH9VK8RPW+IHLf1Jy95gPAL4g0NbBfMjqp26in9/8pQzcQeKpb2VXAZz/2PiZZo
         TXw9PKPdyWOd94pY5Z2ezaNd02j+27SXYncyNZzUhlSsEhvEY2szaW9cB1mPNWZ+AC2G
         34XuOHmaEWgR6OcL3oom5NMtT577XyWyOPbfd9i5NDVATLN3ZcxbSTHQSFB9s4QqIX36
         Z35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlVDLzJGanbto4J5WaQuahd4zx7ayW+h2jsNvaLoGX4=;
        b=1Nm38lmXu4lzAwnN+tg99bD0oT7DJpM2/CMO1HxDU7Ez0l2LPxNy/PIiCwzHr4OBm1
         cfoPhIQpzXjYb1aABMostdfAC4QrziNQ3fLbvdAn7zyg3Iug+8v2CR39t7torRQBkQ1M
         uDb0CGn101Gy9YZe3u6QZFrUtFpu1xNaIux2YqmDlUB+y1YnYX1RTqx+tw4rcds+O2oH
         ItmM4wf/A5MlagC56UwvcY26UUklklXbEJRTy8V8QP99FEVHx3d/jeWKnymC9PMsM5Pk
         GASm/nmavNBTwnYy1g0UnQVjT/sbiankSmiC/SqhbbL/9g4UXI4jPx5MkRGFwzhJAyeA
         IDPQ==
X-Gm-Message-State: AFqh2kqtI3cSn/q+nxJUZQ2J/AEAO8Wusu96pP2ccMVvcxkxJQrEjrUF
        j1r5YrBrhuh3MIWgU8i/uHoXGDZUdWYbvwGEIwU=
X-Google-Smtp-Source: AMrXdXvm64IXEFXC6ttbUewbZlNz7Ng+4MCJ2TOkQljDXfpS0Gj9MyTWI5MvawwfpQWz68GaFxh2nRi4gm4OebY6wXc=
X-Received: by 2002:a17:907:a803:b0:7c1:702a:ebbc with SMTP id
 vo3-20020a170907a80300b007c1702aebbcmr5782792ejc.288.1672998286272; Fri, 06
 Jan 2023 01:44:46 -0800 (PST)
MIME-Version: 1.0
Sender: davisalicia887@gmail.com
Received: by 2002:a17:906:d0d5:b0:7c1:31f2:344a with HTTP; Fri, 6 Jan 2023
 01:44:45 -0800 (PST)
From:   Aisha Al-Qaddafi <aisha.gdaffi24@gmail.com>
Date:   Thu, 5 Jan 2023 21:44:45 -1200
X-Google-Sender-Auth: nBxBFNDqxtxLY48jximc0OP39gs
Message-ID: <CAOG5YLRiMjjSCSW5B_gyqhiY-fk+tRAVm7Twf9yN-PWTO9sroA@mail.gmail.com>
Subject: Good Day My beloved,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        MILLION_USD,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davisalicia887[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davisalicia887[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.5 MILLION_USD BODY: Talks about millions of dollars
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Assalamu alaikum, I came across your e-mail contact prior to a private
search while in need of your assistance. I am Aisha Al-Qaddafi, the
only biological Daughter of Former President of Libya Col. Muammar
Al-Qaddafi. Am a single Mother and a Widow with three Children. I have
investment funds worth Twenty Seven Million Five Hundred Thousand
United State Dollar ($27.500.000.00 ) and i need a trusted investment
Manager/Partner because of my current refugee status, however, I am
interested in you for investment project assistance in your country,
maybe from there we can build business relationship in the nearest
future. I am willing to negotiate an investment/business profit
sharing ratio with you based on the future investment earning profits.
If you are willing to handle this project on my behalf kindly reply
urgently to enable me to provide you more information about the
investment funds.
