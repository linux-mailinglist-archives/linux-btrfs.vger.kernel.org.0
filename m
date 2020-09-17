Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E381D26D97B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgIQKrv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 06:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgIQKrf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 06:47:35 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4750C06174A
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Sep 2020 03:47:34 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id f82so1787990ilh.8
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Sep 2020 03:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EYP0l981WinCRpG0BQMz4qZFP8BZ46bu8MMhK2FkeeA=;
        b=mnGKtN74G8N8VXDLUt6a/jQsnhtRK8EvBgI3KpH2KAnVmB7Qy/+KN7fFcd7cZl8FTq
         gTAomNHN1FIeusE27g1wGCGDUGtSiJelaRw856/8VBrQ+nXgBF3bf4G9uAhAZClnH1hN
         HFyb5pfUiYrr8ZGRn245FxRdaWAOc71hRag2PeO6eW09KJj9PRvAhD/j85vRtLCV+CmU
         Ccw/8B69LPMN/PRxeVDLoK8ifSl+oa3dbouwy/5p8xefFbZnqloOTa4ywzX/airtMJVd
         SqZv3GgLOiWDJOpeAwi+vuds3Jj6ncfdgpcur/bcUHuqkPfMQCeCl2EYNn2bZGj3xF0i
         XxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EYP0l981WinCRpG0BQMz4qZFP8BZ46bu8MMhK2FkeeA=;
        b=iPQYF6ciHUn4CUPzLVGRY3NbifVV9CGexVqgYv30CnMHfVq04ncx1GD0YoZcEqjq7y
         QmsNBjZpdfPjVln30EQtAxu9I1KJmHUSBtT7Ek/BK+GppzaJ9iPz2DI4SAjn5iA5Qk9G
         Et8fEdZTcAWXHsH7gpJ+YIBhj6tb8sAo6pBs1tDgNlSur6r82tlU/hOYuvimyHkqrmFc
         ZvEpfUQRgZjMZDl6aEHVshg8vt2x7VBwTGK3dURMlq7V3mjUiq7GhOB/Ya7xGww19WIl
         AybcgGJ3NSU0d6/gnMG9RDKJfQ5yGOPNBRCTnMTjbUFOQtIBLWKENWhgL7akEprlEyo9
         5Eww==
X-Gm-Message-State: AOAM5312a9RjHm8Yu5gTSr3DOYBBWjUktZoUHrz0oDRJ0DD5zD7l78r3
        JSspBsMYwmjXOJsmiQgICoomfn+vDeSqOs0A8aA=
X-Google-Smtp-Source: ABdhPJyhqUNSrWIO2tqUFp+39CoFjJIkiOihkO0V9yauYQWMyDxDh8BUmQZGwHEiX6FdtAPRB6nfG5wcDxR3YDMNQuE=
X-Received: by 2002:a05:6e02:e4e:: with SMTP id l14mr24025730ilk.10.1600339653811;
 Thu, 17 Sep 2020 03:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XNQ=ijYZbtTejEcdfgOAgmUu68d7c2YL-3BLQfokq3YYuZNQ@mail.gmail.com>
 <9b5706c1-fe21-6905-9c42-ffdc985202d9@gmx.com> <CA+XNQ=j1=XObwis138fphNcRVfwgXUcfm7JW1FJG2UWm8pBEGA@mail.gmail.com>
 <9415e33b-c018-7a60-33c5-4d2b992bca80@suse.com> <CA+XNQ=hVzU5vWB-hw=3vVpiH=Fmx5QAeE-uvmRkSavD2wspdbQ@mail.gmail.com>
 <927663a6-589d-e35e-99a7-3ef74b87d046@suse.com>
In-Reply-To: <927663a6-589d-e35e-99a7-3ef74b87d046@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 17 Sep 2020 06:46:57 -0400
Message-ID: <CAEg-Je_zAnNybwESr=giF2aenLfnpfxW5N0vzRbdB2oZS-++xw@mail.gmail.com>
Subject: Re: Need solution: BTRFS read-only
To:     Qu Wenruo <wqu@suse.com>
Cc:     Thommandra Gowtham <trgowtham123@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 17, 2020 at 2:31 AM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2020/9/17 =E4=B8=8B=E5=8D=882:15, Thommandra Gowtham wrote:
> > Thanks a lot for your response. A few questions
> >
> > - I had evaluated the SSD health by looking at the SMART attributes
> > and did not find any faults. Is there any other way to evaluate if a
> > problem is indeed hardware related?
>
> SMART should report read error, but I'm not sure if all vendors follows
> that.
>

Unfortunately, in my experience, most SSD vendors either send garbage
SMART data or do nothing at all (always report "good" values). So
SMART is an unreliable way to determine SSD health. :(


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
