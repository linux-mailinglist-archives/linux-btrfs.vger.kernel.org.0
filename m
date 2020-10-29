Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E936629F542
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 20:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJ2Tab (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 15:30:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44220 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgJ2Tab (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 15:30:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TJSjVS160596;
        Thu, 29 Oct 2020 19:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3oridU6T0mWFtEKztztevnuWpB0acWj+ZWAWpvwrArM=;
 b=KJPw0Yv54Ys8tXZCZAjIWLaGT/YZ1lOQmLpqdGFbPsZWkAJ8f1BNCfCRMhNywZeXmLL3
 EtYNVdHIpyY9hHElCs7RCYMBnrsf7aV5s9r19QXtxdtt1Y48Kjf/4qhJqcPiG+c2tRat
 /NMThyaMhjvEF0W0TtTTuYLvbTVbyH1WWjwbL1nwhMunSTZ5PHoHr92QlKrGFoppp7Kt
 96SIhmxB9dk6NEvhZ1vJ2r9Yk3dhHEaFaeL5zAHcx3eKXkvMUa8eRwUE5hb27C2QJ1+8
 SK5b4wfjx1xtB0T870W1cstJLvDVV2ZhX1npKLWETPQfQy/1mzGc2wMRwpvQiwj7bMhu Rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34dgm4c8gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 19:30:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TJUKiC160118;
        Thu, 29 Oct 2020 19:30:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34cx60vmf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 19:30:24 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09TJUE20018432;
        Thu, 29 Oct 2020 19:30:14 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 12:30:13 -0700
Subject: Re: [PATCH v10 3/3] btrfs: create read policy sysfs attribute, pid
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1603884513.git.anand.jain@oracle.com>
 <52a41497534bdaa301adc57d61ea3632ab65f2c6.1603884513.git.anand.jain@oracle.com>
 <20201029164535.GO6756@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a74b6fdd-55dc-e890-78df-c19d0430b4a2@oracle.com>
Date:   Fri, 30 Oct 2020 03:30:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201029164535.GO6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290133
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/10/20 12:45 am, David Sterba wrote:
> On Wed, Oct 28, 2020 at 09:14:47PM +0800, Anand Jain wrote:
>> +static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>> +				       struct kobj_attribute *a,
>> +				       const char *buf, size_t len)
>> +{
>> +	int i;
>> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
>> +
>> +	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
>> +		if (btrfs_strmatch(buf, btrfs_read_policy_name[i])) {
> 
> Does sysfs guarantee that the buf is nul terminated string or that it
> contains a null at all? Because if not, the skip_space step of strmatch
> could run out of the buffer.
> 

It does

[  173.555507]  ? btrfs_read_policy_store+0x3e/0x12d [btrfs]
[  173.555541]  ? kobj_attr_store+0x16/0x30
[  173.555562]  ? sysfs_kf_write+0x54/0x80
[  173.555582]  ? kernfs_fop_write+0xfa/0x290
[  173.555611]  ? vfs_write+0xee/0x2f0
[  173.555641]  ? ksys_write+0x80/0x170
[  173.555671]  ? __x64_sys_write+0x1e/0x30
[  173.555692]  ? do_syscall_64+0x4b/0x80
[  173.555708]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9


static ssize_t kernfs_fop_write(struct file *file, const char __user 
*user_buf,
                                 size_t count, loff_t *ppos)
{
::
         buf[len] = '\0';        /* guarantee string termination */


Thanks, Anand
