Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7B9FA76E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 04:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKMDlh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 22:41:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39276 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfKMDlg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 22:41:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAD3dEnW131603;
        Wed, 13 Nov 2019 03:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=k+ctU8ulrsftnSpJSadCDeieKPWMej3UZYOWs14eEt4=;
 b=Hw1+JLRm3AIFLjTa6z7xiFvlXjw7CcJvJZ2Ud7PnVUqgIMWhJ4lbjvS0n5O9Uk6SG+zs
 lC69INfFIN5vRSTUG0zp/4QadpgJagRSZse0UFDLXd2sGD+QdTONw2+6K99N1S21Su6v
 OD1wcg31lSB6HVCYaqsgRb2rk92q2N+xmIifJUWZOJn3PdwxkURD65g8ar/d63+HYM9Q
 NiIx/h8B/9UgV9SdjN4a5BTE+KX2T7358ov+qrFRfh9ZQk9eM3ibN3frSQGMjykwvTUH
 4ko4yWUcBuTZcP5IhdfJgD4rlgTTVyO72Hsg4uMY48xCnEFekaqAvprFrKRy4Gtkg92b cQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2w5mvtscgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 03:41:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAD3caH7048814;
        Wed, 13 Nov 2019 03:41:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w7vpnh1m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 03:41:26 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAD3fPDE021387;
        Wed, 13 Nov 2019 03:41:25 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 19:41:25 -0800
Subject: Re: Potential CVE due to malicious UUID conflict?
To:     Timothy Pearson <tpearson@raptorengineering.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <1204250219.669.1573609035591.JavaMail.zimbra@raptorengineeringinc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c3996c5a-477e-b1ee-0455-3366a1b5fadc@oracle.com>
Date:   Wed, 13 Nov 2019 11:41:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1204250219.669.1573609035591.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130029
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/11/19 9:37 AM, Timothy Pearson wrote:
> I was recently informed on #btrfs that simply attaching a device with the same UUID as an active BTRFS filesystem to a system would cause silent corruption of the active disk.
> 

> Two questions, since this seems like a fairly serious and potentially CVE-worthy bug (trivial case would seem to be a USB thumbdrive with a purposeful UUID collision used to quietly corrupt data on a system that is otherwise secured):
> 
> 1.) Is this information correct?
> 2.) Does https://lkml.org/lkml/2019/2/10/23 offer sufficient protection against a malicious device being attached iff the malicious device is never mounted?
> 
> Thank you!
> 

  Corruption of the data is not possible at all. Because when the device
  is mounted its already been excl-opened for RW and we won't
  close/replace it unless unmounted. And while the device is mounted
  if there is malicious device with the same UUID, then any scan shall
  fail with -EEXIST if the kernel has the commit as in [2] (above).

  However if the kernel does not have [2], then it will just
  appear as if the original device path has been replaced, but
  underneath the RW IOs are still going to the original device
  and not to the malicious device, so its safe.


HTH

Thanks,
Anand
