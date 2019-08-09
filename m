Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E2C87C4D
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407007AbfHIOHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 10:07:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39984 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfHIOHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Aug 2019 10:07:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79E4RMF066458;
        Fri, 9 Aug 2019 14:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=zjoaU/cQFox7mHJr6Y57km1/g66zsKTytVih5vd5WsE=;
 b=hEv9h5lCYAnZlsGT3AIQZeNBWxmKMoQvtYYbT9qK2rZP0++R9k7E9LvoRw7VhxTT3L2a
 pJe98ykEn2yqRKfAp5Kx3OghNCNGdSjrYctgulQwiwj90zTYQY1Zxe5JC6IgmgPV6dk0
 lATxJqJQCx2/iwrJhStoaQTYQRzFGxtft1ONXsEZ/mbTe/KUuXseHoURu2E1GhJoOz2X
 j2JqCxvxV6P20W686PXeXyQZyLjp6H45sNhnYmjdxZnAJ5HrIUj6nVHXu4UZT7xdmnsH
 VdqxxvK7oenBRCjzMgOS+xz6ZMWMq8WlM5msIiQWPKAQB1x0fPCk1G8t6FLZosadPjvW Sg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=zjoaU/cQFox7mHJr6Y57km1/g66zsKTytVih5vd5WsE=;
 b=ZSVRr4dtrU9vDywrfxEyh8ndycmyY4i7Pfwxlw2RFVvnsExBJGPlDxIx82Iubnt6dlD+
 1YKbDUxoS5hQCAT1QhI49LHH1+oVVsakAiuVtS6804E0Hm6szofsvGnUdC/Mp7yVGxfS
 gJbtt5ekNyATAcVKlZxx81/yB7mfJQXm7Avlw+tPJudw/N1O4xLyPGNmrGTU4kuIhdOO
 XIUGcVHkpfRWt3PjPiiE2OKGWrOtYiNQfXvtcHzPHZ/yPwQd3otN+xubOeyLmFAliZma
 B+fh/9YtECYDc8Zd+dVS6KaCr12z0uxIvKAhjZw2paS0z+UFIiJaHbaYt4tVxv3aYvJ6 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u8hasfntr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 14:07:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79E2nfq009861;
        Fri, 9 Aug 2019 14:07:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2u8x9fhk7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 14:07:47 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x79E7kpx031370;
        Fri, 9 Aug 2019 14:07:47 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Aug 2019 07:07:46 -0700
Date:   Fri, 9 Aug 2019 17:07:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] Btrfs: Fix an assert statement in __btrfs_map_block()
Message-ID: <20190809140739.GA3552@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908090143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908090143
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs_get_chunk_map() never returns NULL, it returns error pointers.

Fixes: 89b798ad1b42 ("btrfs: Use btrfs_get_io_geometry appropriately")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6edd1d57e530..e69d135c7d3c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5818,7 +5818,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		return ret;
 
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
-	ASSERT(em);
+	ASSERT(!IS_ERR(em));
 	map = em->map_lookup;
 
 	*length = geom.len;
-- 
2.20.1

