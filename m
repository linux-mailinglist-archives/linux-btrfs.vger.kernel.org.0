Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFBAA11409C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 13:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfLEMKw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 07:10:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57234 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbfLEMKw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 07:10:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5C44Na113031;
        Thu, 5 Dec 2019 12:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=USE9FBRyBc/8efN5GRIT5pi7xJoADKskPxJBSnpjAb8=;
 b=fFCGy8S2y44Xtyu+B7dyWqze0XrVS3rcbOJrS7AYFOTmi/TpjBy40ziuPH14izXSr3w8
 hK9Ev5BHXKcBtDqquPnEpLPpae72E0Li74X0AmprG7W/aV/bA13OpElGQI3lO05PBaJc
 ZBjEW7Jksu2tQgq4nqqduMd1EIE1t3/sA0Vgw4ldj3fnRo6jGm5F2glo7w8lydpFXocU
 GvQ0un1i+ga1XAJvGqJivE1VYjoiElT1l+aj/eS0/KEEEChLgTNJrmzza/7OLm9eivPC
 jpco/PpMa+a9v8Ymd3CWBPXFiLvqJVid8EIr9ozUxseYE5c0/ILataZyqXeMDYavxBZ3 Ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wkfuumv4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 12:10:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5C3VLB182900;
        Thu, 5 Dec 2019 12:10:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wptpufh35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 12:10:44 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB5CAgpR012542;
        Thu, 5 Dec 2019 12:10:42 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 12:10:42 +0000
Subject: Re: BTRFS subvolume RAID level
To:     waxhead@dirtcellar.net, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <494b0df1-2aab-5169-836d-e381498f64db@dirtcellar.net>
 <ed65c577-3971-8c4f-c690-83e85dd8188e@oracle.com>
 <fcbe2d91-a6ad-5b9b-fa66-aebb2edd14f1@dirtcellar.net>
 <422a04ba-2e63-f951-7097-19ecc7a88c53@oracle.com>
 <5297ba43-366f-241c-1934-783686a058c8@dirtcellar.net>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ce4f4f98-ec1c-bb1e-3dcf-0271d7156c22@oracle.com>
Date:   Thu, 5 Dec 2019 20:10:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5297ba43-366f-241c-1934-783686a058c8@dirtcellar.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=743
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=791 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050101
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4/12/19 4:31 AM, waxhead wrote:
> 
> 
> Anand Jain wrote:
>>
>>
>> On 12/3/19 7:27 AM, waxhead wrote:
>>>
>>>
>>> Anand Jain wrote:
>>>>
>>>>> I imagine that RAIDc4 for example could potentially give a 
>>>>> grotesque speed increase for parallel read operations once BTRFS 
>>>>> learns to distribute reads to the device with the least waitqueue / 
>>>>> fastest devices.
>>>>
>>>>   That exactly was the objective of the Readmirror patch in the ML.
>>>>   It proposed a framework to change the readmirror policy as needed.
>>>>
>>>> Thanks, Anand
>>>
>>> Indeed. If I remember correctly your patch allowed for deterministic 
>>> reading from certain devices.
>>   It provides a framework to configure the readmirror policies. And the
>>   policies can be based on io-depth, pid, or manual for heterogeneous
>>   devices with different latency.
>>
>>> As just a regular btrfs user the problem I see with this is that you 
>>> loose a "potential free scrub" that *might* otherwise happen from 
>>> often read data. On the other hand that is what manual scrubbing is 
>>> for anyway.
>>
>>   Ha ha.
>>
>>   When it comes to data and its reliability and availability we need
>>   guarantee and only deterministic approach can provide it.
>>
> Uhm , what I meant was that if someone sets a readmirror policy to read 
> from the fastest devices in for example RAID1 and a copy exists on both 
> a harddrive, and a SSD device and reads are served from the fastest 
> drive (SSD) then you will never get a "accidental" read on the harddrive 
> and therefore making scrubbing absolutely necessary (which it actually 
> is anyway).
> 
> In other words for sloppy sysadmins, if you read data often then the 
> hottest data is likely to have both copies read. If you set a policy 
> that prefer to always read from SSD's it could happen that the poor 
> harddrive is never "checked".
> 



>>   What you are asking for is to route the particular block to
>>   the device which was not read before so to avoid scrubbing or to
>>   make scrubbing more intelligent to scrub only old never read blocks
>>   - this will be challenging we need to keep history of block and the
>>   device it used for read - most likely a scope for the bpf based
>>   external tools but definitely not with in kernel. With in kernel
>>   we can create readmirror like framework so that external tool can
>>   achieve it.
> 
>  From what I remember from my prevous post (I am too lazy to look it up) 
> I was hoping that subvolumes could be assigned or "prioritized" to 
> certain devices e.g. device groups. Which means that you could put all 
> SSD's of a certain speed in one group, all harddrives in another group 
> and NVMe storage devices in yet another group. Or you could put all 
> devices on a certain JBOD controller board on it's own group. That way 
> BTRFS could have prioritized to store certain subvolumes on a certain 
> group and/or even allowing to migrate (balance) to antoher group. If you 
> run out of space you can always distribute across other groups and to 
> magic things there ;)
> 
> Not that I have anything against the readmirror policy , but I think 
> this approach would be a lot more ideal.

  Yep. I remember [1] you brought subvolume to be able to direct the
  read IO.

  [1]
  https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg86467.html

  The idea is indeed good. But its not possible to implement as we
  share and link blocks across subvolumes and snapshots or it may
  come with too many limitations and gets messy.

Thanks, Anand


>>
>>
>> Thanks, Anand
