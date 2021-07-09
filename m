Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F13C3C1FF7
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 09:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhGIH0D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 9 Jul 2021 03:26:03 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:43174 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhGIH0C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 03:26:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 59DC33F40C;
        Fri,  9 Jul 2021 09:23:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5z0-6i66zVI0; Fri,  9 Jul 2021 09:23:17 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1BE7D3F2B8;
        Fri,  9 Jul 2021 09:23:16 +0200 (CEST)
Received: from [2a00:801:73f:ae45::1695:a24] (port=43518 helo=[10.83.231.229])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1m1kqy-000IK8-3s; Fri, 09 Jul 2021 09:23:16 +0200
Date:   Fri, 9 Jul 2021 09:23:14 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Message-ID: <475ccf1.ca37f515.17a8a262a72@tnonline.net>
In-Reply-To: <20210709065320.GC8249@tik.uni-stuttgart.de>
References: <20210310074620.GA2158@tik.uni-stuttgart.de> <20210311074636.GA28705@tik.uni-stuttgart.de> <20210708221731.GB8249@tik.uni-stuttgart.de> <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net> <20210709065320.GC8249@tik.uni-stuttgart.de>
Subject: Re: cannot use btrfs for nfs server
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everyone, 

---- From: Ulli Horlacher <framstag@rus.uni-stuttgart.de> -- Sent: 2021-07-09 - 08:53 ----

> On Fri 2021-07-09 (01:05), Graham Cobb wrote:
>> On 08/07/2021 23:17, Ulli Horlacher wrote:
>> 
>> > 
>> > I have waited some time and some Ubuntu updates, but the bug is still there:
>> 
>> Yes: find and du get confused about seeing inode numbers reused in what
>> they think is a single filesystem.
> 
> A lot of tools aren't working correctly any more, even ls:
> 
> root@tsmsrvj:~# ls -R /nfs/localhost/fex | wc 
> ls: /nfs/localhost/fex/spool: not listing already-listed directory
> 
> In consequence many cronjobs and montoring tools will fail :-(
> 
> 
>> You can eliminate the problems by exporting and mounting single
>> subvolumes only 
> 
> This is not possible at our site, we use rotating snapshots created by a
> cronjob.
> 
> 

Have you tried using the fsid= export option in /etc/exports? 

Example:
/media/nfs/  192.168.0.*(fsid=20000001,rw,sync,no_subtree_check,no_root_squash)

We're using this with Btrfs subvols without issues. We use NFSv4 so I do not know how this works with NFSv3. 

Example:
## On the Ubuntu NFS server:
# btrfs sub list -o .
ID 5384 gen 345641 top level 258 path volume/nfs_ssd/132bbc3e-aed1-15a5-f30d-9515e490e62c/subvol1
ID 5385 gen 345640 top level 258 path volume/nfs_ssd/132bbc3e-aed1-15a5-f30d-9515e490e62c/subvol2

## On the NFS client:
[09:20 srv01 132bbc3e-aed1-15a5-f30d-9515e490e62c]# ll
total 0
drwxr-xr-x 1 root root 6 Jul  9 09:17 subvol1
drwxr-xr-x 1 root root 0 Jul  9 09:17 subvol2
[09:20 srv01 132bbc3e-aed1-15a5-f30d-9515e490e62c]# touch subvol1/foo
[09:20 srv01 132bbc3e-aed1-15a5-f30d-9515e490e62c]# touch subvol2/bar
[09:20 srv01 132bbc3e-aed1-15a5-f30d-9515e490e62c]# touch foobar
[09:20 srv01 132bbc3e-aed1-15a5-f30d-9515e490e62c]# ll -R
.:
total 0
-rw-r--r-- 1 root root  0 Jul  9 09:20 foobar
drwxr-xr-x 1 root root 12 Jul  9 09:20 subvol1
drwxr-xr-x 1 root root  6 Jul  9 09:20 subvol2

./subvol1:
total 0
-rw-r--r-- 1 root root 0 Jul  9 09:17 bar
-rw-r--r-- 1 root root 0 Jul  9 09:20 foo

./subvol2:
total 0
-rw-r--r-- 1 root root 0 Jul  9 09:20 bar



