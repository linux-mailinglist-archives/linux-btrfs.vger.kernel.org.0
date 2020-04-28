Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7AD1BC398
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 17:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgD1P1i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 11:27:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56318 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgD1P1i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 11:27:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFIugJ062174;
        Tue, 28 Apr 2020 15:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jVJDunWLz+Xcykb4FZHQ3k/pcx9Ztn20GwEppCiHnKs=;
 b=cQZXFsmqt6q3R3Iy1gSlI4ejVi7zuw+WTJvrusFRlmQsIzd52aP4UNRnaDRZ121K/shN
 YJJCQgNQs+jIVbl9EFwbbzqXik+w02ND1zdiCGgbrgy2Z0XyHrHCTCjmhx1ruduDamfE
 UJyg3HzWDpqYePYTuHG+hxWONFjtf2tjFMqHt05Pg+s7bbRaGCE6Ls87poHY5Y43RBRp
 sSTFqWYiI0J9z3xFqZIVt+dSumCkeFqonrwLNS7HCYcxtT67r8O2TRviI/RFuEORG4Aw
 VFd/Kyar/bEL4wQhjeLbsonmRu76VNOLuodDjea6Nw+Fn9hoRD843cr1iz8RSams2ZZU MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30nucg0p2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:27:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFD1x4134100;
        Tue, 28 Apr 2020 15:27:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30my0desh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:27:28 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03SFRRbe013087;
        Tue, 28 Apr 2020 15:27:27 GMT
Received: from [192.168.1.119] (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 08:27:26 -0700
Subject: Re: [PATCH 2/2] btrfs: add more codes to decoder table
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1588086487.git.dsterba@suse.com>
 <7557462b9680ecf965016165e100ae57f67d1182.1588086487.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5300a752-2fd6-a0de-2c2b-04a9f0df09d3@oracle.com>
Date:   Tue, 28 Apr 2020 23:27:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7557462b9680ecf965016165e100ae57f67d1182.1588086487.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280120
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Anand Jain <anand.jain@oracle.com>
