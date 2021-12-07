Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E898446C077
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 17:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbhLGQPF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 11:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239528AbhLGQPF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 11:15:05 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4823C061748
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 08:11:34 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id n66so28492695oia.9
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Dec 2021 08:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9kWcOhyV4MLD7N3cUXHI3BZJ2yCj5zMdKKs9yLBkL0=;
        b=BM79zBgUSTyK1Robr0f0N9uhbY4DGM2nNQiaYgZ4SMKtyqXJOOQEB1+g7y39n+nVEY
         EOW17d1fa53fMN4/yuOE4/onevo6x1Y/WaXHfajoZKX/EOooyljX5teSeSbpLeIKYLMx
         4eI1eiBo5hgRJtMB5V4rz3FWqfW6WKgLmfO8pRR/5GDGPQ49e2sa0RSQwpmbSviWD7dR
         xr5Q4cYaqaGb0C9VqUi+t7BtAD9fNia33lg812eqDJ8qCcrbv8O1c89PJdk4p2mZU/Tp
         F/LopKh3e8XUGmeNVQVQVsy27qeBhvX5Y8HjctiaTwLAgU3iGrzpjIfIZ6NQy/HEOkpl
         wrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9kWcOhyV4MLD7N3cUXHI3BZJ2yCj5zMdKKs9yLBkL0=;
        b=VQ9kRPTzHE+psvDZTWXib+O9GEUOPjiD44NmF9eEgVj54EtrFwI7SP8cn8KspsifJC
         SXu+JqBZ+fXs9i2QRQRNF1BsoDJbirKaz5Jy/tLjVvusGFf0gV7jQVfoX5knnLMlbFc1
         IKaMWqmHgPkschGKPe1E+w+u3ZjjXGnmJTLryhV0PBkyzz5vDn8NGUu2Gk6I5sL8stQo
         QVD2/E+1LTapqnD3R817F3NGUPOvQOEZW5or4/c3x+M/CSMrtvmDeScftrhAi4CnI/0N
         kU77SThjeqb34mzHt1aLqLlnS1C+m/VNHQtUHABT+LeGiGPsi/wruZWqdtPgNmeDdgD5
         F9Gg==
X-Gm-Message-State: AOAM532NawXoGkpp/axuXLYiz2qgDTC/P8D+4txHaVuoufX/lKpfjw8p
        3tu5RzhWVZ2NfeF3UDhbZYGyPcqUo4nngsko8Lo=
X-Google-Smtp-Source: ABdhPJwthf0cC3yLNNCmvkto7ShrwKFr5KGIdQvPJEGH4HSDGhWtN73QyJFi054eDGt2U5/HJMJp5pVS03MxVtd2gGQ=
X-Received: by 2002:a05:6808:3b7:: with SMTP id n23mr6041255oie.160.1638893494144;
 Tue, 07 Dec 2021 08:11:34 -0800 (PST)
MIME-Version: 1.0
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
 <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com> <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
 <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com> <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
 <20211207072128.GL17148@hungrycats.org> <CAHzMYBRf63mcgVHiO-8o2UFffjB7Y+7FiOdnWRRb7RzfOBhi5Q@mail.gmail.com>
 <0bfa0a87bafcdc2256b3e917113edc8b5c26a623.camel@scientia.org>
In-Reply-To: <0bfa0a87bafcdc2256b3e917113edc8b5c26a623.camel@scientia.org>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Tue, 7 Dec 2021 16:11:23 +0000
Message-ID: <CAHzMYBTq7t7XjhvPN2i2Y+FtDaVKTcE_mzG=sfiDRaMz=hD4EQ@mail.gmail.com>
Subject: Re: ENOSPC while df shows 826.93GiB free
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 7, 2021 at 3:22 PM Christoph Anton Mitterer
<calestyo@scientia.org> wrote:
>
> Hey Jorge.
>
> I've looked at your old mail thread... and the first case you've
> showed:
> btrfs fi usage /mnt/disk4

Hi,

Thanks for the reply, that one was fine, it was the "good" example,
the next one was the problem, /mnt/disk3, but like mentioned I figured
out it's the metadata exhaustion issue.

Regards,
Jorge Bastos
