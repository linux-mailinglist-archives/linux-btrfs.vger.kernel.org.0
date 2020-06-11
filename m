Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DBF1F6D74
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 20:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgFKS06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 14:26:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51112 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgFKS06 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 14:26:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BICp31093364;
        Thu, 11 Jun 2020 18:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=yY9mgjAZBq115x8OhOWw0g8V2RMnEBoWyNyFIiniJZw=;
 b=sbPV9P5le7JGBLoLAw2SMfl/+aWZXq0es+BZ+ijBK9z0sF72qx0RyzXTuR8wtAIHzkxV
 iZqs0d9EnG4EOrKe3ThEdgUw0g2CiOh7sCFxUUWyGghY6rj3Y/CqAp0B6Pm+koWzC9fs
 1wqSlOzUaQg5i1YfOJ0SxouJtW2ezr8NesSWZ+lc8Gg1Yu9kU52Aq+XpYsItGd263wsE
 qmwLorc+fa6lvfpzpA0Gz0sh29fFwjX5WMOOZHY31fCP/vrbdoyIEaOZly0UeDwJ9kjN
 zStOMOa0fzwRropvu91lAVn4m3rGr+1ZqRGHII1FmxgWnGjz0PsoBqEvXhO8SmP1isYZ 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3sn97my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jun 2020 18:15:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BI3o05186190;
        Thu, 11 Jun 2020 18:13:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31gn327rpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 18:13:43 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05BIDfRJ024508;
        Thu, 11 Jun 2020 18:13:41 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 11:13:41 -0700
Subject: Re: [PATCH v2 00/16] btrfs-progs: global verbose and quiet option
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
 <8a2bac99-5c07-2aa9-fe3b-e09f2ad16213@oracle.com>
 <20200114114047.GC3929@suse.cz>
 <d38e842d-e2a7-5d27-3157-72532c3526b4@oracle.com>
 <b3981267-d64c-ebbf-233c-ea821cb7257f@oracle.com>
 <20200605092413.GA27795@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <17ad44fb-3e32-76f8-50f6-88160e7225fe@oracle.com>
Date:   Fri, 12 Jun 2020 02:13:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605092413.GA27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110143
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> Also, many options that have their own --verbose option should update
> the help text to note that it's an alias of the global.
> 
> I'm going to take another look today, the scope of the change might be
> too big to do in one go so some incremental steps might be needed.

  As global verbose depends on the local verbose to log messages, if
  local verbose used stderr then the global verbose uses the stderr.
  For example
  patch:
     btrfs-progs: send: use global verbose and quiet options

  ------------------
   ./btrfs send --help
  <snip>
     -v|--verbose     enable verbose output to stderr, each occurrence of
                      this option increases verbosity
     -q|--quiet       suppress all messages, except errors

     Global options:
     -v|--verbose       increase output verbosity
     -q|--quiet         print only errors
  ------------------

  IMO verbose should be stdout. Should it be ok to change to stdout as it
  is under verbose?

Thanks.
