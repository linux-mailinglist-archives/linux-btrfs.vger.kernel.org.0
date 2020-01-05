Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681CB1309B6
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 20:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgAETwX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 14:52:23 -0500
Received: from ms11p00im-qufo17291601.me.com ([17.58.38.45]:54490 "EHLO
        ms11p00im-qufo17291601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgAETwX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 14:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578253940;
        bh=n8iX0pXaoUl05al0TBmbuFzWruq4JRfAdYwgkB7LCBk=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=w1yot6kWV3/C6kGV8IkBpOTZyddbesnu/EbVUApGYuF0Mp2RXXj+8TvrsVZMHBFFc
         gVjTa9H7/Ld8JgGfFqDXiwy1OfPiaBAa6qf4Un/i7mfiDeyVdWOZ8rfTyWviPhqx29
         srOawaZSLJr/PwC0CzrloAaK39q6UGwOsh9tlyqRt0ZvBe4494i7lNCCuOQ/xWSQbr
         OeK3DYPU+4fBNLXeJyb/H2x2XJFyPUqumQXdDqM0SRJFvy5sk/ZHWRkt8RMV4OJ9b7
         buhPR9iVVRd6NkoHTgueOxUjcXdG7hU6LViBHjTqQALZT3DPw8DuNzH6X2rkdU5GeF
         gfiycvMypefLA==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-qufo17291601.me.com (Postfix) with ESMTPSA id 1DF362005C4;
        Sun,  5 Jan 2020 19:52:18 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: 12 TB btrfs file system on virtual machine broke again
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
Date:   Sun, 5 Jan 2020 16:52:16 -0300
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF92D4FB-0FBF-49F8-A32D-60D56C41AAEC@icloud.com>
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
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
 <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com>
 <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-05_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=953 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001050184
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTW, I found this messages in the messages-20200105 file:



bash$ grep fstrim messages-20200105
2019-12-23T00:00:03.533050-03:00 linux-ze6w fstrim[32008]: fstrim: =
/boot/grub2/i386-pc: FITRIM ioctl failed: Input/output error
2019-12-23T00:00:04.354989-03:00 linux-ze6w fstrim[32008]: fstrim: =
/boot/grub2/x86_64-efi: FITRIM ioctl failed: Input/output error
2019-12-23T00:00:05.149687-03:00 linux-ze6w fstrim[32008]: fstrim: =
/home: FITRIM ioctl failed: Input/output error
2019-12-23T00:00:05.941978-03:00 linux-ze6w fstrim[32008]: fstrim: /opt: =
FITRIM ioctl failed: Input/output error
2019-12-23T00:00:06.740810-03:00 linux-ze6w fstrim[32008]: fstrim: =
/root: FITRIM ioctl failed: Input/output error
2019-12-23T00:00:07.523365-03:00 linux-ze6w fstrim[32008]: fstrim: /srv: =
FITRIM ioctl failed: Input/output error
2019-12-23T00:00:08.361831-03:00 linux-ze6w fstrim[32008]: fstrim: /tmp: =
FITRIM ioctl failed: Input/output error
2019-12-23T00:00:09.188937-03:00 linux-ze6w fstrim[32008]: fstrim: =
/usr/local: FITRIM ioctl failed: Input/output error
2019-12-23T00:00:09.974086-03:00 linux-ze6w fstrim[32008]: fstrim: /var: =
FITRIM ioctl failed: Input/output error
2019-12-23T00:00:10.761933-03:00 linux-ze6w fstrim[32008]: fstrim: /: =
FITRIM ioctl failed: Input/output error
2019-12-23T00:00:10.762050-03:00 linux-ze6w fstrim[32008]: =
/mnt/so_logic: 27.1 GiB (29089808384 bytes) trimmed on /dev/sdd1
2019-12-23T00:00:10.762121-03:00 linux-ze6w fstrim[32008]: /home/chris2: =
265.4 GiB (284938117120 bytes) trimmed on /dev/sdc1
2019-12-23T00:00:10.762198-03:00 linux-ze6w systemd[1]: fstrim.service: =
Main process exited, code=3Dexited, status=3D64/n/a
2019-12-23T00:00:10.762449-03:00 linux-ze6w systemd[1]: fstrim.service: =
Unit entered failed state.
2019-12-23T00:00:10.762538-03:00 linux-ze6w systemd[1]: fstrim.service: =
Failed with result 'exit-code'.
2020-01-03T11:30:45.742369-03:00 linux-ze6w fstrim[27910]: fstrim: =
/boot/grub2/i386-pc: FITRIM ioctl failed: Input/output error
2020-01-03T11:30:46.592336-03:00 linux-ze6w fstrim[27910]: fstrim: =
/boot/grub2/x86_64-efi: FITRIM ioctl failed: Input/output error
2020-01-03T11:30:47.476629-03:00 linux-ze6w fstrim[27910]: fstrim: =
/home: FITRIM ioctl failed: Input/output error
2020-01-03T11:30:48.376543-03:00 linux-ze6w fstrim[27910]: fstrim: /opt: =
FITRIM ioctl failed: Input/output error
2020-01-03T11:30:49.295675-03:00 linux-ze6w fstrim[27910]: fstrim: =
/root: FITRIM ioctl failed: Input/output error
2020-01-03T11:30:50.180612-03:00 linux-ze6w fstrim[27910]: fstrim: /srv: =
FITRIM ioctl failed: Input/output error
2020-01-03T11:30:51.049373-03:00 linux-ze6w fstrim[27910]: fstrim: /tmp: =
FITRIM ioctl failed: Input/output error
2020-01-03T11:30:51.919945-03:00 linux-ze6w fstrim[27910]: fstrim: =
/usr/local: FITRIM ioctl failed: Input/output error
2020-01-03T11:30:52.777132-03:00 linux-ze6w fstrim[27910]: fstrim: /var: =
FITRIM ioctl failed: Input/output error
2020-01-03T11:30:53.623997-03:00 linux-ze6w fstrim[27910]: fstrim: /: =
FITRIM ioctl failed: Input/output error
2020-01-03T11:30:53.624172-03:00 linux-ze6w fstrim[27910]: =
/mnt/so_logic: 27.1 GiB (29089808384 bytes) trimmed on /dev/sdd1
2020-01-03T11:30:53.624247-03:00 linux-ze6w fstrim[27910]: /home/chris2: =
262.5 GiB (281862184960 bytes) trimmed on /dev/sdc1
2020-01-03T11:30:53.624365-03:00 linux-ze6w systemd[1]: fstrim.service: =
Main process exited, code=3Dexited, status=3D64/n/a
2020-01-03T11:30:53.624883-03:00 linux-ze6w systemd[1]: fstrim.service: =
Unit entered failed state.
2020-01-03T11:30:53.624991-03:00 linux-ze6w systemd[1]: fstrim.service: =
Failed with result 'exit-code'.


Chris

