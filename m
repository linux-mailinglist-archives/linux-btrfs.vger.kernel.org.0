Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1B54407FB
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Oct 2021 10:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhJ3ISu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 30 Oct 2021 04:18:50 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:40562 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhJ3ISu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Oct 2021 04:18:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 3EC9F3F3F4
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Oct 2021 10:16:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9ECFMZS9RxOj for <linux-btrfs@vger.kernel.org>;
        Sat, 30 Oct 2021 10:16:16 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id E31E03F3E6
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Oct 2021 10:16:16 +0200 (CEST)
Received: from [192.168.0.126] (port=45522)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mgjXD-000G9Z-VL
        for linux-btrfs@vger.kernel.org; Sat, 30 Oct 2021 10:16:15 +0200
Date:   Sat, 30 Oct 2021 10:16:14 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     linux-btrfs@vger.kernel.org
Message-ID: <38e1b33.df69821a.17cd0454b6b@tnonline.net>
In-Reply-To: <20211029155346.19985-1-dsterba@suse.com>
References: <20211029155346.19985-1-dsterba@suse.com>
Subject: Re: Btrfs progs pre-release 5.15-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: David Sterba <dsterba@suse.com> -- Sent: 2021-10-29 - 17:53 ----

> Hi,
> 
> this is a pre-release of btrfs-progs, 5.15-rc1 (version tag is v5.14.91).
> 
> The proper release is scheduled to next Friday, +7 days (2021-10-05).
> 
> The noticeable changes are in the mkfs defaults:
> 
>   * no-holes
>   * free-space-tree
>   * DUP for metadata unconditionally
> 
> This is based on numerous user requests and discussions, and after long period
> where the respective features have been in released kernels.
> 
> Other changes:
> 
> * libbtrfs - minimize its impact on the other code, refactor and separate
>   implementation where needed, cleanup afterwards, reduced header exports
> 
> * documentation - introduce sphinx build and RST versions of manual pages, will
>   become the new format and replace asciidoc
>   (Preview at https://deleteme12545.readthedocs.io/en/latest/index.html)
> 
> Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
> 

Thank you for the release. It compiles and runs fine on my Gentoo 5.14.14 amd64 system. 

Here is the output and the corresponding dmesg bits. One note is the mention of "cleaning free space cache v1“ during mount. Is this intended? 


# mkfs.btrfs /dev/loop0p1 -fv --csum xxhash btrfs-progs v5.14.91 See http://btrfs.wiki.kernel.org for more information. Performing full device TRIM /dev/loop0p1 (100.00GiB) ... NOTE: several default settings have changed in version 5.15, please make sure this does not affect your deployments: - DUP for metadata (-m dup) - enabled no-holes (-O no-holes) - enabled free-space-tree (-R free-space-tree) Label: (null) UUID: ee548f53-5639-4d90-8c23-810b4b1f0a69 Node size: 16384 Sector size: 4096 Filesystem size: 100.00GiB Block group profiles: Data: single 8.00MiB Metadata: dup 1.00GiB System: dup 8.00MiB SSD detected: yes Zoned device: no Incompat features: extref, skinny-metadata, no-holes Runtime features: free-space-tree Checksum: xxhash64 Number of devices: 1 Devices: ID SIZE PATH 1 100.00GiB /dev/loop0p1 # dmesg ... [224380.260049] BTRFS: device fsid ee548f53-5639-4d90-8c23-810b4b1f0a69 devid 1 transid 6 /dev/loop0p1 scanned by mkfs.btrfs (6730) [224534.460239] BTRFS info (device loop0p1): flagging fs with big metadata feature [224534.460246] BTRFS info (device loop0p1): using free space tree [224534.460249] BTRFS info (device loop0p1): has skinny extents [224534.462430] BTRFS info (device loop0p1): enabling ssd optimizations [224534.462540] BTRFS info (device loop0p1): cleaning free space cache v1 [224534.591074] BTRFS info (device loop0p1): checking UUID tree


