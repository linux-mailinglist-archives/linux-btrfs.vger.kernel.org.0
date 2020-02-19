Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC0F16438C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 12:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSLlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 06:41:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37764 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgBSLlF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 06:41:05 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JBYMe7135816;
        Wed, 19 Feb 2020 11:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9gB/i3q+3MIc/ooXdVAJ3dLVnPNDQEmcldxnW6WGy0k=;
 b=zUX2y4fwWBm0fgQKYWDl375gHQwsiGXdE0yMTCp6auPemXXI+kEfAg0cEzmpxUS0upe4
 45kEtng8r5iRSS8EqjF7uQMz8s+ST0G7Xh6lAGtjPxj8AMIL7E/XA+N6xf/mx/iVZmSZ
 Lqx5rCgTHk2mWNAWabhFjndF6GJrS/aABabQv//89JufNjJGNji+QnZj0eTad7AUhC7n
 6vkqf3qdgCi4hIeZidHMFRVIIp4ekETVBqk8pI80qiaCkev++iCrMm3bJsjX9z2WXjzJ
 gZfZ/TIf5n5FubWL/XutT3X5/JpQ0SA64+CfQkGjTmJwFZFpfzhSYDgCZhuFss/nRtrp mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y8ud12dwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 11:40:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JBVnsp186225;
        Wed, 19 Feb 2020 11:40:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y8ud507xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 11:40:58 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01JBevBI012902;
        Wed, 19 Feb 2020 11:40:57 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 03:40:57 -0800
Subject: Re: [PATCH v5 2/5] btrfs: create read policy framework
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-btrfs@vger.kernel.org,
        josef@toxicpanda.com, dsterba@suse.com
References: <1581937965-16569-3-git-send-email-anand.jain@oracle.com>
 <202002191535.zA4fBD3N%lkp@intel.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c06da00e-2cb2-806a-f441-6d5a29c7293c@oracle.com>
Date:   Wed, 19 Feb 2020 19:40:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <202002191535.zA4fBD3N%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1011 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190088
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>     In file included from fs/btrfs/volumes.c:18:0:
>     fs/btrfs/volumes.c: In function 'find_live_mirror':

>>> fs/btrfs/ctree.h:3143:4: warning: this statement may fall through [-Wimplicit-fallthrough=]

  This is not a bug. May be we can make the robot happy.

Thanks, Anand
