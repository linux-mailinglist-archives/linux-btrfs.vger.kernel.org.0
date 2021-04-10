Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1CD35B025
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Apr 2021 21:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhDJTms (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Apr 2021 15:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhDJTmr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Apr 2021 15:42:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21CEC06138A
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Apr 2021 12:42:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a6so8888577wrw.8
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Apr 2021 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+nSiV4nFDD9oLhxq/bQZ6llneYtoYYbGIfcIFRjqUs=;
        b=fbL3epQ4nbWJKZeDwCUpFdY12Ps/nldsEa5D+a+7aYO+kVyOUxpjpWUf4DCFAO2JCa
         J8F5bZh8Wz/YNL43ExRWRa61FiIEhNI82xTultuGxWkiwQhmrITz1OC7XH9EFmMc7Lxd
         ihbGb3iWDYiRpKZDZuLs6gGtd0vW3Q4z7wv+fSCP7dXwq7wZT0ZWdMDrE67VavtvfLQW
         sfIymvTaxOqmvC/hFpyKQL6pXpWYS/XipzcpZqyVjtgqr2clr0SYr7Cu223pzkj9Zq9F
         lgF8BqBOjQ1SAZhZoIdwVmdRmX7gR8o/sb5tXg7I86b6ubOvkNfSqkQk7tHky+Zm/Kbx
         k5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+nSiV4nFDD9oLhxq/bQZ6llneYtoYYbGIfcIFRjqUs=;
        b=rykbs5m8t3iTZDhn23Nqiqfby2qKbBfCFveb6wjUD9vlJ1d8HfWbmxJTGdoYqcgoX8
         Coawl5R/KNZ/u56bUCtlhNJA4LJoxNYPjed/DA+ILX5ken/WCwqx2WfvmPM0DzV6mrXM
         Jt2hAXVJzEjCwgaJ4pWuYCQT5aYGwSGcldF8OYNSEyhBxcihqH05jnx/ZQkrAVnoftmQ
         OSX/y0QahCxXvbJhcy1/86fwvgaDGPKQT15f3Yl86k5uMj6u9ND8YboF4G1IaqhqUPKm
         OFshqoKpHj25xgzSSTIWdVhDRrleqyjbbkRcx9II6y1osPwrBwt6zqR7R3iD+kiFOIiw
         XSCA==
X-Gm-Message-State: AOAM531yRuPJAtCle2B484bKs8Vyk0D56x4J4S+S4RjdlzSMfVtIP29r
        dv4w+lk7jJHmlbLt0mU6uNlQp9C0WK5L22eK4lD2PQ==
X-Google-Smtp-Source: ABdhPJyunLGHawJjOH77NIpSztXKMscYL+goNlYMbZ1wo/wu2fJgLrEC6qCedchxlggzH04NFhgJ3ruOdWVr7CuZpgM=
X-Received: by 2002:adf:dd0c:: with SMTP id a12mr23640830wrm.274.1618083749321;
 Sat, 10 Apr 2021 12:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp0aXBssEr4ZXGX=DS_+RyGghmoANCKDdxG59QWu8LVA@mail.gmail.com>
 <CAOQ4uxht70nODhNHNwGFMSqDyOKLXOKrY0H6g849os4BQ7cokA@mail.gmail.com>
 <CAJCQCtRGdBzyskifrYLbBGAAm0g7VeC6GeD7xBN-hRqE3GAWYA@mail.gmail.com>
 <CAOQ4uxhU2KX=jKKL5EZ102z_+6KyVKAOoAzSp2K8i0PMGJUg4A@mail.gmail.com> <CAJCQCtTHepsUHjCUAwawC6r6txAZ=XypE5rJOizqxMx9zuR4AA@mail.gmail.com>
In-Reply-To: <CAJCQCtTHepsUHjCUAwawC6r6txAZ=XypE5rJOizqxMx9zuR4AA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 10 Apr 2021 13:42:13 -0600
Message-ID: <CAJCQCtQshgFBvUF2+DLm0=iHhiONu-QCRnB1uNv2dLigT+WfZg@mail.gmail.com>
Subject: Re: btrfs+overlayfs: upper fs does not support xattr, falling back to
 index=off and metacopy=off.
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 10, 2021 at 1:36 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> $ sudo mount -o remount,userxattr /home
> mount: /home: mount point not mounted or bad option.
>
> [   92.573364] BTRFS error (device sda6): unrecognized mount option 'userxattr'
>

[   63.320831] BTRFS error (device sda6): unrecognized mount option 'user_xattr'

And if I try it with rootflags at boot, boot fails due to mount
failure due to unrecognized mount option.


-- 
Chris Murphy
