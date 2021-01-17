Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059EB2F9554
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jan 2021 22:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbhAQVGL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 16:06:11 -0500
Received: from mout01.posteo.de ([185.67.36.65]:39215 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbhAQVGL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 16:06:11 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 8EF49160063
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 22:05:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1610917513; bh=FzRND18AcZ+3ux48Er2swghnZDjB8yFfguaM3kOv3Lo=;
        h=To:From:Subject:Date:From;
        b=o8qKIfmgJOgdRrn0jkMdxf+ommbyBpbvAWA3E5buOjgnteuZuMp904/6zkTUKHQFf
         rgksJNpfyT7haAKwaIkXpM+XajJth1HPLe66B4eNBjZ/tpW4Nz+fDkKe+rK4PgVOnM
         tPicfMBNbXxImGgbEGrpCpot5Ahomu78Bp46ps+v4vl4LvIaaDTCG185KDmwVpkTI/
         FBS0cMwRJV3vvevtUt2077zODis6B2H94H4XtVM5usSkmb3sGZ+wOn6pFqEm3mwklx
         8Ep00KYrI5UfgBM9iHDWUgJr7mEKKr5gVcHZ9/+g1iGuCbt4j4zpFH9bHBNg0KB8LI
         JQ00rFdtIqFHA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DJnVx1TmZz9rxM
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 22:05:13 +0100 (CET)
To:     linux-btrfs@vger.kernel.org
From:   =?UTF-8?Q?Damian_H=c3=b6ster?= <damian.hoester@posteo.de>
Subject: nodatacow mount option is disregarded when mounting subvolume into
 same filesystem
Message-ID: <180be9af-8a4b-886c-aefb-f7c904058bea@posteo.de>
Date:   Sun, 17 Jan 2021 22:05:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The nodatacow mount option seems to have no effect when mounting a 
subvolume into the same filesystem.

I did some testing:

sudo mount -o compress=zstd /dev/sda /mnt -> compression enabled
sudo mount -o compress=zstd,nodatacow /dev/sda /mnt -> compression disabled
sudo mount -o nodatacow,compress=zstd /dev/sda /mnt -> compression enabled
All as I would expect, setting compress or nodatacow disables the other.

Compression gets enabled without problems when mounting a subvolume into 
the same filesystem:
sudo mount /dev/sda /mnt; sudo mount -o subvol=@test,compress=zstd 
/dev/sda /mnt/test -> compression enabled
sudo mount /dev/sda /mnt; sudo mount -o subvol=@/testsub,compress=zstd 
/dev/sda /mnt/testsub -> compression enabled

But nodatacow apparently doesn't:
sudo mount -o compress=zstd /dev/sda /mnt; sudo mount -o 
subvol=@test,nodatacow /dev/sda /mnt/test -> compression enabled
sudo mount -o compress=zstd /dev/sda /mnt; sudo mount -o 
subvol=@/testsub,nodatacow /dev/sda /mnt/testsub -> compression enabled

And I don't think it's because of the compress mount option, some 
benchmarks I did indicate that nodatacow never gets set when mounting a 
subvolume into the same filesystem.

