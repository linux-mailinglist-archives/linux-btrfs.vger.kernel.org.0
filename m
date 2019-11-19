Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A385B10123D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 04:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfKSDhI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 22:37:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59344 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKSDhI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 22:37:08 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ3aIYn055123;
        Tue, 19 Nov 2019 03:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=xu/k1/Cc6AFJ+v1uae29gSzF9aV6v+MH0cn9UIfcD8E=;
 b=nKUuhL/+g3zEBCXZHEyTbdIZpdzn4XYPQOAYWEqhTzWAHxjnKjUgfToR7ZROTxGerG7d
 TLMNZmnWKQXfcE2bY/qLOmywLSedlvN+fa81IHqH/RnhYgQjlp3WaeqVCTghRSj33+C0
 1Lzy2OsyJNX51Ev3EoUFfEmzGphlFhNXEXet23+/O3SghvB2a/Lys3fTuqafnK0VeArJ
 s2o+yfLUj357whrqx+cvJwDDwYETUSNY2/1c24v21gw1N+vbleel9TrZRFFx5PPb2o80
 Ip7kZ3lDj7YLoruiFIBy5c5/GnUrhaPN1ObTERwtehDd7OZG1XgFAYN6TNSalQOBsOr8 Pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wa8htm80v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 03:37:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ3S6Ym112459;
        Tue, 19 Nov 2019 03:37:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wc0afmudf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 03:37:04 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJ3b2JU003136;
        Tue, 19 Nov 2019 03:37:03 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 19:37:02 -0800
Subject: Re: [PATCH v1.1 04/18] btrfs-progs: add global verbose and quiet
 options and helper functions
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
 <1572849196-21775-5-git-send-email-anand.jain@oracle.com>
 <20191114160813.GK3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6852d675-0244-388e-899f-008dc53b6ad9@oracle.com>
Date:   Tue, 19 Nov 2019 11:36:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191114160813.GK3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190030
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/15/19 12:08 AM, David Sterba wrote:
> On Mon, Nov 04, 2019 at 02:33:02PM +0800, Anand Jain wrote:
>>   /*
>> + * Global verbose option for the sub-commands
>> + */
>> +#define HELPINFO_GLOBAL_OPTIONS_HEADER						\
>> +	"",									\
>> +	"Global options:"
>> +#define HELPINFO_INSERT_VERBOSE							\
>> +	"-v|--verbose       show verbose output"
>> +#define HELPINFO_INSERT_QUIET							\
>> +	"-q|--quiet         run the command quietly"
>> +
>> +/*
>>    * Special marker in the help strings that will preemptively insert the global
>>    * options and then continue with the following text that possibly follows
>>    * after the regular options
> 
> I've realized there's more magic around the global options, because
> currently the --format option depends on the subcommand definition thus
> it can't be a static text like you do with the definition of
> HELPINFO_GLOBAL_OPTIONS_HEADER.
> 
> There's a special keyword that gets replaced, the verbose/quite options
> don't need that so it's just the plain textual definition/description.
> 
> As this is a simple fixup
> s/HELPINFO_GLOBAL_OPTIONS_HEADER/HELPINFO_INSERT_GLOBALS/, hold on with
> resending I might find more things or fix it myself.
> 

But there is one problem,  HELPINFO_INSERT_GLOBALS is already defined
as..
      Global options:
     --format TYPE      where TYPE is: text

(ref: common/help.c   do_usage_one_command())

Albeit all commands support --format text by default.

But no sub-command is using the HELPINFO_INSERT_GLOBALS in its usage.

Looks like its a good idea to separate title and the options, like
#define HELPINFO_INSERT_GLOBALS		"Global options:"
#define HELPINGO_INSERT_FORMAT		"--format TYPE"

As at the moment I am not sure if its safe to declare that all
sub-commands will support --format json (whenever we do that).

So with the defines split as above, in each sub-command-usage
we shall do..

-----------------------------------------
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 4f22089abeaa..f4dba38b4c17 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -631,6 +631,10 @@ static const char * const 
cmd_filesystem_show_usage[] = {
         "-m|--mounted       show only mounted btrfs",
         HELPINFO_UNITS_LONG,
         "If no argument is given, structure of all present filesystems 
is shown.",
+       HELPINFO_INSERT_GLOBALS,
+       HELPINFO_INSERT_FORMAT,
+       HELPINFO_INSERT_VERBOSE,
+       HELPINFO_INSERT_QUIET,
         NULL
-----------------------------------------


Thanks, Anand
