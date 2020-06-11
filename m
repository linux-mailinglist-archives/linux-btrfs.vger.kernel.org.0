Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DC61F6CEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 19:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgFKRlq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 13:41:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49132 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKRlp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 13:41:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHaVtD039822
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=9FzUIGJOSimQqHKTqeZsBeZAdMFz9wTVAJb3oVSSZWQ=;
 b=dO3fOHrnnPmVf6d8h9D24BMU/sRRQsZqJB1b3elzXzNPVK0JJPShjwRm8bWNhD6rqHlW
 0W+1jp6AyvszFtV0RLfgtK9bQibI8Ct1q3vqAFMW+KxqC3LXIN7Y6vknp6Fx7pYwbZCN
 SMh/71ySckSn0B58W8hjkGUXKcXhoPJRRlUBY4rOEPP/TR8DCUTueIT9gm1wMO3wgfjq
 9FMEDe3fdhjPkVHZA4kuBOWJHY1gZ+riEUYMtz3mv7CJeLRpOfzYj367r2LTUn+H8laA
 tutkNmYOLdS6dmTRWM9Z+TbWecRD44X5/RV5y2j5WVN3bHdb7QWkALpMABq9oWQx/jWR gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3sn92te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:41:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHbnjt065919
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:41:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31gn326f0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:41:43 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05BHfgls019773
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:41:42 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 10:41:41 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8 v2 PART2] btrfs-progs: add quiet option
Date:   Fri, 12 Jun 2020 01:41:15 +0800
Message-Id: <20200611174123.38382-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110139
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2: pr_verbose()'s first argument %level can accept -1, and if the
    quiet option is not set, pr_verbose() shall print the message
    overriding the verbose level set during the command option.
    We need this -1 level to make sure we continue to print the
    messages which have been printed with the default log level,
    so that backward compatibility is maintained.

    Now in v2 value: -1 is defined as MUST_LOG. The relevant patch
    is sent as a reroll patch v3 
[PATCH v3 02/16] btrfs-progs: add global verbose and quiet options and helper functions
    in the part-1 set. So replace -1 with the new define wherever
    necessary.

    The whole series (both part-1 and part-2) has been pushed to
    the git repo branch as below [2].

----- main cover-letter -------
The part-1 patchset [1] 'btrfs-progs: global verbose and quiet option'
[1]
https://patchwork.kernel.org/project/linux-btrfs/list/?series=207709

provided a global structure to communicate the verbose and quiet options
down to the individual sub-commands where the actual printf happens.
So each of the sub-command could enable the verbose or quiet option as
needed.
But some of the sub-commands already had the verbose and quiet options
locally at the sub-command level. So the aim of part-1 of this series
was to merge the local verbose and quiet option with the global verbose
and quiet, which it did successfully.

In this series, part-2, adds the global quiet option to the found
chatty sub-commands. So each of the sub-commands outputs were 
individually checked and brought those logs under the global quiet
option. As this process is nondeterministic (unless like in part-1 where
sub-commands with -v or -q were checked) so there might have few logs
left behind and those can be fixed as moved along.

The whole series can be fetched from [2], which is based on latest devel
branch, last commit: c1d6d654a3f9 (btrfs-progs: docs: update balance).

[2]
https://github.com/asj/btrfs-progs.git verbose

Anand Jain (8):
  btrfs-progs: quota rescan: add quiet option
  btrfs-progs: subvolume create: add quiet option
  btrfs-progs: subvolume delete: add quiet option
  btrfs-progs: balance start: add quiet option
  btrfs-progs: balance resume: add quiet option
  btrfs-progs: subvolume snapshot: add quiet option
  btrfs-progs: scrub start|resume: use global quiet option
  btrfs-progs: scrub cancel: add quiet option

 cmds/balance.c   | 17 +++++++++++------
 cmds/quota.c     |  4 +++-
 cmds/scrub.c     | 27 +++++++++++++++++----------
 cmds/subvolume.c | 24 +++++++++++++++---------
 4 files changed, 46 insertions(+), 26 deletions(-)

-- 
2.25.1

