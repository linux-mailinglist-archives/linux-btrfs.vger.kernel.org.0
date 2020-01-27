Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B02E4149F59
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 08:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgA0Hx7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 02:53:59 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:62842 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgA0Hx7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 02:53:59 -0500
Date:   Mon, 27 Jan 2020 07:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1580111637;
        bh=FkXSK7U6UXjHPe8yAO3rgJzoH/oVb85NbA/ruHNlVz4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=n3G7JAuyeg+ZL0QTZb5AN6uij17HmvX4u9RlCvAvKu6X7+rH4HFu/u9q0mMAJBx8K
         ohraXuJvqt7biK8rNXb2JRGivtqcyb62S83bKbBXgi0iOVPF+X15rEXImO1c5e0c0w
         UDPSJ2KVF54pe23wXccQhpGAbktdaJj/5d1Dm6z8=
To:     Nikolay Borisov <nborisov@suse.com>
From:   Raviu <raviu@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: Raviu <raviu@protonmail.com>
Subject: Re: fstrim segmentation fault and btrfs crash on vanilla 5.4.14
Message-ID: <B5lXpRtqEz0NPuXGaaqp8p0AKY3ndP946GmHLVHkhHDPIntSm5HopHG8RCNWlyx8bw39N0NdjMh0PSMuCqZ6-yts7YUKhASbJ2oLx3z06aM=@protonmail.com>
In-Reply-To: <1DC5LVxi3doXrpiHkvBd4EwjgymRJuf8Znu4UCC-Ut0mOy9f-QYOyvQT3hf-QJX3Hk8hm_UhBGk_3rLcGYs_b6NdpNHDuJU-qog6PFxjEDE=@protonmail.com>
References: <izW2WNyvy1dEDweBICizKnd2KDwDiDyY2EYQr4YCwk7pkuIpthx-JRn65MPBde00ND6V0_Lh8mW0kZwzDiLDv25pUYWxkskWNJnVP0kgdMA=@protonmail.com>
 <7tcxgXvMR83f-yW7IN3dKq8NWJETNoAMGo_0GShBJMjR_p_N4vE3nDMPkECoqBiOFDCEFsBM4IZ08Lkk0yT5-H81FkHAV-xEThPkbey0Z40=@protonmail.com>
 <1a8462a7-c77b-ecc9-681f-3cecb6a51576@suse.com>
 <hNqW0cNKaqya5Nvb99uUaI7KRF7zyl2urKDMfG6CkwEvLdLq6HlWnBLFrgtNCpleC2dfm8HLOHUdlQYPa1zi9zxfBaY1wwXli1mTAM-4qTQ=@protonmail.com>
 <1DC5LVxi3doXrpiHkvBd4EwjgymRJuf8Znu4UCC-Ut0mOy9f-QYOyvQT3hf-QJX3Hk8hm_UhBGk_3rLcGYs_b6NdpNHDuJU-qog6PFxjEDE=@protonmail.com>
Feedback-ID: s2UDJFOuCQB5skd1w8rqWlDOlD5NAbNnTyErhCdMqDC7lQ_PsWqTjpdH2pOmUWgBaEipj53UTbJWo1jzNMb12A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM
        shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Follow-up:
It seems that I could solve my problem. Maybe this can also help you know t=
he root cause and reproduce it some how.
My buggy btrfs was initially on a single partition, I've freed another part=
ition later and added as `btrfs device add` as the free partition was to th=
e left of the original one so a resize was not possible.
Originally I'd metadata as dup and data as single.
Even after adding the new device it remained like that for few days, yester=
day, I noticed it reported both dup and RAID1 of metadata which was weird. =
It did some sort of metadata balance on its own when it got a new partition=
, actually I didn't run such balance command before as both partition are o=
n the same disk, so thought that raid-1 is useless.
So I've taken a backup, then run `btrfs balance start -mconvert=3Draid1 /ho=
me/` .. So only raid1 is reported now on `btrfs filesystem df` and `btrfs f=
ilesystem usage`. I then run fstrim and it worked fine.


