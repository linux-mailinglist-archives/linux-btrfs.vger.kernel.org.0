Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7942F6B38
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 20:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbhANTj1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 14:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbhANTj1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 14:39:27 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6A6C061575
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:38:47 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id b11so615180ybj.9
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sq55+11BPcOiPRvaGuagWcjEJTrAtOImbEM2PC2En/k=;
        b=FVxTLXJH4N8u9JaYQsIuZlkJSkl4+Mvz8MBoOEpNEtzppU2Yxg0AD6pgYMDDNhYdMJ
         M9z/diLX40B5vBl7dn8FMdwlf0pQ3SK5mkswVFwXeBqk7OZ45GpTQnG638Cwb5MoHn9Q
         4jGXwh/QQItNhTs6J77Sbr45p2RwsXB9xGfd59ntJbyRCTyQEi8bkwxnlwTGukVLFwU8
         XtJeZUdY017PRTu/q1cCP7ujvCGGzEEyyhJUBX4sR8gy5VPH7fI/0OTl2HrDV2uwQAPZ
         P1MyerXktkj9J+E15+4WG+/8nN6P4/YGT62hr5RmkE6uyUVdOzwBamtplA+c0sWinWCd
         PRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sq55+11BPcOiPRvaGuagWcjEJTrAtOImbEM2PC2En/k=;
        b=rz7Bok6rc4aVkPM/ArK+VV5Kfn09JHOPfOevSF7xej/upsT851XeDEJ8BjTh/NUVwL
         LN4DmL5isyaQLdLzqJuMf1Hb1F1roeJBF9S0VDlN77YW2KOHKi0MgTfmFdeaz4nlVi0/
         5uAHHcqqpsqJzArfwv+zw1t1z6hkVJ7iXxCRlP81CzdwHlb+tIHbWNWU8fxEQin7kr5m
         UnfiQ2lu0vvNz+W7+nE1FATWu1zKc1y0pg7UgJurl5YtMysYwCQQXYyi0cHcMPrGCxsi
         IOTIRqBGdnPmbBQRjq7Tb+1GQsjkVXKk0msFpYi+8mi0QwXPOAUwWQ/FHByZUaln5f04
         7xig==
X-Gm-Message-State: AOAM533bItw+hiv2hGOv8nBxjzOcoCPfVf8wJO4BCncsKuYfKsTiEHRy
        x/+sZCKtwW98rxFbOA90Lwj9uFFYbm9Ktgjnqbw=
X-Google-Smtp-Source: ABdhPJwB4XwS8aoALGRfFvfzKONx+fLu2tUjUSWGUMBLO4KMPExxV+QyXeIalMunMpoBWuVv8aC3KNwIw4aXwuHaqKE=
X-Received: by 2002:a25:ab63:: with SMTP id u90mr2727661ybi.47.1610653126276;
 Thu, 14 Jan 2021 11:38:46 -0800 (PST)
MIME-Version: 1.0
References: <b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de> <X8/pUT3B1+uluATv@relinquished.localdomain>
 <20201210112742.GC6430@twin.jikos.cz> <7f16d12b-c420-86f1-2cb5-ece52bec6a2f@denx.de>
In-Reply-To: <7f16d12b-c420-86f1-2cb5-ece52bec6a2f@denx.de>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 14 Jan 2021 14:38:10 -0500
Message-ID: <CAEg-Je93py9VSkUN98fZw5SN6yuKsa2jUMd2+KsvJ5WctRsH4w@mail.gmail.com>
Subject: Re: btrfs-progs license
To:     Stefano Babic <sbabic@denx.de>
Cc:     dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 10, 2020 at 7:18 AM Stefano Babic <sbabic@denx.de> wrote:
>
> Hi David,
>
> On 10.12.20 12:27, David Sterba wrote:
> > On Tue, Dec 08, 2020 at 01:00:01PM -0800, Omar Sandoval wrote:
> >> On Tue, Dec 08, 2020 at 10:49:10AM +0100, Stefano Babic wrote:
> >>> Hi,
> >>>
> >>> I hope I am not OT. I ask about license for btrfs-progs and related
> >>> libraries. I would like to use libbtrfsutils in a FOSS project, but t=
his
> >>> is licensed under GPLv3 (even not LGPL) and it forbids to use it in
> >>> projects where secure boot is used.
> >>
> >> libbtrfsutil is LGPLv3, where did you get the idea that it is GPLv3?
> >>
> >>> Checking code in btrfs-progs, btrfs is licensed under GPv2 (fine !) a=
nd
> >>> also libbtrfs. But I read also that libbtrfs is thought to be dropped
> >>> from the project. And checking btrfs, this is linked against
> >>> libbtrfsutils, making the whole project GPLv3 (and again, not suitabl=
e
> >>> for many industrial applications in embedded systems).
> >>>
> >>> Does anybody explain me the conflict in license and if there is a pat=
h
> >>> for a GPLv2 compliant library ?
> >>
> >> No objections from me to make it LGPLv2 instead, I suppose. Dave,
> >> thoughts?
> >
> > I've replied in https://github.com/kdave/btrfs-progs/issues/323, the
> > initial question regarding GPL v3 does not seem to be relevatnt as
> > there's no such code.
> >
>
> I read this, thanks.
>
> I was quite confused about the license for libbtrfsutil due to both
> "COPYING" and "COPYING.LESSER" in the library path. COPYING reports
> GPLv3. But headers in file set LGPLv3, sure, and btrfs.h is GPLv2.
>
>
> > I'd like to understand what's the problem with LGPLv3 before we'd
> > consider switching to LGPLv2, which I'd rather not do.
> >
>
> Please forgive me ig I am not correct because I am just a developer and
> not a lawyer.
>
> The question rised already when QT switched from LGPv2 to LGPLv3, and
> after the switch what companies should do to be license compliant. Based
> on information given by qt.io and from lawyers (I find again at least
> this link https://www.youtube.com/watch?v=3DlSYDWnsfWUk), it is possible
> to link even close source SW to libraries, but to avoid the known
> "tivoization", the manufacturer or user of a library must provide
> instruction to replace the running code. This is an issue for embedded
> devices, specially in case the device is closed with keys by the
> manufacturer to avoid attacks or replacement with malware - for example,
> medical devices. This means that such a keys to be licence compliant
> (anyone please correct me if I am wrong) must be provided, making the
> keys itself without sense. The issue does not happen with LGPv2.1, and
> this is the reason why many manufacturers are strictly checking to not
> have (L)GPLv3 code on their device.

While I'm not a lawyer, what I've been told by others is that it just
means that you need a way to reset the keys for loading custom
software. That doesn't mean giving your official keys, just a way to
reset the trust for custom keys. This is analogous to how Secure Boot
works on PCs with support for adding the user's own keys and removing
preloaded keys.

You can design systems to only interoperate on matching keys, so if a
custom firmware is loaded, it's distrusted by standard firmware, and
so on.

This approach actually makes sense for the longevity of secure devices
in the field, because they often outlast the companies that made them.
Having a way to have another party "take over" and maintain the
firmware is a good thing for the long-term stability of leveraging
technology in sensitive industries.




--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
