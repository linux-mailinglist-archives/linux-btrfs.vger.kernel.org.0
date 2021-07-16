Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4393CBA3E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbhGPQFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240696AbhGPQFO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 12:05:14 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A139FC06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 09:02:17 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u11so11453993oiv.1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aqj+HQxMss170fHgScPIzxRVe6Om1lfw5WEZgSEmnn0=;
        b=IPcvgjkbAogeKqoh8w+xXSBlYTadcsp2o9fwzsJ5NMoHHyJomX8wwm7BZ6d0hNw4eI
         0U1dlVWL83YLrt/frclBAA+w5BcoT4++MJBQ4XEb3Sqs5XuDWOoetat8IaulCAu7x/T2
         dvjgTikpxU7Q50T3+6hm14eqPDQXsnIiURKfRiSWNN6iSMMlYGb4ESY+F2dzlA7GB13L
         nL7oCosxuKdcexZT3vj86of9J6MKTFj26ZrQNQI8oywUrtIbZVgjSiMMkO8fzIejYBXS
         fnkcZroePb7fe/UGKshGSOAiTS3JR2DtQrmob7afyt22gstSKt2h/KymvJcc7tumzl4s
         6UNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aqj+HQxMss170fHgScPIzxRVe6Om1lfw5WEZgSEmnn0=;
        b=oqzXNOSQTgVFgwKZlCKiFCngQMxj7znzmtXqstshCiKI0sgTWEfOv6Ks8p75f+TYbx
         +m8PSeAl47quSykc010ns9rw3QB8saRDAyNKSe8Zi0XB/KY+hLepU0SUrey+eYqOwXjI
         mnzxs0O19MMPyni1SKugFm33tkFReBB3+nNObv+AywhpNvsJZPNVaKXveyN8XVxhR0TR
         ZZvXeRYHuVu0SEe1lwobVmaZiK4vktsSeIWUvbOcvYNSie9ApvTiUXVoeCs1AHRSkt4g
         kmCzZ28VwucFK19hmq6tJfa506etZ4il8SATzktdyZxrshkDGp0c0T7733iYnSfC6f9N
         Iv0A==
X-Gm-Message-State: AOAM530KJo6Ung3rJDhbnkVJMW1AmmVq3tWlF+5ozKEY+cB3h3snC8xQ
        b2rLmaJ9TwjHqrDUU1lYqfO45jvyF2ESZvvIqDE3vkJoECo=
X-Google-Smtp-Source: ABdhPJz9Pwokm9uLv2g6Cub87/0imh64HSyGTl8Zlus2WhcaEx0Mcr0oHXcDTQSc2tl+DvSZ6yff+Uh5urhzLZl83nU=
X-Received: by 2002:aca:47d6:: with SMTP id u205mr8460948oia.44.1626451336901;
 Fri, 16 Jul 2021 09:02:16 -0700 (PDT)
MIME-Version: 1.0
From:   Dave T <davestechshop@gmail.com>
Date:   Fri, 16 Jul 2021 12:02:05 -0400
Message-ID: <CAGdWbB5Dygauhft3S1nQ=S5E9Xwj4NsXCgQJkUCyacaP18A-PA@mail.gmail.com>
Subject: what are the current best practices for maintaining a BTRFS file system?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am running a rolling release Linux distro (Arch) and many of my
devices run on BTRFS file systems originally created many years ago
(e.g., 2014).

BTRFS has been mostly problem-free for me since even before 2014. The
snapshot feature (automated with snapper or btrbk) has saved me more
times than I can remember, so any issues I have experienced related to
BTRFS pale in comparison to the benefits I have enjoyed from using it.

I would like to know what steps I can take to keep my BTRFS file
systems in the best condition.

For example, in recent days I have been reading about switching to the
"space_cache=v2" mount option and running "btrfs check
--clear-space-cache v1".

Should I do that for all my BTRFS devices? Do I change the mount
options before running the check command? Other than it being slow,
are there any other caveats?

What other steps should I take to keep my BTRFS data robust and error-free?

Here's what I do now about once a month. I step through a balance
incrementally and generally my BTRFS devices reach the maximum dusage
parameter I set in less than 30 seconds. With this approach, my
balance operations never take very long. (The scrub operation can take
a while on large and slow HDD's.)

Does this approach look appropriate?

    #!/bin/bash

    max_dusage=80 #btrfs balance filter parameter for maximum dusage
so balance does not run a very long time
    max_runtime=30 #if any balance iteration exceeds this time, that
is the last balance run on that path
    step_size=5 #increment of dusage and musage filter parameters with
each loop iteration

    check_space() {
            path=$1
            df -h "$path"
            btrfs fi usage "$path"
    }

    balance() {
            echo "starting btrfs balance for $path"
            path=$1
            runtime=0
            dval=15
            mval=15
            while [ $runtime -le $max_runtime ] && [ $dval -le $max_dusage ]
            do
                    echo "starting btrfs balance with $dval, $mval ..."
                    start=$(date +%s)
                    time btrfs balance start -dusage=$dval
-dlimit=2..10 -musage=$mval -mlimit=2..10 "$path"
                    end=$(date +%s)
                    runtime=$(( $end - $start ))
                    dval=$(( $dval + $step_size ))
                    mval=$(( $mval + $step_size ))
            done
    }

    scrub() {
            echo "starting btrfs scrub ..."
            path=$1
            btrfs scrub start -B "$path"
    }
