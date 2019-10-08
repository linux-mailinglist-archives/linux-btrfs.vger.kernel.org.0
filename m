Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B6DCF0F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 04:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfJHCxz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 22:53:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58190 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfJHCxz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 22:53:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x982oBYm070704;
        Tue, 8 Oct 2019 02:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=GUvkv5pLPKl7H1ZUwD7JCnWT8Mul643yT2Bazj8V19k=;
 b=iIlJ3bNvgl3o2LTRu5wwnoy1IUwST6JqON37X4H7M8Sy1k+nkqBekuOAuuVZqWzXYF3i
 0nCRPDBIJinBccUbr3nBEzUBsZuFoWRaM8kL3cCAjcIYHmAakbuzATW6KUxRdI8QLQgB
 dH9lENPq/ZLWdPuNnsb//RmDm+exiVHRE6aAyfkk5UPfx9k0kXYBGM9F5WQarIUGXHv4
 VTnQ+cDNjY0qkBYE8c+CP07rMg3RO1m+l0zGgE2UjTZkJOG4hUUcaEOYnB46Vr+qtqcP
 71En5GcPfpuYBr0fKK7velGZ3mk8IzqqqLdjuZvP/xw1yb+07mP//WSJarnHtWd0dw+e BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vek4qae6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 02:53:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x982rg64096940;
        Tue, 8 Oct 2019 02:53:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vg2057nvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 02:53:49 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x982rjfA026330;
        Tue, 8 Oct 2019 02:53:48 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 19:53:45 -0700
Subject: Re: [PATCH v3] btrfs-progs: add verbose option to btrfs device scan
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1569989512-5594-1-git-send-email-anand.jain@oracle.com>
 <20191007174129.GK2751@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a9c0a957-e151-32e8-a42e-b5c6d817ed78@oracle.com>
Date:   Tue, 8 Oct 2019 10:53:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007174129.GK2751@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080029
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/8/19 1:41 AM, David Sterba wrote:
> On Wed, Oct 02, 2019 at 12:11:52PM +0800, Anand Jain wrote:
>> To help debug device scan issues, add verbose option to btrfs device scan.
> 
> The common options like --verbose are going to be added into the global
> command so I'd rather avoid adding them to new subcommands as this would
> become unnecessary compatibility issue.

> There's an pattern to follow, the output formats (--format). So add a
> definition for global verbosity options, add new GETOPT_VAL global enum
> values that do not clash with existing options, add relevant
> HELPINFO_INSERT_ text string and use it in commands where needed.
> 

  IMO a debug option should rather be at the top level command.
  If verbose is the top level it would emit a lot of unwanted messages.
  Here is how a user is using --verbose option in dev scan.

 
https://lore.kernel.org/linux-btrfs/2daf15de-d1e7-b56a-be51-a6a3062ad28a@oracle.com/T/#t

------------
useful to get the list of devices it finds.
------------

  OR I didn't get the whole idea here. Looks like you are suggesting
  something like

   btrfs --verbose device scan
   btrfs --verbose subvolume list <mnt>
   ::

  How does the user will know if a subcommand will have any verbose
  or not?

  How would you not emit unwanted messages and keep the output clutter
  free.


Thanks, Anand
