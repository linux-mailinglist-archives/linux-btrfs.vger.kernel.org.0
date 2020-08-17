Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E095A24780B
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 22:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgHQUTB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 16:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgHQUSz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 16:18:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6BDC061344
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Aug 2020 13:18:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id p24so19319981ejf.13
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Aug 2020 13:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hvmDXaakfQULfvFeyzWxNjplJI/nDhye2dI0S7svhuU=;
        b=J3F6kS7cWUOJS6Y3GsEz5ojrADe9EWTBOKVOyLv3QQu45pklQJHV9MRWap+3hYGgjm
         oFy0WJ4lY8+zsTHTJ1tJkIs0g0tMs8Gs+N3XZNZNDH1RJOs7SfFH72d8GhxrBvKH8N9K
         hXPaZREYH9L/ZmeYr6iw7IqFfIE1g1dUmD5GgnWv3NiLAjXVcwfP4B6hRX8ralCjYbPT
         Rbk1RxqNU2pMc3oYG4bASv61djIIpu/k0AIMj5LvmxrAofsR6u2snwDtmJsTKZykrF54
         KjGj6mqqHOjQvhS97jRwzB4OqTY0h9Fc103UuXKkF4oZEK+bck73sFf34Q/AzbR4U9Wa
         YuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hvmDXaakfQULfvFeyzWxNjplJI/nDhye2dI0S7svhuU=;
        b=tyncP7Q8mGi1jymEpfg+ALMm48Hg7DpCMjtkU4BT8/JrFY4eb4LT9oUdT4hFVwO7jO
         uHjSIeP5y5v2oElrlOxuuqVBke7JMPWFofjBlgjEYmeNOx3ezTUc5PYaXlfRLDPAqkP3
         k7i58IfeAF/kzlP72zc2mX4XlhpMVKpBsuKql1QfQDB7dn/JhcCc+6pAJH2uG8IrGBOV
         THwGgLsxpF+v/tPo9Hf6zWQDuOK/6VmCW7Jfk1n1PkTJZ9mZIxXZY7JIQacFEh2bdYLp
         ySKhdhdV5f636nfr7Qm+3D5JBgn0JEnojiUeY3jzvKlIdLU8TnZUxF95Z8xW4GZzUlKo
         aGkw==
X-Gm-Message-State: AOAM531r5Zisnyoc9eznGCg1Gs8bILBeWpzbOBXjfD469YB6hgMweXvI
        yQmtnuY4tE77t96DfbNi/nY1X9/nVy/fq/JETVejyWGBlIymcA==
X-Google-Smtp-Source: ABdhPJx1kaakWdP2ymPYRDlqkNJxb7A5lPSEZeAUorfHcbKTu2D96UrBwv5yppUbnEzelCYlTxaQ8V0PTJ8ZO5+o6A0=
X-Received: by 2002:a17:906:2296:: with SMTP id p22mr16684587eja.510.1597695533522;
 Mon, 17 Aug 2020 13:18:53 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Kese <peter.kese@gmail.com>
Date:   Mon, 17 Aug 2020 22:18:42 +0200
Message-ID: <CAGP+SyZctwxGV=O4vw6pLY-R9LmirNgk=s8Zq9x5juV+3EjMEw@mail.gmail.com>
Subject: compress-force mount option documentation is ambiguous
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The `compress-force` mount  option which states:

"If compress-force is specified, then compression will always be
attempted, but the data may end up uncompressed if the compression
would make them larger."

It is unclear  whether that means that compress-force will really
ALWAYS attempt compression, or it will respect the +c / -c file
attributes?

Which one is it? Can we fix the documentation?
Thanks
