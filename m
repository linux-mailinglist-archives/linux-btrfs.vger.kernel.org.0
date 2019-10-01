Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11833C3197
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 12:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfJAKhE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 06:37:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44346 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbfJAKhD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Oct 2019 06:37:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91ATHwD053890;
        Tue, 1 Oct 2019 10:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=ZuqC/3XMJ1hEFP1r6E+mH/wqJRj/QNz0Y9UwB8diLdI=;
 b=D+kI2E1LVmYtij3rrvOHsj8Jg5YBAwJmE8tPeRP4KdbxUWKGj4C9SjDqrPVry24ZskWg
 8y0Len1XN3yq/7W0Hyno8TZothJPvthdFkzCWAdpOB/be+LBajGxu6QF1L1IhWwQPhpy
 MiAQE7WD+0tmzsWI9qJTlnn6QsB4kbJ7g9pE+qOEMIpLjc5ZJKihW2o8Av96RMN6gDwi
 YSM96vfdDt8+XtuwK4EqWHWHJuUQHXXnmWHtIvlmtgWk0TE7y7B4dEZ5r5ZAbTsjnsuD
 tIYvLzAHqYfHQJCRHT0ojMrHssHL1SrSkJ0THxCzgXQNTIxvDadPqF+qzE+C/xlseuCp DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v9yfq4w26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 10:36:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91ARlmj055253;
        Tue, 1 Oct 2019 10:36:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vbsm1r6x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 10:36:52 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x91Aap9T032127;
        Tue, 1 Oct 2019 10:36:51 GMT
Received: from [10.186.52.87] (/10.186.52.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 03:36:51 -0700
Subject: Re: [PATCH v2 RESEND] btrfs-progs: add verbose option to btrfs device
 scan
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org
References: <1569398832-16277-1-git-send-email-anand.jain@oracle.com>
 <1db59f87-9abc-c0ca-a086-3c65eaa5e629@oracle.com>
 <b8929b52-817f-beb4-d371-188d0edfba91@cobb.uk.net>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <818e0fa9-208b-4210-8144-7a85fcf28f30@oracle.com>
Date:   Tue, 1 Oct 2019 18:37:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b8929b52-817f-beb4-d371-188d0edfba91@cobb.uk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010099
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Shouldn't "--verbose" be accepted as a long version of the option? That
> would mean adding it to long_options.

For verbose we provide -v in
    btrfs balance
    btrfs convert
    btrfs filesystem
    btrfs inspect-internal
    btrfs rescue

and -v|--verbose in
    btrfs send
    btrfs restore
    btrfs subvolume

we kind of lost the consistency. But most of it is -v.

> The usage message cmd_device_scan_usage needs to be updated to include
> the new option(s).

  Will do.

> I have tested this on my systems (4.19 kernel) and it not only works
> well, it is useful to get the list of devices it finds. If you wish,
> feel free to add:

Thanks.

> Tested-by: Graham Cobb <g.btrfs@cobb.uk.net>

Thanks, Anand

> Graham
