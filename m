Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE1550D0C
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 22:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbiFSUvP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 16:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiFSUvO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 16:51:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44915FD5
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 13:51:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id s21so3773391lfs.13
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=KpErp1lO/U8S7OwwpUvHHV1HGjzwMViuRN8sDJJKwYA=;
        b=N948ZvrBDMkWjEj3liFAqU+1Ubfn6+kBL6Y8qLGZbVRTV3cz2FFicNlpz/2wl9C2jo
         AX9zTx1jQcxFd1ZLjFCaI6W1suHlsHLsdlDmsSTfbcMvH8DH8FQKly8kvBS7KA3QWHXL
         he4+oQ5TqhUsmFEqlE+iCYmTb0fV+nKkuzxuvBzoXsbMlhU0x21YVdzhHVc1VjfWhFbw
         fPFTDQfnstxtiWo16siYDPd03UClKXMtEQz2yLtEfJIdp81UekzDIcyGVa8tqFp099E9
         YEwTj3rWvxgs1yc4pM1iKNMyOaM3Wp3bsipwR3tRWa4yZGn6ARaIgTNbo+HZwkGhkace
         a4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=KpErp1lO/U8S7OwwpUvHHV1HGjzwMViuRN8sDJJKwYA=;
        b=ALJ/iv0DB8nEiQavGXtEdPZQCeg4w+fy0L//xGIZDav7kK3gU6hFZUU8uGKHiBiqHn
         tObuist6LqOO6UF05of/bShSVDOEPPUBIFcHty1HChvOr5ckWEJ+MUv6U8bMutUBXfDV
         w2TUeNqXWvEXSFfD4/6yX6DrmgpWFPyzSNu4wUnxxyCmTK+4DuM9rjmNMlGIaPqUxq0+
         i2gvjZgmCeen9DCmKoQoK4MzucWR4OsM9dEpx3+JrC8JKrPAKiibFgROwQcSBX0cH0Z7
         ERoIHL1fZZCxFtBYsBbnR0oXsup5fWVUOR9LhmKSRK3i+261b3Zaz9ZKsPo9nTZ74mpC
         TvzA==
X-Gm-Message-State: AJIora9HHIyY0sXvu4b+Xkoh8Pwvr7KdvDE1BAbE8X7CUMP/xEaeyhY/
        wpDhPCrvHw+IlwOKJqrlc/GAXOgL+eDhY37HTlY=
X-Google-Smtp-Source: AGRyM1t6MG6lD54R+r8xHVp/wBAcBSkY7tyDP+YtMxYEDeO94GIRSi9wfhqD7uRd0XxzxMFNCTz3/4U4ZcnMLG1xj7s=
X-Received: by 2002:a05:6512:2305:b0:479:75d4:39e8 with SMTP id
 o5-20020a056512230500b0047975d439e8mr11785778lfu.676.1655671871798; Sun, 19
 Jun 2022 13:51:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:c12:0:0:0:0 with HTTP; Sun, 19 Jun 2022 13:51:10
 -0700 (PDT)
Reply-To: te463602@gmail.com
From:   "Prof. Dr. Diane" <laviis7111@gmail.com>
Date:   Sun, 19 Jun 2022 13:51:10 -0700
Message-ID: <CALMQbW_kT9L1qG75wn7nTgo0kASQnkhwxuxohJJvPXJGhMZanA@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Greetings,
I'm Prof. Dr Diane, how are you doing hope you are in good health,
the Board director try to reach you on phone several times Meanwhile,
your number was not connecting. before he ask me to send you an email
to hear from you if you are fine. hoping to hear from you soonest.

Best regards
Prof. Dr Diane
