Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5ECC24A7D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 10:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfEUIey (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 04:34:54 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:42053 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUIey (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 04:34:54 -0400
Received: by mail-qk1-f180.google.com with SMTP id d4so10508369qkc.9
        for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2019 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=qf6g+IrKMjQYaWYd7OR0jNaLXUEknKW0oXr6oMkM1lQ=;
        b=WU/h8HSeNuh6luRJUrApcaHpn3GFStbiJLORXnkabBHUn7PBs69lUu+aL1skUDrmz0
         GHv+P2Pcj6sI6anucaO9adSd2BSaIqmosiKl5PKvo+v6IXbQdh+2k7wGd3C0m15dOS2U
         Z6fg6DmCPuv0NnfE98ALqFCPvYPVmsE6VJYf0+n39h5VVfo0zL75G7k7WhpJm4NQkxM+
         KXCQokUjJvbAFhvCTSV+CY7jd/byACSVMfTfzs10izxFxB0Mt2LuDPGpDECi/5Nwe295
         JTdEJVlGHW242sop/MKmvKP/Pi9YLVzSD7KSbWfvB5erpPAJQz48jHRDAyoZT6WdVoYJ
         9h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qf6g+IrKMjQYaWYd7OR0jNaLXUEknKW0oXr6oMkM1lQ=;
        b=AQ+Rd2E1VGJH4/XhOoTYML9djqAFRz2dShLDQD9RT6XrkvR9VsneYFpFzvU2KyKVkq
         uKhfnbIJ/Cxmj3Myh+YQ/njTeMLcyldBkdFcHxM3gSkFyv96ePvPQNYr2XccUlZNolfn
         Scc+dd3/dg/1lRwlrra+JPty9DTpdhvSLS+x3DNCG3pf6RSzRp3V5Fxizp9ac/jLW7nX
         zYCp9kXqb1IruiGS7LSYONPMIR1GyFtA5poAxp+45y2lR55o23unuddgVxDwJdqEh9Qz
         wuWWBxe5PK18mVjXAiG2gGriHF1Ob9zyN41yXJGZFqbQHLgxxE2lr5oF6QwuxHb6tnLX
         Ag9A==
X-Gm-Message-State: APjAAAVuusQS3c8aTfWpZwKoaLJrMyyts6mSNBGi2d+OWH5KWjL+Qdd0
        4CcSQFTncIrb3vpJM2KIfEsMC5At2fxGC2RGW/NvhVH6UKpgrw==
X-Google-Smtp-Source: APXvYqyMxLVBD0N5RwNxg/N8B5WwvVZucnP24S/shH1k69tF0MeZBlTbEZQdOYpQvPNInislNuM7vGjn3GfQWjEehuw=
X-Received: by 2002:a37:f50d:: with SMTP id l13mr41055470qkk.13.1558427693188;
 Tue, 21 May 2019 01:34:53 -0700 (PDT)
MIME-Version: 1.0
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Tue, 21 May 2019 01:34:42 -0700
Message-ID: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
Subject: "bad tree block start" when trying to mount on ARM
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a 5-drive btrfs filesystem. (raid-5 data, dup metadata). I can
mount it fine on my x86_64 system, and running `btrfs check` there
reveals no errors. However, I am not able to mount the filesystem on
my 32-bit ARM board, which I am hoping to use for lower-power file
serving. dmesg shows the following:

[   83.066301] BTRFS info (device dm-3): disk space caching is enabled
[   83.072817] BTRFS info (device dm-3): has skinny extents
[   83.553973] BTRFS error (device dm-3): bad tree block start, want
17628726968320 have 396461950000496896
[   83.554089] BTRFS error (device dm-3): bad tree block start, want
17628727001088 have 5606876608493751477
[   83.601176] BTRFS error (device dm-3): bad tree block start, want
17628727001088 have 5606876608493751477
[   83.610811] BTRFS error (device dm-3): failed to verify dev extents
against chunks: -5
[   83.639058] BTRFS error (device dm-3): open_ctree failed

Is this expected to work? I did notice that there are gotchas on the
wiki related to filesystems over 8TiB on 32-bit systems, but it
sounded like they were mostly related to running the tools, as opposed
to the filesystem driver itself. (Each of the five drives is
8TB/7.28TiB)

If this isn't expected, what should I do to help track down the issue?

Also potentially relevant: The x86_64 system is currently running
4.19.27, while the ARM system is running 5.1.3.

Finally, just in case it's relevant, I just finished reencrypting the
array, which involved doing a `btrfs replace` on each device in the
array.

Any pointers would be appreciated.

Thanks.
