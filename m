Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCEF279E7B
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Sep 2020 07:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgI0FoC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Sep 2020 01:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgI0FoB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Sep 2020 01:44:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CE5C0613CE
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Sep 2020 22:44:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so3346736wmi.0
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Sep 2020 22:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fJPzoShlulolTsCANwxHPouik8hhFIKRZxbrnyMnBxg=;
        b=gm6JRmHyu6FCIlYLlcuF3gkpdPQmOZiAaQ6r0qJ/LqLvrr5GSqX1wO8sc0Wx7x01i5
         r+KJyoZFwKB8ohUDqRgFZKW2Eghmqd6gBGInvCSJQ2SAvcB80EzamxolkyvEb66Uqy67
         D/k82CtITb/Tgysxji2gtWwLnH+9k+bJSJyu0jgym9eRVtPmawF3Zwjrq4gfOlTGJTan
         CyFGtUQ8V+0WG/Bhk+s1rNe20mRyuDB2eO6705ZLMwcu6NVLpk2eUlGk4AtCm2ag0M/B
         oFLJGol08xUmUCecCKpEi9Qo/nlCAbKQKEN1necZaLyOzbD12OL6jCo1Qw/cd4QUgO0a
         kw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fJPzoShlulolTsCANwxHPouik8hhFIKRZxbrnyMnBxg=;
        b=WiY59Ljwr87Ke5uaQZjlZjyebCY9AHG3X5CmFymdnNxSxYWz5/KvVmHBXNb42PJvbM
         cQqyzl1pUsyOnDBnftQGjE9BeZSjPajyr/7841VQPLDDKwdi9cnHXjXGnUsCXVc9yHWd
         9Qhr9vCy94AwTTERvtEUdX3h6S/56Y91k6jvog/4aIeRKMzNGCJ7w974ShSATJBWZ0eC
         m4G7RL3YcyBKHjVhOi1hR1Mhbfz8uTOeCF7m80JuB2ay88wF640sj0muke5UjhAt47Nh
         1FuFHYLWu/BvKvzSMzjeVufrT9cqttwlo/mSkX1G9Mk5ir7OuVvB+9DM78AunyTnfAJO
         JufQ==
X-Gm-Message-State: AOAM530wgWkM7wRRL6SMElhGEuPXQRPZ12tQ2tl1kJPMHP0K2axWonfV
        lFss2Ca18HxXCPTWYQSKxMi8rc4fBiZPSMHOqCeVug==
X-Google-Smtp-Source: ABdhPJxT9NYBk+UqAfqtCmRdbqh9aHh/1i1OkjqDkopnJe+C1jWbsWENY7dtupPkhEQHwtjmA7+f3FodboFCNwdk4ew=
X-Received: by 2002:a1c:35c5:: with SMTP id c188mr5589117wma.11.1601185440226;
 Sat, 26 Sep 2020 22:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <91595165-FA0C-4BFB-BA8F-30BEAE6281A3@icloud.com>
 <fff0f71b-0db7-cbfc-5546-ea87f9bbf838@gmx.com> <C83FF9DC-77A2-4D21-A26A-4C2AE5255A20@icloud.com>
 <c992de06-0df7-4b68-2b39-d8e78332c53d@gmx.com> <33E2EE2B-38B5-49A3-AB9F-0D99886751C4@icloud.com>
In-Reply-To: <33E2EE2B-38B5-49A3-AB9F-0D99886751C4@icloud.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 26 Sep 2020 23:43:44 -0600
Message-ID: <CAJCQCtTjj7Q9D9uKQRPixC6MPKRbNw3xkf=xdF1yONcqR=FM6w@mail.gmail.com>
Subject: Re: Drive won't mount, please help
To:     J J <j333111@icloud.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 26, 2020 at 11:27 AM J J <j333111@icloud.com> wrote:
>
> I ran btrfs-restore and recovered some data, but not most, and not the mo=
st critical. Believe it or not, my other backup drive failed within the sam=
e week (different file system, different location), so I=E2=80=99m worried =
I lost a lot of data.
>
> I'm Following this page https://btrfs.wiki.kernel.org/index.php/Restore, =
is this the best source for information?

One thing missing is  -l|--list-roots doesn't show the
subvolume/snapshot names. That might make recovery harder because if
there's tree damage and the data you're after is in an older snapshot
- decent chance that tree is not damaged and you can get data out that
way.

Something like this:

 btrfs insp dump-t -t 1 /dev/whatever | grep -A1 'ROOT_REF'

For each item, first line contains the root ID number you need, and
the second line contains the name you're familiar with.

    item 4 key (FS_TREE ROOT_REF 258) itemoff 31311 itemsize 22
        root ref key dirid 256 sequence 3 name home

If I want to work on just home, I need to use

btrfs restore --ignore-errors --verbose --root 258

Also, you probably want newer btrfs-progs than 4.7. I don't know if
there have been improvements to restore since then, but why not give
it a shot and see. Most people give up because the restore tool is
sort of a choose your own adventure book.

In particular, the part about filtering with regex is a hurdle of its
own but if the subvolume/snapshot you're restoring as a lot of files
in it that you don't want to restore, then it can be useful time
savings wise. If you'd rather filter through things later, then you
can skip --path-regex option.

--=20
Chris Murphy
