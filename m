Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32A7A31DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2019 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfH3IIV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Aug 2019 04:08:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58262 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfH3IIV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Aug 2019 04:08:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7U86esp132121;
        Fri, 30 Aug 2019 08:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=dWl+95zeAqRGZtXcoLCRBaO3HhMktrMTA2iCjDOv0zk=;
 b=VHOTeZlmS1UJ+IlwQtAr6BVhaSmAh5Z9iN5UFSg9zmWJeTTuCp1WeVeD5vadvdT1Oft5
 KdmHi8pMjbr4Df8/MWForpBuCwlfU+CHw95DV+54hZ6sDAQPrxU62ou2amKrf2/cytb1
 bkFmu647UFQl1TvptRVTv7rDMGLoA0xPCmpGfiO31WMS2CSWF9iUwMsPvP/xOkoerKAq
 DC/tsYQKYX/KXyU74HFdjkQeRAqqXk9nYy2/D30kK7Fl/CAUuIV8EshiMlcmxVaskTZ3
 xTQMocFfZCNzlCY9T6Gc4H2s3KUXa5FDvqCMZn9aNSkM6h6xBmAC/LbQ1HsLTABuHFX4 zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2uq009g0c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 08:08:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7U83Cqb137260;
        Fri, 30 Aug 2019 08:07:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2upkrg0hk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 08:07:38 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7U87WvQ024474;
        Fri, 30 Aug 2019 08:07:32 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 01:07:31 -0700
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: Spare Volume Features
To:     Marc Oggier <marc.oggier@megavolts.ch>, linux-btrfs@vger.kernel.org
References: <0b7bfde0-0711-cee3-1ed8-a37b1a62bf5e@megavolts.ch>
Message-ID: <32719c3e-6aa5-940f-6d53-59bab80d5ad5@oracle.com>
Date:   Fri, 30 Aug 2019 16:07:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0b7bfde0-0711-cee3-1ed8-a37b1a62bf5e@megavolts.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908300086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908300086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


  use-cases in production must need a spare device to maintain data
  redundancy in the event of volume disk failure, so this feature
  should be in btrfs.ko. And nntil we get there, workaround like
  monitor for write_io_errs and call for replace should help.

  HTH.

Thanks, Anand
