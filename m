Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14539517018
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385201AbiEBNUX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 09:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbiEBNUW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 09:20:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8A0B7DB
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 06:16:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w1so25197297lfa.4
        for <linux-btrfs@vger.kernel.org>; Mon, 02 May 2022 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XSAhrm03GGWEjMLlDF84S4bAtbLEkCKWCJtvQMW45U=;
        b=NZfnMZTUfsg9DfI0DkYHoJOsoiJg8G/+eNuB6Ll5/LkEa6pf9CasxSb1JmGs4wr3ha
         hOQjBd5VwaV0aWCvXA2KMIAq5Sz0UC4KiFQlZpUmbS4tCEEWrf9+PE0vfNWtDZzcXowu
         5iWjrBmK0+IlaFRM8l2vdMGH1FlmNbCb5apvfhdV1UXvPfuTwGw1kNgJ0Z9eChfHvPKM
         mzhoveSoYCZAhMphyw6MjaT5W9FIkE/ZfECwlqIJmiPjQyk+pe2y8TM4kn1I/FDKEJlO
         48QzQF7yZxLQjJTwCOi2Nmqlj9coLC7bG62FCGQkr3khGa/t6ygBoA7jYi//MIaG5Yov
         cAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XSAhrm03GGWEjMLlDF84S4bAtbLEkCKWCJtvQMW45U=;
        b=mTHMcNaHWVEpZ9LLBj9ythhLDb7frH00dA6Qk0I8Hyi3Z36P8au1jvGdsHS6hy52VK
         7c1GbXeDyLb0+2tep6/okEv+Q40SM9Otp9Xx0LWTnKdKyvUZf8OyX20FdqTAENs4k7Ya
         0kvxWBzB20Bnt9tu7v6t2OmWZiRcLitanQ328OkS8b+xShU+jycP1dMPwjdD5KZEV5BV
         jJ56RHsnOksQzoQcUCp33gOvxaRAyvS3V6bRot+a9Rr5B2r1Gnxv/J2YRDZ9uVrTBDXu
         pnMSDEWMmoaKi9j3+zAzURZJGOmdg2D2mrVoJ9YcD/kr/4Yr9p4ae/s7BouIrVvD4Yx1
         CELw==
X-Gm-Message-State: AOAM531qYqGSgIQKlIA7Qv0g+dvclfkuE1NFL/fH6hq4fnzOuUljT7M5
        QD5W0I2+JKairw5xI+m3pD0EtKPBmJRwkpJr2Lrz2w==
X-Google-Smtp-Source: ABdhPJwoBJsbOH059vLBJG50hFPVbOlr0QxjSqMs9sAIcvYmIJQrQWcuz+oQAqgsu5HOsFjWnw5BR3bZbkFxsTPUrZ0=
X-Received: by 2002:a05:6512:1194:b0:471:b0dd:8755 with SMTP id
 g20-20020a056512119400b00471b0dd8755mr8496252lfr.212.1651497411418; Mon, 02
 May 2022 06:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <87238001-69C5-4FA8-BE83-C35338BC8C81@gmail.com>
 <20220430201458.GG15632@savella.carfax.org.uk> <85da8da9-54ee-f65b-e79e-bb24b7540e7c@gmail.com>
In-Reply-To: <85da8da9-54ee-f65b-e79e-bb24b7540e7c@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 2 May 2022 09:16:35 -0400
Message-ID: <CAJCQCtQuCorJ6YaPb_hVpX4312U4Ec5v3jcw+g6whYFd4udx0g@mail.gmail.com>
Subject: Re: How to convert a directory to a subvolume
To:     John Center <jlcenter15@gmail.com>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 1, 2022 at 8:02 PM John Center <jlcenter15@gmail.com> wrote:
>
> Hi Hugo,
>
> Thanks for responding.  I guess what I don't understand, @home is a
> subvolume, but it appears as /home when it is mounted via fstab.  It has
> a top level ID of 5.  If I create a subvolume for opt, it has a top
> level of 256.  I've tried different variations of opt, /opt, & @opt, but
> they all appear as that variation under /:
>
> john@Mariposa:~$ sudo btrfs subvolume create /@opt
> Create subvolume '//@opt'

This is the mistake. Since @ is mounted at /, using /@opt actually
means /@/@opt, thus it's been nested.

>
> john@Mariposa:~$ sudo btrfs subvolume list /
> ID 256 gen 5968 top level 5 path @
> ID 257 gen 5968 top level 5 path @home
> ID 259 gen 5966 top level 256 path @opt

@opt was created inside @, that's why it looks like this. Thus, @opt
is nested within @. Thus, @ and @home follow a flat layout. And @opt
follows a nested layout. To continue with the flat layout for @opt
you'd need to create the @opt subvolume in the top-level of the file
system alongside @ and @home rather than within one of them. To create
it in the top-level you need to mount the top-level somewhere, e.g.

btrfs subvolume get-default /

Assuming this refers to ID 5, then you just

mount /dev/sdXY /mnt
btrfs subvolume create /mnt/@opt

And the fstab entry should be subvol=@opt

If get-default reports a value other than 5, then you need to
explicitly mount the top level:

mount -o subvol=/ /dev/sdXY /mnt       OR
mount -o subvolid=5 /dev/sdXY /mnt    OR
mount -o subvolid=0 /dev/sdXY /mnt

The top-level subvolume was assigned ID 5 during initial creation of
the file system. Soon after, ID 0 was set up as an alias for 5 because
maybe it'd be easier to remember.

Note: The top-level nomenclature used by btrfs subvolume list is
considered confusing, and I think it's going away in btrfs-progs
soonish? The "top-level" of the file system is considered equivalent
to subvolume ID 5, which has no name, cannot be renamed or removed,
but can be snapshot, and is the subvolume created at mkfs time. Above,
it sounds like there's multiple "top-level" subvolumes, e.g. 5 and
256. But in practice it's not how anyone is using the term "top
level", which these days is intended to refer to just ID 5. The
subvolume with no (explicit) name.



>
> john@Mariposa:~$ sudo btrfs subvolume delete /@opt
> Delete subvolume (no-commit): '//@opt'
>
> john@Mariposa:~$ sudo btrfs subvolume create /opt
> Create subvolume '//opt'

Yep, / is still the @ subvolume here, because @ is bind mounted to /


> So, what am I missing between what I'm seeing vs what I think I should
> be seeing?

It'd be neat if we had a way to create subvolumes in the top level
directly without having to mount the top level. The FD variant of the
C API found in libbtrfsutil suggests it's possible. And also we have a
way to delete subvolumes by subvolid, even when they aren't locatable
via the mounted file system hierarchy, using the --subvolid flag.




-- 
Chris Murphy
