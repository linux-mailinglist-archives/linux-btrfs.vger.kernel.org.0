Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83960272223
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 13:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgIULTy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 07:19:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46256 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIULTx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 07:19:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LBJq6W142195;
        Mon, 21 Sep 2020 11:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kc0wMejO6+FYzrxYka//8OOZs47+Oi6AP8yiUy27IDw=;
 b=gnylYI449ftwTsdjiXjqsOzBo3I+/7P/FXTRIhHAiG1LPbmFH5uGpDBSh79krYe6b131
 xk7DJBGFUwRqOzLmuPC+HsFRj+rLpLZKqq1PaBtYn1EkNd7cfTC23DRG8e27ufdz0PSv
 iHdm1L6p/R7TeVqoRTS/TJb4RueB555zH9SrRk6ifGfG/p2qWGHm7L5sxZSIZ2EgDFiV
 tPGP51iRQILi//XNuHHyF62IpRe4wMVKIyLk6Wtq7oFLvgvK2/26iqZZZ3sdAASOKM8a
 rj52ujAhnU/mZazZxGkj+tLSaf/WY1K8tbntnmpUGikOzXisgfljxtKGlorHuitE72de OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33n9dqw2g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 11:19:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LBJmKU069279;
        Mon, 21 Sep 2020 11:19:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33nuw0j3bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 11:19:48 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08LBJi6a024617;
        Mon, 21 Sep 2020 11:19:44 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 04:19:44 -0700
Subject: Re: [PATCH] btrfs: free device without BTRFS_MAGIC
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
 <SN4PR0401MB35985D5EE98316CC15DBB5DB9B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e37d4e83-7e2f-3bd4-9e34-22c04a86b4f3@oracle.com>
Date:   Mon, 21 Sep 2020 19:19:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB35985D5EE98316CC15DBB5DB9B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210084
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21/9/20 6:52 pm, Johannes Thumshirn wrote:
> On 19/09/2020 04:53, Anand Jain wrote:
>> Fix is to return -ENODATA error code in btrfs_read_dev_one_super()
>> when BTRFS_MAGIC check fails, so that its parent open_fs_devices()
>> shall free the device in the mount-thread.
> 
> But now it doesn't only fail if the BTRFS_MAGIC check failed but also,
> if the offset of the superblock doesn't match the offset for the copy.
> 
> Sorry for not spotting this earlier.
> 


Here are the links to the older comments.

  https://patchwork.kernel.org/patch/11177085/
  https://patchwork.kernel.org/patch/11177081/

I am not sure if -ENODATA is ok. It is open to comments. If it is not ok
then suggestions better alternative will help.

You are right I didn't intend to include btrfs_super_bytenr(super) != 
bytenr under -ENODATA thanks for spotting. Will fix.
