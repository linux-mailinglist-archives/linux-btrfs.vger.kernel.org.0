Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD71A7402C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 19:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjF0R6H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjF0R6G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 13:58:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEA6297D
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 10:58:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so139400e87.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 10:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687888683; x=1690480683;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JlnmRh5yhTQ3rKHiE7xggd9dnBjSXMi9aqCUuXM6RzY=;
        b=ZYtmJodAKMLUrM8NOyGyvIMNNeUei+vQwzXX+n59n3Ho0An2QyyWsW2oWpQ6wpdEPv
         QSS+Omrmz4y8acT/w/wDpfZVONw1fqX3WZjTAps36N6Vj96XUSQ5hIYcXqgDDG6uIgNk
         hWa7yiVdtUsyIzoKClpICG65uoswiNgljpnf4zIsbXctH5T1GWiI6bpW+xpTQ5DECZZw
         Z+TqgJ4lKA4ns5WbysG2FeNzi932AhnPVwQx0JtjIkcYp+yjIyS6/MJMQaAZo5ERaWEr
         iX2jOXwl+VlJ35EoBNOLQkt63oKscxUG6Qyr8ynhz/72hglv0G1bheJWNRrvRUqCjgnp
         F7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687888683; x=1690480683;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JlnmRh5yhTQ3rKHiE7xggd9dnBjSXMi9aqCUuXM6RzY=;
        b=SSk5SsfI315hu+wcUK8k3KVYsu4p+8cFK1T9oFR+QdW8TI1tAg3I8J5Br8cv+cfx7z
         nTh79iogy5n0Z94NNcjlrKm1X+2I9s91JksRgu9LjnaP8Z7sOXKlrQZq63NRTQIotx1L
         cyRxhB2f+0nNrwmaYwFx6MepiroNdlrpAw0Qzhd4l3q/5Q8Q7j7g95kIiCa39VewVJ5S
         6I4IKb/PiLf/Dpr3Mxz8WMeSUFFQ+mhm3qeJijqlvEcyfl5cr7P6ieGTx/gk6llpwuC8
         9j8DnI/hiSkMV3TRumSpuAuL56QBdVOKkprBHImL1dZQbT21rNfMFsIuhRRZj9xWCQjp
         AqNQ==
X-Gm-Message-State: AC+VfDywz0jO3qjgB6HK7U4A03d+aLpzDGRkTKyDPIxe0103jDNBMUEo
        4aAtbU0sFHzcOtzhqVj3OFGD9OPBVE0T9zBXiHkEHsjtROw=
X-Google-Smtp-Source: ACHHUZ4RumNNm7zmOGuqBY9uwQQOhi7m4CxxySCDoeUHGBJDzlamBuELRr4gxgv27TTYuSGQ2rkSfs54r9HF4MdUmx0=
X-Received: by 2002:a19:2d4e:0:b0:4f8:453f:732f with SMTP id
 t14-20020a192d4e000000b004f8453f732fmr10943733lft.2.1687888682546; Tue, 27
 Jun 2023 10:58:02 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Kielkopf <andreas.kielkopf@gmail.com>
Date:   Tue, 27 Jun 2023 19:57:26 +0200
Message-ID: <CAJHmLGg8KKRh3kZFQTyN8BJE9_MfhQx0d_TANaFMUhTVrmQmzw@mail.gmail.com>
Subject: btrfs receive
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

btrfs send is probably not used very often yet.

Lately I've been using btrfs send and btrfs receive a lot. In most
cases this works very well. But sometimes a somehow "exotic" snapshot
is created on the receive side. It seems complete and good, but it has
no receiveduuid.

This may happen 1 or 2 times out of 1000 send-receive operations.

It occurs reproducibly more frequently when btrfs is disrupted on the
receiving side. If e.g. while a receive is still running, another
snapshot in the same volume is deleted.

The receive continues. The delete is executed in between, but
extremely slowly. Even several deletes one after the other are
apparently executed correctly in parallel with the receive. Just
extremely slow.

With 10 such receives, in which deletes were inserted, 4 "exotic"
snapshots were created in which "only" the receiveduuid is missing.

Is this already known?

Greetings, and thanks for a really good file system
