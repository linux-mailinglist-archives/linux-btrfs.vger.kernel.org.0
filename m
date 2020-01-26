Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B92149BB4
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2020 16:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAZPyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 10:54:33 -0500
Received: from mail-40132.protonmail.ch ([185.70.40.132]:52123 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgAZPyd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 10:54:33 -0500
Date:   Sun, 26 Jan 2020 15:54:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1580054069;
        bh=inXop1fl/F/hqwEewAwMrjyo9gI6bLDR7R4wNEnL/OU=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=Z/m7pFi6S/6SFCh44y/fjbYz6keTfGbFQTZU5uNUjnWY1Vf6HVWMulABQXGM/+mcv
         tg/R/Qsolg+LRv6wpvkd2vogo6Jh+nKy6MnBJX0Uo/Wq4IFxwt1JkfyQNYpfWrkSqJ
         ozSz6KKOb/EqZ7DA1iKPv8FFZ9HlzXNQ4R66LxOs=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Raviu <raviu@protonmail.com>
Reply-To: Raviu <raviu@protonmail.com>
Subject: fstrim segmentation fault and btrfs crash on vanilla 5.4.14
Message-ID: <izW2WNyvy1dEDweBICizKnd2KDwDiDyY2EYQr4YCwk7pkuIpthx-JRn65MPBde00ND6V0_Lh8mW0kZwzDiLDv25pUYWxkskWNJnVP0kgdMA=@protonmail.com>
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

Hi,
I've two btrfs filesystems on the same nvme disk / and /home.
I'm running fstrim -va as cronjob daily.
Today, once fstrim run, apps writing to /home got frozen. Reviewing dmesg s=
how a bug message related to fstrim and btrfs.
Rebooting the system- actually forcibly as it couldn't umount /home - and r=
unning fstrim manualy on each filesystem; on / it worked fine, on /home I g=
ot the same error.
Here are the dmesg errors:

http://cwillu.com:8080/38.132.118.66/1

Here is the output of btrfs check --readonly with home unmounted:

http://cwillu.com:8080/38.132.118.66/2

I've run scrub whith home mounted it said, `Error summary:    no errors fou=
nd`


The fstrim kernel error is reproducible on my machine, it occurs every time=
 I run it on my home. So I can test a fix, just hope it doesn't cause data =
loss.
