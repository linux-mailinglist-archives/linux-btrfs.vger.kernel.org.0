Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCA5391988
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 16:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhEZOJy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 10:09:54 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:41059 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232948AbhEZOJx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 10:09:53 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 2706510B6;
        Wed, 26 May 2021 10:08:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 26 May 2021 10:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=to:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=q
        8vreKndmYzvQmkdmCKBioC1qWB1DB8pNPoovaGG3HQ=; b=P8easdd6am7f14Zxm
        6VrOfT4EGQIn1aLo3aSr5lShqYrfveQ9M0nfYyuNGhNpL1mED+HBSQWYitqc14AW
        HurkTacMQoSsX8r4Zq1YGnjD4J7rxQEIDp3a9/92F9HgzWKo7em595oLpzgGg+Wr
        PosLmfyV5dmAsPDGAofnvgv0WAZZoWKYZ0Ads2q+xQbEbQ/AQMP5tpV4dZtXaN81
        PPTsD7T8bwsKeCENpwtz9AWIIQG9YUttNHQ6SMdPzXb2OxWABhiwp6RMeYvu+1kD
        G5YLF4r4I1nKBueNwkh8laU42zZe8EudeuRW2TJC97W9+4cPYl/lZzwXa+I7/ye4
        6wOYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=q8vreKndmYzvQmkdmCKBioC1qWB1DB8pNPoovaGG3
        HQ=; b=PLCO6Fd1/+L+10tR1cGVE/ysykcMj5k1JFuU7JzFfFlam3KQI1edEEkk+
        POa4m/eWJterE3+7CnkNMD0+YQ8fpXm+jhYWsLhU2BZ7F10s7f+pBAql+UWgQYK/
        zuerqOMqnnPYsxqsIMbKvnqnaQ6gqk/s8stu1tYBjJTBK5dZmMBa6qhJQ8L8qR8O
        Fdt0s77KkIkmDWKtGYcFWzp+yFK034r0BNH0qlV72FqjoRF2izrIDmWpBWnuKePP
        lanR50mq6kKmwJHyjbsnRclTXxohXMFfv52Fv3KWyREcvv+dmNDPpRK8s6gG5eew
        Pu6LrZ8pRtOqUeQeESbofQFoymLxA==
X-ME-Sender: <xms:VVauYELHiz7WMEiADsHQLVKFoWv7BCqvggEnEVr6mBW7sJR61XBr5A>
    <xme:VVauYEI_V2tu_Re77MY-hoBjWspzXlpVYKxbFE4_SzAAnIQCMA2ad0iiiY9_uIgJE
    -y8wfpcMQedbWF52w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekfedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomheptfgvmhhi
    ucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghnihhtrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeliedvleeghfdvhefgudehfeetheeiteejhfejuedvkedutdeigeejveek
    geehffenucffohhmrghinheptghomhhmrghnugdrmhhvnecukfhppeduledvrddtrddvfe
    elrddufedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:VVauYEuTM5tcoPEE4H_kPpdgJg46mQaNN45QRG2WD9OK45i0zkENVA>
    <xmx:VVauYBaFUoMAAz0Yx4WuiKlahcp-060k_W6drriPn3706G7rJJzbLQ>
    <xmx:VVauYLYyQA7Hsuq3nwmABcc6WVgfrLaXxoSC0hgRHQW-wHmpAMOIEA>
    <xmx:VVauYF1Y15g46ySdC_WPJObxNSFDF66Qdb5xJ8wPjCf4pobD-RutyA>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 26 May 2021 10:08:20 -0400 (EDT)
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de>
From:   Remi Gauvin <remi@georgianit.com>
Subject: Re: how to rollback / to a snapshot ?
Message-ID: <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com>
Date:   Wed, 26 May 2021 10:08:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm going to offer my perspective in the hope that it helps. I would not
be comfortable doing this if I could not get physical access with boot
media in case I make a mistake and need to fix hands on.

On 2021-05-26 9:05 a.m., Lentes, Bernd wrote:

> This is my setup:
> 
> root@pc65472:/boot# mount |grep btrfs
> /dev/mapper/vg1-lv_root on / type btrfs (rw,relatime,ssd,space_cache,subvolid=257,subvol=/@)
> /dev/mapper/vg1-lv_root on /home type btrfs (rw,relatime,ssd,space_cache,subvolid=258,subvol=/@home)
> /dev/sdb1 on /data type btrfs (rw,relatime,space_cache,subvolid=258,subvol=/@data)
> /dev/sdc1 on /local type btrfs (rw,relatime,space_cache,subvolid=5,subvol=/)
> /dev/mapper/vg1-lv_root on /var/lib/docker/btrfs type btrfs (rw,relatime,ssd,space_cache,subvolid=257,subvol=/@/var/lib/docker/btrfs)
> /dev/mapper/vg1-lv_root on /mnt/snap type btrfs (rw,relatime,ssd,space_cache,subvolid=767,subvol=/@apt-snapshot-release-upgrade-bionic-2021-05-21_10:38:10)
> /dev/mapper/vg1-lv_root on /mnt/sub/root-volume type btrfs (rw,relatime,ssd,space_cache,subvolid=5,subvol=/)
> 
> /home, /data and /local are not involved, and /mnt/snap is the snapshot i want to rollback.
> 
> root@pc65472:/boot# btrfs sub list /
> ID 257 gen 44758165 top level 5 path @
> ID 258 gen 44758165 top level 5 path @home
>  ...
> ID 767 gen 44757961 top level 5 path @apt-snapshot-release-upgrade-bionic-2021-05-21_10:38:10
> ID 768 gen 44757961 top level 5 path @apt-snapshot-release-upgrade-bionic-2021-05-21_10:38:13
> ID 769 gen 44757961 top level 5 path @apt-snapshot-release-upgrade-bionic-2021-05-21_10:38:46
> 
> Is it sufficient to change the the default subvolume with btrfs sub set-default to the snapshot and reboot ?

You should probably ignore all the documentation you find on net about
changing your default subvolume.  Those basically come from early
implementations of btrfs before it was common to put root in the '@'
subvolume.

The apt plugin that created those snapshots probably has it's own revert
process that I know nothing about.  So here's how I would do it manually.

Step 1: List the subvolumes that are directly in your @, those will have
to be moved or snapshoted back into the new root.

# btrfs sub list -o /


Hopefully, /@/var/lib/docker/btrfs is the only one, and you can just
move that whole subvolume

# mv /mnt/sub/root-volume/@  /mnt/sub/root-volume/@bad

# btrfs sub snap
/mnt/sub/root-volume/@apt-snapshot-release-upgrade-bionic-2021-05-21_10:38:10
/mnt/sub/root-volume/@

I'm assuming that docker itself has subvolumes, (you truncated the
subvolume list.)  If it does not, you can just snapshot it into the new
@.  If it does have subvolumes, you have to move the whole thing.  Only
do this to a directory/subvolume found with the sub list -o command.


mv /mnt/sub/root-volume/@bad/var/lib/docker/btrfs
/mnt/sub/root-volume/@/var/lib/docker/btrfs

You need to repeat this for any other subvolumes found in the first sub
list command.

Reboot


> Do i need additionally to modify grub and fstab ?
> 

No... once the subvolume you want as your new root is named "@", grub
and fstab will be correct.

> Or just modify grub and fstab, let it point to the snapshot and reboot ?

This path lies madness

> 
> What is with mounting the snapshot and rsync it to the current / ?
> I think that's not possible in a running system which has / mounted.

Seems a very wasteful approach

