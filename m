Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76261409EAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 22:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245036AbhIMU5b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 16:57:31 -0400
Received: from mail.linuxsystems.it ([79.7.78.67]:48666 "EHLO
        mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244810AbhIMU5a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 16:57:30 -0400
Received: by mail.linuxsystems.it (Postfix, from userid 33)
        id 70F4A210393; Mon, 13 Sep 2021 22:40:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxsystems.it;
        s=linuxsystems.it; t=1631565624;
        bh=R+7MmH/15dGU2CnfvuSNcHIX+h0iEb8C/ioPqitzIAM=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
        b=mrDLU32qqlF+/HhKFpqNwPyc0nbAYniVpmMdVSMZhrCTu2MixCK2X9oZ7CeaubzoM
         PGQq65NVl4oiuInaZ1u4dHZXwKBpU+QHA5BIHg/dIRSGuAEXNNjGMyBfOK1Q8bqPFi
         l52Mi1620ieSgVAuZPAmW8IUT8Tr/QcBwfcucO8I=
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: Unmountable / uncheckable Fedora 34 btrfs: failed to read block  groups: -5 open_ctree failed
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 Sep 2021 22:40:24 +0200
From:   =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <20210913145049.GM29026@hungrycats.org>
References: <0303d1f618b815714fe62a6eb90f55ca@linuxsystems.it>
 <22ac9237-68dd-5bc3-71e1-6a4a32427852@gmx.com>
 <7163096f475d3c31d7513c22277ad00f@linuxsystems.it>
 <e71b92f4-43ba-1544-07c7-2dcc1dbf546c@gmx.com>
 <7294d85b7a0b3386be95fbe2d1ec6f9b@linuxsystems.it>
 <20210913145049.GM29026@hungrycats.org>
Message-ID: <7f736bc3b00f31f42b260d4694c3a6fe@linuxsystems.it>
X-Sender: darkbasic@linuxsystems.it
User-Agent: Roundcube Webmail/1.1.5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il 2021-09-13 16:50 Zygo Blaxell ha scritto:
> 1.  What is the device model and firmware revision of the SSD?  e.g.
> 
> 	smartctl -i /dev/nvme0n1 | grep -v 'Serial Number'

$ sudo smartctl -i /dev/nvme0n1 | grep -v 'Serial Number'
smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.13.15-200.fc34.x86_64] 
(local build)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, 
www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Number:                       Samsung SSD 970 EVO 250GB
Firmware Version:                   2B2QEXE7
PCI Vendor/Subsystem ID:            0x144d
IEEE OUI Identifier:                0x002538
Total NVM Capacity:                 250,059,350,016 [250 GB]
Unallocated NVM Capacity:           0
Controller ID:                      4
NVMe Version:                       1.3
Number of Namespaces:               1
Namespace 1 Size/Capacity:          250,059,350,016 [250 GB]
Namespace 1 Utilization:            171,265,327,104 [171 GB]
Namespace 1 Formatted LBA Size:     512
Namespace 1 IEEE EUI-64:            002538 5781b1927e
Local Time is:                      Mon Sep 13 22:51:00 2021 CEST

> 2.  What kernel was running at the time of the failure?  Was it 5.14,
> or an earlier kernel?

It was 5.13.14 or 5.13.15.
