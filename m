Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219EF22D3BA
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jul 2020 04:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGYCTd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 22:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgGYCTd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 22:19:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AD2C0619D3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 19:19:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 3so2816373wmi.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 19:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKuqztaoFsQggNnz3OSEf05SuDlhtC5AMxLpw+xu4WY=;
        b=V5cIFkplUwp1yzvFW6/kSPtybuYiRVOV86ECTWFl4q/6Vr0TY5hOCwkZo3YueweOfi
         9ospdcVMuf6+1CN/gDjhf0BtMsFfEuwHgcbyceat2N+EKlXfRFZmyP6EkOTGWHKAmIE2
         uK/e9QHdQHY7Az9h1AuPcVnEHffJDGm6Ho+ProejWpS+HDqcf3VZ/XaVWaPgPH0NgXyK
         RzRgRi/XCf+TkenpAOcqKAEJWjSEQbmkziLF0wi4E8TcSUHLIes1oIc7TqLY4IvJUyF9
         lt56kLIHwuPlVt0pz+CEmrNQCRA6JwVxFrdarNiR0aURCwbxRX0nXhpOJ/g1e5XSkGx6
         uwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKuqztaoFsQggNnz3OSEf05SuDlhtC5AMxLpw+xu4WY=;
        b=ec6y8LmyekHCrNAI4eiCRZEYr0X7/WP/e5okU0oZU0yzM5YBOhwky0X/GQKX+Ub0x7
         5TWUJ3UiU6EyMChX1DKtExy6jNaYIotet4AwKaH47/S2f6rjurbcw3r8j3YiO7BzWcJb
         50FywylfGQvYmQ762VHzhjVbP9ZL2+Nt5SE96A6HsNOWMorst+34uTekA5TTXBmFHRNA
         wod9//2hlnFIlnUEhVQ489u5MS5axpRYgyx1Z84EytG098jY3hXDElGmDwtA6h4IPNQS
         dB+ZNOHUOC3w254/5d5pxb2H+/U7Hhg2rbbiNX0rvnpnFgJqHFL25TH46qG0VkKgy7zN
         tH/Q==
X-Gm-Message-State: AOAM5332UOTWCmyxWd+jyukrPQqK93/qx2ZbtTcGC3pCrvay4RCRXOK5
        6HT62P0+r5WNN3+KxdkTXzfK8nASTR04dS4LLsNBjg==
X-Google-Smtp-Source: ABdhPJwGybHcnBJ+Ox1lpJw+V1kXycht90QQNkeeZEFmRIyvBtm3rohjB90ODP6urV28zMPzBfTeo+ewDSDZtoL9eaA=
X-Received: by 2002:a05:600c:410f:: with SMTP id j15mr10802956wmi.128.1595643571234;
 Fri, 24 Jul 2020 19:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHzMYBTU=JuEsRX7YXzMJMELy63TXrm3J6onKnhGSOOzTnnMBg@mail.gmail.com>
 <CAJCQCtS6eS7a+wHR__A_aDujANWNJEmUMApjChVMk1WNuZ0BKg@mail.gmail.com>
 <CAHzMYBT8a9D817i2TRqdRiJFdmF-c3WVyo6HNgbv8bJqqOyr5g@mail.gmail.com> <CAJCQCtSeAKD_bVk7GUVyLdzdSZqR8O9zEX40kCmyR--DyWtSRw@mail.gmail.com>
In-Reply-To: <CAJCQCtSeAKD_bVk7GUVyLdzdSZqR8O9zEX40kCmyR--DyWtSRw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 24 Jul 2020 20:19:14 -0600
Message-ID: <CAJCQCtTgkDJVC-yiB5pXDoymG-AbL7Ukn60iHK+Jh9zfUY0dHQ@mail.gmail.com>
Subject: Re: df free space not correct with raid1 pools with an odd number of devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://github.com/kdave/btrfs-progs/issues/277
