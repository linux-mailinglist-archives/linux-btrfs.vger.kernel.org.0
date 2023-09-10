Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A354799D72
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Sep 2023 11:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbjIJJRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Sep 2023 05:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjIJJRY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Sep 2023 05:17:24 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED8ECC9
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Sep 2023 02:17:19 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-64a70194fbeso23714786d6.0
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Sep 2023 02:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694337439; x=1694942239; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JxIk8v6+j45HjplK2bvQfVGZCGfurpRwYWShuptrI8=;
        b=cLGeAR542H5Ev7J1OsER6FhnsqtO3gsZ1x0/uzQN9njRgpbN603SVouwM478uw9egg
         sNmaw1+e/44HMJDl9We0xitbjDYXNMnrgUhAT29v7u2TV/RqrxFwI4ucY+cENFYTpCvD
         7fywpcscO2LCwxbMraca+iwGv9M7FkbGCEznnsVlOXu+672RJlPB0mdtNxdmivlH/6pH
         cV6Dj05PcaSxIpZWD6BkUCWQ9VTk54zah+vV1L/6jRpWfMUrxgRe6nPcVz33/kghe4Ff
         1fJKzEyzRmXBB+CMLArssSieQ+AM+T13wrdnDpaNcuucv1nUcmmUsEhzneTY7Tuo10F7
         0gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694337439; x=1694942239;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JxIk8v6+j45HjplK2bvQfVGZCGfurpRwYWShuptrI8=;
        b=nXQANE76FwSkHTRLX20ZywQrCbNhxvN1ZQJZ2xoou1bsuJ44fBPnJfCYIM6hpdd1jk
         bPkLUw2oaVYibD0/b5Pb6SIR2xJaHRv9w5+IjiaY1JM4LZMFEYeAhbg9Y6GKg2hJ5ack
         krvtL/kU1Mule4r58xsVwpMP6aOPn4NemzeOHdQ3Qx2tGbVKOsHwkCRS0EWmJxJagT59
         v7S6Ql6aYRvt6uzMFzgjHq3hT8Oba+KjeFso7n5sDPnq9doPLacvy/skZwcIeZFVrpcy
         Up8djVvR9uu/ekyv4y9cVmWNTk5t8oE9xtuDCtWKIBW5+3wEkuV3MEf4CrsTrgIz6bQA
         CoOg==
X-Gm-Message-State: AOJu0YzNjbGhYvEHRIcTEfJPnN5ERvhLqEsl41/3vSB3NhZvv7+07OrW
        kbuTN0rMtqm6BLEiKzpLRHPSVXFk3HXd0dd9y1A=
X-Google-Smtp-Source: AGHT+IEOfA4uCTKVsAECMz2qXKng6Qc8hXI6oyTZ6mH/jqmOR5kWpQGjvlTuPXFROclUxLEkGwA+NADTF+n/YUdC62U=
X-Received: by 2002:a0c:cc8b:0:b0:64f:3de6:d502 with SMTP id
 f11-20020a0ccc8b000000b0064f3de6d502mr8052741qvl.5.1694337438560; Sun, 10 Sep
 2023 02:17:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:4c01:b0:634:9c6a:f3bd with HTTP; Sun, 10 Sep 2023
 02:17:18 -0700 (PDT)
Reply-To: krp2014@live.fr
From:   "Mrs. Kish Patrick" <mmrskish@gmail.com>
Date:   Sun, 10 Sep 2023 09:17:18 +0000
Message-ID: <CAF2A5BfvF1yh4EAJni6SpPkepzhwV-NQSOgoz1jCXRwp05+j3A@mail.gmail.com>
Subject: CONTACT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Dear Freind,

I have sent you two emails and you did not respond, I even sent
another message a few days ago with more details still no response
from you. Please are you still using this email address? I am VERY
SORRY if sincerely you did not receive those emails, I will resend it
now as soon as you confirm you never received them.

Regards,
Mrs. Kish Patrick
