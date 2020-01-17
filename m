Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B5E140973
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 13:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgAQMEd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 07:04:33 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:33331 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgAQMEd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 07:04:33 -0500
Received: by mail-lj1-f177.google.com with SMTP id y6so26272266lji.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 04:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0FMNs+khiVmMzAetIDMzIhyKlJE8HQh1Ss3k5Xj4ycY=;
        b=H6VmEMFJNL28cr/IXDTKagqQh8/zUrGgunz6GOTIbOzTan/IOorLxX17CV+9nEyM1R
         jImihEY14cBp4afbL7EPfKyrmcdIkWAnYOSIdK0wp0hYAMsckVk0XJXMwIsNmyjmOp7Z
         l5TiIq/QW0I9JDZv8IjqbbD01OJPLt3HFdv+6dzhRlPetI3HXJ3d5up7ANPNHz8d4I2E
         L+9ia4e1kPGI/pxlYr8pUdugH2LRUivSvK93w2bRMHVb9D73/gW/Tdie10m+tyHdAMJf
         M450by3O76FtEpbN7BvpVx25VMtVnPBINb0TKkyxHFMnkH2Xv+hdS+d1lDX4kjgJCGo2
         KjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0FMNs+khiVmMzAetIDMzIhyKlJE8HQh1Ss3k5Xj4ycY=;
        b=ejbnvO4GQY7hK7z3bzr1fwkqDjTdbRg6W29OemuWHy0+KPrx5l1c/g2+c9TvQ5X1d/
         vQ8ipjnDCqN6XYbIN2lcatmFNAQcWyzpCT9S6fDn+y7USU6n0Wi8ZFdnw1vuQRSYptIJ
         VnntklT8rvkaXzZFz4Nr9S3BT4kh5F06aIarG6Fbs2ufJ+44YbTUmWx+LF5MLkfjHpCB
         GMe7SRkbNQ/aBVjKKn87+okA2AISs7rkKG/QORqnnPZRK5QtQh90PfxXo6TgzfaX0Nqt
         gFu7ysEF4pXp1BGnZCQx4Ny8Y3Mxgj7ApWJ/zS9gTwg/hwctbQXFnQJZPS8yLD/3DJut
         38ug==
X-Gm-Message-State: APjAAAVMCeXzUFMvj8XGCIqHL8jyKfDk35WDWxfGcwdhdJe1e/uSVyZ7
        zPtj6XMtOiJzP+WdJpXHkCQ9wzxnNPxGU73wZ+Q=
X-Google-Smtp-Source: APXvYqxr09Lbz2EhOxWHzlBrge/9pMZ9BhaWnBE2wDsbp8EHvE/nlYLxlUsNfA7/t7mVVqvWHD/mh8MvEhqH45UVYXI=
X-Received: by 2002:a2e:9052:: with SMTP id n18mr3005438ljg.251.1579262671469;
 Fri, 17 Jan 2020 04:04:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+ZCqs6w2Nucbght9cax9+SQ1bHitdgDtLKPA973ES8PXh1EqQ@mail.gmail.com>
 <6ba43f60-22d1-52da-0e9a-8561b9560481@suse.com> <CA+ZCqs5=N5Hdf3NxZAmPCnA8wbcJPrcH8zM-fRbt-w8tL+TjUQ@mail.gmail.com>
 <53da4b02-6532-5bb9-391c-720947bac7f1@suse.com> <CA+ZCqs4pTKePM4NaStAs=CWYBZbA_btqip1WiU8DC6DL13Eh_Q@mail.gmail.com>
 <CA+ZCqs5hLS3ekUpU8TTJq6UP9rjPYZjBwVYcC4xJcaMXuvSudQ@mail.gmail.com>
 <237d7698-63e1-cb2b-dfbf-ddf5119bd18b@suse.com> <CA+ZCqs7u5XxyaKS=5jPTTDW9+LKdhSBip1+xRNG2VhkEtxDnfw@mail.gmail.com>
 <31c3be6d-2005-1daa-5d45-ae3812a36ecd@suse.com>
In-Reply-To: <31c3be6d-2005-1daa-5d45-ae3812a36ecd@suse.com>
From:   Peter Luladjiev <luladjiev@gmail.com>
Date:   Fri, 17 Jan 2020 14:04:20 +0200
Message-ID: <CA+ZCqs6=4=j=jUix77npV_MfB4ucTbxNUBVYmziHsWATO_EA7Q@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you very much.
Everything seems fine now.

On Fri, 17 Jan 2020 at 11:10, Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 17.01.20 =D0=B3. 10:22 =D1=87., Peter Luladjiev wrote:
> > btrfs-progs v5.4
>
> As Qu mentioned - with the rootfs unmounted you can run btrfs check
> --repair and it should repair that one broken backref.
>
> >
> > On Fri, 17 Jan 2020 at 10:14, Nikolay Borisov <nborisov@suse.com> wrote=
:
> >>
> >>
> >>
> >> On 17.01.20 =D0=B3. 9:54 =D1=87., Peter Luladjiev wrote:
> >>> Should I run with repair flag?
> >>>
> >>
> >>
> >> Which version of progs do you have ? Because it seems original mode
> >> (Default) finds the corrupted backref but lowmem doesn't ?
> >>
> >>
> >>
