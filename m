Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D3A496D44
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jan 2022 19:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiAVSVJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jan 2022 13:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiAVSVI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jan 2022 13:21:08 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC9DC06173B
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Jan 2022 10:21:08 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i8so11040650pgt.13
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Jan 2022 10:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LTkYoQuTiypETWTrbQ/dFwycrgwsW+MM4EvhuxglxJ8=;
        b=boGTkwI7uOpRKPl3/YAjA7Dczm2UHGuvpJ3PGDNqwf0QD3iIywDUp6HARwN2/RF09h
         C4Iqk82PYVyx3eWsFHg//uSCvC0BVNmmuFW+F8oNMCGrC26dQCfN70VHZd8Bg/IMOKg/
         6xRP2GyoSVK1AB/HlIyBn8rRVJmGoPNG34KY0A1OxMtnqqrb3wTaNvbmaQPQV7yGlFDR
         s2yaBrlwUypok6RzI5t6CPr3j7yBmTVNGU9Jq1yNpftgizmEoV2OvEt+BsRkejT8k4Nx
         QkItPamqYdAGHCROV6xS05yD/1gJ9xG9HP1s3+RftdPF98eccbI2+qnol66BNMEK507C
         HeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LTkYoQuTiypETWTrbQ/dFwycrgwsW+MM4EvhuxglxJ8=;
        b=OLEH4kFSHrZPaZStxCyJrcHRW4xsiQzWm9Bj+WY0ve6eb2PmtNYA8OoNV+4w+nZ0IP
         S58Q+bs/t66SFZ5cgmZO9ZFxzRWLy8Xu1lSaQPMuxnD9sCFBF35zzgkm3/0u+QUgvTqp
         Wym6VsKxczmrfSVlJzjkFAlNo2ce47y2Tu9GGW5bwZrKcppJcgBx/kmVdelxbWwpKENW
         J95jzrCnyqShzsugeH2OrIyLyj2JCYVfOBRBhyYYUTsGjz5ijLbxCICHHTCY0A01NRUy
         /DxfDCW+LMpxaMsyzSMQCFEf0q5CGxFEv3asA6DKvWF1ZS86x/yo/rcVxOVI6Pdb+xRz
         VNFA==
X-Gm-Message-State: AOAM530koVIHaFMkjG3ilmvWbm3JnABCbBmI+uTmjDRF7ZdCYCQgM4An
        UdgOwdBy5ZUiFXtVT6Svq50XaFsgKZDKU1K1CNJ7oC1knGDx9A==
X-Google-Smtp-Source: ABdhPJyhN/jhMZ7Sp0pITWvenWU61dtqwLoEhR3Y2Opj5FOh0V8sS6C8S2fnaMQ2n3DHmz6QeEtRHlLNrQi+YT/CoLY=
X-Received: by 2002:a63:9712:: with SMTP id n18mr6687147pge.594.1642875667312;
 Sat, 22 Jan 2022 10:21:07 -0800 (PST)
MIME-Version: 1.0
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
 <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
 <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
 <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
 <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com>
 <CAL3q7H7xfcUk_DXEfdsnGX8dWLDsSAPeAugoeSw3tah476xCBQ@mail.gmail.com>
 <CAEwRaO4Doi4Vk4+SU2GxE7JVV5YuqXXU_cw7DY9wQrMnr9umdA@mail.gmail.com>
 <CAL3q7H4ji1B7zn4=mP4=891XfokkVyOaaqW3dCmUH6uVGjgkjg@mail.gmail.com>
 <CAEwRaO7cA3bbYMSCoYQ2gqaeJBSes5EBok5Oon-YOm7EQ8JOhw@mail.gmail.com> <7802ff58-d08b-76d4-fcc7-c5d15d798b3b@gmx.com>
In-Reply-To: <7802ff58-d08b-76d4-fcc7-c5d15d798b3b@gmx.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Sat, 22 Jan 2022 19:20:55 +0100
Message-ID: <CAEwRaO58oCzY4GjU3gCSru3Gq02GvGSdkg5hPwCKMwYcZ+cM2Q@mail.gmail.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> https://pastebin.com/raw/p87HX6AF

The 7th patch doesn't seem to be having a noticeable improvement so far.

> So even with more fixes, we may just end up with more IO for autodefrag,
> purely because old code is not defragging as hard.

That's unfortunate, but thanks for having looked into it, at least
there's a known reason for the IO increase.

Fran=C3=A7ois-Xavier
