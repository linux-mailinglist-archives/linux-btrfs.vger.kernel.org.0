Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948F5520D3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 07:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiEJFl1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 01:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbiEJFl0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 01:41:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48891E327B
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 22:37:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so1214954pji.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 May 2022 22:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9qPmmvdmg9Y7atUYbQm4tZIEIaskvmEAW5s2XXs56H8=;
        b=OQEuA/gpXDWHigjrDTvJvshNwL3JeopGwM6DvR0bM/XFBtGdf7X7zZd2sQk9QtEg5C
         NqC5HjuezSDWMdWWTSfKDvOlcPgmTKHuWibzOMlrVSQFwQhrDv6/smt/s9854rL6ayGG
         nYZ4JiGrr7oeg1SxL7K3owfEN4pw0KwVBfdpzkthTuf8j7grdVL/+s4WK4m8H+rHs5aB
         OASJ/v1z/ij/PpjvlRdGwWKCxNKbtf1iGB7XiPotWM8s+neqwHGOWyrSUmXey1vWBSI8
         jJ4nquYympWY9KyrdgBdI9ePviOb9VWtGcIve4Qe+WYdrBJtE38KqnZTN0cd9KlTrtLV
         b4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=9qPmmvdmg9Y7atUYbQm4tZIEIaskvmEAW5s2XXs56H8=;
        b=xu1SsTH3arLSVW2uYL9mjJ+pFJQscrmhhOrbtJ4ov0touyXpY5NV8cijojlJM9YI+p
         Qg2YSf4IJ6FczLzF5DgcKwb+g6W3WIq8v4rxBnDcjtSsuG6Lnmz1AnFAc1W50vJa4+cu
         x9cn+z612ZQ2lRBJZhKgZN7wL7MVGRFCPDQ6DUwmc5s2WqJvEgoTeWw+MEYZv09n7snY
         mA+LMrl316W3IwyvAwv8QkV2vx0vGo5tt95J/740Qjy+FWHXNyo58HhcDR/qAqMtscM/
         HNdubkJ4UJjnkv+jSTcOAtaC+jlKk1MgRyroWa9wP7Wk69Ed4a3D1kPBKJGi2sqnszMl
         9KMQ==
X-Gm-Message-State: AOAM53104AhR20j1wou/4ywrZHTHUH9R3X3BvR5hLzjfMfjk0VXyNWlb
        vNBT6RtoYZWPJW2RxENEnDanY/HDh43w3RzHXvyInLD7sAY=
X-Google-Smtp-Source: ABdhPJxd/GVeCIokEHQDHdEFBwP7Ug35yeC0Iv5GBYkm7Pns8q6YNAJrEA3O0QwCQ+f922JXKxqSlGamrJrPy5MvUjc=
X-Received: by 2002:a17:90a:8c04:b0:1de:5177:37e5 with SMTP id
 a4-20020a17090a8c0400b001de517737e5mr1846502pjo.26.1652161049228; Mon, 09 May
 2022 22:37:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:191d:b0:60:cb2c:ccd2 with HTTP; Mon, 9 May 2022
 22:37:28 -0700 (PDT)
Reply-To: sgtkayla2001@gmail.com
From:   Kayla Manthey <kafouiapeti@gmail.com>
Date:   Tue, 10 May 2022 05:37:28 +0000
Message-ID: <CAC6cm1K9KkWFPae7Esz88HACtZmrx=-4z=5+6d3VFQYcFTsZiQ@mail.gmail.com>
Subject: 
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=20
Pozdrav draga moja, molim te, =C5=BEelim znati jeste li primili moju
prethodnu poruku, hvala.
