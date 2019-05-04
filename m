Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 737F41368F
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 May 2019 02:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEDAWo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 20:22:44 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:33175 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfEDAWo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 May 2019 20:22:44 -0400
Received: by mail-oi1-f171.google.com with SMTP id m204so96879oib.0
        for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2019 17:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=lIsj6VCHSAXDj4nBUlZ2DuQj0yxwo1fjHVMKjvxdqXQ=;
        b=Do6ABBaswO27YTz+CKNJDLr6DKsxugGrgQryPbSEo5ADpEBeqJn65+5JERXaE3xXZR
         +Zkrok8fO8uQNDNwYIOzfob7n25Jap5yVrPj3X6YTBoCl81Id8PN5P/TPohuvH24QcBd
         v91OIWEMTIV0Qe0NwatYQRve4nA7Rcz08RBcgTrRFcmQP7wwHFZFs1IkyCqjeJSv+dkX
         73lSF9AacgQp2HNqbRIvyrPbOc2uIXrnQmoPeoe/phSMJINqW9bqeYs7JUOE6FgeYmWo
         rJMW4AWREPFQK2JA/mp/dd/bNR8pk9PUJeO0YtglFh63054VSou+xA21WK6gwc0Q7LqZ
         eU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lIsj6VCHSAXDj4nBUlZ2DuQj0yxwo1fjHVMKjvxdqXQ=;
        b=pxBUlt8vOhDIU3rqquNBaWXZCsxRCy+wzHl3+kPHJpbDwTZHYX+NXcGDg+CSHxwXou
         mqazdutMNk1LZoCD3oNGBIWHiYqbzOGP/FOiBs1RP+gIJgRr7GcyC2J8utiJ6zo+Lxox
         oXpx82XXVm2ZuU5S6vhr8Vla9dOXKhlUiAR/U871MHjAUducjcvsW6unnq2RNWXWOtcT
         wBpQdEKH+Bt1kbbOXNRbNBFBP0ao+mdziE5YZ5rma2medOGJtAomcgLRsocWjd3xPA1S
         AyO4iqzmZ0Zv7hH0SNjJgGdF+ld446OJ2+47EftzUK7Phk3HyFcrFgd6arD2F47Rmhzx
         AUbA==
X-Gm-Message-State: APjAAAVua+lvFQO7msYuEtoOeiuC08h834BDvMwgY+MNZIJ4N5ib7NKa
        hkNR70buBL5cLe8PIvKVirXnaTbXkYF3T9dLc6Kzqepg
X-Google-Smtp-Source: APXvYqy0PiNItFwWvdrfs10DAZmlirqgVstKI75bW9dMOzKBftj0Vhs906xkkPygQLVFMhI6MTRfWGkp26v5H8W6uIU=
X-Received: by 2002:aca:d8d5:: with SMTP id p204mr1051545oig.26.1556929363544;
 Fri, 03 May 2019 17:22:43 -0700 (PDT)
MIME-Version: 1.0
From:   Dave T <davestechshop@gmail.com>
Date:   Fri, 3 May 2019 20:22:32 -0400
Message-ID: <CAGdWbB5-iCfWD3NXuNHU+QVF4RWKptkzjyYwX_HteR1wshVV0Q@mail.gmail.com>
Subject: ref mismatch / root not found in extent tree / backpointer mismatch /
 owner ref check failed
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The filesystem has become very, very slow. smartctl doesn't show any
problems with the HDD. My usual btrfs maintenance (balance, scrub,
defrag) did not show any problems -- but did not resolve the slowness.
So I ran a btrfs check -- the result is pasted below. What causes this
and is there any solution other than recreating the file system? Would
the errors shown below make a btrfs filesystem slow?

Opening filesystem to check...
Checking filesystem on /dev/mapper/bak_luks
UUID: 3ac770bc-e7c4-4792-2d2d-1d3ed19d126b
[1/7] checking root items
[2/7] checking extents
ref mismatch on [374849568768 16384] extent item 0, found 1
tree backref 374849568768 parent 6835 root 6835 not found in extent tree
backpointer mismatch on [374849568768 16384]
owner ref check failed [374849568768 16384]
ref mismatch on [374940549120 16384] extent item 0, found 1
tree backref 374940549120 parent 6835 root 6835 not found in extent tree
backpointer mismatch on [374940549120 16384]
owner ref check failed [374940549120 16384]
ref mismatch on [569319473152 16384] extent item 0, found 1
tree backref 569319473152 parent 6835 root 6835 not found in extent tree
backpointer mismatch on [569319473152 16384]
ref mismatch on [569329385472 16384] extent item 0, found 1
tree backref 569329385472 parent 6835 root 6835 not found in extent tree
backpointer mismatch on [569329385472 16384]
ref mismatch on [569516376064 16384] extent item 0, found 1
tree backref 569516376064 parent 6835 root 6835 not found in extent tree
backpointer mismatch on [569516376064 16384]
ref mismatch on [570749665280 16384] extent item 0, found 1
tree backref 570749665280 parent 6835 root 6835 not found in extent tree
backpointer mismatch on [570749665280 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 3655790232414 bytes used, error(s) found
total csum bytes: 3534402188
total tree bytes: 46277705728
total fs tree bytes: 34533392384
total extent tree bytes: 7925743616
btree space waste bytes: 8021706864
file data blocks allocated: 30545889550336
 referenced 31161532510208
