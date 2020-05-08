Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4809D1CAA9C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgEHM2w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 08:28:52 -0400
Received: from st43p00im-ztbu10063601.me.com ([17.58.63.174]:40751 "EHLO
        st43p00im-ztbu10063601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbgEHM2v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 May 2020 08:28:51 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 May 2020 08:28:50 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1588940448;
        bh=qsx1g8im2C6KvnaVBZgSVvUOgevCt28lYUTy/vJMZj0=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=hNwcpb+u/5j576SDd+6At7V9oL87aOTDaKkhco9zTxDtuU9rUhN2d/lfgT2loea7p
         h+MdvbpYyci8C4svrZO1cWv+kBS6kztulj6viXZvaIW1qxMguU0JkwAhcG7ivJJIhT
         YOiZZNx3K58GpLXHqZhYDl+kAUQMTjL8/sHFZ8Cjl53sJhrGsKhagxZzpTFVYw9I+A
         6/p92Uh5X34AxFH3Z/+qXjAD6BqWPAMJg7xULj+ad7HbbiADwcELSy9V3GmzRcps+v
         YFQDxP2N8anaYAjOX27FqvFaaq+s7Lq2BDwYATl3rqzH9yw1U2NixV9GhEgLmjppCa
         woX6kymdXNQCg==
Received: from [192.168.15.23] (200-170-112-116.corp.ajato.com.br [200.170.112.116])
        by st43p00im-ztbu10063601.me.com (Postfix) with ESMTPSA id E1B7970022A;
        Fri,  8 May 2020 12:20:47 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: btrfs reports bad key ordering after out of memory situation
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <CAJCQCtRyr17kdSdozU4_ZxJL_VdCWZe7DCCuUuz0cy2AiJs3=A@mail.gmail.com>
Date:   Fri, 8 May 2020 09:20:45 -0300
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E923657-A63F-45E6-B837-7F33E1648468@icloud.com>
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
 <5EFA3F48-29DA-4D02-BF14-803DBEEB6BB2@icloud.com>
 <CAJCQCtRyr17kdSdozU4_ZxJL_VdCWZe7DCCuUuz0cy2AiJs3=A@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_12:2020-05-07,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=952 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2002250000 definitions=main-2005080110
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris,

after reducing all partition sizes to 2TB I run my system now since 3 =
months without any problems. Many reboots and still very stable. =
Yesterday I run into a situation where I run out of memory on my 48Gbyte =
Virtual machine and suddenly the home partition was mounted read only. =
After a reboot the system did not come back.

I did a btrfs check =E2=80=94readonly /dev/sda2 and it reported=20

btrfs restore -l  /dev/sdb2 test
 tree key (EXTENT_TREE ROOT_ITEM 0) 278911795200 level 2
 tree key (DEV_TREE ROOT_ITEM 0) 279226892288 level 0
 tree key (FS_TREE ROOT_ITEM 0) 22118400 level 0
 tree key (CSUM_TREE ROOT_ITEM 0) 437370880 level 2
 tree key (QUOTA_TREE ROOT_ITEM 0) 279164583936 level 0
 tree key (UUID_TREE ROOT_ITEM 0) 460750848 level 0
 tree key (257 ROOT_ITEM 0) 22642688 level 0
 tree key (258 ROOT_ITEM 0) 279163060224 level 1
 tree key (259 ROOT_ITEM 0) 278998171648 level 2
 tree key (260 ROOT_ITEM 0) 279162814464 level 2
 tree key (261 ROOT_ITEM 0) 594477056 level 0
 tree key (262 ROOT_ITEM 0) 278959783936 level 1
 tree key (263 ROOT_ITEM 0) 279005970432 level 2
 tree key (264 ROOT_ITEM 0) 279162961920 level 2
 tree key (265 ROOT_ITEM 0) 655015936 level 0
 tree key (266 ROOT_ITEM 0) 654376960 level 1
 tree key (267 ROOT_ITEM 0) 461029376 level 0
 tree key (268 ROOT_ITEM 0) 279156670464 level 2
bad key ordering 192 193
bad key ordering 192 193
 tree key (DATA_RELOC_TREE ROOT_ITEM 0) 43673436160 level 0


Could you please help me to repair this system?

Which command I can use ?

For the btrfs restore command I used the newest btrfs version.
The btrfs version the system was running on is 4.19=20

Thanks a lot,

Chris

