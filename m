Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A0351CFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 23:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfFXVT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 17:19:59 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38314 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFXVT6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 17:19:58 -0400
Received: by mail-wm1-f48.google.com with SMTP id s15so738619wmj.3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2019 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=6A+II+uFCjkda9pmopY6gLtwLbLxPIe4jn1khpi+jUw=;
        b=tv6wS942Iqe7wvtZYWy/K/GQERW0YGm2bDL8xV46VPHR8hMVohUEkeKaQGtvd9akHp
         Igkve0UoRjzvFzQpbv89eNVA/CkYwrbGMR4PTbbInRo0LR/Gi94Zo3BzQHZjUxTDEhYi
         9IDJdYg1VWsLHjqYT8+veDl1z8GvYBX16eVvqx5TDCAPQqsYfdAJwH5i5c50sDfsHMUJ
         L7LIS8pXBf3vjLKEJKA+IlRY0Osq6G7j/k92ptyUXudy15xfRdmM+lRwx1yGuQGikwZW
         aXtl/jzsG+flqBrl09SQjeIsaE04j1p8TqIH8MzsTlt/IKec1sVn/zC0smWH+WOipLSe
         9onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6A+II+uFCjkda9pmopY6gLtwLbLxPIe4jn1khpi+jUw=;
        b=Kt6gUr/Wl9ihZ0G9Kw6TP/URLNFxtULtCxjD23chmuUZ/z92Bg0e9ciykWDcLT7ErO
         U9p84RbIZ2kBC618zAoXcUBzos0T7l01psJvfcIQurWM8YWr/1B4NDHU6syn4RnHsef5
         AlehOd0G+cSpS/2lw5DXWbp8pM6h651a41wz064oc32mKJKGTQL1YXtJ1LXi63a8aBdI
         0wTGwb4LQNU5n2KhVOMxeBRlIPkwPWn/yY6mZmR9bcNpLVuT52WJjdR+N4nOk6ypLsc4
         FgF9IQBXF+uZHAq+Y9h4USpINzLY0NtX9Nk8T2ymyKQZenHaLqV7p+SloGz7wSf7BOgP
         gg1w==
X-Gm-Message-State: APjAAAUGc85e5mQEsOTCJd6fXp+rU6kPSP4290kUSYCd9CGBNip3fz7C
        4d3HQPIcIFukovlGt68YijYzQmVqFO38/IaMqObGgoJlfZaSBw==
X-Google-Smtp-Source: APXvYqz/aEcFTL6GRJCi0lkHXJVbCvleQifPgEqaBtHYR/Y+SCTrzCM3Elu7fXHf28fGJQ/X1xEQqZzVysrW9B+abSs=
X-Received: by 2002:a1c:a997:: with SMTP id s145mr16785395wme.106.1561411196594;
 Mon, 24 Jun 2019 14:19:56 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 24 Jun 2019 15:19:45 -0600
Message-ID: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
Subject: 5.2rc5 corruption, many "is compressed but inode flag doesn't allow"
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Short version:
sysroot is Btrfs. I made a rw snapshot of an ro snapshot in order to
do a rollback, and then rebooted. The umount was clean, but during
startup I noticed many services had failed, but couldn't tell why and
I had no shell or remote service to get into the system. I don't know
if a rw mount happened, journald is set to volatile journal so there's
no log of this failed boot. I waited about 5 minutes in this state
then forced a poweroff, rebooted from USB stick and btrfs check finds
errors and collect  information. There are many btrfs check errors in
lowmem mode. It does mount ro without complaint using kernel 5.0.7.

This system has used Btrfs for years with zero corruptions until now.
This system was clean installed with Fedora Rawhide ~ 2 weeks ago,
with a newly created file system.

Hardware:
Apple Macbook Pro (2011)
Samsung SSD 840 EVO 250GB, Firmware Version: EXT0DB6Q

Detail version:
only btrfs-progs 5.1 used
mix of kernel 5.2rc2, rc3, and rc5, at the time of the snapshot and
reboot with scary failures, it was using rc5+, specifically git
bed3c0d84e7e

mkfs.btrfs -d single -m single -n 32K /dev/sda6
mount options: noatime,ssd,space_cache=v2,compress=zstd

btrfs check (normal)
https://drive.google.com/open?id=1ZkIPq01lz1BxjOjxA22SUh0kSQaEeRex
btrfs check lowmem
https://drive.google.com/open?id=11INxc1OQbdpmqrVRlk0mNuLwmgSnnB1K
btrfs super
https://drive.google.com/open?id=13cNGSvjPTiYgG0smEFWecP3fk9P2Tn5G
btrfs debug tree, 97MB zstd compressed
https://drive.google.com/open?id=1TaxKikn9gKDjnkQpOrqWzdGYw17maCpt
btrfs image, 31MB
https://drive.google.com/open?id=1is_prjUhu8IBjq9oadugOi_YBYbGYGRA


-- 
Chris Murphy
