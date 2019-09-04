Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA91BA877A
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 21:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfIDNym (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 09:54:42 -0400
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:37422 "EHLO
        3.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbfIDNym (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 09:54:42 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Sep 2019 09:54:41 EDT
Received: from player699.ha.ovh.net (unknown [10.108.57.44])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 4C5541183C0
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2019 14:35:43 +0200 (CEST)
Received: from grubelek.pl (31-178-94-81.dynamic.chello.pl [31.178.94.81])
        (Authenticated sender: szarpaj@grubelek.pl)
        by player699.ha.ovh.net (Postfix) with ESMTPSA id 4DF5596DB8E3;
        Wed,  4 Sep 2019 12:35:40 +0000 (UTC)
Received: by teh mailsystemz
        id 15ED3170D788; Wed,  4 Sep 2019 14:35:39 +0200 (CEST)
Date:   Wed, 4 Sep 2019 14:35:39 +0200
From:   Piotr Szymaniak <szarpaj@grubelek.pl>
To:     Edmund Urbani <edmund.urbani@liland.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Unmountable degraded BTRFS RAID6 filesystem
Message-ID: <20190904123539.GG31890@pontus.sran>
References: <f58d5ec1-4b38-ad8b-068d-d3bb1f616ec2@liland.com>
 <CAJCQCtTqetLF1sMmgoPyN=2FOHu+MSSW-MGsN6NairLPdNmK+g@mail.gmail.com>
 <c57b8314-4914-628c-f62b-c5291a6be53c@liland.com>
 <CAJCQCtT5WecG26YXE6EVwhv52xSY_sm8GqgLDoQbZBUom4Pw7Q@mail.gmail.com>
 <3d683d4c-375a-e5ed-ebd7-188c2b10f925@liland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d683d4c-375a-e5ed-ebd7-188c2b10f925@liland.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Ovh-Tracer-Id: 12654833481584547465
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejhedgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 04, 2019 at 08:18:09AM +0200, Edmund Urbani wrote:
> *snip*
> The timeout under /sys is 30 for all of them.
> 
> I am not sure what you mean by SCT ERC value and where to look for that.
> Here's all the info smartctl gives me about sda:

Try:
smartctl -l scterc /dev/ice

ie. one of my drives (also WD Red) outputs:
$ smartctl -l scterc /dev/sdb
smartctl 7.0 2018-12-30 r4883 [x86_64-linux-4.19.62] (local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.org

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)

SCT ERC value should be lower then the value in /sys.


Best regards,
Piotr Szymaniak.
