Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC37823C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 01:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfG1XHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Jul 2019 19:07:47 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:34425 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfG1XHq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Jul 2019 19:07:46 -0400
Received: by mail-wr1-f41.google.com with SMTP id 31so59812295wrm.1
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jul 2019 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsJIOMYG1Sj4jo+MyJwxg3Fmu++ClNAN45OODaTU7bU=;
        b=VqjR7YA/Q4w/6vwE0SGsikbOeAsdyUGbfZ/UVOWXAXT65IIU5wvmPiL/4VoQyRhVms
         bqvaDUhTWEpT7yBrGFDtnzu5EDqwu4vuqXzq9D1niT9fRgf/MeWC02n4DtuYtvRtCKog
         cVCKpU23TDLpR9BQ2GIs6LtZnA2oYEEct3lN1AhJMRqGnGZomHHQmGtOalKqY+ImObCk
         R7lOa8cJqTR5mQ6owY+4OuZ6w/lq4v0+xG2q66Wec6xZjxn3dFtvU936hqUOtJ6GL8pF
         CXUqxaqYJ8DCmXadv069ZX68EYcYv46p2rhrEXtw4LxvpwJv95o/XIhQOfZ+zIgQINlf
         AyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsJIOMYG1Sj4jo+MyJwxg3Fmu++ClNAN45OODaTU7bU=;
        b=H7r0pNS1/dLzeFRTYeQ6myQ5RPKd8DurB/O+dq+ZjL4sJtzzcHBuk6sSMgOSN1jBok
         F/ITDOlDDvl4oaNftJTFR6up9n48u/PjyT37Z2BaFdHHX/ro4l1JVQbaVl6wB8GluYEG
         KuziHWVZtns8Ofi6yjD6NqE4x+S9lYrwD2Uwns+v2ofBm9KY4q1giIs79W9R+gLgYaVY
         Dtut9XojYIK8bB83M2KywNnZq2OZXvFctVitL6s0I9xlY2NVaqxIi7ezswXfNeLEA2b2
         GuNfqild/6aZVFUoGt5si42JuCVgSdAiCFtBvOZUgfepn87BDlotPJtU7Z5FQ7jKVdRF
         bXrQ==
X-Gm-Message-State: APjAAAUGk9UneW/8SeY9X7IqKCk0HJfRUbMI4RLzJyxol72DhtpShF/1
        oV6LOcILOqKFthKgbbqtIVBfQp43C7iZkIvrrUvZD+AZ
X-Google-Smtp-Source: APXvYqyhc8pX7zFpKRs6upovfpty0NZYjeJdgTUYU0HLuJN84yOQy+qSltxI/HJztkNVkx3hESZbiKMmdPtkewWpdb8=
X-Received: by 2002:a5d:4403:: with SMTP id z3mr34755124wrq.29.1564355264560;
 Sun, 28 Jul 2019 16:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <1244295486.47.1564331283120.JavaMail.gkos@xpska>
In-Reply-To: <1244295486.47.1564331283120.JavaMail.gkos@xpska>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 28 Jul 2019 17:07:33 -0600
Message-ID: <CAJCQCtR2LaLriC7cxFwxxztWZWEZSx-vJP2YLEwpoJWy7ivgdQ@mail.gmail.com>
Subject: Re: how to recover data from formatted btrfs partition
To:     "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 28, 2019 at 10:36 AM Konstantin V. Gavrilenko
<k.gavrilenko@arhont.com> wrote:
>
> Hi list,
>
> I accidentally formatted the existing btrfs partition today with mkfs.btrfs
> Partition obviously table remained intact, while all three superblock 0,1,2 correspond to the new btrfs UUID.
> The original partition was daily snapshotted and was mounted using "compress-force=lzo,space_cache=v2" so I guess the recovery using photorec would be troublesome.
>
> Is there any chance to recover the data?
> Any ideas or advices would be highly appreciated.

mkfs.btrfs doesn't write that much data, but does zero some other
things out to avoid later confusion so it's plausible some of the
previous btrfs has already been damaged by those overwrites. But if
you ignore that, I bet you can reconstruct the old super and at least
do a read only mount of the previous file system, and at least get a
backup.

The hard part is finding the start LBA for all the roots, and the
physical address for the system chunk so that you can populate the
system chunk array field in the super block correctly. It's mainly a
question of time and effort, there's no tool that can do this for you,
it's pretty much a manual process.


-- 
Chris Murphy
