Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D4E19FE5B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 21:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgDFTrE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 15:47:04 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:40996 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFTrD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 15:47:03 -0400
Received: by mail-il1-f178.google.com with SMTP id t6so699901ilj.8;
        Mon, 06 Apr 2020 12:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nGsbs2a7yXinNzlofEw+863mjB1jB5rZqB8WFUgCZKA=;
        b=RzVCG7Wg7gEXXRF5ZsJkOf7YYI+Uf6XzrJpyGMsP9INdTFzY3tTHVbW+5Fj///KoS/
         jPFctMm1tteGfhpSI8I08HGivlJRJKG41pN4If6KplHnR30IzmW29T7M6MLnT6l/X4F0
         VCPyi/VtHdlXSKtdPyguPh8reNHjCBdRy/FXSXxToMMhUoedfCiTSOSBBZtreNzNjhW/
         dMj0WNpRhLlforQVYjtvcjyUh5zoEywkCeY0Dezg341k7Q8IeJvD6dj61IcZKwKfBxwh
         lkINU+VayYKs8Ueu2P4NcloH3PjoGY2LYvGkG8sVbhhGk8PbodqfGIIltOKWkeK+AqIQ
         OdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nGsbs2a7yXinNzlofEw+863mjB1jB5rZqB8WFUgCZKA=;
        b=RlEZcbur+oSRCrm3ZpJVC4UlGofSHf5SDMa6fQJcYqxJVD65LIOlJkxOyA96ae3atZ
         E67cZenEnJ8PLHWGYZgBCi03+miXfQ8wcS62HzjpCl6xjGmi3DdKaZZhaO7I7g+qtPde
         uabZy2qoP+ByQmPNXN5FQKP4I9rwSuJtlZSWSZF6dV/IYqVCJ++UGW0D5Hqe6xCk/Jy8
         Aa9GrMFa5vYz62GnoRNSEp5uJwB26h6Yfqo8B5LYB0Errt4z52u+9pJ7dGQItuRmiGFn
         fpiAM9oiuSBHo8n90BT51jNh9aGmvxUWCQ9nmUFPpA3RpLy0WQ/c3DjdImpWe2wG0kGD
         HmmA==
X-Gm-Message-State: AGi0PuZ21UcwCbddGk7MWQKqK8MeWXIxisAhsHIpAaMKuBBK7pHY1mOs
        uvf15XA11q5pY0cyOirSExgmFDd0dy71Mb1l49ggg5nlCw==
X-Google-Smtp-Source: APiQypL1DFH0DFa2iqagxrpbY6ST23Tz+OfdvNbX8iqcgfqqevPv/QzrNI/pZNJ7epkEYKU1E4ykdCwL3PbBkD5i6kQ=
X-Received: by 2002:a92:d347:: with SMTP id a7mr1054377ilh.289.1586202422365;
 Mon, 06 Apr 2020 12:47:02 -0700 (PDT)
MIME-Version: 1.0
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
Date:   Mon, 6 Apr 2020 14:46:51 -0500
Message-ID: <CAM2wg3Sqw_a3dwjh6nQn8h-SsyM3v=43Oqce7Eq0U-Jcb7EaaA@mail.gmail.com>
Subject: Strange sync/fsync behavior in btrfs
To:     linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org, Vijay Chidambaram <vijay@cs.utexas.edu>,
        Jayashree Mohan <jayashree2912@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I am Arvind Raghavan, an undergraduate student at the Unversity
of Texas at Austin, working with Prof. Vijay Chidambaram. I've
been working on the Crashmonkey [1] project, which is a test
harness for file system crash consistency checks. Specifically,
we've been working on making a fuzzer to find new bugs, and we
discovered some weird behavior. Given the following workload:

mkdir A
mkdir B
mkdir A/C
creat B/foo
sync (1)
link B/foo A/C/foo
fsync A (2)
<crash>

Running on Linux 5.5.2, upon recovering the filesystem, the hard
linked file A/C/foo is not present. However, if we replace (1)
with "fsync B/foo", then upon recovery the link persists. This
behavior seems strange, as intuitively it seems that sync should
have at least as strong effect as fsync. In addition, it seems
that Chris Mason's definition of fsync guarantees here [2] might
require this workload to pass.

It is important to note that even if we skip the final fsync (2),
the result is the same. Thus, the behavior is coming only from
the syncing operation at line (1). However, we were also curious
to know whether an fsync of the directory A here (2) should
persist the file A/C/foo. Chris mentions [2] that an fsync
of a directory means that "all the files/subdirs will exist".
Should this apply to files created in subdirectories?


Thanks!
Arvind

[1] https://www.github.com/utsaslab/crashmonkey
[2] https://www.spinics.net/lists/linux-btrfs/msg77330.html
