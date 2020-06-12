Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7607E1F7F0F
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jun 2020 00:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFLWsM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 18:48:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60240 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFLWsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 18:48:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CMlKC2161186;
        Fri, 12 Jun 2020 22:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Gp/UDyip3kX9iLputsLhEy7cftgTlc711qrjZpoq6Cc=;
 b=gGjb/snEqsXK23pFNFrR+v5USkexQBeO6p2LbkWMipOm/xB6RykIJFnMjzQaFy5KZSAQ
 Yd/V3/d3Zd5DeVzR4S0tbxw49JqPmtdgnUCVaiiDxpB4iBcCNEu/FXx7SuYh9imcv5HM
 m8umIpoRd9CE556yTCvgLDyCftgiwtlDhWPqvp8EOztI9K9pENvjQYP2FhiyVrrj4m/w
 40uQzWwzwFORtIvjiI9klblIE78wJxnd9z67TEl3YPNXieOm/UgGe7jZiDWka7l4s8zs
 h6eVev7nRQLOoeJlroFJb1NN6MvpIP8nPyNo2/h8EZimnaC14MH53/E7h3NSzaW/4+wt nA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31jepp99xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 22:48:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CMm0Bo158140;
        Fri, 12 Jun 2020 22:48:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 31mhgjws08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 22:48:05 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05CMm3ww020677;
        Fri, 12 Jun 2020 22:48:04 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 15:48:03 -0700
Subject: Re: [PATCH v3 02/16] btrfs-progs: add global verbose and quiet
 options and helper functions
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <1574678357-22222-3-git-send-email-anand.jain@oracle.com>
 <20200612105606.18210-1-anand.jain@oracle.com>
 <20200612153935.GU27795@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <eba7d4f9-82b1-49c7-54c1-c4a6dcf905ac@oracle.com>
Date:   Sat, 13 Jun 2020 06:48:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612153935.GU27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120170
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/6/20 11:39 pm, David Sterba wrote:
> On Fri, Jun 12, 2020 at 06:56:06PM +0800, Anand Jain wrote:
>> Add btrfs(8) global --verbose and --quiet command options to show
>> verbose or no output from the sub-commands.
>> By introducing global a %bconf::verbose memeber to transpire the same
>> down to the sub-command.
>> Further the added helper function pr_verbose() helps to logs the verbose
>> messages, based on the state of the %bconf::verbose. And further HELPINFO_
>> defines are provides for the usage.
>>
>> Suggested-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v3:
>>    Add define MUST_LOG
>>    Add comment about the argument %level in the function pr_verbose()
> 
> Now you've created quite some chaos here, why didn't you just send v3 as
> a standalone patchset? Replies to individual patches works for small
> fixups but not as a whole new iteration.
> 
> The second part now depends on this v3 that has the MUST_LOG define
> burried in patch 2/16, while it should have been one extra patch to the
> second part and we'd be done with that. I'll sort it out somehow but ...
> 

  Yeah, standalone patch would have been simpler. It was painful at my
  end too. Sorry about that.

  On a different topic. I checked with you before - by legacy send.c and
  receive.c use stderr for verbosity. Is it a regression to change these
  to stdout now?

