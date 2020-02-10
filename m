Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB9A156D75
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 02:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgBJBt3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Feb 2020 20:49:29 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:55570 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgBJBt2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Feb 2020 20:49:28 -0500
Received: by mail-wm1-f50.google.com with SMTP id q9so8070845wmj.5
        for <linux-btrfs@vger.kernel.org>; Sun, 09 Feb 2020 17:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PiDiE9d82DCOCNrOuXpOX70frlQb8NKWaAJTTK3Ql6M=;
        b=Dzh4RMIFqyanmkq3ZskLs/YpRK60GWdsSraq0qVKCmARxj1h3E76+yxJlD3SwVzbEo
         aCVsVUqYrbUPEYV14iijqxrzUE7D89MBX1+9omqrGQczvMz1WDptuVhk/Aos9hAFKChy
         NkxH+kj1FQrq3/7CJH0a9Nnu4A0yqks95OYsq3hjR4gA0EEB4QsCUNMjhVKqG2tDCnfE
         1j2BbC9gFpEw5zA1t3AdY0GZlGJw1adqUqaymeWMM4Rm+Z5aE8enkf6VIFrjj4lCaiwu
         3c6OiX9hKRdqJs80gpuD3kkZnEUAYbFuQKc83Sj4mIVyuJFGc6RkYW3WJOoeYQDjfU6w
         0zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PiDiE9d82DCOCNrOuXpOX70frlQb8NKWaAJTTK3Ql6M=;
        b=qoetJyGUT2Jj1AyNgzH3nNVb+gAhyb4nDjWpIAvT6flRZA+5J073RDU0Gw5Dznj3jp
         wF05bLOcLSbGvJF0hoHYAWKDq7xHFpuowpSuscZAfF9TRGQWNhTZonDRzYnCEFXn9YpA
         /MN0+Ji9WyyJQzpnWLxEAyPcGXm964tY5YRaOc6TDDEQWGiA5KiMh/J5xBVaxEqdJHRR
         lK2FMy5ZtOn8XoyUfV1XhfL5/D4E0opSgdc1Nk/LwGzkoS8xC+NORWf1w7ySfvH3gtUL
         Ftaxco3pQj5usHJyRJ4faIyiuPpbwPxxrUtiARJhSnZeju0GAjZXLlkxZuQF4/bvUkzw
         Q+1w==
X-Gm-Message-State: APjAAAXeghE6SDIpIDG6sFnDH+bVPDgXVd9rtnkXtJNz1WU//bQTESRa
        ZPq51F5b9JVNrhs3vU92El7MDB2Jx065c0SRi50hye3tGZpG9g==
X-Google-Smtp-Source: APXvYqydXNJIoL6wo3Ka6suYA7mjdVHEBYNCM5/nI7ylaMy+UI5ftb8KmUXBaA0iGdi0Ke+IVAEIz+tjcW7fBhCvP0U=
X-Received: by 2002:a05:600c:217:: with SMTP id 23mr11934578wmi.124.1581299367139;
 Sun, 09 Feb 2020 17:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20200209004307.GG13306@hungrycats.org>
In-Reply-To: <20200209004307.GG13306@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 9 Feb 2020 18:49:11 -0700
Message-ID: <CAJCQCtRzMqPREP5U=8ZoCY0fMEsX_ng4tH3pHbQwJfrdk-MNmw@mail.gmail.com>
Subject: Re: data rolled back 5 hours after crash, long fsync running times,
 watchdog evasion on 5.4.11
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Timothy Pearson <tpearson@raptorengineering.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 8, 2020 at 5:43 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> Upon reboot, the filesystem reverts to its state at the last completed
> transaction 4441796 at #2, which is 5 hours earlier.  Everything seems to
> be intact, but there is no trace of any update to the filesystem after
> the transaction 4441796.  The last 'fi usage' logged before the crash
> and the first 'fi usage' after show 40GB of data and 25GB of metadata
> block groups freed in between.

Is this behavior affected by flushoncommit mount option? i.e. do you
see a difference using flushoncommit vs noflushoncommit? My suspicion
is the problem doesn't happen with noflushoncommit, but then you get
another consequence that maybe your use case can't tolerate?


-- 
Chris Murphy
