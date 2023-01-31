Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DA6682FC9
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Jan 2023 15:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjAaOxO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Jan 2023 09:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjAaOxF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Jan 2023 09:53:05 -0500
Received: from mail.fsf.org (mail.fsf.org [IPv6:2001:470:142::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E23B35257
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Jan 2023 06:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fsf.org;
        s=mail-fsf-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:references;
         bh=cgVVzeDfBYVDR40Lm61wsumLae6nQ76DsjmnAcbL2cI=; b=eX8CzVZpIfz+XO8Wq12yt5RCO
        YA7EZXhpmmhK0xYsFd2PNUeBS/lnZza1W6T0sPXfmjHDpbfRIM5HDchft63d/IWTUhAaTsooEBNOH
        MXoq365Pk1CTAoivnj+DIpB/gcmrqXzuwsBM3mqjMGGBwpExEqe4bw2eVxb284ZItTtEWciu2hnKb
        uRzBi/KXbzT+x4LMKkFemtTWr59tNvZYkLEYtq0R1TFtT48Hay38KD4+tDXzR2lxNzy3lEJuAAzwm
        7WmtEAVb/VSqCBWUm3xy3mAa7GmpjmN7DDdG7vrEp7bc+iQqvZ3j0aSoQrIEK8lu94vpr0cGdO3Du
        NU0UqdR0A==;
User-agent: mu4e 1.9.0; emacs 29.0.50
From:   Ian Kelling <iank@fsf.org>
To:     Btrfs <linux-btrfs@vger.kernel.org>
Subject: bug: btrfs receive: ERROR: clone: did not find source subvol
Date:   Tue, 31 Jan 2023 09:02:27 -0500
Message-ID: <87mt5y4uyj.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

on sending host:
btrfs send -p /mnt/root/btrbk/q.20230126T000018-0500 /mnt/root/btrbk/q.20230130T200019-0500
on receiving host:
btrfs -v receive '/mnt/root/btrbk/'
...
write p/c/firefox-swf-profile/places.sqlite - offset=0 length=32768
... (642 similar lines writing to places.sqlite)
write path/to/abrowser-profile/places.sqlite - offset=42860544 length=32768
write path/to/abrowser-profile/places.sqlite - offset=42893312 length=49152
write path/to/abrowser-profile/places.sqlite - offset=42942464 length=16384
ERROR: clone: did not find source subvol


On the receiving machine:

# cat /proc/version 
Linux version 6.1.4-060104-generic (kernel@sita) (x86_64-linux-gnu-gcc-12 (Ubuntu 12.2.0-9ubuntu1) 12.2.0, GNU ld (GNU Binutils for Ubuntu) 2.39) #202301071207 SMP PREEMPT_DYNAMIC Sun Jan  8 18:52:10 UTC 2023
 # btrfs --version
btrfs-progs v6.1.2


On the sending machine:

# cat /proc/version
Linux version 6.1.8-gnu (rms@mit-oz) (x86_64-linux-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.40) #1.0 SMP PREEMPT_DYNAMIC Tue Sep 27 12:35:59 EST 1983
# btrfs --version
btrfs-progs v6.1.2

The snapshot was created running those versions.

I take snapshots hourly and send and receive them using btrbk, which is
a perl wrapper. This error has happened around 7 times in the last year
or so, and when I inspected, it was always places.sqlite, which is a 45M
sqlite database of firefox containing browsing history. Note, I use
abrowser, a rebranded firefox in trisquel that fixes some software
freedom issues. The workaround I've found is to delete the parent
snapshot on sending machine. The error exists for any combination of
that parent and a subsequent snapshot.

A few details about the sending machine where the bad snapshot
originated: It is using ECC ram and reported no ECC errors, and no
kernel errors anywhere near the time of the snapshot. The disks are 2
ssds in raid1.

I'm happy to help the btrfs developers debug the issue, running any
commands, running alternate software, etc. Note, I can't share
places.sqlite file as it contains private browsing history.


-- 
Ian Kelling | Senior Systems Administrator, Free Software Foundation
GPG Key: B125 F60B 7B28 7FF6 A2B7  DF8F 170A F0E2 9542 95DF
https://fsf.org | https://gnu.org
