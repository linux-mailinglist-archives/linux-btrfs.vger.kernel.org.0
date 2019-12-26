Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0AE12AD45
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 16:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLZPmX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 10:42:23 -0500
Received: from naboo.endor.pl ([91.194.229.149]:44713 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfLZPmX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 10:42:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 812A71A10BA;
        Thu, 26 Dec 2019 16:42:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SrRonVPUvVks; Thu, 26 Dec 2019 16:42:21 +0100 (CET)
Received: from [192.168.1.16] (aaee101.neoplus.adsl.tpnet.pl [83.4.108.101])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id 4BC311A1025;
        Thu, 26 Dec 2019 16:42:21 +0100 (CET)
From:   Leszek Dubiel <leszek@dubiel.pl>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
 <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
 <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <5954540e-e7b0-e3c8-cbab-ad45f4467684@georgianit.com>
Message-ID: <adaa8713-64dc-3b3b-dad9-8b68370fcc72@dubiel.pl>
Date:   Thu, 26 Dec 2019 16:42:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5954540e-e7b0-e3c8-cbab-ad45f4467684@georgianit.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> Recovery of Raid0 with a faulty drive is a job for restore from backup,
> (or attempt to scrape what you can with array mounted ro).. That's what
> Raid0 *means*.
> I'm assuming that /dev/sda is the the drive you already identified as
> failing,, if not, you're totally hosed.


Yes -- /dev/sda is getting errors, it's failing. I didin't pass smart 
self-tests.
  Thank you for inspection of my logs.

I will try to pe patient until btrfs removes /dev/sda2 from array.

