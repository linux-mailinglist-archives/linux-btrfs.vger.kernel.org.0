Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B22667C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Sep 2020 19:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgIKRvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 13:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgIKRvQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 13:51:16 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D68C061573
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Sep 2020 10:51:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m5so7151040pgj.9
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Sep 2020 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=vZfa69IbjWieWe7vh7bX50tqf8UQuznZiHw0grJWjC8=;
        b=bE1kM8EQBjIbLrAu3+sL/DdZcBRyX6qU7Yh4YZZR+Wrsh0TK0me+MTyCKLfOvrS3ir
         bm7maGzIoT8x/xcyg5ijxbEc90xzCuZ6H8KFTuTNYoLQdx66eNgr40IycqsdALKvJv3i
         iQw4SVqbnLBqwK+WKz9DGCOx501ojkEYUfjfzKVQ7WDggjiLMIBjrkv+If/EjV68Srrg
         6zWiutQMR2+LhtpkZiPCCXjLm2uYGOxZNE3QCCMyVM5SOIlcq++Ir9IACyaG4kTxak2p
         ygRzFVgyVaVKfX7nTY/da6YheWvHgHj50RzwABM8SCOROHSNmGkGgYJVK1JfE9X6iCPD
         Cy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=vZfa69IbjWieWe7vh7bX50tqf8UQuznZiHw0grJWjC8=;
        b=GjgcDx0eq+OlRdldWYCghEJ84QgepLfQlPl2tTGrxtBlTiY3Rc4umiAikSs2/ERL+r
         euhFDnI2e5iEPLtS0mpkk4fll0ZsIkIFcr1VLDcdSVH9HOeqbQ4EL2Unz3RnqgVceOVO
         hXf8Ur62hKZkAmzTSHxo/Bi+YhsYund7mMQx4pfzn9ez58BTaK9q8yReR9A2YOuTBqt+
         EevFIfDFryvpkyl0quQPJvNuf45mEODZ5VwOsvV89aY8IXx+cbGbi2XGdu/3NDxClopm
         ZhrB5V7SdjVCkqHKzyQ3wOlqTpxcZBmytj/IkKLXqZQxVfdv1k9MutbnfbEBFRcy27OK
         VamQ==
X-Gm-Message-State: AOAM533AbnRWH8K1a9BSc51xKzMlhOaV4JXki3M6VJzrwJq3PRd/aac6
        cVf3/2XBYQ1CzHVJzXiOHXSgmZz+cEJOQg==
X-Google-Smtp-Source: ABdhPJyJSfHKAB70a6Dt6oxWhfu9C5jjaVjH4GApEd5sL2enjZC7OcJt0P2Urm+iFy0sP6h08blnxg==
X-Received: by 2002:a62:108:: with SMTP id 8mr3227087pfb.36.1599846675362;
        Fri, 11 Sep 2020 10:51:15 -0700 (PDT)
Received: from [0.0.0.0] (tunnel595741-pt.tunnel.tserv22.tyo1.ipv6.he.net. [2001:470:23:8a4::2])
        by smtp.gmail.com with ESMTPSA id v26sm2331321pgo.83.2020.09.11.10.51.14
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 10:51:14 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Zhang Boyang <zhangboyang.id@gmail.com>
Subject: Not all deduped disk space freed?
Message-ID: <66ea94f5-ba6b-da68-7d6b-c422b66f058d@gmail.com>
Date:   Sat, 12 Sep 2020 01:51:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello all,

The background was I developed a btrfs deduplication tool recently, 
which was opensourced at github.com/zhangboyang/simplededup

The dedup algorithm is very simple: hash & find dupe blocks (4K) and 
ioctl(FIDEDUPERANGE) to eliminate them.

However, after I run my tool, I found not all deduped blocks turned into 
free space, and `btrfs fi du' [Exclusive+Set shared] != `btrfs fi usage' 
[Used], as below: 2932206698496+945128120320 is far lower than 4119389741056


root@athlon:/media/datahdd# btrfs fi du --raw -s /media/datahdd
      Total   Exclusive  Set shared  Filename
4369431683072  2932206698496  945128120320  /media/datahdd

root@athlon:/media/datahdd# btrfs fi usage --raw  /media/datahdd
Overall:
     Device size:             8999528280064
     Device allocated:             4144710549504
     Device unallocated:             4854817730560
     Device missing:                         0
     Used:                 4138705166336
     Free (estimated):             4856449110016    (min: 2429040244736)
     Data ratio:                          1.00
     Metadata ratio:                      2.00
     Global reserve:                  75546624    (used: 0)

Data,single: Size:4121021120512, Used:4119389741056 (99.96%)
    /dev/sdc1    2559800508416
    /dev/sdb1    1561220612096

Metadata,RAID1: Size:11811160064, Used:9657270272 (81.76%)
    /dev/sdc1    11811160064
    /dev/sdb1    11811160064

System,RAID1: Size:33554432, Used:442368 (1.32%)
    /dev/sdc1      33554432
    /dev/sdb1      33554432

Unallocated:
    /dev/sdc1    2429196152832
    /dev/sdb1    2425621577728
root@athlon:/media/datahdd#


That's quite strange. Is this an expected behaviour?

Thank you all!


ZBY

