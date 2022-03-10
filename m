Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609784D3E54
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 01:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiCJApA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 19:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiCJAo7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 19:44:59 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE726E56B
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 16:43:59 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a8so8695304ejc.8
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 16:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=W75NRnxSjysildMlohUaDZ4g26a8Gj/os6LIsbjez4HdNa4Mjl1lDzps6VzFtQasIi
         lLwJY9zhyywPgtOXSnB7Df7D8JBUbPrFwKC3IApZB2tjXQkg3cFoBvxm3MqNr6NMRwvY
         8CkvxwwwZcPHRnbpTodHwHGqXwBdEVWhuDqxq4awS/lkk8dE8rNdmcXiXAMdfvuHi35e
         t7yvHCYsrisTKD62IVCPa2gJEXwkkxcn5qpmQaiCDDLrI2Xhfp2ljEJWZEC75s1CKCbo
         FMHriNMUV8XBOgqGcCEatDZ7KAoaXFjLpjydUGwGBM3mc9G9Vat4NvQRwgXOHMPISqwR
         kUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=Z4QIDDrw+XMQfm+xGLZEFOeNDpdUaztXw7NxwJm69f26KCDAvf0DFQ2ccVFtGF7D8T
         +UhkiF31jB5pAdCT0HWes1NL7brnmfMSE8+uDSc9l8ewpYPqVPOnrPqn0MN5VYTNlhjH
         x+Yj7Mbuydt8YVSfE8EufJGOgzAPcdb/myLg7jQYrMu1WNVwyJXmHib0WZeiDTh9pBKU
         wK1U7HMW92TP4/eqTD/aQ1Lg88gE3kkmj70y7ujT9wYyqi5UeNZz24o/104JBBqwu2aW
         i9xNKcFqZVmH3AQ2orNwR+RbYcUqS4U58/6ASgk0uGObaC15k+Fv1wa4z4k7yVLkguEE
         n9SA==
X-Gm-Message-State: AOAM531QYQGepzvNpHKz/sph4EHw+1xAn8FZrAZY+e8qGEXpoio6ifJS
        HFv/5Qy38S7ClBogPfgPG4mxZIADOL4NpsPDUp8=
X-Google-Smtp-Source: ABdhPJwtXIsWkBonjzAMoEQ0G4/gObCTRi4jHgbKH0iHizLiELutxwOBl/ACS8IfM4k9f2FuxJU0G/btkGFKEquyLso=
X-Received: by 2002:a17:906:6a26:b0:6da:873c:b9a2 with SMTP id
 qw38-20020a1709066a2600b006da873cb9a2mr2162753ejc.727.1646873037647; Wed, 09
 Mar 2022 16:43:57 -0800 (PST)
MIME-Version: 1.0
Sender: julianterry39@gmail.com
Received: by 2002:a54:2346:0:0:0:0:0 with HTTP; Wed, 9 Mar 2022 16:43:57 -0800 (PST)
From:   "Mrs. Latifa Rassim Mohamad" <rassimlatifa400@gmail.com>
Date:   Wed, 9 Mar 2022 16:43:57 -0800
X-Google-Sender-Auth: 9eU4rWPgLfAiFrCK6qtntnhTJ0c
Message-ID: <CA+Kqa7dztzx0FKEV9bd_5S=KDZc0VvWretGFtjyoa_QQD0tagw@mail.gmail.com>
Subject: Hello my beloved.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings dears,

Hello my dear Good evening from here this evening, how are you doing
today? My name is Mrs.  Latifa Rassim Mohamad from Saudi Arabia, I
have something very important and serious i will like to discuss with
you privately, so i hope this is your private email?

Mrs. Latifa Rassim Mohamad.
