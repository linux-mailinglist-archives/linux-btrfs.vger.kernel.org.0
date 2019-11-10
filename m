Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D5EF6724
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2019 04:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfKJDth (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Nov 2019 22:49:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:32808 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfKJDth (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Nov 2019 22:49:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAA3mx0B109082;
        Sun, 10 Nov 2019 03:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=7JX2DnFJxlq8yukxGCTS1cU7tVbRbsAYyX6IdHjTXhc=;
 b=nJb37wbeiw6X+d/SkasdLnaDiLLoklifgtNhuhEXMumenZBq1raYUPLvkgT6ib1bpBmU
 wuEHTh4IwWXTrEaK+FO1r2Pp4R7jCosqXgRcsVU7sCUTgwXUai9jbyyoT047DBrtuSJL
 k9zXW3MpGroU43qHwSw5ZYFhePQtf5NrS4SDyBA4fGatuXyojWy9F/YNbphwaiYdtK4i
 v0OpyxQAGhhUHypfrvy/JUIlv5UlgzQ20FahumLdAMaDppCh6mssv8ZBD0yqFNS+khZ7
 2rzbGDEmWQLP3LoqL9jKIjxln2rS2z5UQroFUsDs2Y7apuZstv730+dopkEOHEHUGIlM xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w5p3qa95x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Nov 2019 03:49:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAA3nX3s009840;
        Sun, 10 Nov 2019 03:49:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w67kxprv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Nov 2019 03:49:32 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAA3mhsT017845;
        Sun, 10 Nov 2019 03:48:43 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 09 Nov 2019 19:48:43 -0800
Subject: Re: Unable to delete device
To:     Alex Powell <alexj.powellalt@googlemail.com>,
        linux-btrfs@vger.kernel.org
References: <CAKGv6CrZ6bpMFtWJ5grJ8tsuV1GehEP07QaAmyZWkhj-ixTchw@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c0479d4c-5163-8a5c-3a0a-58a4f5f0f75f@oracle.com>
Date:   Sun, 10 Nov 2019 11:48:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKGv6CrZ6bpMFtWJ5grJ8tsuV1GehEP07QaAmyZWkhj-ixTchw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9436 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911100036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9436 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911100036
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/10/19 9:14 AM, Alex Powell wrote:
> Hi all,
> I had a disk fail on my BTRFS RAID5 array. It is still mounting but
> there are bad sectors which will switch the array to read only mode
> when used.
> 
> I used "btrfs device delete /dev/sdd /mnt/data" to remove it from the
> array. However it seems that it is only partially removing it from the
> array and when it gets to the bad sectors it fails.
> 
> localhost ~ # btrfs device delete /dev/sdd /mnt/data
> ERROR: error removing device '/dev/sdd': Input/output error

  Could you please provide 'btrfs dev df <mnt>' we need to know the
  allocated chunk profiles.

  If its only RAID5, we continue to reconstruct the RAID5 for failed IO
  during the delete. But here its may be that there are IO errors from
  more than one device in the RAID5, which unfortunately is a fatal
  error.

  You could confirm the devices involved in the errors from the syslog
  and 'btrfs device stats <mnt>'.

> What is best practice for removing the drive from the array in this situation?

  Device replace is better as it will continue to fulfill the raid5
  redundancy promises. Yeah but you need the spare device, which is
  a good practice in the data centers.

HTH.

Thanks, Anand

> Kind Regards,
> Alex Powell
> 



