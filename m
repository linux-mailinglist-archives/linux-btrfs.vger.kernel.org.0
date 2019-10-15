Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD8BD6DC6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 05:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfJOD3r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 23:29:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34004 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfJOD3r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 23:29:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9F3TCBn102746;
        Tue, 15 Oct 2019 03:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=VfvS/Xa7hR6KitFSina1sFCOCCA+nb6WL00o61pzsCs=;
 b=fd9xvFBKcfEuVjLiubrWM9L/k0jlo2fGFXQaFOOHSfQMICv59duBXwVuo6kMjF+aCwII
 0Hjp7VzvxDBIRFqGw/Sx1Tus6Ztmy4DppqlW2NJAYxY5oWUZq+ileROWKqzuM1tjr7Hc
 oPTrhRkavG6IhjbU+8HKkCyWeSr6szUuPAe5eNbbjXox/9KKGtUE7nKl04pRJXq62QIq
 Azl6iMaY/ee1Gic/5QsROo+oLx/OHup+rGhDy5ycSZojd6yyYw/PM62JIuRehXSPTKkA
 G1lGaFnrC+j3t+jHayEPgfzgU6jVNjVh9TgDMmQL/LjWCk7dSLH49yh7sko01ns33FCq 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vk6sqcsa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 03:29:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9F3Swiv174822;
        Tue, 15 Oct 2019 03:29:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vkrbm3796-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 03:29:43 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9F3TgTt029043;
        Tue, 15 Oct 2019 03:29:42 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 03:29:42 +0000
Subject: Re: [PATCH v3] btrfs-progs: add verbose option to btrfs device scan
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1569989512-5594-1-git-send-email-anand.jain@oracle.com>
 <20191007174129.GK2751@twin.jikos.cz>
 <a9c0a957-e151-32e8-a42e-b5c6d817ed78@oracle.com>
 <20191014152457.GQ2751@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <365faddf-cf4f-2a03-820d-d4f5071240e8@oracle.com>
Date:   Tue, 15 Oct 2019 11:29:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191014152457.GQ2751@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150029
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/14/19 11:24 PM, David Sterba wrote:
> On Tue, Oct 08, 2019 at 10:53:37AM +0800, Anand Jain wrote:
>> On 10/8/19 1:41 AM, David Sterba wrote:
>>> On Wed, Oct 02, 2019 at 12:11:52PM +0800, Anand Jain wrote:
>>>> To help debug device scan issues, add verbose option to btrfs device scan.
>>>
>>> The common options like --verbose are going to be added into the global
>>> command so I'd rather avoid adding them to new subcommands as this would
>>> become unnecessary compatibility issue.
>>
>>> There's an pattern to follow, the output formats (--format). So add a
>>> definition for global verbosity options, add new GETOPT_VAL global enum
>>> values that do not clash with existing options, add relevant
>>> HELPINFO_INSERT_ text string and use it in commands where needed.
>>>
>>
>>    IMO a debug option should rather be at the top level command.
>>    If verbose is the top level it would emit a lot of unwanted messages.
>>    Here is how a user is using --verbose option in dev scan.
>>
>>   
>> https://lore.kernel.org/linux-btrfs/2daf15de-d1e7-b56a-be51-a6a3062ad28a@oracle.com/T/#t
>>
>> ------------
>> useful to get the list of devices it finds.
>> ------------
>>
>>    OR I didn't get the whole idea here. Looks like you are suggesting
>>    something like
>>
>>     btrfs --verbose device scan
>>     btrfs --verbose subvolume list <mnt>
> 
> Yes this is what I mean.
> 
>>     ::
>>
>>    How does the user will know if a subcommand will have any verbose
>>    or not?
> 
> The point is that the global option will work for all subcommands, so
> the user does not have to know which support that or not. For
> compatiblity reasons, what works now will continue to work. This means
> that the verbosity option will be duplicated for some commands.
> 
>>    How would you not emit unwanted messages and keep the output clutter
>>    free.
> 
> What unwanted messages? Though the verbosity option will be set as
> global option, it will be up to the command itself what to print.
> 
>    $ btrfs -v device scan
> 
> would be equivalent to
> 
>    $ btrfs device scan -v
> 

  I was thinking there might be some common code between the
  sub-commands in btrfs-progs now or in future, and if the printf()
  due to verbose is required in one sub-command and the same printf()
  due to verbose is not required in another sub-command (which I
  called unwanted message) then we won't have any choice to not
  to print those unwanted printf().
  But as this is just an anticipatory only, so probably we could try
  global verbose and see how it fares. I will try.

Thanks, Anand

