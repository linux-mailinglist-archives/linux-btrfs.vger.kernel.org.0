Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BDC26822C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 02:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgINAge (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Sep 2020 20:36:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34616 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgINAg2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Sep 2020 20:36:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08E0aM3J036337;
        Mon, 14 Sep 2020 00:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8au3AxKrOUwYd2WsHaFmLLHTgmGnY1C4E28oQVmzZmk=;
 b=WvFiqJUW4E/2D3LiST/+I1BQEPK82KSfO8TYEIltLjTBBuAbWViZPtXiZoBR9XahcSqf
 vYkmzPpSe8He3n7Fnz1FumgTVDGFkRkLyoRKh1ugDNOHAE6kZ3qRj16eYvYnZY7EKQYr
 A/wemcytaDQF3hZ8iXH9bUY3mHrU5IdAxzBPG6Tz5n8HCv/agwd5693JHfBDA6/ps86F
 hfMK/iYZO3kFF4/BRK2qlKsZ7SArtSlu3P+evfHHUU3V0SqTQwX7IWJ9ZnbZVu7NacSB
 idaDNhRnAvEiDTkUWWHBbFWgFDDhc3D0r05k6aA1RISaaUbdRCtkHNE6YU9fGzi0tqjw Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 33gnrqkn55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Sep 2020 00:36:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08E0ZiHS187658;
        Mon, 14 Sep 2020 00:36:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33hm2vyek4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 00:36:22 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08E0aKaE030508;
        Mon, 14 Sep 2020 00:36:20 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Sep 2020 00:36:20 +0000
Subject: Re: Detecting new partitions fails after "btrfs device scan --forget"
To:     Jonas Zeiger <jonas.zeiger@talpidae.net>,
        linux-btrfs@vger.kernel.org
References: <1ab4e230fe413c033b195bbd0f7e1db0@talpidae.net>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <40e2315e-e60e-6161-ceb7-acd8b8a4e4a0@oracle.com>
Date:   Mon, 14 Sep 2020 08:36:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1ab4e230fe413c033b195bbd0f7e1db0@talpidae.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9743 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009140004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9743 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140004
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> /dev/sda have been 
> written, but we have been unable to inform the kernel of the change, 
> probably because it/they are in use.  As a result, the old partition(s) 
> will remain in use.  You should reboot now before making further changes.
> 
> The partitions do not become visible so the deployment can't continue.

The forget subcommand does not touch the mounted device, and it frees 
only the unmounted or unopened btrfs devices from its kernel memory.

Now the error seems to be about the device being kept open. Can you find 
out who did not close it?
