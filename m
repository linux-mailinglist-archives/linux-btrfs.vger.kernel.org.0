Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDFC345069
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Mar 2021 21:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhCVUBU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Mar 2021 16:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhCVUAv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Mar 2021 16:00:51 -0400
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC87C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 13:00:51 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5b07e8e5.dip0.t-ipconnect.de [91.7.232.229])
        by mail.itouring.de (Postfix) with ESMTPSA id 1AF65124FB9
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 21:00:47 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id D24B3F01600
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 21:00:46 +0100 (CET)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: Wrong RAID 5/6 warning when converting single -> dup
Organization: Applied Asynchrony, Inc.
Message-ID: <e8ef1ebf-704b-f494-b67b-87b234e25ee0@applied-asynchrony.com>
Date:   Mon, 22 Mar 2021 21:00:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


So I just did a conversion from single to dup and got the following
unexpected warning:

$btrfs balance start -mconvert=dup /mnt/data
WARNING:

	RAID5/6 support has known problems and is strongly discouraged
	to be used besides testing or evaluation. It is recommended that
	you use one of the other RAID profiles.
	The operation will continue in 10 seconds.
	Use Ctrl-C to stop.
10^C

I let it run and it's dup now, so the conversion itself works correctly.
Looks like this was introduced in [1] but offhand I don't see what's wrong.

-h

[1] https://github.com/kdave/btrfs-progs/commit/1ed5db8db445073eb0d8b807901b64edaac1d8c4
