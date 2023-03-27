Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC226CAF29
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 21:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjC0TvU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 15:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjC0TvQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 15:51:16 -0400
Received: from mta-p5.oit.umn.edu (mta-p5.oit.umn.edu [134.84.196.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA62D35A9
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 12:51:12 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4Plk2l6L8gz9wTCG
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 19:51:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x-WvlKsjJgPP for <linux-btrfs@vger.kernel.org>;
        Mon, 27 Mar 2023 14:51:11 -0500 (CDT)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4Plk2l4CgZz9wTC5
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 14:51:11 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4Plk2l4CgZz9wTC5
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4Plk2l4CgZz9wTC5
Received: by mail-pf1-f199.google.com with SMTP id i7-20020a626d07000000b005d29737db06so4781120pfc.15
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 12:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google; t=1679946671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+1gszN0Ti5RSlLDEj691jdf2nHt6WRImNSYcdJ2Smw=;
        b=afgGl2jCY3S3Duxbcv+VmqiKzeZGonMsOjmOrsZ7RPC8WPaZkKpiUuadUr60BZsqu6
         /cqSPduWs/aFak8T4o/KLPxEOa2wl5U36IgZbd3Jo1EFG1vTN0Mc+7CeEtVUaibvEuVy
         OUAXyHqdPcj/HOkmU8BF4jiQhk84VJyEkAluCBEtuq7JUgq2u57vOSmzmBn5roeNk9j/
         gfP3Rlu01yS6Ndvyt+g6DvLkni3g70Oo/64QU3HIdYyda9sn2K5h837L6H4a3TnlJWqU
         D24vPGcLihC8lgW/5bPmD932UrTp9m+h12ikoGo+ntPwFh9/oQqaBDOCp5qvLqlP9C/V
         fCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679946671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+1gszN0Ti5RSlLDEj691jdf2nHt6WRImNSYcdJ2Smw=;
        b=4yuduSg44CNZA0aw73hXsgJ8RC10L6TFgT0a7GJFnrul4quASGZ0F17U/FHRYVpVJd
         e5IUivi1DIXhWqzKsKpZjmfgdntg3c17iXdhVqgG4mF6luByyzsu8j2EaLMxC/58KAE7
         4Y+wmj4CZGgHrs41v/bJp+qXuoUAGpRA59oQgolnMWQs9R50nAg9brninAs+W4YCjaED
         9Br1cHyqMQU5H6hqcyZmtjz/zra990P2dx2DCpuginIgwcpBrKJUeZwOHqfL/o2ZFrT1
         KgFCbYf47k0MFxp6/Vg3OC82WvI2WxfIp6A3gXDw8QZtHhkQJt6jnsmG0cFewXOsLJ6c
         twWg==
X-Gm-Message-State: AAQBX9fJvaN1G//2OwT90KBBjnVFFPoT+ECszG9KHnu19S3FVBMFPK7k
        GtRisw0BnilTPK4Xz3cqwMpPIC1VqsjR4c3jvliwi2r0APahg7toZQCKUoGwpzr6m6dGEOjnOdA
        F7KTT2aPEp9d+qYaCKt2G94bms8W1le3dveQOh8Ah0LA=
X-Received: by 2002:a05:6a00:1488:b0:623:8a88:1bba with SMTP id v8-20020a056a00148800b006238a881bbamr7113701pfu.2.1679946670883;
        Mon, 27 Mar 2023 12:51:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZYLSkwpzMAdfHhoVRKnG/O7F8p1wEd3VO3R31rHr6m+kgH/PuN5XZdx4OXJ8u2awqPnB4NuVAnqdD1einVZx8=
X-Received: by 2002:a05:6a00:1488:b0:623:8a88:1bba with SMTP id
 v8-20020a056a00148800b006238a881bbamr7113695pfu.2.1679946670616; Mon, 27 Mar
 2023 12:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLfK3WuXuVKxH4dsXGGynwkMAM7Gd14mmxiT2CFYEOFbVuCQw@mail.gmail.com>
 <ffca26e0-88e8-1dc7-ce67-6235a94159e1@gmail.com>
In-Reply-To: <ffca26e0-88e8-1dc7-ce67-6235a94159e1@gmail.com>
From:   Matt Zagrabelny <mzagrabe@d.umn.edu>
Date:   Mon, 27 Mar 2023 14:50:59 -0500
Message-ID: <CAOLfK3UZDNO_jSOOHtnA+-Hh-V6_cjsL36iZU0a+V=k80KDenQ@mail.gmail.com>
Subject: Re: subvolumes as partitions and mount options
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 27, 2023 at 2:25=E2=80=AFPM Andrei Borzenkov <arvidjaar@gmail.c=
om> wrote:
>
> On 27.03.2023 21:48, Matt Zagrabelny wrote:
> > Greetings,
> >
> > I have a root partition btrfs file system.
> >
> > I need to have /tmp, /var, /var/tmp, /var/log, and other directories
> > under separate partitions so that certain mount options can be set for
> > those partitions/directories.
> >
> > I'm testing out a subvolume mount with the subvolume /subv_content
> > mounted at /subv_mnt.
> >
> > For instance, the noexec mount option can be circumvented:
>
> "exec/noexec" option applies to mount instance, it is not persistent
> property of underlying filesystem. It is not specific to btrfs at all.

Agreed. My email was more about subvolumes and the mount point has the
"noexec", but the actual subvolume doesn't - so there exists a path on
disk where folks can exec the same file by circumventing the mount
option by directly invoking the full path under the subvolume.

>
> bor@bor-Latitude-E5450:/tmp/tst$ ./bin/foo.sh
> Hello, world!
> bor@bor-Latitude-E5450:/tmp/tst$ mkdir exec noexec
> bor@bor-Latitude-E5450:/tmp/tst$ sudo mount -o bind,exec bin exec
> bor@bor-Latitude-E5450:/tmp/tst$ sudo mount -o bind,noexec bin noexec
> bor@bor-Latitude-E5450:/tmp/tst$ ./exec/foo.sh
> Hello, world!
> bash: ./noexec/foo.sh: Permission denied
> bor@bor-Latitude-E5450:/tmp/tst$

Agreed completely.

If an attacker can gain access to a system, I'd like /tmp to be
mounted "noexec".

The attacker can execute the foo.sh via /tmp/tst/bin/foo.sh even
though the bind mount (/tmp/tst/noexec) restricts the executing of
programs.

That seems to be the position I am in right now with subvolumes as
opposed to an actual partition.

If I create a separate partition for /tmp and mount it noexec, there
is no backdoor bind mount where the attacker can execute programs
from.

It seems mounting subvolumes works similarly to bind mounts - is there
a way to mimic /tmp being on a separate partition and mounted with
noexec using subvolumes?

Thanks for the help!

-m
