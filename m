Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D7F15A4C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 10:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgBLJ3y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 04:29:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56572 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbgBLJ3y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 04:29:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C9MQF7043850;
        Wed, 12 Feb 2020 09:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=rtjbavNA4zglgCv5CAcHBn5B6k3ImdLrcxAlbKvidd8=;
 b=ICzoaZlNPA8TL/9k0SVhN5QMSKeZ/EWXJRmk27NhRS2rjWX/KRgHm6yl2PAfQFhY/uSH
 zb5Dp4c1ZbVcBQoCnC/RRNn5oCP9/wvXF51Y+HS3ndTH9k+Or6kUVSChF/+ExZ356pSn
 6/F8/nsoAf7MVrSXmbq2srsa+RZ1cYE2nZPpiaKWFZNA2OM7Bl35leW/lNh+rLIXe3TB
 zSiQoq0+Si4rwo7gnL4nmJ8QyYnPFFdIWcaedom699I3+w1g6SGUgruzilMdzdGjF9jl
 fBaJmI2g17IoRxoKctaSMZMKkmmTQbbmwh73eb364/p4WMY+SNWb34rIgpXeZDszaa5F aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y2jx697xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 09:29:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C9MD85115388;
        Wed, 12 Feb 2020 09:29:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y26hwkhqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 09:29:47 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01C9TkaC010716;
        Wed, 12 Feb 2020 09:29:46 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 01:29:46 -0800
Subject: Re: [PATCH 0/4 RESEND 1-3/4 v5 4/4] btrfs, sysfs cleanup and add
 dev_state
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20200203110012.5954-1-anand.jain@oracle.com>
 <20200203171659.GA2654@twin.jikos.cz>
 <c0ac6404-ed46-be94-ac05-01c723f05134@oracle.com>
 <20200206141136.GX2654@twin.jikos.cz>
 <5a9e45e2-645c-e15e-c87c-6914d3e2f397@oracle.com>
 <20200211192904.GG2902@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4f037b58-ed6a-7f78-24bb-4465d4e5b713@oracle.com>
Date:   Wed, 12 Feb 2020 17:29:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211192904.GG2902@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120075
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> * "btrfs: sysfs, add UUID/devinfo kobject"
> * fixup of the device id files created under devices
> * the other cleanups

  Done. Its here:

  https://patchwork.kernel.org/cover/11378051/

