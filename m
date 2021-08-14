Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7183EC4B3
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Aug 2021 21:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhHNTL6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Aug 2021 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhHNTL5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Aug 2021 15:11:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C25AC061764
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Aug 2021 12:11:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f12-20020a05600c4e8c00b002e6bdd6ffe2so6208583wmq.5
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Aug 2021 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=whkGUc8NI3kcVw8/OlirgwHx/dHSyutmkNlOpyc/2fc=;
        b=ZAlRdYiNe+qJ+dsfbcwFqYtK540TZx2EdyKiG8M2zTYsha6RV8U5wsF00K4sc3eowa
         UpAzybod1W//qBxXdOPQ0EbCZoxUBWZSt7BLC1haQpiUOvIMwBGv3VxTAh05VCZFCop6
         py67pGCl8voCUkPiv0BjaPpEI45wg3QjzKQZnRDOZMUbA1w9WJmRBBv17zBZ67ZgFJSH
         YmyxDqSw5aLyQVOdmR+ggn+eB6KO0tEw0kvBIZDBeo057BOO/6+8+gMZ/k+x0+LDeAB8
         1gZWYjx36phEemYUiT4do3yudp/n+O1lM8brDtJXLtaNiyKrmpZxyuN+Erl5sYVElO8K
         H6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=whkGUc8NI3kcVw8/OlirgwHx/dHSyutmkNlOpyc/2fc=;
        b=Tjmh4VekIuPHj5CiIab4ds4/2GABNj8H1T//k+2oIN2dzlI3N/nY2QF3I+SJRV3r/M
         9sXCg916yYhbB1M/TvLVU+D9cpE/FiblL0c2egAvacuii/yefediBYrqpnnWOfSrPo5C
         gmTL3dJ07+k5EKsSp7xnckGWuRuHiJwrK07Lksl297xwNps92IuhA0rKTj5NQU1muIv1
         nedP/zwUlxFWUv3F3kuMsOXBqrmhAYF6BMfSJEv8Wv7Z6FWPpsVw9T5Zjs0I+jQfvUEH
         ysTD0ekwF9E5McsXvTBVO/CHE6JVaqVhCJxbtHC41dKsN5aPKJs8JuphNZIFxxVIxle1
         Gw8Q==
X-Gm-Message-State: AOAM5333/Gh4D8IJUjdmkpBs+LYQvH04NDmKtphbRhMHAOpimUdA5r/p
        N14LHU5lOv5HcL36iBA58bm0PlQvQ0PCJKX4EN0=
X-Google-Smtp-Source: ABdhPJwKS5xBbwT+euO+edodwi60f7KVbT1hCEOn9Wr0GABYx/yKEa6uYUYSNFUydH9WVtKy1ljJ3myJfXDR5dbnZsQ=
X-Received: by 2002:a05:600c:3593:: with SMTP id p19mr6165364wmq.95.1628968286826;
 Sat, 14 Aug 2021 12:11:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a4c7:0:0:0:0:0 with HTTP; Sat, 14 Aug 2021 12:11:26
 -0700 (PDT)
Reply-To: nb7250896@gmail.com
From:   Nelson Bile <lawfirm288@gmail.com>
Date:   Sat, 14 Aug 2021 12:11:26 -0700
Message-ID: <CACEwRZzJGBj64C1PxuG6aNFNAt028e4cpMtDqd8394CpHodudg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

P=C5=99ed n=C4=9Bkolika dny jsem v=C3=A1m poslal zpr=C3=A1vu, vid=C4=9Bli j=
ste moji zpr=C3=A1vu?
Pros=C3=ADm odpov=C4=9Bzte mi.
