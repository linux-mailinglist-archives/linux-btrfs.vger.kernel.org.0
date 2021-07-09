Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06123C1FFB
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 09:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhGIH1R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 03:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhGIH1Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 03:27:16 -0400
X-Greylist: delayed 208 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Jul 2021 00:24:33 PDT
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5604AC0613DD
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 00:24:33 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1m1ks2-0004SG-Pc; Fri, 09 Jul 2021 08:24:22 +0100
Date:   Fri, 9 Jul 2021 08:24:22 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Forza <forza@tnonline.net>
Cc:     Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: cannot use btrfs for nfs server
Message-ID: <20210709072422.GF11526@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Forza <forza@tnonline.net>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
 <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de>
 <475ccf1.ca37f515.17a8a262a72@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <475ccf1.ca37f515.17a8a262a72@tnonline.net>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

   I'm using it on NFSv3 and it works fine for me.

   Hugo.

On Fri, Jul 09, 2021 at 09:23:14AM +0200, Forza wrote:
> Hello everyone, 
> 
> ---- From: Ulli Horlacher <framstag@rus.uni-stuttgart.de> -- Sent: 2021-07-09 - 08:53 ----
> 
> > On Fri 2021-07-09 (01:05), Graham Cobb wrote:
> >> On 08/07/2021 23:17, Ulli Horlacher wrote:
> >> 
> >> > 
> >> > I have waited some time and some Ubuntu updates, but the bug is still there:
> >> 
> >> Yes: find and du get confused about seeing inode numbers reused in what
> >> they think is a single filesystem.
> > 
> > A lot of tools aren't working correctly any more, even ls:
> > 
> > root@tsmsrvj:~# ls -R /nfs/localhost/fex | wc 
> > ls: /nfs/localhost/fex/spool: not listing already-listed directory
> > 
> > In consequence many cronjobs and montoring tools will fail :-(
> > 
> > 
> >> You can eliminate the problems by exporting and mounting single
> >> subvolumes only 
> > 
> > This is not possible at our site, we use rotating snapshots created by a
> > cronjob.
> > 
> > 
> 
> Have you tried using the fsid= export option in /etc/exports? 
> 
> Example:
> /media/nfs/  192.168.0.*(fsid=20000001,rw,sync,no_subtree_check,no_root_squash)
> 
> We're using this with Btrfs subvols without issues. We use NFSv4 so I do not know how this works with NFSv3. 
> 
> Example:
> ## On the Ubuntu NFS server:
> # btrfs sub list -o .
> ID 5384 gen 345641 top level 258 path volume/nfs_ssd/132bbc3e-aed1-15a5-f30d-9515e490e62c/subvol1
> ID 5385 gen 345640 top level 258 path volume/nfs_ssd/132bbc3e-aed1-15a5-f30d-9515e490e62c/subvol2
> 
> ## On the NFS client:
> [09:20 srv01 132bbc3e-aed1-15a5-f30d-9515e490e62c]# ll
> total 0
> drwxr-xr-x 1 root root 6 Jul  9 09:17 subvol1
> drwxr-xr-x 1 root root 0 Jul  9 09:17 subvol2
> [09:20 srv01 132bbc3e-aed1-15a5-f30d-9515e490e62c]# touch subvol1/foo
> [09:20 srv01 132bbc3e-aed1-15a5-f30d-9515e490e62c]# touch subvol2/bar
> [09:20 srv01 132bbc3e-aed1-15a5-f30d-9515e490e62c]# touch foobar
> [09:20 srv01 132bbc3e-aed1-15a5-f30d-9515e490e62c]# ll -R
> .:
> total 0
> -rw-r--r-- 1 root root  0 Jul  9 09:20 foobar
> drwxr-xr-x 1 root root 12 Jul  9 09:20 subvol1
> drwxr-xr-x 1 root root  6 Jul  9 09:20 subvol2
> 
> ./subvol1:
> total 0
> -rw-r--r-- 1 root root 0 Jul  9 09:17 bar
> -rw-r--r-- 1 root root 0 Jul  9 09:20 foo
> 
> ./subvol2:
> total 0
> -rw-r--r-- 1 root root 0 Jul  9 09:20 bar
> 
> 
> 

-- 
Hugo Mills             | Modern medicine does not treat causes: headaches are
hugo@... carfax.org.uk | not caused by a paracetamol deficiency.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
