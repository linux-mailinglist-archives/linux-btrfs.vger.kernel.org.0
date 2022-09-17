Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E975BBAB5
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Sep 2022 23:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIQVcm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Sep 2022 17:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQVcl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Sep 2022 17:32:41 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B96BDEA5
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Sep 2022 14:32:41 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p69so30777921yba.0
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Sep 2022 14:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=o2fzgTmCIyAnW7Cv/6QWbu8owpSLER1tvQfuJI2Tz7Q=;
        b=f18wxRIEMo0qE4oIhrwHV4TsULXuIJoOuHTFy5OuWWkP01YZGyU0dMG/YCWgNx/nan
         YcZxvfjRRJQhzA9k1TaXcddyfpnOxguYUlrofnGPrpmt/C8Ozix0cP5MqTv6VHME8avL
         Nr3KylhA+S/NrQSArbXNhr/xBNsV5rI77kyxxOic0602LjZ3TVn5023mwzZalFahLpRx
         l6Gef8yq/+IjqzoUI+5TaSmXvfmF8gmJR5faJ3LqzBjoAk1rm9Xkp/mjSkDU6Y/y/s+a
         6PbgWxVw1QwugLV4UCmwE0KFmxSmHjcc024rdfQfsFyqok78eqLFrmio4ObO1Azrs59O
         mj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=o2fzgTmCIyAnW7Cv/6QWbu8owpSLER1tvQfuJI2Tz7Q=;
        b=aakFvpuEZGMTXqUk2ywCoVlOXd44HOUUcjSaM+XXHDnIyG/z30yEGuTX/tvsDyN3j5
         eFzS+ovwBNXRVhxbNn4uEWCo+ckCuL/9x3a+7DStjgM+KEUvi6ipThNvcm0Y3Gk1HuOr
         VhGTLWELFXwCXZkTjJHKuoDDr7duWcKocLAn84Bzeerj4ncRhnuMVvblI77kHBB5Grbn
         qZskdthYRvH239+VnYrpDTrL6BQjPpjj4x2TqFOhJLgAm627ncFlQ2aZ6TREqjvNJNY6
         bE5/9mw5KIfh/qpBWV+r0wvUo4CCqdpeaEWfJnuZO+3kW+97NzhR6EuaO0U2jNiDc/RZ
         DIxA==
X-Gm-Message-State: ACrzQf1NjF1Y7w5KgNp+aQqJeeJhWWDq1pDRzZ7RMi/WsnusKHtI2a0K
        4iQ3VvcxiGYERqfOFC3IVKDe9yf4S4m2xRTyRXkzaM3pzrY=
X-Google-Smtp-Source: AMsMyM61tZYKaz0rGsdklDylW5JrPci/B7BVDaWLkWMD6MRUqzy0gtqTPnh/T1VZAxtU11AcFN8udMDdwDv8B/Uy/cM=
X-Received: by 2002:a25:2055:0:b0:67c:28e7:702c with SMTP id
 g82-20020a252055000000b0067c28e7702cmr9074527ybg.625.1663450360087; Sat, 17
 Sep 2022 14:32:40 -0700 (PDT)
MIME-Version: 1.0
From:   Brian Clark <bsclark75@gmail.com>
Date:   Sat, 17 Sep 2022 17:32:30 -0400
Message-ID: <CADQkWYDMLfAi+XVNrXJYjUV1iS7Uj8zLs5L2XNGiQBSTYM0K2Q@mail.gmail.com>
Subject: Help w/ Parent transid verify failed
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I have a Fedora 36 Workstation running as a VirtualBox.  This evening
I started it up to the error above and is now sitting at an emergency
boot prompt.  I am going to have to type some of the needed
information because the trouble system is not booted far enough to
allow copy/paste.

Linux Fedora 5.17.5-300.fc36.x86_64  ...
btrfs-progs v5.16.2
Label: 'fedora-LIVE' uuid:  ...
     Total device 1 FS size 5.1 GB
    devid 1 39GB used 6.52 GB path /dev/sda2
     unable to mount device to get output

Any help would be appreciated to recover the data.

Thanks in advance,

Brian S. Clark
