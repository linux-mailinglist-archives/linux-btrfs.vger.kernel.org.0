Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEED436659
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhJUPfH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 11:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhJUPfG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 11:35:06 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BC7C061764
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 08:32:49 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i84so145998ybc.12
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VKUiSFOCxpq+d21wU9hNdykl9qv+HTo70X4AiaB9Cm4=;
        b=c+IFD3NQgpqTlx+Ofhr70ARjNZZTujvF3+RhzQNkJILuzieFb9E9nEKnV1xX5ySXnS
         kUTY6jFNcQ3QevrMGFrAGAICVmI9tww76s/GjKLdh3UTSpJvhGr8Tcs0aOW3GsST5bG1
         edmFhTocVfa0b64ask3EVJl2v8cSSML+aX7081JIpNUy8yqL0FC7sfKEAiP866tdD6fk
         /vULwxyLRsTJwn8lNIu0h+EugJwo+/jKQmrSUy3C2p0qVtK/EinR9fjRGsbUkA7YBIl2
         JnL6XqmqiKacE8uh+OiQ+rVtML9dLJTrLnvECU1FgLkdVp74jJDHgFua9U/2DvCO9rLu
         OeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKUiSFOCxpq+d21wU9hNdykl9qv+HTo70X4AiaB9Cm4=;
        b=eZJvtYYabF8f/faTp2shDCYnEa9iB1OCLWXL/ytFsIyqbwCFGGRDm0pa8fNeFSC413
         W7d0HI+pkHCXgUvrQDK6iVv6jmI8BwCqny3uLSuVEstPCd8JF7b6uRKFvvzfTBhlSMHd
         HtKToGuDTOg8h1Y6kRxAdRpfQkeDZDcJhr35J2vAnTFd/CRS9oYCuygyrSnXev4b0oAZ
         +Cw+iW2LZYl3JC54lH9of1YEdIPaDR/HbMni6i7exjrcVBBzlukXNrS3JHQwIbs/6Qv3
         i+hb1v959Idifyaq2Smy5/yVVh2PBKs8zyloTd2LeqmHICgcICDj1n0XlT04B+z14U9w
         zLXg==
X-Gm-Message-State: AOAM5333P0LwQQUWcmzHxg/Uj6JdWaj0ZhgT1hAi64o+MLL8XjgIU9x5
        RQu/NBXjqX2ehLGz2qUUZ62syUMg51UufKjSBbniMw==
X-Google-Smtp-Source: ABdhPJxvR7plc0BIjZ/uVuIvENxB0KIPkSZoRCXlbe6ftE62xK8mGKdRC/BpvpPQloGOkKMbmwwkCva3qZPkM+gxXpU=
X-Received: by 2002:a25:780e:: with SMTP id t14mr6742249ybc.470.1634830369161;
 Thu, 21 Oct 2021 08:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su> <CAJCQCtR3upV0tEgdNOThMdQRE+fGH60vcbTeKagzXsw1wx9wMQ@mail.gmail.com>
 <y26ngqqg.fsf@damenly.su> <CAJCQCtScczmps7+NfNEObqOnsU64QHhjRRy0Fmj7W8z=ZJNK0g@mail.gmail.com>
 <CAJCQCtQuuzrzLDDZZ0jExeZ6RbDXH3wF7WFq02W77REMn4YJNA@mail.gmail.com>
 <2e18d933-a56e-198d-20c8-ab3038d3f390@suse.com> <CAJCQCtQ+23cQCZQrwPO7Yq1G48yEoUT2CbLH9GdytP6zYXux3g@mail.gmail.com>
 <3c1ead76-e321-a3c1-755c-288ddd5fbeeb@suse.com> <CAJCQCtSr8aSkt+LA_UYD6Cxnqx4uA4g+s5xKs8b75QVStWHojQ@mail.gmail.com>
In-Reply-To: <CAJCQCtSr8aSkt+LA_UYD6Cxnqx4uA4g+s5xKs8b75QVStWHojQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 21 Oct 2021 11:32:33 -0400
Message-ID: <CAJCQCtTJ13FT=t-pFkYUew7Nxv+nCK0=hnURn3KPBAu6acgqcQ@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Su Yue <l@damenly.su>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a significant hand in either sshd or dnf when doing package
installs that precedes the splat. The splat doesn't always happen but
the hang does seem to be reproducible. I have a sysrq+t during this
hang here:

https://drive.google.com/file/d/14qsIb3HNlSx91kPq1Uvo_IHnivQ3S3NO/view?usp=sharing

Maybe there's a hint why we're hung up as a prelude to the splat even
though I haven't gotten the warning yet...

--
Chris Murphy
