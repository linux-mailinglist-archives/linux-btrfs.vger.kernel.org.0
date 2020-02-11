Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0AEC15894C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 06:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgBKFA1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 00:00:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39804 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgBKFA0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 00:00:26 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B4wO9C098145;
        Tue, 11 Feb 2020 05:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HB/KyC8ImCOs7qklpZuMZxkKVSRfAX7spt95qDH0tcs=;
 b=TX2VUA1Yd8qogRFNm03r3Yh1tSYhomX4J37tbhrD17XqgbNlDhU/z/fq31zS4CcarvEw
 1FpJm8SCHGmuBymnFaxAQejxbkmSbfz9NDSuy4782q+hqwBV0CuS3Qaumx8ZjkWlX+kd
 /A3i51OqL0FvG0SPhO9YqvkpEG4K9o9gfF5JnPiQGiI9Dft+9U8l5zesZno5Zi7RJwEr
 vEe8xuTnPxoBU47ZBaq2mLfdqrwjQ4ReHnAbnKW00X07Z4xNBUQF0sgs48H0rx99+6e0
 NEeSCKc/4WNjd+4KbYOB0sOjK96Go0OhiTu+KvtyovMB7j2eXiqwpiWQAHzLosE2iIfA tA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y2jx612xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 05:00:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B4w7HJ162455;
        Tue, 11 Feb 2020 05:00:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2y26hu82dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 05:00:18 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01B50GLO021677;
        Tue, 11 Feb 2020 05:00:16 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Feb 2020 21:00:16 -0800
Subject: Re: [PATCH 2/8] btrfs: drop argument tree from submit_extent_page
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1580925977.git.dsterba@suse.com>
 <a54487df38bbbd4f6149b2a7bbe86247fe5c532e.1580925977.git.dsterba@suse.com>
 <150ff69f-996e-7cfb-02ad-2193224f9b49@oracle.com>
 <20200206134733.GW2654@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e06ff045-7b3b-ea8c-1890-457d033b2c6f@oracle.com>
Date:   Tue, 11 Feb 2020 13:00:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206134733.GW2654@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110034
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110034
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2/6/20 9:47 PM, David Sterba wrote:
> On Thu, Feb 06, 2020 at 01:58:22PM +0800, Anand Jain wrote:
>> On 2/6/20 2:09 AM, David Sterba wrote:
>>> Now that we're sure the tree from argument is same as the one we can get
>>> from the page's inode io_tree,
>>
>>
>>> drop the redundant argument.
>>
>>    I think there is/was a plan to drop the btree inode? should we need
>>    this argument if the plan is still on? or any idea if it still can
>>    be implemented without this argument?
> 
> That's a question for the one implementing the btree inode removal. As
> there are several possible ways how to implement it, with different
> trade-offs and such, I can't forsee if this particula parameter will be
> useful or not. And keeping things around for theoretical needs of future
> patches has proven to not work so we've been removing such artifacts.
> 
> The exception is of course for patchsets that are in active development
> and would have to revert the cleanups.
> 

Reviewed-by: Anand Jain <anand.jain@oracle.com>
