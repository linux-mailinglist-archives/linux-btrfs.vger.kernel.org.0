Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A252E5FF51
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 03:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfGEB3W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 21:29:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32846 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfGEB3V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Jul 2019 21:29:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x651T6fO070656;
        Fri, 5 Jul 2019 01:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=slFKgbkcpr9fjFvWoe3DoKeQzpSPVso27jCpqoRXNcI=;
 b=G7RA3nrknRJI7HafSA2oogRCFMVwMGExV7Bq89TjNzpRsnfPrzh7Co9lWSHPlIyJcbd9
 v3D+wgxSxlVpMr7awt3YYIGBW2+4DYW4J+oLZvbXWHQkCNcYDlHnKa4vcvfw/n2uscNS
 tA5d7GfmNFixUF+KDId3bEEmKeQ7qRYPlnskHMGgsGKNKR8oN6EathGUVNOEi24bDfZW
 sLic8OCK2TPG47jTDLOCobcPd+zSeCO24VG0mf/BDK2cZb2EZ7c7Y8gfHk/9q2EJYZqm
 jpgi2UxJWGxH2PC0/xLIk0ZJHwdFXYu/aDemRs7qEfbHL447ddx1s745D3yS0z7ZWWGU MQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2te61q8m6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jul 2019 01:29:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x651RtnB158674;
        Fri, 5 Jul 2019 01:29:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2th5qm8v31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jul 2019 01:29:06 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x651T4NS018919;
        Fri, 5 Jul 2019 01:29:05 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jul 2019 18:29:04 -0700
Subject: Re: [PATCH][next] btrfs: fix memory leak of path on error return path
To:     dsterba@suse.cz, Colin King <colin.king@canonical.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190702141028.11566-1-colin.king@canonical.com>
 <20190704163721.GA20977@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <06e5e9f3-5cf5-99a7-6d49-6d72d975f594@oracle.com>
Date:   Fri, 5 Jul 2019 09:28:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190704163721.GA20977@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9308 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907050018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9308 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907050018
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/7/19 12:37 AM, David Sterba wrote:
> On Tue, Jul 02, 2019 at 03:10:28PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently if the allocation of roots or tmp_ulist fails the error handling
>> does not free up the allocation of path causing a memory leak. Fix this by
>> freeing path with a call to btrfs_free_path before taking the error return
>> path.
>>
>> Addresses-Coverity: ("Resource leak")
> 
> Does this have an id, that coverity uses?
> 
>> Fixes: 5911c8fe05c5 ("btrfs: fiemap: preallocate ulists for btrfs_check_shared")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   fs/btrfs/extent_io.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 1eb671c16ff1..d7f37a33d597 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -4600,6 +4600,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>   	tmp_ulist = ulist_alloc(GFP_KERNEL);
>>   	if (!roots || !tmp_ulist) {
>>   		ret = -ENOMEM;
>> +		btrfs_free_path(path);
> 
> This fixes only one leak, therere are more that I spotted while
> reviewing this patch. The gotos from the while-loop jump to
> out_free_list but that leave the path behind.
> 
> That's why the exit block is a better place for the cleanups. This
> requires proper nesting of the cleanup calls, that's slightly
> inconvenient in this case. The free_path is before call to
> unlock_extent_cached so when the ordre is switched and free_path moved
> to out_free_ulist, then all the leaks are addressed in one go.
> 
> Bummer that the leaks escaped sight of original patch author (me), 2
> reviewers and now 1 fix reviewer.
> 

There is no goto out_free_ulist inside the while loop; where do you see
that? I did git pull again and checked.

4664         while (!end) {
::
4726                                 goto out_free;
::
4748                         goto out;
::
4759                         goto out_free;
::
4761         }




