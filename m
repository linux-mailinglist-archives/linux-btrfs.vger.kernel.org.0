Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDD612755B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 06:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfLTFgd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 00:36:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55030 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfLTFgd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 00:36:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK5YEGe121969
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=B07R2QaQ8o1RLKm9Gx5YCf3NuPDoX+EeS2DNitEmydo=;
 b=R8m9rkCqhxKbxgmFMPSvJVXDJJ9i0ulWHrnUeuMn3YOs4t45dDPt9yDELrB19OBbgZEy
 c1JIY6N1xB7xSXGadD2wecQHrTRAx1GkxwR/lox503HQwwSc6LvwKJ95b3HUmKD7o/Hq
 c1jkHWsI82ZXu4CBUGhJBcKistVd29Sdj3cBAmSUHb1SgSuqwcf+isn1dxJ8zf+mS5I+
 rT+Anzk8kPVJCRyF+U7jEshqW3IsOVBdXdB3CsfkujquMjbD3f3Zm2VW03LPTsVSLksB
 kONB9lr0vhYqP+VXZ8n4MIeNNVrK79H/hJLbz9nQatFiXMlHEu8yBLFCkUu2rKynKYQc WA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2x01knprgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:36:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK5YIYe072659
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:36:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2x04mtrexn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:36:31 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBK5aUFE032530
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:36:30 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 21:36:30 -0800
Subject: Re: [PATCH v2 00/16] btrfs-progs: global verbose and quiet option
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
Message-ID: <fa7d3576-78eb-909b-97f1-6bb1025e7ed7@oracle.com>
Date:   Fri, 20 Dec 2019 13:36:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=776
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912200043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=842 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912200043
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Gentle ping.

Regds, Anand
