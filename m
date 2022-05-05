Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E9751C3ED
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 17:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiEEPbY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 11:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbiEEPbX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 11:31:23 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628112182B
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 08:27:43 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id m6so5092076iob.4
        for <linux-btrfs@vger.kernel.org>; Thu, 05 May 2022 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lzRwkTW/eZ1T6OtJRC0/Yus3ciyzq8YKNzhcecJFZU=;
        b=YB7T3UsTeSsWEN6M+0IIMP3W4KbZjPR5BJR0Pc9EnYGHiscgZVomLNeikcTKg7lA34
         M9Qbp6s/gR585L0N3gQO4RRLJErNby+HG1muqUXQNSpXkF0M/maBSaiGniKYnvLVajJQ
         45twV2GphF6iqGM4FepOHE9Hkds8IPvsA0r46sFBDBv5AMujPEdgd4H5ncOgU/52IDRg
         /z1e4/QgfEj49ua6Hoq3w4SV7nV+ZGl+F23pKp8yrDdJjZANoAwo8SzjtS5KyZSw1ZRi
         7Q5xGJ6NA2C5CHBbPHAw/AjkXk8lkMoyl+tOKw4/UslBul7YXMX3sub5GJ127CRFy445
         3XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lzRwkTW/eZ1T6OtJRC0/Yus3ciyzq8YKNzhcecJFZU=;
        b=ikIk4sIbHfb7RFYuATd+FCeR1fOeWp7IhAmR45FmwxZcqpOPGkCTQnfaGE3PrGwRXs
         U0mpkMn5YbXcJNCuZKqcok6qJQNo/zDDrmj8RUaKs5U5iD30UpPZc5rBxoe8Rc+doPy+
         LGrflCE/C8KXkkWP8kMZNQhkcxB8efhxIUAZ/QI69vPPHlu4/FcyG974R09l8abTUuXh
         TDYCpq0gmImpE0AYej86vVyUz08AqmRYLiRVZPbH15TI5GZKivrvdknh1sghMxPLm+sA
         jXslZnmejvaML8k84Bcz2K5G/CoFdYY0Q9tq+S6x9aAfZlhAJcP+BLzJB2cX9zjsBCD1
         NO8A==
X-Gm-Message-State: AOAM533jyEv+TSXMBpxB5qhZM7ja5g6RVlBNGWMnRuUzs2loVZYTv50t
        AKFaZcmDUhCpre5MU1XQlKBZUW88JmxIJBr5J7CNLqyjQbg=
X-Google-Smtp-Source: ABdhPJyns4Ier95MU0ZSmThNKraD4mmbKQMKxmhRDUsiiI82H4IfcNk7Frx+fTACXNmxA9L9snY7IyDNKke6BsyQueA=
X-Received: by 2002:a05:6638:30e:b0:32a:f864:e4d4 with SMTP id
 w14-20020a056638030e00b0032af864e4d4mr11373705jap.218.1651764462726; Thu, 05
 May 2022 08:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqeHSCGrOZuUs2XSXAhrHvFbUiWmAkG_hRUu49g7nQ8K8w@mail.gmail.com>
 <20220502234135.GC29107@merlins.org> <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
 <20220503012602.GT12542@merlins.org> <CAEzrpqdth9sKazxbiUhmuH7BTayzzsFGzfEDMpdd0ZOQ6C_GYw@mail.gmail.com>
 <20220503040250.GW12542@merlins.org> <CAEzrpqecGYEzA6WTNxkm5Sa_H-esXe7JzxnhEwdjhtoCCRe0Xw@mail.gmail.com>
 <20220503045553.GY12542@merlins.org> <CAEzrpqdegGAkJmdpzqeLJrFNwkfkMMWEdFxkVQnfA0DvdK5_Zg@mail.gmail.com>
 <20220503172425.GA12542@merlins.org> <20220505150821.GB1020265@merlins.org>
In-Reply-To: <20220505150821.GB1020265@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 5 May 2022 11:27:32 -0400
Message-ID: <CAEzrpqfx3_BxSFPOByo5NY43pWOsQbhcCqU1+JqGAQpz+dgo7A@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 5, 2022 at 11:08 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, May 03, 2022 at 10:24:25AM -0700, Marc MERLIN wrote:
> > doing the longer one, will report back
> > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check --repair --init-extent-tree /dev/mapper/dshelf1
>
> Still running, it would be lovely to have a percentage of completion on
> this one too :)
>
> Repaired extent references for 331055104
> ref mismatch on [331071488 16384] extent item 0, found 1
> tree backref 331071488 parent 353419264 not found in extent tree
> backpointer mismatch on [331071488 16384]
> adding new tree backref on start 331071488 len 16384 parent 353419264 root 353419264
> Repaired extent references for 331071488
> ref mismatch on [331087872 16384] extent item 0, found 1
> tree backref 331087872 parent 353419264 not found in extent tree
> backpointer mismatch on [331087872 16384]
> adding new tree backref on start 331087872 len 16384 parent 353419264 root 353419264
>

Sorry Marc I was busy with the conference and completely misread what
you did.  Cancel the btrfs check now, and then do

btrfs rescue tree-recover <device> // This should succeed without
doing anything but just in case
btrfs rescue init-extent-tree <device> // I'm hoping this will succeed
this time, if not of course tell me
btrfs check --repair <device>

There may be some things left to delete but we're just about there.  Thanks,

Josef
