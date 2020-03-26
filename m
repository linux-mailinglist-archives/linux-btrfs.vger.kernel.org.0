Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6E7194660
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 19:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgCZSQ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 14:16:26 -0400
Received: from mail.itouring.de ([188.40.134.68]:52688 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbgCZSQZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 14:16:25 -0400
Received: from tux.applied-asynchrony.com (p5B07E2B3.dip0.t-ipconnect.de [91.7.226.179])
        by mail.itouring.de (Postfix) with ESMTPSA id 9FDDD416B3B8
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 19:16:24 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 52BC3F01604
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 19:16:24 +0100 (CET)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: Q: what exactly does SSD mode still do?
Organization: Applied Asynchrony, Inc.
Message-ID: <8dcb2f1b-7cb4-cfd4-04ba-7fe4f3c3940b@applied-asynchrony.com>
Date:   Thu, 26 Mar 2020 19:16:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi,

could someone explain what SSD mode *actually* still does? Not ssd_spread,
that's clear and unrelated. A recent commit removed the thread-offloaded
bio submission (avoiding context switches etc.) - which I thought was the
reason for SSD mode? - and looking through the code I couldn't find any
bits that helped clarify the difference.

Thanks!
Holger
