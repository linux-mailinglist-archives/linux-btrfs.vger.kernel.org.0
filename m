Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C996C4853
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 11:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCVKza (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 06:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCVKz3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 06:55:29 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00FC5ADFB
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 03:55:28 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id u15so5453344qkk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679482528;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRGRUQFFD8KVrAsNwV8knnCAvr6RxFab9v+4lBG/QoI=;
        b=F901bUPKDLBHV6F7G+uPeNSNe1KfylQgWFMefaOlxWiKMzbNy4In4/M1HA1BcLK0DK
         5eY3iSXrrYj0Oy87na5zYWY4lilGAYYN2UU7Q6DLFslcabMP4h+yFXCG5zVeT5O3+/8I
         4qotiyI3jAv1u0cnxCX+gsAA3P015qqb6RB5IhpJPBB5k1MIl9l+si0m6qxSWqptXD6g
         rSblBQpaL1ewkkQpkKYHN4l5AplbZ8iz/9mm7HW9GYGFMmcSWTSrwTbW1Is8J+fWLEet
         t3DFzPD9KjpRBVFBQpGCN81qSCNVsvkkT7KMp2NOBLPDQLjDOpXRNFY4MdeG/6OC8v8V
         X0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679482528;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRGRUQFFD8KVrAsNwV8knnCAvr6RxFab9v+4lBG/QoI=;
        b=m7JxtSrRGcrHMLBZGY5n1rkQTjAmEUKIwosOJ3mjalCCIh+OTbnq8YSvur/4+WFr/i
         vaEwHzFAzmx4MoFRfpBPFoc364npEb8LNilJhxGd2FVy1lNxy/xgIu3IUpr90LbN/KI8
         JdzHK4YYwBINiPEcN/H9wKv7RdG+i17WyS2LDMamRdFjU/GIN3ShSWd8McdNfjFSFqrI
         RN5CkrzC/GbEru7wNc++z/wudbdRoJy/A8BT1zDt8EYyZ6hRcmkVWfAQwj0utJrpr3+m
         QPlsHlIqfqwIksZWMZVA8b9PRWepTQmOvssyZXbb0/Nr/mNa36jM0JTjNgUF/A9tnOW1
         3+TA==
X-Gm-Message-State: AO0yUKVTMCmMHbNuwbqYfyp0ljoqGUIFeDwV9ebAC927/2h2wSwhdkZx
        bDj4PRkzWdkhMWAsvKSTaKXRrkBWSjLHWM93ol4=
X-Google-Smtp-Source: AK7set+HP3a2md1+pj7pzOVoUpZHQjo5WLeqO6KNWv/66z4ShBwmlOPVCCmbusCGf2X/HGt50hzBVOJirzu0qalXR4Q=
X-Received: by 2002:a05:620a:4e3:b0:743:577d:d756 with SMTP id
 b3-20020a05620a04e300b00743577dd756mr565542qkh.4.1679482527883; Wed, 22 Mar
 2023 03:55:27 -0700 (PDT)
MIME-Version: 1.0
Sender: austinesteves4real90@gmail.com
Received: by 2002:a0c:f281:0:b0:56e:c1b3:cebd with HTTP; Wed, 22 Mar 2023
 03:55:27 -0700 (PDT)
From:   Rose Coulibaly <rosecoulibalyy@gmail.com>
Date:   Wed, 22 Mar 2023 11:55:27 +0100
X-Google-Sender-Auth: 9cMWvm_xvItqPnfVHs0wdktNwQQ
Message-ID: <CAKq=LRDjGDGq3vVRHoaX1EapKASBUVwoBird5fyqRqJBpriLnw@mail.gmail.com>
Subject: Greetings my beloved,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings my beloved,
My name is Miss Rose Coulibaly
I am pleading from the bottom of my heart to know about your services
to be my partner/foreign  investor and support me transfer and manage
my funds in a profitable  company and how to buy stocks or real estate
by the company, I have  nobody here. I have a reasonable amount that I
inherited from my  father that I want you to help me invest in your
country.
Best regards.
Note: below is the major reason I am contacting you.
(1) To provide a new empty bank account in which this money would be
transferred into. if you don't want us to use your personal account.
(2) To serve as a guardian of this fund since the bank insisted that
Their agreement with my father was that I provide a foreign partner
before releasing the fund.
(3) To make arrangements for me to come over to your country to further
my education and to secure a resident permit in your country.
please reply to me as soon as you read this message so that i will
tell you how to proceed.
Regards,
Miss Rose Coulibaly
