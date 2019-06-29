Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042A75ACE0
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jun 2019 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfF2SuG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Jun 2019 14:50:06 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:14517 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbfF2SuG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Jun 2019 14:50:06 -0400
Received: from 6.3.0.0.0.0.e.f.f.f.2.6.e.1.2.0.0.f.5.c.f.a.e.e.4.3.e.0.1.0.a.2.ip6.arpa (unknown [78.234.252.95])
        by smtp1-g21.free.fr (Postfix) with ESMTP id A4665B0056B
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Jun 2019 20:50:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by 6.3.0.0.0.0.e.f.f.f.2.6.e.1.2.0.0.f.5.c.f.a.e.e.4.3.e.0.1.0.a.2.ip6.arpa (Postfix) with ESMTP id 535009D2F
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Jun 2019 18:50:04 +0000 (UTC)
Received: from 6.3.0.0.0.0.e.f.f.f.2.6.e.1.2.0.0.f.5.c.f.a.e.e.4.3.e.0.1.0.a.2.ip6.arpa ([127.0.0.1])
        by localhost (mail.couderc.eu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wZuRi3Yw-VfZ for <linux-btrfs@vger.kernel.org>;
        Sat, 29 Jun 2019 18:50:04 +0000 (UTC)
Received: from [192.168.163.11] (unknown [192.168.163.11])
        by 6.3.0.0.0.0.e.f.f.f.2.6.e.1.2.0.0.f.5.c.f.a.e.e.4.3.e.0.1.0.a.2.ip6.arpa (Postfix) with ESMTPSA id 917C49D2C
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Jun 2019 18:50:03 +0000 (UTC)
To:     linux-btrfs@vger.kernel.org
From:   Pierre Couderc <pierre@couderc.eu>
Subject: What are the maintenance recommendation ?
Message-ID: <f9ceb3c8-b557-16d6-3f21-f2de34dfae9c@couderc.eu>
Date:   Sat, 29 Jun 2019 20:50:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

1- Is there a summary of btrfs recommendations for maintenance ?

I have read somewhere that  a monthly  btrfs scrub is recommended. Is 
there somewhere a reference,  an "official" (or not...) guide of all  
that  is recommended ?

I am lost in the wiki...

2- Is there a repair guide ? I see all these commands restore, scrub, 
rescue. Is there a guide of what to do when a disk has some errors ? The 
man does not say when use some command...

Erros occurs fairly often on big disks...

Thanks

PC

