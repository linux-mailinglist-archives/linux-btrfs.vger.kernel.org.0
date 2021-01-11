Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545CB2F1232
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 13:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbhAKMQe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 07:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbhAKMQb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 07:16:31 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD5AC061795;
        Mon, 11 Jan 2021 04:15:50 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id e15so1117329qte.9;
        Mon, 11 Jan 2021 04:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=IsF5dCerd4QVTKKX8OpS9mFHO2oe9mdyNl5ZiwNxlOo=;
        b=bj6MWYx1aigP6bu7V8Zoix2RcDJ3G+StSNhrWKDLV8Sd1ybTbIi99UzLhErqBPp23z
         U8d32IUok6KscrVZ124udmb6Pw0QZVvhHjpKPWOaXQBc9DaLSEz5CvTKspFoUsFDtE3Y
         K6dBVFB2GQ/jqDtmHHwnzZUG7NYHhtKR+SQ6wrqVBKOMScubPOZYi+4BiYOjSRi87W0c
         zCXjtsb1AmYMZaIX9H64PcgUjYLJpk9ynLl7pG32wlODzLxGPOuVJ+tPog/69qf18Hls
         qUeRhYJJ38KZaQ4k5tDWiNo2o9oAq26xmA/zxrbj+ElvUFSw+lzgvoFwZTQZ1h3GkMNK
         tRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=IsF5dCerd4QVTKKX8OpS9mFHO2oe9mdyNl5ZiwNxlOo=;
        b=bwWjzd85God8QBJD2dJq3zvBFdffxsAUnZFFS9nF/0Jqudcpos1Eu3C69uiCY2ULmo
         h0l8V4SaTDnXDPPlU/ZgrI/A14g37uplDAnf30ePcMjdjq3UOMbe2/dQsi4Nf2Ip0A4+
         tXzBTX0OmpmmE/UCcXqKdaMUYKOLrhibaqD8hg5mDvCAs24WFTdkLl+g5l5NyEkYjrtr
         oRk9fLzB61DpVCb6QRcFc1OM7F9i4mGjGZYoMPL3uUWyHrHw8xTT+QME+5aFSEbh/h3a
         Hv4OgijsTRmbaSvjY/cIAdaWkDKP5G3BBBnmoNFJw9OZn7W+bq/l1uBq/PXf3LPcws6w
         Z0yg==
X-Gm-Message-State: AOAM533zwOG66a/eciuLu42w/IKvvqHwojscexYO6bFEq9IMt2xcY89W
        yFr9n+O0OeZL6J+2jJxe/WzBpu3ffVaEq9RCM5M=
X-Google-Smtp-Source: ABdhPJynCpOZKGejF+uFRZtWZmw8lxdKl5nGvKfHtDADqsltWP78tSgb++8S7q2U3x4A0DM7+6T9DoALCTYaBh1emxA=
X-Received: by 2002:ac8:4cda:: with SMTP id l26mr7649532qtv.213.1610367348507;
 Mon, 11 Jan 2021 04:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20201111113152.136729-1-wqu@suse.com> <CAL3q7H5W6U4jYGBszQF59RLi-aehO9vBTNU_HMTi8hRfK7gjGg@mail.gmail.com>
 <d5cabe8e-37cb-42b7-9bd4-ba7ddca68b20@gmx.com> <20201113151946.GY6756@twin.jikos.cz>
 <705e1226-2aaf-0d5f-45ed-03b25457e680@gmx.com>
In-Reply-To: <705e1226-2aaf-0d5f-45ed-03b25457e680@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 11 Jan 2021 12:15:37 +0000
Message-ID: <CAL3q7H7_-p1hKvJ9twWq3dd5Qj3QS4ujUaYwsy+H_j6u2uWThw@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: check qgroup doesn't crash when beyond limit
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 14, 2020 at 12:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/11/13 =E4=B8=8B=E5=8D=8811:19, David Sterba wrote:
> > On Thu, Nov 12, 2020 at 07:50:22AM +0800, Qu Wenruo wrote:
> >>>> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> >>>> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> >>>> +
> >>>> +# Set the limit to just 512MiB, which is way below the existing usa=
ge
> >>>> +$BTRFS_UTIL_PROG qgroup limit  512M $SCRATCH_MNT $SCRATCH_MNT
> >>>
> >>> $SCRATCH_MNT twice by mistake, though the command still works and the
> >>> test still reproduces the issue.
> >>
> >> Nope, that's the expected behavior.
> >>
> >> Btrfs qgroup limit <size> <path>|<qgroupid> <path>
> >>
> >> The first path is to determine qgroupid, while the last path is to
> >> determine the fs.
> >>
> >> In this particular case, since we're limit the 0/5 qgroup, it's also t=
he
> >> as the mount point, thus we specific it twice.
> >
> > So why didn't you specify 0/5 so it's clear?
> >
> Oh no, my brain just shorted, and forgot that it's 0/5 fixed for fs tree.
>
> 0/5 is indeed much better.

Any reason this wasn't merged? What happened?

Thanks.

>
> Thanks,
> Qu
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
