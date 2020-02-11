Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5661586D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 01:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBKApu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 19:45:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45014 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgBKApt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 19:45:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B0cqC4137823;
        Tue, 11 Feb 2020 00:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0bAo5VlAlmyFix62CORirt6tVVmhp/apgoW6fdxQjeA=;
 b=KzxbZ+D1PoqLPCZMePjVBfofyxV8AdAdu9UK/RGtJvjU5IOfOEjUrBz8egbU3HZgRpWv
 rjs4rbIDHIgrXO9ZwaUuQMySpIw85X/Go204sJBqkofwse8SvTYkUlFOVzMfGiQu14oX
 1FBrzGkC1YbJOgXX4TY9qaXN9KtTeE4DTHaAX3TtAi2AAlX00eSDX0wAwn6DPHPuY/RS
 0DY20/jIgpEcz9IFAKaoERoyaKKcjoS1BXJaCSfvvzeZXeBk1zMVHEdd8T9v+mknudDw
 l9Pc0p4kkixT+KXzAZ6TZKQVdklTJG1hAorNd0/zMg8DNP4/25Wez+oXxQyxZuDblJ+4 kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2y2jx60f35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 00:45:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B0adOw023656;
        Tue, 11 Feb 2020 00:45:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2y26q08y1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 00:45:46 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01B0jixL019812;
        Tue, 11 Feb 2020 00:45:45 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Feb 2020 16:45:44 -0800
Subject: Re: [PATCH] fstests: common/btrfs: use complete sub command
To:     Marcos Paulo de Souza <mpdesouza@suse.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20200210031322.1177-1-anand.jain@oracle.com>
 <ee02dd42a41bd63999730c890f949667a76ca98b.camel@suse.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <084e2458-8fe8-1e78-49b6-28739d7b3763@oracle.com>
Date:   Tue, 11 Feb 2020 08:45:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ee02dd42a41bd63999730c890f949667a76ca98b.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110001
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/10/20 8:03 PM, Marcos Paulo de Souza wrote:
> On Mon, 2020-02-10 at 11:13 +0800, Anand Jain wrote:
>> Grep failed to find this subcommand of btrfs, leading to a wrong
>> inference for a moment.
>>
>> Make sure we use the full subcommand name in the btrfs command.
> 
> Well, I don't see how this could fail,

Its about searching for the subvolume sub-command in the file common/btrfs.

I hope this clarifies. Change log is updated in v2.
