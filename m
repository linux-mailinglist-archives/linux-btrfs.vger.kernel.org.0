Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C511DB07A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 12:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgETKo5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 06:44:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48268 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKoz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 06:44:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KAbxpM178136;
        Wed, 20 May 2020 10:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2020-01-29;
 bh=3KnfWKANY5AR1polnAg7fiUIV01YzNDmhos8wsZc5DM=;
 b=ykzjaVLeedL9heheh2dCefDLbBdsi/GsEFjRs20Wo614DgTai0tIW2UUpdVT5lC38a5a
 qI0Mqx4293ehaS4+M1KBOLNFtOUeN1m7QaGVrH3GO5ZIoK0YI2eEhyB5L23XZGgsE9o9
 zmcpINFnwIW91uTb9OqclZOBdsX5qNVgKMO2yoY/coObBeJbhFuB7L+e4leqxV397h4C
 bx7YGLG4XsdwimwJ8D1uIwwZ1K5KAKBs25ex+SBKirhPfrXa2npfp7VK0n31ZbfINsRh
 M4jLRUdri98eqc1jCJAkCVYh5RqNWlb0rC+6L54KqiCQZ6ziCyLVRGUmG3xLMNDz05BR gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31284m2ctt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 10:44:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KAcSwf035933;
        Wed, 20 May 2020 10:44:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 314gm6ujjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 10:44:48 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04KAilur011952;
        Wed, 20 May 2020 10:44:48 GMT
Received: from [192.168.1.102] (/39.109.177.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 03:44:47 -0700
Subject: Re: [PATCH] btrfs-progs: drop unique uuid test for btrfstune -M
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190906005025.2678-1-anand.jain@oracle.com>
 <f3d33e1d-803e-34a5-4dfa-7eeceec6177c@suse.com>
 <232bccd3-3623-8ee9-18db-98edf7cd2e25@oracle.com>
 <673ba386-debc-96e9-311e-4c3c0abd89d0@suse.com>
 <41b5b682-e67f-40d6-93cb-75e4889a4b06@oracle.com>
 <20190911170139.GH2850@twin.jikos.cz>
 <1cd24402-40dd-86f0-ac47-91cad78ef5fe@oracle.com>
 <20191017163252.GL2751@twin.jikos.cz>
 <3952c4bf-755a-5824-b57e-1c2ce1deda99@oracle.com>
Message-ID: <c38ddbbb-8c30-60b7-7563-7f56ffb11623@oracle.com>
Date:   Wed, 20 May 2020 18:44:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3952c4bf-755a-5824-b57e-1c2ce1deda99@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005200092
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David,

  We let the fsid to change but restrict if the user decides to undo.
  This bug is like a one-way trap.

  Any resolution on the issue below?

Thanks, Anand

 >> On 10/18/19 12:32 AM, David Sterba wrote:

>> I can't say I have a clear picture yet, can you please describe it in
>> some more desriptive way, like
>>
>> host1: create image1-uuid1
>>
>> host2: copy image1-uuid1 to image1-uuid2
>> host2: use image1-uuid2
>> host2: change image1-uuid2 back to uuid1     <-- I want this to work
>   From the bug as I received.
>      create btrfs root-image for the vm use.
>      copy root-image to root-image1
>      copy root-image to root-image2
>      start vm1 using root-image1
>      (when root-image1 has issues; shutdown vm1)
>      start vm2 using root-image2 with root-image1 accessible.
>      login to vm2
>        (change fsid so that root-image1 can be mounted)
>        btrsftune -m remote/root-image1
>        mount -o loop remote/root-image1 /mnt
>          analyze, collect logs, fix remote/root-image1
>        umount /mnt
>        (Revert the changed fsid so that vm2 can boot) <<<< Usecase wants 
> this to work
>        btrfstune -M $(btrfs in dump-super remote/root-image2 | \
>                       grep metadata_uuid | awk '{print $2}') \
>                       remote/root-image2
>      logout from vm2
>      start vm1 using root-image1




