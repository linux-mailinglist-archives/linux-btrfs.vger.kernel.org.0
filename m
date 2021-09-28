Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBCC41B6B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 20:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242170AbhI1Syw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 14:54:52 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:49200 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhI1Syw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 14:54:52 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 14:54:52 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4HJpMx52Sxz9vlRv
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 18:45:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 63eMMwArNT4M for <linux-btrfs@vger.kernel.org>;
        Tue, 28 Sep 2021 13:45:01 -0500 (CDT)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4HJpMx3Dwbz9vlRg
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 13:45:01 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4HJpMx3Dwbz9vlRg
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4HJpMx3Dwbz9vlRg
Received: by mail-qt1-f200.google.com with SMTP id 100-20020aed30ed000000b002a6b3dc6465so95612249qtf.13
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 11:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=K/MVmXrNRxudS00qy3MpILzmC0YWAswl6S2Ayxm9mTc=;
        b=V59RsRhYIEIJLwr4DlkulX7FQCR8O477LDVpuNmYssTvphCN4vCCIpXGOrhBuDv+wg
         Q97P7WIPA87Dk4RH3pPRRghOfhYoVitj0NVkohEKWgyyeHaBLN8BmkmbsCNRgf7/LDiE
         x0fX/nTKlZqltcFeULrX8Q+5kCGvv78CL8guF4oMCY4DUip3q2ko0f0uv0cUcK8kFN8j
         S2iiSz4WFfCYMy9jzic8yIaQ+vsXMlpthPkPCl4o0xAdy4tjDc3gp4RRxxGswgbvjR2M
         SzTb4QdVcCSR+3E656fm79W6hr73s1XHpRe6+Bo+q8VwjImgw4t4lJeYgrpdTNJ3u5Ej
         pySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=K/MVmXrNRxudS00qy3MpILzmC0YWAswl6S2Ayxm9mTc=;
        b=vAG1qaOEIsJSWFTUvXX0WVFvmMFaNj+cAUo/QmZpAAhyWtg8ryVDV4z4IdENgtj18I
         rRD8+qSA1xBT9XCdsxBXT3X04qmM4roF1DV50KS6ikaF7CCkHinCJ12B71g45mophRv1
         fCkLqeYTPO4v46i63omudskRupYipUiPIM653pLQoubbxL4GkUrzVaTF0MrYKa1FiUbJ
         ITeTQQTSy+w9HIFmcdNlWQwiRAZlZAvMO/qGW44WERCWuFRjK2MS599Pd0k6xuUY5OM9
         XCHxtj2X+Ent+VZ3ZtkhYKFbPIFRCb0HK0DZtK4ByGjjHHxPg0I1MV+ytCyExeHJJtuG
         9L7w==
X-Gm-Message-State: AOAM533Htqw4GdGr4uuJN+U02yylJU5aCmq5Vw9fz6ikCTaSJtSm1qT6
        Zbren4Tvx2CnpUV/pM08hHPgGdJZGhRljYpclNdgNfxJxWIB77JaWseSbWJNUKVYZdh60Zjw1nu
        O6h6QJCz7TtAA7gUP9WwcWvbssFYTma6l9bXK2+CE8PE=
X-Received: by 2002:ac8:1386:: with SMTP id h6mr7608731qtj.36.1632854700737;
        Tue, 28 Sep 2021 11:45:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwfJGZJUZWpaUEm2EzxPsQ8Xz9RE8xMF50U8i0OKXM8d1EMh5ugxlYjZeKMl0SRa06KsTJpERQQmom41Mn4Qc=
X-Received: by 2002:ac8:1386:: with SMTP id h6mr7608710qtj.36.1632854700488;
 Tue, 28 Sep 2021 11:45:00 -0700 (PDT)
MIME-Version: 1.0
From:   Matt Zagrabelny <mzagrabe@d.umn.edu>
Date:   Tue, 28 Sep 2021 13:44:47 -0500
Message-ID: <CAOLfK3VL5P7uAPAqvaRHv5gcoT5hdVqkSR5Nz+hTcb=FRmj9ZQ@mail.gmail.com>
Subject: unable to mount disk?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings btrfs folks,

I am attempting to mount a filesystem on a (likely) failing disk:

$ mount /var/local/media
mount: /var/local/media: wrong fs type, bad option, bad superblock on
/dev/sdb, missing codepage or helper program, or other error.

excerpt from dmesg:

[  352.642893] BTRFS info (device sdb): disk space caching is enabled
[  352.642897] BTRFS info (device sdb): has skinny extents
[  352.645562] BTRFS error (device sdb): devid 2 uuid
bf09cc8f-44d6-412e-bc42-214ff122584a is missing
[  352.645570] BTRFS error (device sdb): failed to read the system array: -2
[  352.646770] BTRFS error (device sdb): open_ctree failed

Is there anything I can do to attempt to recover this hardware issue?

Thanks,

-m
