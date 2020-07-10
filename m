Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223A921BA07
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGJPyZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 11:54:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53622 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJPyZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 11:54:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06AFqhfi050860
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 15:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=SXaD6iljuZenC1FMjyemCNTnzFp3JEZY6NlMRzL1vko=;
 b=yNFwJl1bucwcRpAs0K6SU/UposvqRJ8OjExhOz8amqmpOGMMC6z8VGRGyCwAxF1kpwX+
 8faZHWSbJH0gWPUjVwzjbSX0CFrxvMpQla0xLNXRson4MqW23aZ3eoTdm6DftVQDrNpZ
 R0SvqJGlQnYHIw3CJ68NIP9YK7sNiU+4jC+a8wrYMS4Yn2H+iAklAQcUPwS1q9K9x59p
 8Xpjd//sxu/qyHvbF2vFA/qo4FrwwfQj3B/HbOlt9bZJBk3uQeh4ZIaZa3j2nmncKqsl
 edx5DifFo2LivH0tzj3oHGHDTeIlN1cNpQpQQM7bVNEeQzHPoMXgbU2XwCZb/6OWlvJf lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 325y0ar8yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 15:54:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06AFrPN7091465
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 15:54:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 325k3kj1ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 15:54:23 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06AFsM7u007302
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 15:54:22 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Jul 2020 08:54:22 -0700
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs_show_devname don't traverse into the seed fsid
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y2nrtlhk.fsf@ca-mkp.ca.oracle.com>
References: <20200710063738.28368-1-anand.jain@oracle.com>
Date:   Fri, 10 Jul 2020 11:54:20 -0400
In-Reply-To: <20200710063738.28368-1-anand.jain@oracle.com> (Anand Jain's
        message of "Fri, 10 Jul 2020 14:37:38 +0800")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9678 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=983 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007100108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9678 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 mlxlogscore=985
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=1
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100108
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Anand,

> So instead, do not traverse through the seed devices, just show the
> lowest devid in the sprouted fsid.

Reported-by: Martin K. Petersen <martin.petersen@oracle.com>
Tested-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
