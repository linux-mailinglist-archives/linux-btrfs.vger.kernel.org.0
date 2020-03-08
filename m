Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C617D380
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2020 11:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCHK67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Mar 2020 06:58:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35026 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgCHK67 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Mar 2020 06:58:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 028AtjVB001651;
        Sun, 8 Mar 2020 10:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kINgjCvQrFN1H94vBQ2EqzD1V+wSng60QRFxon4e8aE=;
 b=fWC9bHKS2/Ir7+oiTAuny2VNI+7Upd+WWOGyHmgph0eyVmMIwTqJJTZd+oT4jfAizueh
 Hud/U0EZBoftHuTmPX4EGu5oUWnOlICx/C7EeDW4bL8zi4MeWGHUJ00Imm1gpagXpvXb
 PP/K9guR/Txoo9+s8rPRrCfdsOLyv0y7WTCOmogEe06x+lILg0I32UqUnQQC9pbonvYD
 FjMbCglxvW5c06gZTGeYgQOh9Tni784ZfvL9JC2tpT0DAESwo9/AJpHhUN6XV1WF8GLo
 9lv15NDZX3llvHcG1KTt/z+RPp9nlfsZlRLTS4t5ahgyJ8BEKuGLcKv9y0HpXXevoYp+ 7w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ym31u3554-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Mar 2020 10:58:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 028Aqwmb060957;
        Sun, 8 Mar 2020 10:58:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ymnd9pavj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Mar 2020 10:58:41 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 028AweX4021342;
        Sun, 8 Mar 2020 10:58:40 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 08 Mar 2020 03:58:39 -0700
Subject: Re: [PATCH 0/2] btrfs-progs: Auto resize fs after device replace
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200307224516.16315-1-marcos@mpdesouza.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <95a53477-a71d-5304-f4b2-8a0225414050@oracle.com>
Date:   Sun, 8 Mar 2020 18:58:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200307224516.16315-1-marcos@mpdesouza.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9553 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003080084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9553 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003080084
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/8/20 6:45 AM, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> These two patches make possible to resize the fs after a successful replace
> finishes. The flag -a is responsible for doing it (-r is already use, so -a in
> this context means "automatically").

If resize fails we should be able to fail the replace as well which does
not happen here. I am thinking this should be kernel feature, do the
resize part before calling btrfs_dev_replace_finishing().

IMO, it makes sense that replace and resize be in one command as
proposed in this patch. We had similar discussion whether to combine
replace and resize of missing device here:
    https://patchwork.kernel.org/patch/11249009/

-Anand

> The first patch just moves the resize rationale to utils.c and the second patch
> adds the flag an calls resize if -a is informed replace finishes successfully.
> 
> Please review!
> 
> Marcos Paulo de Souza (2):
>    btrfs-progs: Move resize into functionaly into utils.c
>    btrfs-progs: replace: New argument to resize the fs after replace
> 
>   Documentation/btrfs-replace.asciidoc |  4 +-
>   cmds/filesystem.c                    | 58 +--------------------------
>   cmds/replace.c                       | 19 ++++++++-
>   common/utils.c                       | 60 ++++++++++++++++++++++++++++
>   common/utils.h                       |  1 +
>   5 files changed, 83 insertions(+), 59 deletions(-)
> 

