Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65587E0140
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 11:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfJVJ4O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 05:56:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45680 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJVJ4O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 05:56:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M9mdRZ193692;
        Tue, 22 Oct 2019 09:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=EhtU8KDJyBxHe6nq+JXxSigQbkmSNe1z3pKnRdVmlGs=;
 b=JjZsoxxIbGU2kmtnWsUSRTY+Yyyt2cjnURY9NUAFhX3I7A23rsKdCXyTjCp6UHKjF8pN
 i9fUK9O1AaDIAQkcAdKW7rD8gVaBpv2jUobf6QMgtt8XyTrJqy8VLrCiY4ET8yrnq62C
 bemJNqqVwzHqlMaRE+B+PyciWj9mdpAg0Eyv4nd/EePLZUosqhQ9vKsX+OzsUivl3jsY
 TWWVJGsGpRLItJgd9t0eFAlk/aas9BtbJZAc02sy5Q6cD+rSiNlxYYqPZI+dYQB6SlFU
 Oq+xgp8AZpcUwhDcOC8KdP4QX9NG8qdZgHc/72lqpFnIJ57kt0Mw6vwvgCjK078iFBtv nQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vqtepngf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 09:56:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M9lxHr025140;
        Tue, 22 Oct 2019 09:56:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vsx22d2xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 09:56:08 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9M9u6OG022311;
        Tue, 22 Oct 2019 09:56:06 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 02:56:06 -0700
Subject: Re: feature request, explicit mount and unmount kernel messages
To:     Chris Murphy <lists@colorremedies.com>
References: <CAJCQCtTPAm6eGA80y9LYc+Jaeo1wB0+vOMvO6B02o5JJKRFrhw@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Message-ID: <d1b51dc7-38c0-89d2-e51f-803e19773936@oracle.com>
Date:   Tue, 22 Oct 2019 17:55:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTPAm6eGA80y9LYc+Jaeo1wB0+vOMvO6B02o5JJKRFrhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220092
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


  I agree, I sent patches for it in 2017.

  VFS version.
    https://patchwork.kernel.org/patch/9745295/

  btrfs version:
    https://patchwork.kernel.org/patch/9745295/

  There wasn't response on btrfs-v2-patch.

  This is not the first time that I am writing patches ahead of
  users asking for it, but unfortunately there is no response or
  there are disagreements on those patches.

Thanks, Anand

On 10/22/19 5:00 PM, Chris Murphy wrote:
> Hi,
> 
> So XFS has these
> 
> [49621.415203] XFS (loop0): Mounting V5 Filesystem
> [49621.444458] XFS (loop0): Ending clean mount
> ....
> [49621.444458] XFS (loop0): Ending clean mount
> [49641.459463] XFS (loop0): Unmounting Filesystem
> 
> It seems to me linguistically those last two should be reversed, but whatever.
> 
> The Btrfs mount equivalent messages are:
> [49896.176646] BTRFS: device fsid f7972e8c-b58a-4b95-9f03-1a08bbcb62a7
> devid 1 transid 5 /dev/loop0
> [49901.739591] BTRFS info (device loop0): disk space caching is enabled
> [49901.739595] BTRFS info (device loop0): has skinny extents
> [49901.767447] BTRFS info (device loop0): enabling ssd optimizations
> [49901.767851] BTRFS info (device loop0): checking UUID tree
> 
> So is it true that for sure there is nothing happening after the UUID
> tree is checked, that the file system is definitely mounted at this
> point? And always it's the UUID tree being checked that's the last
> thing that happens? Or is it actually already mounted just prior to
> disk space caching enabled message, and the subsequent messages are
> not at all related to the mount process? See? I can't tell.
> 
> For umount, zero messages at all.
> 
> The feature request is something like what XFS does, so that we know
> exactly when the file system is mounted and unmounted as far as Btrfs
> code is concerned.
> 
> I don't know that it needs the start and end of the mount and
> unmounted (i.e. two messages). I'm mainly interested in having a
> notification for "mount completed successfully" and "unmount completed
> successfully". i.e. the end of each process, not the start of each.
> 
> In particular the unmount notice is somewhat important because as far
> as I know there's no Btrfs dirty flag from which to infer whether it
> was really unmounted cleanly. But I'm also not sure what the insertion
> point for these messages would be. Looking at the mount code in
> particular, it's a little complicated. And maybe with some of the
> sanity checking and debug options it could get more complicated, and
> wouldn't want to conflict with that - or any multiple device use case
> either.
> 
> 

