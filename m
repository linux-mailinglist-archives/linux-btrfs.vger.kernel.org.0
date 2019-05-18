Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A066224AA
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 21:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfERT2m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 May 2019 15:28:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34953 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbfERT2m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 15:28:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id c17so7605388lfi.2
        for <linux-btrfs@vger.kernel.org>; Sat, 18 May 2019 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6UNUAxGOptlRxrNdqWrBGU9sjShdpfb9QWXI0rF6cFc=;
        b=Q6mCIj09Zs6WHQYDxjiSqDeFG1nnGnWhx0mp/4eP04AcNkOCXL53fibXEz0AG1FNBX
         rRgLy/lagrf8jclIUi+DUxdX/FHCGDUq9J2qaK0M3Vc3a6uOmnJSFuNSWdOtQBzivOOW
         FkCyyGUX/EDno+NsLnNYKApnvyHa5gj2VeRvvpf8AiU7dOVCEY7atYSs8iML7cGWKTqm
         fiM9jG2hOi0GtdUnGltn8h/0CYV/DZBzbadxTdmFVMUIG81L3Dwq6eoQ44RWi4ZgXVtx
         xNRH1F6goh9+rV9wj1EKaywt+9cX/ZJ/qFUQbyaa1xEf6Gc/JDcDQsQyHRG3LQO8ynSl
         ZY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6UNUAxGOptlRxrNdqWrBGU9sjShdpfb9QWXI0rF6cFc=;
        b=DTCzvC3sVSd1Q8ejSiTUDtATqVfDCzjkDfHJFwLMxwgXzuhO3zGMzVPpMJtvlG06Pe
         FtyxubyyxOIhIfF7uKIDYU4DMD5GRH+CfCKgMIn5VhDTF6Sf6csBnu4RYKyBH33Au39L
         S7DcwE57W98cq65Qp7+rv1dc7i2+RdHSGF8rMuzTFrU4NpOY+Pdf+Dp/UsVuaSqxeaw9
         MmJ/MIXj9iNHj4JuQw6bXQGdwuY2ghm9FutBQnDbydDkhhEHslQyGD/TKZBIiALY4oeS
         7RTf5xSjNU4Y1Zdr7JiW9gQqQwCWbGvtgxizZX8Q9TBZC2zzdRF4ty9gPchu8BZRoqBP
         YSrA==
X-Gm-Message-State: APjAAAVDeEAm3y1boU6PaicP9KdTZkH4az/pJsHtFRZYRKCuEKAzZFBC
        mO8LTBYfTwH9zb2Pm6USxOa4IqmUXnAdNFHvxmp9yQ==
X-Google-Smtp-Source: APXvYqzIBh90qYZ2qq37xSiZ90sVTZloxp/qc2+ra6A84jeJU37f5wXVd2Vgo1TFhO+NTRN4pnl5TT0O3XHc0jd2r/k=
X-Received: by 2002:ac2:5606:: with SMTP id v6mr29009053lfd.129.1558207720448;
 Sat, 18 May 2019 12:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAKS=YrP=z2+rP5AtFKkf7epi+Dr2Arfsaq3pZ9cR3iKif3gV5g@mail.gmail.com>
 <CAJCQCtTmZY-UHeNYp=waTV8TWiAKXr8bJq13DQ7KQg=syvQ=tg@mail.gmail.com>
 <CAKS=YrMB6SNbCnJsU=rD5gC6cR5yEnSzPDax5eP-VQ-UpzHvAg@mail.gmail.com>
 <CAJCQCtQhrh8VBKe11gQUt5BSuWCsDQUdt_Q4a4opnAYE5XoEVQ@mail.gmail.com> <2571b502-737b-05b5-633b-cf198c0e6764@pobox.com>
In-Reply-To: <2571b502-737b-05b5-633b-cf198c0e6764@pobox.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 18 May 2019 13:28:28 -0600
Message-ID: <CAJCQCtSDBGwCJrgLkEON-0miT2KxzHDo5+SFg=V1sUe0djkCgA@mail.gmail.com>
Subject: Re: Unbootable root btrfs
To:     Robert White <rwhite@pobox.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Lee Fleming <leeflemingster@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 17, 2019 at 10:39 PM Robert White <rwhite@pobox.com> wrote:
>
> On 5/18/19 4:06 AM, Chris Murphy wrote:
> > On Fri, May 17, 2019 at 2:18 AM Lee Fleming <leeflemingster@gmail.com> =
wrote:
> >>
> >> I didn't see that particular warning. I did see a warning that it coul=
d cause damage and should be tried after trying some other things which I d=
id. The data on this drive isn't important. I just wanted to see if it coul=
d be recovered before reinstalling.
> >>
> >> There was no crash, just a reboot. I was setting up KVM and I rebooted=
 into a different kernel to see if some performance problems were kernel re=
lated. And it just didn't boot.
> >
> > OK the corrupted Btrfs volume is a guest file system?
>
> Was the reboot a reboot of the guest instance or the host? The reboot of
> the host can be indistinguishable from a crash to the guest file system
> images if shutdown is taking a long time. That megear fifteen second gap
> between SIGTERM and SIGKILL can be a real VM killer even in an orderly
> shutdown. If you don't have a qemu shutdown script in your host
> environment then every orderly shutdown is a risk to any running VM.

Yep it's a good point.


>
> The question that comes to my mind is to ask what -blockdev and/or
> -drive parameters you are using? Some of the combinations of features
> and flags can, in the name of speed, "helpfully violate" the necessary
> I/O orderings that filesystems depend on.

In particular unsafe caching. But it does make for faster writes, in
particular NTFS and Btrfs in the VM guest.


> So if the crash kills qemu before qemu has flushed and completed a
> guest-system-critical write to the host store you've suffered a
> corruption that has nothing to do with the filesystem code base.

For Btrfs, I think the worst case scenario should be you lose up to
30s of writes. The super block should still point to a valid,
completely committed set of trees that point to valid data extents.
But yeah I have no idea what the write ordering could be if say the
guest has written data>metadata>super, and then the host, not honoring
fsync (some cache policies do ignore it), maybe it ends up writing out
a new super before it writes out metadata - of course the host has no
idea what these writes are for from the guest. And before all metadata
is written by the host, the host reboots. So now you have a superblock
that's pointing to a partial metadata write and that will show up as
corruption.

What *should* still be true is Btrfs can be made to fallback to a
previous root tree by using mount option -o usebackuproot



--=20
Chris Murphy
