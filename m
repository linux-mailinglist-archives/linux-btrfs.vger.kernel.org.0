Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77D0139A46
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 20:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgAMTlt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 14:41:49 -0500
Received: from ms11p00im-hyfv17281201.me.com ([17.58.38.39]:60556 "EHLO
        ms11p00im-hyfv17281201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbgAMTlt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 14:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578944506;
        bh=UvrNFj840GokAtR4vGVSeFGEAdvsabyZ5H6uWGsYEf8=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=GIHFmBl0atqKgYq46wcHNyNL8L++v6CIessQ9E6PIx9yK8Iyeh8kFuES0qzBP0zLG
         WrnEKFpdrWeqxaCeun607n+c9Y2qoyLK4LgGYVU3TYrjSaiFRPSIaryrpbxYhK0WE7
         IcM+/LgtenztxZwtfFJEJpt91UixNe+g6wiwhoYBK5jEug1BuTkUtNDnkefzy6L6jS
         opGt+FlHGjaMbJb2vxerB+5ry32wzL90wmSCMcYRnN3bW7gBqZKcB7SqU8rAYneI34
         BihG/48WI94xdHgKgVF9qJ9vPCysblltpJ+wB0e07EOmizgalz85j6ZCb9B8oI1+wN
         LZ9V+jzj4Z5VQ==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-hyfv17281201.me.com (Postfix) with ESMTPSA id A0F24C00677;
        Mon, 13 Jan 2020 19:41:45 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: 12 TB btrfs file system on virtual machine broke again (fourth
 time)
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <CAJCQCtRkZPq-k6pX3bCJmj25HY4eDdAEUcgLwGSh_Mi6VEqdiQ@mail.gmail.com>
Date:   Mon, 13 Jan 2020 16:41:42 -0300
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5EFA3F48-29DA-4D02-BF14-803DBEEB6BB2@icloud.com>
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
 <3F43DDB8-0372-4CDE-B143-D2727D3447BC@icloud.com>
 <CAJCQCtRUQ3bz--5B7Gs9aGYdo6ybkJWQFy61ohWEc2y1BJ6XHA@mail.gmail.com>
 <938B37BF-E134-4F24-AC4F-93FECA6047FC@icloud.com>
 <CAJCQCtROKcVBNuWkyF5kRgJMuQ4g4YSxh5GL6QmuAJL=A-JROw@mail.gmail.com>
 <25D1F99C-F34A-48D6-BF62-42225765FBC1@icloud.com>
 <CAJCQCtQxN17UL7swO7vU6-ORVmHfQHteUQZ7iS1w7Y5XLHTpVA@mail.gmail.com>
 <86147601-37F0-49C0-B6F8-0F5245750450@icloud.com>
 <CAJCQCtRkZPq-k6pX3bCJmj25HY4eDdAEUcgLwGSh_Mi6VEqdiQ@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=832 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001130160
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi guys,

just to update you.=20

I tried a 4th time with a brand new 12 TB archive and right after =
setting up everything and putting some data on it I performed a =
controlled suspend and restore and so on and yes, it broke again with =
that terrible messages that it can not mount any more the file system.

Then I decided to create only 2TB archives (hard disks) as the slider in =
the Parallels VM suggests to do.
I created 4 x 2TB files, one with persistent size and three expandable.
I filled up all hard discs with data and rebooted 5 times (even when =
writing data to it) and everything runs very stable.

So to resume, the Parallels Virtual machine has a problem when the =
virtual disk is being selected bigger than 2TB. There is (and was) never =
a problem with the btrfs files system I think.

Sorry for bothering you all the time with my bad setup.

Thanks a lot for all your help!

Chris

