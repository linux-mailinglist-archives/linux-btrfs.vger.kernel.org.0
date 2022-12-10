Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66BD6490BA
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Dec 2022 21:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLJUya (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Dec 2022 15:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLJUyU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Dec 2022 15:54:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0F617073
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Dec 2022 12:54:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u5so8187624pjy.5
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Dec 2022 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:reply-to:subject:mime-version:from:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxHhqqWxNnPCfNEXEE618/X/E0tQxQbTzz2F2uokgZg=;
        b=WtePhy3vSqe4RejPWdOxztFyAFOpFsO9V0lxnOVRPHa2tv6QnsVX3FBgAciymcg/Lq
         xnInhC0Z/12oBjTyw5ttDBHzqGgQ58tRbPPzMkL40X2p33qPZRazi8sWF79Z8sIzHhK9
         CBFNUlAhAG/0ekd+pjHF5nNxXaFv+dqXVY8a971yTH/CXMlZ+D8WUsrAySo8/NZtyWl+
         obpzhNQva7LrcIKBSlGxgx/FrKVt/hUu+Vnm/OgH/+UVA69UqcWzNgs5/2yUCEwJbmNj
         +SoEtf1PQBZGCSQSzskLDyiwOllnjCRRwEwLh2B/BhpNGbE2ypGjox/sA/wwFAOnOKCt
         fMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:reply-to:subject:mime-version:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxHhqqWxNnPCfNEXEE618/X/E0tQxQbTzz2F2uokgZg=;
        b=5DlDhrqWsf+rIiwrUMiudOshvjlUuoJNP3uNWI2EfNKkKGu4SuhI+x6P0KH/HEDSRA
         CCLOlZQnOzOwcIT7VQWKz098VsQBTfwuMsI4CXIG08dl4OqkNsHs3UUl8Ha5iXUlc+rS
         mwPHrWO9jNgr5fqkU6MbMq0jAlGm9CH7hnbr2Na9tC6XLg5tn2Dd//C+xhf8XYpz0Qx5
         V2kIxpvemTgBYZLHmc8GGmvme60rLmgW24Pu9vNu8niZzn3hY6OGrX2gG5hx53yXjxXQ
         Vr33sTU4NPeGSzvWNMvEFv4XmCv8GNUAkxxcva7x/frEWnGJEJ5JqW+WsBuUXnf8OfQP
         sc6Q==
X-Gm-Message-State: ANoB5plWjGSKlWDMtrA9V3QVEaK6QocTgZbw/oh9ty3KoVkzw28nTcXl
        5WdKvFOYWxpBswDLZVkGptHaLkODSseBbVnV
X-Google-Smtp-Source: AA0mqf4dPbDLLh2Wsex5KHMyDok1zOFzt65jbuzeJkd0AGfQAiaT+CoRLhRNNdyTbmZNjCDWXyvohw==
X-Received: by 2002:a17:90b:2710:b0:20d:bd62:9788 with SMTP id px16-20020a17090b271000b0020dbd629788mr11054773pjb.5.1670705659352;
        Sat, 10 Dec 2022 12:54:19 -0800 (PST)
Received: from [127.0.1.1] ([202.184.51.63])
        by smtp.gmail.com with ESMTPSA id z9-20020a17090a7b8900b001fd6066284dsm2864132pjc.6.2022.12.10.12.54.18
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 12:54:19 -0800 (PST)
Message-ID: <6394f1fb.170a0220.c72d1.5882@mx.google.com>
Date:   Sat, 10 Dec 2022 12:54:19 -0800 (PST)
From:   Maria Chevchenko <17jackson5ive@gmail.com>
X-Google-Original-From: Maria Chevchenko <mariachevchenko417@outlook.com>
Content-Type: multipart/alternative; boundary="===============1218406076771224045=="
MIME-Version: 1.0
Subject: Compliment Of The Day,
Reply-To: Maria Chevchenko <mariachevchenko417@outlook.com>
To:     linux-btrfs@vger.kernel.org
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--===============1218406076771224045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Please, i need your help; I have important business/project information that i wish to share with you. And, I want you to handle the investment. 
  Please, reply back for more information about this.
  Thank you.
--===============1218406076771224045==--
