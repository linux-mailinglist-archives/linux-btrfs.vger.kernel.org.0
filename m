Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE634AEA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 01:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFRXTp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 19:19:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45010 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRXTp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 19:19:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16so1230111wrl.11
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 16:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=judycc9JCc5b1sM4Z6f3RT/e/CT6jTUbCl81hGKinKc=;
        b=vazW5CIkyPs9OJwuaehWdyRFDS6emrDFl819k6CfFtEuuU8j6znGE+G72Iu3c6kgXs
         RsFBfozqGe6agi7nNav1zDDdtAp0+TasVrjztIrcf8CnKLMYCGRj85uqLzSiU4XBzgYn
         LFb9A2cv5NYqRDaRnzxjrDtxs7wuUO2dNGG3m5sjXKh1M+JXoD53hpCk7c8sVnN7rYyy
         EoT8KswEnN4fTkYgEaxgiHmgRLD00AQ5CNDOk2IhByvo/hSqpsSMn+WXnF/b0Pnaje1H
         jU3SfdnEenpNacvqfWD76OeNdNxfzjIApN7lD2LYjBwejKC9GTWIH7bNviYKUlK31xII
         1HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=judycc9JCc5b1sM4Z6f3RT/e/CT6jTUbCl81hGKinKc=;
        b=e33edrjRl+wfIZ8IB6oH65RZkdgCRkQ0vooFqsLMT7zsf0N1JdVjsnvRwCQakQFPLb
         /jLajFb2rgxGg7gguYoVzodB8L0YX00NLd/3NeEQwI98naz02ruuneOuu0oGfCHvtrE2
         tHZ6xGi3OZ7hQ4Roiw2PteuEGcxR92iVIMK3W7R5V7RSvwBapG71l93WPFO9dPeZ0Urh
         3hgNf7OT8ATK1hc/m/EiHuFDQamzrPwrRuahKFQbc6qlB/PWbyDSGQCZ02FIsMX2Ge6P
         Ki5GIhlEJhSXJWvX0Hv9Gns0gVu/dPdAA++DoMf+u+8jgjZPWqcNqv5kpNsRDXPVo6MO
         IdSg==
X-Gm-Message-State: APjAAAVnRtU0ZHYQ0BEZ2JRkWecP7H6gnrjdWra1YrV/0FJP8fRY69vI
        /Fc5Bb5cxdtw/wfYkGnwKkNO5r7LL0XldfZweOhtNi2XsVE=
X-Google-Smtp-Source: APXvYqzQmnAXZ4kfsrzuSPn38W1uV5zHqrUShNAqfL9dBcW21wzePIVUKCpITpW6ylYZ5orAmVXKfCK4AFb+Tk0IJKo=
X-Received: by 2002:a5d:4843:: with SMTP id n3mr31799621wrs.77.1560899983307;
 Tue, 18 Jun 2019 16:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <405184D6-3E29-4308-B2CA-BF5644A6CED7@storix.com>
In-Reply-To: <405184D6-3E29-4308-B2CA-BF5644A6CED7@storix.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 18 Jun 2019 17:19:32 -0600
Message-ID: <CAJCQCtQtpHbe=in8V+-iYCxZhsnRfxpcde0SJkBH-1ajc=e72w@mail.gmail.com>
Subject: Re: "no space left on device" from tar on ppc64le
To:     Rich Turner <rturner@storix.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 18, 2019 at 4:23 PM Rich Turner <rturner@storix.com> wrote:
>
> tar: ./lib/modules/4.4.73-7-default/kernel/drivers/md/faulty.ko: Cannot open: No space left on device

If this really is a 4.4.73 based kernel, I expect the report is out of
scope for this list. There have been 109 subsequent stable releases of
the 4.4 kernel since. There nearly 3000 commits between 4.4 and 5.1.

Ideally you'd retest with 5.2-rc5 since that's the current mainline
that this upstream development list is actively working on fixing bugs
in. But I'd suggest at the oldest, 4.19.52 or whatever most recent
version has Btrfs backports. If it does reproduce with a recent
kernel, I suggest remounting with option enospc_debug to include
additional information; and also include the output from

$ sudo ./btrfs-debugfs -b / mntpoint

The btrfs-debugfs script can be found in upstream btrfs-progs, I'm not
sure if it's typically packaged by distributions.
https://github.com/kdave/btrfs-progs


> PRETTY_NAME="SUSE Linux Enterprise Server 12 SP3"

In the case you can't test with something recent, then I suggest
reporting it to this distribution's support. That's the way it's
supposed to work.

-- 
Chris Murphy
