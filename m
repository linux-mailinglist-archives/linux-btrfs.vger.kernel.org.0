Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC8DCE8F46
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 19:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbfJ2S1t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 14:27:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51460 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731451AbfJ2S1t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 14:27:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TIOJKi192149;
        Tue, 29 Oct 2019 18:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=kTkoc41Ou0QTcD9cvayhvlOJQgfm4ilylLSjP5eflUs=;
 b=jCTjAaDj+bJQFxOkmVACxJHR5x6lAdP1lAaZBioTvAt2h3XLI74kuQPnbGgMWoDqKNt6
 EmdWWo1IyqB+YTREDdpJvDgtrY5oG+CzAs/daY7GXnz+y/5EWVLsC9YOTEWE8nAa0hPK
 dimouPNMSAXQKCIyKxCZxvjZ98ly26KcwFWlgfrmwtbKKJ3tWBJuaXmb8LG6uuwuXi7+
 Uckvmeo3qB9PxOWkmUsWuQPfVEdV61MY94HF6f6s26Aoo57ByPDgev5eEE8CUtsuCFFE
 VIMBzIfy0mwA4XcBN2o5M9ZHHAWnFljw0EHnAHGZzMF8FLB6wPfxipPStVsj0c5DLNeE Aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vvdjuba42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:27:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TI8Rr7052344;
        Tue, 29 Oct 2019 18:25:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vxj8gqeqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:25:43 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9TIPgfd008315;
        Tue, 29 Oct 2019 18:25:42 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 11:25:41 -0700
Subject: Re: [PATCH devel] btrfs-progs: subvolume: Implement delete --subvolid
 <path>
To:     dsterba@suse.cz,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org, mpdesouza@suse.com
References: <20191028160506.22245-1-marcos.souza.org@gmail.com>
 <cb24c0bb-121e-08bc-9138-16abb1f2727a@oracle.com>
 <20191029135157.GU3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <bbd9a37c-b09e-a089-089e-3c1b5c68e8f8@oracle.com>
Date:   Wed, 30 Oct 2019 02:25:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191029135157.GU3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290161
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29/10/19 9:51 PM, David Sterba wrote:
> On Tue, Oct 29, 2019 at 10:05:25AM +0800, Anand Jain wrote:
>>> @@ -223,6 +223,7 @@ static int wait_for_commit(int fd)
>>>    
>>>    static const char * const cmd_subvol_delete_usage[] = {
>>>    	"btrfs subvolume delete [options] <subvolume> [<subvolume>...]",
>>> +	"btrfs subvolume delete [options] [--subvolid <subvolid> <path>]",
>>
>>
>> It should rather be..
>>
>> + "btrfs subvolume delete [options] <[-s|--subvolid <subvolid> <path>] |
>> [<subvolume>...]>"
> 
> This is hard to understand on the first read, so the preferred way is to
> split into more lines when an option changes the overall behaviour, eg.
> what plain receive and receive --dump does:
> 
> 
> $ ./btrfs receive --help
> usage: btrfs receive [options] <mount>
>         btrfs receive --dump [options]
> 

yep makes sense.
