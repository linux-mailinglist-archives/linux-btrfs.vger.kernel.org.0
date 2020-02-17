Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96AD161445
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 15:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgBQOMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 09:12:48 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:41461 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgBQOMs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 09:12:48 -0500
Received: by mail-qk1-f180.google.com with SMTP id d11so16246419qko.8
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2020 06:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S+4vt5G3+tTYUWVOkf1cHZLWfWtYa1FLtuLPzgV9D5Q=;
        b=gUnTRzxosB2DM3vpCHwnXW0JWjaMYDZ2ZATW6ixT+bFUQsQXz9fZP4PTUTonLU11oF
         qWK60DW1moElb4ncx0NaaASwBepxlB1f/L0IK4itKwqhoIlOK8FypEgQk8b5MlDufmxT
         nJm/dbCoqwLKUm8zMYJqobS1hBdmXad1+Pu4DbW30Og6ImXMLB2xRumfnLAfz92yUDzl
         udXrcHNKr6eiPLiTFweNrjJGntf3Mx99wm9ywROXShIZdlYG48Defur/wsFA9xzRykWA
         aIFpx6rZqvuCWUVRtaCtmORu0LuwiZbYupsk+BnHFzPSxLtTTJLTfNAC6Yg3y09Hp7z6
         PqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S+4vt5G3+tTYUWVOkf1cHZLWfWtYa1FLtuLPzgV9D5Q=;
        b=hcGxDNyx3I5JsieOW4ZAjVw0JqkecLI7ceHNYljYIfnuLZq8Nnc2NnsM4jlfmBeH/l
         jw2FNpphyTVOPGtWbYXQ/Dx6KBW0AuQCJUtKvJrqiYoOSirqHC6CB2InreJYKat/3FfD
         68iAG4ywUQ0zE/neM83H/1PJA1wI6UDJn//tDlFzB1Tk7tY+4kiKGPX4pkITQai2rsWM
         J8vQB276/hFNUwkI3LeVqvhIL2sAS0Yb7fsKlNPUeWP0/Rrd0Ub3n9Lhi9pPPP6g4MQj
         RkbC7fUGO19bOrfr26lF6K+MCmLE8Phw6eGF1K7zoCfJXS+P/jEJX7K6beSYOsfwF5EQ
         Yr+g==
X-Gm-Message-State: APjAAAXo6jAK/tgcA5Du79MjSZfLwrUI3z8ws9gvijEDCYnnowLCnnMw
        WY3RtSgmxZ7tzTsGjbg3zlCrFhEpTK5/a2izNS53zdNl
X-Google-Smtp-Source: APXvYqz90MAfhfaR3LFhQ3wnM/Ha7IRYNBEC7PAbhLLW6kV6gIzfrJImb1s3WecbicrqwfzGAyLWThBAQBf2Wf0kk9Q=
X-Received: by 2002:a05:620a:1586:: with SMTP id d6mr14739900qkk.234.1581948766855;
 Mon, 17 Feb 2020 06:12:46 -0800 (PST)
MIME-Version: 1.0
References: <CAJVZm6ewSViEzKRV4bwZFEYXYLhtx2QFvGiQJOD1sNdizL4HjA@mail.gmail.com>
 <641d8ba2-89c1-83ac-155f-f661f511218a@petaramesh.org> <CAJVZm6f6ntgnTuC76Juz9tkro1ybQaVLCV2xmPqyt5_9tPQP1Q@mail.gmail.com>
 <baa25ede-ee93-b11e-31e9-63c9e458e6e1@petaramesh.org>
In-Reply-To: <baa25ede-ee93-b11e-31e9-63c9e458e6e1@petaramesh.org>
From:   Menion <menion@gmail.com>
Date:   Mon, 17 Feb 2020 15:12:35 +0100
Message-ID: <CAJVZm6dyD1w6i6oRECGMhVOZcEH7OQvS_fP5bOyC3C7ZEi6Omg@mail.gmail.com>
Subject: Re: btrfs: convert metadata from raid5 to raid1
To:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ok thanks
I have launched it (in a tmux session), after 5 minutes the command
did not return yet, but dmesg and  btrfs balance status
/array/mount/point report it in progress (0%).
Is it normal?

Il giorno lun 17 feb 2020 alle ore 14:55 Sw=C3=A2mi Petaramesh
<swami@petaramesh.org> ha scritto:
>
> On 2020-02-17 14:50, Menion wrote:
> > Is it ok to run it on a mounted filesystem with concurrent read and
> > write operations?
>
> Yes. Please check man btrfs-balance.
>
> All such BTRFS operations are to be run on live, mounted filesystems.
>
> Performance will suffer and it might be long though.
>
> > Also, since the number of HDD is 5, how this "raid1" scheme is deployed=
?
>
> BTRFS will manage storing 2 copies of every metadata block on 2
> different disks, and will choose how by itself.
>
> =E0=A5=90
>
> --
> Sw=C3=A2mi Petaramesh <swami@petaramesh.org> PGP 9076E32E
>
