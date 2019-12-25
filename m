Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6627512A909
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Dec 2019 20:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfLYT0a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Dec 2019 14:26:30 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44511 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfLYT0a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Dec 2019 14:26:30 -0500
Received: by mail-ot1-f51.google.com with SMTP id h9so27455458otj.11
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Dec 2019 11:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=65q5dCLAg9qT/opfrDDuZQKilanMugOPrsqeeUVJ+vM=;
        b=oH1Q41sk0wif/dUYnVTMPj4EmeFNKyntGlQ25w0hSkRJHP42EPkxpp6GbyWPEthhoF
         LbKlvedgTzwVj6tUlu6xW6iM6tQ8fCzvjs223YUyIM0Mt7smLN/2W13Vj7Hba3roVJsM
         nw4WdFX/WWeUnh9OatG0Twg9pYiClNnr/wknPHKLNgpSNxndK1zsYbwoAnLGR4IJrqWn
         w3DpiIJcz4QxIO5jUZ9Fn1DNJfLWuAzwltTOlF+09PWp65blfjutIEKWeUb3aWjdsqIK
         uvdViTkeCUTruBZEp5wCp7QmDfolqFdqeF8Npyy5HmK5gNKxTaASLyAngtj6fBafSdif
         Kr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=65q5dCLAg9qT/opfrDDuZQKilanMugOPrsqeeUVJ+vM=;
        b=eVMqfETONejJiknUF//oWK9xAZpfAprDVWZ5bJAbR7S0Wp1LkL/Qmtzblnd9+8lIN1
         D48lTgy4Rz56/H6rmXpXtQvTcAQioTBREJZzQjHE1XOnI0bUErPdk3vUOjD1nPABP21r
         x4M7zU6E8RCzfixND1fvEppCSAOK1/73wiSZMRprR3IroNAG3aMiZFGPWpZxqVD3c8v+
         1iHNOofxExo97era4c0qc0lONVxGhjOJLosfjvCPsHADVy6oGSDPdMAm2YLBwyToB5bm
         3/3qcFrBhyg5yvOChugjeWosflUB2DMwuwEVopCS6SzSmoGWtjPRrKL2EnFtMxl7kNOa
         LMtQ==
X-Gm-Message-State: APjAAAXn4TqUWVP3zkXS3woA/bMsYMRyGrS7K2NeKYdWpBKHY7ICI6UC
        cys2iE5bTNcZJ3+k9CJuWFnoxoTptWQArKUrzRhT1FR65Ps=
X-Google-Smtp-Source: APXvYqxIbCecN6lGBVImjENy0Q5IALXyVdcYJOuLHtKzzSQQ9w0eypqQrsADVCb3XCtiqGQfY2rcn+vBQIcqV62Fr5Y=
X-Received: by 2002:a9d:7342:: with SMTP id l2mr46628043otk.98.1577301989631;
 Wed, 25 Dec 2019 11:26:29 -0800 (PST)
MIME-Version: 1.0
From:   Martin <mbakiev@gmail.com>
Date:   Wed, 25 Dec 2019 14:25:53 -0500
Message-ID: <CAHs_hg00v9zmMAXp7E=7Xe_ZD5kgB2tVBOFCt5UQuJRp+yESAg@mail.gmail.com>
Subject: Deleting a failing drive from RAID6 fails
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a drive that started failing (uncorrectable errors & lots of
relocated sectors) in a RAID6 (12 device/70TB total with 30TB of
data), btrfs scrub started showing corrected errors as well (seemingly
no big deal since its RAID6). I decided to remove the drive from the
array with:
    btrfs device delete /dev/sdg /mount_point

After about 20 hours and having rebalanced 90% of the data off the
drive, the operation failed with an I/O error. dmesg was showing csum
errors:
    BTRFS warning (device sdf): csum failed root -9 ino 2526 off
10673848320 csum 0x8941f998 expected csum 0x253c8e4b mirror 2
    BTRFS warning (device sdf): csum failed root -9 ino 2526 off
10673852416 csum 0x8941f998 expected csum 0x8a9a53fe mirror 2
    . . .

I pulled the drive out of the system and attempted the device deletion
again, but getting the same error.

Looking back through the logs to the previous scrubs, it showed the
file paths where errors were detected, so I deleted those files, and
tried removing the failing drive again. It moved along some more. Now
its down to only 13GiB of data remaining on the missing drive. Is
there any way to track the above errors to specific files so I can
delete them and finish the removal. Is there is a better way to finish
the device deletion?

Scrubbing with the device missing just racks up uncorrectable errors
right off the bat, so it seemingly doesn't like missing a device - I
assume it's not actually doing anything useful, right?

I'm currently traveling and away from the system physically. Is there
any way to complete the device removal without reconnecting the
failing drive? Otherwise, I'll have a replacement drive in a couple of
weeks when I'm back, and can try anything involving reconnecting the
drive.

Thanks,
Martin
