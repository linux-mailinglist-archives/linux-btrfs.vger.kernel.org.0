Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679EE34C6D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 10:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhC2IKf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 04:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhC2IJg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 04:09:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD3FC061756
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021 01:09:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k128so6110144wmk.4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021 01:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VOwIXHSniF1RZyfvHPf+572FzKqKlryYSYBMcwaVF9Q=;
        b=mzoiNVnu6SgNGIoB3JUy3QYVKxLomXpQdFlHLeoep4BT/roO7Ifw26kL96Gw2z/+wp
         cExAmb4tI7K2QBijLKNBIQOCavQ6kGplVVkymsxVgnvlORN674nFN5VJyzVQ1b8dOK79
         5S4imQCVlTWiqfpZTk9CMnOwv2zcbXjaa2CxcYc9hiXZjFMZrnMYNh1bxG+CNIYdXdUu
         xUTjVDgnbbuvx/+kLJeJz7sn+Yx96vnWZgZOP/a3R9MvrfPhaTJxNuNdENX90+fkj9sN
         gOArMamOsav4Qje5qlIvS+VQhkT6Pzrk6ZhL3VsqaCP0Dh/sxnLpYAnNcA1F/Bst6drs
         ouyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VOwIXHSniF1RZyfvHPf+572FzKqKlryYSYBMcwaVF9Q=;
        b=Px3LGaYz8/Hw4AaWyX+CfVK2H82JdpERC4z7kV70qDjI9J2tafNCA/+EoNN1MMmGKl
         FnU/vDNmadIl+wtjHwZApHSpL1M4UNr76iqLBLBkg4KTiQj4keFO0Xc1DXVee4pSsw21
         PCuP1QaK27uiQ9wS3PrzQtsNFXDdXjNC2HHsQEWx6o40owTdDKogIDN8BeXMsb0FYatW
         RrvbdzNWzwcbpPMk9JK1/W+7Ktxwu7KqUW7f3K7pMzjW2wKF+JX4ev0e7ppxRhmLVlrI
         D+7+NG6VFffXa0yKNOY95Gd1Ca/KvvWjEKioGcvYd3f5Sn4BmxDS3wBqU5mxKZD9Ge8u
         ALsw==
X-Gm-Message-State: AOAM530TT8kimrcWPznHxQAiaumgBv5kZ6Txdksx8EnJOJjBrQ33GmUm
        ufxpeNMiy5esVf+5JAzKXEx6icvl7F2PZYdwDn4wmg==
X-Google-Smtp-Source: ABdhPJyNmHvu3IlE7gU6HtQEVbz81kR2kgPrsadbiOAYkJwb3wcMjXFFt1YvFIk7R5nJ5frH1H0Gql+4cIhGTAZSw8M=
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr23615854wmq.11.1617005373041;
 Mon, 29 Mar 2021 01:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-ed62f670-6e98-4395-85c0-2a7ea4415ee4-1616946036541@3c-app-webde-bs48>
 <CAJCQCtQZOywtL+sz1XBC54ew=JJaLsx=UkgmeZi3q-ob39vgjw@mail.gmail.com> <trinity-10b6732b-bd13-45e0-b795-66e3c9a869c4-1617003257785@3c-app-webde-bap09>
In-Reply-To: <trinity-10b6732b-bd13-45e0-b795-66e3c9a869c4-1617003257785@3c-app-webde-bap09>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 29 Mar 2021 02:09:16 -0600
Message-ID: <CAJCQCtSp1cmA6iVmRfRXrxzo7pUA8eSUGwzuifbZkS=p0deO0Q@mail.gmail.com>
Subject: Re: Re: Help needed with filesystem errors: parent transid verify failed
To:     B A <chris.std@web.de>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 29, 2021 at 1:34 AM B A <chris.std@web.de> wrote:
>
> This is a very old BTRFS filesystem created with Fedora *23* i.e. a linux=
 kernel and btrfs-progs around version 4.2. It was probably created 2015-10=
-31 with Fedora 23 beta and kernel 4.2.4 or 4.2.5.
>
> I ran `btrfs scrub` about a month ago without issues. I ran `btrfs check`=
 maybe a year ago without issues. I also run `btrfs filesystem balance` fro=
m time to time (~once a year). None of these have shown the issue before. D=
oes that mean that the issue has not been present for a long time (>1 year)=
?

Maybe. The generation on these two leaves look recent. But kernels
since ~5.3 have a write time tree checker designed to catch metadata
errors before they are written.

What do you get for:

btrfs insp dump-s -f /dev/dm-0

Hopefully Qu or Josef will have an idea.

--
Chris Murphy
