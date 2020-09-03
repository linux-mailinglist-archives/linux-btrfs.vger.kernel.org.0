Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D7425C080
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 13:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgICLnD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 07:43:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59272 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgICLmV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 07:42:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 083BdIcF070792;
        Thu, 3 Sep 2020 11:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=mZ3ILnU1oKWRYhzP8Ui1jcNWmIfCZRQdEDGKok56vKQ=;
 b=spnhteKsnj7LwjHoNRM8J8cbF8UOfXKUwtfkJzEOxgX65xGPwBqTqYjjkVUTpKxStfog
 Xh9BGW70AKYv9Ge2Yw4jbA+Ax3C2QhNZXtAo914cJAFiDJqx5UiTXF6ioso1rtGcoFs8
 Zm4271p38YiSvvN66Ph5hfOENqyZOBnOLJFd7i9RbYf+sK2oT0sawmQiKfPsCqR4jXXt
 1WrcifM0UGudyz/6cWitjkSm6QvPv0l8FTh2bT22rJn5FVAK2spU2t9iNgArjvc4+OMt
 aWy1Mmsd08cJNG5yWXArdg/3+XkhVNW7UyJZBhSfJhVToqIxL73IulxA7x0avAIYuJi/ lQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 337eer87w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Sep 2020 11:42:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 083Bdnpm093186;
        Thu, 3 Sep 2020 11:42:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3380y1s4fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Sep 2020 11:42:13 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 083BgDs9006516;
        Thu, 3 Sep 2020 11:42:13 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 04:42:12 -0700
Subject: Re: [PATCH 2/4] btrfs: init sysfs for devices outside of the
 chunk_mutex
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1598996236.git.josef@toxicpanda.com>
 <5dccee8f9d7fe7b5072090327854fcbfdbd45b28.1598996236.git.josef@toxicpanda.com>
 <79ace2bf-6f01-39ee-0566-727182c5ff85@oracle.com>
 <20200902174549.GL28318@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <fbab9f23-8c59-d3a1-c7ed-1f073fbc9362@oracle.com>
Date:   Thu, 3 Sep 2020 19:42:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200902174549.GL28318@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030109
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 1:45 am, David Sterba wrote:
> On Wed, Sep 02, 2020 at 02:21:31PM +0800, Anand Jain wrote:
>>> @@ -2609,6 +2606,10 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>>    	btrfs_clear_space_info_full(fs_info);
>>>    
>>>    	mutex_unlock(&fs_info->chunk_mutex);
>>> +
>>> +	/* add sysfs device entry */
>>> +	btrfs_sysfs_add_devices_dir(fs_devices, device);
>>> +
>>>    	mutex_unlock(&fs_devices->device_list_mutex);
>>>    
>>>    	if (seeding_dev) {
>>>
>>
>> Strange we should get this splat when btrfs_sysfs_add_devices_dir()
>> already has implicit GFP_NOFS allocation scope right? What did I
>> miss?
> 
> The problem is the sysfs' kernfs_mutex, all sysfs allocations are
> GFP_KERNEL thus it can grab fs_reclaim at some point.
> 

Oh. Thanks.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Anand
