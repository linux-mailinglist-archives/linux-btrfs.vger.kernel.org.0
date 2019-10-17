Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE69DB752
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 21:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441467AbfJQTR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 15:17:26 -0400
Received: from mail.itouring.de ([188.40.134.68]:47954 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfJQTR0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 15:17:26 -0400
Received: from tux.wizards.de (pD9EBF359.dip0.t-ipconnect.de [217.235.243.89])
        by mail.itouring.de (Postfix) with ESMTPSA id 14667416F642
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2019 21:17:24 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id BB0D4F0160C
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2019 21:17:23 +0200 (CEST)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: Evaluating File System Reliability on Solid State Drives
Organization: Applied Asynchrony, Inc.
Message-ID: <dcba97bb-3ee4-1bae-6bb4-22a114c8e7ee@applied-asynchrony.com>
Date:   Thu, 17 Oct 2019 21:17:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Since resiliency and recovery from corruption continues to be a
hot topic, I figured I'd mention a paper/talk/slides from the
recent Usenix ATC'19 conference:

Evaluating File System Reliability on Solid State Drives
https://www.usenix.org/conference/atc19/presentation/jaffer

Maybe it provides some inspiration for future improvements.
The used error injection software (dm-inject) is on Github.

-h
