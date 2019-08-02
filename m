Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4100B7EABD
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 05:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfHBDlK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 23:41:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56372 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfHBDlJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Aug 2019 23:41:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x723dR1B161859;
        Fri, 2 Aug 2019 03:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Wb3GncaLPDtvdPyjBku4n8drGF3QoFjUmcER621uB/M=;
 b=TiQ8DQ3WV9v37dx8qjKQBS0KSHZAqWgyhqaRw6Gy48Ee3RzLupyd3wI3tnJ1XFenUZmV
 dqUPDZ/buP+l/8v4kfxpRdLAVsFyfWOCxrYz5PxQm/B/7kRNQXAmN8YXXyUaUpBr+Tpz
 9h45gy3Z3pF7PqkDpLJOTqiwR4D2z2kQ5FbDYemL83AdnNcm3JKukhz3xHbv7vpxa+3D
 FJQ8wJGDGk4rHirxEHRoGU7wy3GGrtufrnvXwugI8YMe7ggjtwksZ0ygmu3/Dk6F8aOR
 YyxGidrTHXGvMS6T9YdUra+s+1YIIZqsUcZwUeeSUaBCP5Fc2QAyXPJq/tAm1BuZfUb8 bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2u0e1u7kjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 03:41:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x723bxY5058237;
        Fri, 2 Aug 2019 03:41:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2u49htvhm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 03:41:05 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x723f4ub015385;
        Fri, 2 Aug 2019 03:41:04 GMT
Received: from [192.168.1.147] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Aug 2019 20:41:03 -0700
Subject: Re: [PATCH 2/2] btrfs: remove unused key type set/get helpers
To:     David Sterba <dsterba@suse.com>
References: <cover.1564681931.git.dsterba@suse.com>
 <69849572853391c7e2e3aadd2f169786ec663234.1564681931.git.dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <12a43ab8-78c0-2553-753f-70277d70fe39@oracle.com>
Date:   Fri, 2 Aug 2019 11:41:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <69849572853391c7e2e3aadd2f169786ec663234.1564681931.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908020036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908020036
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/2/19 1:53 AM, David Sterba wrote:
> The switch to open coded set/get has happend long time ago in
> 962a298f3511 ("btrfs: kill the key type accessor helpers"), remove the
> stray helpers.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
