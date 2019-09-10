Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61649AE337
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 07:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390667AbfIJFM4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 01:12:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41112 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390663AbfIJFMz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 01:12:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A59pEi070426;
        Tue, 10 Sep 2019 05:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=L+P83pIJBPNY0Yzl6/b+tqDDx9cytdT10VukX1V4akg=;
 b=Vmdr+AaqNNRhUaOLcGu30lZiTHo+V23mMtdWL7eHacnx8W8btg/07LgSI9S97jOX6dso
 Cqyu98vdlRuXptQoviP1hhjIVhGgaNLaG6aFVUR+dewakdUqk7Z8Fuv2OuN5+dnzyw8x
 sGkXIkX6iIxIkwhhXu/wMyDnfLXsb8k0Air5dHd1NrovdHup1qUWlGCF9lwQKDoaEX+U
 15LrwS5kWAK7XpKZjrcK9wr4xVx53VkyBezvlTnU6YwU8mxES3SykjgA9TSwWNRIzJFO
 kn6BvSWmA9x/685kylHYT9rL954ha/FAcqyoAu3Ziw/pmyg4lw+FoJT9CXs0HN4cUEAH yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2uw1m8rkdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 05:12:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A59JEd195464;
        Tue, 10 Sep 2019 05:12:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2uwqkt92y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 05:12:50 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8A5CoAQ025612;
        Tue, 10 Sep 2019 05:12:50 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Sep 2019 22:12:50 -0700
Subject: Re: [PATCH] btrfs-progs: drop unique uuid test for btrfstune -M
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190906005025.2678-1-anand.jain@oracle.com>
 <f3d33e1d-803e-34a5-4dfa-7eeceec6177c@suse.com>
 <232bccd3-3623-8ee9-18db-98edf7cd2e25@oracle.com>
 <673ba386-debc-96e9-311e-4c3c0abd89d0@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <41b5b682-e67f-40d6-93cb-75e4889a4b06@oracle.com>
Date:   Tue, 10 Sep 2019 13:12:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <673ba386-debc-96e9-311e-4c3c0abd89d0@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100049
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Nikolay,

>>> This is intended. Otherwise it's an open avenue for the user to shoot
>>> themselves in the foot.
>>
>>   I don't understand how?

  Again. Any idea how? Is there any test case?

  <snip>

> UUID, by definition, are Unique. What you want to is
> to toss the Unique part, meaning we'll really be left with some sort of
> ID. What's more - the UUID is used by libblkid to populate the available
> devices so not making it unique can cause subtle bugs.

- Irrespective of the fstype, when fs image file is copied/snapshot-ed
   the fsid is indeed going to be duplicate.

- xfs and btrfs kernel doesn't allow duplicate fsid to be mounted which
   is fair and accepted. (I remember fixing the duplicate fsid bugs in
   the kernel, just fyi if you are concerned about them).

- ext4 kernel does allow duplicate fsid to be mounted.

- btrfstume -M <uuid> isn't the place to check if the fsid is a
   duplicate. Because, libblkid will be unaware of the complete list of
   fs images with its fsid.

- As I said before, its a genuine use-case here where the user wants to
   revert the fsid change, so that btrfs fs root image can be booted.
   Its up-to the user if fsid is duplicate in the user space, as btrfs
   kernel rightly fails the mount if its duplicate fsid anyways.

Thanks, Anand
