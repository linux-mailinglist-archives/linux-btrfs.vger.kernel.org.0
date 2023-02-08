Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C233B68F0E9
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 15:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjBHOeI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 09:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjBHOeD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 09:34:03 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345A81D91F
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 06:34:02 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id y81-20020a4a4554000000b0051a7cd153ddso957438ooa.10
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Feb 2023 06:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ISmrNvL/NJV9YBEcOBUIrlDQoxhRg6SvGetQbseQjmw=;
        b=kA7ad/h0XxK1McTTGPba9T/ch0NZ++mp9r7866pJpWYC6ql5+SDiZlHEqku/H2luxJ
         I81buyQcDQZ7hytpAblPmy3EaEDSCCta/7w52fvlYPTBdKqIIoUn96uhXVeHrVMDsQty
         +MAan4t4GqPw2isAA64KDum/4wyyYmAQBGXUkvABvPJAz5TPgm1k7qjVTzE9YljYbXdA
         eQa7ZSA3flU1XIOyQ/4S5AwWANsp/uajFl/fTj5u7m1w0EwACv9JyjYHztafduA/vC4x
         6/RpV2NhXTj6n1ThlpeMV44n2Dfe0d4v92ihT5+PJ8wHYY7EQa8+Bt63hlm81cCO8wgu
         Rnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ISmrNvL/NJV9YBEcOBUIrlDQoxhRg6SvGetQbseQjmw=;
        b=bMzspG4Shm3kK5QOYU02XsPJbi7ZE7KjLnVwctICE0dfp8MMg7+T7Ghvn9cweXU/YV
         1AWyh9eFAc7lr8e9FeCHgC5e+Ig7n3JeuG9iScmey3YNwb191SYGnDDti1GbQfjag/Uo
         G1lOatr562olxW5n9ZTQfVfSLyU0t5YA8QeLRVP6PjX7euK+QcTorMyYGa0SMKvAy87H
         yEP631sc41KsmHMbF3KD8LFf9T/BgSDyDbqsQSzQGQRiBK/UctmJ4Iqt4jXPKJ6kmnQf
         AK6iyE7KeKW5VFqfTAwfID3VVzzk1kbZ8udOqN9/MoBmQHpwfldnXiIwgEYfc9C6OyDc
         NuwA==
X-Gm-Message-State: AO0yUKX1gemQbcm6lhGTH25U+5wyZHDtci2Yxl4PJJ+ubblQIz/vebko
        DdvZ2ybNPbdYAwK2lHg7ZFAhDjrM3KNpb7KKFtWCbsCm3UE=
X-Google-Smtp-Source: AK7set8mSF695x6YLdZkobuuDSb1wjPsV9C3sHVapbdZDqMQZBmPq5Mds/Huzf74Fx98F9ALOFrwCTEiLIknVygDPA8=
X-Received: by 2002:a4a:929d:0:b0:51a:934a:6f6c with SMTP id
 i29-20020a4a929d000000b0051a934a6f6cmr317427ooh.18.1675866841238; Wed, 08 Feb
 2023 06:34:01 -0800 (PST)
MIME-Version: 1.0
From:   Paul Boughner <paulboughner@gmail.com>
Date:   Wed, 8 Feb 2023 09:33:50 -0500
Message-ID: <CAKH6Scdg_BXDo9MR9O-RosM-VbR2Uz7Or=d_5-x3FSMSu75ziw@mail.gmail.com>
Subject: =?UTF-8?Q?Leap_Guest_OS_in_Vbox_parent_transid_verify_failed?=
        =?UTF-8?Q?=E2=80=A6=2E613771_wanted_613774?=
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is in a VM so I am not sure how to get the log out and everything
is in images.

 I did a dumb thing and hibernated my Win10 host with the Leap guest
still running then woke it up, then hibernated again, repeatedly 3x.


thanks for any help in this
