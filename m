Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5B31A17CC
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 00:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgDGWL3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 18:11:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45305 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGWL3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Apr 2020 18:11:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id v5so5575779wrp.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Apr 2020 15:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1oZCBlsYl6gqiMobmXc1XnEMI4SUVXR6O0V+z/zMYQ=;
        b=M4UJmLmwVbRdUJXfUgLzChB9G7FHGxB18xWEWQcdh7KDtUJG+PUyTBjogipo+MomnZ
         sADyhDPbVdYuSoQBQau6/nezL/JRGz3IiYGxYhz8KaJNpu+xIS8Co1xUIFJKRJ3hhNz5
         YGUOfI7JFRUbVkyDH7nI2ia6ZP02w0xpMBZE41qLj9/gGmLV++tl4skBT58UG4suKKq1
         OcKRQ3rT8D/KGJ9tZJT1VbnD7Whl8sHN2ujqwtUG9OFNEsWQ2xOosLzPbD3ekG+QmHaZ
         ah3N/vjEbZpYg8yEoT69UyiZrZFjEXr2eEsE4BfQ9GHJu6JeYMgga6j+LqFmUOkchYM9
         z+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1oZCBlsYl6gqiMobmXc1XnEMI4SUVXR6O0V+z/zMYQ=;
        b=lXbnzu7AezE6Dbt8XZouDNo+RgD01UNhkS0As9bJDwG2UOf2ExjNoyMK/TmiTjLTKQ
         GRAhIU0vhPack2UnjGQPBiHBKlKqJrvfpnC2OVzsmVhz60rrXozA8X18/Y6GiIyvud8Y
         Ji9+D4i45YaG1dFvdhnO6j6WEuE6PINAaOIKNsV5I8Dwj+rGHVgDNVkCmtz2OMmSGk/+
         IWVa6AdvgH8kVrPzpx5CYr3s0klshxIAYOv7BVQICYSgpRZvhXvZPdw0us/tXOhO9915
         EUqTamAENEib2NPX4NpIHWb7hkpjZX/uQY1YNGppkaIbzwJidCJ2JTq9Uf0UwweZDzSj
         j0KQ==
X-Gm-Message-State: AGi0PuaWZRcDy3zymMrnkmpr21WcwVCfj4E4YDLBMMMvLaWS/HufyzNp
        B6nk1iRE98VS9eSMWXrs2ZX/iEEBlChXaLXoXBpqPg==
X-Google-Smtp-Source: APiQypJLLmCnGsXnS5nddRPEOMkY7SuX6AsTw6jxjNHdc3aUVaVMbaSssrzODAb/WsIN21Y9Z65YzAN2SGD3xi/ddVA=
X-Received: by 2002:adf:ec11:: with SMTP id x17mr4849033wrn.42.1586297487939;
 Tue, 07 Apr 2020 15:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <6a1c8ce0-ce2a-698d-dcc6-0657a125dae4@gmail.com>
 <CAJCQCtRcTzL9LQZppvCj4zg2NpvGUri0QS58wY3E_PG+o0Jchg@mail.gmail.com>
 <CAJCQCtQ6C4kvBQaKMaoPBo8jbj-abNEYh_63-d-EkHVgWq6iPg@mail.gmail.com> <4ef177eb-4b06-3b76-bf5c-5cf6df3221f7@gmail.com>
In-Reply-To: <4ef177eb-4b06-3b76-bf5c-5cf6df3221f7@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 7 Apr 2020 16:11:11 -0600
Message-ID: <CAJCQCtTJQOZ-t6RZuG2ifPMFtEeHRjP6h6SeTc5ysHi-ekMTbQ@mail.gmail.com>
Subject: Re: btrfs freezing on writes
To:     kjansen387 <kjansen387@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 7, 2020 at 2:39 PM kjansen387 <kjansen387@gmail.com> wrote:



>$ grep /export /etc/fstab
>UUID=8ce9e167-57ea-4cf8-8678-3049ba028c12 /export       btrfs
>device=/dev/sde,device=/dev/sdf    0 2

I'd use only noatime for options. There's no advantage of specifying
devices. And also fs_passno can be 0. fsck.btrfs is a no op anyway, so
it doesn't hurt anything to leave it at 2.



> I've attached sysstat info of my disks. What's obvious is that 2 disks
> have the load (one is written to, the other one is the mirror), and 3
> are pretty idle. But, it's 2.4MB per second - that's not much!

Lots of small file writes maybe? What's iostat show for utilization?
Or vmstat for io? Hard drives of course have limited IO per second.

> I've just changed the space_cache to v2, but it doesn't seem to help
> much. 'sync -f /export/tmp' still takes very long at times (just took 22
> seconds!)

I just did a strace on this command and it uses syncfs, not fsync. I'm
pretty sure on Btrfs this is a full filesystem sync, which is
expensive, all data and metadata. So if it's very dirty, yeah it could
take some time to flush everything to disk.

Try it without -f and you'll get fsync.


> Any way we can find the cause, before I move everything into subvolumes
> ? I'd like to avoid that if possible. Sounds a bit overkill for 2.4MB/s
> writes, and I think most of it is going to one influxdb database anyway.

From the sysrq...
[937013.794093] mysqld          D    0 10400      1 0x00004000
[937013.794240]  do_fsync+0x38/0x70

[937013.794253] mysqld          D    0 10412      1 0x00004000
[937013.794297]  do_fsync+0x38/0x70

[937013.794306] mysqld          D    0 10421      1 0x00004000
[937013.794353]  do_fsync+0x38/0x70

[937013.794788] WTJourn.Flusher D    0 1186978 1186954 0x00004320
[937013.794894]  do_fsync+0x38/0x70

[937013.794903] ftdc            D    0 1186980 1186954 0x00000320
[937013.794951]  ? btrfs_create+0x200/0x200 [btrfs]

[937013.795022] influxd         D    0 2082782      1 0x00004000
[937013.795086]  do_fsync+0x38/0x70

[937013.795098] influxd         D    0 2082804      1 0x00004000
[937013.795143]  do_fsync+0x38/0x70

[937013.795191] vim             D    0 2228648 2223845 0x00004000
[937013.795286]  do_fsync+0x38/0x70

Quite a lot of fsync all at once.

But I'm not very good at parsing kernel output. Maybe a developer will
have input.



-- 
Chris Murphy
