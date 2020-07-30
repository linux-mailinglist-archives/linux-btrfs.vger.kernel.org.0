Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44265232AFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 06:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgG3Ebr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 00:31:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42376 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgG3Ebr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 00:31:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06U4Rh88006931;
        Thu, 30 Jul 2020 04:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=w/IaYw0QsIeqxmZ8qthZqpZR35FfiU+PazaFyzCa9Lw=;
 b=TWvrp4LkISzk4gMcLsWE+c7gI2fGm19T0FupWcdGnWHrqrsEdjMVcqYBFw/JuQ/IzHzB
 q1mZSZHy6UgJOfNjp2gD7n/1lp6Ba6NYWybwJ4ohxeSQ3NMjDGqlgSqJklM7zUzww1zF
 7FjQnDS5bfofZWEi6zGGIxn6+GHB6YOMgBJypONtM2tZ6EYWF9eir8zbiocxT8k9u/Rp
 Gt2T2+suh3uFDqUljzZO4I0Oue5ZSsKHhqh4/968i7eeZNuyEWSOiRMYuygKE7TOo5Pt
 sLNnxhcvol91q+SFc3cE0MCGG2UAp9RWPdNYMcOn/AhOHkH8LJuKNRaQg5WYXJVOC3Fq xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32hu1jsct4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 04:31:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06U4Se17181914;
        Thu, 30 Jul 2020 04:31:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32hu5w3y3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 04:31:42 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06U4VeLf008171;
        Thu, 30 Jul 2020 04:31:41 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 21:31:40 -0700
Subject: Re: [PATCH 2/4] btrfs: Refactor locked condition in
 btrfs_init_new_device
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200722080925.6802-1-nborisov@suse.com>
 <20200722080925.6802-3-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f1953d5b-4c1f-f637-512f-fe715a9b85be@oracle.com>
Date:   Thu, 30 Jul 2020 12:31:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200722080925.6802-3-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300032
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300032
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/7/20 4:09 pm, Nikolay Borisov wrote:
> Invert unlocked to locked and exploit the fact it can only ever be
> modified if we are adding a new device to a seed filesystem. This allows
> to simplify the check in error: label. No semantics changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

