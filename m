Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F4E2334D
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 14:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfETMPC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 08:15:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45526 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbfETMPC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 08:15:02 -0400
Received: by mail-io1-f65.google.com with SMTP id b3so10770934iob.12
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70xSC+VLF/6PE3ZpolYwHFfp5EZgSjE6e1njtnj+hfw=;
        b=LMU1oCPbMAnvjZdc3sFFDElTVk/NqCfsqiQigZFYHQdeUddZO0J5jbdeNBNAqxf+GV
         BdoBGq+sY+8rLLrjScBEWq65NiPJ4yXFa/evmqlDiSCBUnvpeMx0SD+wca/jz0jH0T4Q
         Jp+Tv16JZoSDFgFyxj+MpNiaAA8BNeueeK7VCqQKJewb21aHCiUqBw3upaRUMxr/AG0h
         fXr5MNzTgFTRNvIo5mIFO+66KjadIqlCICDCvyi2kw0D1ftww2NwWBusFL+YgXHtRvPw
         +xscIgjvOxV1RWckcIfooYSwqs1CABXCn+dgeeljMakO+j+Ou6l6HLylrxHNt198HfGu
         CaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70xSC+VLF/6PE3ZpolYwHFfp5EZgSjE6e1njtnj+hfw=;
        b=aYpnCrRnr9Q94qZ1nrz1y9RE+G2gffhc4m5RiWXIZtE4xb+7THW8OMblrkNvKHMQfV
         Bgxu2WhB3fdM5SJxZsfBJymwJ5cGYvVamlXEsWXg/kkge4fxlZYRZ+5HJ2sbW5vO8BIq
         Y6PuRWgLht3BDi5R9rjxtUxdNQThQ5ru9Wf1ndZS4tptY9I9cLuBp+HLcaNI9+yAXKmi
         MolPWsNHjfSZzvxtzDq7iSvDR73Ud9ggdhdJNO1eyFlSTNPuezvJECWtCmoinGHRtf05
         glFf8fMtQmDqNt6eBZu4PEjPacqsfOuPfLz8tTbGfYcRPZChlHuzj9Mou5xKCCDpbeSf
         hcNA==
X-Gm-Message-State: APjAAAVfXXs2BTa08JXIFA6yg1kcvFC8K6nC6p7xYyxsg1/360R7hBQt
        DlCypwHtFVlkM3tAHzN4LQa0DZ5f1RNHOOayw6Y=
X-Google-Smtp-Source: APXvYqz13jRQGMXnQzeALWOfYXoitBvmxvzFKzz2/ODK75523IrjMSVaI80yu9UiVeCMeRiaV2BLgvjWu0b1JA6LEGI=
X-Received: by 2002:a6b:5914:: with SMTP id n20mr14476023iob.239.1558354501910;
 Mon, 20 May 2019 05:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <clzY4RoSOURzgBtua3TjQ4WXJzgY3EwTyiaYwt49zFAPIi_jO2nAQ8O2saTwpqHH9x0ISw9AVbWOvVR4hFDIx8_dzlWKAzHwcOtEuwaXzJ8=@protonmail.com>
 <275f7add-382c-bf6d-4cf8-f9823cf55daf@gmail.com> <CAA7pwKM_1uWbu9ECgkqAMXMWTOJm5xH1wvHKFwq+7w=JeQQ7xg@mail.gmail.com>
 <ZBp4TxX3BVubLSjbbtXjztW20HT6YFrXCMMV6IX3xamgZbnpU4KJvO5vs0tcF5po8Ay4KdgGyffZ2DHitm4X4Hm0CFMPCjC2g_HHS9CR51M=@protonmail.com>
 <56ee6d38-d4a8-a62b-4e0d-7568030cdcad@gmail.com>
In-Reply-To: <56ee6d38-d4a8-a62b-4e0d-7568030cdcad@gmail.com>
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Mon, 20 May 2019 14:14:48 +0200
Message-ID: <CAA7pwKPZrwKcpPRvvuhgqxZk6KzC871Pa0gusTCa6oz=W=fqGw@mail.gmail.com>
Subject: Re: Btrfs send bloat
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     Newbugreport <newbugreport@protonmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>, ddiss@samba.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 20 May 2019 at 13:58, Austin S. Hemmelgarn <ahferroin7@gmail.com> wrote:
>
> On 2019-05-20 07:15, Newbugreport wrote:
> > Patrik, thank you. I've enabled the SAMBA module, which may help in the future. Does the GUI file manager (i.e. Nautilus) need special support?
> It shouldn't (Windows' default file manager doesn't, and most stuff on
> Linux uses Samba so it shouldn't either, not sure about macOS though).

The client side needs support for FSCTL_SRV_COPYCHUNK. Nautilus uses
gvfsd-smb which in turn uses the Samba libs, but I have no idea if it
works. Maybe David Disseldorp knows? Try copying a large file and
compare used space.
