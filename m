Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F1221602D
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 22:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGFUTa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 16:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGFUT3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 16:19:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60823C061755
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 13:19:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s16so17919011lfp.12
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jul 2020 13:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ginkel.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plnKDv3/6fIn9BxWDFvUSeUed+7kCGTaEmIwLvNupoE=;
        b=HiRSQzOv/HIXHGRlP+SdANFAMdkLbwgXwIKzjAUsBAczbdUEXZ5lGa3IjOCqu5vUOc
         MQZtPIlhawxLO5VZA13cDaAqigbDz/qmyPpt+mhtTFA2l+skIb/mMRC16jpKhMCKn08Z
         NToik2+sunsilVgOKwv5a34n9YEdyqquHhE9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plnKDv3/6fIn9BxWDFvUSeUed+7kCGTaEmIwLvNupoE=;
        b=LpufTpHbnsan2NpDWyjDcVwdR+rvVqnpJc7BWR11PjppJ2hlGZZkifSVUx568AhabS
         6MkRSjwQlxy8HHxkhldk7dyD5VReAwRQT8R/QRgW0gXwi+HRE4/QahQDObiVf1SsB1ic
         RaplGMwNw5f7NLRcj0lkyQm7JY+JldMgwy+5qjarKdRqyOnVNjvdpUJVRepbKIM55sul
         OF40gwQTyE2Jf8edXI7XcPqfz8HyILEV/kxXOyUVdaJWIAlUOmb4FCngrOu8CSqP9oIm
         fwjxhKaHIAOMPvkWsBPX45fvYMipmPPilOusIuepO4U/R9b8T98Cz9Vi9y0TLBTV7mY+
         IF3g==
X-Gm-Message-State: AOAM533dit2gWAYxQypa72ZEenjVDnrcu3MmNP62V+pwvafzv4OniL1V
        RyGIHSwFMVneXJ1q/avhu6GW154gJseVDsKbqPsnwg==
X-Google-Smtp-Source: ABdhPJysd/JzqBZweApXYXiCWZrkou9ACTw2NH1DTMg7zletUfvf86+2Go4NMAJYleheQMouinwQZ1IqC2CRGup+RF4=
X-Received: by 2002:ac2:4557:: with SMTP id j23mr31896930lfm.124.1594066767760;
 Mon, 06 Jul 2020 13:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <CANvSZQ_5p4JD4v79gFkSRBBvehCDh_Q5bBKeyNi912tr0biNLg@mail.gmail.com>
 <90c7edc7-9b1d-294f-5996-9353698cedbe@gmx.com> <CANvSZQ_HDZ=54MW+dSAP1A_zUiaGR_PLkV7anQj5K+qNds0QsQ@mail.gmail.com>
 <2483ed80-90ae-765d-e3d3-15042503841c@gmx.com> <CANvSZQ_NCb_RZyd0Z5v1W8ggrDuBRs4Gw1Q_wT62DC1e+8fjTA@mail.gmail.com>
In-Reply-To: <CANvSZQ_NCb_RZyd0Z5v1W8ggrDuBRs4Gw1Q_wT62DC1e+8fjTA@mail.gmail.com>
From:   Thilo-Alexander Ginkel <thilo@ginkel.com>
Date:   Mon, 6 Jul 2020 22:19:11 +0200
Message-ID: <CANvSZQ8WFEQbkhuXZ7E+EYOZn-dZA=q1qoy74vMMFiUYpRX5+w@mail.gmail.com>
Subject: Re: Growing number of "invalid tree nritems" errors
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 5, 2020 at 3:24 PM Thilo-Alexander Ginkel <thilo@ginkel.com> wrote:
> On Sun, Jul 5, 2020 at 2:10 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > So if it's possible, try upstream kernel can also be an alternative to
> > test if it's really something wrong.
>
> I took Patrik Lundquist's advice and upgraded to the latest HWE
> kernel, which is based on 5.3.0. I'll follow your suggestions if the
> problem manifests again.

Good news, the problem is gone after upgrading to 5.3.0 (the most
recent Ubuntu 18.04 HWE kernel).

Thanks for your support!

Regards,
Thilo
