Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ED54C0FD9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 11:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbiBWKHS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 05:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbiBWKHQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 05:07:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3290A13D2B
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 02:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645610803;
        bh=fu7ybmoqs2pgjLu2FcM7do+ygag/eldOUfYcfncWJec=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=GuP9sMwIRxRILODY8/sUtFfIU0EL+VHtM91hKVSG9RWAitnEdxO2uNhhb+3maVY7F
         0CA9fLHbh63OEpvlyWPyZeglixFN3BS9fTxRhxBoTx94EdW2W6PddpVAjzpJtGi0mB
         gdGI8YyeZLRB2QmI0gwaWRTmzXzhC9aXgGQ1wfCs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M72sP-1nJG2P1cMx-008Wqv; Wed, 23
 Feb 2022 11:06:43 +0100
Message-ID: <4e094239-c987-8b1a-bc56-b4252481fbaa@gmx.com>
Date:   Wed, 23 Feb 2022 18:06:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <c574966a-4b9e-0a50-cb47-e6f904f95eaf@tnonline.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Crash/BUG on during device delete
In-Reply-To: <c574966a-4b9e-0a50-cb47-e6f904f95eaf@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NQgFQ+PK/swwwj6ImxtzQXv5PTPuFfbUQlD7U/AGnI9cnzhuO18
 JxyoZIrdPKasZNTUPIBUmQsLjR7uT4YympxtDOOB9aKEqQbl0RyiIjpj4pcBmw6B1rQsRdJ
 NF77KnJamVYws9BtOvSh8619v1GYqZNTpM2RBf+S2KL7cZlkCq8o2i02C1mniGaLPkM9M0U
 sOpyciBOe6z3mZoBCMjDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4W8LnyBW520=:Iuv83P7R+saPsfG8dPgK02
 fXRy5hNMXCKqB5AkzSPcgzU1mpIWm7m7pmG9iKm0MYByyNAd8D2pHcOmyf3cQEy44uWcROEOP
 AVJJ09+AkRTZlGzl9TaHS5eqW0+aJ9qaA79nBQd6olIn5FKjxLwpdJ9y5TuemqR1ukEuFeqSi
 tiuafOi7gPbUX54FpFySj/OdBqoMkkKrRx1tb0byBwCxFz2dpLSkp90ewXBdgS147QBpAuBZa
 Pr15lu2Ss5XtQuOwxPNZyuLyqA6ClYAF5IodPd7M4AfBDctX1/EUvTM/0Ek9dYZGe3I/MFTrr
 UKE+DyufcqSdRrYHosYLkHj1+bMwlcDOHeitqdof/ycC0ghiSj2QGjdJiAE7qlAa53e3q1eJK
 PX+H308Zdahc9WSpLYlfwKtHliOW4FbuZCyWx8zpA/E5P1znnAc5fPNY9IPdLyl6ZW5PolADU
 fNg0YZXKiCgiTtNLRdjKnU/shUyoB7i6rYrEn3iSApGk9MhAk1faav4l6RcntSZc4jG8+jzrL
 VJkKqwWz/Sbk3eQayfE/R+0hW1j7PqiL2ioGpQ/XVDrqls+e1hBiAH1sb4PfJK+B800TAm3c1
 UWWRdUV62VJIuiK9Re0u+x6uKzk4ysOgn9nZHp59Yr7IQTXhTZ4BRMkNFTY1vEpkOkXKLnoo2
 fqcVvmtvRE7iodPqsu8MIjHOLhLJigKcvWB/+kHlZNr4jhY6uhA54ewzQRyBEht87V6UR4u0/
 YOMqCacem2VhWDbRKF6+arC4SJIac2RqVwQ4i7XsavJSpSsPlHFMwzYdPRJ7CYRn1E/WBLpS9
 2EyafTms2sUJjM6pbu0UxypT7Yy4d/RkdP2S2hhtwNUIqwFFJ8CEbuiQWU4MpI2Y0ONcfClrN
 mIavlu47+sZMSaIPfi+Szt/AS2ws+xnYjbsJJDHYh/Y73n3mgrodu3nPKJjOSidBQbB1+Rg68
 E2RikN9B1FiF+Pb/qJfdGHLQDtMqNOnhvgfQTnm1UK2B0bnvHdaDXa70mczL/maI8AAnJUT7/
 kzDkgnFnqjRagWhQOgxyJIaqAR2oi7PgAa8f91c3sTiI3S5wyInrkarkApGJ3zDTHvnpioL/W
 2eKzbXFAvHRKd8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/23 17:01, Forza wrote:
> Subject:
> Crash/BUG on during device delete
> From:
> Forza <forza@tnonline.net>
> Date:
> 2/23/22, 09:59
> To:
> linux-btrfs@vger.kernel.org
>
> Hi!
>
> I am running a test system and experienced a hard lockup with the
> following message:
>
> [53869.712800] BTRFS critical: panic in extent_io_tree_panic:689:
> locking error: extent tree was modified by another thread while locked
> (errno=3D-17 Object already exists)
> [53869.712825] kernel BUG at fs/btrfs/extent_io.c:689!
>
> Kernel: 5.15.16-0-lts #1-Alpine SMP
> CPU: Xeon(R) E-2126G
> MB: SuperMicro X11SCL-F, 64GB ECC RAM
> Broadcom 9500-8i HBA SAS controller
>
>
> I had 5 SSDs in a RAID1 filesystem and wanted to delete 3 of them.
>
> # btrfs device delete /dev/sdf /dev/sdd /dev/sdd /mnt/nas_ssd
>
> When about 6GB was left on the last device I got a kernel BUG message
> with stack trace. Unfortunately the message was not saved to syslog -
> anything trying to access the system disk froze, even though the "btrfs
> device delete" operation was not performed on the root filesystem. I
> managed to get some screenshots of the trace.
>
> I performed a hard reset and the system booted normally. A scrub showed
> no errors and a new "btrfs device delete /dev/sde /mnt/nas_ssd/"
> finished without errors.
>
> Attached images (wasn't able to send them to the list):
> https://paste.tnonline.net/files/ISD0z6LNqw5D_Screenshot2022-02-23083359=
.png

 From the stack, it looks like related to chunk discard optimization?

Can you provide the code line number of btrfs_alloc_chunk+0x570 and
add_extent_mapping+0x1c6?

Better with the code context.

Thanks,
Qu
>
> https://paste.tnonline.net/files/DR2pgh8bVHCZ_iKVM_capture.jpg
>
> I can do some further tests if needed. otherwise I need to deploy this
> system in about a week.
>
> Thanks.
>
>
