Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A87D512D48
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 09:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245686AbiD1Hso (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 03:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245681AbiD1Hsn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 03:48:43 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C5027B3F
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 00:45:29 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y74so3863747vsy.7
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=NLijoYwk7hqoA8TsUJbQbQCYzScrvalH7Lc8MykkZrA=;
        b=aVlRD9lVje9JINa+B701E819D54LSeS9zYTCXY91YkvddZCI6cpTXoV9o5CUTEspMQ
         bPxpMr3n9DQpLcappkOsUcGa5x1Fc3Qe6dn2XXG2yaPYsMlyhcJspbpLbXFkYHOgbMwo
         gIcyS006w/9sN5KJy0FUj0eemCIuo026Z9DBhfYtSusS3M12p2k8yW0MWVDADqowWU4A
         i3ZxvgNI0uT65mCE3SeSyOyVstdQ5mf4/ErWFs5/NpVmPd7hkpmZ6d3AlHXsCNd22wX7
         Y7IK/vwbyVzBeCSlo6DZXUe2wQSZiMnapYitlL9oKZjzV7hLB+ln1BDjWuGGCib0XDci
         oFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=NLijoYwk7hqoA8TsUJbQbQCYzScrvalH7Lc8MykkZrA=;
        b=JpPklLeU2EuUYEDDT7D7eyRJT5PzFCh/k7nhzQgue05n/Iy/Ed8dvoc0n2VhZBnQVY
         f6da+VNGwnwDakhs05pY5jg2R4Jvx6pLaEPJYWu7m1JGE2PPsy6sZWYyu6VfCKIQNfKI
         L8+qyKeEszx3/dp0HZMbT6fvB3SpJNzi0cm6lyiIcDHOf9vx/rXCLPv8xvoZa2hkVv/5
         V4MsgGOpFMVJJJZFkS7WhFEyaZJCs8uiSPi72VeLyWEWsxplHQ5MDYEfdP2vYOIevM2O
         8xuY6RVuZ1eXFrHA4efi4UGH3fUIzwXulXUeSevXb5jvYLDtq53BqcyOHCh/Km/Rv2iH
         Bzvw==
X-Gm-Message-State: AOAM5328FK74EjIoWuJbeOQ+qqUFqxQnN8zKgyeJ1J/IaT7rf/BQzRaU
        wFOXRch/MQLA6LlF28OSU/IHbz8Su3pZI+4OPA==
X-Google-Smtp-Source: ABdhPJybXVPCWs98j08Hfqig3naSQ5jnbepESY3K0fZx/Rr8JrRX9CSegA/eC0k40UmJtMhGXvcqadGnUEor26bPhJc=
X-Received: by 2002:a67:f6ce:0:b0:32c:dcb9:3857 with SMTP id
 v14-20020a67f6ce000000b0032cdcb93857mr5754240vso.57.1651131927957; Thu, 28
 Apr 2022 00:45:27 -0700 (PDT)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: mwibergcaitlin997@gmail.com
Received: by 2002:a59:cde8:0:b0:2b1:df2c:6127 with HTTP; Thu, 28 Apr 2022
 00:45:27 -0700 (PDT)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Thu, 28 Apr 2022 07:45:27 +0000
X-Google-Sender-Auth: -8hZpBjJiXJ3DWgyGT5K5kLykKg
Message-ID: <CAOw4te0Y8Rp4hrcHwH0oK6Qb8vdEFE+5d7yOU_8C10gsKSseYw@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_HUNDRED,
        MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I assume you and your family are in good health. I am the foreign
operations Manager

This being a wide world in which it can be difficult to make new
acquaintances and because it is virtually impossible to know who is
trustworthy and who can be believed, i have decided to repose
confidence in you after much fasting and prayer. It is only because of
this that I have decided to confide in you and to share with you this
confidential business.

overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred
Thousand Dollars Only) when the account holder suddenly passed on, he
left no beneficiary who would be entitled to the receipt of this fund.
For this reason, I have found it expedient to transfer this fund to a
trustworthy individual with capacity to act as foreign business
partner.

You will take 45%  10% will be shared to Charity in both country and
45% will be for me.

Yours Faithful,
Mr.Sal Kavar.
