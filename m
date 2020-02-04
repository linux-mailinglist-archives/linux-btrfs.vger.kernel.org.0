Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7091151AB2
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 13:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBDMqO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 07:46:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41958 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgBDMqN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 07:46:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014ChDRD087516;
        Tue, 4 Feb 2020 12:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=0qFUiWWfnkEoGulaAD+K0EXphsRDz+htUuGqFCzJmp8=;
 b=Bn/G9/bGaSLFzytx8Q7K1hDlkf89xAdfgiWNfgtf2M1O9wNnfPx/bkl+cWITzqV6WP4j
 FhW895QAfMM5VB9990Z1PobqhblyJ2sfvGujKGTuFznHZLiuGDEKlJfzbhg735OvgaSZ
 rh4hxN4w1qvMenvhjNaqnFWYv2VSrnxjy23QwKYLDI5W92pjzTiRgp0NSHoa9OOCjuoN
 YiYGWEASVGaqWcwpk5Q6JEucDXbMBAivdeCa9hOuGBNV83Ml/YFOSBfIBOGWOs+wXOHj
 z8va/vrK29qQgWfxVuHWOIyztGKn78NTxXN4GofZj4lkclPn60yo2n5RaNW9GUslOmt6 xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xwyg9jmj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 12:46:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014Cj3uH073075;
        Tue, 4 Feb 2020 12:46:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xxvurpqw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 12:46:09 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 014Ck8cu024997;
        Tue, 4 Feb 2020 12:46:08 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Feb 2020 04:46:07 -0800
Subject: Re: [PATCH] btrfs: drop math for block_reserved which is block_rsv
 size
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <1580814358-1468-1-git-send-email-anand.jain@oracle.com>
 <f35d657a-bbee-119c-793d-9871d0fc2c65@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a230e596-887c-51f5-8e4a-e800406774c3@oracle.com>
Date:   Tue, 4 Feb 2020 20:46:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f35d657a-bbee-119c-793d-9871d0fc2c65@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040090
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2/4/20 7:10 PM, Nikolay Borisov wrote:
> 
> 
> On 4.02.20 г. 13:05 ч., Anand Jain wrote:
>> In btrfs_update_global_block_rsv the lines
>>    num_bytes = block_rsv->size - block_rsv->reserved;
>>    block_rsv->reserved += num_bytes;
>> imply
>>    block_rsv->reserved = block_rsv->size;
>>
>> Just assign block_rsv->size to block_rsv->reserved instead of the math.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/block-rsv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
>> index 6dacde9a7e93..62e0885c1e5d 100644
>> --- a/fs/btrfs/block-rsv.c
>> +++ b/fs/btrfs/block-rsv.c
>> @@ -304,9 +304,9 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
>>   
>>   	if (block_rsv->reserved < block_rsv->size) {
>>   		num_bytes = block_rsv->size - block_rsv->reserved;
>> -		block_rsv->reserved += num_bytes;
>>   		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
>>   						      num_bytes);
>> +		block_rsv->reserved = block_rsv->size;
> 
> Any particular reason why you put the assignment after
> btrfs_space_info_update_bytes_may_use and not before?

  Oh. To make it similar to the else if part below.

Thanks.

>>   	} else if (block_rsv->reserved > block_rsv->size) {
>>   		num_bytes = block_rsv->reserved - block_rsv->size;
>>   		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
>>
