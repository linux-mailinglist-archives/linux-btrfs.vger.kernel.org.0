Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFEA10DE48
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2019 17:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfK3Qbc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Nov 2019 11:31:32 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:34161 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfK3Qbb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Nov 2019 11:31:31 -0500
Received: by mail-wm1-f51.google.com with SMTP id f4so2451121wmj.1
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Nov 2019 08:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TKqPmy2aPnYHWztjtEikxbF0iihDCjbvVSjdatW4m2E=;
        b=wc0SshbuqYreyCD40RNwJu0psO0hmVpPzJuqd3RQibMcm72hfg1eE4vBVZAHeTdWGA
         rYW4SyeO6WOl1qdz7c5tindtjNDU+al5HidH/0/+cu9rJWg6PRY7X9ZdYirNZo5tm4Zz
         zie0qQWdz6cIyPRaRyoCyqGq3wcpZX41LtTZxn6UKUg/pCmSXNjp1EqRBQJ0uwWPCpQi
         /1PbtxKsMpWH/bPROl6zx8ROBEuOtydsPidi2UnhJqGq4mLDI1HcFkq7B0aP/bkJTgas
         sl48aZa2gc/J3VUVALeVRhFRx5oOgyztH9KBVLPuwMU+sIYuMnbinzapuwNrzoyOcWKq
         XXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TKqPmy2aPnYHWztjtEikxbF0iihDCjbvVSjdatW4m2E=;
        b=YO0GpwfFTIWQ3TAYiVfREms25r1xE3VMwIzjk2aNSRNCbekKZXRszHk+mDOqf6Flre
         CYC0B8i2YCgzZDexB8u0tMnTYlmdILOhqjOHh/PEpOFQ4uyQcy2pgAI4BVa/ZXqP0Auq
         70vSzWX5HiPLN/ubs4q0XR5pQaCENHKfsY3VPfL7LiPkSL1dDuj36mDd4xyTSeLYLvV3
         Ug3JY4mRX2QtWu9QgSoJMyF60qw5Ue7Oj1jlZthQ5OSLoXlZ716Cc6ZuRO2mFzT8jYnZ
         dEgiGM+rbcRREZFEqcvuvE5q+uK8j3umlpX7edzir24gydd92fBEk3Ez/eIu95IWratB
         5JnA==
X-Gm-Message-State: APjAAAULjc7s9c9TzQAo32PX8gP62mCGCm7uLytLbRNW2iacSo0Fjute
        ZpyVcyYgNiwgMWHrSfbDdqpag0ROzSgWEr6+r+mdpg==
X-Google-Smtp-Source: APXvYqwgRTP2KxdpqRLQjNXWdtDuvmHsDf+0/6jOmiloKGsPZ2It7SBL9Cfb4MPf9Fjml/gbV/DcDYlGI1V1h0eSqPM=
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr19485064wmj.106.1575131489653;
 Sat, 30 Nov 2019 08:31:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it> <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <be389a15-4659-2cc8-ffe3-f2305f6f4775@gmail.com> <CAJCQCtTuu=k3FsKYmon4zP2b7c9D3zYzJwGZ3pLzFXMoJTepYA@mail.gmail.com>
 <6bc5b69e-188e-a7b2-e695-bd1bcb6a9ba3@gmail.com>
In-Reply-To: <6bc5b69e-188e-a7b2-e695-bd1bcb6a9ba3@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 30 Nov 2019 09:31:13 -0700
Message-ID: <CAJCQCtQxR4Xnikz7vVxOX-gzU6aWzu5eHeG95HOKsx40ziTGLg@mail.gmail.com>
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 30, 2019 at 12:31 AM Andrei Borzenkov <arvidjaar@gmail.com> wro=
te:
>
> 30.11.2019 00:11, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, Nov 29, 2019 at 1:50 PM Andrei Borzenkov <arvidjaar@gmail.com> =
wrote:
> >>
> >> 27.11.2019 02:53, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>
> >>> The storage is one CD-ROM drive and one SSD drive. That's it. So I
> >>> don't know why there's hd2 and hd3, it seems like GRUB is confused
> >>> about how many drives there are, but that pre-dates this problem.
> >>>
> >>
> >> grub enumerates what EFI provides. What "lsefi" in grub says?
> >
> > https://photos.app.goo.gl/pBxLJNdbzz6J9Vo56
> >
>
> These are vendor media device paths handles that are children of (some)
> disk partitions. GRUB already tries to skip such handles:
>
>
>        /* Ghosts proudly presented by Apple.  */
>        if (GRUB_EFI_DEVICE_PATH_TYPE (dp) =3D=3D GRUB_EFI_MEDIA_DEVICE_PA=
TH_TYPE
>            && GRUB_EFI_DEVICE_PATH_SUBTYPE (dp)
>            =3D=3D GRUB_EFI_VENDOR_MEDIA_DEVICE_PATH_SUBTYPE)
>          {
>            grub_efi_vendor_device_path_t *vendor =3D
> (grub_efi_vendor_device_path_t *) dp;
>            const struct grub_efi_guid apple =3D GRUB_EFI_VENDOR_APPLE_GUI=
D;
>
>            if (vendor->header.length =3D=3D sizeof (*vendor)
>                && grub_memcmp (&vendor->vendor_guid, &apple,
>                                sizeof (vendor->vendor_guid)) =3D=3D 0
>                && find_parent_device (devices, d))
>              continue;
>          }
>
> but these have different GUID. Google search comes with something
> hinting on Apple still (like
> https://www.macos86.it/topic/1136-asus-x202e-hm76-vs-n56vb-hm76/page/2/?t=
ab=3Dcomments#comment-31186).
>   Device paths look like
>
> PciRoot(0x0)\Pci(0x1F,0x2)\Sata(0x0,0xFFFF,0x0)\HD(4,GPT,A640EF60-F7E9-49=
45-81A9-B04CCE53EE97,0x176F4800,0x482FC88)\VenMedia(BE74FCF7-0B7C-49F3-9147=
-01F4042E6842,4F20CFA89785973FAAF730597BFC41BA)
>
> where vendor GUID is BE74FCF7-0B7C-49F3-9147-01F4042E6842
>
> So we have hard disk, then partition as child and then this vendor media
> as child of partition.
>
> This should certainly be reported to grub list. What system is it - is
> it Apple?

Yes. Macbook Pro 8,2 (2011). I'll report the phantom device problem to
grub-devel@

But still an open question is what's the instigator or secondary
factor because this wasn't happening before adding an unused but
already existing partition as a 2nd Btrfs device. Last time this
happened, all I did was remove the 2nd device and the problem went
away. I'm ready to try that again (remove the 2nd device) and see if
the problem goes away, but has enough information been collected about
the present state?


--=20
Chris Murphy
