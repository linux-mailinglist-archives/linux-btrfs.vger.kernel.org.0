Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6B5C1613EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 14:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgBQNur (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 08:50:47 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:35195 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgBQNur (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 08:50:47 -0500
Received: by mail-qt1-f175.google.com with SMTP id n17so12043247qtv.2
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2020 05:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PrNMJ1EAC4IcivKh+EiDEwDKWTs1CBWKr94WQhR0jTg=;
        b=WV4i3VLQS1dpxCwjH9oHNon155rE8hJVOey50MzDPNZY4YNYEAeQo6QuG/wcnY8FJd
         inja+1zUWFzo0kZk/+DvQQgOQRyykT2fUGf7liMYjPOQufrOXogBU1QsglmAOwGllqnB
         2JaKKlZHL+0SX9XTlkBHUuC7GlV+jWZEr02UQ4Hifb7p+LOe/tH7QkoA49T0ktQV6jRC
         1GnWwIT6wkHhwcCJh0jVrF86VxJDD4rIlL4LxiU4FEYS2t3tQEafjO6/X8BDmUVOeNCz
         WD81NdFC2Tt8+EG1JbRwKh53WgFUdPWoVono6Eu2n5uWoEFFpXVrb+H9diSAoY1B/CEd
         KuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PrNMJ1EAC4IcivKh+EiDEwDKWTs1CBWKr94WQhR0jTg=;
        b=kCO0bNRHiCM9pgzdTMfbAZvjxUvQ1+z87hGN481/d6SSQ9c2YevC+srqidDjpy9knF
         ZjP1qNtcU5hOOuIcX1sa5DWqOVRkmXTYyCqSVBNCu0b04t+wTQhQObpA0hjNn4ETrF5X
         DPBbXVvFAYDrhzY+Fgf8T9EHQEMYU00/kOv0kgYK4yMpLnd/TBPENe+jiPoSuAQtOYg/
         1vbaF3HL4aFoKDWIt+DfBFV6uc44MH1ZSCYacAI0ECO8UD7PP3of40o0Ljf/iWMXby57
         KEah5//h/grsZYFcEFQMW1xDFmhDLhi3TY/Ao+ENy36506/x/n7c/+S3GYX8SfIB1flB
         XoUg==
X-Gm-Message-State: APjAAAWHW7g5jHLnYENFbDehzjOg7Qt4c/qtt9dMgS1PCA4zDDQLAHMR
        MI1ym0lLpxdVm0PbqjyhOaL32BCngQihRh3Rl5tUsg==
X-Google-Smtp-Source: APXvYqwyxoabix4P6BTcu+I8RHn6U2MQepDgfzxaGBWstoFjK1yyjtEVZ3GC7gfulq3JFM2Z1OTPdrLHesJH/Nmg5TI=
X-Received: by 2002:ac8:5510:: with SMTP id j16mr13129223qtq.262.1581947446390;
 Mon, 17 Feb 2020 05:50:46 -0800 (PST)
MIME-Version: 1.0
References: <CAJVZm6ewSViEzKRV4bwZFEYXYLhtx2QFvGiQJOD1sNdizL4HjA@mail.gmail.com>
 <641d8ba2-89c1-83ac-155f-f661f511218a@petaramesh.org>
In-Reply-To: <641d8ba2-89c1-83ac-155f-f661f511218a@petaramesh.org>
From:   Menion <menion@gmail.com>
Date:   Mon, 17 Feb 2020 14:50:35 +0100
Message-ID: <CAJVZm6f6ntgnTuC76Juz9tkro1ybQaVLCV2xmPqyt5_9tPQP1Q@mail.gmail.com>
Subject: Re: btrfs: convert metadata from raid5 to raid1
To:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Is it ok to run it on a mounted filesystem with concurrent read and
write operations?

Il giorno lun 17 feb 2020 alle ore 14:49 Sw=C3=A2mi Petaramesh
<swami@petaramesh.org> ha scritto:
>
> Hi,
>
> On 2020-02-17 14:43, Menion wrote:
> > What is the correct procedure to convert metadata from raid5 to proper
> > raid scheme (raid1 or)?
>
> # btrfs balance start -mconvert=3Draid1 /array/mount/point should do the =
trick
>
> =E0=A5=90
>
> --
>
> Sw=C3=A2mi Petaramesh <swami@petaramesh.org> PGP 9076E32E
>
