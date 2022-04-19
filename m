Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1AC506A61
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 13:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbiDSL3T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbiDSL3S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 07:29:18 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F176240BD
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 04:26:35 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id AC57C9B86A; Tue, 19 Apr 2022 12:26:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1650367592;
        bh=rgWq6IY+QSGtySEPdAk9in5oSBsuRcHSrSV4vHWwzBs=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=PlKllCeQuxanaw8hZ/T+jsRPUBG124I63vWEva3zLzlQfyAPo2l8v0E+z/jz3awfV
         rMusOQfGZnfA/KTxPHwV2yXlfy+rYey1xCHCiwvn2uqHSQrSNIj3o5TcDA0gnjJ5RT
         huN9dTUgfy+oJvCURApVwQ6JJ7D/SfaivrIbTixYEOVuLsEa2elK/2dFjUaA1Hc0VL
         dQIw7Z1YKmbX/oewgs1OOlPMgBpalqDoC3zkYU1q4SscUC2gjZyZDL8/SxRmfpAKuV
         kBmM2omvWYXPFr18eJvzTbfPgS+RZqUY3yWMlLhf8WLVpB8ng7EunDFCdo3t/TFJg/
         rNgW0HjysCMAw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id E4E469B6D3;
        Tue, 19 Apr 2022 12:21:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1650367291;
        bh=rgWq6IY+QSGtySEPdAk9in5oSBsuRcHSrSV4vHWwzBs=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=qenWO4lSvf27SZVbu5j3+jLBYWT8QE89DZS2qzvZnT4cUVmYUOsvagWqklGxqXxw2
         zRoFbBA5rv8RyLKicJLc1iA2CtkoG95TSDLlKhpW0WO8Zn4GxhaufCPk1Q/j5S/7z5
         lSmGGB+x124SH3iJu1mFWyCd06w/JHJM0ciKFOgr670dcSWtMN2Td+xy0dQh6H3G/s
         6sGHNamJOk/O5t8RAFV5SA/XWVenLfCzn8ZwPAmkCv3Sr9m8UelApoFFPsXQkJvwnz
         tEdRz57ySV/ECQEK/OreZVXpohpPPJNj+5ZklMux8mdso0kYENESzGGQPixNM8iOtD
         kpPiNbb+W6+vw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id B49921579B9;
        Tue, 19 Apr 2022 12:21:31 +0100 (BST)
Message-ID: <6672365e-c3d2-1a4c-7eb6-957f7a692d3a@cobb.uk.net>
Date:   Tue, 19 Apr 2022 12:21:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: space still allocated post deletion
Content-Language: en-US
To:     Alex Powell <alexj.powellalt@googlemail.com>,
        linux-btrfs@vger.kernel.org
References: <CAKGv6Cq+uwBMgo6th6E16=om8321wTO3fZPXF151VLSYiexFUg@mail.gmail.com>
In-Reply-To: <CAKGv6Cq+uwBMgo6th6E16=om8321wTO3fZPXF151VLSYiexFUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/04/2022 11:41, Alex Powell wrote:
> Hi team,
> I have deleted hundreds of GB of files however space still remains the
> same, even after a full balance and a dusage=0 balance. The location I
> am deleting from is usually a mount point but I found some files had
> saved there while the array was unmounted, which I then removed.

Most likely you have files in subvolumes which are not currently mounted
anywhere. You need to mount the root subvolume of the filesystem to see
all the files. Many distros default to putting the system root into a
non-root subvolume.

I think you can see them all if you use:

btrfs subv list -a /

To access them...

mkdir /mnt/1
mount -o subvolid=5 /dev/sdh2 /mnt/1

Graham

> 
> root@bean:/home/bean# du -h --max-depth=1 /mnt/data/triage
> 6.4G /mnt/data/triage/complete
> 189G /mnt/data/triage/incomplete
> 195G /mnt/data/triage
> 
> root@bean:/home/bean# rm -rf /mnt/data/triage/complete/*
> root@bean:/home/bean# rm -rf /mnt/data/triage/incomplete/*
> root@bean:/home/bean# du -h --max-depth=1 /mnt/data/triage
> 0 /mnt/data/triage/complete
> 0 /mnt/data/triage/incomplete
> 0 /mnt/data/triage
> 
> root@bean:/home/bean# btrfs filesystem show
> Label: none  uuid: 24933208-0a7a-42ff-90d8-f0fc2028dec9
> Total devices 1 FS bytes used 209.03GiB
> devid    1 size 223.07GiB used 211.03GiB path /dev/sdh2
> 
> root@bean:/home/bean# du -h --max-depth=1 /
> 244M /boot
> 91M /home
> 7.5M /etc
> 0 /media
> 0 /dev
> 0 /mnt
> 0 /opt
> 0 /proc
> 2.7G /root
> 1.6M /run
> 0 /srv
> 0 /sys
> 0 /tmp
> 3.6G /usr
> 13G /var
> 710M /snap
> 22G /
> 
> Linux bean 5.15.0-25-generic #25-Ubuntu SMP Wed Mar 30 15:54:22 UTC
> 2022 x86_64 x86_64 x86_64 GNU/Linux
> btrfs-progs v5.16.2

