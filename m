Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3FC485752
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 18:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbiAERe1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 12:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiAERe0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jan 2022 12:34:26 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC4C061245
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 09:34:26 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id e202so77417692ybf.4
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Jan 2022 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OsAnZDUgDxmn/Do38dRaqwEP7cDCwfWwfANc7Mgkfzk=;
        b=NYNnJLmzZYVJB5M8tWqffjAXhzNH05ASVIGM0I1aBg0yaEqhYtiL9n1CmVjcmuZ35x
         DEeJVpuS+wYmjMcxzOzlyiwdF0uweoRtxKSCiODxxhpwooID3KeJhIVs+KASfqLl1hqx
         IxPlYGMz76xZ0zZBbSRARo2VFY797kDhST6RCDsfnLmQgkM/QrDlUEsEld7KZoaZMLNH
         rUhlDXbBhishqUbCk5vdZD5wC5FcCn2ej2L7AwYZMxgOwpA0UeDT1iF//exLbc3XAoop
         8c2169H3eUqmePxlPejpih+I7CkRYj09273xxvW9WjdNENiCgiBIeqW/2tOrk+qVyfZz
         tsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OsAnZDUgDxmn/Do38dRaqwEP7cDCwfWwfANc7Mgkfzk=;
        b=X43bAXsqsLnn31KjZd3RTvEI4A9lQzX5bpp8mkUpMECncwaeXP9/Rb1KDZ1Nup9Bgn
         TiOfbR0HqcHmKQVBfjfrv+9wO0G8Fc01CxdufQqaIfUbuqyINcTQ8YVwbmk16ipiZeTn
         MXwWoPLK5M4w6tJdPD+iLbfAANUPTlCYV8my3WLy7u41oHJ7l1AJ23V94AajFIrJ1ySq
         XBVXDCE6CPWpCpP+aXt524xyBwFTBuNhWGk/2IbidwWOW1UjZ9U5n4XCm8QHsHMGThQs
         07rBf8NndP53rU5R3ztWrT1XJ4p2w076w2g37NJHktrGc4YcdC+fl8WdXe8qXz5KKOiu
         gdqA==
X-Gm-Message-State: AOAM5301Qkf1uqqYinQz9pA/2xIZkyeYl9uurhcSnarhLlh5Q9EmIgAf
        ztaMVa5BjDm7UPrp5QEmDCv6lyHVeHinDamhoLzCCpriWMqqEMap
X-Google-Smtp-Source: ABdhPJyUcwOzSfRTh5Bjd/SHdcuMPSwyThxkXEC/bVl/qFsa0bNKL/EbdKyOzgHa6OOYy9LzFavAkGCZYjfXiQZR4p0=
X-Received: by 2002:a25:bb07:: with SMTP id z7mr32488661ybg.509.1641404065576;
 Wed, 05 Jan 2022 09:34:25 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 5 Jan 2022 10:34:10 -0700
Message-ID: <CAJCQCtRnyUHEwV1o9k565B_u_RwQ2OQqdXHtcfa-LWAbUSB7Gg@mail.gmail.com>
Subject: [bug] GNOME loses all settings following failure to resume from suspend
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://gitlab.gnome.org/GNOME/dconf/-/issues/73

Following a crash, instead of either the old or new dconf database
file being present, a corrupt one is present.

dconf uses g_file_set_contents() to atomically update the database
file, which effectively inhibits (one or more?) fsync's, yet somehow
in the crash/powerfail case this is resulting in a corrupt dconf
database. I don't know if by "corrupt" this is a 0 length file or some
other effect.

Thanks,

-- 
Chris Murphy
