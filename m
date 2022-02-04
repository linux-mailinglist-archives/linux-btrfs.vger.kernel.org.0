Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426684A9860
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 12:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358369AbiBDL1v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 06:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358367AbiBDL1v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 06:27:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28564C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 03:27:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so5877875pjb.1
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Feb 2022 03:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g93ivFOOGbh5jcvtz3qNtPKQrhCOznH92wLjilef/RU=;
        b=qpQfccTlOXSnhL+NDcV3h27dXd5d2+UIW2BmePy7KZKRX6Nx9GeIS0HHcBACU467BJ
         fVDU4wzJwP1FcWIP0xpYfjCcUqSzZLEA2JmRtjPnFSmKFna2xbPMtNjFYFQN3GdYp01Z
         B4DkniAuzNqBEH5qNg9FrKoU1P6K7tDrF7tHW9aC3XrD4rVf2b3PzOG/NSUslwcRsbXC
         mk57oUcCNU1CFEHfVxyoiqI2491A4jnWgn9D1U5wPzieK6CL7XXWd6n9KskrhjHZzSB3
         5pJZa9w2eEWSY5wBiFcoPpDB1mxuZe3HB/0Tp/uubdtAkbU9FcTDT1GDa/gtN3r4ChDG
         2byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g93ivFOOGbh5jcvtz3qNtPKQrhCOznH92wLjilef/RU=;
        b=iIN0vLQaKla2JwnXDYalXJUbYSHDlTM0kNGaoTkLYrEjpNy+wlhaWOYtqu6V2N1pDJ
         HtzqKGOt/UwK+9UHsTTvSwDQKQKHSzldIK0OIfwSr6pZbjqJpGn3Mn/3LZLBHbOQKlCt
         4Nu68PbF2Elszp/WdqhM+3V0n/jMbRRbbADIb9XUIgC+tH5ew4O8JMn6VbwBbC2oLa4x
         B41FcT2bOaTQc5eL9zpUbpDIdaSXzi0X4S8piTNMz/XwSXOzgMaPfMNzZZznW0qg8akq
         4e1/4niU7M6cRbmyNaQqQKNArRbeArdxvcVgrXFwlDJ1frX38YsgywVo5NENORk6qM+X
         Huwg==
X-Gm-Message-State: AOAM5328ojiAY8E1Tksl1vThcqY84+x55BMxNg1cC+FFsxAYSIx9Gpyj
        rNTzfXUDM7Zx+FEh2f4pf+i7IoeiNMFuDsKSncyahlqr78k5bg==
X-Google-Smtp-Source: ABdhPJz/atKQuRJ6vEoOsVOQpeLACdDVZ91zgJ97Ft1Ye0nYjuBEbloegKOPtSJYHTjzC3LRmrzmVFBCNlYOCvrVFcs=
X-Received: by 2002:a17:90a:fa82:: with SMTP id cu2mr2607777pjb.212.1643974070676;
 Fri, 04 Feb 2022 03:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20220125065057.35863-1-wqu@suse.com> <Ye/S15/clpSOG3y6@debian9.Home>
 <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com> <92236445-440d-b1c0-bd76-b8001facd334@gmx.com>
 <CAEwRaO6xT_utSgyHuRhEK+C6Y8uvLABJw5FS=TitsMVxODo1OQ@mail.gmail.com>
 <CAEwRaO6qcxr7ArAhkL-s=yRyNxmupFSVZL_w5ffHXagPQbiAgg@mail.gmail.com>
 <e67bb761-c4bf-b929-0bee-650f425248ac@gmx.com> <6f76b518-b509-dd45-11bd-c75aa78a5898@gmx.com>
 <CAEwRaO4Fo6k2-UjtJaAKjnP79a02C2eQsjoju41HXOzNP9nL-w@mail.gmail.com>
 <CAEwRaO69PQKC1Hn=vWt92BNk8ZQwtz4t9dW4uHYJpGGqYkmjNA@mail.gmail.com>
 <4fdf158c-203e-6def-27e1-8a003775693c@suse.com> <CAEwRaO4H_KTRBn8adNr0b_Ob_9-yYZhW=R7B1C+J=uDzL=NdWg@mail.gmail.com>
 <c4a8ab03-792c-2d95-4f92-a7ba7b5b0f31@gmx.com>
In-Reply-To: <c4a8ab03-792c-2d95-4f92-a7ba7b5b0f31@gmx.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Fri, 4 Feb 2022 12:27:39 +0100
Message-ID: <CAEwRaO6_XKO_bNBLrgAW2v2-H5VPHspMdgVRPHfBw6m8HKpcuQ@mail.gmail.com>
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper defrag
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Although now the legend only shows write MB/s, but I still see some pink
lines.

Zabbix shows slightly different colors for statistics when the
timeline is zoomed out far enough: reddish pink is maximum, light
green is minimum ; the legend shows the average. That was indeed a
little muddy in the previous graphs!

> read MB/s would also help.

Here's a set of separate graphs with read/write ops/bytes (no real
difference in reads):
https://imgur.com/1Zp47zj

Fran=C3=A7ois-Xavier
