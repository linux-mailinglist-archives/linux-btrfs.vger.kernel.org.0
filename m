Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54043164390
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 12:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgBSLmO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 06:42:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52334 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgBSLmO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 06:42:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JBfQjh029887;
        Wed, 19 Feb 2020 11:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+vjajekEh3qzLH/UqWsPVAnJQJeUHkHB9O3iddWY+Ts=;
 b=Xb6QolHBIwk8GQ9udZelSC8yxEANkXLPWzuR0xjQjFmUnxQ0UC5Dr6qFED/lkbSd9q2T
 vgwCk8izhWDmVrk1Ifcv9cFr4XyRFEZw3JHC5xoqnakkkQyE6CEI2PFcTTBNT1GUSxUx
 7bioZ5kZ7WYL4jk9ZtJP0Hblg7F7nxAtPSmZlkFdcXKZ/EFtorkvdihTpEyzSnQh6dHO
 eWoU2ouFErEBHKm5WchppgWsiAknNzHv01No+fKdwQaWpvALLsM7pY88D/Qrd0ZPvBHS
 2U/fOMCuLJkPvQYpJKe14DCS6XYpCaoDtfgaxyiZkEO36PKeKZqmybOmgb6OIQEAnuKq 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2y8udkadhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 11:42:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JBfkLj007976;
        Wed, 19 Feb 2020 11:42:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2y8ud314fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 11:42:07 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01JBg6h9013515;
        Wed, 19 Feb 2020 11:42:07 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 03:42:06 -0800
Subject: Re: [PATCH v5 0/5] readmirror feature (sysfs and in-memory only
 approach; with new read_policy device)
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com
References: <1581937965-16569-1-git-send-email-anand.jain@oracle.com>
 <20200218163547.GQ2902@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <95249fd3-9a6b-1b1a-744c-331795a22522@oracle.com>
Date:   Wed, 19 Feb 2020 19:42:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218163547.GQ2902@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190088
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> The last patch implementing the new policy needs explanation how it
> works so users can decide if this is the right read policy for the use
> case.

V6 adds more details.

HTH.

