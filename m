Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31877128901
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 13:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfLUMII (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 07:08:08 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48763 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfLUMIH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 07:08:07 -0500
X-Originating-IP: 88.191.131.7
Received: from [192.168.1.155] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DD1F7E0003;
        Sat, 21 Dec 2019 12:08:04 +0000 (UTC)
Subject: Re: Kernel 5.4 - BTRFS FS shows full with about 600 GB Free ?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>
References: <8bd55f28-2176-89f7-bd53-4992ccd53f42@petaramesh.org>
 <81dec38b-ec8e-382e-7dfe-cb331f418ffa@gmx.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Message-ID: <e7204e11-bb45-b7d2-7e98-af4d52c306a8@petaramesh.org>
Date:   Sat, 21 Dec 2019 13:07:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <81dec38b-ec8e-382e-7dfe-cb331f418ffa@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 21/12/2019 à 13:00, Qu Wenruo a écrit :
> A known regression introduced in v5.4.
>
> The new metadata over-commit behavior conflicts with an existing check
> in btrfs_statfs().
> It is completely a runtime false behavior, and had*no*  other bad effect.

Many thanks to you for the quick explanation.

I understand « no other bad effect » as « The FS will be OK again when 
this is fixed in the kernel, I can leave the disk in my drawer in the 
mean time » ?

Well I find that makes several recent problematic regressions in 
BTRFS... 5.2... 5.4...

I'm starting worrying about this development model.

Something as serious as an « Enterprise grade filesystem » that has been 
under heavy development for about ten years is not supposed to be a toy 
that breaks every now and then and couple patches is it ?

Or it would mean that it would ever stay a toy, not an enterprise-grade 
FS...

Kind regards.

