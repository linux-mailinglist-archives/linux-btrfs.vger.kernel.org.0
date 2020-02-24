Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81ACD169CA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 04:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgBXDbX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Feb 2020 22:31:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60448 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgBXDbW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Feb 2020 22:31:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O3N0tG059604;
        Mon, 24 Feb 2020 03:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=PrW1Abyu1kEQGP77FZasIjhJaq7Z23rm70nZwdVivzY=;
 b=aD0I5METQzeWU8amxyfyEdPVCBdKib8CIllID2GLMRo9mjR5kNU78dcJHvhcancp1XqS
 RKswt2vNEkZMhIJQdg1mFcCzwqJahP8Snn2H7NxF5xIZhacqVBqw0IWcO28iiIyksmSo
 K7zLVX/8UyKdZ551id6+8NYTYPs7dArp2auQRKf52r2Cb1xnGG0MRdHHTt5w2jKE+ZjF
 VULCGm6f5np/tLxA6Uft0E846P/PW//6aWSgIifiX+CLO9JoKDZIzo6cAbRiDCU6xvZh
 2fvr2T+3lHwU/B1QsbRSC2u8DkFkP5gRVnHGroaqefgOMHAw8L9fRRk8ozah6Hmxns0Y Mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yavxrcn1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 03:31:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O3SicZ179411;
        Mon, 24 Feb 2020 03:31:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2ybe104yvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 03:31:18 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01O3VHe3022234;
        Mon, 24 Feb 2020 03:31:17 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Feb 2020 19:31:17 -0800
Subject: Re: [PATCH 02/11] btrfs: move mapping of block for discard to its
 caller
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1582302545.git.dsterba@suse.com>
 <32b32a9b68f956a3bfe216b72060001811a71d01.1582302545.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <0ab1fdaa-41fc-4f6b-615b-719df2c949be@oracle.com>
Date:   Mon, 24 Feb 2020 11:31:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <32b32a9b68f956a3bfe216b72060001811a71d01.1582302545.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240027
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/22/20 12:31 AM, David Sterba wrote:
> There's a simple forwarded call based on the operation that would better
> fit the caller btrfs_map_block that's until now a trivial wrapper.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

reviewed-by: Anand Jain <anand.jain@oracle.com>
