Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD0F679D99
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jan 2023 16:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbjAXPea (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 10:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjAXPeV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 10:34:21 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3954B4AB
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 07:34:14 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b3so24037490lfv.2
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 07:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jo2uaUWCnGPs2Qiu0WPugIPlQhTGjXEujLrHd3U+iR8=;
        b=Lpwgjul7tNPJr3sSPWAtYFvU9EaphkU8OjL2wWpyDhkxHWaotP+xCRxHjo3LX9JTfj
         KSP4R4YLhlHCLJhi6VouEi5J+F1vrv7vlBXFagqa3nUxwj5L9UHpyV60nhd1UqESFMUj
         t6lfdsdA08D2XjFv+UP8IzCJMCBo8mQ6Az+3mrOyeuqE8MbZpBRNYu1y2RND5VzuQgWP
         43vdWeEEMzg5IL92KSBOXiO3t0DHWgZWnSpS5yMfIdr7bXO76cXFLYXtyl9KFm+gQY2o
         9ojdHO1vnShbsljiafMEweoq0/lPoi2DtljyFqIfup+Ma/qyJSRgci10zfMQ4rknNwdY
         57YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo2uaUWCnGPs2Qiu0WPugIPlQhTGjXEujLrHd3U+iR8=;
        b=UqB1liTghxgiGc7GFp2SJJ5mQKpUtj9a2iQLvHjmJAE/0+1k43GtAMaBdmYVBkP9VM
         nUkM38+FOBFh+hAgn4IbSfiLJOGBfEWp2qp0aUwUec+8HIDvhE9mMsFyu+J94g8qmHRf
         KsbPcy2AeqWihh8Npc6oh3FBMgOsUPR74O5GJGQ7QZJfJ9ZSQgsIvQsiyeZfzpWiWv/u
         9V0RyZmbDZRYVhOxr1FRHsY1MYPilz4ybw96+i8tR7huD4UIwkgCo3LRBJy2MSQNN+Ae
         cNLWx0OBOmvwMIz+3WXB8w43SNNvH9NtpF08/C+Snbq7uC7r3HcDh/2oid7PhmgT1+nE
         rlvg==
X-Gm-Message-State: AFqh2kr7W3+hvXjkbwnknzF85vuILFppVpQb3R32ZkGpgNKma86kM6CQ
        UbU+AKPS9gFNtiPPUXan2hh2BZ6nq6ArwKMXjWM=
X-Google-Smtp-Source: AMrXdXsCoy279Y5E/WgKv6h5unwPorbWlrQASIZYHjsjGh6USw1/UcX8qn2fDiatg1h3ADULAD5tQ134VPx33/zEEvk=
X-Received: by 2002:ac2:44ce:0:b0:4b1:b7d0:21e4 with SMTP id
 d14-20020ac244ce000000b004b1b7d021e4mr2346498lfm.72.1674574452653; Tue, 24
 Jan 2023 07:34:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6520:2586:b0:23f:164c:b173 with HTTP; Tue, 24 Jan 2023
 07:34:11 -0800 (PST)
Reply-To: kl145177@gmail.com
From:   Ken Lawson <davidwolfgang046@gmail.com>
Date:   Tue, 24 Jan 2023 15:34:11 +0000
Message-ID: <CAFGUgZttq9WfV7Ej-fRGOKbG9UCiaq4A8zDgf+nk10Xneo4Vhw@mail.gmail.com>
Subject: I am still surprised.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,YOU_INHERIT
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6662]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12a listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidwolfgang046[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [kl145177[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidwolfgang046[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 YOU_INHERIT Discussing your inheritance
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Best wishes to you and your family. I am still surprised why you
decided to abandon your family inheritance fund I just want to inform
you that the bank authority is not happy about it.

I am currently waiting to hear from you, for more details.

Yours sincerely,
Ken Lawson
