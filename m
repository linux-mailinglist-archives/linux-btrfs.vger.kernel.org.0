Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0218D1012C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 06:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfKSFHO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 00:07:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfKSFHO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 00:07:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ54GON092549;
        Tue, 19 Nov 2019 05:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=OSdJnrXiJFJUzbT3dnW28p4RocW7NV0x81Q+2mH5baw=;
 b=Hz5M/DKoEtEGh1xMs172mcaXpJ6vgwwu2Cekybb+ZGFwB9Q1gImk7yof511AUVQSqZzv
 GgLqW2cYx1BbwlLcuKin1CUh8Z40F6jtgSg5o25bZIjf3+rkGE96pbQdNji6StUI8KAZ
 66OSFq09sxAwX3KkifmI+aUkfSaQT8qWxrcYO1fS6qo+10qIXJi/zHYQ85ORU+T2p5do
 H03k6FLd671I7gAUjTGz508ArA/qlVNKVtCz1B7VQSBvYWn17xp/RPb+zLBX1ppeXd26
 1T1oSmY6leu09yWHlDeD8fxxF/vqSBkAMUOxQ27cZMJ6GWrOZMffoz9wqkT3MqWMJAKU 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wa9rqccw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 05:07:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ4xUBF159688;
        Tue, 19 Nov 2019 05:07:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wbxm3n3da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 05:07:09 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJ578AL016903;
        Tue, 19 Nov 2019 05:07:08 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 21:07:08 -0800
Subject: Re: [PATCH v1.1 04/18] btrfs-progs: add global verbose and quiet
 options and helper functions
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
 <1572849196-21775-5-git-send-email-anand.jain@oracle.com>
 <20191115155816.GX3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <dc018b50-def0-1a21-695b-e8ed068ee82a@oracle.com>
Date:   Tue, 19 Nov 2019 13:07:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191115155816.GX3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190046
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/15/19 11:58 PM, David Sterba wrote:
> On Mon, Nov 04, 2019 at 02:33:02PM +0800, Anand Jain wrote:
>> +		case 'v':
>> +			bconf.verbose < 0 ? bconf.verbose = 1 : bconf.verbose++;
> 
> This code gets repeated and it's not IMO simple enough to be copy-pasted
> around. Eg. bconf_be_verbose() and eventually bconf_be_quiet().

  I was just concerned- it will make life of other developers difficult,
  IMO too much abstraction in the code is almost like learning a new
  programming language for the new person looking at the code.
  For example fstests. To write patch for fstests you need to
  learn about a lot of helpers, defines and functions and filters
  specific to fstests but you wouldn't have had this problem if the
  fstests abstractions were limited and if it embraced open-code style.
  Just my 1c.

  For now I have added bconf_be_verbose() and bconf_be_quiet() it looks
  neat as below,

+               case 'v':
+                       bconf_be_verbose();
+                       break;
+               case 'q':
+                       bconf_be_quiet();
+                       break;


>> +			break;
>> +		case 'q':
>> +			bconf.verbose = 0;
>> +			break;
>>   		default:
>>   			fprintf(stderr, "Unknown global option: %s\n",
>>   					argv[optind - 1]);
>> --- a/common/help.h
>> +++ b/common/help.h
>> @@ -53,6 +53,17 @@
>>   	"-t|--tbytes        show sizes in TiB, or TB with --si"
>>   
>>   /*
>> + * Global verbose option for the sub-commands
>> + */
>> +#define HELPINFO_GLOBAL_OPTIONS_HEADER						\
>> +	"",									\
>> +	"Global options:"
>> +#define HELPINFO_INSERT_VERBOSE							\
>> +	"-v|--verbose       show verbose output"
> 
>                              increase output verbosity

fixed.

>> +#define HELPINFO_INSERT_QUIET							\
>> +	"-q|--quiet         run the command quietly"
>   			    print only errors
fixed.

>> +
>> +/*
>>    * Special marker in the help strings that will preemptively insert the global
>>    * options and then continue with the following text that possibly follows
>>    * after the regular options
>> --- a/common/utils.h
>> +++ b/common/utils.h
>> @@ -122,6 +122,9 @@ void print_all_devices(struct list_head *devices);
>>    */
>>   struct btrfs_config {
>>   	unsigned int output_format;
>> +
>> +	/* -1:unset 0:quiet >0:verbose */
> 
> Instead of the constants, please add some defines for the unset and
> default states. Maybe also for quiet.

Fixed.

+#define BTRFS_BCONF_QUIET       0
+#define BTRFS_BCONF_UNSET      -1


Thanks for the valuable comments.
Anand


>> +	int verbose;
>>   };
>>   extern struct btrfs_config bconf;
