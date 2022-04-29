Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0AF5140F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 05:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiD2DYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 23:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiD2DYb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 23:24:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F33A8BE16
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 20:21:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t6so9074898wra.4
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 20:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=5vWK0JpfQ+5dEz2CMtNV4odL0R9fmfLG6J7U7Dej0v0=;
        b=C2EYCQ0UOC8OIsuYhp50g7NTB4bupPAquQJfMsQSQl5X2sWeWqV74B9e6paI2tY+hb
         FuJQDD4N7kC97AqUcRn+DJvCjdz/Ggrh/qJUnfDfLZ4veiL9omt76UNx76yImiqQoL9A
         ElS+HCMVJ4psZlvcXtzTclDjaRB5iOo+eFrnZMF0/up2ISdo40bFaCweFt3RE9ZlBPqZ
         9gQ+oAAgELnMFdLHkCWLBiMJLd5mV/MyA+Bd2MgIh/P4+nRPJgXb1Xxvd8FDpX57spOO
         17Hy0o36GQ1bkeNjErhlMoGMonheXOkeyAYJVOhzXdqmGKO1lLivXJ6RI12EPT0X26S+
         xRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5vWK0JpfQ+5dEz2CMtNV4odL0R9fmfLG6J7U7Dej0v0=;
        b=2hx0/cgdVEWzOr5utNVNOENEdQ1ZOm7FyCIVhGIi8xh8QL5xA+Smea49oawkYXTBrW
         C2yd4fNmlXe85+HGDE5XR6s77qoPJsgxj0vv8RlbWjVbXW8JfNfs/JpfdtzXcyAt8wUT
         UNaZZLtQ0H/bgkL2J7q7AejOT6YhcXUfLDm7rZftoPUBgBm2nRb2dKzTooK/GDww3pc8
         hG9icxvn0nLvRYyyj5jOo8Hsvmb0f/P+OoqvZB+TXixfDNJs3e3zYi0hZNDpYj8ZsJcU
         a1brLX56sKIcBGA04MAoS9XvVjjdkk36V78lyGOC2Qrib16cQKIEAXs0uJMYy/AdVA/9
         xa3w==
X-Gm-Message-State: AOAM530M5iZGKck95jW0yCnM6pK2GpbdCJb+/b/7R72qmoPscJ3u5LT6
        QeS/m9a/0cTDDsAqsc/fZZZKel9bvLh3T4rqPAziyHmbSaU=
X-Google-Smtp-Source: ABdhPJzeBK9tHosOMDeuPhiYPFOdbtaz7wPO3j1OHjQn9h2Im57coCSNxK2/bOob9g7mKKGRNveLYdO2NkMPsBBhrPY=
X-Received: by 2002:a5d:4dcc:0:b0:20a:ddaa:1c30 with SMTP id
 f12-20020a5d4dcc000000b0020addaa1c30mr16780056wru.419.1651202469290; Thu, 28
 Apr 2022 20:21:09 -0700 (PDT)
MIME-Version: 1.0
From:   Dave T <davestechshop@gmail.com>
Date:   Thu, 28 Apr 2022 23:20:58 -0400
Message-ID: <CAGdWbB4ndWsZQg13dbp2L5uXQUExtV=L0XmWvTEz61nWGzY=tg@mail.gmail.com>
Subject: What is the recommended course of action for: Found file extent holes
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs check found errors in fs roots. What is the recommended course
of action? I don't care much about the data on the volume.

# btrfs check --progress --check-data-csum /dev/mapper/xyz_luks
Opening filesystem to check...
Checking filesystem on /dev/mapper/xyz_luks
UUID: <redacted>
[1/7] checking root items                      (0:00:23 elapsed,
4710592 items checked)
[2/7] checking extents                         (0:01:03 elapsed,
154607 items checked)
[3/7] checking free space cache                (0:00:00 elapsed, 127
items checked)
root 1430 inode 7492 errors 100, file extent discount17 elapsed,
121521 items checked)
Found file extent holes:
        start: 0, len: 937984
root 1430 inode 7493 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 5390336
root 1430 inode 7494 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 1430 inode 7495 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 1392640
root 1430 inode 7496 errors 100, file extent discount

<removed about 600 more lines like these>

root 1430 inode 7699 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 770048
root 1430 inode 7700 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 1802240
root 1430 inode 7701 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 1007616
root 1430 inode 7702 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 221184
root 1430 inode 7703 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 380928
root 1430 inode 7704 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 573440
root 1430 inode 7705 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 212992
root 1430 inode 7706 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 802816
root 1430 inode 7707 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 65536
root 1430 inode 7708 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 483328
root 1430 inode 7709 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 172032
root 1430 inode 7710 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 241664
root 1430 inode 7711 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 12288
root 1430 inode 7712 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 86016
root 1430 inode 7713 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 1171456
root 1430 inode 7714 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 90112
root 1430 inode 7715 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 29728768
root 1430 inode 7716 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 741376
[4/7] checking fs roots                        (0:00:17 elapsed,
122659 items checked)
ERROR: errors found in fs roots
found 129201229839 bytes used, error(s) found
total csum bytes: 123927020
total tree bytes: 2527707136
total fs tree bytes: 2024407040
total extent tree bytes: 369098752
btree space waste bytes: 379740661
file data blocks allocated: 1630234861568
 referenced 1662138822656
