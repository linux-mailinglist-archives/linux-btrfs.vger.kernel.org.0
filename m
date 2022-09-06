Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A525AE44D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiIFJcg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 05:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiIFJcf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 05:32:35 -0400
X-Greylist: delayed 1203 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Sep 2022 02:32:34 PDT
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F726F56A
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 02:32:34 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1oVUcl-0000xO-JQ; Tue, 06 Sep 2022 10:12:03 +0100
Date:   Tue, 6 Sep 2022 10:12:03 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     "Kengo.M" <kengo@kyoto-arc.or.jp>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: delete whole file system
Message-ID: <20220906091203.GY1103@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        "Kengo.M" <kengo@kyoto-arc.or.jp>, linux-btrfs@vger.kernel.org
References: <p0600104adf3cb2552d24@kyoto-arc.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p0600104adf3cb2552d24@kyoto-arc.or.jp>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 06, 2022 at 05:59:21PM +0900, Kengo.M wrote:
> Hi folks
> 
> I made raid5 file system by btrfs like below
> 
> sudo mkfs.btrfs -L raid5.btrfs -d raid5 -m raid1 -f /dev/sda /dev/sdb
> /dev/sdc /dev/sdd /dev/sde
> 
> And mount /mnt/raid5.btrfs
> 
> sudo btrfs filesystem show
> 
> Label: 'raid5.btrf'  uuid: 23a34a45-8f5e-40f5-8cda-xxxxxxxxxxxx
>         Total devices 5 FS bytes used 128.00KiB
>         devid    1 size 2.73TiB used 1.13GiB path /dev/sda
>         devid    2 size 2.73TiB used 1.13GiB path /dev/sdb
>         devid    3 size 2.73TiB used 1.13GiB path /dev/sdc
>         devid    4 size 2.73TiB used 1.13GiB path /dev/sdd
>         devid    5 size 2.73TiB used 1.13GiB path /dev/sde
> 
> 
> So,I want to delete this file system.
> 
> btrfs device delete /dev/sda /mnt/raid5.btrfs
> 
> But delete /dev/sda only.
> 
> Please Someone tell me how to delete whole this file system.
> 
> BRD
> 
> Kengo.m

   "btrfs dev delete" remove a device from the SF leaving the rest of
it intact. To destroy the filesystem completely, wipe the start of the
device on each device. You can do that with any tool that will write
data (dd if=/dev/zero is a popular one here), but there's a generic
tool called wipefs that will do it for any filesystem with minimal
writes to the device and a good level of recoverability if you get it
wrong.

   Hugo.

-- 
Hugo Mills             | Klytus, I'm bored. What plaything can you offer me
hugo@... carfax.org.uk | today?
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                      Ming the Merciless, Flash Gordon
