Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EFE506CAF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 14:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350261AbiDSMpW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 08:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbiDSMpU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 08:45:20 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00778369F4
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 05:42:37 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1ngnBh-0007zy-OP; Tue, 19 Apr 2022 13:42:33 +0100
Date:   Tue, 19 Apr 2022 13:42:33 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Alex Powell <alexj.powellalt@googlemail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: space still allocated post deletion
Message-ID: <20220419124233.GA15632@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Alex Powell <alexj.powellalt@googlemail.com>,
        linux-btrfs@vger.kernel.org
References: <CAKGv6Cq+uwBMgo6th6E16=om8321wTO3fZPXF151VLSYiexFUg@mail.gmail.com>
 <6672365e-c3d2-1a4c-7eb6-957f7a692d3a@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6672365e-c3d2-1a4c-7eb6-957f7a692d3a@cobb.uk.net>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 19, 2022 at 12:21:31PM +0100, Graham Cobb wrote:
> On 19/04/2022 11:41, Alex Powell wrote:
> > Hi team,
> > I have deleted hundreds of GB of files however space still remains the
> > same, even after a full balance and a dusage=0 balance. The location I
> > am deleting from is usually a mount point but I found some files had
> > saved there while the array was unmounted, which I then removed.
> 
> Most likely you have files in subvolumes which are not currently mounted
> anywhere. You need to mount the root subvolume of the filesystem to see
> all the files. Many distros default to putting the system root into a
> non-root subvolume.
> 
> I think you can see them all if you use:
> 
> btrfs subv list -a /
> 
> To access them...
> 
> mkdir /mnt/1
> mount -o subvolid=5 /dev/sdh2 /mnt/1

   As well as the above, the deleted files may also exist in
snapshots, in which case the space is still needed to store the
snapshot copy of it, and won't be released until all of those
snapshots have been removed as well (this may simply be a case of
waiting for the snapshots to time-out through your normal cleanup
schedule).

   If the things you deleted were themselves subvolumes, then it's
possible that there was an open file on the subvol (or that it was
monted elsewhere), in which case it won't be cleaned up until the open
file/mount is closed. You can check that with "btrfs sub list -d", but
I don't think that's likely to be the case here.

   Hugo.

> Graham
> 
> > 
> > root@bean:/home/bean# du -h --max-depth=1 /mnt/data/triage
> > 6.4G /mnt/data/triage/complete
> > 189G /mnt/data/triage/incomplete
> > 195G /mnt/data/triage
> > 
> > root@bean:/home/bean# rm -rf /mnt/data/triage/complete/*
> > root@bean:/home/bean# rm -rf /mnt/data/triage/incomplete/*
> > root@bean:/home/bean# du -h --max-depth=1 /mnt/data/triage
> > 0 /mnt/data/triage/complete
> > 0 /mnt/data/triage/incomplete
> > 0 /mnt/data/triage
> > 
> > root@bean:/home/bean# btrfs filesystem show
> > Label: none  uuid: 24933208-0a7a-42ff-90d8-f0fc2028dec9
> > Total devices 1 FS bytes used 209.03GiB
> > devid    1 size 223.07GiB used 211.03GiB path /dev/sdh2
> > 
> > root@bean:/home/bean# du -h --max-depth=1 /
> > 244M /boot
> > 91M /home
> > 7.5M /etc
> > 0 /media
> > 0 /dev
> > 0 /mnt
> > 0 /opt
> > 0 /proc
> > 2.7G /root
> > 1.6M /run
> > 0 /srv
> > 0 /sys
> > 0 /tmp
> > 3.6G /usr
> > 13G /var
> > 710M /snap
> > 22G /
> > 
> > Linux bean 5.15.0-25-generic #25-Ubuntu SMP Wed Mar 30 15:54:22 UTC
> > 2022 x86_64 x86_64 x86_64 GNU/Linux
> > btrfs-progs v5.16.2
> 

-- 
Hugo Mills             | What's a Nazgûl like you doing in a place like this?
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                                Illiad
