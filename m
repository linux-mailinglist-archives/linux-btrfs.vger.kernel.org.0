Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CEF2C893E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 17:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgK3QTN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 11:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbgK3QTM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 11:19:12 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811D5C0613D2
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 08:18:32 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id b12so1664890pjl.0
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 08:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=0dJitds3ZeVs0oaZapxLzhdfjOP25ToOE2TCrQ7IDjA=;
        b=sa7ljTWnWuieoXEM0z4pa5DGMp60hA1hMHbMDyhDTOLGVdqn7N3QbhQ9Yy5fC47uB3
         FzbnrMKrdfQZDJsMMusprl9q6jaAr/E22PhYDLf5coZ4qKKREb2fSb/+Ksg0YrltOXhD
         p4Vtwj2QCtn5TmvctUkAeEXm2m0EiCz3zheTxs5S4L8ECsq+3mWKKaJSwHbVRacA7N9E
         0JpSmxqFq0yk3JpbQhDGxCJaxEsVllglrmOXoR4U9XdvBoy9bXGpRuYZdqhy8vBqyZG8
         EPmhg5goPE//j7OvJ8kCSBGPot9qara2CC7yqrUj91w8KIbX9oDKxOq2LLLYOkTYMphJ
         bmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=0dJitds3ZeVs0oaZapxLzhdfjOP25ToOE2TCrQ7IDjA=;
        b=uEmq9HMnzENg9Y/PgPPw7uVrcDKOVr9UsNf9PjDNHOVyyhTn4RetvJJAt9poD4ApDX
         HzloscWk/f+R0pMwV8qxdbgXDYz1LEBUWaukEBGHm7JH6iWr6tkCbJ/goNEKJJal3uvx
         Tn5HmW8Ep2mAc6szcxq6+dWLzuDfzIY4JuHKFlNTx2rJaLlrb7yYY+PSBZOHpp4SHC38
         91/gStFIhQFk0xDWKatmHpRj3jguGBJNhnNtnEIhOhxDFP6nWCeLc8gZu4UbcO/bRMru
         B4fvzckomSvEYGGL59QTcFpbn4riFzQ9IzZ27zBJx7MyepiPbcZ8gFSNXybpb/oOtzCY
         uFHQ==
X-Gm-Message-State: AOAM530DbGri/p0k8lOLoK7bfMWQT3usnYdPMYUS8J3W3A7jF6Tb8r6B
        gmoTiEpvtUDD/2fuoK88FzqLKXHOwHXJ+3VolRI=
X-Google-Smtp-Source: ABdhPJz5hN1qSVxnrRq6PsRlN6QnRQ1pkkrjah8H/J+Emu9vLL4wid2mXx4Vz/eU8aQBUUliV+302BwKzrF3vThkwu4=
X-Received: by 2002:a17:90a:43c1:: with SMTP id r59mr27454753pjg.13.1606753111920;
 Mon, 30 Nov 2020 08:18:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:90a:ab13:0:0:0:0 with HTTP; Mon, 30 Nov 2020 08:18:30
 -0800 (PST)
Reply-To: jm7398911@gmail.com
In-Reply-To: <CAPZuYWEsP4Qgw+h5dVUBOny6ZJWnyQEz_gGriLg5srLF-7C=wQ@mail.gmail.com>
References: <CAPZuYWEsP4Qgw+h5dVUBOny6ZJWnyQEz_gGriLg5srLF-7C=wQ@mail.gmail.com>
From:   Jack Martins <jm7398911@gmail.com>
Date:   Mon, 30 Nov 2020 16:18:30 +0000
Message-ID: <CAPZuYWEBfuzoQ6U0-2_N1NWESwu3cJvKNZH5EqTOsBFib3MBWw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, I sent you an email few days ago and I do not know if you
receive it, I am still waiting for your response. Please reply me
through my email address
