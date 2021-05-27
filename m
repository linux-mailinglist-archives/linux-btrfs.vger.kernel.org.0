Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABC8393743
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 May 2021 22:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhE0Um4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 May 2021 16:42:56 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:53817 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235263AbhE0Umx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 May 2021 16:42:53 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A8206917;
        Thu, 27 May 2021 16:41:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 27 May 2021 16:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=to:references:from:cc:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=o
        7JYHnU/54wUVQM5YHx0nPdsc/MwxtUi59JZwPLiGOI=; b=w/miUi9k3EiB8WSEh
        ohbRnacpSM0CXOgtJV8WKFdbmeeoVzreUagQ5lunouJ33i30zAwO362xMLPf5EY7
        yjuRosIG+EAMFoAo6KiWzMrDfx1bUxrwbFy/PHOFSydXMb9XyFqoX2gY+OsucQx5
        JZNH82IkOAfUphIQ4HJyJSUVuY/NmXXfd8tr8dBQ3VrnElMpz6xmsKUzo3g6Ow4a
        +NHzFtjc4EUUhZ1gxc6O3dJeZsKK9bc1CneIh24HMOJij5Xelvq5fKwPxvRfKmNu
        k00zg4xf6VpJUhbrJf7QDkrlrcTIQGv8MMdtcWOn4Z1LRwd6q+02WIdyowqikAfW
        G/UAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=o7JYHnU/54wUVQM5YHx0nPdsc/MwxtUi59JZwPLiG
        OI=; b=rXjmv/Gx/wn6omoLjL9x5OfVgUsnRxByCRWp2iMTkwi9V0iw2dmSdWjHF
        aloV/SfeSronxx3EhhF2gO+u05lMC1n8R0hF241/gicN4w7kCYsEezF5fGmzsewt
        FNTB+pzTChRh7yftUFsn/GHCKfDrnntovWBrMCsGyqsqFwLC9GXinVfnodosZR2+
        WBgVLq7q7MCri3PKSDHK0lovXLS0EFLucu4QFYP1e/jkj1MaZmTHgBnkmr5pBGjq
        gvuIypEZmqqcKVau/dlXZowSzJcbkEU8HXl8ruqJAk/J7lejKXoVyEnPNZCQokk6
        A+Hnxo9M07AZWVlBvB9uBzlNePamA==
X-ME-Sender: <xms:5QOwYFaphhVMaLjmRtSuG4W2fZJ995PfrQ0EuOtzPfRR0F_TMIwrsQ>
    <xme:5QOwYMZ5tx1xqN8ma1PBm9l7YHAZ7xIA0SBQNljyWH50qg6XH90fcESkZn1YdBMmb
    8bvpqcd39GPUOkzVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekhedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefvfhfhuffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeftvghm
    ihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecuggftrf
    grthhtvghrnhepheejhfetudduffffgfduheeivedtleekffeludekhfehheffuefggeeg
    keejiedunecukfhppeduledvrddtrddvfeelrddufedtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdr
    tghomh
X-ME-Proxy: <xmx:5QOwYH8Vb2wKwGFF0U_yFEfQefDSf-rMYe1JYT-d6DO8-5gr_9rVyg>
    <xmx:5QOwYDqtkzBHA1FxWcj08Z0ExvreGiwFZVdUUzkWyKSZAg3Rj51UVg>
    <xmx:5QOwYAqiPpZlR0qPNaE-BwQSqARogZUTuaRk2CNaTZ2-56w0x6gsWw>
    <xmx:5gOwYGHfqszgxAsD4lzcfipg0ReaxBxkIPUMoevSNtHvESShW6WDIg>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 27 May 2021 16:41:09 -0400 (EDT)
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de>
 <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com>
 <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de>
 <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com>
 <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de>
From:   Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: how to rollback / to a snapshot ?
Message-ID: <331cf8f6-b048-5b55-475f-5b3c460df400@georgianit.com>
Date:   Thu, 27 May 2021 16:41:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-05-27 3:37 p.m., Lentes, Bernd wrote:

> 
> i followed your guide and tried a reboot remotely.
> PC stuck in BIOS, someone in the office pressed F2, and system booted completely.
> But unfortunately in the bad system and without X:
> 
> root@pc65472:~# mount|grep btrfs
> /dev/mapper/vg1-lv_root on / type btrfs (rw,relatime,ssd,space_cache,subvolid=257,subvol=/@_bad)

This is interesting, because your system is mounting the old subvolume
as root and not the new @.

Check the /etc/fstab, (maybe it would be wise to post it here.).  Maybe
at some point, someone replaced the default 'subvolume=@' with a
subvolid=257?

If that's the case, you should also check the /boot/grub/grub.cfg and
verify that the kernel boot options specify: rootflags=subvol=@

That doesn't really explain why X wouldn't be working.,,, or why
pressing F2 did anything,, (that would indicated the Bios is
experiencing some kind of error?)

