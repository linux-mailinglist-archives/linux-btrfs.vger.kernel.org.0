Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E01A0F95
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2019 04:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfH2CbP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 22:31:15 -0400
Received: from fenrir.routify.me ([155.94.238.126]:41166 "EHLO
        fenrir.routify.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfH2CbP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 22:31:15 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Aug 2019 22:31:15 EDT
Received: from [192.0.0.4] (unknown [172.58.37.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by fenrir.routify.me (Postfix) with ESMTPSA id 2787640225;
        Thu, 29 Aug 2019 02:21:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 fenrir.routify.me 2787640225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seangreenslade.com;
        s=fenrir-outgoing; t=1567045275;
        bh=jNmJ4pdjL+FfAl+sEeN5S4a9EPnSWz2Cf3JHex01zTA=;
        h=Date:In-Reply-To:References:Subject:To:From:From;
        b=YpNW9IYRoIjS9xoKrmV+ImSqPIMcSdWfKzxdU3R+FIcc0ZGxiBvK0J4LQciI+doIK
         Fk7QK5uGXxDN1/jMPG5Jd0vDv/xsKGqlX/kBnR+3zOh9A+hCe9awJ/wZFytyxgh/tk
         NbN42R1Gr40fWdZ6+DRYQyPzwgd0mFT2wg249vhI=
Date:   Wed, 28 Aug 2019 19:21:14 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <0b7bfde0-0711-cee3-1ed8-a37b1a62bf5e@megavolts.ch>
References: <0b7bfde0-0711-cee3-1ed8-a37b1a62bf5e@megavolts.ch>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Spare Volume Features
To:     Marc Oggier <marc.oggier@megavolts.ch>, linux-btrfs@vger.kernel.org
From:   Sean Greenslade <sean@seangreenslade.com>
Message-ID: <CD4A10E4-5342-4F72-862A-3A2C3877EC36@seangreenslade.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On August 28, 2019 5:51:02 PM PDT, Marc Oggier <marc=2Eoggier@megavolts=2Ec=
h> wrote:
>Hi All,
>
>I am currently buidling a small data server for an experiment=2E
>
>I was wondering if the features of the spare volume introduced a couple
>
>of years ago (ttps://patchwork=2Ekernel=2Eorg/patch/8687721/) would be=20
>release soon=2E I think this would be awesome to have a drive installed,=
=20
>that can be used as a spare if one drive of an array died to avoid
>downtime=2E
>
>Does anyone have news about it, and when it will be officially in the=20
>kernel/btrfs-progs ?
>
>Marc
>
>P=2ES=2E It took me a long time to switch to btrfs=2E I did it less than =
a=20
>year ago, and I love it=2E=C2=A0 Keep the great job going, y'all

I've been thinking about this issue myself, and I have an (untested) idea =
for how to accomplish something similar=2E My file server has three disks i=
n a btrfs raid1=2E I added a fourth disk to the array as just a normal, par=
ticipating disk=2E I keep an eye on the usage to make sure that I never exc=
eed 3 disk's worth of usage=2E That way, if one disk dies, there are still =
enough disks to mount RW (though I may still need to do an explicit degrade=
d mount, not sure)=2E In that scenario, I can just trigger an online full b=
alance to rebuild the missing raid copies on the remaining disks=2E In theo=
ry, minimal to no downtime=2E

I'm curious if anyone can see any problems with this idea=2E I've never te=
sted it, and my offsite backups are thorough enough to survive downtime any=
way=2E

--Sean

