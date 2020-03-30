Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA219768F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Mar 2020 10:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgC3Ifk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Mar 2020 04:35:40 -0400
Received: from mail.virtall.com ([46.4.129.203]:43864 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgC3Ifk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Mar 2020 04:35:40 -0400
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id 4F08541AB137;
        Mon, 30 Mar 2020 08:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1585557338; bh=BtaotMGC5ftKqYkicayOtAVFEV2xiW11H26G0V/jb2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=CX3klUiGUdx1MoNvrn5CvBeue+KsjViQx6wC0pam/h15JTDLu565YtB6TiNBrWLx1
         MPIoNeBzR3UFN8rUQmk+4IchdJutkfqSlk0tQLmfssG4KkyhPl9KWYXGzaHRu06w3D
         2j6M3ao2l9vEz5CtQOxVdtwlZyfi1uqHAOkWKyMpOvJA6xbVoZCfLZeKme8dANNh5b
         SAEpSKQzTOFHFDO5dBNuIcTMskuvQQBTfnmEskcCzX8vCRzfKGvIXQ/SIPQWm39Uot
         f514rueB5Ec0PG8F2+nyv0L6avSmm9RB4MzfCOIRcGW2pkz67n83am5ABKiSYN4OXj
         XsRcyiJEhnsqw==
X-Fuglu-Suspect: eb9396513f6443cba73c5d70abd148bc
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA;
        Mon, 30 Mar 2020 08:35:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Mar 2020 17:35:34 +0900
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Brad Templeton <4brad@templetons.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs-transacti hangs system for several seconds every few
 minutes
In-Reply-To: <b71b10f8-6410-4d32-f89c-9b3f20d9b2f2@templetons.com>
References: <94d08f2b57dd2df746436a0d6bb5f51e@wpkg.org>
 <8703e779-d31b-37c1-672b-dea482e8a491@gmail.com>
 <b71b10f8-6410-4d32-f89c-9b3f20d9b2f2@templetons.com>
Message-ID: <7128ae496fcc9187920cb27de1a80584@wpkg.org>
X-Sender: mangoo@wpkg.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-03-30 17:11, Brad Templeton wrote:
> Also, isn't it 4 debs -- image, modules, headers and architecture
> independent headers?

You don't have to install header debs (unless compiling the modules 
yourself etc.).


Tomasz Chmielewski
https://lxadm.com
