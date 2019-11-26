Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9304610A744
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 00:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfKZXyB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 18:54:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39902 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfKZXyB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 18:54:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so21443332wrt.6
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2019 15:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K5GWw20iwlnpAGuNeVHUa0tJBYEMAG3r8gn0EQ74Gr0=;
        b=Mf62zW+8FjPwMT0USJrXrjKDWsdmq47CvBcRPEGr1iKlN8Of5z1TAxFGXI2wSr1oop
         LgBLwtjmByXLucwWfbHE50xJocuirWs5nfMccPCB8AR3ze4oYvQApEsu2XbhXKbqKWd1
         6Ir7FJqoADRZ43nU011WBRAOZo+1tLlXicJSLofM6+dU6+ckx95vFlxse6lJzzTJ33d+
         ZbSkC/vUN1pozSW6UWfmpV46122ctELaBUiuQTwF3FhrQSKKdN2AxentnhIrOKJv37Aq
         txlXr5eHn1l7XU0wW9QUvfBQmhq28luTyKg7Y5ChFYuXagcBEKIVjs+3lB+B4pMVLfPI
         6mVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K5GWw20iwlnpAGuNeVHUa0tJBYEMAG3r8gn0EQ74Gr0=;
        b=NIIe/Ti6KATO0qEbLKL574Pic/lzGaoLJbnxMjQwJf58Wrko04u1JgfilRb7UW93Vc
         Jn0PgLwQfm8vXp6glWyZVAtI/IgDRd+U8VM11B3ytnSgNWOCKL3vSdx0RXpaTfmkBqAQ
         Fm36ZautzjiIf2gQ4xyrNSu9cnw9fE2j/keB0LRSvRPJFzOx66MPY6I4zCqbK5tw3pKM
         C7hWhwR8hEI0q2yCx36JZy9FW0aC50F5c0tFC0fCwK2Qh/+n641wi+XEwvJ6M7nlkSjM
         He21MEwtNMpCPB9IXi7p/v+tGBi8RfDlzn8z2Y3KLNs1ufaeyXRMjcELCLhaYe9OKVbV
         e7Jg==
X-Gm-Message-State: APjAAAXfmXP2OmGBVu55tu6oRkf7G3HG2LAQTa7oNniXevyQuZSgpZs1
        wlyKML8aREWL0rrEeu+2Eao4/sOdNtMAjmaDRiZvGQ==
X-Google-Smtp-Source: APXvYqxMWkVvABwomNxe3l3zab/Da3k/aqTXFEBNNEKqDcQBtIXan6zo/aomxeUwp8Q0quCaURRlIqDHMpZqnAlxHtQ=
X-Received: by 2002:adf:da52:: with SMTP id r18mr39665229wrl.167.1574812438630;
 Tue, 26 Nov 2019 15:53:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it>
In-Reply-To: <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 26 Nov 2019 16:53:42 -0700
Message-ID: <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 26, 2019 at 2:11 PM Goffredo Baroncelli <kreijack@libero.it> wr=
ote:
>
> On 26/11/2019 05.05, Chris Murphy wrote:
> > grub2-efi-x64-2.02-100.fc31.x86_64
> > kernel-5.3.13-300.fc31.x86_64
> >
> > I've seen this before, so it isn't a regression in either of the above
> > versions. But I'm also not certain when the regression occurred,
> > because the last time I tested Btrfs multiple devices (specifically
> > data single profile), was years ago and I didn't run into this.
>
>  From the video, it seems that GRUB complaints about a "failure reading".=
 However GRUB is capable to perform the boot and because the profiles are "=
single (no redundancy), it seems a "false positive" error.
>
> When I added the RADID5/6 support to grub, I remember errors like what yo=
u showed. However it happened 1 year ago, so my remember may be wrong.
> I noticed that GRUB test a lot of disks (hd0 ... hd3) . Could you be so k=
indly to share the disks layout ? Most error is something like "failure rea=
ding sector 0xXX". However I can't read the XX number: could you be so kind=
ly to tell us which number is "XX" ? It seems 0x80... but my eyes are bad a=
nd your video is even worse :-)

It was a dark room and shaky cam was seeking for focus :-D It's 0x80.

The storage is one CD-ROM drive and one SSD drive. That's it. So I
don't know why there's hd2 and hd3, it seems like GRUB is confused
about how many drives there are, but that pre-dates this problem.


> I think that the errors is due to the "rescan" logic (see grub commit [1]=
). Could you try a more recent grub (2.04 instead of 2.02) ?

Yes Fedora Rawhide has 2.04 in it, so I'll give that a shot next time
I rebuild this particular laptop, which should be relatively soon; or
even maybe I can reproduce this problem in a VM with two virtio
devices.


--=20
Chris Murphy
