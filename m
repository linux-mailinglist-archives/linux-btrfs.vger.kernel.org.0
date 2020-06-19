Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022E3200AAA
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 15:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbgFSNuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 09:50:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57212 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgFSNuS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 09:50:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05JDlavF058331;
        Fri, 19 Jun 2020 13:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Rs69d24JeqcVi2TouBsmVXSCfudLuFNO/UBjXx1gX/8=;
 b=dUJZabJJNBQfk/9CfRuotcqV/N3279Oapk7TRerOrfn9Lzo4mIl5B9T/Do8kN8TYzotm
 5VKrzN5Vp4w2u/RvoVgN+4drW6XmX3c7oKDi42SId8DSMsKGsnibHW7l6G2cAejZIQEk
 OD204ptq5/YEcvnL6dHjR/h6VYmxUT4AZxRq5kMCtHAaiMqaJzv1fcdLRq3BDyaNzxNu
 YL/A4b+NNsBZDVWrFhMdHcrZA1TGrsoKAgnx9JosNxyEyjAA+Vu6pAyL2bOj9YTSMi2v
 l87jMn8wsEtiHST+xqyZJXtANGc06brdxhHZnx5KgStOl7Lktl5TqWTw5ttAIcp3gQs0 SQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31qg35csef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jun 2020 13:50:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05JDlHqj038355;
        Fri, 19 Jun 2020 13:48:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31q66rhcnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 13:48:14 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05JDmCYA019745;
        Fri, 19 Jun 2020 13:48:13 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Jun 2020 13:48:12 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: fix wrong chunk profile for
 do_chunk_alloc()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200616063230.90165-1-wqu@suse.com>
 <20200616063230.90165-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <cc74b1b4-0694-0e45-10bc-3e529bd98b11@oracle.com>
Date:   Fri, 19 Jun 2020 21:48:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616063230.90165-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 cotscore=-2147483648 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006190102
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>
