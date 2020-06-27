Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B008820C137
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jun 2020 14:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgF0MNl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 27 Jun 2020 08:13:41 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45177 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgF0MNk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Jun 2020 08:13:40 -0400
Received: by mail-ua1-f65.google.com with SMTP id g44so3862619uae.12
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Jun 2020 05:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=z1cs5OnFQ8NuTwtRM6mj1+K8b8fQJ/8S7l6/gabbZjU=;
        b=J3b8mFjZcBp+VCIkkjm3T2Q3aHF/j0r0pCi3XVFYFdxFxGTJ0lkAt6vqmfpTBym6az
         fEsi3Wpk8dp4Epy5KCfUenYj5yvMzZIyKGrS76G+0R+c8gukEOZzPZIaClbLc4TN278Q
         AK2cH92lahoDJoyTj6aMypIVfMOssR+OkvUpMMEREmd+iQQCeUUGXX4JE6UZh9qVaD5r
         3exApeoSBDgsw4csX0YIB4tnEWjJ5R92jYl4MT6wWxKKlIdVsGFgzOgWDsd/AoAC6VMA
         Bl+QbmB2q6mAtkGOB3Qe0Y7BKcHX037onJv37T4LClHzMQOssNK4q2aQF9ETE+SgkyHG
         UxHQ==
X-Gm-Message-State: AOAM532yG4cZHzywrw7H4WWlAewbV7M7jJ/T2WcaNKWh9VCdj/ifDyfT
        pOT+A8r86JPgOwNuywmWkmhoG4jEtJA=
X-Google-Smtp-Source: ABdhPJxogBb6w7yKwd/5twtQDjHz5X1jtdBlDxLg/LUP0IVPXqXOIj+6UUMCw9w1blxuNeUNF8uSQA==
X-Received: by 2002:ab0:2850:: with SMTP id c16mr5397875uaq.143.1593260019409;
        Sat, 27 Jun 2020 05:13:39 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id t2sm4580887vka.28.2020.06.27.05.13.38
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2020 05:13:39 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id z9so2755899uai.6
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Jun 2020 05:13:38 -0700 (PDT)
X-Received: by 2002:a9f:22e1:: with SMTP id 88mr5417576uan.19.1593260018717;
 Sat, 27 Jun 2020 05:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200621054240.GA25387@tik.uni-stuttgart.de> <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de> <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
 <20200622000611.GB16871@tik.uni-stuttgart.de> <CAJCQCtQ8GFAdg2HJY_HqDgW8WAp5L1GoLbKqUN2mZ7s_kS-8XA@mail.gmail.com>
 <20200622140234.GA4512@tik.uni-stuttgart.de> <20200622142319.GG27795@twin.jikos.cz>
 <2E6403C5-072D-4E71-8501-6D90FB539C15@fb.com>
In-Reply-To: <2E6403C5-072D-4E71-8501-6D90FB539C15@fb.com>
From:   Jan Killius <jan@jki.io>
Date:   Sat, 27 Jun 2020 14:13:27 +0200
X-Gmail-Original-Message-ID: <CACe732ug3Pr1hSoFC3snX3Uq07HfoOPrcw0kCT8ZZks-uKM9ZA@mail.gmail.com>
Message-ID: <CACe732ug3Pr1hSoFC3snX3Uq07HfoOPrcw0kCT8ZZks-uKM9ZA@mail.gmail.com>
Subject: Re: weekly fstrim (still) necessary?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

discard=async triggers continuous disc activity for me without any
calls to the filesystem.
Is this intentional?

On Mon, Jun 22, 2020 at 5:57 PM Chris Mason <clm@fb.com> wrote:
>
> On 22 Jun 2020, at 10:23, David Sterba wrote:
>
> > On Mon, Jun 22, 2020 at 04:02:34PM +0200, Ulli Horlacher wrote:
> >> On Sun 2020-06-21 (18:57), Chris Murphy wrote:
> >>
> >>>>> You need to check fstrim.timer, which in turn triggers
> >>>>> fstrim.service.
> >>>>
> >>>> root@fex:~# cat /lib/systemd/system/fstrim.timer
> >>>>
> >>>> root@fex:~# cat /lib/systemd/system/fstrim.service
> >>
> >>> I'm familiar with the contents of the files. Do you have a question?
> >>
> >>
> >> You have deleted my question, it have asked:
> >>
> >> This means: an extra fstrim (via btrfsmaintenance script, etc) is
> >> unnecessary?
> >
> > You need only one service, either from the fstrim or from
> > btrfsmaintenance.
>
> Dennis’s async discard features are working much better here than
> either periodic trims or the traditional mount -o discard.  I’d
> suggest moving to mount -o discard=async instead.
>
> -chris
