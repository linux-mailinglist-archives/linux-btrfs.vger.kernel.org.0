Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C59D13A0E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 07:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgANGOh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 01:14:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51354 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgANGOh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 01:14:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E6Cqwx155479;
        Tue, 14 Jan 2020 06:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=uYk15ZHNj3GVhbwO6xVnUynxwpCLJvOPN0nY3SPA/ZQ=;
 b=rva63lVncyMNIE9CQFUdJCLktzY2smtoEK3/lIeJ7/32jhRsEreUgmI8qpB7U1Y0Mz/g
 7CHqEWXi25pIKzc9kZHq0LHW1ftnhxYnmyKMoqKr4Q04RTO3h+5ioiwm6nlwVNIPjyBW
 LlLhByAyVCNOzwGPm2wExb/eif577eGeuwD8eTGM4Dv8WkxLKg98zi143N9yBOyeOPir
 I2ZeRc3TpZ4nSM8/JfVpS3ACp7l+DIOj8hMjp2B4Fo28h8k5akaPB0kWBfNTpP0LV4Fx
 zdudgKdzKzQBSDxXsDqWnXr79+JM08b0mSWO8fnXNbfpay05Fa1jLJh4JLvfcXesiwTI lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xf74s3snq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 06:14:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E6EI7C013742;
        Tue, 14 Jan 2020 06:14:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xh30yus9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 06:14:32 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00E6ERRj001438;
        Tue, 14 Jan 2020 06:14:28 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 22:14:27 -0800
Subject: Re: [PATCH v2 00/16] btrfs-progs: global verbose and quiet option
From:   Anand Jain <anand.jain@oracle.com>
To:     David Sterba <dsterba@suse.com>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <8a2bac99-5c07-2aa9-fe3b-e09f2ad16213@oracle.com>
Date:   Tue, 14 Jan 2020 14:14:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140055
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David,

  I wonder if could this be integrated?

Thanks, Anand


On 25/11/19 6:39 PM, Anand Jain wrote:
> v1.1->v2:
> Mainly:
>   . Splits define HELPINFO_INSERT_GLOBALS from --format option and
>   . Rename HELPINFO_GLOBAL_OPTIONS_HEADER to HELPINFO_INSERT_GLOBALS
>   . Create and use helper bconf_be_verbose() and bconf_be_quiet().
>   . Use gobal bconf.verbose where possible and drop local verbose argument passing.
>   . In some patches the bconf.verbose initialization wasn't necessary so drop it.
> Some small fixes as mentioned in the individual patch.
> 
> v1->v1.1:
>   . Fix typo in HELPINFO_INSERT_QUIET.
>   . Remove #include <stdbool.h> where its no more required.
>     (was needed when %bconf.verbose was declared as bool).
>   . Use pr_verbose(-1,..) instead of all conditions printf()
>   . Use pr_verbose(1,..) instead of pr_verbose(true,..)
> 
> verbosity sample code as in v1.1
> 
> global init
> -----------
>          bconf.verbose = -1; //-1:default, 0:quiet, >1:verbose
> 
> at global options
> -----------------
> 	case 'v':
> 		bconf.verbose < 0 ? bconf.verbose = 1 : bconf.verbose++;
> 		break;
> 	case 'q':
> 		bconf.verbose = 0;
> 		break;
> 
> sub-command init
> ----------------
> For send/receive only (special cases, default verbosity is 1):
> 
> 	if (bconf.verbose < 0)
> 		bconf.verbose = 1;
> 	else if (bconf.verbose > 0)
> 		bconf.verbose++;
> 
> Non-send/receive:
> default verbosity is 0 (ref: cmds/rescue.c)
> 	if (bconf.verbose < 0)
> 		bconf.verbose = 0;
> 
> at sub-command options
> ----------------------
> 	case 'v':
> 		bconf.verbose++;
> 		break;
> 	case 'q':
> 		bconf.verbose = 0;
> 		break;
> 
> 
> pr_verbose()
> ------------
> /*
>   * level -1: prints message unless bconf.verbose == 0;
>   * level  0: quiet
>   * level >0: prints message only if <= bconf.verbose
>   */
> void pr_verbose(int level, const char *fmt, ...)
> {
>          va_list args;
> 
>          if (level == 0 || bconf.verbose == 0)
>                  return;
> 
>          if (level > bconf.verbose)
>                  return;
> 
>          va_start(args, fmt);
>          vfprintf(stdout, fmt, args);
>          va_end(args);
> }
> 
> 
> RFC->v1:
> .. Adds --quiet option to the global btrfs(8) command.
> .. Used global struct bconf.
> .. Refactored pr_verbose(), accepts level (int) as argument, so now the
> sub-command can specify the verbose level at which the particular
> verbose messages has to be printed.
> .. Added global help defines.
> 
> Kindly note the following:-
> 
> 1.
>   There are certain sub-commands which does not have any verbose output
>   or quiet output. However if the global options were used with those
>   sub-commands then the command shall not report any usage error. Or
>   my question is should it error out.? For example:
>    (with the patch) btrfs --verbose device ready /dev/sdb
>   actually there isn't any verbose output but we won't error out.
>   Similarly,
>    (without the patch) btrfs send -vvvvv will not show usage error
>    as well.
>    So I believe this is fine. IMO.
> 
> 2.
>    There is slight difference in output when global options are used
>    as compared to the output using the same sequence of options at the
>    sub-command level. For example:
> 
>     btrfs send -v -q -v  is-equal-to  btrfs send
>     But same sequence in the global option
>     btrfs -v -q -v send is-not-equal-to btrfs send
>     but is-equal-to btrfs -v send or btrfs send -v.
>     (similarly applies to receive as well).
> 
>    which IMO is fair expectation as -v is ending last.
> 
> 
> RFC:
> This patch set brings --verbose option to the top level btrfs command,
> such as 'btrfs --verbose'. With this we don't have to add or remember
> verbose option at the sub-commands level.
> 
> As there are already verbose options to 11 sub-commands as listed
> below [1][2]. So the top level --verbose option here takes care to transpire
> verbose request from the top level to the sub-command level for 9 (not 11)
> sub-commands as in [1] as of now.
> 
> This patch is RFC still for the following two reasons (comments appreciated).
> 
> 1.
> The sub-commands as in [2] uses multi-level compile time verbose option,
> such as %g_verbose = 0 (quite), %g_verbose = 1 (default), %g_verbose > 1
> (real-verbose). And verbose at default is also part the .out files in
> fstests. So it needs further discussions on how to handle the multi-
> level verbose option using the global verbose option, and so sub-
> commands in [2] are untouched.
> 
> 2.
> These patch has been unit-tested individually.
> These patches does not alter the verbose output.
> But it fixes the indentation in the command's help output, which may be
> used in fstests and btrfs-progs/tests and their verification is pending
> still, which I am planning to do it before v1.
> 
> [1]
> btrfs subvolume delete --help
>          -v|--verbose           verbose output of operations
> btrfs filesystem defragment --help
>          -v                  be verbose
> btrfs balance start --help
>          -v|--verbose        be verbose
> btrfs balance status --help
>          -v|--verbose        be verbose
> btrfs rescue chunk-recover --help
>          -v      Verbose mode
> btrfs rescue super-recover --help
>          -v      Verbose mode
> btrfs restore --help
>          -v|--verbose         verbose
> btrfs inspect-internal inode-resolve --help
>          -v   verbose mode
> btrfs inspect-internal logical-resolve --help
>          -v          verbose mode
> 
> [2]
> btrfs send --help
>          -v|--verbose     enable verbose output to stderr, each occurrence of
> btrfs receive --help
>          -v               increase verbosity about performed action
> 
> 
> 
> Anand Jain (16):
>    btrfs-progs: split global help HELPINFO_INSERT_GLOBALS
>    btrfs-progs: add global verbose and quiet options and helper functions
>    btrfs-progs: send: use global verbose and quiet options
>    btrfs-progs: receive: use global verbose and quiet options
>    btrfs-progs: subvolume delete: use global verbose option
>    btrfs-progs: filesystem defragment: use global verbose option
>    btrfs-progs: balance start: use global verbose option
>    btrfs-progs: balance status: use global verbose option
>    btrfs-progs: rescue chunk-recover: use global verbose option
>    btrfs-progs: rescue super-recover: use global verbose option
>    btrfs-progs: restore: use global verbose option
>    btrfs-progs: inspect-internal inode-resolve: use global verbose
>    btrfs-progs: inspect-internal logical-resolve: use global verbose
>      option
>    btrfs-progs: refactor btrfs_scan_devices() to accept verbose argument
>    btrfs-progs: device scan: add verbose option
>    btrfs-progs: device scan: add quiet option
> 
>   btrfs.c                     | 20 ++++++++++--
>   cmds/balance.c              | 14 ++++----
>   cmds/device.c               |  7 ++--
>   cmds/filesystem.c           | 14 ++++----
>   cmds/inspect.c              | 41 +++++++++++------------
>   cmds/receive.c              | 80 +++++++++++++++++++++++++--------------------
>   cmds/rescue-chunk-recover.c |  9 +++--
>   cmds/rescue-super-recover.c |  7 ++--
>   cmds/rescue.c               | 18 ++++++----
>   cmds/rescue.h               |  4 +--
>   cmds/restore.c              | 53 +++++++++++++-----------------
>   cmds/send.c                 | 33 ++++++++++++-------
>   cmds/subvolume.c            | 28 ++++++++--------
>   common/device-scan.c        |  3 +-
>   common/device-scan.h        |  2 +-
>   common/help.c               |  4 +--
>   common/help.h               |  9 ++++-
>   common/messages.c           | 25 ++++++++++++++
>   common/messages.h           |  3 ++
>   common/utils.c              | 16 ++++++++-
>   common/utils.h              | 11 +++++++
>   disk-io.c                   |  2 +-
>   22 files changed, 245 insertions(+), 158 deletions(-)
> 

