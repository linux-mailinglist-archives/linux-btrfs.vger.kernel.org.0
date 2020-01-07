Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7095131CED
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 01:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgAGA5R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 19:57:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52756 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgAGA5R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 19:57:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0070rqKO137500;
        Tue, 7 Jan 2020 00:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=zx9/09uxBbTCX6go6UeXdHjxlycz0f4FN6PGw46XXaE=;
 b=aUxfnG4R7zAtvygHqtzxH926V3FDwKNeOvHbn8NFJsB1i5n2uwAMma7VME2mMmjWvvvX
 99uVEPLt/BXNyhWTLXRXbYx7HhYJ/qg1aENDgeyaTxcdRa7gwsq/3td6ucpPaDo/sdEK
 y9N1cLKZVPNGhLf9t2PJVSusHIOIT9dFAYQ1r5JPmPwFRRMNncZivXQFAwfSb3Lk3+Lj
 zWMGkaMZaMArN7dpsfjftEHgj0QiV5vqArLon8Vup3rG+mvuYST7UcG67fvfgkUwjyud
 V8YiwSYX1TKTphbfAmLyNTffUv4Pv/QDLaRMjk1WbX9ZBFiiYfGIb6EnQm+/WRmHNhJk 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xakbqjatb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 00:57:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0070rDmZ127251;
        Tue, 7 Jan 2020 00:57:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xb4uq09vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 00:57:12 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0070vBIL001148;
        Tue, 7 Jan 2020 00:57:11 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 16:57:11 -0800
Subject: Re: [PATCH] btrfs: remove unused member btrfs_device::work
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200106162028.10029-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b408523f-c170-3b13-f888-18d7ba10b0d9@oracle.com>
Date:   Tue, 7 Jan 2020 08:57:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200106162028.10029-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070004
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Reviewed-by: Anand Jain <anand.jain@oracle.com>
