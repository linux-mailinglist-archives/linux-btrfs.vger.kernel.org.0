Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFFE42FD35
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 23:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243007AbhJOVDh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 17:03:37 -0400
Received: from st43p00im-ztfb10063301.me.com ([17.58.63.179]:46219 "EHLO
        st43p00im-ztfb10063301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235480AbhJOVDg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 17:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1634331689;
        bh=HziOGzUJ99EWCjD3NNGmxXHGTJpAMF4PkWMFfPZ8CxM=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=u1qlu0teLbNWSqU0D1BH4w/6AyT3H1KwgGZBQbt5pU1DmFXP0fM4RSCjGlP+dpv6q
         hpl5X6DFWheb5TXIRUeJrLWrEKeixE7/hjQ2TPiJ074oBrr5zv3YRN47a1rysH4HCM
         +K3fN3HztH2XSjkw3aZ19FAI8p+I4gAXf4JRzYfIZ9YQTunv1r4sye0iOMAc4jojmN
         yJr77hcBl3tbpHlo3sMibMf/GM+7U4QCirADritnGIlXUQiaoeMaMVxtH1Mq3c8k3B
         dfBrBCk2R7cazVMtdrsDSR+6HV9uIOyKMATWP2tCMdXfUzBmo7ZSy93lQIPqsUVG5g
         4ZgKTOonj38mQ==
Received: from smtpclient.apple (unknown [152.249.37.238])
        by st43p00im-ztfb10063301.me.com (Postfix) with ESMTPSA id 013BAA40692;
        Fri, 15 Oct 2021 21:01:27 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: need help in a broken 2TB BTRFS partition
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <bd42525b-5eb7-a01d-b908-938cfd61de8c@gmx.com>
Date:   Fri, 15 Oct 2021 18:01:24 -0300
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <12FE29EC-3C8F-4C33-8EF3-BD084781C459@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
 <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <bd42525b-5eb7-a01d-b908-938cfd61de8c@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-15_07:2021-10-14,2021-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2110150127
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

I hope I find you well.

Almost two years that my system runs without any failure.
Since this is very boring I tried make my life somehow harder and tested =
again the snapshot feature of my Parallels Desktop installation =
yesterday:-)
When I erased the old snapshots I could feel (and actually hear) already =
that the system is writing too much to the partitions.
What I want to say is that it took too long (for any reason) to erase =
the old snapshots and to shut the system down.

Well, after booting I saw that one of the discs is not coming back and I =
got the following error message:

Suse_Tumbleweed:/home/proc # btrfs check /dev/sdd1
Opening filesystem to check...
parent transid verify failed on 324239360 wanted 208553 found 184371
parent transid verify failed on 324239360 wanted 208553 found 184371
parent transid verify failed on 324239360 wanted 208553 found 184371
Ignoring transid failure
leaf parent key incorrect 324239360
ERROR: failed to read block groups: Operation not permitted
ERROR: cannot open file system


Could you help me to debug and repair this please?

I already run the command btrfs restore /dev/sdd1 . and could restore =
90% of the data but not the important last 10%.

My system is:

Suse Tumbleweed inside Parallels Desktop on a Mac Mini

Mac Min: Big Sur
Parallels Desktop: 17.1.0
Suse: Linux Suse_Tumbleweed 5.13.2-1-default #1 SMP Thu Jul 15 03:36:02 =
UTC 2021 (89416ca) x86_64 x86_64 x86_64 GNU/Linux

Suse_Tumbleweed:~ # btrfs --version
btrfs-progs v5.13=20

The disk /dev/sdd1 is one of several 2TB partitions that reside on a NAS =
attached to the Mac Mini like=20

Disk /dev/sde: 2 TiB, 2197949513728 bytes, 4292870144 sectors
Disk model: Linux_raid5_2tb_
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 942781EC-8969-408B-BE8D-67F6A8AD6355

Device     Start        End    Sectors Size Type
/dev/sde1   2048 4292868095 4292866048   2T Linux filesystem


What would be the next steps to repair this disk?

Thank you all in advance for your help,

Chris

