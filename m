Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3413352C0A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 19:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbiERRGn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 13:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbiERRGn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 13:06:43 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5474B1C9
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 10:06:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id g16so3299425lja.3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9T6gMcFyu+Kbsw/2TSbA7QhiBkOaWtcZW/qtYVU6sU=;
        b=vGbEacv7EOsJXSrvGYqnXABgLfU3fBj69nEY/Ix8j+xG2yJe+sDtiV7+6eR9BZXJ8U
         u2fBDL3AspIzRBeIhtr/xcgVHGcazU8YM9mcS0mj4khR50gK4TWVd3+9roEFkuJmo0rc
         hXgK/OcgSvhIWPY7vyseYU+qLsxBMz1tW/8y1tMxF+npAVT+Pzhmi2tlgCQ9EvPsRfHq
         SAQBPRb2Pqh2YNAdmHCsSAARlu816GT5KKlqOqrVXvvU0QRS8GKSDBEAx3bdUDeJdoSo
         8SeMjgb/nS3umhiB+9us6vZXzzHdLqxEB2h+Vr8mS/IEDTM9MfKdYE1mj2/gZowFjc7h
         2kNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9T6gMcFyu+Kbsw/2TSbA7QhiBkOaWtcZW/qtYVU6sU=;
        b=0BD3MMGBRcSOW2rHNIBzCcpxRfo7Gzg2htdryx5XUbxmqyLhG9UGvjizlnoepysilg
         KFvXjcnIcMNEfHdPjw6WX6tAFJP79+DKaQITZdCo4qPxXqpnlQy3hr7GjBFYrprmbWs5
         n8Jdd/uyncSYGltqarZHenc2F3WuJA3aiRLxaMwX7HZ3m/E2fpsQqgoo00lQf9pKLrZX
         WPrEUBuCuJyhyom2jBCsW9mx4lK0YrTGZnIWXKvjyKii3lK0JgcPrHpd9KjlML/0ZXUW
         kh7ctkvmlmPE0j0fsxQrcFNYDTWebwOxP+i2C3HN75GSCZPk9OyhwISNbzB2ZCOMre/W
         EE8g==
X-Gm-Message-State: AOAM530tkQeDv5x3vJkXrdM7hBioTQrJmI53Icba3VyX3AYyLmHdOlZ1
        42heaEYha4PV/uo0k2PgjMgC4jYOZmXc/0h78PcDZg==
X-Google-Smtp-Source: ABdhPJybxGJBnH8deGZCFx5U9/92FFl+YyB4ua9kTJ5ULVx396iKh2Z0JoTK68pIgjDLvt0VzX7GnQ7I8zECOBQhbBk=
X-Received: by 2002:a05:651c:312:b0:251:f8b8:184e with SMTP id
 a18-20020a05651c031200b00251f8b8184emr205231ljp.9.1652893599702; Wed, 18 May
 2022 10:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHRVCvZ4BDGK3gfD3WgC0VZFh1accyHFoZO+P0rX1mvt6wPoNw@mail.gmail.com>
 <CAJCQCtRNkLZHvUynEuD7_LC4dPyNJr9HmkGL73gAq1_YhkH8kA@mail.gmail.com> <CAHRVCvYOhOEyBKLYFC3Q+maoeyU16BMtcLdu+RQgC+=mD8=oxg@mail.gmail.com>
In-Reply-To: <CAHRVCvYOhOEyBKLYFC3Q+maoeyU16BMtcLdu+RQgC+=mD8=oxg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 18 May 2022 13:06:23 -0400
Message-ID: <CAJCQCtQFaRBQ1h99oOrS18NhfOTe4J4ORi7wt7u+t4hi0w6_Fw@mail.gmail.com>
Subject: Re: Trying to recover pair of drives after sudden power off
To:     Gabe <felixnightshade@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 16, 2022 at 11:10 PM Gabe <felixnightshade@gmail.com> wrote:
>
> Okay, updated btrfs-progs to 5.17.
>
> # btrfs check --readonly /dev/sda1
> Opening filesystem to check...
> parent transid verify failed on 1436734291968 wanted 13636 found 13639
> parent transid verify failed on 1436734291968 wanted 13636 found 13639
> parent transid verify failed on 1436734291968 wanted 13636 found 13639
> Ignoring transid failure
> ERROR: root [4 0] level 0 does not match 1
>
> Yep, same output as  btrfs restore -viD /dev/sda1 /mnt/Alpha2
>
> Something that might be of note is that the drive pair was passed
> through directly to a virtual machine (bad idea for many reasons; now
> I know). In Proxmox the default option for the disk cache is no cache
> (which I hadn't changed). If this error stems from a write cache issue
> then I'm thinking this could have been the cause.

It's a reasonable suspicion. You'd need to dig into what exactly no
cache means. Does it mean writes can be reordered, violating flush/FUA
imposed write order? This might not be a problem if the guest crashes,
because the host will still write everything that was pending. But if
anything physical happens to the host including the drives, then all
bets are off and it can be really bad.

However, I'd like to think even in this case that btrfs restore can
still do a recovery because not everything can be so badly damaged
that it's impossible. I'd look at the options for specifying older
root trees. e.g.

btrfs-find-root

And then use the root tree block address in descending order with the
btrfs restore -t option. Also helpful if you can point to a particular
subvolume using the --root option. This is easier to figure out with
newer versions of btrfs progs by using the btrfs restore --list-roots
option by itself (not attempting a restore otherwise). The more you
can narrow the tool, the greater the chance of success.

https://btrfs.wiki.kernel.org/index.php/Restore


--
Chris Murphy
