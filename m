Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3F852D230
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 14:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbiESMNk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 08:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbiESMNd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 08:13:33 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD55C6D193
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 05:13:29 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u7so5280366ljd.11
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 05:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWndpxvibkJrXEeB9baq9OY5IPtGADtY92+FMPR78JQ=;
        b=Rqj3NGIx4ISHLfSILmG9HRMiOLBcfcfBz3RXaNRYk14ADC/deaYEsmylidD+F/NJ+/
         FalU0Am93MQ4+0PNwC6YuBg5nJ+hdqk8e4y2yHvewAPNgBHx+z36iQNFTcsZ2eevsE6Q
         Wg6lQ7aSyJzWgCjbw4v42F/bqnNAK7HP6EQVFf8FuuNvvL6UCS5LzkTuqpukqwQtOc26
         sXwus1VeCRQxhEPPR3BPRdoCaWG9WHZvCNgHaSfyZAWmbIag8UHd3rn29PjkTfxFCYFO
         ZAJCfUOYjtC40Q3Deuva8uVvxvxEX2thWZlKkMUr2x41MHzvZ7Zr7HBfiMs3aTdFB7sy
         qHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWndpxvibkJrXEeB9baq9OY5IPtGADtY92+FMPR78JQ=;
        b=1cuV9Ii5H8xCrhhZvZdgfTkPKxzWwAQdNAfVwQEYXRsPT1SynuyngJ+R1z/60megeE
         qJ3pcEJVkgLRkByqlvOrmhy427m6sk1rU2zECUV2EwN+dP+qXAn7/sNksLxmMLtbaGyt
         SQi7+lGa9p3+x0dLsgb9d5dN+ycHl2ea1LlpooE3dUYeHcHBrjALXt0F+FFxRHretaWz
         UiKC+fU16cEA+HOoZBcNSmmG4c3Pt3Mgr1Cp18JxZVswbw868tGHD0VkaMB9bFPIx5ko
         mtLxTcThnZaZxT66cjGI6ilQ23rqk7T58ohpjO57Ereb36u2WfQHCBIbwUJHq1IDCKdi
         hu+Q==
X-Gm-Message-State: AOAM530yMqcL/kIxIXMkAozCeLFRCd1Z9jTZD/5vRlJubgCBZGmrS713
        7CDucAitYDk8a37jxkK5o02uZjwsjwA+Yl/DzMe0D9YAZl8=
X-Google-Smtp-Source: ABdhPJxd7t5bE3SnK7XJvd3WIh8kWv14UluE2BJGija1/jG3+ab2PHHbt3i1s7BxM/cCE/QdFUJNZEKhskSngmOJ2TM=
X-Received: by 2002:a05:651c:160b:b0:247:f955:1b18 with SMTP id
 f11-20020a05651c160b00b00247f9551b18mr2555853ljq.427.1652962407611; Thu, 19
 May 2022 05:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAK1hC9sdifM=m3iH7YVh6Cd1ZKHaW69B+6Hz9=aO_r1fh3D7Tg@mail.gmail.com>
 <275444b7-de43-d0b5-dd4b-41670164e351@cobb.uk.net> <CAK1hC9u_9w5K6Mz=k+AhzjNcZ4N_7fmaDtrLqVSpM3ttb46muQ@mail.gmail.com>
 <f7bec7f0-3dc9-e34b-fcef-81ff2757cb36@georgianit.com>
In-Reply-To: <f7bec7f0-3dc9-e34b-fcef-81ff2757cb36@georgianit.com>
From:   arnaud gaboury <arnaud.gaboury@gmail.com>
Date:   Thu, 19 May 2022 14:13:08 +0200
Message-ID: <CAK1hC9v4MYaOLzqFvhyP3LVdNHuX=DzyuREdKbhOtWkN5bhiaA@mail.gmail.com>
Subject: Re: can't boot into filesystem
To:     Remi Gauvin <remi@georgianit.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 19, 2022 at 2:08 PM Remi Gauvin <remi@georgianit.com> wrote:
>
> On 2022-05-19 7:36 a.m., arnaud gaboury wrote:
> > I take the opportunity of this thread to find a solution on my initial
> > probel: how to use an external device to store the backup snapshots?
> > 'btrfs subvolume snapshot' command will not allow me to store on
> > another device. So my idea was to add the external device to my btrfs
> > filesystem.
>
> That's not how snapshots work.  Snapshots do not create a copy, and are
> by definition, not a backup.
>
> If you want a backup with snapshots, you can create a new, separate
> btrfs filesystem on your external, rsync your filesystem to it (with
> --inplace option), then create snapshots on *that* filesystem.

the external device is on a btrfs filesystem, and for sure I can mount
it under a /backup directory.
I will do this with btrbk tool.

>
> Alternatively, you can use btrfs send and btrfs receive to send your
> snapshots to the external.  The idiosyncrasies there are a little more
> complex, but it will be much more space efficient when files are
> renamed/moved.
>
