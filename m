Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7852629D3D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiKOPV1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiKOPVW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:21:22 -0500
Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC74C29C8A
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:21:21 -0800 (PST)
Received: from selket.spencercollyer.plus.com ([80.189.102.133])
        by smtp with ESMTP
        id uxkVo5sGGZhEluxkWocnee; Tue, 15 Nov 2022 15:21:20
 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1668525680; bh=mHp0SmaMlC6sdMtaHCymHkP9eZj6h3DUZSltqqNzIiI=;
        h=Date:From:To:Subject:In-Reply-To:References;
        b=V2nMoDIi+I2GqHyDiReHU/1ofdkI2CLRxuI/Yd6W6g/bMAn/aKmqemOglidqw0c3J
         bMUqM5K2qzfABdzVvFs26KLYdLvYeZSb6llQ/EZwTD3cUGOS2rJBvU+hhmXfXGmoWH
         RGNc2JA2NTng+LOGlVeEGaeyiKoiwsbB/wEFDp4k92C1ThDGcTsvuk+4yieIhCt+fz
         M9lM/VLWdAN5qw07NtecDvvlWWJN6bY3xCCb41GD+JSzIegsGOLuocgiTBY4xs8gLb
         3a0CLgsymet/AcoEcF8xyoR5GuHNqjmBbM+8zIvJdZnI1vJ7+5/Ld8IdoMcW1jrZ+W
         Q7GuhIT4z8gsw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=XcOaca15 c=1 sm=1 tr=0 ts=6373ae70
 a=t3eprasJVEmiovQRZ0k/8A==:117 a=t3eprasJVEmiovQRZ0k/8A==:17
 a=kj9zAlcOel0A:10 a=9xFQ1JgjjksA:10 a=KhWKbWAMehFtYlDSfboA:9 a=CjuIK1q_8ugA:10
Received: from selket (localhost.localdomain [127.0.0.1])
        by selket.spencercollyer.plus.com (Postfix) with ESMTP id 11C9780055
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 15:21:19 +0000 (GMT)
Date:   Tue, 15 Nov 2022 15:21:18 +0000
From:   Spencer Collyer <spencer@spencercollyer.plus.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Change BTRFS filesystem back to R/W from R/O
Message-ID: <20221115152118.76f4d011@selket>
In-Reply-To: <20221115140847.12fa1902@selket>
References: <20221115122702.4ca83887@selket>
        <7be0584d-5596-189a-353a-63e4b21c3b5e@gmx.com>
        <20221115140847.12fa1902@selket>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCX8laU6RUewyyFwnquFbvgL4FRWBs0Bo3/HzjvY8Ev5K7zIZ+Zkwew4gHwmtNW7B1ZJMf2hEJhi3wI7dgZ4+tAeGu70VLUJr6BPfR1zN1/nMzcFF0x8
 MXwOYJ6CLKMOgBpN//e3mujsxxjRaoNMU7qZiBrST0lx23po9aRI1LgGvp7szio6RdIPwYjo4qb2/0zVgDyiGUy82IdwKAwa379lkodwSiM+CPmvnfPypHDt
 8HWZMfYMB0YCLoOUJxfjSg==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 15 Nov 2022 14:08:47 +0000, Spencer Collyer wrote:
> 

In the end I just did a umount / mount and it came back fine. So now I'm busy moving stuff off the filesystem to backup :)

Spencer
