Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19952101245
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 04:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKSDxB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 22:53:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44916 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKSDxA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 22:53:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ3nTu5065643;
        Tue, 19 Nov 2019 03:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=tBGsV4A1FU2vsDGa+pWzsLQ1W2JxFmcWcuxn78PqlPM=;
 b=ZcxYRtvPTTStTqLtJwSqT3ZLFknsd7+uVaW/Mxqu8oabb3ZtZMF7wt3nivNrqVdpJ+aj
 zYkiYw686Az4ruVrXbc3QKaZtLxBmIWuNQNknCW/jziYUY1mN7FBSSytT50fwaCl9knW
 NG4eC4s7Rny5ejJ2Vf2yO6irycuweaBYkzhE8HVzj0aGMv/rtxZiRjSG0pCVak+RN6GB
 oSD9XdcqdRZTEFh2yQIVjFQk11EUp4sfr+Iuzqj5xr72YpKtuCTR6GXxw1tiN2UMjFA3
 dAF5cNSMwFy3lHGNVvCU1qerzFFN56mPF0XJYTMC++YvphlTdvBzddzEjKMfLIKJhu2A ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wa8htm9yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 03:52:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ3lk6d004768;
        Tue, 19 Nov 2019 03:50:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wbxgdqb2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 03:50:55 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJ3osAS010512;
        Tue, 19 Nov 2019 03:50:54 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 19:50:54 -0800
Subject: Re: [PATCH v1.1 00/18] btrfs-progs: global verbose and quiet option
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
 <20191115161147.GY3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <912175a5-7693-e2bc-3d18-4fd0977ea780@oracle.com>
Date:   Tue, 19 Nov 2019 11:50:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191115161147.GY3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190032
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190033
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/16/19 12:11 AM, David Sterba wrote:
> On Mon, Nov 04, 2019 at 02:32:58PM +0800, Anand Jain wrote:
>> v1->v1.1:
>>   . Fix typo in HELPINFO_INSERT_QUIET.
>>   . Remove #include <stdbool.h> where its no more required.
>>     (was needed when %bconf.verbose was declared as bool).
>>   . Use pr_verbose(-1,..) instead of all conditions printf()
>>   . Use pr_verbose(1,..) instead of pr_verbose(true,..)
>>
>> verbosity sample code as in v1.1
> 
> Please user integer numbers for patch revisions, no need to mark patches
> that haven't changed, the overall summary of changes can mention what
> changed where if needed.

  Ok got it.
  (I kind of didn't want to integer++ unless it fixes review comments).

>> pr_verbose()
>> ------------
>> /*
>>   * level -1: prints message unless bconf.verbose == 0;
>>   * level  0: quiet
> 
> Are we ever going to call the function with level == 0?

   Yes. For example in the patch

    [PATCH v1.1 13/18] btrfs-progs: restore: use global verbose option

--------------
@@ -375,8 +374,7 @@ static int copy_one_extent(struct btrfs_root *root, 
int fd,
         if (compress == BTRFS_COMPRESS_NONE)
                 bytenr += offset;

-       if (verbose && offset)
-               printf("offset is %Lu\n", offset);
+       pr_verbose(offset ? 1 : 0, "offset is %Lu\n", offset);
--------------



>>   * level >0: prints message only if <= bconf.verbose
>>   */
>> void pr_verbose(int level, const char *fmt, ...)
>> {
>>          va_list args;
>>
>>          if (level == 0 || bconf.verbose == 0)
>>                  return;
>>
>>          if (level > bconf.verbose)
>>                  return;
>>
>>          va_start(args, fmt);
>>          vfprintf(stdout, fmt, args);
>>          va_end(args);
>> }
>>
>> 1.
>>   There are certain sub-commands which does not have any verbose output
>>   or quiet output. However if the global options were used with those
>>   sub-commands then the command shall not report any usage error. Or
>>   my question is should it error out.? For example:
>>    (with the patch) btrfs --verbose device ready /dev/sdb
>>   actually there isn't any verbose output but we won't error out.
>>   Similarly,
>>    (without the patch) btrfs send -vvvvv will not show usage error
>>    as well.
>>    So I believe this is fine. IMO.
> 
> Yes this is fine.
> 
>> 2.
>>    There is slight difference in output when global options are used
>>    as compared to the output using the same sequence of options at the
>>    sub-command level. For example:
>>
>>     btrfs send -v -q -v  is-equal-to  btrfs send
>>     But same sequence in the global option
>>     btrfs -v -q -v send is-not-equal-to btrfs send
>>     but is-equal-to btrfs -v send or btrfs send -v.
>>     (similarly applies to receive as well).
>>
>>    which IMO is fair expectation as -v is ending last.
> 
> Agreed, hopefully the wild combinations of -v and -q are not too common.
> 
> The patchset looks good, though it needs the small fixups like the
> global header or the helper macros, the core of the changes is there.
> That should be good for 5.4.
> 
> The first version merged should bring the support for global verbosity
> options, then we can gradually convert all fprintf/printf to the helpers
> and add new printfs with higher verbosity levels.
> 

Yes. Will do.

Thanks, Anand
