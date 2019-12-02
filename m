Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF85A10E516
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 05:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLBEiJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Dec 2019 23:38:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34340 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfLBEiJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Dec 2019 23:38:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB24TExn166392;
        Mon, 2 Dec 2019 04:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=b8+o2D/sn5W2cVwdz1x5dpWpUERgubY21024dPcoVQ0=;
 b=WgtoX+j2nH8dWqOHy7bWZ4SphhmfnxxrnSwEegqD1sog3E7zaNcUE82znh1R3ErxRBuf
 dDdURfc0iPG7/eObd+bwlKOfHd7fUJWreU+4SO63OKvEOscJxmhOqtMOlJVhMsZxgXbu
 eZPTYyP08B0PAZ1ekk1ATII97V2YS3EFdBepMyPBxMukoXBjHdgCKPpp4owszam88om3
 Po0zwSnxsM6bTIZVWTWTOHKsKJ83GOrGzJqdnIH1xIsqQVweanRbXbuFldya4daESNjh
 ERojqcxsuqBuAVi5CDBmN+IwxFY+pDHRm9H39sJ7QGCwRACmAvgKFHpcVme2TYRvriDj eQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wkfutwfms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 04:37:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB24T77E047523;
        Mon, 2 Dec 2019 04:37:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wm1xjm2e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 04:37:58 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB24bvFP002925;
        Mon, 2 Dec 2019 04:37:57 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Dec 2019 20:37:57 -0800
Subject: Re: kernel trace, (nearly) every time on send/receive
To:     Christoph Anton Mitterer <calestyo@scientia.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <21cb5e8d059f6e1496a903fa7bfc0a297e2f5370.camel@scientia.net>
 <768283ac-99c5-0fd1-2acb-e504cbb1f3fd@oracle.com>
 <5cea01b65a3cfe773300f69d5847cdc457ab49d1.camel@scientia.net>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <46777ed1-acb5-4f5e-e981-17d1f71fe815@oracle.com>
Date:   Mon, 2 Dec 2019 12:37:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5cea01b65a3cfe773300f69d5847cdc457ab49d1.camel@scientia.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912020038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912020038
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2/12/19 11:30 AM, Christoph Anton Mitterer wrote:
> Hey Anand.
> 
> Thanks for looking into this.
> 
> On Mon, 2019-12-02 at 10:58 +0800, Anand Jain wrote:
>> Looks like ORPHAN_CLEANUP_DONE is not set on the root.
>>
>>           WARN_ON(send_root->orphan_cleanup_state !=
>> ORPHAN_CLEANUP_DONE);
>>
>> ORPHAN_CLEANUP_DONE is set unless it is a readonly FS, which I doubt
>> is,
>> (can be checked using btrfs inspect duper-super <dev>) because you
>> are
>> creating the snapshot for the send.
> 
> I should perhaps add, that there are two btrfs filesystems involved
> here:
> The first is basically the master, having several snapshots including
> all + one newer which is missing from the second (which is basically a
> backup of the master).
> 
> So it's about:
> /master# btrfs send -p already-on-copy newer-snapshot | btrfs receive /copy/snapshots/ ;
> 
> In fact /master is mounted ro only here, whereas /copy is of course
> mounted rw.
> Since nothing should be changed on /master I assumed it would be ok to
> have it mounted ro.
> 

  I am able to reproduce. Create send from the readonly mounted FS
  and we log the warning as we couldn't clean the orphan flag. It's
  false positive log. Will fix.

  As of now there is nothing that tells me the FS at your end would
  need a btrfs check so please ignore that part.

  One question though - why the FS is readonly mounted? Its ok if that's
  part of your operations.

Thanks, Anand


>>   btrfs check --readonly might tell
>> us more about the issue.
> 
> I cannot do this right now since I'll be on some diving vacation for ~2
> weeks,... but since --readonly is the standard behaviour (i.e. same
> without --readonly) I'm pretty sure that a fsck (which I always do
> after each snapshot to the /copy) brought now visible errors.
> 
> 
> Does the whole thing imply any corruption to any of the two
> filesystems... or is it just a "cosmetic" issue?
> 
> 
> Cheers,
> Chris
> 
