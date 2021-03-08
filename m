Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD383309D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 09:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCHI5N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 03:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCHI5C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Mar 2021 03:57:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8506FC06174A
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Mar 2021 00:57:01 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so3286322wmj.1
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Mar 2021 00:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmQihI3pk2ry5UxwKx/liOd4sWik5Dbq8q/qAvdjq3s=;
        b=kSr3Gyo9NkmsR5I1N4s9Gb2rlzLrmtpzrFW3/8yy1t/57pn13aPDapBQfq1g8R8ZjD
         DZr4S+sujV2w+4uJmEUPp7akcp8tDNVzUn0UgNabkgEApV9gFWpfqrfsq6yiemPmowMy
         oZJxoN1CpLav1RHSQPuWlwHReR2HGRGHu/EtxladD996mUn16a5+ZkvBnIYcx5pUy7H4
         buEtwgDuqTy/OzVLNXTxmL0B9TvfEOiJfmT/No5MvAf25/+HIoVPH6fe0aiM3o6EGNSZ
         Ze5OhM5afMXplNfpsWqpex8fWS1QxgM70+/dau1iZMjRprDp90WIqLIsaHAuMIbOKUWg
         MVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmQihI3pk2ry5UxwKx/liOd4sWik5Dbq8q/qAvdjq3s=;
        b=J5Lh8P19vYCa9PpIywKPWufaa5MuXlp3Pbu+VTd6M0AEThtdZEoQ8s7YM2mjxdoiYO
         Kb4xbewR7Rbh0yawzZJP9+Ic6MpP0VxLIyzIMGulCwSBYbvoVSbCloIOBy9lw9r8sxYF
         aaYODIlYQMa9gkjiimpW7119VmMyyo08U6Y0GRHre3FZwq/1heipiWdiSzN/XsGBsnk6
         6akBWRoGjTarh7QCcVB7+ZU4De30QtJw6W+Wg11dH85RhnE2k3YuleGuQZcsiQJvH6CC
         +Gmm2ifv4goDxDBP7UG5DwfYqseQ3hkF874PX13xUvae4OBwoVviy6bO7WxEp3gEqNxZ
         NfMA==
X-Gm-Message-State: AOAM5313oJEWJio8AvezBMVuKF6iosNTAKhN8I6Dcde2zHIpWVvtQRxg
        vYnJh7rjxPOX913QurEmPuIkM1jO/s7KDgzgY1TYlQ7k
X-Google-Smtp-Source: ABdhPJw+Pnt5RcRPz3blKlYxY19901/wQB6itOCuZ/cKLRE2OCcN1m/XrTTfZ48ojoQ8xrJdkVt2wP8RnAvHZOwUNXg=
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr21083913wmk.101.1615193820297;
 Mon, 08 Mar 2021 00:57:00 -0800 (PST)
MIME-Version: 1.0
References: <CABBhR_6Y=H6Eujw51xkt6_fjAQFjdcp5trVgjtbrNf9iMDxZ0g@mail.gmail.com>
 <PH0PR04MB74168E7E65BDF004A6C06BB39B939@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB74168E7E65BDF004A6C06BB39B939@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   chil L1n <devchill1n@gmail.com>
Date:   Mon, 8 Mar 2021 09:56:49 +0100
Message-ID: <CABBhR_6mO2e2Bu2TLGTCjY-xG3+Yu34visp9+uqdvKUvpVhG-g@mail.gmail.com>
Subject: Re: btrfs error: write time tree block corruption detected
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Johannes,

Thanks for the advice. I'm running memtester now. This will take some
time as the machine has 32GB RAM.
Regarding your explanation, I count two bit position differences, not
1. Can you explain your reasoning?

Thanks,

chill


On Mon, Mar 8, 2021 at 9:41 AM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 06/03/2021 10:11, chil L1n wrote:
> > [2555511.868642] BTRFS critical (device sda4): corrupt leaf: root=258
> > block=250975895552 slot=78, bad key order, prev (256703 108 3276800)
> > current (256703 108 1310720)
> > [2555511.868650] BTRFS error (device sda4): block=250975895552 write
> > time tree block corruption detected
>
> This /might/ be a memory bitflip:
>
> 3276800 = 0b1100100000000000000000
> 1310720 = 0b101000000000000000000
>
> I guess the highest bit did flip so it should have been:
> 3407872 = 0b1101000000000000000000
>
> (3407872 - 3276800) / 4096.0
> 32.0
>
> Can you run a memtest on the machine to check if the RAM is ok?
>
> Byte,
>         Johannes
