Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC1C2316A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 12:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfETKfH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 06:35:07 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:53266 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731632AbfETKfH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 06:35:07 -0400
Received: by mail-wm1-f45.google.com with SMTP id 198so12713549wme.3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+lssdH0Jhu3CDQ1AuTZa7avnhhNR6elfyxebFRtLVVQ=;
        b=TIdsWwgD1UH2Dg2NcOLzRhg7KTXLukBL78LhL/Jyogo3w6b/1dboFrkDy7FgFkmEd5
         SW81WQGx7V3/h/2htw7RM8VDuQR2IZ9jyTcP919mHDb7flHnBLb655rSdvCzs+4K/aRr
         H+Zw7YQluI64/ZRe/8SrAzdE6IQuBd7hWU9GMC4EXndGASfKYUUTUtFNUCbmaPL2zfvq
         0B44yhDg32QjDEmBp6nfv8vXGhpDsyeWCiu82x5fQJ0QLpD6krIG/cBo4fiS6B40VzeY
         05feBlXMzyK2cEKkS/No5NMbcIGCeRSVSLfthTsrfhDliICGpermhYb8/IVuaIAgf5Ws
         f7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+lssdH0Jhu3CDQ1AuTZa7avnhhNR6elfyxebFRtLVVQ=;
        b=A3Y8WP5Bkr1YAIVb5fVELsyIHKXbB4mG2dqPptwgN8UlRJp/8NAyNPFbRn+tnnNCeB
         vguNnIjleujc/BTyJD4lYnOdpIxz3Udh2zv/9L4ZFioYHE+hljFXNYdH5+OQfE23iE/k
         /lZ1ti7rsAvr3uJywb4Z7bTJm9F6rg8HXd952h3ou8LXP1lxuH+YFHfANKRRMnkiL5Qj
         UsifkfIelc37yNnybNq9W+Uni/cF3KwlXmS00nr31qnZKIPrn3szIr+ETd9wVQqoFkLi
         nUa/ch9c/QNeQrtehp5f1JbeSl3D+0qZzuebCfIcKqqYuqnhxOgQDz73g+KnkIgqGG9r
         lCbg==
X-Gm-Message-State: APjAAAVzeXdXuP1zTcba72dDAfupHdWzy079FvUSvyOYmHqccTwM5AmL
        hLvkrFiOvhpCH7e3vy6GrWNSMDmuUgbAMh246CpTRzOU
X-Google-Smtp-Source: APXvYqyuYvMM7QCmWU7GToUWOY8Q+vc1EBopwFmwgUCeKadSL+X0NvxpQ792n9yzXlVvnu1IwWpV0SWoXtxyL6DCuD0=
X-Received: by 2002:a05:600c:23ce:: with SMTP id p14mr25979599wmb.36.1558348505319;
 Mon, 20 May 2019 03:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <clzY4RoSOURzgBtua3TjQ4WXJzgY3EwTyiaYwt49zFAPIi_jO2nAQ8O2saTwpqHH9x0ISw9AVbWOvVR4hFDIx8_dzlWKAzHwcOtEuwaXzJ8=@protonmail.com>
 <275f7add-382c-bf6d-4cf8-f9823cf55daf@gmail.com>
In-Reply-To: <275f7add-382c-bf6d-4cf8-f9823cf55daf@gmail.com>
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Mon, 20 May 2019 12:34:51 +0200
Message-ID: <CAA7pwKM_1uWbu9ECgkqAMXMWTOJm5xH1wvHKFwq+7w=JeQQ7xg@mail.gmail.com>
Subject: Re: Btrfs send bloat
To:     Newbugreport <newbugreport@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 20 May 2019 at 02:36, Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>
> 19.05.2019 11:11, Newbugreport =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > I have 3-4 years worth of snapshots I use for backup purposes. I keep
> > R-O live snapshots, two local backups, and AWS Glacier Deep Freeze. I
> > use both send | receive and send > file. This works well but I get
> > massive deltas when files are moved around in a GUI via samba.
>
> Did you analyze whether it is client or server problem? If client does
> file copy (instead of move as you imply) may be the simplest solution
> would be to use different tool on client. If problem is on server side,
> it is something to discuss with SAMBA folks.

Also try the Btrfs module in Samba.
https://wiki.samba.org/index.php/Server-Side_Copy#Btrfs_Enhanced_Server-Sid=
e_Copy_Offload
