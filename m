Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B150E1E2239
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 May 2020 14:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEZMse (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 May 2020 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgEZMse (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 May 2020 08:48:34 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACEBC03E96D
        for <linux-btrfs@vger.kernel.org>; Tue, 26 May 2020 05:48:33 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id o5so21750752iow.8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 May 2020 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=58ee3MtHg1EWWgwHj/N2sVhSpUFRNt4/r4iB0jWAe/w=;
        b=HleX+Zc5CT0Cn9VMRoqdx/JgZix4n6U0oQ9Tn2GKMp5BB2JdSCIlY6YyHoZhPSNfyu
         ocCESD6jm11nkvRoo5B1wm0o+vAgLrRZRjIr5eQrSgKj6R2pq0GdtDcnn5JOcf05XrSk
         1Fc1epzGydRHIhxUYEAhm1OKV741TkRaEEy4MHZFV2oLb2tClYCfYVJvFGdd7N0Gsm9c
         Q1SDCiT7pBxl1/AVw7sRlmr5allnWB6VTcMV8NkENOb4mZ1Ltr6zQqknKtDfpqH9OERR
         iXDGhRu6sZxzxzENtyu4v3q51JHZt/h6u4skvuYeivsk4PHgMkiunTUiD67PUSNeXb0E
         EBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=58ee3MtHg1EWWgwHj/N2sVhSpUFRNt4/r4iB0jWAe/w=;
        b=Lkig2bdpBc7TrIT7O+Ij11YSYje/f0X+Cx5cKnc6juz7BgdLNfdHJL6bqammRRY0ZM
         B+2fwa1kKHtE8xi+PPxwjX1//I3KQ+Q93224Nwiz7z2zkt2n39iP796JGlh7afjVPhVL
         ufD0NFNgx/s2gtHJn1lreiYu825WNkF60i7NXDTnsoMTzC5aAf+sL1vyJ67gEO/WLzdS
         XVXkeMIgnCgBn5bM0F6EqT9ZoXGnAEv00YOyGFZB15h4i20DKqL3e3DnTbKhbmtQf1iT
         /dh547EKNWMcMssl/cJ4/Z9oISa4No+r88HuTzLsJz1ikZjsx6rTTZ0Kc0VpbemvuyTg
         f6jg==
X-Gm-Message-State: AOAM533ROV3A+7jFXh1aPpMofnUZGO4lD16N6rQbaAIYTCLRfv+ZdJJd
        fhoPog5uqWWVhtzio3tvPbWf2HC9Gc2fQp7LjXuziAfEuvM=
X-Google-Smtp-Source: ABdhPJyy8iKhbpbWoOqSsv9vEmjOKjmamYT+fNkumYnFMZHz2at9NAY7ayE4OuWAF1BfjLL4v5ePqh8j8Mrsl6HwwLs=
X-Received: by 2002:a6b:1487:: with SMTP id 129mr4519205iou.197.1590497313047;
 Tue, 26 May 2020 05:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAGAeKut52ymR5WVDTxJgQ=-fZzJ+pU8oVF89p4mBO-eaoAHiKw@mail.gmail.com>
In-Reply-To: <CAGAeKut52ymR5WVDTxJgQ=-fZzJ+pU8oVF89p4mBO-eaoAHiKw@mail.gmail.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 26 May 2020 08:47:57 -0400
Message-ID: <CAEg-Je_KWY5BpG0LKD4yDCVC7CdYbmxfCxxNy1pf5ACfZSnMRQ@mail.gmail.com>
Subject: Re: Planning out new fs. Am I missing anything?
To:     Justin Engwer <justin@mautobu.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 24, 2020 at 9:35 PM Justin Engwer <justin@mautobu.com> wrote:
>
> Hi, I'm the guy who lost all his VMs due to a massive configuration overs=
ight.
>
> I'm looking to implement the remaining 4 x 3tb drives into a new fs
> and just want someone to look over things. I'm intending to use them
> for backup storage (veeam).
>
> Centos 7 Kernel 5.5.2-1.el7.elrepo.x86_64
> btrfs-progs v4.9.1
>
> mkfs.btrfs -m raid1c4 -d raid1 /dev/disk/by-id/ata-ST3000*-part1
> echo "UUID=3Dwhatever /mnt/btrfs/ btrfs defaults,space_cache=3Dv2 0 2" >>=
 /etc/fstab
> mount /mnt/btrfs
>
> RAID1 over 4 disks and RAID1C4 metadata. Mounting with space_cache=3Dv2.
> Any other mount switches or btrfs creation switches I should be aware
> of? Should I consider RAID5/6 instead? 6tb should be sufficient, so
> it's not like I'd get anything out of RAID5, but RAID6 I suppose could
> provide a little more safety in the case of multiple drive failures at
> once.
>

In general, this looks fine, but I'd suggest that you switch to CentOS 8.

There's a COPR for btrfs-progs for EL8 that's keeps in sync with
Fedora: https://copr.fedorainfracloud.org/coprs/ngompa/btrfs-progs-el8/

For CentOS 8, you should continue to plan to use ELRepo.org kernels. :)


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
