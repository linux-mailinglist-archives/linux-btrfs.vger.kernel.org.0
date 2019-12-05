Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9EE1142DF
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 15:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfLEOjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 09:39:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57310 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbfLEOjW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 09:39:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5EdHmi038716;
        Thu, 5 Dec 2019 14:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=8dt0wuvwYT/Lo/DmgDwbDbMjmwK746rSv0FbBrT5L7w=;
 b=pZ0977njeezpLRNLChudmwEsXeFNx7I82ge9Mf1vfCkpcFHn7v86ztG5TGDlITV5QbMV
 KsIN13G7lxEj8vN+azhTelYeWnbU15cXYKdY+a8QLPEOQqJ9jUUNrLDetiyMFvyyRljq
 NJ6YZcJWFQq93Db8jZc6jNLz8e/T+k9KkIu0JKJ1hk/u1kSpOPOu7ovfx2foAUFJUzn7
 AuR8p4foz6pomU/VuRG5A8DyJMjvn2UnNAEtJbxFMOifObRvlc0vc5xEVEomzxbVWHm1
 NKMiCsoq4XmtA9dPhXCG6jmlpMcyPPMc6uDA22lfbH51b71jz16XaDTu9ClUWS8chPNL pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wkgcqng3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 14:39:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5Ed4F8062640;
        Thu, 5 Dec 2019 14:39:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2wpp8hysd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 14:39:13 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB5Ecqvt032114;
        Thu, 5 Dec 2019 14:38:52 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 06:38:52 -0800
Subject: Re: [PATCH 4/4] btrfs: sysfs, add devid/dev_state kobject and
 attribute
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205112706.8125-5-anand.jain@oracle.com>
 <20191205141024.GP2734@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <fa6882c2-53a4-df61-36a4-f3932d69212b@oracle.com>
Date:   Thu, 5 Dec 2019 22:38:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191205141024.GP2734@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050123
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/5/19 10:10 PM, David Sterba wrote:
> On Thu, Dec 05, 2019 at 07:27:06PM +0800, Anand Jain wrote:
>> +static void btrfs_dev_state_to_str(struct btrfs_device *device, char *dev_state_str, size_t n)
>> +{
>> +	int state;
>> +	const char *btrfs_dev_states[] = { "WRITEABLE", "IN_FS_METADATA",
>> +					   "MISSING", "REPLACE_TGT", "FLUSHING"
>> +					 };
>> +
>> +	n = n - strlen(dev_state_str) - 1;
>> +
>> +	for (state = 0; state < ARRAY_SIZE(btrfs_dev_states); state++) {
>> +		if (test_bit(state, &device->dev_state)) {
>> +			if (strlen(dev_state_str))
>> +				strncat(dev_state_str, " ", n);
>> +			strncat(dev_state_str, btrfs_dev_states[state], n);
>> +		}
>> +	}
>> +	strncat(dev_state_str, "\n", n);
> 
> Please use the snprintf way as in supported_checksums_show and not the
> str* functions.
> 

Ok. Will fix.

Thanks, Anand
