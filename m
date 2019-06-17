Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5394800A
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2019 12:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfFQKyM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jun 2019 06:54:12 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:56452 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfFQKyM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jun 2019 06:54:12 -0400
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jun 2019 06:54:12 EDT
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id B7998E80B34;
        Mon, 17 Jun 2019 12:45:40 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 2515D160849; Mon, 17 Jun 2019 12:45:39 +0200 (CEST)
Date:   Mon, 17 Jun 2019 12:45:39 +0200
From:   Lennart Poettering <mzerqung@0pointer.de>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     systemd Mailing List <systemd-devel@lists.freedesktop.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [systemd-devel] 5.2rc2, circular lock warning systemd-journal
 and btrfs_page_mkwrite
Message-ID: <20190617104539.GF24827@gardel-login>
References: <CAJCQCtS4PRWU=QUY87FRd4uGE_wA+KSSLW+2e_9XDs5m+RYzsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtS4PRWU=QUY87FRd4uGE_wA+KSSLW+2e_9XDs5m+RYzsQ@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Di, 04.06.19 12:24, Chris Murphy (lists@colorremedies.com) wrote:

> This is on Fedora Rawhide
> systemd-242-3.git7a6d834.fc31.x86_64
> kernel 5.2.0-0.rc2.git1.2.fc31.x86_64

Please report to the kernel btrfs maintainers, this is not a userspace
problem.

Thanks,

Lennart

--
Lennart Poettering, Berlin
