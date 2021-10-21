Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE8B436509
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 17:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhJUPIk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhJUPIi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 11:08:38 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA97DC0613B9
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 08:06:21 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r184so889516ybc.10
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 08:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zn7Gawkh/Nm8y4i/NqLNFMva5eF87QCz8fZNBQpCA/8=;
        b=UgZmD4fdI+QjmUshHL41NE1xwGYEPFD9/3gmQtVHTheigRIZyTpyVLsAOo70Mc4gh+
         nqokIQ8d45+ig+SyVCHAkz9XVuxHfJh6kKliVw2KEjV22V0WivJl9941mjxPfRYuvK3D
         dfDdVlcSi+rNVX2QTRGAEEh8My/SYdOBY7N+MKElpfcx4JAFhuP0xULfQxsIaarZKkq/
         7lxfcoDXBR26hT8+KDKbJp8yGj5iAZcQZfOgklDn1gqZCaJqFbter36s3vQs4qsixv7h
         WfpOXaiqFZ1GbumQ14R9uJecdy4OnAv/Gu5kfsAKat7hNj2K4tamsyDdCX2Ph79D/RbW
         ej7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zn7Gawkh/Nm8y4i/NqLNFMva5eF87QCz8fZNBQpCA/8=;
        b=UFErjrRV8+PRdsSuO4mpkeN7nKI0fFUQlz2QbEiM8s0Wc8NFqQkILIJewz/JAZk3jC
         FZN3v2UAGiNiV/GuezvsVZ07/XJUVSNEYPhBdXxPaExk4Z3umqbSX4/I4iYeXC8+TbPx
         bh+Y+1ca5TgU0sf6FvzJppkOwJhuT+QcCDOWJdyA98e7npNPxciDQ8/X0N/A+qWupczK
         J1Ru/KlvK5TpPNc4AVnT+Jo0zlOR33ldcM0XbYyhCIdQvxi1OZzJINI/rrsAO5tOuDaW
         zXL5hO4KoU28VLyIZ48N6iTlyKnAZwoFRXjqfA0bGM+KVAuqwQk66Of1B9LJ9O/pybal
         emJg==
X-Gm-Message-State: AOAM533L3A1X389gER+a4Q33ON740ghqW/1+S9Jf6ld0nYzZCpy/+nO+
        jFgY41rwOvwjozkzTfvQ3/B0zL45uppL1ie/O4L8SZsgMdV0WI44
X-Google-Smtp-Source: ABdhPJzbe+cgqDelghLuRkPw5tqq7WdzgOCW8K5hV9h+tw8VWPp/QleykUsfSQaIQCobaZa2jf8zl1fBZaRHCMl8l00=
X-Received: by 2002:a05:6902:1029:: with SMTP id x9mr7106449ybt.493.1634828781124;
 Thu, 21 Oct 2021 08:06:21 -0700 (PDT)
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
 <3c1ead76-e321-a3c1-755c-288ddd5fbeeb@suse.com>
In-Reply-To: <3c1ead76-e321-a3c1-755c-288ddd5fbeeb@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 21 Oct 2021 11:06:05 -0400
Message-ID: <CAJCQCtSr8aSkt+LA_UYD6Cxnqx4uA4g+s5xKs8b75QVStWHojQ@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>, Su Yue <l@damenly.su>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 11:01 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> Just to be clear, when you initiate a crash with sysrq+c does it capture
> a crashdump? That's the basic test that needs to pass in order to ensure
> kdump works as expected.

Yes it does.


-- 
Chris Murphy
