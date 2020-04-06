Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C89719F5A5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 14:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgDFMOO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 08:14:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54624 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgDFMOO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 08:14:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036CDg22125963;
        Mon, 6 Apr 2020 12:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=VBRH0n+cTM8LYcEjz1f5DW61ValrU2pSct5+AowMS2M=;
 b=Zl+648cPakbrLZh/QfjuegrZH3BrBzOJYQgU+jH5jZKvd/yU3dX1xURgPO3YJPkPNSNq
 oLmxAU/GYnkehr3w1JC0Gry3F5GsDfMATnZnUhtcO+7wWjyrDCs8IDXrhnMdfj71O9dG
 7ceqxbeEduBmGbTuNCExmW8XPQft90k8ziSCsdcyUhwShNUq7rRfZP6x6iTc5ieoOT0Y
 vTZ3ijpfLBa+lp4LhOE+1r1NbzWufsRvQxkqZyIUDr9Isjfz9NlLlbtoHKL5Ra/z7+WG
 xh3mKnQnW0T3DGw+c+cu19BR+65+I4JYsHlKs2gJSlQ+thnLwoOMjWNZtv2H+tgqZMe6 UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 306j6m6e3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 12:13:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036CCZN1165865;
        Mon, 6 Apr 2020 12:13:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3073sptu22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 12:13:50 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 036CDmKn026414;
        Mon, 6 Apr 2020 12:13:49 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 05:13:48 -0700
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
To:     fdmanana@gmail.com
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <636dfbc5-32a7-bdf3-b83b-93e65901aa43@oracle.com>
Date:   Mon, 6 Apr 2020 20:13:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=911
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060108
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> 7) When we do the actual write of this stripe, because it's a partial
> stripe write
>     (we aren't writing to all the pages of all the stripes of the full
> stripe), we
>     need to read the remaining pages of stripe 2 (page indexes from 4 to 15) and
>     all the pages of stripe 1 from disk in order to compute the content for the
>     parity stripe. So we submit bios to read those pages from the corresponding
>     devices (we do this at raid56.c:raid56_rmw_stripe()).


> The problem is that we
>     assume whatever we read from the devices is valid - 

   Any idea why we have to assume here, shouldn't the csum / parent
   transit id verification fail at this stage?

   There is raid1 test case [1] which is more consistent to reproduce.
     [1] https://patchwork.kernel.org/patch/11475417/
   looks like its result of avoiding update to the generation for nocsum
   file data modifications.

Thanks, Anand


> in this case what we read
>     from device 3, to which stripe 2 is mapped, is invalid since in the degraded
>     mount we haven't written extent buffer 39043072 to it - so we get
> garbage from
>     that device (either a stale extent, a bunch of zeroes due to trim/discard or
>     anything completely random).
>
> Then we compute the content for the
> parity stripe
>     based on that invalid content we read from device 3 and write the
> parity stripe
>     (and the other two stripes) to disk;


