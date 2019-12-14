Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90D11EF34
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 01:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLNA0e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 19:26:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59046 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfLNA0e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 19:26:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBE09NTC044734;
        Sat, 14 Dec 2019 00:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=ozkC4rl3g15bsldcQTV9jRtOnqrrAvVMva0uCByfsNk=;
 b=Eh+rLdrWH42k9MzbMxLLsUXPcYGKqoPCWln3+iPLRIlrQPB+NqS9ppDXbIG/i3nKGys1
 hf0oFBxradmM+SYdced+6v3A7aiG50pS0OvIAUaGnrHo2mwZbW61/psc6qTBGIJxauVQ
 eEmMQzSbQcWD+ZGANlvusimHOsn29VCknI05mKqlNwbXGZ/pasizcXxhibQ/bE91/ucl
 Wlhk+qtB/gi49j7r9wc9hIFIyLBac1jeuK/PzspNNIaWSka0K0LXieVfmiIsnkb01Vh9
 xLC7yjapzR5IwPK6cI6wiffKjAJyPqz7AO6f9nFJMTPzxmjqkai4CS0bJDvuY+FyCfTG GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wrw4nrru9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Dec 2019 00:26:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBE09c0a061876;
        Sat, 14 Dec 2019 00:26:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wvdwru2y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Dec 2019 00:26:28 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBE0QSjW003608;
        Sat, 14 Dec 2019 00:26:28 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 16:26:27 -0800
Subject: Re: [PATCH 4/4] btrfs: sysfs, add devid/dev_state kobject and
 attribute
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205112706.8125-5-anand.jain@oracle.com>
 <20191205142148.GQ2734@twin.jikos.cz>
 <78560abd-7d85-c95d-ed76-7810b1d03789@oracle.com>
 <20191205151428.GS2734@twin.jikos.cz>
 <673babd8-90ec-2f7e-532a-df8c98a844cf@oracle.com>
 <8bd3d9b9-11b1-4c9a-8b59-ccfe0c6d92c4@oracle.com>
 <20191213164332.GA3929@twin.jikos.cz> <20191213170215.GB3929@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1faa5860-130a-9f3c-3e44-724ce9a26adb@oracle.com>
Date:   Sat, 14 Dec 2019 08:26:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191213170215.GB3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912140000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912140000
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14/12/19 1:02 AM, David Sterba wrote:
> On Fri, Dec 13, 2019 at 05:43:32PM +0100, David Sterba wrote:
>>>    Looked into this further, actually we don't need any lock here
>>>    the device delete thread which calls kobject_put() makes sure
>>>    sysfs read is closed. So an existing sysfs read thread will have
>>>    to complete before device free.
>>>
>>>
>>>         CPU1                                   CPU2
>>>
>>>    btrfs_rm_device
>>>                                             open file
>>>       btrfs_sysfs_rm_device_link
>>>                                             call read, access freed device
>>>         sysfs waits for the open file
>>>         to close.
>>
>> How exactly does sysfs wait for the device? Is it eg wait_event checking
>> number of references? If the file stays open by an evil process is it
>> going to block the device removal indefinitelly?
> 
> Yeah, sysfs waits until the file is closed. Eg. umount can be stalled
> that way too.
> 

  And similar to umount, I don't think we should return EBUSY
  for btrfs_rm_device if the device sysfs attribute is opened,
  as sysfs show attributes are non blocking and would be completed
  in the timely manner.

regards, Anand
