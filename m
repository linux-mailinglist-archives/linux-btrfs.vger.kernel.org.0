Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA4278255
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 10:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgIYIM4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Sep 2020 04:12:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34742 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgIYIMz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Sep 2020 04:12:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08P89cG4133814;
        Fri, 25 Sep 2020 08:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=n9FCAs/5XQLSuaYJzz5tc/eY/XA6t1F47Ih1F5gUlCg=;
 b=N8bxrPtl38vnMLvHiWJomc4ZpqsNtjMBpFa+xhe3TsyDAWWvRz1FqLlPRu5m7C0DLNTr
 8I04GZ+E5eq8g/ICro4Clu9V2cORRpm96I5rmqxzflD1HCRaZWojtpES+55eG1bFPOyb
 Zl4r7q530yT73me5MPeKHVSi0cqrT2YyLZEr+nR0vyPV5V2zU7ldxEffxleMNJe/u/wa
 nP7Dlu8hizCFycvdWm324kZbmZp9ISxqBf3dIHmRH8uGvV4zCzNxOwjwZIkIUMAtjfSt
 Pky3ncdQ0Spf5cp6/ULa3RZyAbiPY8YddPAl316HSwmwVM/WJFCLljhwGA/O4hzRpBcV Ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 33qcpu95ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 08:12:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08P8AWZn150501;
        Fri, 25 Sep 2020 08:12:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 33nurxerpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 08:12:49 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08P8Cm3w017191;
        Fri, 25 Sep 2020 08:12:48 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 01:12:48 -0700
Subject: Re: [PATCH 1/2] btrfs: drop never met condition of disk_total_bytes
 == 0
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, dsterba@suse.com
References: <cover.1600940809.git.anand.jain@oracle.com>
 <4fea8a706aedf7407d6af7a545126511168e15f5.1600940809.git.anand.jain@oracle.com>
 <c9e538dd-c039-478c-d677-0e9dd95cfc39@suse.com>
 <bed38208-67ff-ac66-187e-7e8ad91e1968@oracle.com>
 <b7c8399b-e410-8748-d1f3-f8603a8980ae@suse.com>
 <e8b066ae-8436-d8b1-049b-2eb83ff47da4@oracle.com>
 <afb34443-5bbb-2ddd-8676-0ac33b306cc9@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ac2b36de-272b-02e6-e9d4-86a0c0d3df29@oracle.com>
Date:   Fri, 25 Sep 2020 16:12:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <afb34443-5bbb-2ddd-8676-0ac33b306cc9@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250055
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/9/20 3:56 pm, Nikolay Borisov wrote:
> 
> 
> On 25.09.20 г. 10:33 ч., Anand Jain wrote:
>>
>>
> <snip>
> 
>>
>> Even this is wrong. Generally seed's devid is 1, and
>> btrfs_verify_dev_extents() starts verifying from the dev object id = 1.
>> So typically, the seed will be the first device that gets verified. As
>> btrfs_read_chunk_tree() is called before btrfs_verify_dev_extents() so
>> the btrfs_device is properly initialized before the verify check.
>>
>> 2817 int __cold open_ctree
>>
>> 3073         ret = btrfs_read_chunk_tree(fs_info);  <-- seed init
>> ::
>> 3106         ret = btrfs_verify_dev_extents(fs_info);
> 
> 
> Fair, I missed that btrfs_find_device can also return a device from
> fs_info->seed_list because it searches it as well. > So this indeed means
> all devices are initialized by fill_device_from_item so :

Oh. The btrfs_find_device(). Yep something was missing in what you said
I wasn't sure what. But now it makes sense.

> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Thanks!

-Anand

> Still I think this mechanism ought to be explicitly described in the
> changelog i.e mentioning that btrfs_find_device also returns seed devices.
> 
> 
>>
>>
>> Thanks, Anand
>>
>>>
>>> <snip>
>>>
>>

