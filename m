Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF2F1148FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 23:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfLEWBh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 17:01:37 -0500
Received: from st43p00im-ztdg10061801.me.com ([17.58.63.170]:60515 "EHLO
        st43p00im-ztdg10061801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729502AbfLEWBh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 17:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1575583296;
        bh=dFokQYMLV4GFUHUHTINjRJgq6zzqKfkDBd/VDrg98iY=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=1OzOWEYssa56hJF2vdqmD0bRdHc8rsg1cq4AaKW61QfAye7kG2KqddcAl91oOUnaj
         /Q5DybsoUfs+AYJP3l6Dw+aTikrLMbqKi18rqu4+/kxuXoQEnB9OFBYQExHK52VneD
         gaiuhjtaWbdSfQvbtU2J00H0lEVNd+WS9w9dtRy/FPGklQHZmMsKWf1MfXQ2mm2HSm
         0d9RHiinLD3lCJ8bCOlAxoq8kEXGlSIsFZFpVG5FNAOylzKgueibI33RrIblvQadU7
         xLDS97LYOFDM9URX5C05w6FgwTJAylA4o5qOz6jaMI9WkhtIDsrQpB7bRPA9Ug1xmD
         85nYpTi8LurFQ==
Received: from [100.98.43.211] (unknown [5.62.51.38])
        by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id EB8568C0A6F;
        Thu,  5 Dec 2019 22:01:35 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: is this the right place for a question on how to repair a broken
 btrfs file system?
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <20191205202449.GH4760@savella.carfax.org.uk>
Date:   Thu, 5 Dec 2019 19:01:33 -0300
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1DB17C6B-FDFF-406D-BD81-F67A5F4D8493@icloud.com>
References: <A01B0EC4-8E96-486B-A182-76B74AD0F97D@icloud.com>
 <20191205202449.GH4760@savella.carfax.org.uk>
To:     Hugo Mills <hugo@carfax.org.uk>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912050179
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Hugo,


just for your information. I run following command on the  backup file:

# btrfs rescue chunk-recover -v /dev/sde1
All Devices:
        Device: id =3D 1, name =3D /dev/sde1

Scanning: 575601561600 in dev0chunk-recover.c:129: =
process_extent_buffer: BUG_ON `exist->nmirrors >=3D BTRFS_MAX_MIRRORS` =
triggered, value 1
btrfs(+0x6d3b6)[0x56428c4f03b6]
btrfs(+0x6de31)[0x56428c4f0e31]
/lib64/libpthread.so.0(+0x7569)[0x7f351bee9569]
/lib64/libc.so.6(clone+0x3f)[0x7f351bc209ef]
Aborted (core dumped)


Seems to be a bug in the btrfs program.

# uname -a
Linux linux-ze6w 4.12.14-lp151.28.13-default #1 SMP Wed Aug 7 07:20:16 =
UTC 2019 (0c09ad2) x86_64 x86_64 x86_64 GNU/Linux
# btrfs version
btrfs-progs v4.19.1=20


Best regards,

Chris

