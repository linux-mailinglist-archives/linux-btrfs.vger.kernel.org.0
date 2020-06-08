Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9383D1F144A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 10:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgFHIOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 04:14:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43300 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgFHIOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 04:14:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0588CFh6158655;
        Mon, 8 Jun 2020 08:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ts32KiCWGlxInxVf6FPZO5ZDMVSTn18dVTyV7N78yvE=;
 b=GjKg40DAw153tfn4ge73k1PLzQn+Caag55NoJWDKisauRwxjMsgtAx9l2QXO0gkv6J+I
 adMDAIghgbI/SuozdfVEVRRg7xzyTid0BC3gAjmqNAdlnDzi1NEgtivRnTLKxWBDIykd
 xoCiv9FC5LARBVki6K3yiw9YDjjbzsHvMPu7a2ei19v5AyjPNDpuw+x2fa3WhLrjWAI1
 jQ9bb2v5yTzoA0oePxOPEOpRwjTnM4ri7Wx/Yv48CU694bxmUxhdlaz/uZ4ATHRm4jhB
 mStSuFzYkm87BmeXm19Ua09lCWF/VVpGhpv6g7R6CCCcUGD2z8hVZ800i32BjaZ8Tsxs Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31g2jqwfx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 08:14:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05888Gtr011475;
        Mon, 8 Jun 2020 08:12:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31gn21ydkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 08:12:02 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0588C1VW028093;
        Mon, 8 Jun 2020 08:12:01 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 01:12:01 -0700
Subject: Re: [PATCH v7 1/2] btrfs: Introduce "rescue=" mount option
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200604071807.61345-1-wqu@suse.com>
 <20200604071807.61345-2-wqu@suse.com>
 <3659322f-0687-d179-ff89-f3a303fe2379@oracle.com>
 <20200605113638.GB27795@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <006ff0d7-517f-e505-e8cd-529029e1e203@oracle.com>
Date:   Mon, 8 Jun 2020 16:11:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605113638.GB27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080063
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/6/20 7:36 pm, David Sterba wrote:
> On Fri, Jun 05, 2020 at 06:04:01PM +0800, Anand Jain wrote:
>> On 4/6/20 3:18 pm, Qu Wenruo wrote:
>>> This patch introduces a new "rescue=" mount option group for all those
>>> mount options for data recovery.
>>>
>>> Different rescue sub options are seperated by ':'. E.g
>>> "ro,rescue=nologreplay:usebackuproot".
>>> (The original plan is to use ';', but ';' needs to be escaped/quoted,
>>> or it will be interpreted by bash)
>>
>>    I fell ':' isn't suitable here.
> 
> What do you suggest then?
> 

There isn't any other choice, right? Probably that's the reason for
-o device it is -o device=dev1,device=dev2 still remains separated?
IMO if there isn't a choice it is ok to leave them separate.

But as I commented in the other thread instead of
-o rescue=skipbg:another1:another2 why not just -o rescue
and mount thread shall skip the checks that fail and mount the
fs in RO if possible. The dmesg -k must show the checks that
were failed and had to skip to make the RO mount successful.
So, that becomes clear about the errors which lead to the current RO 
mount, instead of going through the logs to figure out. This is a more 
user-friendly approach as there is one rescue option. But I am not
sure if it is possible?

Thanks, Anand


>>> And obviously, user can specify rescue options one by one like:
>>> "ro,rescue=nologreplay,rescue=usebackuproot"
>>
>>    This should suffice right?
> 
> Setting the rescue= value separately should be supported, but requiring
> to write the option name for each value defeats the purpose to make it
> compact and user friendly.
> 

