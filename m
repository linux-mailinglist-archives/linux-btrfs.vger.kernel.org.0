Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F072D5807
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 11:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgLJKKp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 05:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgLJKKh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 05:10:37 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FC4C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 02:09:48 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id y18so4182944qki.11
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 02:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9zc1+U5xEyjYPIKXVMQtzZ+5Wd/UuFwG02rd+rgq8cs=;
        b=HVeU0wN16phLW+3KhpxIKwDgApVofTrQzEz8VXHi0Dxs+LS6zlc8uoOxGiYXc5uDZv
         wNLbIJLHiLCMmgbwWcsdkiClLHEa9+26s0FLMBKLBrp4j/K9Py6YKjjSCDldzPPnynlq
         CC1YGHZWb1lsc7nOkBKmRXYNfZCijl7c3a6XiDIRAoseBF8Ry98AnbKbsXXkzukeem6K
         fu0NqrCKLp52auPaS5HY1PmyS4M9nQ5yXOuZzhGSmPZ1h3ZFlgfnsvDg7vQWrfS3fFMU
         lBKjGNkupGza1pV8+3arLml1quJAhMFeIadMLpCgEEohj6FterUZIcB9i25xSFYaT0pn
         LCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9zc1+U5xEyjYPIKXVMQtzZ+5Wd/UuFwG02rd+rgq8cs=;
        b=AJNfX935VR527kLcIlJhYuGLv8cxIKkIiLyohwLx3TkbfPjBbgS9Gqa9710GNbJjGu
         V1SAZcd2qp/NIk9StPxB0aFp1jsAWNpV4U2h+kBh+0jjUlVkIJd5beKS1yFPQWilmy9x
         IZrileU/kkvE/l1Mo3Z9AVj214oKWjvN0tk9bkkzAgpwlGDmKgvBqjaDrdc1+Y14rkG0
         ONDX6Sa6JLmwaJN4aOFEOplrw/bktjY6hWGjLNVkkRuVr66M+mwzcbQyz7QJ8Sl2wGLb
         g/3SVUcFX+cdE2LAi6Y89Lqi0u7VsDedV+PbrjKSTaFXeGbxQhzsh3wOhzfjq4k5g1ff
         qUsw==
X-Gm-Message-State: AOAM5333G53S3aliN04sjBXm0Li3L6bvCf5wssL54roPJerj/qujiRIi
        whsVUxkKtcj3QuasKvRmji1ZO8btVbWLOWNOekc=
X-Google-Smtp-Source: ABdhPJynQEzyJVYbOnQJ0cldSk6lvssd0MarKmHvmUgHumIBq6o/DYZMDvyQctPF7WGtguBwxovYvqMx8g6HNKPLP84=
X-Received: by 2002:ae9:df47:: with SMTP id t68mr7937486qkf.438.1607594987497;
 Thu, 10 Dec 2020 02:09:47 -0800 (PST)
MIME-Version: 1.0
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
 <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
 <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net> <CAL3q7H5AOeFit_kz4X9Q2hXqeHXxamQ+pm04yA5BqkYr3-5e+g@mail.gmail.com>
 <40b352dfa84e0f22d76e9b4f47111117549fa3bb.camel@gmx.net> <CAL3q7H7oLWGWJcg0Gfa+RKRGNf+d4mv0R9FQi2j=xLL1RNPTGA@mail.gmail.com>
 <1f78cd5d635b360e03468740608f3b02aea76b5d.camel@gmx.net> <CAL3q7H4r-EtnMc=VD2EP01HsLCqg-z8LfMnFseHrNEv=rjPT_g@mail.gmail.com>
 <1d40f2a14487b6f052c2be84a38b5fff18d088a3.camel@gmx.net>
In-Reply-To: <1d40f2a14487b6f052c2be84a38b5fff18d088a3.camel@gmx.net>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 10 Dec 2020 10:09:36 +0000
Message-ID: <CAL3q7H5b5d1X6WhQeX0=-Pieo66K=2n7c=KCuFpU74du3fkmVw@mail.gmail.com>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file or directory
To:     "Massimo B." <massimo.b@gmx.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 10, 2020 at 6:23 AM Massimo B. <massimo.b@gmx.net> wrote:
>
> On Wed, 2020-12-09 at 10:29 +0000, Filipe Manana wrote:
> > So to confirm if there are other problems, you really need to let send =
and
> > receive processes finish (don't kill them). If they finish without fail=
ure,
> > then check if temporary directories (or files with the same name patter=
n)
> > still exist or not.
>
> Ok, it seems to be working.
> Thank you very much.
>
> Can you put a note on the list here, when this is going to be released an=
d to
> which version?

Sure.
Thanks for testing it!

>
> Best regards,
> Massimo
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
