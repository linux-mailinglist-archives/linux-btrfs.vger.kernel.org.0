Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190A720B981
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 21:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgFZTxL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 15:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFZTxL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 15:53:11 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E48C03E979
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 12:53:11 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j10so8358297qtq.11
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=y8TIHX2pmRtL2gNYYak7tGLgvSpNo1smBAGTdaf+hXc=;
        b=iW/TfavRN7wnw23a2190qgb2O1Sy33xymmwsSuipN8xJC4Mf86oG9h+vMLQsdBvdgN
         CCDFM1AuP/3gCMKjP7DTuOhcH4UtAe41S04dtVwu6KJiPInrIC61rh4QUJlSeS0OJeIb
         km/Cj61iKC7VEzUio9nc41qFZpOm0JCZKhk5dQJrFTPfCYmcpijc3ZmpZ8WdhIosmgM7
         te+h2nuzYW9CqlF6Eatn8bV840cSD1Rv+paJ58eBcnV7dNQVgF/W/sYzEU/othlNKct0
         JAO0c9sxJNazWn7Mk7kVhwjOxfRvoT59aJ16uVW/lsiE5vXc7Hdgw30t+qrJZUA7Sqjz
         7X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=y8TIHX2pmRtL2gNYYak7tGLgvSpNo1smBAGTdaf+hXc=;
        b=bmtER8ybl7vbhpqYGEMZpp+uWmWIbaVCS8bsvgsknjXncnptnJZNFymey6kR9IIkby
         x1a2XMDvULcy63ynAUdSKp7x22IA9/PbzOhFR6UUnX9QXIcarZnpbnS2au7cGuldr3eA
         lt9wn4dGl9yzHAoNpOQFBO4fFkKPTBwbbr2bDHaL1aQKJhXfccuq6b+DjPeKwbP3kcoF
         JD1vaj6Gxy97fHSEQT3V8TfRumhThGf2RanOFcPLpXr1nNTM/JSIyc68BNM95ZfBpiw7
         CFerXaVc8Hbh6h2XsRpWYZ8DtFmd6KeiDSVZwsspUKMSEnZS53Z6/ADRojJiV7DKzSnU
         WMTA==
X-Gm-Message-State: AOAM531pw65zcEH0gjqcaaFscDYclJ4xqIJWn7nBrv13UvVpzhyekGNu
        2eRNj75rY4CCNc9HZBDbvf18a+qmbU9eZALRPsY=
X-Google-Smtp-Source: ABdhPJz56pJadgKC9Fn0PmRal5xGvWa3aEw8EOisD8Eek5Uac83/k1mGc1tuDn069sSu7l2Y7WWGGaSWGOo0cmRwsm0=
X-Received: by 2002:aed:3686:: with SMTP id f6mr4497287qtb.328.1593201190167;
 Fri, 26 Jun 2020 12:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200621054240.GA25387@tik.uni-stuttgart.de> <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de> <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
 <20200622000611.GB16871@tik.uni-stuttgart.de> <CAJCQCtQ8GFAdg2HJY_HqDgW8WAp5L1GoLbKqUN2mZ7s_kS-8XA@mail.gmail.com>
 <20200622140234.GA4512@tik.uni-stuttgart.de> <20200622142319.GG27795@twin.jikos.cz>
 <2E6403C5-072D-4E71-8501-6D90FB539C15@fb.com> <CAAKzf7=gQCMCECtnFwry8+LzuVCkkfeYX6VsAUcrnONtyaF18A@mail.gmail.com>
 <650BA0CA-449A-48DD-9E0D-A824B5D41904@fb.com> <CAAKzf7kMFqkrQyRzJ6WHVE95PBm2e0BX+QBua-2-rasp=BR7FQ@mail.gmail.com>
 <00D64498-C734-4D08-8FBE-019B7292BE8E@fb.com>
In-Reply-To: <00D64498-C734-4D08-8FBE-019B7292BE8E@fb.com>
From:   Tim Cuthbertson <ratcheer@gmail.com>
Date:   Fri, 26 Jun 2020 14:52:59 -0500
Message-ID: <CAAKzf7ni2KEzPiOSg0fVb9ds5hhrwqaNhyLwLR488J_dHGEh_A@mail.gmail.com>
Subject: Re: weekly fstrim (still) necessary?
To:     Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was running kernel 5.7.5 on a fully updated Arch Linux desktop system.

On Fri, Jun 26, 2020 at 2:33 PM Chris Mason <clm@fb.com> wrote:
>
> On 26 Jun 2020, at 15:30, Tim Cuthbertson wrote:
>
> > Well, I am going back to using a weekly, manual fstrim. I have been
> > doing that for many months with no issues.
> >
> > I cannot be certain that discard=3Dasync caused the problem. However, I
> > had implemented that for the first time less than two days before I
> > discovered the problem. My system was still booting and seeming to run
> > fine, but then Firefox refused to start. I was looking for the problem
> > and I found csum errors in the systemd journal. Then, I ran btrfs
> > scrub, and found that there were 12,936 csum errors.
> >
> > The systemd journals should still be available, if you'd like me to
> > post them.
>
> I=E2=80=99ll try reproducing things, which kernel were you running?
>
> -chris
