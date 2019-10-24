Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E8CE4068
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 01:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbfJXXvQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 19:51:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57520 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJXXvQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 19:51:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9ONoMCm054764;
        Thu, 24 Oct 2019 23:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=QfMynPdgUv8fxjpkzkP54619CBpQr5pnzXtUPHzNM7A=;
 b=NQjwo9xv+D8/WJ6qTpqoy6O6Nga0Tgn4jdY5xGYEbknYoaLz/RSXNsU5sQRL7PLTzLqK
 q++2I8amkdeC8rLBBbWJSfeJzF/3TjHnppn8O11HS/yV5cfJW3ha6YKuONANz7Pub7jL
 1YWndEegybrpBzU85AYSx7cVgvZoIjZxbnK/3tr9xW/qoYkS5/YaIlicmA/aOjQgsCpi
 rIDugYiWRF8Df1cRW0euwRBV33LCJ8WbF4SVZQ/K/6FFI1q/hZhMmAG4XjBlck66F6kn
 y1j+J4t9WkdB3yY04R7Btj0ZR9M9UoNGRl+DAoR3yc2S1tTT4Nb14alCb7nBlim2AmqO XQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vqu4r6pg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 23:51:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9ONn4xJ133856;
        Thu, 24 Oct 2019 23:51:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vtsk652xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 23:51:10 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9ONp9Hr023612;
        Thu, 24 Oct 2019 23:51:09 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 16:51:09 -0700
Subject: Re: [RFC PATCH 0/3] btrfs-progs: make quiet to overrule verbose
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191024062825.13097-1-anand.jain@oracle.com>
 <20191024154151.GI3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1166a5c7-8bc9-b93f-6f4c-8871b5fc394b@oracle.com>
Date:   Fri, 25 Oct 2019 07:51:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191024154151.GI3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240225
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240225
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24/10/19 11:41 PM, David Sterba wrote:
> On Thu, Oct 24, 2019 at 02:28:22PM +0800, Anand Jain wrote:
>> When both the options (--quiet and --verbose) in btrfs send and receive
>> is specified, we need at least one of it to overrule the other, irrespective
>> of the chronological order of options.
> 
> I think the common behaviour is to respect the order of appearance on
> the commandline.

   I am fine with this. Will fix it as this.

   (IMO generally command -q is used in scripts so it makes sense to keep
   it absolutely quiet when used. Where as -v is used for
   understanding.).

> So 'command -vvv -q' will be the same as 'command -q',

> while 'command -q -vvv' will be 'command -vvv'.

  We need to fix this. As of now command -q -vvv is command -vv.

Thanks, Anand

> Eg. ssh behaves like that, OTOH rsync does not and -q beats -vvv. I
> don't know about other commands that accept multiple -v and -q to get
> more samples. The usage pattern where order on command line matters is
> following the idea where there's a long line and adding -vvv to the end
> will make it verbose.
> 


