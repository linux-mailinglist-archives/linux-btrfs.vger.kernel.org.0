Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5A35AE454
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiIFJfR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 05:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiIFJfQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 05:35:16 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E4545F43
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 02:35:13 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-127d10b4f19so994400fac.9
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Sep 2022 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=vTYRoLUk3pA3c0YjP+/ewZuA2rlY910Xc5hEW8vdxxw=;
        b=if7Vwq73jnhv/peT3VfnKOWw0ZhYc6kqchOeKIzV9h038Lwlp5ztcGB/Tff8W51fY1
         sjEAB21SSEAtsaHOcC9DKcmJtR0aOjA2ij8vuKt10cpFP1Ae5fZeDkYbpVZKspOG2ERy
         7PxZGljqHbjqa+kSr34Lk+GNyJG//gTuq9I7xQ5nlG9887Isbd1d7AW1aBqdccIgw8HX
         nMABPsL8xoHhqdfrviMw6U8RV7hzIdBoevpapyukGSrl45TZOz/U19US9U4lVcMhBZU6
         9aV2xpeVf5l/BWbkZNDc5VDQnUYtLGdp8Ry0+mdO5eUGiKxpstID5Q48Iksdo8aqsqxe
         shtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vTYRoLUk3pA3c0YjP+/ewZuA2rlY910Xc5hEW8vdxxw=;
        b=JaT770WU5V22R/ucMY6shIMYJlscTJY26AWQRLqAaTBwV4IGOd3gZs25BAZO3BarlV
         PaLr0hnYWmH/dsJGRyQQBN1aTMmP1Laa8SNtjrIZzP3DR7XkcG1fWCnKpACkZug2h+z8
         FdVKHHn1MVtupZovIuMQcKNcewxYHgswaZmiJXMCI1AOHvCIuC2pKqxc89rlrMxF/pfB
         5HnQgCLTSqm9R5rhdpJNKqziMRDgkJrelqqw811ibsXmhyT00jnwxrqbS2+P5PgoM24a
         dPTN014BQ5wyPm/fu6bUF9iRJKz8ujVUwwcvtlhSlnNbeIN8QlD3+bgI7Ipl4gx+w/2m
         Qyng==
X-Gm-Message-State: ACgBeo399OYGcbwsfE+GjZhykr2SLQ3PpbjmKjU9jD2glRctuu+njZUZ
        fk5YifeUbHX1QQVLOSoaLX7M2rjCRAq8q9ptUNezUFLj
X-Google-Smtp-Source: AA6agR60Y7M7tg4PgoK+Grz3czEUs8hpY+C95tN3mtwsO2oVffNHroqD/P0LV85hJEH87kErX8yzN/kDzT8hxmBbpDA=
X-Received: by 2002:a05:6870:9108:b0:127:4bc0:c255 with SMTP id
 o8-20020a056870910800b001274bc0c255mr5138160oae.176.1662456912627; Tue, 06
 Sep 2022 02:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <CADm1Te+nXM2diJMj-jCTw7MKtS0uZEY8Qy8p+Twh4cCOxz+crw@mail.gmail.com>
In-Reply-To: <CADm1Te+nXM2diJMj-jCTw7MKtS0uZEY8Qy8p+Twh4cCOxz+crw@mail.gmail.com>
From:   Alon Ben Refael <alon.ben.refael@gmail.com>
Date:   Tue, 6 Sep 2022 12:35:01 +0300
Message-ID: <CADm1TeKaCqt3ZHFhhZDZURaxsmTgsn7+WPKJVURtGkM4T09Npw@mail.gmail.com>
Subject: Feature suggestion for the btrfs
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I have a suggestion for a feature for btrfs. I hope that this is the
right way to go about suggesting it.
So it goes like this:
During a snapshot process, perform a check for whether or not the
snapshot file is archived. If there are more than a predetermined
threshold a log warning is issued containing a list of said files and
the date of modification.
The idea of this is to be able to recognize the existence of
rensomware on a user's computer, causing havoc on the file server. By
doing so the infected machine can be wiped with as little data loss
possible.

Alon.
