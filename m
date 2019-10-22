Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC8DFA48
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 03:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfJVByw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 21:54:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44186 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJVByv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 21:54:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M1rpD1032207;
        Tue, 22 Oct 2019 01:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=GI9eAA+1ItVeRXyW0o+MvKDxOIKD7Sueg6f/NK9+Wcc=;
 b=kWRteqindizQP7DtLy/y2MepXwk7uqlgHGzJxn+q2yqhCu6zRbhWgez0uKEkz672lWfp
 sHM0/7u1SPFeBJr8JlRLrWZgw8WpInaRw90GGBtt3HEqAOJw9Ns+Cqd4+j9R6IhEyRDH
 xVI/RfChyPLaFRTJWM9Qd4t/Wo3JfjUQ6YW+0hOW5y/5B9SalgED8RCKks92+mmAAtTa
 S2OAnoAhgPquPxNxukovLVGn/Wuft/zqWkl4q7TFhtk0WecJ53PbpvlPMjgJBtx/qDJ6
 xETbRkFRD3Pwu81tWjH1uV0tLYmSUufyLjYgK6IjsCs7BSglajOiNBuhx2lsMFCqC8j9 Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vqswtbfvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 01:54:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M1sBgD122065;
        Tue, 22 Oct 2019 01:54:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vrc00tupb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 01:54:46 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9M1sjZp028653;
        Tue, 22 Oct 2019 01:54:45 GMT
Received: from [172.20.10.3] (/183.90.37.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 18:54:45 -0700
Subject: Re: [RFC PATCH 00/14] btrfs-progs: global-verbose option
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
 <20191021161256.GR3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <daf2cb74-64bb-66bf-9b08-9f07076eacc8@oracle.com>
Date:   Tue, 22 Oct 2019 09:54:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021161256.GR3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220017
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/22/19 12:12 AM, David Sterba wrote:
> On Mon, Oct 21, 2019 at 06:01:08PM +0800, Anand Jain wrote:
>> This patch set brings --verbose option to the top level btrfs command,
>> such as 'btrfs --verbose'. With this we don't have to add or remember
>> verbose option at the sub-commands level.
>>
>> As there are already verbose options to 11 sub-commands as listed
>> below [1][2]. So the top level --verbose option here takes care to transpire
>> verbose request from the top level to the sub-command level for 9 (not 11)
>> sub-commands as in [1] as of now.
>>
>> This patch is RFC still for the following two reasons (comments appreciated).
>>
>> 1.
>> The sub-commands as in [2] uses multi-level compile time verbose option,
>> such as %g_verbose = 0 (quite), %g_verbose = 1 (default), %g_verbose > 1
>> (real-verbose). And verbose at default is also part the .out files in
>> fstests. So it needs further discussions on how to handle the multi-
>> level verbose option using the global verbose option, and so sub-
>> commands in [2] are untouched.
> 
> The idea is to unify all verbosity options. Default is 1, 0 is for quiet
> (only errors are printed), the rest is up to the commands what to print
> on the higher levels.

As of now verbosity level is a compile time option. [3]

[3]
-------
cmds/send.c

  51 /*
  52  * Default is 1 for historical reasons, changing may break scripts 
that expect
  53  * the 'At subvol' message.
  54  */
  55 static int g_verbose = 1;
--------



>> 2.
>> These patch has been unit-tested individually.
>> These patches does not alter the verbose output.
>> But it fixes the indentation in the command's help output, which may be
>> used in fstests and btrfs-progs/tests and their verification is pending
>> still, which I am planning to do it before v1.
> 
> The indentation does not need to be changed if the glboal options are
> split from the per-command, like
 >
> ---
> usage: btrfs subvolume delete [options] <subvolume> [<subvolume>...]
> 
>      Delete subvolume(s)
> 
>      Delete subvolumes from the filesystem. The corresponding directory
>      is removed instantly but the data blocks are removed later.
>      The deletion does not involve full commit by default due to
>      performance reasons (as a consequence, the subvolume may appear again
>      after a crash). Use one of the --commit options to wait until the
>      operation is safely stored on the media.
> 
>      -c|--commit-after  wait for transaction commit at the end of the operation
>      -C|--commit-each   wait for transaction commit after deleting each subvolume
> 
>      Global options:
>      -v|--verbose     show verbose output
> ---


  Oh split it. ok. Makes sense.

> Some commands can have long option names or the argument names make it
> long in some cases, the global options could stay indented. I think
> visually it'll be ok. We can introduce some way to automatically format
> the options and help texts so we don't have to adjust them manually each
> time, but this would be more intrusive and can be done later.

  ok. But my pertaining question is if the sub-command verbose option
  should still remain? if no I will be happy to take it out as the same
  verbose will anyway be activated using the global verbose option.

> With the global verbose option there shouldbe also -q|--quiet. Both
> short and long versions should be available for all commands. So the
> help would look like:
> 
> ---
>      Global options:
>      -v|--verbose     verbose output, repeat for more verbosity
>      -q|--quiet       print only errors
> ---
> 
> In code this looks like:
> 
>            "",
>            "-c|--commit-after  wait for transaction commit at the end of the operation",
>            "-C|--commit-each   wait for transaction commit after deleting each subvolume",
>            HELPINFO_GLOBAL_OPTIONS_HEADER,
>            HELPINFO_INSERT_VERBOSE,
>            NULL
> 
> #define HELPINFO_GLOBAL_OPTIONS_HEADER					\
> 	"",								\
> 	"Global options:"
> 
> and HELPINFO_INSERT_VERBOSE also contains the quiet option.
> 
> The global option value is stored in 'btrfs_config_init bconf', so
> everything can access it directly.

  Oh ok.

  In the above code-snap [3].

  g_verbose = 0 and g_verbose = 1 can be mapped to the global
  -q|--quite and --verbose respectively.


  But any idea what to do with g_verbose > 1? which we support
  in send.c and receive.c. And in defrag which the patch [4] removed it.
   [4]
   [RFC PATCH 09/14] btrfs-progs: restore: delete unreachable code

  Another way is

   btrfs [--quite] [--verbose[=n]]

n=1 default
n=2 verbose

Can't imagine anything better.

Thanks for helping to shape this.

Anand

> Thanks for working on this, I'll have more comments on v2 as I probably
> forgot a few more things to do, the above is the base for all further
> changes.
> 
