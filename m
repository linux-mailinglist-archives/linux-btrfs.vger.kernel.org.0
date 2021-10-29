Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60B543FD98
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhJ2NzQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhJ2NzP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 09:55:15 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3B1C061570
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 06:52:46 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id n2so9128555qta.2
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lj4X9sIp5dx5Ycy9z1fi+/RaKClEzhPQMVfHaxujZdA=;
        b=WoqFNmdXwJQPhe/ubr+dC96HrkBVOnhHn0U2fOvI/xCZ3qMO0u4RSwrj4h4Mty5m5w
         Xa9cSXJypvGM1qTlPW2yHAwN/wmnG2FPd/q5HK4/Yx3T3HcsH9gVUco76e6GUDLbA5IE
         HeJAHdk39lZGIKnmAN2Ek8UHy15uDJnl2LIi8lcDkkIh3eAoBfoQaIAoWBdGRKlPtwsB
         uPHh78v0IKJ+SVMUxjm4dBP5y1tFqOelQAy8UBOZlNV3ackcSvGxwdGQAdWw0uVQ/bC9
         MUe7s+HIkHUx1j54/hH4IaPrGxOE3QShOIkUSAmZK9TyWjYems7pgRyUpIIuHfpMeZs0
         1gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lj4X9sIp5dx5Ycy9z1fi+/RaKClEzhPQMVfHaxujZdA=;
        b=g9eTNw91UYoTIm7ot3gAVg0xyAAgkm4gBL8hX9vtMw/XxtuJJWJyeQy9Y8BodXF5vm
         EivdgdwogxMdo1OiITNGCAcIFia2vJXkHy/DcuwhuwAPeWNYIHEXvh5+PPQSBSlllnVU
         MY8Mu2aa1fKzBl/uAtCsysZ3ups2h9fnNwkzHyH/2fsDpUEtBnqOO8qImrNI32Rlk/uC
         EBBNCE1147p5SEiGebM493IRE3aH5UAV7r4V76rTRsu9bhECPFxqFdfuyvkY4Ohusy7I
         grk6on+owY99iiAf0lxytak+gTGIIOlBolYZHS5gWHqtjdvk26F5lRgMKArWpT9cGq9n
         /5/g==
X-Gm-Message-State: AOAM533Ul0b9xcGJjBpkys3qgL72GmQti1iwQleb4ojd64UPr6Eo/dj3
        Xr7NObnZrdGCO5rQaAq7efaazJv4jmmMNm3r3mSY8hGBpVE=
X-Google-Smtp-Source: ABdhPJx3gPl01vSIuSrKNQkkZ5NBcJH443uVWLm6aPgBVIk48J07j02S8zlW6xWILJnW6ctiPsxvSL9ZULnWdUMm3O0=
X-Received: by 2002:ac8:7f8c:: with SMTP id z12mr11962652qtj.292.1635515565861;
 Fri, 29 Oct 2021 06:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQ7scWxVCuQkbtY_dTo3rPoW+J0ofADW4GYGDMb_bfcha81CA@mail.gmail.com>
 <20211029132232.GA20319@twin.jikos.cz>
In-Reply-To: <20211029132232.GA20319@twin.jikos.cz>
From:   Jingyun He <jingyun.ho@gmail.com>
Date:   Fri, 29 Oct 2021 21:52:34 +0800
Message-ID: <CAHQ7scV9i_s3gEXXki_U+RmqWLHu-DMWF_kzXFWKgOtqBQhvhA@mail.gmail.com>
Subject: Re: unable to run mkfs.btrfs for host managed sata hdd
To:     dsterba@suse.cz, Jingyun He <jingyun.ho@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
Thanks for your reply,
I run these commands under root account.

After debugging this furthermore,

The issue looks like LSI 2308 doesn't report it as a host managed device.

If I connect it to the onboard SATA port, everything is working fine.

I'm not sure if there is any method to run mkfs.btrfs forcely, as even
LSI 2308 didn't report it as a host managed device, but it can pass
most of the libzbc tests.

On Fri, Oct 29, 2021 at 9:23 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Oct 29, 2021 at 08:48:45PM +0800, Jingyun He wrote:
> > Hello, all
> > I have a LSI 2308 HBA in IT mode, and attached a sata host managed disk.
> > And run mkfs.btrfs /dev/sdb -O zoned -d single -m single -f
> > get following errors:
> > btrfs-progs v5.13.1
> > ERROR: superblock magic doesn't match
> > Resetting device zones /dev/sdb (67056 zones) ...
> > ERROR: error during mkfs: Operation not permitted
>
> Can you also reset the zones by 'blkzone reset' under the same user
> account that also runs the 'mkfs.btrfs' command?
