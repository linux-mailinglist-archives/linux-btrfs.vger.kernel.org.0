Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF55C4A99
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 11:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfJBJZM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 05:25:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39904 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfJBJZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 05:25:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x929O4N3045396;
        Wed, 2 Oct 2019 09:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : subject :
 cc : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=mKySQiuUQg9zfihY+YfUCshwOHase/ovPpoeigPLGFk=;
 b=huICBTcwTem0C7zUGhWDDRw0H0phTbYLK5ZqATF8wFubqi3hNL76N+q4+XGe8frndjG2
 7qSSF/LHkS0Fgc8WMzyx1S6rUZ4J+efOeavf4rMqCA64RB2lz3HzpVKb77zksFc2ygqF
 81kzlkY8M9SJsWzsQHV33DBrFN2yAK0806yvll0hCw9XUW4Yn+RhUNRO6LIKxabasyts
 Qu7n4jsOA9Tu59uMl2Rci/kT05C6cCbBYWASEtGkTwpVKwcSMJPG3ssmjA8Iad80pBFk
 /aWQ8ZWzanEQzM1CI8OgjE+e4BTrZILrCikra+ZpVXFXfyBr/EuU7R0T8WU5PtVRYb+r zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2v9xxuuvwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 09:25:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x929NsnJ155503;
        Wed, 2 Oct 2019 09:25:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vckynn794-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 09:25:07 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x929P79N019557;
        Wed, 2 Oct 2019 09:25:07 GMT
Received: from [10.186.52.87] (/10.186.52.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Oct 2019 02:25:07 -0700
To:     systemd-bugs@lists.freedesktop.org
From:   Anand Jain <anand.jain@oracle.com>
Subject: [bug] strange systemd-udevd scan for btrfs device
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <9fe6ad9b-d53f-614c-5651-6de8bad93f1e@oracle.com>
Date:   Wed, 2 Oct 2019 17:25:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910020089
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



I am looking for systemd part of the answers to understand what
is triggering a strange problem. Any help is appreciated.

After mkfs.btrfs creates btrfs filesystem it scans to register the
device in btrfs.ko.
And we have 'btrfs dev scan --forget' command to undo the process of
register.

But the problem is - immediately after 'btrfs dev scan --forget' the
systemd-udevd scans the device again, defeating the purpose of the
forget as show below (scanned-by).

mkfs.btrfs -fq /dev/sdc && btrfs dev scan --forget /dev/sdc

-------------------
kernel: BTRFS: device fsid 8ea20bb2-888a-4b3b-9f4c-1db9117dc219 devid 1 
transid 5 /dev/sdc scanned-by mkfs.btrfs
kernel: BTRFS: device fsid 8ea20bb2-888a-4b3b-9f4c-1db9117dc219 devid 1 
transid 5 /dev/sdc scanned-by systemd-udevd
-------------------

And the problem does _not_ happen if there is a sleep of 3 secs after
the mkfs.btrfs, as below.

mkfs.btrfs -fq /dev/sdc && sleep 3 && btrfs dev scan --forget /dev/sdc

------------------
kernel: BTRFS: device fsid 601bd01a-5e6b-488a-b020-0e7556c83087 devid 1 
transid 5 /dev/sdc scanned-by mkfs.btrfs
------------------

Any idea what happening from the systemd point of view?

Thanks, Anand
