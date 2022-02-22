Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1354C4BF4DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 10:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiBVJjG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 04:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiBVJjF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 04:39:05 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D691156C79
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 01:38:41 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id x6-20020a4a4106000000b003193022319cso16725219ooa.4
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 01:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=pA4LOyU1ITW9Ybka/nY8oF+Z+zeR3qpDd/7rUrPksqk=;
        b=VvMYipW1ulv1LUii3FnQawvtewIJI/vSVttOJme5xqIH3vLw+glbpZ0nUs84rjybXC
         9wdILN4N6NuLSyTe3BLQnjar5hoS+1TPpL8bJ1UV5fiaNnF7OUs63d5U0kjorhBMuT75
         rpJxHlPEitbCf4Yg7ok+ixLCs7ADSDVqRUduRXL7dn20xpsYzRqr7uErRLyEY/XP3k9u
         Nt1RxE5nT2Ds/muH/FKn7Std5Sxz0UIPIV0xqJDrhs9Xgn1T5vSTTlOa5Q1Fr8O07ClV
         SB4Ovx/NTLURiSfL6Y3rpsKfGknYHIbjsROzPzOdWekDA8MHltdJ/Y9Hr5A7YmM2g03K
         jQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=pA4LOyU1ITW9Ybka/nY8oF+Z+zeR3qpDd/7rUrPksqk=;
        b=5R2rghzfWDZI2wfDCSoYv4ejVspyPKBXmLfl9ftXYhuNTFHeP8Z2ttVaJO7tPRpj+L
         VcDloKPZQrCxucQoJpFQ+eySXC+23SeQ6mWJIVNDb/s3jmLlpLNfztC8mY7z9H/8jPne
         DBLOEoN6VhdE+RpDHIuFj8pMwxsLXTNQMJ4WGkI9zWvO3mIfH8oSrdVG9F27BJ63jsvY
         aHm0JUYeQ9v56/kwKwNbaYYbcXWwwtmM9nfra9p28RNbXurqL8JTHhkFbVOQp9WlAcU9
         JW1bEBciMOAK5wFP5RUAA3UKgMs8IMU12sWd8lGnoZfpA8rDr23SMli105ekPWXwxya1
         hkWA==
X-Gm-Message-State: AOAM530+ktSZSY8Q70w32utdUWe7WaVaDxPxNpGC8UsWdPstupfJXj/B
        Vq0huo6rgHfkcFdfUXLL+lVN5AR3v7oi6uwwPjQ=
X-Google-Smtp-Source: ABdhPJxxhAFsaiq+LFtXqijcOuWaRB0YW4gvEsxKCcWpFZfkxY5liDPlpeE/IfNls8TEM2Y58KPV7JOIxya6AOipzig=
X-Received: by 2002:a05:6870:ac08:b0:c6:5f64:fcef with SMTP id
 kw8-20020a056870ac0800b000c65f64fcefmr1210362oab.151.1645522720014; Tue, 22
 Feb 2022 01:38:40 -0800 (PST)
MIME-Version: 1.0
Sender: amuvalentin@gmail.com
Received: by 2002:a05:6850:671c:b0:2ce:7975:fb6c with HTTP; Tue, 22 Feb 2022
 01:38:38 -0800 (PST)
From:   Davids Nyemih <nl6186443@gmail.com>
Date:   Tue, 22 Feb 2022 10:38:38 +0100
X-Google-Sender-Auth: TWIApK5rv_B0gEhYa_ExnorU7VI
Message-ID: <CALoTmgdRWy1z1N8LOpHFrhx8e2pLLxuapzE_La5zBWNhDaLdEg@mail.gmail.com>
Subject: David
To:     undisclosed-recipients:;
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

HI,
Good day.
Kindly confirm to me if this is your correct email Address and get
back to me for our interest.
Sincerely,
Davids
