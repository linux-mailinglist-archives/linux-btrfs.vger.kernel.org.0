Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D97B24A9EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 01:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHSX1Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 19:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgHSX1P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 19:27:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBBEC061757
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 16:27:15 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id x5so34955wmi.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 16:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=rhKznv8+FvaPHilSeotJQzhWjUvKmqTIZl3VYhttBq4=;
        b=Mxk3SkmTIz7TSkzr7WSqZEyKWTSmcqGroFVc+FGMwIyIgI79B6zFn8chqdHhSWW3wv
         3VHFtqUfwLT7Pa122M+mxukU+bHcw8sUZ2rHpmgCYNcoEFTXRWYZBMXF2a5/6IhyC0J0
         xna9fO1c3MC0LLx99pD+rzXDqQafE4bpCOkaiQxOpCUMEXkQZTdnbCQ69PIvPQnt0WAT
         Xtlb/SMrdeEMO3E857JnKaKi4N7Wrp4cw8uTbc3Egt+vWEDcDfv9UHxPYNFUqClFhZT1
         RoyJYw9FiSbVvolfF+iZ1f1m3IT7clmmOzlspVLTGYlF8YB6MaQ60sochERYt6W83HFx
         nmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rhKznv8+FvaPHilSeotJQzhWjUvKmqTIZl3VYhttBq4=;
        b=JkuXi8W7TC1b6wljvuGRSnL9YJnnWuaA87ZgZY1Fn4haNMrYbKrBb+HjI08U7pavHu
         quSzcY+3ANnVJZzPpYoQx76vgRUSAn6MsmEfc7pU1jCYw8qRyyjBDOTLGvUgqR7gj+Mz
         DRYMy7MsYoo+5z55CCFI+De9VOFJp6QWeApiDkgcX1UU89gJmSVcb9l4vV4BmXo/OGJD
         nQbwWdterkCt4NYkyWtGUhos6J31EdSna0WgpP4N2o/B19azZTUUx/cI9VaUv2nFl+cz
         gN9b4FUnwebJZg9331jcnFXt6SAaPHTXafKDvVu87Fk0W98Kl04jvV6+9UDNr7o49loB
         zihA==
X-Gm-Message-State: AOAM530YOkCSHhvMuzkU2yrSDxm138WCanDam9eGmkwgayRm+5SNFqGH
        K7oamqWCpgjX/AU8OIypOy1O8X9AWuK78iHliG39MIrUtdhpKH9u
X-Google-Smtp-Source: ABdhPJyQifFzixb4v5Kaalfv7KRNJ1K7YSpOoSjpVIXzF5nb/b3YywrF2+O97k74NPxBw5p1+HGO2IBfgWV+fAC/XfU=
X-Received: by 2002:a1c:e0c2:: with SMTP id x185mr579552wmg.124.1597879632975;
 Wed, 19 Aug 2020 16:27:12 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 19 Aug 2020 17:26:35 -0600
Message-ID: <CAJCQCtQQHCu8qy-rn=1HU9Mby6VgThbpNOBDn7LqZ+RkguSANA@mail.gmail.com>
Subject: 5.9-rc1 kernel scrub exits 0, but progs reports it was aborted
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are multiple problems with scrub with this combination:

5.9.0-0.rc1.1.fc34.x86_64+debug
btrfs-progs-5.7-5.fc33.x86_64

The simplest one:

[101728.012329] BTRFS info (device loop1): scrub: started on devid 1
[101728.832029] BTRFS info (device loop1): scrub: finished on devid 1
with status: 0
[root@fmac libvimages]# btrfs scrub status /media
UUID:             c0cd2b08-c550-4a03-9960-2e4865b97d64
Scrub started:    Wed Aug 19 17:20:52 2020
Status:           aborted
Duration:         0:00:00
Total to scrub:   3.85GiB
Rate:             0.00B/s
Error summary:    no errors found

Consistently it's reported as aborted.


When problems are found in an earlier scrub, also with exit 0
completion, 'btrfs scrub status' reports aborted but also says no
errors found even though they were found and fixed.

[101533.811248] BTRFS info (device loop1): scrub: started on devid 1
[101534.667318] BTRFS info (device loop1): scrub: finished on devid 1
with status: 0
[101567.638306] repair_io_failure: 546 callbacks suppressed
[101567.638315] BTRFS info (device loop1): read error corrected: ino
256 off 0 (dev /dev/loop2 sector 4076824)
[101567.638340] BTRFS info (device loop1): read error corrected: ino
256 off 8192 (dev /dev/loop2 sector 4076840)
[101567.638387] BTRFS info (device loop1): read error corrected: ino
256 off 12288 (dev /dev/loop2 sector 4076848)
[101567.638396] BTRFS info (device loop1): read error corrected: ino
256 off 20480 (dev /dev/loop2 sector 4076864)
[101567.638422] BTRFS info (device loop1): read error corrected: ino
256 off 24576 (dev /dev/loop2 sector 4076872)
[101567.638438] BTRFS info (device loop1): read error corrected: ino
256 off 28672 (dev /dev/loop2 sector 4076880)
[101567.638620] BTRFS info (device loop1): read error corrected: ino
256 off 32768 (dev /dev/loop2 sector 4076888)
[101567.638628] BTRFS info (device loop1): read error corrected: ino
256 off 36864 (dev /dev/loop2 sector 4076896)
[101567.638636] BTRFS info (device loop1): read error corrected: ino
256 off 40960 (dev /dev/loop2 sector 4076904)
[101567.638640] BTRFS info (device loop1): read error corrected: ino
256 off 45056 (dev /dev/loop2 sector 4076912)
[root@fmac libvimages]# btrfs scrub status /media
UUID:             c0cd2b08-c550-4a03-9960-2e4865b97d64
Scrub started:    Wed Aug 19 17:17:37 2020
Status:           aborted
Duration:         0:00:01
Total to scrub:   3.85GiB
Rate:             1.92GiB/s
Error summary:    no errors found


I don't know what the 'repair_io_failure' is all about. This is a 2x
device raid1 on loop. The loop backing files are on btrfs, nodatacow.



-- 
Chris Murphy
