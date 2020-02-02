Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F4F14FF05
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 20:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgBBT6O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Feb 2020 14:58:14 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:45072 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgBBT6O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Feb 2020 14:58:14 -0500
Received: by mail-wr1-f54.google.com with SMTP id a6so15245932wrx.12
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Feb 2020 11:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAafDDpPi2F+D3fNe3Nr/Ap6ds/cexRtWvU5B5wpwMM=;
        b=KulfiIaKvQLV2hfKrXQfeEM22/iI++4diAHTF32dEgh4W2Iq6Ugci1jujXnaFn77NA
         9FjTs57wqOjjZHHebXilrFOjwOKm47jBEMpe1tfQ9OILFjbcngRF7A97hkcsBmVsRVoj
         tnaCSRT9UXWDev7mI6GnQ696V+TSSInAYFHx7u1x3VwLOiOzd+qYqWZWFNBwNDwDt0Ca
         0L9hcbB5VSxGIS1c2dlaxEeZ9sSDyGweqQUv43Tln2fvPMqAEOgZ0nXbtlqpsEqI7n05
         yNOMZTFfUJ4ZyqGyH92yPWLEleReygC2I3wZXdYKbfaYBWfbOVYkiRLpkuKNFAP9k6fQ
         hp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAafDDpPi2F+D3fNe3Nr/Ap6ds/cexRtWvU5B5wpwMM=;
        b=ars5gua5kPzb434urfWmqJr958cR3U4gFEi29IvvjMsjl6ZIHyxgZHdxKgvcKiNPFO
         RpH7AGkX9Kb1SH+nI8KazVotguOi6T6opcZRp+b5F3wf7qQ3p03GREef8wEWYEiUHHm5
         47C22PPhWuFbuz50mad/YjkaxeRn7oPtTNw4dQctNSmbwTg2puxQjUFd3pP2eRgem85K
         ZmMdtqyhwzJuf5n9NVRUsX052aYZcmOj9zjI9lxerwSEnCUVkHWYQqmKb60OT4bs8tsh
         CUlLiWx2yf9Ix0D8A5Obbpp4vAOxUeQkGY5BQo3PmLUHA7oCrQr82DRkwh+MHEzO2J46
         e3og==
X-Gm-Message-State: APjAAAX8gsdfhr8fiX9UANYlpvccjfKd0VspqWqkYoUtVZ1R+9fi/ziP
        T90OKJb7yuBsDem+8UNY77NXTWlVAJFOovO2dO6tTA==
X-Google-Smtp-Source: APXvYqyWKrh8vzY3extaM+VA0Ftn0jiVJ+QSax3BsckwIJj9CT82yAoQ77YlVNx54YERhisrV5uN+M98FUOQtJutEwI=
X-Received: by 2002:adf:8564:: with SMTP id 91mr11689404wrh.252.1580673493010;
 Sun, 02 Feb 2020 11:58:13 -0800 (PST)
MIME-Version: 1.0
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
In-Reply-To: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 2 Feb 2020 12:57:57 -0700
Message-ID: <CAJCQCtQiwT1zeS3bShMJzKR9tezgZ-2MpQBG1+Zqk=Li2RN0RA@mail.gmail.com>
Subject: Re: My first attempt to use btrfs failed miserably
To:     Skibbi <skibbi@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Also, what are the mount options for this file system?
`mount | grep btrfs`


--
Chris Murphy
