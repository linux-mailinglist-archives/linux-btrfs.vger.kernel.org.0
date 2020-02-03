Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D77FD15045F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 11:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgBCKk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 05:40:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60102 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgBCKk4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 05:40:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013ANx3J188734;
        Mon, 3 Feb 2020 10:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=CwSpTHLydpRKwKGyzLyuWuTOClRx8huf1jd3MypOjts=;
 b=l7HNuN3Uod3iVMxbPkJOcl8Njtes2T4cKtmVMIt1zUXx8nyAupoymvnwZuCFp4c5kyRT
 54hEVcAnkG/98H011rJHIIKwzkyYbELh/NaxCit6BBZDhIx1fJqcH3fAoDQVzjL+kU4Q
 ZgT40rx7Ww0MFm1taIOeR9GTxqDXD4Bz8EVhpIiZGSeafXYr+Uhvo2JDo+oa59cWSbvg
 tAQjDf5vruvTRoi6VQuT5CqhBOfBzPubAoQhPdai8tynLZ0ILSuqu7O5aDFWx4LbwxTb
 PgTLN6vLysPk3RyiWOoq/isMWo8Mf0e5bAWV+P0tUwJ6ts/EVFOp70JyHiRabmMYDEl/ 0Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xw0rtxxv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 10:40:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013ANma4006638;
        Mon, 3 Feb 2020 10:40:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xwjt3n7a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 10:40:51 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 013AeoR6019638;
        Mon, 3 Feb 2020 10:40:50 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Feb 2020 02:40:50 -0800
Subject: Re: [PATCH 2/4] btrfs: sysfs, add UUID/devinfo kobject
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205112706.8125-3-anand.jain@oracle.com>
 <20200114183257.GI3929@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a3eee535-4013-ac65-d7bc-7fb75b2641af@oracle.com>
Date:   Mon, 3 Feb 2020 18:40:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200114183257.GI3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002030081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002030081
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




On 15/1/20 2:32 AM, David Sterba wrote:
> On Thu, Dec 05, 2019 at 07:27:04PM +0800, Anand Jain wrote:
>> Preparatory patch creates kobject /sys/fs/btrfs/UUID/devinfo to hold
>> btrfs_fs_devices::dev_state attribute.
>>
>> This is being added in the mount context, that means we don't see
>> UUID/devinfo before the mount (yet).
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 


> There's a report about duplicate directory created:
> 
> btrfs/064
>
> 
> [ 1782.480622] sysfs: cannot create duplicate filename '/fs/btrfs/3f26615b-afcd-4008-8aed-44e714be257c/devices/0'                                                                                               

  Just for the clarity this patch did not cause this issue.

David,

  The patches 1/4,2/4,3/4 in this series are cleanups and preparatory
  which is missing in misc-next.

  So the devid is being created under <UUID>/devices instead of
  <UUID>/devinfo as planned.

  I am sending the whole series again with the patch 4/4 taken from
  misc-next, please help to integrate.

Thanks, Anand
