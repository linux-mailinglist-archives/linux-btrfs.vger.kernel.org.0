Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F31153E6B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 06:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgBFF6e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 00:58:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45948 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgBFF6e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 00:58:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0165r7Eg074086;
        Thu, 6 Feb 2020 05:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Pmre9gz6S4BAJpaRQ/OA4PsZ1YN/YxVwtPfyFnh2M9c=;
 b=qaREi7TgD2MmIVfeN9Cm3Gqgc8WDfM0MkCldrd7SuVt1/OyJnDZ/XEsbCU3Z+uwXfV0p
 +Ofxc5fvDHzNjjK53d0SHWn2kQQVFT9e4opPOr8Q4unsB369oaDOG+iYk3Q4yUqXYRSi
 7bZ4f6w2zfkXD4iOP0wYwKakxJQGX0XnrfaE8UfSFCIxgCbN/TJnSLDqDorFkpPBjKT5
 p+Rmy/qL9hLRLNntcThX+87bFrv9+aaTufr0aSfwRAohOHcJmTv2Ex3cVUp6RPRZWcDe
 l2yLtz19XrvHYl4cMxCRUjrQCml6ShzWWg8EsLHkoyb+hievpKEGnM60IndBVX5agfej HQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Pmre9gz6S4BAJpaRQ/OA4PsZ1YN/YxVwtPfyFnh2M9c=;
 b=XcyDSvVeuDn0a9w5sf2KDYT0Z/qzfe6PgzhI8MB/DUaRglQ8ZEboraKo6EVhTeygjWsO
 qdDZ6oNEd8aqczoL1AuUOBbiE4ucPAT9v4xX18jC9cX2Dfq+vatDdE8QPbmJeZjTgUyN
 cwY9DPxxYY2sHdbvqE+hFvPf4ofIj79OSyjJ0Mb6Yf4E7HLYEhE9hGkxy7uBUO6TdoHS
 uukeZNi7eSsyAqWxhyncqEvly+X7UgT2+bZbsZbMZPzSfyuGu/Fee9Yy7xonQU3C0l0m
 njx0Urcf5K09lLjZU/nV4Q4cesa97RiU+pevFXh1hGv0LeeaGT6gqSbKSuVt+qjJtqQq Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xykbp7f57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 05:58:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0165rqMC179407;
        Thu, 6 Feb 2020 05:58:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xykcb4xdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 05:58:30 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0165wT4J029010;
        Thu, 6 Feb 2020 05:58:29 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 21:58:29 -0800
Subject: Re: [PATCH 2/8] btrfs: drop argument tree from submit_extent_page
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1580925977.git.dsterba@suse.com>
 <a54487df38bbbd4f6149b2a7bbe86247fe5c532e.1580925977.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <150ff69f-996e-7cfb-02ad-2193224f9b49@oracle.com>
Date:   Thu, 6 Feb 2020 13:58:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a54487df38bbbd4f6149b2a7bbe86247fe5c532e.1580925977.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060046
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 2:09 AM, David Sterba wrote:
> Now that we're sure the tree from argument is same as the one we can get
> from the page's inode io_tree,


> drop the redundant argument.

  I think there is/was a plan to drop the btree inode? should we need
  this argument if the plan is still on? or any idea if it still can
  be implemented without this argument?

Thanks, Anand
