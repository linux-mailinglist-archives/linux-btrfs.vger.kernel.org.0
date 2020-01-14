Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09E713A075
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 06:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgANFPk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 00:15:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36468 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANFPk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 00:15:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E5D7Tf072151;
        Tue, 14 Jan 2020 05:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=bD+la0i8wL3kh+/S4dutfv6fHmYFqVYUS1UEIlvLlG0=;
 b=oDWqjuYhJeLqMC/CXdz7xod1GGhv2LW7jdom+qNXCGEVz6W6gybt8MkHnS/sn0WXlCOs
 DSGhuve94I++82UsA2CNGHBzlPBUpxD8yF5z/iwMFxJaubt68dDNknjOLIqneJGl+p95
 ZqdN+m1dXXjRJ9nCDuIZZ6x3oUuTZJH65swHmSeVNR/43c25gB3+x8gVq2qxD3l+YFPW
 F3kWyo9EMVogrwaGBPkbmdD9HBBQlMwDysVg2ExcKD6Qv6Q5OuM3rBnBUz1TDASI3YkC
 M23OCrnhxUtHkUW/ltoHqfM7A/uFa3lvLu4eypsrVhp672SvQMfP/4jX8kudH8wj8UB1 0A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xf73tkg5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 05:15:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E5EIT7187627;
        Tue, 14 Jan 2020 05:15:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xh2tn2p74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 05:15:36 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00E5FZ5Z017119;
        Tue, 14 Jan 2020 05:15:35 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 21:15:35 -0800
Subject: Re: [PATCH 1/2] btrfs: open code log helpers in device_list_add()
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200110090555.7049-1-anand.jain@oracle.com>
 <20200110164212.GQ3929@twin.jikos.cz>
 <ec1a6bed-ecea-c7f6-2567-9626590bc9c7@oracle.com>
 <20200113162521.GW3929@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <01be0d25-e7e6-663e-3e49-82a248e7cc1e@oracle.com>
Date:   Tue, 14 Jan 2020 13:15:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200113162521.GW3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140045
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/1/20 12:25 AM, David Sterba wrote:
> On Sat, Jan 11, 2020 at 07:41:51AM +0800, Anand Jain wrote:
>>>>    			if (device->bdev != path_bdev) {
>>>>    				bdput(path_bdev);
>>>>    				mutex_unlock(&fs_devices->device_list_mutex);
>>>> -				btrfs_warn_in_rcu(device->fs_info,
>>>> -			"duplicate device fsid:devid for %pU:%llu old:%s new:%s",
>>>> +				rcu_read_lock();
>>>> +				printk_ratelimited(
>>>
>>> Avoiding fs_info here is correct but we don't want to use raw printk or
>>> printk_ratelimited anywhere.
>>>
>>
>>    I think I discussed this a long time back, that we should rather pass
>>    fs_devices in btrfs_warn_in_rcu().
>>
>>    I am ok to make such a change, are you ok?
> 
> No, this does not sound right at all. Why should be btrfs_warn_in_rcu
> special from the other message callbacks? We need to fix one context, so
> let's find something less hacky.
> 
>>    Or I wonder if there is
>>    any other way?
> 
> We could add a fs_info stub that will get recognized in btrfs_printk.
> Eg.
> 
> #define	NO_FS_INFO		((void*)0x1)
> 
> btrfs_printk() {
> 
> 	if (fs_info == NULL)
> 		devname = "<unknown>";
> 	else if (fs_info == NO_FS_INFO)
> 		devname = "...";
> 	else
> 		devname = fs_info->sb->sb_id;
> 

Yeah it makes sense to me. Patches sent.

Thanks, Anand
