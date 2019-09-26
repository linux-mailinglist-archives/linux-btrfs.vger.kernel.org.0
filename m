Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E327BEC98
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 09:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfIZHfO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 03:35:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45274 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfIZHfO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 03:35:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8Q7YS6V062036;
        Thu, 26 Sep 2019 07:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=kDvzriFvgLgDzsCphtMAGUpv8k/ad40Ph+cMqKRwfy8=;
 b=o0DURz/F7BzsARrGr/obxC7Fzeybtiuu4NgN4KjcQLrTGmf7s70Sr28ZecwYldGPT5OD
 L0UCTclArtF9Zk6DKPlYaf8fdADJo2In49Toj6gIg0vQKDXa45xEikSA+5o4PacDvxn2
 J5ii9Z1DD/i+PEIJ5lgd76HQCIAMaB7lW6u32YQD1YeuNbjrlmBL5cWme3BO4cPhS4gu
 DtSqiV+rf0d3jQJESFrKf8IyNFcWBxYSURPDZjm5aA/JfaTCkL26hTxm0ew3uTm6KV9v
 ATRe83WjySJiuAQBuUZ2HUMDBRVdSjPA+m6nSmLU7sV4leKmDJ3nao33sbL3RUg/g8AG wA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2v5btq9sjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 07:35:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8Q7XWml090186;
        Thu, 26 Sep 2019 07:35:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2v82qbntys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 07:35:08 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8Q7Z7HT025933;
        Thu, 26 Sep 2019 07:35:07 GMT
Received: from [10.186.52.87] (/10.186.52.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Sep 2019 00:35:07 -0700
Subject: Re: [PATCH] btrfs: Add regression test for SINGLE profile conversion
To:     Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com, guaneryu@gmail.com
References: <20190926072635.9310-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <87fd085e-c193-ef1e-f644-60eac1fd3c98@oracle.com>
Date:   Thu, 26 Sep 2019 15:34:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926072635.9310-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=988
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909260073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909260073
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9/26/19 3:26 PM, Nikolay Borisov wrote:
> This is a regression test for the bug fixed by
> 'btrfs: Fix a regression which we can't convert to SINGLE profile'
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
