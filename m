Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B5A4EE1B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 21:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbiCaTbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 15:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiCaTbn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 15:31:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D13FD6F
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 12:29:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id jx9so354569pjb.5
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=6OjGOuUQmRQlasC8i3PBmaid5B3skti1naFsojF0Uts=;
        b=mQy92mfeA4YOZxQCZe8AT/WqRE36spnfzqRq/Bvmm6j8R5zU8Y1UCtLNq/MMi1rtvs
         NjM1kb5PaXWmZix++CJFWcnuoTR/78/WdnStcFagu9RAKIC8qOrhynxc2UnlcSyACCeg
         IlGKjtrsj8KX+UcJRyS02PnCHKbDYQCKMwCPyxrXd2kaREAxX/J9DqKdaXcGvOA57+FX
         kEOSJdMQ9FwjNDfYpHhzt6fpCE0HnWgZdcsx4d27R39cowp5DsnKil6F53HQ+7eN+sxC
         3081SG1+mBvq6hUdxHoSeyvp4tyNz74/d4v5VLJrK9weRJ2Mq5Jnb6ULGvmKmELxaP7P
         YazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6OjGOuUQmRQlasC8i3PBmaid5B3skti1naFsojF0Uts=;
        b=SDsCz00hs8CxgKRIFRvmJWsmfHm5RuEJwo3xHi9b6D7qJwStMPloXq9zucxVzsWSaN
         3SQ4phtCbusQFgBMdLmsspRDHQCC2xc/ltHttpeoRQyHundfzKMvkCWA3Y350bzcO3as
         7SnJAF6w0JEkZZqYWUlmGh7uWpmqhmv46RqQqHB9tk6G2VqdrXVx41pxuc1nX631lkVn
         4N+N2ZiKdhjFsCKNexGHpoM16DueaLtixFZrcoCONTTdgO+jrerOh63oblceDyFyhBFr
         pUwDDgRo72qlIzDUQewCn9/ys3j1sZp1K7phnmUgekRn+OqlhaeAtAXfmXKulzz1iLnb
         MFOw==
X-Gm-Message-State: AOAM530IGacArN6FAxGkvcJLlel+BTTmXFfYhrt+IirKPhxNk7qng0rc
        QVCrFIR5ea8+WhFDY2JvBBbwksZnanp4+fQgR1XiXRnM
X-Google-Smtp-Source: ABdhPJy4tH8VZHwhmtTcKquuuiCV/udzv8Y8ct28gaHDCos2AN0e1lk5DtmXSdWBxgMZd2QlV8l1rfzxyeSS266+VCY=
X-Received: by 2002:a17:902:ab04:b0:156:1517:411a with SMTP id
 ik4-20020a170902ab0400b001561517411amr6794300plb.128.1648754995047; Thu, 31
 Mar 2022 12:29:55 -0700 (PDT)
MIME-Version: 1.0
From:   Rosen Penev <rosenp@gmail.com>
Date:   Thu, 31 Mar 2022 12:29:49 -0700
Message-ID: <CAKxU2N-FKf-RsbA4S7hrYJXHUe7wJUrRyHGKjzKGgBmNcE1sCA@mail.gmail.com>
Subject: btrfs volume can't see files in folder
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A specific folder has files in it. Directly accessing the path works
but ls in the directory returns empty.

Any way to fix this issue? I believe it happened after a btrfs
replace(failed drive in RAID5) + btrfs balance.
