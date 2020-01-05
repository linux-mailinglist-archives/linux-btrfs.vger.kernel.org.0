Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB413086B
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 15:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgAEOXf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 09:23:35 -0500
Received: from ms11p00im-hyfv17291101.me.com ([17.58.38.40]:48346 "EHLO
        ms11p00im-hyfv17291101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726188AbgAEOXf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 09:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578234212;
        bh=oiZ2v/D0fG7PSXd+ijuu9/BNXhjpXXOWlJQDVhOtRBQ=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=mQG99ETiKApSfuMebgwLAOf/r9SJEQ3EZtFek1efmdtGltP/ge1qLXh8BRYUAG9/H
         fHgjn0Sflt5gco0JsCygxN+FZ/JQPj4QHEUIx0zQC4whxWD4AoX8C00H8Fmxj7pMrc
         CdVqmkeURKaQ6fZYjB7LUsjbNSiEwcqV/QeXNpvqchNz7ZjVa1D9AuisLY5y6A0VM0
         UKWDhRQcNUK3oASAmDrI0ueehfvw/9GP3IxMX54q/HoL9hXht5bb6hO7/aVq3Tx3Ig
         ZKz1OgI0n9yfJTM3/MnAWcNVocZsQJRvdk09EFzpVEbxB74iBXGxtjz3zKm6pCP+MC
         cdjvGtVZQ8QGQ==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-hyfv17291101.me.com (Postfix) with ESMTPSA id 75C6D6C072C;
        Sun,  5 Jan 2020 14:23:31 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: 12 TB btrfs file system on virtual machine broke again
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <4BB63A89-98D3-4990-9970-8D8258F66E11@icloud.com>
Date:   Sun, 5 Jan 2020 11:23:19 -0300
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5E64CEB-1F48-46D0-80A9-943BC3A9E4DF@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <CAJCQCtQmvHS8+Z7=B_8panSzo=Bfo0ymVU+cr_tR5z1uw+Ejug@mail.gmail.com>
 <CE5FDD33-F072-40EE-9ED7-66D5F7F2A5FA@icloud.com>
 <0102016f76081d01-72e2a7ca-3d8e-4238-b578-898fbe7d7bc3-000000@eu-west-1.amazonses.com>
 <4BB63A89-98D3-4990-9970-8D8258F66E11@icloud.com>
To:     Martin Raiber <martin@urbackup.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=629 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001050135
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the warn file (var/log/messages/warn) If found following lines:

2019-12-29T13:10:33.097033-03:00 linux-ze6w kernel: [1297807.325928] =
btrfs_dev_stat_print_on_error: 25 callbacks suppressed
2019-12-29T13:10:33.097048-03:00 linux-ze6w kernel: [1297807.325935] =
BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 1, rd 0, flush 0, =
corrupt 0, gen 0
2019-12-29T13:10:33.097051-03:00 linux-ze6w kernel: [1297807.326276] =
BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 2, rd 0, flush 0, =
corrupt 0, gen 0
2019-12-29T13:10:33.097052-03:00 linux-ze6w kernel: [1297807.326584] =
BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 3, rd 0, flush 0, =
corrupt 0, gen 0
2019-12-29T13:10:33.097052-03:00 linux-ze6w kernel: [1297807.326937] =
BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 4, rd 0, flush 0, =
corrupt 0, gen 0
2019-12-29T13:10:33.097057-03:00 linux-ze6w kernel: [1297807.327051] =
BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 5, rd 0, flush 0, =
corrupt 0, gen 0
2019-12-29T13:10:33.097058-03:00 linux-ze6w kernel: [1297807.327263] =
BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 6, rd 0, flush 0, =
corrupt 0, gen 0
2019-12-29T13:10:33.097058-03:00 linux-ze6w kernel: [1297807.327264] =
BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 7, rd 0, flush 0, =
corrupt 0, gen 0
2019-12-29T13:10:33.097058-03:00 linux-ze6w kernel: [1297807.327272] =
BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 8, rd 0, flush 0, =
corrupt 0, gen 0
2019-12-29T13:10:33.097059-03:00 linux-ze6w kernel: [1297807.327273] =
BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 9, rd 0, flush 0, =
corrupt 0, gen 0
2019-12-29T13:10:33.097059-03:00 linux-ze6w kernel: [1297807.327280] =
BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 10, rd 0, flush 0, =
corrupt 0, gen 0
2019-12-29T13:10:33.097068-03:00 linux-ze6w kernel: [1297807.327416] =
BTRFS warning (device sdb1): Skipping commit of aborted transaction.
2019-12-29T13:10:33.097069-03:00 linux-ze6w kernel: [1297807.327433] =
BTRFS error (device sdb1): commit super ret -5
2019-12-29T13:10:33.097069-03:00 linux-ze6w kernel: [1297807.327531] =
BTRFS error (device sdb1): cleaner transaction attach returned -30
2019-12-29T13:10:33.097059-03:00 linux-ze6w kernel: [1297807.327414] =
BTRFS: error (device sdb1) in btrfs_commit_transaction:2261: errno=3D-5 =
IO failure (Error while writing out transaction)
2019-12-29T13:10:33.097069-03:00 linux-ze6w kernel: [1297807.327418] =
BTRFS: error (device sdb1) in cleanup_transaction:1881: errno=3D-5 IO =
failure



