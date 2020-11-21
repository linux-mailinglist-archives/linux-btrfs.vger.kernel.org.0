Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C227E2BBE19
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Nov 2020 09:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgKUIgJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Nov 2020 03:36:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34606 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgKUIgI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Nov 2020 03:36:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AL8UBhs026366;
        Sat, 21 Nov 2020 08:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=u6981nnfLIMptixIh6FAA1yEr708TcEF5/Dd1OTHJnI=;
 b=x9Rcvt4khYJcdlEau2eRNMs36VFErTDb1wradl8Byz4rHcpzYBQ1a2cdwa8Tw36+Rest
 2UPhkgatiqCPFmZorbojSd3XNZHKqzsrQcCAdj6tYoGo5GGCoJHC4+JKILoSHkRIwHJB
 wkr0EvhnfxXxcJiIYIjREZcRGB3KTD2IvYkBGyQ4m+RgaoyZ9ws7IZxBxCDXRmIBj312
 6ksnPkZrgmw7FHoL2GHv4IA3HLwwn/GaRLqWX9nyodmDpWyl0Jj5oRR5oKX7dIsZchBX
 3Y7KuZIjM9BJBj92l+/qyv6F/ZWofoes7xy1nLCfbY7XQQqKQ5lduvzReqr8AxA22g/R CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34xrdagfdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 21 Nov 2020 08:36:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AL8ZhUL064448;
        Sat, 21 Nov 2020 08:36:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34xt7h8h64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Nov 2020 08:36:02 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AL8a1Za030879;
        Sat, 21 Nov 2020 08:36:01 GMT
Received: from [192.168.1.109] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 21 Nov 2020 00:36:01 -0800
Subject: Re: [PATCH] btrfs: remove stub device info from messages when we have
 no fs_info
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20201120154312.23976-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <61d2c5af-56a9-a111-3283-dae1b8703210@oracle.com>
Date:   Sat, 21 Nov 2020 16:35:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201120154312.23976-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011210059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011210058
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/11/20 11:43 pm, David Sterba wrote:
> Without a NULL fs_info the helpers will print something like
> 
> 	BTRFS error (device <unknown>): ...
> 
> This can happen in contexts where fs_info is not available at all or
> it's potentially unsafe due to object lifetime. The <unknown> stub does
> not bring much information and with the prefix makes the message
> unnecessarily longer.
> 
> Remove it for the NULL fs_info case.
> 
> 	BTRFS error: ...
> 
> Callers can add the device information to the message itself if needed.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
