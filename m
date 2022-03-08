Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F108D4D1B0F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 15:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245172AbiCHO4p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 09:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347648AbiCHO4o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 09:56:44 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30254D60E
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 06:55:47 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a5so5962070pfv.2
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 06:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=lgK2/rms/ZffyGFUOET/BYtcPYuQBzLJkyvn4UNTFX8=;
        b=Y+KTPaAsBBgWmnnBaAVQJy7ejgqcJN7dKV5EGstvs3erKochxJ7Q89Pb8u5MFtaCwk
         1YucdsIAD9LItXfRYBDsR/85flXRRXBIjtWaoG+TQm0e2UXj/t/KWOWKiP4qsuRsp2mP
         t/TgsfXwNLxDr0L99u5N8zPU6kqq5KkPV/NRUJt0yZ3xGhZOBdiZzEO3f2/ZTld9hd+S
         iV28QUGZRy0fm5dSuDCgyzZHUxmmGvikshbpk9a16KAG4Z74nuwqpB3Op9bQYXgW7WDF
         iZgrLvr5PjPorSS0OQ/f0eID3hRH1dlWoAQAJVPXG+/xvkz5zHJ5u901bEO2O0oaUVRF
         rgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=lgK2/rms/ZffyGFUOET/BYtcPYuQBzLJkyvn4UNTFX8=;
        b=j/MnCF3srJ2r6eFpvqNSfP8Y6fznhfmFkgLYmwM4GFf5SRR9wlYSr0KD6zTaNZoSMQ
         aEHKOljKCoSq4XWBm2Gp/R+ODRUO/MaB9IEdkIrmLOJ7Y7UNUws+YNwgolipxOxNyD50
         q4vna5tSwUZf9rwGyU5Lp6++sM3DMe7XAX3jBAr/tvuPv/CzEoKARseFMjSReS7djpwS
         zg+9tsi0va/JO1ityQ6t2pFi+JhGc63Utc/OIUQQgk0+3T1HgmhOxYbNGTwaaUffCRee
         z8Tylkv1jorsvax/9/kPeXlqNd97QJW7CtSDDogoWlLpdjFvP7Tc/9Gq9qoXkvOOn8d5
         wafg==
X-Gm-Message-State: AOAM533rmDKlsgsNcIRH5TLHpTpZ/y7hnS4nCH+NuiBXypxRh/d9NIpQ
        Ir49SvGrBESdPOgo6dl1i8T1W+XJTXM=
X-Google-Smtp-Source: ABdhPJwou01zi91yGIjZekI0hAdsqyQp5zFhkv78CZ0a+ujJxkKI0l1LEgzfgvCqvtKnOxOzyqJ/LQ==
X-Received: by 2002:a63:1c8:0:b0:380:189b:1e66 with SMTP id 191-20020a6301c8000000b00380189b1e66mr11655373pgb.71.1646751347134;
        Tue, 08 Mar 2022 06:55:47 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id nm14-20020a17090b19ce00b001bf2404fd9dsm3182877pjb.31.2022.03.08.06.55.46
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:55:46 -0800 (PST)
Date:   Tue, 8 Mar 2022 14:55:39 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: A question for btrfs-progs code
Message-ID: <20220308145539.GA19735@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi I have a simple question for btrfs-progs.
In cmd/subvolume.c, It seems that create subvolume command has -c
option. According to code, it gets two qgroup ids and adds to
qgroup_inherit. But the command is not in manual. Same as creating
snapshot.

Is it deprecated option or internally used?
If it should be deleted, It would be glad to do it.
