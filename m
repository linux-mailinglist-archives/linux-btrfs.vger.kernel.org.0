Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13027371E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjFTQkJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 12:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjFTQjs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 12:39:48 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF522C0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 09:39:47 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-78cee27c08aso1520563241.2
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687279187; x=1689871187;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xdqoQe+J6zXuoUbEFJIdtAC7RTOj4usThHed3qRPwE0=;
        b=FPKIcmTwZQO2qcnPIeDD1e/rrGrBYTZwrzPDdVcEfiRUULsQ+DTKLyLRr92fNN5yPW
         xeZtgkoJlO8cwlRyU5wZaEra62zFU96YQZl9h23tpX91ekfrc+YJUDjBP+HXwzfHDveB
         mW5tYCKw3HfHVmPFffQiYUSArcyYM3HbGHPD8eDgExb4v4pJ+cUrCCYDws83vCJsnOy6
         XQp/H2qdeErSonUeSiVIBTVrpYY3zM/uoprITP/TDAQkcATRjL7jlLhE9wI8/m+MJCR0
         1n0EPoIgoaTTAri2se/cC+YfmqpWDtpeUbdakhU/BmSGx8X3AqTlQU7NxAt7CvGNslfL
         olXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687279187; x=1689871187;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdqoQe+J6zXuoUbEFJIdtAC7RTOj4usThHed3qRPwE0=;
        b=PCq9IwtpJ/17JKz9Nii3l+nFXzgRwUbDeoNMGZ/qVOCZzaL0c4cShdON8pXl3Jps1n
         8iN2xWYLpTIRSVWqpjIfxoJd41NtGgbQHJ4pwrVNWiHZEVkzDdmGCKwFIWd7rEaTdAcd
         qPliimuCmuK5I/AUAvLtdBTsILUTirleox4vAjrBu6Gr7YLbHQVfWSKwrH///Fb5IVRX
         If6gDi1a/WG0zQ+m0cgz7ml5e41vdVlrkT0TPQsfV0tat/0v1871wjzJGVotxyOVVpee
         qLoOoC27rtkua2/rOk255T+xBKg3nGVgHeeFkwCKkLn9i2IGDZ3tBH9Uq1jy3jV/O0/w
         3l/Q==
X-Gm-Message-State: AC+VfDxfAUNUnh9gmFRkwmggu3aVcceAj8A8rDk4COCx0yP/S2HuSoyn
        4x4YBu8cgTvhdmMdXcFVq/4SmPzih8betVgPn4U=
X-Google-Smtp-Source: ACHHUZ5GC0EeSDpf1Uplq3Yss8JjUNKX9e7Cdr4MA/O9ef6Eou1s91SqocEE1atXv7wNb0xn3r3qM8yEofAqAuYkOoY=
X-Received: by 2002:a05:6102:34e2:b0:43f:5ae4:d582 with SMTP id
 bi2-20020a05610234e200b0043f5ae4d582mr3986945vsb.15.1687279187011; Tue, 20
 Jun 2023 09:39:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:d74e:0:b0:3da:22e9:4fde with HTTP; Tue, 20 Jun 2023
 09:39:46 -0700 (PDT)
From:   "Christina D'Amato" <rahmanaulu75@gmail.com>
Date:   Tue, 20 Jun 2023 16:39:46 +0000
Message-ID: <CAFyRFaAJgTuBQtTb4NOUqgbhovg921g6p18aF9LdauSXoM=HtA@mail.gmail.com>
Subject: Franz Schrober
To:     Jonathan Nieder <jrnieder@gmail.com>, jw <jw@jameswestby.net>,
        kim phillips <kim.phillips@freescale.com>,
        kovarththanan rajaratnam <kovarththanan.rajaratnam@gmail.com>,
        linux btrfs <linux-btrfs@vger.kernel.org>,
        Lars Wirzenius <liw@liw.fi>, lool <lool@debian.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://honestlyhardstudent.tumblr.com/#==gN1MjM0MTb1MjM0UGZ2QTN0MzLjNmLrlGdl5mLxhjdxF3LvoDc0RHa
