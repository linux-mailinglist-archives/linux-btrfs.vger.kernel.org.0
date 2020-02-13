Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECA115B9A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 07:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgBMGho (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 01:37:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36761 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgBMGho (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 01:37:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so5244747wma.1
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 22:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tNjBrAXkxZ1QBx8OXYsmOyn3t73R3rheFL7PA9Ea1Y=;
        b=EO68McubF9fWz93mV++1Xjd4jjTYYXTI9Xn05BtkRlawucCyNzh6aw2AwTO866fWNy
         rDj+KJHRseCGeUBVPOyIgaLsnOOkd0E1pSoTM1Cng2S6aqEAufxhAcQ/JyYUH0nKMDXw
         JYmVHvRyjCKACI/47gDaNp4oc/kA+M5DX3itDvg3px6krXY97O3+t907Up48GOWxYPQc
         ENWwnG9fFpcxddrzXMfyWOzApvZ/lKFLzZLcOakim1/RVSi2B/EXw/gd4OyQ76r92bOB
         ANZTEZnEcZHucWchkCH2kT+yfAdyS/Svg+0yg8AEPpkB0wKikmvR5of1nZhwPoZyDTEd
         BhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tNjBrAXkxZ1QBx8OXYsmOyn3t73R3rheFL7PA9Ea1Y=;
        b=QJkFUWe7x0E0YepXZ9X1GnrkvMA+zTMvxk59dxL+3Ba89vLsl7wkSg7JvnvDJgdsHJ
         WyRvtcDJvozZASs9jB8tD5txynqQ0ebuJkKAJw7uy0WFaYQW8jynZQZ60qClDzl/xoFc
         L+cv3rxiIwtfsDTJzZZ7M6iCjOHjER0EPbKUUGNaqo9g17+1T9D4hOzeVqQtfb8tIe4y
         BvSk4ORnIFIUuyK2YnDTQdWArBQheytvMZdFYwNghMlnqnf2e/ogNMER2lncvAuzVzPM
         WotygSnmNzYTwcyl+9afbw9p/OWLNKpIiuKYkQrle0O/P3p5f9I1+3Vc84tHRqlxc9U1
         vsQA==
X-Gm-Message-State: APjAAAU7jVLID0h9HhCRzr7RH2SqnZXyzIUNXA8Rjas8k9aXE2//rHqZ
        gpzMYff+a8DaGLCR6NB8POEwu3Yl1vo0mYHzmUTj+g==
X-Google-Smtp-Source: APXvYqw3ySSPtr/UPOcD5hOB5QngwA32LPqFP3WWY3xP4EedXe8QcSo5OybFPxGlUvXJ8zEEf4l3uhowZ1oqxld9UcY=
X-Received: by 2002:a05:600c:217:: with SMTP id 23mr3776128wmi.124.1581575862052;
 Wed, 12 Feb 2020 22:37:42 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtS9Te9gRAGwin_Wjqv_3cJXVXthNa1g53zF4PbZW+k0Qg@mail.gmail.com>
 <20200213112110.7100baf2@natsu>
In-Reply-To: <20200213112110.7100baf2@natsu>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 12 Feb 2020 23:37:26 -0700
Message-ID: <CAJCQCtT6QwBeB79jWGoOtpT+GLLEQAdVHrYvMRZhFz4Th_xYNw@mail.gmail.com>
Subject: Re: fstrim reports different value 1 minute later
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 12, 2020 at 11:21 PM Roman Mamedov <rm@romanrm.net> wrote:
>
> On Wed, 12 Feb 2020 23:08:03 -0700
> Chris Murphy <lists@colorremedies.com> wrote:
>
> > Host: kernel 5.5.3, qemu-kvm, Btrfs, backing file is raw with +C  5.6.
> > Guest: kernel 5.6.0-rc1, / is Btrfs
> >
> > Boot and login, and immediately run these commands:
> >
> > [root@localhost ~]# df -h
> > /dev/vda4        96G  4.4G   91G   5% /
> > # fstrim -v /
> > /: 91 GiB (97633062912 bytes) trimmed
> >
> > 1 minute later
> >
> > [root@localhost ~]# fstrim -v /
> > /: 3.5 GiB (3747549184 bytes) trimmed
> > [root@localhost ~]#

Huh... these are about 10s apart.

# uname -r
5.4.18-200.fc31.x86_64
[root@localhost ~]# fstrim -v /
/: 92 GiB (98746789888 bytes) trimmed
[root@localhost ~]# fstrim -v /
/: 3.6 GiB (3808149504 bytes) trimmed
[root@localhost ~]# fstrim -v /
/: 3.7 GiB (3993657344 bytes) trimmed
[root@localhost ~]# fstrim -v /
/: 3.6 GiB (3812700160 bytes) trimmed
[root@localhost ~]# fstrim -v /
/: 3.6 GiB (3812700160 bytes) trimmed
[root@localhost ~]# fstrim -v /
/: 3.6 GiB (3812700160 bytes) trimmed
[root@localhost ~]# fstrim -v /
/: 3.6 GiB (3812700160 bytes) trimmed
[root@localhost ~]# fstrim -v /
/: 3.6 GiB (3812700160 bytes) trimmed
[root@localhost ~]# fstrim -v /
/: 3.6 GiB (3813261312 bytes) trimmed
[root@localhost ~]#

3-4 minute gap

# fstrim -v /
/: 3.5 GiB (3729862656 bytes) trimmed

OK and on baremetal with 5.5.3.. also 10s delay

# fstrim -v /
/: 82.6 GiB (88663547904 bytes) trimmed
[root@fmac ~]# fstrim -v /
/: 11.3 GiB (12157599744 bytes) trimmed
[root@fmac ~]# fstrim -v /
/: 11.3 GiB (12156633088 bytes) trimmed
[root@fmac ~]#

There's no good use case for multiple fstrim instance this short
apart. I stumbled on it by accident while seeing what the behavior is
of a fallocated file created inside a VM on a sparse raw file used as
the VM's backing "device" - so at first I thought it was related to
that but now it's obviously not related to VM stuff at all.

I have fstrim.timer set to run fstrim.service once per week, and that
reports sane (expected) values each time. But, it also tends to happen
soon after a fresh boot or wake from S3.

-- 
Chris Murphy
