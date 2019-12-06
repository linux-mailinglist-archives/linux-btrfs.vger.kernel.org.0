Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5059114B84
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 04:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfLFDy2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 22:54:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46819 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfLFDy2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 22:54:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so6139212wrl.13
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 19:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VIJ49er3KGbXs3GRNEumQxYQoJjFQF/TsnCwnyymnSQ=;
        b=Fqrtum0hn6ZODvGTSuQZgbyJbKtyJpq0KDLlj+ilE7tGVPCQ2WHeHSK5WYfhAWr8gs
         HHGO/Ncgx+rRCd5LzWAosxRk+7UCG6bpPSJXX6VRe8jEnkLPVn4A8hNa0qdnH7Rw7RQc
         mSPO0EEzf2mdNKBkUIn+dQk+vdq7ADHUIKEkZgVUpmWBCt/KNpGgLs2l92vqrv5C22RA
         ssMsmomtFuYyNFX48c/mux6GS/g8t9HeuzXb4mLXfLCDhyH+WaMaT+ZOVkCy+g9WBc2X
         jRSg2cOTU7tfJ8MqPUP8z/+uoU42ro2T0Ay3uVq3qaJ0cE4uPknND3NUjDNDRd4Cr2NF
         xq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VIJ49er3KGbXs3GRNEumQxYQoJjFQF/TsnCwnyymnSQ=;
        b=tK8ICAxqqScumYrkZnCJuzanraPAP78srDnZ3EOq2Mi18S20slGuM7tVu5mvbvISNS
         QnuMQhxK2bPrlV4dOFMaJrzW9rWx18Z/FpEXlAe1Kh1bR3YDQyHFqP/pzXgu7oMVDmlv
         1fn9xWciAzH5IcjIGb45o+YvVeKyA9a+Ky6+Z3PLb7fF6hysDTqdpbNV0Wa8csLtDwgA
         QiPRwtJ5SUPg9KJrLELVqPaULadJBBuzkU4hOikTcY9tMA0UcHPn7pX4QVjTmkONC/hi
         VwwYRcj58P6wqlmxvLsPCQvspOBCJeOwup3E1ZB6YW5NSHyy8b+uvROt1oWC/6dfA6qu
         tSEA==
X-Gm-Message-State: APjAAAXrS+OYF3dFGsgAugwxbxJSlkwKgDmw7a6TpNuImRnihLq8QVpE
        d1EkGrHd3sKw7uJ4Onas3FN7r+7PkMK2p1mwpato9g==
X-Google-Smtp-Source: APXvYqwdMjdfg47dQU/hedUaiadxbCOIcGoRJ1tpBvbfaydxxd7PbkKdX/AldsAOy09x81Ci+OC9j++OGXvr7A15kNY=
X-Received: by 2002:adf:f108:: with SMTP id r8mr13361212wro.390.1575604466265;
 Thu, 05 Dec 2019 19:54:26 -0800 (PST)
MIME-Version: 1.0
References: <eb9cfb919176c239d864f78e5756f1db@wpkg.org>
In-Reply-To: <eb9cfb919176c239d864f78e5756f1db@wpkg.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 5 Dec 2019 20:54:10 -0700
Message-ID: <CAJCQCtQ9Vg9VuT66diid6KdRMDqicxj9xLigTBF4sbMgqD=5jQ@mail.gmail.com>
Subject: Re: 100% disk usage reported by "df", 60% disk usage reported by
 "btrfs fi usage" - this breaks userspace behaviour
To:     Tomasz Chmielewski <mangoo@wpkg.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 5, 2019 at 7:04 PM Tomasz Chmielewski <mangoo@wpkg.org> wrote:
>
> I know that "df -h" is not to be trusted with btrfs, but some userspace
> tools (i.e. apt, monitoring checks) rely on it.
>
> Sometimes, "df -h" will report 100% disk usage on a btrfs filesystem,
> while there is still space available and writes are possible.
>
> Linux 5.4.1, LXD containers located in /data:
>
> # df -h
> /dev/nvme1n1               1000G  571G     0 100% /data
>
> # btrfs fi usage /data
> Overall:
>      Device size:                1000.00GiB
>      Device allocated:            580.02GiB
>      Device unallocated:          419.98GiB
>      Device missing:                  0.00B
>      Used:                        570.06GiB
>      Free (estimated):            429.45GiB      (min: 429.45GiB)
>      Data ratio:                       1.00
>      Metadata ratio:                   1.00
>      Global reserve:              512.00MiB      (used: 0.00B)


It does look like a bug. But I'm not sure if this is expected, I
thought such significant disagreements were long since fixed.

What version of coreutils?

Maybe attach a strace of df? (I'm not sure of the list attach size
limit but it's preferred, but something like a pastebin is OK also)

And maybe this will be useful for a dev?
# grep -r . /sys/fs/btrfs/<fs-uuid>/allocation/

You'll need to use the correct fs uuid for the btrfs in question.


> Data,single: Size:578.01GiB, Used:568.54GiB
>     /dev/nvme1n1  578.01GiB

df seems to be treating only unallocated space as free, rather than
both unallocated and allocated that is unused. Color me surprised.



-- 
Chris Murphy
