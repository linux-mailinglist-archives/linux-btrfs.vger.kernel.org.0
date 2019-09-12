Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68372B0CE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 12:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfILK2u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 06:28:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57336 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbfILK2t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 06:28:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8CASilP174041;
        Thu, 12 Sep 2019 10:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=YQZtYBDgbt0ISgq54B3JkvS4j2NRxVXhkib0yAMrNak=;
 b=Nh4SI5rn/ftVYZMUCWEqrF9jMKczo1fpegkG+U0Iayjrg4gI5T088d/MRx/i7CC6JHSJ
 59rUcfKDQnwSUMX+eH74LyjyL39xR21/4bP/bk91XRgIqMOnmfw5T1mZpvsCIhWJim4P
 xLKs6T/rcNTDY9cNCeV1bEUCQ8LYWJp6TKTsNB/woWljMd8nbHaRjX2lx615aqM5det6
 sQ7TGVz/GnPxFifOYhdYo4QIzkyTZBUC16Zxqjm8BLt2GEvYTSTHe+HpPRTTH53Dr99N
 UwccIy0FhJFzM7ShjNz1Pcxo/wYN/qUT6ow9Zpl3YW6y8ICacxaQqWS32sTs0omYytx/ JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2uw1jkqh0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 10:28:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8CASd9Z098934;
        Thu, 12 Sep 2019 10:28:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2uy8w9s6tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 10:28:41 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8CARTXl005594;
        Thu, 12 Sep 2019 10:27:29 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Sep 2019 03:27:29 -0700
Subject: Re: [PATCH] btrfs: volumes: Allow missing devices to be writeable
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190829071731.11521-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <7e9294de-1859-886a-3ac3-9659e70463d7@oracle.com>
Date:   Thu, 12 Sep 2019 18:27:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190829071731.11521-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909120111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909120111
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



There is previous work [1]

[1]
https://lore.kernel.org/linux-btrfs/1461812780-538-1-git-send-email-anand.jain@oracle.com/


I guess it was on purpose that missing device is not part of
alloc chunk, so to have lesser impact due to writehole bug.
My target is to fix the writehole first, and then this and
other bugs.

> [FIX]
> Just consider the missing devices as WRITABLE, so we allocate new chunks
> on them to maintain old profiles.

  IMO. In a 3-disks raid1 when one of the disk fails, we still
  need the _new writes_ not to be degraded. Just use two available
  disks. This fix fails that idea which is being followed now.

Thanks, Anand
