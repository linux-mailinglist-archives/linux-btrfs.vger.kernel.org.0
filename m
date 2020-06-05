Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF511EF51C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jun 2020 12:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgFEKMo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jun 2020 06:12:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55116 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgFEKMm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jun 2020 06:12:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055A83WN071764;
        Fri, 5 Jun 2020 10:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SOg1you79UFTl5L2dq70EPuyQAEhIVOvZixI1Hjy0jU=;
 b=YUpfawUgiVeebjMnY2//4tLo2TWoHwRFHZvWRJUYlhunmhZ1gKGrs8orCaHYwlrFSmZL
 G9LSbakzlS9/KuNHs+qfDAyQaRlvEXPeeGpeQET3I5xqBFsd7267ZvvKzltLT5okS7RP
 QvLCS9A5jre9OBKPdkdOZBl2C3sJ5YMLKk4pn4LrwU1421uVmUfn31pxYGyyhC4yhkYg
 O38elenOw62nukQXxHK7VVfPEs+sN3exLk+ADh/Ut3veacbVGy5qkCLuCoFcx2n+l8Qn
 ulT6TTxLSPVgOiCq8u9lSQHCeb1ZJ5hK+zHe8DjJyRacuFv/V3Nspk4bNKY3Vc2ubagB lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31f924255a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 10:12:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055A87XW108119;
        Fri, 5 Jun 2020 10:12:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31f9271vr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 10:12:35 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 055ACYm3005540;
        Fri, 5 Jun 2020 10:12:34 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 03:12:34 -0700
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
Message-ID: <525dc473-b717-a274-f083-3ab280e83add@oracle.com>
Date:   Fri, 5 Jun 2020 18:12:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605092413.GA27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 bulkscore=0
 lowpriorityscore=0 cotscore=-2147483648 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050077
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> My first test was 'btrfs -q subvolume create' and 'delete' and
> that -q did not work is surprising. The -v/-q options need to come in
> the same release.

  Ah. I thought rest of the commands shall adopt -q option progressively.
  So its not unfinished. Anyway I can fix them now.

> Also, many options that have their own --verbose option should update
> the help text to note that it's an alias of the global.

  Hmm. Yep. Fixing them.

> I'm going to take another look today, the scope of the change might be
> too big to do in one go so some incremental steps might be needed.

  Sure. Thanks.

Anand

