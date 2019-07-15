Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE4E682C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2019 06:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbfGOEAM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 00:00:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33088 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfGOEAL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 00:00:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6F3wmmE126145;
        Mon, 15 Jul 2019 04:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=gTwOMM589EzpRTGelALs18kW3uOuQ+sRDGULCZHg2UE=;
 b=Pg3EHHa7nHjjM0iN56Y+r1/MsYWWV/QYN+GBmgBdm3Liskg/SNSUQalMFMA0cN752Gcc
 yBK+DEI+CiNxiZJGTbSBsQtv77XFeQRpJOuu6G70pqcmtPZW1XmJPrq79z3VuOK9pE/L
 shsT1G67xCT7upljcH4cSxeJmgfpSzcdJVcODwb1zJTVf18SJOq9W7BLc0ef5fI6SCWp
 SEfj3NGedenJDQIvHXXK9DROQ5t50N14RXjGuSk6ccX1So6mlMtMokSEUf2BqmCTSWEU
 FXB6lY07NiIcnDgTUAoNmAr0bmZDVYTCa5km0gIpH9J+zunv3x+Etevil/eJuaGvZ1Dh 6w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2tq78pc1dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 04:00:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6F3w76a013407;
        Mon, 15 Jul 2019 03:58:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tq742a52x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 03:58:07 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6F3w6NK021671;
        Mon, 15 Jul 2019 03:58:06 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Jul 2019 20:58:06 -0700
Subject: Re: [PATCH v2.1 08/10] btrfs-progs: image: Introduce -d option to
 dump data
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190704061103.20096-1-wqu@suse.com>
 <20190704061103.20096-9-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c3447721-209b-e316-d90f-5524ba8a2b7e@oracle.com>
Date:   Mon, 15 Jul 2019 11:57:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190704061103.20096-9-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9318 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9318 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150046
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




> +		if (dump_data && walk_trees) {
> +			error("-d conflicts with -f option");

  should be ..with -w option

Thanks, Anand
