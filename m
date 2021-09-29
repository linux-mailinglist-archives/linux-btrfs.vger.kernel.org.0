Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34D041C828
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 17:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345162AbhI2PT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 11:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345081AbhI2PT7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 11:19:59 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3DCC06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 08:18:18 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q205so3576860iod.8
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W8/1xNBRZafkOEhMSJBPasrJm9N2rnAffDOd2cTejjc=;
        b=gMWT2b77U0QLLypi+Tbr8nQ3IbAVa7VUwBEJUh9VUlZ04gkxeAwYp9muY2FLly0qpz
         3BwWVd43PcM99jFtQFxmvoq1dtVWf+pWy2mMhSlOxGyUXJJhTGSElqL4gmq+iM9rBKO4
         TMxOrEPyu/JcUsp+6vBlbWdl+fk1OEm9sR3MZNaWYXcSq1UZCXSNVtzvhGkiwBMg5EuE
         /Uw16K3QxI6++P8bR979ekK5FT3I2EPqCnYE2Mfzsd72ryq1oRHykGmbjzHqPPYlsuZx
         TKpFytcxD2mjJrSszkGSRbES9sZL7j4bg7Iel42STYKlIH5SmSDR3cJfiwA08BnIXFRN
         L8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W8/1xNBRZafkOEhMSJBPasrJm9N2rnAffDOd2cTejjc=;
        b=7X9f7luS7QpD6lLeSGRprk8i7eS5d04XiN5IAwpTi1ptET5x1dzF7aicIPhL0VzxwN
         4i4KWF49pJ6hI+3FQLoUu2vok8j3t7tJxScX4rDXtPvdbVeRvA2VfSSaTUy6MlgidTCF
         T55cPT4GQY7NMFBYBf3EsRyPhWXQxtCzwjWAh3nP5vsThNnYpvtwdgsoEmziiRHLL+EF
         sIlnIGped84qWNFSangt0XJedVaCxw9ym3ZzIL055cz7VGm90BEfl3ufL0g2DfIe7Eov
         FBNK1WzAIoIniWfpzT8f3410aiGlWiyCedogIIMp5J487frl3kWMF4rxqz5UaKZRNVTi
         uYLA==
X-Gm-Message-State: AOAM5314Y7w0A5vkXJQqW8k6cw3WNUVuCFzWiDEEAQi/qJ5UaOIS69qv
        whLwdP4VnesVLeJVdaQyJr2OnLQzXKf7fjufTpAwdkvacC8RQLDT
X-Google-Smtp-Source: ABdhPJwfimWXxGDXeUS1U/gXUGDweC5k1H9wVah0z0KEoiX2Ub3y0CoK4EqFqTEk3M4/8Dwa8TSKTsUtpHMYbriHpCc=
X-Received: by 2002:a05:6638:35ac:: with SMTP id v44mr359357jal.48.1632928697476;
 Wed, 29 Sep 2021 08:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com>
In-Reply-To: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Wed, 29 Sep 2021 17:18:05 +0200
Message-ID: <CAK-xaQYo1vRi10ZY09q2=7oCTPy1s_i8-rZV_vyc0AMX1JOQLQ@mail.gmail.com>
Subject: Re: btrfs metadata has reserved 1T of extra space and balances don't
 reclaim it
To:     brandonh@wolfram.com
Cc:     Linux BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno mer 29 set 2021 alle ore 04:41 Brandon Heisner
<brandonh@wolfram.com> ha scritto:
>
> I have a server running CentOS 7 on 4.9.5-1.el7.elrepo.x86_64 #1 SMP Fri =
Jan 20 11:34:13 EST 2017 x86_64 x86_64 x86_64 GNU/Linux.  It is version loc=
ked to that kernel.  The metadata has reserved a full 1T of disk space, whi=
le only using ~38G.  I've tried to balance the metadata to reclaim that so =
it can be used for data, but it doesn't work and gives no errors.  It just =
says it balanced the chunks but the size doesn't change.  The metadata tota=
l is still growing as well, as it used to be 1.04 and now it is 1.08 with o=
nly about 10G more of metadata used.  I've tried doing balances up to 70 or=
 80 musage I think, and

Similar situation here.
A 18TB single disk with one big snapraid parity file, and a lot of
metadata allocated.
I solved with:
btrfs filesystem defrag -v -r -clzo  . (useless the compression, in my case=
)

So, just after a little bit from start  I saw already space reclaming.

In the end I fallback to exfat to avoid to keep re-reading/re-writing
all data just to avoid "metadata waste".

Ciao,
Gelma
